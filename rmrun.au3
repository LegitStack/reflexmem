#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <Misc.au3>
#include <GuiListView.au3>
#include <FileConstants.au3>
#include <File.au3>
#include <lib\executeif.au3>
#include <lib\executethen.au3>
#include <lib\filelocations.au3>
#include <lib\alllcs.au3>
#include <lib\tesseract_stdout.au3>
#include <lib\combinealllcsandtesseract.au3>
#include <lib\levenshtein.au3>
#include <lib\dpiawareness.au3>
#include <Crypt.au3>
#include <lib\applieddpi.au3>

;DllCall("User32.dll", "bool", "SetProcessDPIAware")
;GUISetFont(8.5 * _GDIPlus_GraphicsGetDPIRatio()[0])

$R = GetScale()
$R = 1
VarifyFolders()

GetTriggers()
PopulateGui()

;Get a list of triggers and behaviors
Func GetTriggers()

  global $triggers[1]
  global $triggernames[1]
  global $behaviors[100][1]
  global $behaviornames[100][1]
  global $tcounts[1]


  local $i = 0
  While FileExists(GetScriptsPath("if") & $i & ".txt")
    ReDim $triggers[$i + 1]
    Redim $triggernames[$i + 1]
    ReDim $behaviors[100][$i + 1]
    ReDim $behaviornames[100][$i + 1]
    ReDim $tcounts[$i + 1]
    $triggers[$i] = ReadFileIf($i)
    $triggernames[$i] = ReadFileIfNames($i)
    $temp = ReadFileThen($i)
    $j = 0
    For $t In $temp
      $behaviors[$j][$i] = $t
      $j = $j + 1
    next
    $temp = ReadFileThenNames($i)
    $j = 0
    For $t In $temp
      if $t <> "" then
        $behaviornames[$j][$i] = $t
        $j = $j + 1
      endif
    next
    $i = $i + 1
  WEnd

;  global $hotkeys[100][Ubound($triggers)]
;  local $hotloc
;  local $endloc
;  local $middle
  ;_arrayDisplay($triggers)

;  for $i = 0 to Ubound($triggers)-1
;    while StringInStr($triggers[$i], "HotKeySet(", 1)
;      $hotloc = StringInStr($triggers[$i], "HotKeySet(", 1)
;      $endloc = StringInStr($triggers[$i], ")", 1,1,$hotloc+15)
;      $middle = StringMid($triggers[$i], $hotloc, $endloc-$hotloc+1)
;      $triggers[$i] = stringleft($triggers[$i], $hotloc-1) & stringright($triggers[$i], stringlen($triggers[$i])-$endloc)
;      for $j = 0 to 100
;        msgbox(64,$j, $i)
;        if $hotkeys[$j][$i] = "" then
;          $hotkeys[$j][$i] = $middle
;          $j = 100
;        endif
;        ;_arrayDisplay($hotkeys)
;      next
      ;MsgBox(64, $hotloc, $endloc)
      ;MsgBox(64, $middle, $trigger)
;      Execute($middle)
;    WEnd
;  next


EndFunc


Func HotKeyTrigger()
  ;$msg = GUIGetMsg()
  ;Switch $msg
  ;    Case -3
  ;        Exit
  ;    Case Else
  ;        For $i = 0 To $loop - 1
  ;            If $msg = $Guiarr[$i][0] Then _Enable ($Guiarr[$i][0],$Guiarr[$i][1])
  ;        Next
  ;EndSwitch
  ;  Switch @HotKeyPressed
  ;    Case "^!u"
  ;        SendUnicode("ü")
  ;    Case "^!o"
  ;        SendUnicode("ö")
  ;    Case "^!i"
  ;        SendUnicode("ï")
  ;  EndSwitch
  ;  Execute( the behavior that matches the trigger that contains the @hotkeypressed)


;  local $trigs[Ubound($triggers)]
;  For $i = 0 To ubound($idCheckbox) - 1
;    If $msg == $idCheckbox[$i] Then
;      If _IsChecked($idCheckbox[$i]) Then
;        $trigs[$i] = 1
;        ;MsgBox($MB_SYSTEMMODAL, $msg, "aThe checkbox is checked.", 0, $hGUI)
;      Else
;        $trigs[$i] = ""
;        ;MsgBox($MB_SYSTEMMODAL, $msg, "aThe checkbox is not checked.", 0, $hGUI)
;      EndIf
;    Endif
;  Next


  ;if $paused == false then
;    for $c = 0 to ubound($triggers)-1
;      if $trigs[$c] == 1 then
;        for $j = 0 to 100
;          if StringInStr($hotkeys[$j][$c], @HotKeyPressed) > 0 then
;            for $i = 0 to 100
;              if $behaviors[$i][$c] == ""  then
;                $i = 101
;              else
;                if $paused then
;                  if $behaviors[$i][$c] == "$paused = false" then
;                    Execute($behaviors[$i][$c])
;                  endif
;                else
;                  Execute($behaviors[$i][$c])
;                endif
;              endif
;;            next
  ;        endif
  ;      next
  ;    endif
  ;  next
  ;endif
EndFunc

Func PopulateGui()

  Global $hGUI = GUICreate("Reflex Memory Run", 610*$R, 660*$R)
  Local $idCheckbox[Ubound($triggers)]
  Local $idDelete[Ubound($triggers)]
  Local $idModify[Ubound($triggers)]
  ;Local $idPlugin[Ubound($triggers)]
    ; put this below idmodify for everyone.
    ; it would open up another screen with settings and code to modify or add to.
    ; then a button that encrypts it approapriately.
  Local $idBlist[Ubound($triggers)]
  Local $locCx[Ubound($triggers)]
  Local $locDx[Ubound($triggers)]
  Local $locEx[Ubound($triggers)]
  Local $locBx[Ubound($triggers)]

  ;_arrayDisplay($triggers)
  local $j = 0
  local $k = 0

  for $i = 0 to Ubound($triggers)-1
    if $triggers[$i] <> "" then
      if $triggernames[$i] <> "" then
        $name = $triggernames[$i]
      else
        $name = $triggers[$i]
      endif
      $idCheckbox[$i] = GUICtrlCreateCheckbox(" If " & $name & " then", (($j*300)+10)*$R, (($k*150)+10)*$R, 290*$R, 25*$R)
      $idBlist[$i] = GUICTRLCreateListView("Behaviors                             ", (($j*300)+10)*$R, (($k*150)+40)*$R, 180*$R, 100*$R)
      for $b = 0 to Ubound($behaviors, 1)-1
        if $behaviornames[$b][$i] <> "" then
          _GUICtrlListView_AddItem($idBlist[$i], $behaviornames[$b][$i], 1)
        endif
      next
      $idDelete[$i] = GUICtrlCreateButton("Delete", (($j*300)+200)*$R, (($k*150)+40)*$R, 100*$R, 27*$R)
      $idModify[$i] = GUICtrlCreateButton("Modify", (($j*300)+200)*$R, (($k*150)+72)*$R, 100*$R, 27*$R)
    endif
    $locCx[$i] = (($j*300)+10)*$R
    $locDx[$i] = (($j*300)+200)*$R
    $locEx[$i] = (($j*300)+200)*$R
    $locBx[$i] = (($j*300)+10)*$R

    $k = $k + 1
    if $k == 4 then
      $k = 0
      $j = $j+1
    endif
  next
  ;GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP)
  Local $idClose = GUICtrlCreateButton("Close", 10*$R, 610*$R, 60*$R, 40*$R) ;10, 610, 100, 40)
  Local $idCreatePlugin = GUICtrlCreateButton("Create Plugin", 80*$R, 610*$R, 80*$R, 40*$R)
  Local $idSlider1 = GUICtrlCreateSlider(170*$R, 620*$R, 320*$R, 30*$R) ;(120, 620, 370, 30)
  GUICtrlSetLimit(-1, 100, 0) ; change min/max value GUICtrlSetPos ( controlID, left [, top [, width [, height]]] )
  local $pLabel = GUICtrlCreateLabel("", 535*$R, 600*$R, 80*$R, 20*$R)
  GUICtrlSetFont($pLabel, 7, $FW_NORMAL,  $GUI_FONTITALIC)
  Local $idStart = GUICtrlCreateButton("Start", 500*$R, 610*$R, 100*$R, 40*$R)

  GUISetState(@SW_SHOW, $hGUI)

  local $trigs[Ubound($triggers)]
  local $msg
  Global $paused = False
  Local $X1 = 0
  local $Y1 = 0

  local $loop1 = 1
  local $loop2 = 1
  local $loop3 = 1

  local $blanksfound = true
  local $throwaway

  local $olduservar0
  local $olduservar1
  local $olduservar2
  local $olduservar3
  local $olduservar4
  local $olduservar5
  local $olduservar6
  local $olduservar7
  local $olduservar8
  local $olduservar9
  local $olduservar10
  local $olduservar11
  local $olduservar12
  local $olduservar13
  local $olduservar14
  local $olduservar15
  local $olduservar16
  local $olduservar17
  local $olduservar18
  local $olduservar19
  local $olduservar20
  local $olduservar21
  local $olduservar22
  local $olduservar23
  local $olduservar24
  local $olduservar25
  local $olduservar26
  local $olduservar27
  local $olduservar28
  local $olduservar29
  local $olduservar30
  local $olduservar31
  local $uservar0
  local $uservar1
  local $uservar2
  local $uservar3
  local $uservar4
  local $uservar5
  local $uservar6
  local $uservar7
  local $uservar8
  local $uservar9
  local $uservar10
  local $uservar11
  local $uservar12
  local $uservar13
  local $uservar14
  local $uservar15
  local $uservar16
  local $uservar17
  local $uservar18
  local $uservar19
  local $uservar20
  local $uservar21
  local $uservar22
  local $uservar23
  local $uservar24
  local $uservar25
  local $uservar26
  local $uservar27
  local $uservar28
  local $uservar29
  local $uservar30
  local $uservar31
  local $temp
  local $returned

  while $loop1 == 1
    While $loop2 == 1
      $msg = GUIGetMsg()
      Switch $msg
        Case $GUI_EVENT_CLOSE, $idClose
          $loop2 = 0
          $loop1 = 0
          Guidelete($hGUI)
          Exit
        Case $idStart
          SetUnPause($loop1, $loop2, $loop3, $idStart)
          for $i = 0 to ubound($triggers)-1
            GUICtrlSetState($idCheckbox[$i],$GUI_DISABLE)
            GUICtrlSetState($idDelete[$i],$GUI_DISABLE)
            GUICtrlSetState($idModify[$i],$GUI_DISABLE)
            GUICtrlSetState($idBlist[$i],$GUI_DISABLE)
          next
        Case $idCreatePlugin
          $codetemp = "proc 0" & @CRLF
          $codetemp = $codetemp & "while 1" & @CRLF
          for $c = 0 to ubound($trigs)-1
            $codetemp = $codetemp & "if " & $triggers[$c] & " then" & @CRLF
            for $i = 0 to 100
              if $behaviors[$i][$c] == ""  then
                $i = 101
              else
                $codetemp = $codetemp & $behaviors[$i][$c] & @CRLF
              endif
            next
            $codetemp = $codetemp & "endif" & @CRLF
          next
          $codetemp = $codetemp & "wend" & @CRLF
          $codetemp = $codetemp & "endp"
          ;msgbox(64,"code",$codetemp)
          $codetemp = _Crypt_EncryptData($codetemp, "a", $CALG_AES_256)
          ;msgbox(64,"code",$codetemp)
          If Not FileWrite(@DesktopDir & "\ProPlugin1.rmplugin", "") Then
            MsgBox($MB_SYSTEMMODAL, $name, "couldn't save plugin")
            Return False
          EndIf
          ;MsgBox($MB_SYSTEMMODAL, $name, "mde empty")
          FileWriteLine (@DesktopDir & "\ProPlugin1.rmplugin", "'" & $codetemp & "'")
          _Crypt_EncryptFile(@DesktopDir & "\ProPlugin1.rmplugin", @DesktopDir & "\ProPlugin.rmplugin", "thispasswordshouldcomefromourserversinordertobemoresecure", $CALG_AES_256)
          FileDelete(@DesktopDir & "\ProPlugin1.rmplugin")
          MsgBox($MB_SYSTEMMODAL, $name, "Plugin Saved to your Desktop as ProPlugin.rmplugin")
        Case Else
          ;if _IsPressed('2E') then
          ;  ;msgbox(64, "msg", $msg)
          ;  if $msg <> 0 then
          ;    ToolTip($msg)
          ;  endif
          ;endif
          For $i = 0 To ubound($idCheckbox) - 1
            If $msg == $idCheckbox[$i] Then
              If _IsChecked($idCheckbox[$i]) Then
                $trigs[$i] = 1
              Else
                $trigs[$i] = ""
              EndIf
            elseif $msg == $idModify[$i] then
                $temp = "rmcreate.exe " & $i
                run($temp)
                $loop2 = 0
                $loop1 = 0
                Guidelete($hGUI)
                Exit
            elseif $msg == $idDelete[$i] then

              FileDelete(GetScriptsPath("if") & $i & ".txt")
              FileDelete(GetScriptsPath("then") & $i & ".txt")
              FileDelete(GetScriptsPath("names") & $i & ".txt")
              GUICtrlDelete ( $idCheckbox[$i] )
              GUICtrlDelete ( $idDelete[$i] )
              GUICtrlDelete ( $idModify[$i] )
              GUICtrlDelete ( $idBlist[$i] )
              $trigs[$i] = ""

              for $j = 0 to ubound($idCheckbox)-2
                if $j >= $i then
                  $trigs[$j]          = $trigs[$j+1]
                  $idCheckbox[$j]     = $idCheckbox[$j+1]
                  $idDelete[$j]       = $idDelete[$j+1]
                  $idModify[$j]       = $idModify[$j+1]
                  $idBlist[$j]        = $idBlist[$j+1]
                  $triggers[$j]       = $triggers[$j+1]
                  $triggernames[$j]   = $triggernames[$j+1]
                  $tcounts[$j]        = $tcounts[$j+1]
                  $locCx[$j]          = $locCx[$j+1]
                  $locDx[$j]          = $locDx[$j+1]
                  $locBx[$j]          = $locBx[$j+1]
                  $locEx[$j]          = $locEx[$j+1]
                  for $k = 0 to Ubound($behaviors, 1)-1
                    $behaviors[$k][$j]  = $behaviors[$k][$j+1]
                    $behaviornames[$k][$j]  = $behaviornames[$k][$j+1]
                  next
                  if FileExists(GetScriptsPath("if") & $j+1 & ".txt") then
                    FileMove(GetScriptsPath("if") & $j+1 & ".txt", GetScriptsPath("if") & $j & ".txt", $FC_OVERWRITE)
                  endif
                  if FileExists(GetScriptsPath("then") & $j+1 & ".txt") then
                    FileMove(GetScriptsPath("then") & $j+1 & ".txt", GetScriptsPath("then") & $j & ".txt", $FC_OVERWRITE)
                  endif
                  if FileExists(GetScriptsPath("names") & $j+1 & ".txt") then
                    FileMove(GetScriptsPath("names") & $j+1 & ".txt", GetScriptsPath("names") & $j & ".txt", $FC_OVERWRITE)
                  endif
                  if $trigs[$j] <> "" then
                    $blanksFound = true
                  endif
                endif
              next
            else
              ;for $i = 0 to ubound($triggers)-1
                GUICtrlSetPos($idCheckbox[$i],$locCx[$i]-(GUICtrlRead($idSlider1)*50))
                GUICtrlSetPos($idBlist[$i],   $locBx[$i]-(GUICtrlRead($idSlider1)*50))
                GUICtrlSetPos($idDelete[$i],  $locDx[$i]-(GUICtrlRead($idSlider1)*50))
                GUICtrlSetPos($idModify[$i],  $locEx[$i]-(GUICtrlRead($idSlider1)*50))
              ;next
            Endif
          Next

      EndSwitch
    wend


    ; Loop until the user exits.
    While $loop3 == 1
      ;check for changes from user.
      $msg = GUIGetMsg()
      Switch $msg
        Case $GUI_EVENT_CLOSE, $idClose
          $loop3 = 0
          $loop1 = 0
          Guidelete($hGUI)
          Exit
        Case $idStart
          SetPause($loop1, $loop2, $loop3, $idStart)
          SetPLabel($pLabel, "")
          for $i = 0 to ubound($idCheckbox)-1
            GUICtrlSetState($idCheckbox[$i],$GUI_ENABLE)
            GUICtrlSetState($idDelete[$i],$GUI_ENABLE)
            GUICtrlSetState($idModify[$i],$GUI_ENABLE)
            GUICtrlSetState($idBlist[$i],$GUI_ENABLE)
          next
        Case Else
          For $i = 0 To ubound($idCheckbox) - 1
            If $msg == $idCheckbox[$i] Then
              If _IsChecked($idCheckbox[$i]) Then
                $trigs[$i] = 1
              Else
                $trigs[$i] = ""
              EndIf
            Endif
          Next

          for $c = 0 to ubound($triggers)-1
            if $trigs[$c] == 1 then
              $tcounts[$c] = $tcounts[$c] + 1

              if Execute($triggers[$c]) then
                for $i = 0 to 100
                  if $behaviors[$i][$c] == ""  then
                    $i = 101
                  else
                    ;msgbox(64, $paused, $behaviors[$i][$c])
                    if $paused == true then
                      SetPLabel($pLabel, "Paused!") ;technically redundant
                      if $behaviors[$i][$c] == "Assign('paused',False,2)" then
                        SetPLabel($pLabel, "")
                        Execute($behaviors[$i][$c])
                      endif
                    else
                      if $behaviors[$i][$c] == "Exit" then
                        Exit
                      else
                        Execute($behaviors[$i][$c])
                        ;msgbox(64, "returned troubleshooting", $returned)
                        if $paused == true then
                          SetPLabel($pLabel, "Paused!")
                        endif
                        if StringInStr($triggers[$c], "$olduservar") > 0 then
                          $temp = "Assign('olduservar" & stringmid($behaviors[$i][$c],11,2) & "',$uservar" & stringmid($behaviors[$i][$c],11,2) & ",1)"
                          execute($temp)
                        endif
                      endif
                    endif
                  endif
                next
                $tcounts[$c] = 0
              endif
            endif
          next

      EndSwitch

    WEnd
  WEnd

  ; Delete the previous GUI and all controls.
  GUIDelete($hGUI)
  Exit
