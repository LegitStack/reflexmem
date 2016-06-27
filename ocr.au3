#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         Jordan Miller

 Script Function:
	This uses the tesseract library

 Requirements
  (Tesseract 3.04 installed on the machine)
  tesseract must be the folder called lib which is in the same folder as ocr.au3
  a folder called image must be in the same folder as ocr.au3
  a folder called output must be in the same folder as ocr.au3

#ce ----------------------------------------------------------------------------

;calls lib/tesseract.au3

#include <lib\tesseract.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>

HotKeySet('`', 'SetHotKeys')
HotKeySet("{ESC}", "Terminate")

Func SetHotKeys()

  ;MsgBox($MB_SYSTEMMODAL, "SetHotKeys", "SetHotKeys")

  HotKeySet('1', 'Activate')
  HotKeySet('2', 'Define')
  HotKeySet('3', 'Submit')
  HotKeySet('4', 'Restart')

  HotKeySet('+z', 'Activate')
  HotKeySet('+x', 'Define')
  HotKeySet('+c', 'Submit')
  HotKeySet('+v', 'Restart')

  HotKeySet('`', 'UnSetHotKeys')

EndFunc

Func UnSetHotKeys()

  HotKeySet('1')
  HotKeySet('2')
  HotKeySet('3')
  HotKeySet('4')

  HotKeySet('+z')
  HotKeySet('+x')
  HotKeySet('+c')
  HotKeySet('+v')

  HotKeySet('`', 'SetHotKeys')

EndFunc


Global $ACTIVE = false
Global $CLICKI = 0
Global $CLICKS[100]


While 1
    Sleep(1)
WEnd

Func Terminate()
    Exit
EndFunc

Func Activate()
  $ACTIVE = true
  ClearCache()
EndFunc


Func Restart()
  ClearCache()
  Local $iPID = Run(_PathFull(@ScriptDir & "\runocr.exe"))
  Exit
EndFunc


Func Define()
  If $ACTIVE = false Then
    return $ACTIVE
  EndIf

  $Pos = MouseGetPos()

  ; 0 - top left corner of question
  If $CLICKI = 0 Then
    $CLICKS[0] = $Pos[0]
    $CLICKS[1] = $Pos[1]
  EndIf

  ; 1 - bottom right of question
  If $CLICKI = 1 Then
    $CLICKS[2] = $Pos[0]
    $CLICKS[3] = $Pos[1]
    SaveScreen($CLICKS[0],$CLICKS[1],$CLICKS[2],$CLICKS[3])
  EndIf

  ; 2 - bottom left corner of first answer
    ; get image of answer
  If $CLICKI >1 Then
    $CLICKS[$CLICKI*2] = $Pos[0]      ;4, 6, 8
    $CLICKS[($CLICKI*2)+1] = $Pos[1]  ;5, 7, 9
    SaveScreen($CLICKS[$CLICKI*2],$CLICKS[($CLICKI*2)-1],$CLICKS[2],$CLICKS[($CLICKI*2)+1] )
  EndIf

    $CLICKI = $CLICKI +1
EndFunc


Func Submit()
  If $ACTIVE = false Then
    return $ACTIVE
  EndIf

  If Not FileExists(_PathFull(@ScriptDir & "\image\*.png")) Then
    return FileExists(_PathFull(@ScriptDir & "\image\*.png")
  EndIf

  If Not FileExists(_PathFull(@ScriptDir & "\output\*.txt")) Then
    return FileExists(_PathFull(@ScriptDir & "\output\*.txt")
  EndIf

  ; submit to server and get an answer back. move mouse approapriately
    ; move to the correct image.
      ; Move to the front of the answer of you're sure, back If you're not.
    ; or move to the question If you don't know what the answer is.

  ;testing
  DetermineAnswer("dominated the trade routes")
  ;_PresentAnswer(1)

  ;ClearCache()
EndFunc


Func ClearCache()
  $CLICKI = 0
  Local $i = 0
  While $i < UBound($CLICKS)
    $CLICKS[$i] = ""
    $i = $i + 1
  WEnd
  DeleteCache()
EndFunc
