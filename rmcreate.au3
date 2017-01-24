#NoTrayIcon

#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <File.au3>
#include <Misc.au3>
#include <GuiListView.au3>
#include <GuiComboBox.au3>
#Include <ScreenCapture.au3>
#include <lib\filelocations.au3>
#include <lib\executeif.au3>
#include <lib\executethen.au3>
#include <lib\screencapturedpi.au3>
#include <lib\applieddpi.au3>
;#include <lib\dpiawareness.au3>
#include <lib\upgrademessage.au3>
#include <lib\choosebuttonhelper.au3>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;triggers - demo
#include <lib\trig\keypress_trigger>
;triggers - reg
#include <lib\trig\clipboard_trigger>
#include <lib\trig\dateto_trigger>
#include <lib\trig\do_trigger>
#include <lib\trig\imageonscreen_trigger>
#include <lib\trig\managetextonscreen_trigger>
#include <lib\trig\managevarequals_trigger>
#include <lib\trig\markrect_trigger>
#include <lib\trig\mouseat_trigger>
#include <lib\trig\mouseclick_trigger>
#include <lib\trig\programruns_trigger>
;behaviors - ONLY DEMO
;#include <lib\behave\managemousemove_behavior_demo>
;behaviors - demo
#include <lib\behave\mouseclick_behavior>
#include <lib\behave\messagebox_behavior>
#include <lib\behave\wait_behavior>
;behaviors - reg
#include <lib\behave\managemousemove_behavior>
#include <lib\behave\clipboard_behavior>
#include <lib\behave\keydown_behavior>
#include <lib\behave\keyup_behavior>
#include <lib\behave\manageprograms_behavior>
#include <lib\behave\managereflexmem_behavior>
#include <lib\behave\managevariable_behavior>
#include <lib\behave\volume_behavior>
#include <lib\behave\sendkeys_behavior>
#include <lib\behave\textonscreen_behavior>
#include <lib\behave\managekeypress_behavior>
#include <lib\behave\tooltip_behavior>
#include <lib\behave\managedisplay_behavior>
#include <lib\behave\userinteraction_behavior>
#include <lib\behave\manageaudio_behavior>
;DllCall("User32.dll", "bool", "SetProcessDPIAwareness")
;GUISetFont(8.5 * _GDIPlus_GraphicsGetDPIRatio()[0])

$R = GetScale()
;$R = 1

EraseExtraThen()
EraseExtraIf()

Global $hGUI = GUICreate("ReflexMem Create", 600*$R, 725*$R, -1, -1)
Global $triggerText = ""
Global $triggerTextNames = ""
Global $triggerNumber = 0
Global $behaviorText = ""
Global $triggerRecipeName = "Recipe "

global $mytriggers[100]
global $mybehaviors[100]

global $mytriggersnames[100]
global $mybehaviorsnames[100]

VarifyFolders()

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

LoadThenBypassIf()





;$CmdLine[0] ; Contains the total number of items in the array.
;$CmdLine[1] ; The first parameter.
;$CmdLine[2] ; The second parameter.

Func LoadThenBypassIf()
	if $CmdLine[0] == 1 then
		$triggerNumber = $CmdLine[1]
		CreateTriggers()
		HideTriggers()
		CreateBehaviors()
		HideBehaviors()
		ShowBehaviors(false)
		WaitForThenInput()
	else
		CreateTriggers()
		CreateBehaviors()
		HideBehaviors()
		WaitForIfInput()
	endif
EndFunc

Func LoadThenModify()
	local $temp, $j, $t, $i
	if $CmdLine[0] == 1 then
		$temp = ReadFileThen($triggerNumber)
		$j = 0
    For $t In $temp
      $mybehaviors[$j] = $t
			msgbox(64, "1", $t)
      $j = $j + 1
    next
		$temp = ReadFileThenNames($triggerNumber)
    $j = 0
    For $t In $temp
      if $t <> "" then
        $mybehaviorsnames[$j] = $t
				msgbox(64, "2", $t)
				_GUICtrlListView_AddItem($hlistbehavs, $t, 1)
        $j = $j + 1
      endif
    next
	endif
EndFunc


Func DeleteTriggers()
	GUICtrlDelete ( $hButton )
	GUICtrlDelete ( $hButton1 )
	GUICtrlDelete ( $hButton2 )
	GUICtrlDelete ( $hButton3 )
	GUICtrlDelete ( $hButton4 )
	GUICtrlDelete ( $hButton5 )
	GUICtrlDelete ( $hButton6 )
	GUICtrlDelete ( $hButton16 )
	GUICtrlDelete ( $hGroup )
	GUICtrlDelete ( $hLabel1 )

