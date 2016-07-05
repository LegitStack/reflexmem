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
#RequireAdmin
#include <GUIConstantsEx.au3>
#include <.\mkfolders.au3>

ReflexGui()
Func ReflexGui()
  Local $hGUI = GUICreate("Reflex Memory Startup", 470, 80)
  Local $idCreate = GUICtrlCreateButton("Create", 20, 20, 130, 40)
  Local $idRun = GUICtrlCreateButton("Run", 170, 20, 130, 40)
  Local $idAbout = GUICtrlCreateButton("About", 320, 20, 130, 40)

  GUISetState(@SW_SHOW, $hGUI)

  ; Loop until the user exits.
  While 1
    Switch GUIGetMsg()
      Case $GUI_EVENT_CLOSE
        ExitLoop
      Case $idRun
        run("rmrun.exe")
        ExitLoop
      Case $idCreate
        run("rmcreate.exe")
        ExitLoop
      Case $idAbout
        MsgBox(64, "About ReflexMem", "ReflexMem is an attempt to create non-coding trigger-based automation on windows. It was created by Jordan Miller and is free to use. If you have feedback about this product or find this software useful please contact me at legitstack@gmail.com. Donations are welcome.")
        ExitLoop
    EndSwitch
  wend
  GUIDelete($hGUI)
EndFunc
