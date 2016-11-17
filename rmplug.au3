;#NoTrayIcon
#include <Math.au3>
#include <File.au3>
#include <Misc.au3>
#include <Crypt.au3>
#include <Array.au3>
#include <FileConstants.au3>
#include <MsgboxConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <lib\filelocations.au3>
#include <lib\Array2.au3>
#include <lib\alllcs.au3>
#include <lib\sqlitequery.au3>
#include <lib\levenshtein.au3>
#include <lib\linedistance.au3>
#include <lib\tesseract_stdout.au3>
#include <lib\combinealllcsandtesseract.au3>
;#include <lib\tesseract.au3>
#Include <GDIPlus.au3>

Global $procs[256][256]
Global $loops[256][256]
Global $v[65000]
Global $a[256][256]
Global $hotkey[100]
Global $hotproc[100]
Global $b[256]
Global $c[256]
Global $d[256]
Global $e[256]

Func HotkeyPlugin()
  for $hki = 0 to ubound($hotkey)-1
    if @HotKeyPressed == $hotkey[$hki] then
      ExecuteProc($hotproc[$hki])
    endif
  next
EndFunc


Func ImportPlugin()
  local $path = GetScriptsPath("plugins") & "temporaryplugin.rmplug"
  local $file = FileOpen($path, $FO_READ)
  local $read = FileRead($file)
  FileClose($file)
  local $nread = Stringsplit($read, @CRLF, 2)
  if Stringleft($nread[0],1) == "'" then
    $nread = stringtrimleft($nread[0],1)
    $nread = stringtrimright($nread,1)
  Else
    $nread = $nread[0]
  endif
  $read = BinaryToString(_Crypt_DecryptData($nread, "a", $CALG_AES_256))
  $read = Stringsplit($read, @CRLF, 2)
  AnalyzePlugin($read)
EndFunc


