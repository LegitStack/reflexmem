#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <lib\executeif.au3>
#include <lib\executethen.au3>
#include <Misc.au3>
#include <lib\filelocations.au3>
#include <GuiListView.au3>
VarifyFolders()

GetTriggers()
PopulateGui()

;Get a list of triggers and behaviors
Func GetTriggers()

  global $triggers[1]
  global $behaviors[100][1]
  global $tcounts[1]

  local $i = 0
  While FileExists(GetScriptsPath("if") & $i & ".txt")
    ReDim $triggers[$i + 1]
    ReDim $behaviors[100][$i + 1]
    ReDim $tcounts[$i + 1]
    $triggers[$i] = ReadFileIf($i)
    $temp = ReadFileThen($i)
    $j = 0
    For $t In $temp
      $behaviors[$j][$i] = $t
      $j = $j + 1
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

  Global $hGUI = GUICreate("Reflex Memory Run", 610, 660)
  Local $idCheckbox[Ubound($triggers)]
  Local $idDelete[Ubound($triggers)]
  Local $idBlist[Ubound($triggers)]
  Local $locCx[Ubound($triggers)]
  Local $locDx[Ubound($triggers)]
  Local $locBx[Ubound($triggers)]

  ;_arrayDisplay($triggers)
  local $j = 0
  local $k = 0

  for $i = 0 to Ubound($triggers)-1
    if $triggers[$i] <> "" then
      $idCheckbox[$i] = GUICtrlCreateCheckbox($triggers[$i], ($j*300)+10, ($k*150)+10, 290, 25)
      $idBlist[$i] = GUICTRLCreateListView("Behaviors                             ", ($j*300)+10, ($k*150)+40, 180, 100)
      for $b = 0 to Ubound($behaviors, 1)-1
        if $behaviors[$b][$i] <> "" then
          _GUICtrlListView_AddItem($idBlist[$i], $behaviors[$b][$i], 1)
        endif
      next
      $idDelete[$i] = GUICtrlCreateButton("Delete", ($j*300)+200, ($k*150)+40, 100, 27)
    endif
    $locCx[$i] = ($j*300)+10
    $locDx[$i] = ($j*300)+200
    $locBx[$i] = ($j*300)+10

    $k = $k + 1
    if $k == 4 then
      $k = 0
      $j = $j+1
    endif
  next
  ;GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP)
  Local $idClose = GUICtrlCreateButton("Close", 10, 610, 100, 40)
  Local $idSlider1 = GUICtrlCreateSlider(120, 620, 370, 30)
  GUICtrlSetLimit(-1, 100, 0) ; change min/max value GUICtrlSetPos ( controlID, left [, top [, width [, height]]] )
  Local $idStart = GUICtrlCreateButton("Start", 500, 610, 100, 40)
  GUISetState(@SW_SHOW, $hGUI)

  local $trigs[Ubound($triggers)]
  local $msg
  Global $paused = False
  Local $X1
  local $Y1

  local $loop1 = 1
  local $loop2 = 1
  local $loop3 = 1

  local $blanksfound = true

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
            elseif $msg == $idDelete[$i] then
              FileDelete(GetScriptsPath("if") & $i & ".txt")
              FileDelete(GetScriptsPath("then") & $i & ".txt")
              GUICtrlDelete ( $idCheckbox[$i] )
              GUICtrlDelete ( $idDelete[$i] )
              GUICtrlDelete ( $idBlist[$i] )
              $trigs[$i] = ""

          		for $j = 0 to ubound($idCheckbox)-2
          			if $j >= $i then
          				$trigs[$j]          = $trigs[$j+1]
                  $idCheckbox[$j]     = $idCheckbox[$j+1]
                  $idDelete[$j]       = $idDelete[$j+1]
                  $idBlist[$j]        = $idBlist[$j+1]
                  $triggers[$j]       = $triggers[$j+1]
                  $tcounts[$j]        = $tcounts[$j+1]
                  for $k = 0 to Ubound($behaviors, 1)-1
                    $behaviors[$k][$j]  = $behaviors[$k][$j+1]
                  next
                  _arrayDisplay($trigs)
                  _arrayDisplay($triggers)
                  _arrayDisplay($behaviors)
                  if FileExists(GetScriptsPath("if") & $j+1 & ".txt") then
                    msgbox(64, $j, $j+1)
                    FileMove(GetScriptsPath("if") & $j+1 & ".txt", GetScriptsPath("if") & $j & ".txt", $FC_OVERWRITE)
                  endif
                  if FileExists(GetScriptsPath("then") & $j+1 & ".txt") then
                    FileMove(GetScriptsPath("then") & $j+1 & ".txt", GetScriptsPath("then") & $j & ".txt", $FC_OVERWRITE)
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
                    if $paused == true then
                      if $behaviors[$i][$c] == "$paused = false" then
                        Execute($behaviors[$i][$c])
                      endif
                    else
                      Execute($behaviors[$i][$c])
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

Func PauseIt()
  $paused = true
EndFunc

Func UnpauseIt()
  $paused = false
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
EndFunc

Func _IsChecked($idControlID)
  Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked


Func _ImageSearchArea($findImage,$resultPosition,$x1,$y1,$right,$bottom,ByRef $x, ByRef $y, $tolerance)
	;MsgBox(0,"asd","" & $x1 & " " & $y1 & " " & $right & " " & $bottom)
	if $tolerance>0 then $findImage = "*" & $tolerance & " " & $findImage
	$result = DllCall("ImageSearchDLL.dll","str","ImageSearch","int",$x1,"int",$y1,"int",$right,"int",$bottom,"str",$findImage)

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
