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

#include <GUIConstantsEx.au3>
#include <lib\filelocations.au3>


ReflexGui()


Func ReflexGui()
  Local $hGUI = GUICreate("Reflex Memory Startup", 620, 80)
  Local $idCreate = GUICtrlCreateButton("Create", 20, 20, 130, 40)
  Local $idRun = GUICtrlCreateButton("Run", 170, 20, 130, 40)
  Local $idPlugin = GUICtrlCreateButton("Import Plugin", 320, 20, 130, 40)
  Local $idAbout = GUICtrlCreateButton("About", 470, 20, 130, 40)

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
      Case $idPlugin
        MsgBox(64, "ReflexMem Lite", "You are running ReflexMem Lite which is free and doesn't have the ability to import or run plugins. Please go to www.reflexmem.com and buy the pro version of ReflexMem. In the meantime, thanks for using reflexmem lite!")
        ImportFileToInclude()
      Case $idAbout
        MsgBox(64, "About ReflexMem Lite 1.0", "ReflexMem is an attempt to create non-coding trigger-based automation on windows. It was created by ReflexMem Industrries LLC and is free to use. If you have feedback about this product or find this software useful please contact us at reflexmem@gmail.com.")
   EndSwitch
  wend
  GUIDelete($hGUI)
EndFunc


Func ImportFileToInclude()
  local $sFile = FileOpenDialog("Choose Image...", @scriptDir & "\plugins\", "ReflexMem Plugins (*.rmplugin)")
  if $sFile <> "" then
    FileCopy ($sFile, GetScriptsPath("plugins") & "temporaryplugin.au3", 1)
    FileCopy (@scriptDir & "\rmplugs.exe", GetScriptsPath("") & "rmplugs.exe", 0)
    DirCopy (@scriptDir & "\lib", GetScriptsPath("") & "lib", 0)
    FileCopy(@scriptDir & "\plugins\*.rmplib", GetScriptsPath("") & "lib\", $FC_OVERWRITE + $FC_CREATEPATH)
    ;FileMove(GetScriptsPath("") & "lib\*.rmplib", GetScriptsPath("") & "lib\*.au3", $FC_OVERWRITE + $FC_CREATEPATH) ;not technically needed. idk.
    MsgBox(0, "Importing...", "Please wait...", 2)
    Sleep(1000)
    Run(GetScriptsPath("") & "rmplugs.exe")
    Exit
  endif
EndFunc
