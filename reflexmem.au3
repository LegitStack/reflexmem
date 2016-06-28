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

#include <GUIConstantsEx.au3>

ReflexGui()
Func ReflexGui()
  Local $hGUI = GUICreate("Reflex Memory Startup", 600, 300)
  Local $idCreate = GUICtrlCreateButton("Create", 30, 270, 85, 25)
  Local $idRun = GUICtrlCreateButton("Run", 120, 270, 85, 25)
  Local $idClose = GUICtrlCreateButton("Close", 210, 270, 85, 25)

  GUISetState(@SW_SHOW, $hGUI)

  ; Loop until the user exits.
  While 1
    Switch GUIGetMsg()
      Case $GUI_EVENT_CLOSE, $idClose
        ExitLoop
      Case $idRun
        run("rmrun.exe")
        ExitLoop
      Case $idCreate
        run("rmcreate.exe")
        ExitLoop
    EndSwitch
  wend
  GUIDelete($hGUI)
EndFunc