EndFunc

Func HideTriggers()
	GUICtrlSetState($hButton, $GUI_HIDE)
	GUICtrlSetState($hButton1, $GUI_HIDE)
	GUICtrlSetState($hButton2, $GUI_HIDE)
	GUICtrlSetState($hButton3, $GUI_HIDE)
	GUICtrlSetState($hButton4, $GUI_HIDE)
	GUICtrlSetState($hButton5, $GUI_HIDE)
	GUICtrlSetState($hButton6, $GUI_HIDE)
	GUICtrlSetState($hButton0, $GUI_HIDE)
	GUICtrlSetState($hButton16, $GUI_HIDE)
	GUICtrlSetState($hGroup, $GUI_HIDE)
	GUICtrlSetState($hLabel1, $GUI_HIDE)
	GUICtrlSetState($hlisttrigs, $GUI_HIDE)
	GUICtrlSetState($hButtonCancel1, $GUI_HIDE)
	GUICtrlSetState($hButtonUp1, $GUI_HIDE)
	GUICtrlSetState($hButtonDown1, $GUI_HIDE)
	GUICtrlSetState($hButtonDelete1, $GUI_HIDE)
	GUICtrlSetState($hButton22, $GUI_HIDE)
	GUICtrlSetState($hButton23, $GUI_HIDE)
	GUICtrlSetState($hButton24, $GUI_HIDE)
EndFunc

Func ShowTriggers()
	GUICtrlSetState($hButton, $GUI_SHOW)
	GUICtrlSetState($hButton1, $GUI_SHOW)
	GUICtrlSetState($hButton2, $GUI_SHOW)
	GUICtrlSetState($hButton3, $GUI_SHOW)
	GUICtrlSetState($hButton4, $GUI_SHOW)
	GUICtrlSetState($hButton5, $GUI_SHOW)
	GUICtrlSetState($hButton6, $GUI_SHOW)
	GUICtrlSetState($hButton0, $GUI_SHOW)
	GUICtrlSetState($hButton16, $GUI_SHOW)
	GUICtrlSetState($hGroup, $GUI_SHOW)
	GUICtrlSetState($hLabel1, $GUI_SHOW)
	GUICtrlSetState($hlisttrigs, $GUI_SHOW)
	GUICtrlSetState($hButtonCancel1, $GUI_SHOW)
	GUICtrlSetState($hButtonUp1, $GUI_SHOW)
	GUICtrlSetState($hButtonDown1, $GUI_SHOW)
	GUICtrlSetState($hButtonDelete1, $GUI_SHOW)
	GUICtrlSetState($hButton22, $GUI_SHOW)
	GUICtrlSetState($hButton23, $GUI_SHOW)
	GUICtrlSetState($hButton24, $GUI_SHOW)
EndFunc


Func HideBehaviors()
	GUICtrlSetState($hButton7, $GUI_HIDE)
	GUICtrlSetState($hButton8, $GUI_HIDE)
	GUICtrlSetState($hButton9, $GUI_HIDE)
	GUICtrlSetState($hButton10, $GUI_HIDE)
	GUICtrlSetState($hButton11, $GUI_HIDE)
	GUICtrlSetState($hButton12, $GUI_HIDE)
	GUICtrlSetState($hButton13, $GUI_HIDE)
	GUICtrlSetState($hButton14, $GUI_HIDE)
	GUICtrlSetState($hButton15, $GUI_HIDE)
	GUICtrlSetState($hButton18, $GUI_HIDE)
	GUICtrlSetState($hButton19, $GUI_HIDE)
	GUICtrlSetState($hButton20, $GUI_HIDE)
	GUICtrlSetState($hButton21, $GUI_HIDE)
	GUICtrlSetState($hButton17, $GUI_HIDE)
	GUICtrlSetState($hGroup1, $GUI_HIDE)
	GUICtrlSetState($hLabel, $GUI_HIDE)
	GUICtrlSetState($hlistbehavs, $GUI_HIDE)
	GUICtrlSetState($hButtonCancel2, $GUI_HIDE)
	GUICtrlSetState($hButtonUp2, $GUI_HIDE)
	GUICtrlSetState($hButtonDown2, $GUI_HIDE)
	GUICtrlSetState($hButtonDelete2, $GUI_HIDE)
