#RequireAdmin
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <.\executeif.au3>
#include <.\executethen.au3>
#include <Misc.au3>
#include <.\mkfolders.au3>

VarifyFolders()

GetTriggers()
PopulateGui()

;Get a list of triggers and behaviors
Func GetTriggers()

  global $triggers[1]
  global $behaviors[100][1]
  global $tcounts[1]

  local $i = 0
  While FileExists(_PathFull(@ScriptDir & "\scripts\if") & "\" & $i & ".txt")
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

  Global $hGUI = GUICreate("Reflex Memory Run", 600, 300)
  Local $idCheckbox[100]
  Local $idDelete[100]
  ;_arrayDisplay($triggers)
  for $i = 0 to Ubound($triggers)-1
    if $triggers[$i] <> "" then
      $idCheckbox[$i] = GUICtrlCreateCheckbox("IF     " & $triggers[$i] & "     THEN     " & $behaviors[0][$i] & "     ...", 10, ($i+1)*25, 500, 25)
      $idDelete[$i] = GUICtrlCreateButton("Delete", 520, ($i+1)*25, 60, 25)
    endif
  next
  ;GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP)
  Local $idStart = GUICtrlCreateButton("Start", 420, 270, 85, 25)
  Local $idClose = GUICtrlCreateButton("Close", 510, 270, 85, 25)
  GUISetState(@SW_SHOW, $hGUI)

  local $trigs[Ubound($triggers)]
  local $msg
  Global $paused = False
  Local $X1
  local $Y1

  local $loop1 = 1
  local $loop2 = 1
  local $loop3 = 1


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
          For $i = 0 To ubound($idCheckbox) - 1
            If $msg == $idCheckbox[$i] Then
              If _IsChecked($idCheckbox[$i]) Then
                $trigs[$i] = 1
              Else
                $trigs[$i] = ""
              EndIf
            elseif $msg == $idDelete[$i] then
              FileDelete(_PathFull(@ScriptDir & "\scripts\if\") & $i & ".txt")
              FileDelete(_PathFull(@ScriptDir & "\scripts\then\") & $i & ".txt")
              GUICtrlDelete ( $idCheckbox[$i] )
              GUICtrlDelete ( $idDelete[$i] )
              $trigs[$i] = ""
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
