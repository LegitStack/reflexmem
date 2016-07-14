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
  ; clunky. but basically func becomes proc args call becomes goto and local becomes set









Global $procs[256][256]
Global $v[65000]
Global $a[256][256]
Global $hotkey[100]
Global $hotproc[100]



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
  ;msgbox(64, "$read", $read)
  local $nread = Stringsplit($read, @CRLF, 2)
  if Stringleft($nread[0],1) == "'" then
    $nread = stringtrimleft($nread[0],1)
    $nread = stringtrimright($nread,1)
  Else
    $nread = $nread[0]
  endif
  $read = BinaryToString(_Crypt_DecryptData($nread, "a", $CALG_AES_256))
  ;msgbox(64, "$read", $read)
  $read = Stringsplit($read, @CRLF, 2)
  ;_arrayDisplay($read, "$read")
  AnalyzePlugin($read)
EndFunc


Func AnalyzePlugin($read)
  local $procnum = ""
  local $temp
  local $temp1
  local $ln = ""
  local $hki = 0

  for $r in $read
    $temp = Stringsplit($r, " ", 2)
    $temp1= stringleft($r, 4)
    if $temp1 == "proc" Or $temp1 == "Proc" then
      $procnum = $temp[1]
      $ln = 0
    ;elseif  stringleft($r, 4) == "args" Or stringleft($r, 4) == "Args" then
    elseif $temp1 == "endp" Or $temp1 == "Endp" then
      $procs[$procnum][$ln] = $r
      $procnum = ""
    elseif $temp1 == "hkps" Or $temp1 == "Hkps" then ;hot key pressed set
      $hotkey[$hki] = $temp[1]
      $hotproc[$hki] = $temp[2]
      $hki = $hki + 1
      HotKeySet($temp[1],"HotkeyPlugin")
    else ; regular code
      if $procnum <> "" then
        if $r <> "" then
          $procs[$procnum][$ln] = StringStripWS($r, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
          $ln = $ln + 1
        endif
      endif
    endif
  next
  ;_arrayDisplay($procs, "procs")
  ExecuteProc(0)
EndFunc


Func ExecuteProc($number, $arg1 = "", $arg2 = "")
  local $temp
  local $temp1
  local $return
  local $ift = ""
  local $embeddedif = 0
  ;_arraydisplay($procs)
  tooltip($number)
  for $pcount = 0 to 255
    $read = $procs[$number][$pcount]
    ;msgbox(64,"readsays "& $pcount,$read)
    $r = Stringsplit($read, " ", 2)
    if     (stringleft($read, 4) == "goto" Or stringleft($read, 4) == "Goto") And ($ift == "" Or stringright($ift, 1) == "t") then
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
    elseif (stringleft($read, 4) == "set " Or stringleft($read, 4) == "Set ") And ($ift == "" Or stringright($ift, 1) == "t") then
      if ubound($r) == 3 then
        if stringleft($r[2], 1) == "$" then
          $v[$r[1]] = execute($r[2])
        else
          $v[$r[1]] = $r[2]
        endif
      elseif ubound($r) > 3 then
        for $temp = 2 to ubound($r)-1
          $a[$r[1]][$temp-2] = $r[$temp]
        next
      endif
    elseif stringleft($read, 4) == "ift " Or stringleft($read, 4) == "Ift " then
      if $ift == "" Or stringright($ift, 1) == "t" then
        if execute(stringtrimleft($read, 4)) then
          $ift = $ift & "t"
          $embeddedif = $embeddedif + 1
        else
          $ift = $ift & "f"
        endif
      endif
    elseif stringleft($read, 4) == "elif" Or stringleft($read, 4) == "Elif" then
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
    elseif stringleft($read, 4) == "else" Or stringleft($read, 4) == "Else" then
      if $ift == "f" Or stringright($ift, 2) == "tf" then
        $ift = stringtrimright($ift, 1)
        $ift = $ift & "t"
        $embeddedif = $embeddedif + 1
      else
        $ift = stringtrimright($ift, 1)
        $ift = $ift & "f"
      endif
    elseif (stringleft($read, 4) == "endi" Or stringleft($read, 4) == "Endi") then
      if $ift == "" Or stringright($ift, 1) == "t" then
        $ift = stringtrimright($ift, 1)
        $embeddedif = $embeddedif - 1
      endif
    elseif (stringleft($read, 4) == "endp" Or stringleft($read, 4) == "Endp") And ($ift == "" Or stringright($ift, 1) == "t")then
      if Ubound($r) == 2 then
        if stringleft($r[1], 1) == "$" then
          $return = ExecuteProc(execute($r[1]))
        else
          $return = $r[1]
        endif
      else
        $return = ""
      endif
      exitloop
    elseif  ($read == "exit" Or $read == "Exit") And ($ift == "" Or stringright($ift, 1) == "t") then
      Exit
    else
      if  $ift == "" Or stringright($ift, 1) == "t" then
        Execute($read)
      endif
    endif
  next
  ;clear local variables because proc has ended
  return $return
EndFunc

;msgbox(64, "running", "")
ImportPlugin()

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