Func AnalyzePlugin($read)
  local $procnum = 0
  local $loopnum = -1
  local $temp
  local $temp1
  local $ln = 0
  local $lnloop[256]
  local $embedded = -1
  local $hki = 0


  for $r in $read
    $temp = Stringsplit($r, " ", 2)
    $temp1= stringleft($r, 4)
    ;msgbox(64,"temp1",$temp1)
    if $temp1 == "proc" Or $temp1 == "Proc" then
      $procnum = $temp[1]
      $embedded = -1
      $ln = 0
    elseif $temp1 == "endp" Or $temp1 == "Endp" then
      ;msgbox(64,"r",$r)
      $procs[$procnum][$ln] = $r
      $procnum = ""
      $embedded = -1
    elseif $temp1 == "hkps" Or $temp1 == "Hkps" then ;hot key pressed set
      $hotkey[$hki] = $temp[1]
      $hotproc[$hki] = $temp[2]
      $hki = $hki + 1
      HotKeySet($temp[1],"HotkeyPlugin")
    elseif StringStripWS($r, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES) == "loop" Or StringStripWS($r, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES) == "Loop" then
      $oldloopnum = $loopnum
      $loopnum = $loopnum + 1
      $embedded = $embedded + 1
      $lnloop[$embedded] = 0
      if $embedded == 0 then
        $procs[$procnum][$ln] = "loop " & $loopnum
        $ln = $ln + 1
      else
        ;msgbox(64,"loop found," & $loopnum, $embedded & " " & $lnloop[$embedded])
        $loops[$oldloopnum][$lnloop[$embedded-1]] = "loop " & $loopnum
        $lnloop[$embedded-1] = $lnloop[$embedded-1] + 1
        ;_arraydisplay($loops)
      endif
    elseif StringStripWS($r, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES) == "endl" Or StringStripWS($r, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES) == "Endl" then
      $loops[$loopnum][$lnloop[$embedded]] = StringStripWS($r, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
      $embedded = $embedded - 1
      if $embedded > -1 then
        $loopnum = $loopnum - 1
      endif
    else ; regular code
      if $procnum <> "" then
        if $r <> "" then
          if $embedded == -1 then
            $procs[$procnum][$ln] = StringStripWS($r, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
            $ln = $ln + 1
          else
            $loops[$loopnum][$lnloop[$embedded]] = StringStripWS($r, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
            $lnloop[$embedded] = $lnloop[$embedded] + 1
          endif
        endif
      endif
    endif
  next
  ;_arraydisplay($procs)
  ;_arraydisplay($loops)

  ExecuteProc(0)
EndFunc


Func ExecuteProc($number, $arg1 = "", $arg2 = "")
  local $temp
  local $temp1
  local $return
  local $ift = ""
  local $embeddedif = 0
  local $command = ""

  for $pcount = 0 to 255
    ;put loops in the right places!
    $read = $procs[$number][$pcount]

    ;msgbox(64,"readsays "& $pcount,$read)
    $r = Stringsplit($read, " ", 2)
    $command = stringleft($read, 4)
    ExecuteCode($read, $r, $arg1, $arg2, $temp, $temp1, $return, $ift, $embeddedif, $command)
  next
  return $return
EndFunc



Func ExecuteLoop($number, Byref $arg1, Byref $arg2, Byref $temp, Byref $temp1, Byref $return, Byref $command)
  local $embeddedif = 0
  local $ift = ""
  ;_arraydisplay($procs)
  while 1
    For $pcount = 0 to 255
      ;put loops in the right places!
      $read = $loops[$number][$pcount]
      $r = Stringsplit($read, " ", 2)
      $command = stringleft($read, 4)
      msgbox(64,"readsays " & $pcount,$read & " " & $embeddedif & " " & $ift)
      $ret = ExecuteCode($read, $r, $arg1, $arg2, $temp, $temp1, $return, $ift, 0, $command)
      if $ret == 300 then
        $pcount = 300
      elseif $ret == "bklp" then
        exitloop 2
      endif
    next
  wend

EndFunc



Func ExecuteCode(Byref $read, Byref $r, Byref $arg1, Byref $arg2, Byref $temp, Byref $temp1, Byref $return, Byref $ift, Byref $embeddedif, Byref $command)

  if     ($command == "goto" Or $command == "Goto") And ($ift == "" Or stringright($ift, 1) == "t") then
    if Ubound($r) == 4 then
      if stringleft($r[2], 1) == "$" and stringleft($r[3], 1) == "$" then
        $return = ExecuteProc($r[1], execute($r[2]), execute($r[3]))
      elseif stringleft($r[2], 1) <> "$" and stringleft($r[3], 1) == "$" then
        $return = ExecuteProc($r[1], $r[2], execute($r[3]))
      elseif stringleft($r[2], 1) == "$" and stringleft($r[3], 1) <> "$" then
        $return = ExecuteProc($r[1], execute($r[2]), $r[3])
      else
        $return = ExecuteProc($r[1], $r[2], $r[3])
      endif
    elseif Ubound($r) == 3 then
      if stringleft($r[2], 1) == "$" then
        $return = ExecuteProc($r[1], execute($r[2]))
      else
        $return = ExecuteProc($r[1], $r[2])
      endif
    elseif Ubound($r) == 2 then
      $return = ExecuteProc($r[1])
    endif
  elseif ($command == "set " Or $command == "Set ") And ($ift == "" Or stringright($ift, 1) == "t") then
    if ubound($r) == 3 then
      if StringIsDigit(stringleft($r[2], 1)) == 0 and stringleft($r[2], 1) <> "'" and stringleft($r[2], 1) <> '"' then ;2 is code
        if StringIsDigit(stringleft($r[1], 1)) == 0 and stringleft($r[1], 1) <> "'" and stringleft($r[1], 1) <> '"' then ;1 is code
          $v[execute($r[1])] = execute($r[2])
        else ;1 is not code
          $v[$r[1]] = execute($r[2])
        endif
      else ;2 is not code
        if StringIsDigit(stringleft($r[1], 1)) == 0 and stringleft($r[1], 1) <> "'" and stringleft($r[1], 1) <> '"' then ;1 is code
          $v[execute($r[1])] = $r[2]
        else;1 is not code
          $v[$r[1]] = $r[2]
        endif
      endif
      ;oldway
      ;if stringleft($r[2], 1) == "$" And stringleft($r[1], 1) == "$" then
      ;  $v[execute($r[1])] = execute($r[2])
      ;elseif stringleft($r[2], 1) == "$" then
      ;  $v[$r[1]] = execute($r[2])
      ;elseif stringleft($r[1], 1) == "$" then
      ;  $v[execute($r[1])] = $r[2]
      ;else
      ;  $v[$r[1]] = $r[2]
      ;endif
    elseif ubound($r) > 3 then
      for $temp = 2 to ubound($r)-1
        $a[$r[1]][$temp-2] = $r[$temp]
      next
    endif
  elseif ($command == "setb " Or $command == "Setb ") And ($ift == "" Or stringright($ift, 1) == "t") then
    if ubound($r) == 3 then
      if stringleft($r[2], 1) == "$" And stringleft($r[1], 1) == "$" then
        $b[execute($r[1])] = execute($r[2])
      elseif stringleft($r[2], 1) == "$" then
        $b[$r[1]] = execute($r[2])
      elseif stringleft($r[1], 1) == "$" then
        $b[execute($r[1])] = $r[2]
      else
        $b[$r[1]] = $r[2]
      endif
    endif
  elseif ($command == "setc " Or $command == "Setc ") And ($ift == "" Or stringright($ift, 1) == "t") then
    if ubound($r) == 3 then
      if stringleft($r[2], 1) == "$" And stringleft($r[1], 1) == "$" then
        $c[execute($r[1])] = execute($r[2])
      elseif stringleft($r[2], 1) == "$" then
        $c[$r[1]] = execute($r[2])
      elseif stringleft($r[1], 1) == "$" then
        $c[execute($r[1])] = $r[2]
      else
        $c[$r[1]] = $r[2]
      endif
    endif
  elseif ($command == "setd " Or $command == "Setd ") And ($ift == "" Or stringright($ift, 1) == "t") then
    if ubound($r) == 3 then
      if stringleft($r[2], 1) == "$" And stringleft($r[1], 1) == "$" then
        $d[execute($r[1])] = execute($r[2])
      elseif stringleft($r[2], 1) == "$" then
        $d[$r[1]] = execute($r[2])
      elseif stringleft($r[1], 1) == "$" then
        $d[execute($r[1])] = $r[2]
      else
        $d[$r[1]] = $r[2]
      endif
    endif
  elseif ($command == "sete " Or $command == "Sete ") And ($ift == "" Or stringright($ift, 1) == "t") then
    if ubound($r) == 3 then
      if stringleft($r[2], 1) == "$" And stringleft($r[1], 1) == "$" then
        $e[execute($r[1])] = execute($r[2])
      elseif stringleft($r[2], 1) == "$" then
        $e[$r[1]] = execute($r[2])
      elseif stringleft($r[1], 1) == "$" then
        $e[execute($r[1])] = $r[2]
      else
        $e[$r[1]] = $r[2]
      endif
    endif
  elseif ($command == "loop" Or $command == "Loop") And ($ift == "" Or stringright($ift, 1) == "t") then
    ExecuteLoop($r[1], $arg1, $arg2, $temp, $temp1, $return, $command)
  elseif ($command == "endl" or $command == "Endl") And ($ift == "" Or stringright($ift, 1) == "t") then
    return 300
  elseif ($command == "bklp" or $command == "Bklp") And ($ift == "" Or stringright($ift, 1) == "t") then
    ;$ift = ""
    return "bklp"
  elseif $command == "ift " Or $command == "Ift " then
    if $ift == "" Or stringright($ift, 1) == "t" then
      if execute(stringtrimleft($read, 4)) then
        $ift = $ift & "t"
        $embeddedif = $embeddedif + 1
      else
        $ift = $ift & "f"
      endif
    endif
  elseif $command == "elif" Or $command == "Elif" then
    if $ift == "f" Or stringright($ift, 2) == "tf" then
      if execute(stringtrimleft($read, 4)) then
        $ift = stringtrimright($ift, 1)
        $ift = $ift & "t"
        $embeddedif = $embeddedif + 1
      else
        $ift = stringtrimright($ift, 1)
        $ift = $ift & "f"
      endif
    endif
  elseif $command == "else" Or $command == "Else" then
    if $ift == "f" Or stringright($ift, 2) == "tf" then
      $ift = stringtrimright($ift, 1)
      $ift = $ift & "t"
      $embeddedif = $embeddedif + 1
    else
      $ift = stringtrimright($ift, 1)
      $ift = $ift & "f"
    endif
  elseif ($command == "endi" Or $command == "Endi") then
    if $ift == "" Or stringright($ift, 1) == "t" then
      $ift = stringtrimright($ift, 1)
      $embeddedif = $embeddedif - 1
    elseif stringright($ift, 1) == "f" then
      $ift = stringtrimright($ift, 1)
      $embeddedif = $embeddedif - 1
    endif
  elseif ($command == "endp" Or $command == "Endp") And ($ift == "" Or stringright($ift, 1) == "t")then
    if Ubound($r) == 2 then
      if stringleft($r[1], 1) == "$" then
        $return = ExecuteProc(execute($r[1]))
      else
        $return = $r[1]
      endif
    else
      $return = ""
    endif
    $pcount =300
  elseif  ($read == "exit" Or $read == "Exit") And ($ift == "" Or stringright($ift, 1) == "t") then
    Exit
  else
    if  $ift == "" Or stringright($ift, 1) == "t" then
      Execute($read)
    endif
  endif

EndFunc





















ImportPlugin()














;METHOD 3 (special Raw Execute)
;at least 3 arrays:
  ;1. proc code, arguments of procs = 2d array p[]
  ;2. variables (public)  g[]
  ;3. variables (private) v[]

;this script loads the entire plugin.
;as it loads it it fills up the arrays.
;no returns, args
;everything is separated by spaces
;encoding of Functions:
  ;proc 0          - tells you which i to put it in.
    ;args 1 2     - array 1 1-99
    ;              - array 1 first,
  ;endp            - none
;encoding calling functions
  ;goto 2          - start loading each line from p[2] into execution
;encoding of variables:
  ;set 1 [code]       - v[1] = Execute($restofline)
  ;set 1 puts 2       - v[1] = v[2]
;we may use set as setv for arrays and let them use assign for regular variables
;so first we analyze it to separate it out,
;then the very last line of the code should be only number
;thats when we switch over to run mode
;and starting with the numbered proc we being to execute each line of code.

;limitations:
  ; we could make arrays of 1000 or something like a1-10
  ; no includes
  ; no loops, only recursion using procs
  ; no switches or anything else other than If statement.
  ; clunky. but basically func becomes proc args call becomes goto and local becomes set










;how to prepare plugins
  ;1. create a plugin script
  ;2. encrypt the data, replace code
  ;3. encryptfile, put in the plugins folder in scriptdir.

;plugin requirements:
  ;1. cannot have a function called "ImportPlugin"
  ;2. cannot have a function called "ExecutePlugin"
  ;3. cannot have a variable called "$__R__"
  ;4. cannot have a variable called "$__READ__"
  ;5. you must load everything into Memory before you being to execute.
  ;6. Your plugin cannot have more than 30k lines of code.
  ;7. cannot #include anything.
  ;8. cannot assign variables the normal way. you must use Assign("message", "world") (Assign, Call, Eval)
  ;9. convention suggests you use RMPlugin_ at the beginning of all function and variables in order to avoid duplicates because all the includes have to be