EndFunc
Func ShowBehaviors($includeback = true)
	GUICtrlSetState($hButton7, $GUI_SHOW)
	GUICtrlSetState($hButton8, $GUI_SHOW)
	GUICtrlSetState($hButton9, $GUI_SHOW)
	GUICtrlSetState($hButton10, $GUI_SHOW)
	GUICtrlSetState($hButton11, $GUI_SHOW)
	GUICtrlSetState($hButton12, $GUI_SHOW)
	GUICtrlSetState($hButton13, $GUI_SHOW)
	GUICtrlSetState($hButton14, $GUI_SHOW)
	GUICtrlSetState($hButton15, $GUI_SHOW)
	GUICtrlSetState($hButton18, $GUI_SHOW)
	GUICtrlSetState($hButton19, $GUI_SHOW)
	GUICtrlSetState($hButton20, $GUI_SHOW)
	GUICtrlSetState($hButton21, $GUI_SHOW)
	GUICtrlSetState($hButton17, $GUI_SHOW)
	GUICtrlSetState($hGroup1, $GUI_SHOW)
	GUICtrlSetState($hLabel, $GUI_SHOW)
	GUICtrlSetState($hlistbehavs, $GUI_SHOW)
	if $includeback then
		GUICtrlSetState($hButtonCancel2, $GUI_SHOW)
		GUICtrlSetState($hButtonUp2, $GUI_SHOW)
		GUICtrlSetState($hButtonDown2, $GUI_SHOW)
	endif
	GUICtrlSetState($hButtonDelete2, $GUI_SHOW)
EndFunc




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




Func CreateTriggers()

	Global $hGroup   = GUICtrlCreateGroup("Triggers", 								20*$R, 	10*$R, 	280*$R, 540*$R)
	Global $hButton  = GUICtrlCreateButton("Key is Pressed", 					35*$R, 	35*$R, 	250*$R, 35*$R) ;done
	Global $hButton1 = GUICtrlCreateButton("Mouse is Clicked", 				35*$R, 	80*$R, 	250*$R, 35*$R) ;done
	Global $hButton22= GUICtrlCreateButton("Mouse in Region",   			35*$R, 	125*$R, 	250*$R, 35*$R) ;done
	Global $hButton2 = GUICtrlCreateButton("Clipboard Contains",			35*$R, 	170*$R, 	250*$R, 35*$R) ;done
	Global $hButton3 = GUICtrlCreateButton("Program is Running",			35*$R, 	215*$R, 	250*$R, 35*$R) ;done
	Global $hButton4 = GUICtrlCreateButton("Date and Time is", 				35*$R, 	260*$R, 	250*$R, 35*$R) ;done
	Global $hButton5 = GUICtrlCreateButton("Image on Screen", 				35*$R, 	305*$R, 	250*$R, 35*$R) ;done
	Global $hButton6 = GUICtrlCreateButton("Text on Screen", 					35*$R, 	350*$R, 	250*$R, 35*$R) ;done
	Global $hButton23= GUICtrlCreateButton("Manage Variable",					35*$R, 	395*$R, 	250*$R, 35*$R) ;done
	Global $hButton24= GUICtrlCreateButton("Do",											35*$R, 	440*$R, 	250*$R, 35*$R) ;done
	;Global $hButton24= GUICtrlCreateButton("Variable Equals *Pro",		35*$R, 	440*$R, 	250*$R, 35*$R) ;
	Global $hButton0 = GUICtrlCreateButton("Recipe Name",							35*$R, 	575*$R, 	250*$R, 35*$R) ;done
	Global $hButton16 = GUICtrlCreateButton("Submit Triggers", 				20*$R, 	655*$R, 	280*$R, 50*$R)
	GUICtrlSetFont(-1, 10)

	Global $hlisttrigs 			= GUICTRLCreateListView("Triggers                               ", 330*$R, 245*$R, 240*$R, 380*$R)
	Global $hButtonCancel1 	= GUICtrlCreateButton("Cancel", 330*$R, 655*$R, 80*$R, 50*$R)
	Global $hButtonUp1 			= GUICtrlCreateButton("↑", 			415*$R, 655*$R, 30*$R, 50*$R)
	Global $hButtonDown1 		= GUICtrlCreateButton("↓", 			450*$R, 655*$R, 30*$R, 50*$R)
	Global $hButtonDelete1 	= GUICtrlCreateButton("Delete", 485*$R, 655*$R, 80*$R, 50*$R)

	Global $hLabel1 = GUICtrlCreateLabel("", 330*$R, 35*$R, 240*$R, 200*$R)
	GUICtrlSetStyle(-1, $SS_CENTER)

	GUISetState()

EndFunc


Func CreateBehaviors()
	Global $hGroup1   = GUICtrlCreateGroup("Behaviors", 					310*$R, 	10*$R, 	280*$R, 615*$R)
	Global $hButton7  = GUICtrlCreateButton("Send Keys",					330*$R, 	35*$R, 	250*$R, 35*$R) ;done
	Global $hButton8  = GUICtrlCreateButton("Key Up / Down", 			330*$R, 	80*$R, 	250*$R, 35*$R) ;done
	Global $hButton13 = GUICtrlCreateButton("Copy / Paste", 			330*$R, 	125*$R, 	250*$R, 35*$R) ;done
	Global $hButton10 = GUICtrlCreateButton("Move Mouse", 				330*$R, 	170*$R, 	250*$R, 35*$R) ;done
	Global $hButton11 = GUICtrlCreateButton("Mouse Click", 				330*$R, 	215*$R, 	250*$R, 35*$R) ;done
	Global $hButton12 = GUICtrlCreateButton("Manage Audio",				330*$R, 	260*$R, 	250*$R, 35*$R) ;done
	Global $hButton9  = GUICtrlCreateButton("User Interaction",		330*$R, 	305*$R, 	250*$R, 35*$R) ;done
	Global $hButton18 = GUICtrlCreateButton("Display Message",		330*$R, 	350*$R, 	250*$R, 35*$R) ;done
	Global $hButton15 = GUICtrlCreateButton("Wait", 							330*$R, 	395*$R, 	250*$R, 35*$R) ;done
	Global $hButton21 = GUICtrlCreateButton("Get On Screen Text",	330*$R, 	440*$R, 	250*$R, 35*$R) ;done
	Global $hButton14 = GUICtrlCreateButton("Manage Programs",    330*$R, 	485*$R, 	250*$R, 35*$R) ;done
	Global $hButton20 = GUICtrlCreateButton("Manage Variables",		330*$R, 	530*$R, 	250*$R, 35*$R) ;done
	Global $hButton19 = GUICtrlCreateButton("Manage ReflexMem",		330*$R, 	575*$R, 	250*$R, 35*$R) ;??????
	Global $hButton17 = GUICtrlCreateButton("Submit Behaviors",		310*$R, 	655*$R, 	280*$R, 50*$R) ;done
	GUICtrlSetFont(-1, 10)

	Global $hlistbehavs 		= GUICTRLCreateListView("Behaviors                             ", 35*$R, 245*$R, 240*$R, 380*$R)
	Global $hButtonCancel2 	= GUICtrlCreateButton("Cancel", 35*$R, 655*$R, 80*$R, 50*$R)
	Global $hButtonUp2 			= GUICtrlCreateButton("↑", 			120*$R, 655*$R, 30*$R, 50*$R)
	Global $hButtonDown2 		= GUICtrlCreateButton("↓", 			155*$R, 655*$R, 30*$R, 50*$R)
	Global $hButtonDelete2 	= GUICtrlCreateButton("Delete", 190*$R, 655*$R, 85*$R, 50*$R)

	Global $hLabel = GUICtrlCreateLabel("", 35*$R, 35*$R, 240*$R, 200*$R)
	GUICtrlSetStyle(-1, $SS_CENTER)

	GUISetState()

	LoadThenModify()

EndFunc




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





Func SetLabel()
    Local $a = GUIGetCursorInfo()

	if UBound($a) > 4 then
		if $a[4] == $hButton7 Then
			$data = "Send keystrokes as if they came from the keyboard." & @CRLF & @CRLF & "Which Keys?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton8 Then
			$data = "Press a key as if holding it down on the keyboard. (Be sure to Key Up later.)" & @CRLF & @CRLF & "Which key?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton9 Then
			$data = "Ask the user to input data or answer a yes / no question. Save that result to the clipboard, in a variable, or in a file." & @CRLF & @CRLF & "What question?" & @CRLF & @CRLF & "Where should we save the answer?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton10 Then
			$data = "Move the mouse to a particular location on the screen." & @CRLF & @CRLF & "What X coordinate?" & @CRLF & @CRLF & "What Y coordinate?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton11 Then
			$data = "Click a button on the mouse." & @CRLF & @CRLF & "Which Button?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton12 Then
			$data = "Scroll the mouse wheel." & @CRLF & @CRLF & "Up or down?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton13 Then
			$data = "Put data on the clipboard or retrieve data from clipboard." & @CRLF & @CRLF & "What text?" & @CRLF & @CRLF & "What method?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton14 Then
			$data = "Run a program or end a process." & @CRLF & @CRLF & "Which program?" & @CRLF & @CRLF & "How should it appear?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton15 Then
			$data = "Do nothing for a certain period of time in miliseconds (1000 = 1 second)." & @CRLF & @CRLF & "how many miliseconds?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton18 Then
			$data = "Display Informational Message Box with OK button, or display a ToolTip at a certain location." & @CRLF & @CRLF & "What message?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton19 Then
				$data = "Tell ReflexMem to temporarilly ignore anything it might see as a trigger so that it does no behaviors or to stop ignoring triggers and start reacting to them again. Managing ReflexMem one can have two keys that can turn triggers off and on dymanically."
				if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton20 Then
				$data = "Save data to variables. Mainly used for making counters or preserving data on the clipboard without saving it to a file."
				if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton21 Then
				$data = "Reads Text that is displayed on the screen and copies it to the clipboard." & @CRLF & @CRLF & "Choose as small an area as possible to read text from."& @CRLF & @CRLF & "This can take sometime."
				if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		Else
			;GUICtrlSetData($g_idX, $a[0])
			;GUICtrlSetData($g_idY, $a[1])
		endIf
	EndIf
EndFunc



Func SetLabel1()
    Local $a = GUIGetCursorInfo()

	if UBound($a) > 4 then
		if $a[4] == $hButton Then
			$data = "When you Press a specific key or set of keys on the keyboard." & @CRLF & @CRLF & "Which Key?" & @CRLF & @CRLF & "Include Shift?" & @CRLF & @CRLF & "Include Control?" & @CRLF & @CRLF & "Include Alt?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton1 Then
			$data = "When a button on the mouse is clicked." & @CRLF & @CRLF & "Which Button?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton22 Then
			$data = "When the mouse cursor enters a region of the screen. Usually used in conjunction with the Mouse Click Trigger resulting in a trigger for when the mouse is clicked in a certain region of the screen." & @CRLF & @CRLF & "What protion of the screen?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton2 Then
			$data = "When the clipboard contains certain data." & @CRLF & @CRLF & "What Text?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton3 Then
			$data = "When a program is running." & @CRLF & @CRLF & "Which Program?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton4 Then
			$data = "At a certain date and time. Only specify this once per set of triggers because all triggers must be satisfied to execute behaviors and no two different times are satisfied at the same time." & @CRLF & @CRLF & "What Time?" & @CRLF & @CRLF & "Everyday? On one day of the week? Or on a specific date?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton5 Then
			$data = "When an image is found on the screen. The smaller the image the easier it is to find on the screen." & @CRLF & @CRLF & "Which Image?" & @CRLF & @CRLF & "What portion of the screen?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton6 Then
			$data = "When certain text is found on the screen. This trigger isn't exact and it works much better with smaller areas of the screen and shorter texts. This trigger is very expensive in terms of time, so if the text it is to look for will always look the exact same using the Image on Screen Trigger may be a better choice." & @CRLF & @CRLF & "What Text?" & @CRLF & @CRLF & "What portion of the screen?" & @CRLF & @CRLF & "How much do you want it to match the given text?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton0 Then
			$data = "Two things to keep in mind: Triggers are additive and behaviors are carried out in the order that they are created." & @CRLF & @CRLF & "All triggers must be satisfied in order for the behavior to be carried out." & @CRLF & @CRLF & "You can make upto 100 triggers and 100 behaviors."
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton23 Then
			$data = "When a variable is modified in anyway. Variable triggers allows data or information to be saved in a variable to be used later or by an entirely different trigger-behavior pair." & @CRLF & @CRLF & "Which variable?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton24 Then
			$data = "No Trigger needed, behaviors immediately executes when this recipe is active and stay active. When using the 'Do' Trigger it is adviced that you include the 'Exit ReflexMem' behavior."
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		Else
			;GUICtrlSetData($g_idX, $a[0])
			;GUICtrlSetData($g_idY, $a[1])
		endIf
	EndIf
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; name trigger
Func DetermineRecipeTrigger()
	Local $sAnswer = InputBox("Name This Recipe", "What name would you like give to this recipe?", "Do This When That", "")
	if $sAnswer <> "" then
		$triggerRecipeName = $sAnswer
	else
		return
	endif
EndFunc


Func SwapUpTrigger()
	local $index = _GUICtrlListView_GetSelectedIndices($hlisttrigs)
	if $index == "" then
		msgbox(64, "Move Up Button", "You must first select a trigger to move up.")
		return
	endif
	If $index < 1 Then Return
	; Swap array elements
	_ArraySwap($mytriggers, $index, $index - 1)
	_ArraySwap($mytriggersnames, $index, $index - 1)
	; Rewrite list items
	_GUICtrlListView_DeleteAllItems($hlisttrigs)
	For $i = 0 To ubound($mytriggersnames)-1
		if $mytriggersnames[$i] <> "" then
			_GUICtrlListView_AddItem($hlisttrigs, $mytriggersnames[$i])
		endif
	Next
	; Unselect all items to force selection before next action
	_GUICtrlListView_SetItemSelected($hlisttrigs, $index-1, True, True)
EndFunc


Func SwapDownTrigger()
	local $index = _GUICtrlListView_GetSelectedIndices($hlisttrigs)
	if $index == "" then
		msgbox(64, "Move Down Button", "You must first select a trigger to move down.")
		return
	endif
	If $mytriggersnames[$index + 1] == "" Then Return
	; Swap array elements
	_ArraySwap($mytriggers, $index, $index + 1)
	_ArraySwap($mytriggersnames, $index, $index + 1)
	; Rewrite list items
	_GUICtrlListView_DeleteAllItems($hlisttrigs)
	For $i = 0 To ubound($mytriggersnames)-1
		if $mytriggersnames[$i] <> "" then
			_GUICtrlListView_AddItem($hlisttrigs, $mytriggersnames[$i])
		endif
	Next
	; Unselect all items to force selection before next action
	_GUICtrlListView_SetItemSelected($hlisttrigs, $index+1, True, True)
EndFunc


Func DeleteThisTrigger()
	local $index = _GUICtrlListView_GetSelectedIndices($hlisttrigs)
	if $index == "" then
		msgbox(64, "Delete Button", "You must select a trigger to delete first.")
		return
	endif
	_GUICtrlListView_DeleteItemsSelected($hlisttrigs)
	$mytriggers[$index] = ""
	local $blanksfound = true
	while $blanksfound == true
		$blanksfound = false
		for $i = 0 to ubound($mytriggers)-2
			if $mytriggers[$i] == "" then
				$mytriggers[$i] = $mytriggers[$i+1]
				$mytriggers[$i+1] = ""
				if $mytriggers[$i] <> "" then
					$blanksFound = true
				endif
				$mytriggersnames[$i] = $mytriggersnames[$i+1]
				$mytriggersnames[$i+1] = ""
			endif
		next
	WEnd
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




Func DeleteThisBehavior()
	local $index = _GUICtrlListView_GetSelectedIndices($hlistbehavs)
	if $index == "" then
		msgbox(64, "Delete Button", "You must select a trigger to delete first.")
		return
	endif
	_GUICtrlListView_DeleteItemsSelected($hlistbehavs)
	$mybehaviors[$index] = ""
	local $blanksfound = true
	while $blanksfound == true
		$blanksfound = false
		for $i = 0 to ubound($mybehaviors)-2
			if $mybehaviors[$i] == "" then
				$mybehaviors[$i] = $mybehaviors[$i+1]
				$mybehaviors[$i+1] = ""
				if $mybehaviors[$i] <> "" then
					$blanksFound = true
				endif
			endif
		next
	WEnd
EndFunc


Func SwapUpBehavior()
	local $index = _GUICtrlListView_GetSelectedIndices($hlistbehavs)
	if $index == "" then
		msgbox(64, "Move Up Button", "You must first select a behavior to move up.")
		return
	endif
	If $index < 1 Then Return
	; Swap array elements
	_ArraySwap($mybehaviors, $index, $index - 1)
	; Rewrite list items
	_GUICtrlListView_DeleteAllItems($hlistbehavs)
	For $i = 0 To ubound($mybehaviors)-1
	  ;GUICtrlSetData($hlistbehavs, $mybehaviorsnames[$i])
		if $mybehaviors[$i] <> "" then
			_GUICtrlListView_AddItem($hlistbehavs, $mybehaviors[$i])
		endif
	Next
	; Unselect all items to force selection before next action
	_GUICtrlListView_SetItemSelected($hlistbehavs, $index-1, True, True)
