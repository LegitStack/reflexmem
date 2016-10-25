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
;#RequireAdmin
#NoTrayIcon
#include <Crypt.au3>
#include <GUIConstantsEx.au3>
#include <lib\filelocations.au3>
#include <lib\applieddpi.au3>
#include <lib\upgrademessage.au3>
#include <Misc.au3>
;$R = GetScale()
$R = 1
ReflexGui()


Func ReflexGui()
  Local $hGUI = GUICreate("Reflex Memory Startup", 620*$R, 80*$R)
  Local $idCreate = GUICtrlCreateButton("Create", 20*$R, 20*$R, 130*$R, 40*$R)
  Local $idRun = GUICtrlCreateButton("Run", 170*$R, 20*$R, 130*$R, 40*$R)
  Local $idPlugin = GUICtrlCreateButton("Import Plugin", 320*$R, 20*$R, 130*$R, 40*$R)
  Local $idAbout = GUICtrlCreateButton("About", 470*$R, 20*$R, 130*$R, 40*$R)

  GUISetState(@SW_SHOW, $hGUI)
  GUICtrlSetState ($idPlugin,$GUI_DISABLE)
  Global $disabled_buttons[1] = [$idPlugin]

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
      Case $idPlugin
        MsgBox(64, "ReflexMem Pro", "You are running ReflexMem Pro which doesn't have the ability to import or run plugins. Please go to www.reflexmem.com and buy the Elite version of ReflexMem. In the meantime, thanks for using ReflexMem Pro!")
        ImportFileToInclude()
      Case $idAbout
        MsgBox(64, "About ReflexMem Pro 1.0", "ReflexMem is an attempt to create non-coding trigger-based automation on Windows. It was created by ReflexMem Industrries LLC and the Pro version is not free. If you have feedback about this product or find this software useful please contact us at reflexmem@gmail.com.")
      Case Else
      DemoClick($disabled_buttons)
   EndSwitch
  wend
  GUIDelete($hGUI)
EndFunc