EndFunc   ;==>Example

Func SetPLabel($pLabel, $data)
  if GUICtrlRead($pLabel) <> $data Then
    GUICtrlSetData($pLabel, $data)
  EndIf
EndFunc


Func SetUnPause(ByRef $loop1, ByRef $loop2, ByRef $loop3, ByRef $idStart)
  $loop1 = 1
  $loop2 = 0
  $loop3 = 1
  GUICtrlSetData ( $idStart, "Pause" )
EndFunc
Func SetPause(ByRef $loop1, ByRef $loop2, ByRef $loop3, ByRef $idStart)
  $loop1 = 1
  $loop2 = 1
  $loop3 = 0
  GUICtrlSetData ( $idStart, "Start" )
  $paused = False
EndFunc

;Func _IsChecked($idControlID)
;  Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
;EndFunc   ;==>_IsChecked


Func _ImageSearchArea($findImage,$resultPosition,$x1,$y1,$right,$bottom,ByRef $x, ByRef $y, $tolerance)
	;MsgBox(0,"asd","" & $x1 & " " & $y1 & " " & $right & " " & $bottom)
	if $tolerance>0 then $findImage = "*" & $tolerance & " " & $findImage

  ;method 1
  ;This works, when running from script, but not from exe.
	;$result = DllCall(".\lib\dll\ImageSearchDLL.dll", "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)

  ;method 2
  ;This works, when running from script, but not from exe.
  ;here I call it by a handle instead of by filepath or name
  $hDLL = DllOpen(_PathFull(@scriptdir & "\lib\dll\ImageSearchDLL.dll"))
    $result = DllCall($hDLL, "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)
  DllClose($hDLL)

  ; If error exit
    if $result[0]="0" then return 0

	; Otherwise get the x,y location of the match and the size of the image to
	; compute the centre of search
	$array = StringSplit($result[0],"|")

   $x=Int(Number($array[2]))
   $y=Int(Number($array[3]))
   if $resultPosition=1 then
      $x=$x + Int(Number($array[4])/2)
      $y=$y + Int(Number($array[5])/2)
   endif
   return 1
EndFunc


Func _ImageSearchAreaMouseMove($findImage,$resultPosition,$x1,$y1,$right,$bottom,ByRef $x, ByRef $y, $tolerance, $speed = 10)

	if $tolerance>0 then $findImage = "*" & $tolerance & " " & $findImage

  ;method 1
  ;This works, when running from script, but not from exe.
	;$result = DllCall(".\lib\dll\ImageSearchDLL.dll", "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)

  ;method 2
  ;This works, when running from script, but not from exe.
  ;here I call it by a handle instead of by filepath or name
  $hDLL = DllOpen(_PathFull(@scriptdir & "\lib\dll\ImageSearchDLL.dll"))
    $result = DllCall($hDLL, "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)
  DllClose($hDLL)

  ; If error exit
    if $result[0]="0" then return 0

	; Otherwise get the x,y location of the match and the size of the image to
	; compute the centre of search
	$array = StringSplit($result[0],"|")

   $x=Int(Number($array[2]))
   $y=Int(Number($array[3]))
   if $resultPosition=1 then
      $x=$x + Int(Number($array[4])/2)
      $y=$y + Int(Number($array[5])/2)
   endif
   mousemove($x,$y,$speed)
   return 1
EndFunc