EndFunc


Func SwapDownBehavior()
	local $index = _GUICtrlListView_GetSelectedIndices($hlistbehavs)
	if $index == "" then
		msgbox(64, "Move Down Button", "You must first select a behavior to move down.")
		return
	endif
	If $mybehaviors[$index + 1] == "" Then Return
	; Swap array elements
	_ArraySwap($mybehaviors, $index, $index + 1)
	; Rewrite list items
	_GUICtrlListView_DeleteAllItems($hlistbehavs)
	For $i = 0 To ubound($mybehaviors)-1
	  ;GUICtrlSetData($hlistbehavs, $mybehaviorsnames[$i])
		if $mybehaviors[$i] <> "" then
			_GUICtrlListView_AddItem($hlistbehavs, $mybehaviors[$i])
		endif
	Next
	; Unselect all items to force selection before next action
	_GUICtrlListView_SetItemSelected($hlistbehavs, $index+1, True, True)
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func AddToTrigger($data, $name)
	_GUICtrlListView_AddItem($hlisttrigs, $name, 1)
	local $i = 0
	for $i = 0 to 99
		if $mytriggers[$i] == "" then
			$mytriggers[$i] =	$data
			$mytriggersnames[$i] =	$name
			$i = 100
		endIf
	next
EndFunc


Func AddToTrigger2($data)
	if $triggerText == "" then
		$triggerText = $data
	else
		$triggerText = $triggerText & " And " & $data
	endif
;	msgbox(64,"trigger text", $triggerText)
EndFunc


Func AddToTriggerName($name)
	if $triggerTextNames == "" then
		$triggerTextNames = $name
	else
		$triggerTextNames = $triggerTextNames & " And " & $name
	endif
;	msgbox(64,"trigger text", $triggerText)
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Specific Behaviors




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



Func AddToBehavior($data)
	_GUICtrlListView_AddItem($hlistbehavs, $data)
	local $i = 0
	for $i = 0 to 99
		if $mybehaviors[$i] == "" then
			$mybehaviors[$i] =	$data
			$i = 100
		endIf
	next
EndFunc

Func AddToBehavior2($data)
	if $behaviorText == "" then
		$behaviorText = $data
	else
		$behaviorText = $behaviorText & @CRLF & $data
	endif
;	msgbox(64,"Behavior text", $behaviorText)
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func SaveTrigger()
	local $i = 0

	for $i = 0 to 99
		if $mytriggers[$i] <> "" then
			AddToTrigger2($mytriggers[$i])
			AddToTriggerName($mytriggersnames[$i])
		endIf
	next
	if $triggerText == "" then
		MsgBox($MB_SYSTEMMODAL, "Info","You must create at least one trigger to save successfully.")
		return
	endif

	;get trigger file number, save as global
	$i = 0
	While FileExists(GetScriptsPath("if") & $i & ".txt")
		$i = $i + 1
	WEnd
	$triggerNumber = $i

	if $triggerRecipeName = "Recipe " Then
		$triggerRecipeName = $triggerRecipeName & $triggerNumber & "                            "
	endif

	;save trigger text in if/filenumber.txt
  local $file = GetScriptsPath("if") & $triggerNumber & ".txt"
	local $filename = GetScriptsPath("names") & $triggerNumber & ".txt"
	local $recipefile = GetScriptsPath("recipe") & $triggerNumber & ".txt"
	Local $hFileOpen1 = FileOpen($file, $FO_CREATEPATH + $FO_OVERWRITE)
	Local $hFileOpen2 = FileOpen($filename, $FO_CREATEPATH + $FO_OVERWRITE)
	Local $hFileOpen3 = FileOpen($recipefile, $FO_CREATEPATH + $FO_OVERWRITE)

		FileWrite($filename, $triggerTextNames)
		FileWrite($recipefile, $triggerRecipeName)
	  If Not FileWrite($file, $triggerText) Then
	    MsgBox($MB_SYSTEMMODAL, $triggerNumber, "couldn't write trigger")
	    Return False
		else
			GUICtrlSetState($hButton16, $GUI_HIDE)
			sleep(1000)
			msgbox(64, "Trigger", "Successfully Saved")
		EndIf

  FileClose($hFileOpen1)
	FileClose($hFileOpen2)
	FileClose($hFileOpen3)
EndFunc

Func SaveBehavior()
	local $i = 0

	for $i = 0 to 99
		if $mybehaviors[$i] <> "" And $mybehaviors[$i] <> "-" then
			AddToBehavior2($mybehaviors[$i])
		endIf
	next

	if $behaviorText == "" then
		MsgBox($MB_SYSTEMMODAL, "Info","You must create at least one behavior to save successfully.")
		return
	endif

	local $file = GetScriptsPath("then") & $triggerNumber & ".txt"

	Local $hFileOpen1 = FileOpen($file, $FO_CREATEPATH + $FO_OVERWRITE)

		If Not FileWrite($file, $behaviorText) Then
			MsgBox($MB_SYSTEMMODAL, $triggerNumber, "couldn't write behavior")
			Return False
		else
			GUICtrlSetState($hButton17, $GUI_HIDE)
			sleep(1000)
			msgbox(64, "Behavior", "Successfully Saved")
		EndIf

	FileClose($hFileOpen1)
	ReturnToMain()
EndFunc



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




Func WaitForIfInput()

	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hGUI)
				ReturnToMain()
			Case $hButton0
				DetermineRecipeTrigger()
			Case $hButton
				KeyPressedTrigger()
			Case $hButton1
				MouseClickTrigger()
			Case $hButton2
				ClipboardTrigger()
			Case $hButton3
				ProgramRunsTrigger()
			Case $hButton4
				DateToTrigger()
			Case $hButton5
				ImageOnScreenTrigger()
			Case $hButton6
				ManageTextOnScreenTrigger()
			Case $hButton22
				MouseAtTrigger()
			Case $hButton23
				ManageVarEqualsTrigger()
			Case $hButton24
				;VariableEqualsTrigger()
				DoTrigger()
			Case $hButtonUp1
				SwapUpTrigger()
			Case $hButtonDown1
				SwapDownTrigger()
			Case $hButtonDelete1
				DeleteThisTrigger()
			Case $hButton16
				SaveTrigger()
				HideTriggers()
				ShowBehaviors()
				ExitLoop
			Case $hButtonCancel1
				EraseExtraThen()
				EraseExtraIf()
				GUIDelete($hGUI)
				ReturnToMain()
			case Else
				SetLabel1()
		EndSwitch
	WEnd
	WaitForThenInput()
EndFunc

Func WaitForThenInput()
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hGUI)
				ReturnToMain()
			Case $hButton7
				SendKeysBehavior()
			Case $hButton8
				ManageKeyPressBehavior()
			Case $hButton9
				UserInteractionBehavior()
			Case $hButton10
				ManageMouseMoveBehavior()
			Case $hButton11
				MouseClickBehavior()
			Case $hButton12
				ManageAudioBehavior()
			Case $hButton13
				ClipboardBehavior()
			Case $hButton14
				ManageProgramsBehavior()
			Case $hButton18
				ManageDisplayBehavior()
			Case $hButton15
				WaitBehavior()
			Case $hButton19
				ManageReflexMemBehavior()
			Case $hButton20
				ManageVariableBehavior()
			Case $hButton21
				TextOnScreenBehavior()
			Case $hButtonDelete2
				DeleteThisBehavior()
			Case $hButtonUp2
				SwapUpBehavior()
			Case $hButtonDown2
				SwapDownBehavior()
			Case $hButton17
				SaveBehavior()
				ExitLoop
			Case $hButtonCancel2
				EraseExtraThen()
				EraseExtraIf()
				HideBehaviors()
				ShowTriggers()
				WaitForIfInput()
			case Else
				SetLabel()
		EndSwitch
	WEnd

	ReturnToMain()

EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




Func ReturnToMain()
	if FileExists("reflexmem-pro.exe") then
		Run("reflexmem-pro.exe")
	elseif FileExists("reflexmem-elite.exe") then
		Run("reflexmem-elite.exe")
	else
		Run("reflexmem.exe")
	endif
	GUIDelete($hGUI)
	Exit
EndFunc




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func EraseExtraIf()
	$i = 0
	While FileExists(GetScriptsPath("if") & $i & ".txt")
		if FileExists(GetScriptsPath("then") & $i & ".txt") then
		else
			FileDelete(GetScriptsPath("if") & $i & ".txt")
		endIf
		$i = $i + 1
	WEnd
EndFunc

Func EraseExtraThen()
	$i = 0
	While FileExists(GetScriptsPath("then") & $i & ".txt")
		if FileExists(GetScriptsPath("if") & $i & ".txt") then
		else
			FileDelete(GetScriptsPath("then") & $i & ".txt")
		endIf
		$i = $i + 1
	WEnd
EndFunc
