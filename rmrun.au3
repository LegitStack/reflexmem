#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <.\executeif.au3>
#include <.\executethen.au3>

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

EndFunc


Func PopulateGui()

  Local $hGUI = GUICreate("Reflex Memory Run", 600, 300)
  Local $idCheckbox[100]
  for $i = 0 to Ubound($triggers)-1
    $idCheckbox[$i] = GUICtrlCreateCheckbox("IF     " & $triggers[$i] & "     THEN     " & $behaviors[0][$i] & "     ...", 10, ($i+1)*25, 500, 25)
  next
  ;GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP)
  Local $idStart = GUICtrlCreateButton("Start", 420, 270, 85, 25)
  Local $idClose = GUICtrlCreateButton("Close", 510, 270, 85, 25)
  GUISetState(@SW_SHOW, $hGUI)

  local $trigs[Ubound($triggers)]
  local $msg
  local $pause = false

  ; Loop until the user exits.
  While 1
    ;check for changes from user.
    $msg = GUIGetMsg()
    Switch $msg
      Case $GUI_EVENT_CLOSE, $idClose
        ExitLoop
      Case $idStart
        ExitLoop
      Case Else
        For $i = 0 To ubound($idCheckbox) - 1
          If $msg == $idCheckbox[$i] Then
            If _IsChecked($idCheckbox[$i]) Then
              $trigs[$i] = 1
              ;MsgBox($MB_SYSTEMMODAL, $msg, "aThe checkbox is checked.", 0, $hGUI)
            Else
              $trigs[$i] = ""
              ;MsgBox($MB_SYSTEMMODAL, $msg, "aThe checkbox is not checked.", 0, $hGUI)
            EndIf
          Endif
        Next
    EndSwitch
  wend

  ;_arrayDisplay($trigs, "trigs")
  ; Loop until the user exits.
  While 1

    ;check for changes from user.
    $msg = GUIGetMsg()
    Switch $msg
      Case $GUI_EVENT_CLOSE, $idClose
        ExitLoop
      Case $idStart
        if $pause == true then
          $pause = true
        else
          $pause = false
        endif
      Case Else
        For $i = 0 To ubound($idCheckbox) - 1
          If $msg == $idCheckbox[$i] Then
            If _IsChecked($idCheckbox[$i]) Then
              $trigs[$i] = 1
              ;MsgBox($MB_SYSTEMMODAL, $msg, "The checkbox is checked.", 0, $hGUI)
            Else
              $trigs[$i] = ""
              ;MsgBox($MB_SYSTEMMODAL, $msg, "The checkbox is not checked.", 0, $hGUI)
            EndIf
          Endif
        Next ;

        ;_arrayDisplay($trigs, "trigs")
        ;_arrayDisplay($triggers, "triggers")
        ;check for triggers
        ;sleep(3000)
        if $pause == false then
          for $c = 0 to ubound($triggers)-1
            if $trigs[$c] == 1 then
              $tcounts[$c] = $tcounts[$c] + 1
              if Execute($triggers[$c]) then
                for $i = 0 to 100
                  if $behaviors[$i][$c] == ""  then
                    $i = 101
                  else
                    ;msgbox(64,"executing",$behaviors[$i][$c])     ;sleep(2000)
                    Execute($behaviors[$i][$c])
                  endif
                next
                $tcounts[$c] = 0
              endif
            endif
          next
        endif

    EndSwitch

  WEnd

  ; Delete the previous GUI and all controls.
  GUIDelete($hGUI)
EndFunc   ;==>Example

Func _IsChecked($idControlID)
  Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked
