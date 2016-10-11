#NoTrayIcon

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

EraseExtraThen()
EraseExtraIf()

Global $hGUI = GUICreate("ReflexMem Create", 600, 725, -1, -1)
Global $triggerText = ""
Global $triggerTextNames = ""
Global $triggerNumber = 0
Global $behaviorText = ""

global $mytriggers[100]
global $mybehaviors[100]

global $mytriggersnames[100]
global $mybehaviorsnames[100]

VarifyFolders()

;$CmdLine[0] ; Contains the total number of items in the array.
;$CmdLine[1] ; The first parameter.
;$CmdLine[2] ; The second parameter.

Func LoadThenBypassIf()
	if $CmdLine[0] == 1 then
		;CreateTriggers()
		;HideTriggers()
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
      $j = $j + 1
    next
		$temp = ReadFileThenNames($triggerNumber)
    $j = 0
    For $t In $temp
      if $t <> "" then
        $mybehaviorsnames[$j] = $t
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
	;GUICtrlSetState($hButton24, $GUI_HIDE)
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
	;GUICtrlSetState($hButton24, $GUI_SHOW)
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
	endif
	GUICtrlSetState($hButtonUp2, $GUI_SHOW)
	GUICtrlSetState($hButtonDown2, $GUI_SHOW)
	GUICtrlSetState($hButtonDelete2, $GUI_SHOW)
EndFunc


Func CreateTriggers()

	Global $hGroup   = GUICtrlCreateGroup("Triggers", 								20, 	10, 	280, 540)
	Global $hButton  = GUICtrlCreateButton("Key is Pressed", 					35, 	35, 	250, 35) ;done
	Global $hButton1 = GUICtrlCreateButton("Mouse is Clicked", 				35, 	80, 	250, 35) ;done
	Global $hButton22= GUICtrlCreateButton("Mouse in Region",   			35, 	125, 	250, 35) ;done
	Global $hButton2 = GUICtrlCreateButton("Clipboard Contains",			35, 	170, 	250, 35) ;done
	Global $hButton3 = GUICtrlCreateButton("Program is Running",			35, 	215, 	250, 35) ;done
	Global $hButton4 = GUICtrlCreateButton("Date and Time is", 				35, 	260, 	250, 35) ;done
	Global $hButton5 = GUICtrlCreateButton("Image on Screen", 				35, 	305, 	250, 35) ;done
	Global $hButton6 = GUICtrlCreateButton("Text on Screen *Pro", 		35, 	350, 	250, 35) ;done
	Global $hButton23= GUICtrlCreateButton("Manage Variable *Pro",		35, 	395, 	250, 35) ;done
	;Global $hButton24= GUICtrlCreateButton("Variable Equals *Pro",		35, 	440, 	250, 35) ;
	Global $hButton0 = GUICtrlCreateButton("Help", 										35, 	575, 	250, 35) ;done
	Global $hButton16 = GUICtrlCreateButton("Submit Triggers", 				20, 	655, 	280, 50)
	GUICtrlSetFont(-1, 10)

	Global $hlisttrigs = GUICTRLCreateListView("Triggers                               ", 330, 245, 240, 380)
	Global $hButtonCancel1 	= GUICtrlCreateButton("Cancel", 330, 655, 80, 50)
	Global $hButtonUp1 			= GUICtrlCreateButton("↑", 415, 655, 30, 50)
	Global $hButtonDown1 		= GUICtrlCreateButton("↓", 450, 655, 30, 50)
	Global $hButtonDelete1 	= GUICtrlCreateButton("Delete", 485, 655, 80, 50)

	Global $hLabel1 = GUICtrlCreateLabel("", 330, 35, 240, 200)
	GUICtrlSetStyle(-1, $SS_CENTER)

	GUISetState()

EndFunc


Func CreateBehaviors()

	Global $hGroup1   = GUICtrlCreateGroup("Behaviors", 							310, 	10, 	280, 615)
	Global $hButton7  = GUICtrlCreateButton("Send Keys",							330, 	35, 	250, 35) ;done
	Global $hButton8  = GUICtrlCreateButton("Key Down", 							330, 	80, 	250, 35) ;done
	Global $hButton9  = GUICtrlCreateButton("Key Up", 								330, 	125, 	250, 35) ;done
	Global $hButton10 = GUICtrlCreateButton("Move Mouse", 						330, 	170, 	250, 35) ;done
	Global $hButton11 = GUICtrlCreateButton("Mouse Click", 						330, 	215, 	250, 35) ;done
	Global $hButton12 = GUICtrlCreateButton("Scroll Mouse Wheel", 		330, 	260, 	250, 35) ;done
	Global $hButton13 = GUICtrlCreateButton("Copy / Paste", 					330, 	305, 	250, 35) ;done
	Global $hButton14 = GUICtrlCreateButton("Manage Programs",    		330, 	350, 	250, 35) ;done
	Global $hButton18 = GUICtrlCreateButton("Display Message",				330, 	395, 	250, 35) ;done
	Global $hButton15 = GUICtrlCreateButton("Wait", 									330, 	440, 	250, 35) ;done
	Global $hButton19 = GUICtrlCreateButton("Manage ReflexMem",				330, 	485, 	250, 35) ;??????
	Global $hButton20 = GUICtrlCreateButton("Manage Variables *Pro",	330, 	530, 	250, 35) ;done
	Global $hButton21 = GUICtrlCreateButton("Get On Screen Text *Pro",330, 	575, 	250, 35) ;done
	Global $hButton17 = GUICtrlCreateButton("Submit Behaviors",				310, 	655, 	280, 50) ;done
	GUICtrlSetFont(-1, 10)

	Global $hlistbehavs = GUICTRLCreateListView("Behaviors                             ", 35, 245, 240, 380)
	Global $hButtonCancel2 = GUICtrlCreateButton("Cancel", 35, 655, 80, 50)
	Global $hButtonUp2 			= GUICtrlCreateButton("↑", 120, 655, 30, 50)
	Global $hButtonDown2 		= GUICtrlCreateButton("↓", 155, 655, 30, 50)
	Global $hButtonDelete2 = GUICtrlCreateButton("Delete", 190, 655, 85, 50)

	Global $hLabel = GUICtrlCreateLabel("", 35, 35, 240, 200)
	GUICtrlSetStyle(-1, $SS_CENTER)

	GUISetState()

	LoadThenModify()

EndFunc


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
			$data = "Lift a key up as if not holding it down on they keyboard any longer." & @CRLF & @CRLF & "Which key?"
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
			$data = "Put data on the clipboard." & @CRLF & @CRLF & "What Text?"
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
			$data = "Display Informational Message." & @CRLF & @CRLF & "What message?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton19 Then
				$data = "Tell ReflexMem to temporarilly ignore anything it my see as a trigger so that it does no behaviors or to stop ignoring triggers and reacting to them again. Managing ReflexMem one can have two keys that can turn triggers off and on dymanically."
				if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton20 Then
				$data = "Save data to variables. Mainly used for making counters or preserving data on the clipboard without saving it to a file."
				if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton21 Then
				$data = "Reads Text that is displayed on the screen and copies it to the clipboard."
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
		;elseif $a[4] == $hButton24 Then
		;	$data = "When a variable equals a particular value. Variable Triggers make ReflexMem more robust becuase it can now be used in more dynamic ways. Variables can hold numbers (ie. 56) or boolean values (ie. True) or text (ie 'We are all that we are'). Text must have '' surounding it and can't have any apostrophese inside the text." & @CRLF & @CRLF & "Which variable?" & @CRLF & @CRLF & "What should the variable equal?"
		;	if GUICtrlRead($hLabel1) <> $data Then
		;		GUICtrlSetData($hLabel1, $data)
		;	EndIf

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Specific Triggers

Func KeyPressedTrigger()
	Local $hChild7 = GUICreate("Key Pressed Trigger", 400, 640, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("Which key(s) should be pressed for this Trigger?", 20, 20, 360, 40)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button71 = GUICtrlCreateButton("Single Letter or Number", 20, 60, 160, 30)
	local $button72 = GUICtrlCreateButton("Enter", 220, 60, 160, 30)
	local $button73 = GUICtrlCreateButton("Space", 20, 100, 160, 30)
	local $button74 = GUICtrlCreateButton("Shift", 220, 100, 160, 30)
	local $button75 = GUICtrlCreateButton("Alt", 20, 140, 160, 30)
	local $button76 = GUICtrlCreateButton("Control", 220, 140, 160, 30)
	local $button77 = GUICtrlCreateButton("Left", 20, 180, 160, 30)
	local $button78 = GUICtrlCreateButton("Right", 220, 180, 160, 30)
	local $button79 = GUICtrlCreateButton("Up", 20, 220, 160, 30)
	local $button710 = GUICtrlCreateButton("Down", 220, 220, 160, 30)
	local $button711 = GUICtrlCreateButton("Tab", 20, 260, 160, 30)
	local $button712 = GUICtrlCreateButton("Escape", 220,260, 160, 30)
	local $button713 = GUICtrlCreateButton("Page Up", 20, 300, 160, 30)
	local $button714 = GUICtrlCreateButton("Page Down", 220, 300, 160, 30)
	local $button715 = GUICtrlCreateButton("Home", 20, 340, 160, 30)
	local $button716 = GUICtrlCreateButton("End", 220, 340, 160, 30)
	local $button717 = GUICtrlCreateButton("Delete", 20, 380, 160, 30)
	local $button718 = GUICtrlCreateButton("Backspace", 220, 380, 160, 30)
	local $button719 = GUICtrlCreateButton("Caps Lock", 20, 420, 160, 30)
	local $button720 = GUICtrlCreateButton("Num Lock", 220, 420, 160, 30)
	local $button721 = GUICtrlCreateButton("Print Screen", 20, 460, 160, 30)
	local $button722 = GUICtrlCreateButton("Windows Key", 220, 460, 160, 30)
	local $button723 = GUICtrlCreateButton("Insert", 20, 500, 160, 30)
	local $button727 = GUICtrlCreateButton("Plus (+)", 20, 540, 160, 30)
	local $button728 = GUICtrlCreateButton("F Keys", 220, 500, 160, 30)
	GUISetState()

	local $totrig = ""
	Local $sAnswer = ""

	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild7)
				ExitLoop
			Case $button71
				$sAnswer = InputBox("Key Press Trigger", "What single key should be the trigger? (Letters and numbers allowed.)", "a", "")
				$sAnswer = StringReplace($sAnswer, "{", "")
				$sAnswer = StringReplace($sAnswer, "}", "")
				$sAnswer = StringReplace($sAnswer, "^", "")
				$sAnswer = StringReplace($sAnswer, "+", "")
				$sAnswer = StringReplace($sAnswer, "!", "")
				$sAnswer = StringReplace($sAnswer, "#", "")
				$totrig = StringLeft($sAnswer, 1)
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button72
				$totrig = "{ENTER}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button73
				$totrig = "{SPACE}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button74
				$totrig = "{LSHIFT}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button75
				$totrig = "{ALT}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button76
				$totrig = "{LCTRL}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button77
				$totrig = "{LEFT}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button78
				$totrig = "{RIGHT}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button79
				$totrig = "{UP}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button710
				$totrig = "{DOWN}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button711
				$totrig = "{TAB}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button712
				$totrig = "{ESCAPE}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button713
				$totrig = "{PGUP}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button714
				$totrig = "{PGDN}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button715
				$totrig = "{HOME}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button716
				$totrig = "{END}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button717
				$totrig = "{DELETE}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button718
				$totrig = "{BACKSPACE}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button719
				$totrig = "{CAPSLOCK}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button720
				$totrig = "{NUMLOCK}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button721
				$totrig = "{PRINTSCREEN}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button722
				$totrig = "{LWIN}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button723
				$totrig = "{INSERT}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button727 ;Special keys
				$totrig = "{+}"
				addKeyPressToTrigger($totrig)
				GUIDelete($hChild7a)
				ExitLoop
			Case $button728 ;F keys
				$hChild7a = GUICreate("Function Key Press Trigger", 400, 440, -1, -1, -1, -1, $hChild7)
				GUICtrlCreateLabel("Which F key should be set as the keypress trigger?", 20, 20, 360, 40)
				GUICtrlSetStyle(-1, $SS_CENTER)
				$button7a1 = GUICtrlCreateButton("F1", 20, 80, 160, 40)
				$button7a2 = GUICtrlCreateButton("F2", 220, 80, 160, 40)
				$button7a3 = GUICtrlCreateButton("F3", 20, 140, 160, 40)
				$button7a4 = GUICtrlCreateButton("F4", 220, 140, 160, 40)
				$button7a5 = GUICtrlCreateButton("F5", 20, 200, 160, 40)
				$button7a6 = GUICtrlCreateButton("F6", 220, 200, 160, 40)
				$button7a7 = GUICtrlCreateButton("F7", 20, 260, 160, 40)
				$button7a8 = GUICtrlCreateButton("F8", 220, 260, 160, 40)
				$button7a9 = GUICtrlCreateButton("F9", 20, 320, 160, 40)
				$button7a10 = GUICtrlCreateButton("F10", 220, 320, 160, 40)
				$button7a11 = GUICtrlCreateButton("F11", 20, 380, 160, 40)
				$button7a12 = GUICtrlCreateButton("F12", 220, 380, 160, 40)
				GUISetState()
				local $totrig = ""
				While 1
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a1
							$totrig = "{F1}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a2
							$totrig = "{F2}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a3
							$totrig = "{F3}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a4
							$totrig = "{F4}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a5
							$totrig = "{F5}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a6
							$totrig = "{F6}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a7
							$totrig = "{F7}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a8
							$totrig = "{F8}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a9
							$totrig = "{F9}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a10
							$totrig = "{F10}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a11
							$totrig = "{F11}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a12
							$totrig = "{F12}"
							addKeyPressToTrigger($totrig)
							GUIDelete($hChild7a)
							ExitLoop
					EndSwitch
				WEnd
				GUIDelete($hChild7)
				ExitLoop
		EndSwitch
	WEnd
EndFunc


Func addKeyPressToTrigger($data)
;HotKeySet("^a", "GetPos") ;control
;HotKeySet("+a", "GetPos") ;  Shift
;HotKeySet("!a", "GetPos") ;alt
	local $name = $data & " key is pressed"
	if $data 			== "{BACKSPACE}" 	then
		$data = "08"
	elseif $data 	== "{TAB}" 				then
		$data = "09"
	elseif $data 	== "{ENTER}" 			then
		$data = "0D"
	elseif $data 	== "{LSHIFT}"			then
		$data = "10"
	elseif $data 	== "{LCTRL}"			then
		$data = "11"
	elseif $data 	== "{ALT}" 				then
		$data = "12"
	elseif $data 	== "{PAUSE}"			then
		$data = "13"
	elseif $data 	== "{CAPSLOCK}"		then
		$data = "14"
	elseif $data 	== "{ESCAPE}"			then
		$data = "1B"
	elseif $data 	== "{SPACE}" 			then
		$data = "20"
	elseif $data 	== "{PGUP}" 			then
		$data = "21"
	elseif $data 	== "{PGDN}"				then
		$data = "22"
	elseif $data 	== "{END}" 				then
		$data = "23"
	elseif $data 	== "{HOME}" 			then
		$data = "24"
	elseif $data 	== "{LEFT}"				then
		$data = "25"
	elseif $data 	== "{UP}" 				then
		$data = "26"
	elseif $data 	== "{RIGHT}"			then
		$data = "27"
	elseif $data 	== "{DOWN}" 			then
		$data = "28"
	elseif $data 	== "{PRINTSCREEN}"then
		$data = "2C"
	elseif $data 	== "{INSERT}"			then
		$data = "2D"
	elseif $data 	== "{DELETE}"			then
		$data = "2E"
	elseif $data 	== "{NUMLOCK}"		then
		$data = "90"
	elseif $data 	== "{LWIN}"				then
		$data = "5B"
	elseif $data 	== "{F1}"					then
		$data = "70"
	elseif $data 	== "{F2}"					then
		$data = "71"
	elseif $data 	== "{F3}"					then
		$data = "72"
	elseif $data 	== "{F4}"					then
		$data = "73"
	elseif $data 	== "{F5}"					then
		$data = "74"
	elseif $data 	== "{F6}"					then
		$data = "75"
	elseif $data 	== "{F7}"					then
		$data = "76"
	elseif $data 	== "{F8}"					then
		$data = "77"
	elseif $data 	== "{F9}"					then
		$data = "78"
	elseif $data 	== "{F10}"				then
		$data = "79"
	elseif $data 	== "{F11}"				then
		$data = "7A"
	elseif $data 	== "{F12}"				then
		$data = "7B"
	elseif $data 	== "0" 						then
		$data = "30"
	elseif $data 	== "1" 						then
		$data = "31"
	elseif $data 	== "2" 						then
		$data = "32"
	elseif $data 	== "3" 						then
		$data = "33"
	elseif $data 	== "4" 						then
		$data = "34"
	elseif $data 	== "5" 						then
		$data = "35"
	elseif $data 	== "6" 						then
		$data = "36"
	elseif $data 	== "7" 						then
		$data = "37"
	elseif $data 	== "8" 						then
		$data = "38"
	elseif $data 	== "9" 						then
		$data = "39"
	elseif $data 	== "9" 						then
		$data = "39"
	elseif $data 	== "{!}"					then
		$data = "6B"
	elseif $data 	== "{#}"					then
		$data = "6B"
	elseif $data 	== "{+}"					then
		$data = "6B"
	elseif $data 	== "{^}"					then
		$data = "6B"
	elseif $data 	== "{}}" 					then
		$data = "6B"
	elseif $data 	== "{{}" 					then
		$data = "6B"
	elseif $data 	== ";"						then
		$data = "BA"
	elseif $data 	== "="						then
		$data = "BB"
	elseif $data 	== ","						then
		$data = "BC"
	elseif $data 	== "-"						then
		$data = "BD"
	elseif $data 	== "." 						then
		$data = "BE"
	elseif $data 	== "/" 						then
		$data = "BF"
	elseif $data 	== "`"						then
		$data = "C0"
	elseif $data 	== "["						then
		$data = "DB"
	elseif $data 	== "\" 						then
		$data = "DC"
	elseif $data 	== "]" 						then
		$data = "DD"
	elseif $data 	== "*" 						then
		$data = "6A"
	elseif $data 	== "A" Or $data == "a" then
	 	$data = "41"
	elseif $data 	== "B" Or $data == "b" then
		$data = "42"
	elseif $data 	== "C" Or $data == "c" 	then
		$data = "43"
	elseif $data 	== "D" Or $data == "d" 	then
		$data = "44"
	elseif $data 	== "E" Or $data == "e" 	then
		$data = "45"
	elseif $data 	== "F" Or $data == "f" 	then
		$data = "46"
	elseif $data 	== "G" Or $data == "g" 	then
		$data = "47"
	elseif $data 	== "H" Or $data == "h" 	then
		$data = "48"
	elseif $data 	== "I" Or $data == "i" 	then
		$data = "49"
	elseif $data 	== "J" Or $data == "j" 	then
		$data = "4A"
	elseif $data 	== "K" Or $data == "k" 	then
		$data = "4B"
	elseif $data 	== "L" Or $data == "l" 	then
		$data = "4C"
	elseif $data 	== "M" Or $data == "m" 	then
		$data = "4D"
	elseif $data 	== "N" Or $data == "n" 	then
		$data = "4E"
	elseif $data 	== "O" Or $data == "o" 	then
		$data = "4F"
	elseif $data 	== "P" Or $data == "p" 	then
		$data = "50"
	elseif $data 	== "Q" Or $data == "q" 	then
		$data = "51"
	elseif $data 	== "R" Or $data == "r" 	then
		$data = "52"
	elseif $data 	== "S" Or $data == "s" 	then
		$data = "53"
	elseif $data 	== "T" Or $data == "t" 	then
		$data = "54"
	elseif $data 	== "U" Or $data == "u" 	then
		$data = "55"
	elseif $data 	== "V" Or $data == "v" 	then
		$data = "56"
	elseif $data 	== "W" Or $data == "w" 	then
		$data = "57"
	elseif $data 	== "X" Or $data == "x" 	then
		$data = "58"
	elseif $data 	== "Y" Or $data == "y" 	then
		$data = "59"
	elseif $data 	== "Z" Or $data == "z" 	then
		$data = "5A"
	else
		$data = "6B"
	endif
	local $totrig = ""
	;if $shift then
;		$totrig = $totrig & "+"
	;	$totrig = "_IsPressed('10') And "
	;	$name = "{SHIFT} key is pressed And " & $name
	;endif
	;if $alt then
;		$totrig = $totrig & "!"
	;	$totrig = "_IsPressed('12') And "
	;	$name = "{ALT} key is pressed And " & $name
	;endif
	;if $control then
;		$totrig = $totrig & "^"
	;	$totrig = "_IsPressed('11') And "
	;	$name = "{CONTROL} key is pressed And " & $name
	;endif
;	$totrig = "HotKeySet('" & $totrig & $data & "', 'HotKeyTrigger')"
	$totrig = $totrig & "_IsPressed('" & $data & "')"
	AddToTrigger($totrig, $name)
EndFunc



Func ClipboardTrigger() ;must put a escape chaaracter before and apostrophese \'
	Local $sAnswer = InputBox("Clipboard Trigger", "What text?", "Planet Earth", "")
	if $sAnswer <> "" then
		local $totrig = "ClipGet() == '" & $sAnswer &"'"
		local $name = "clipboard contains " & $sAnswer
		AddToTrigger($totrig, $name)
	endif
EndFunc


;NOT DONE YET!!! get variable, and when modified devise a way to
Func ManageVarEqualsTrigger() ;must put a escape chaaracter before and apostrophese \'
	local $hMain_GUI = GUICreate("Variable Equals Trigger",600, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("What should the trigger check?", 20, 20, 560, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $hmButton1 = GUICtrlCreateButton("a Variable Equals a Value", 20, 80, 160, 60)
	local $hmButton2 = GUICtrlCreateButton("a Variable Equals a Variable", 220, 80, 160, 60)
	local $hmButton3 = GUICtrlCreateButton("a Variable has a Changed Value", 420, 80, 160, 60)
	GUISetState()

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton1
				VariableEqualsTrigger()
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton2
				VarEqualsVarTrigger()
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton3
				VariableModifiedTrigger()
				GUIDelete($hMain_GUI)
				ExitLoop
			EndSwitch
	WEnd
EndFunc


Func VariableEqualsTrigger() ;must put a escape chaaracter before and apostrophese \'
	Local $sAnswer = InputBox("Variable Equals Trigger", "Which variable do you want to check to see if it has been modified? (0 to 31)", "1", "")
	if $sAnswer <> "" then
		local $totrig = "$uservar" & $sAnswer & "  == "
		local $name = "variable " & $sAnswer & " equals "
	else
		return
	endif
	Local $sAnswer = InputBox("Variable Equals Trigger", "What value should that variable hold? (text must be encased in '' and can't have any ' in the text. Numbers or true or false don't need '')", "'oh what a beautiful morning'", "")
	if $sAnswer <> "" then
		$totrig = $totrig & $sAnswer
		$name = $name & $sAnswer
		AddToTrigger($totrig, $name)
	endif
EndFunc


Func VarEqualsVarTrigger() ;must put a escape chaaracter before and apostrophese \'
	Local $sAnswer = InputBox("Variable Equals Trigger", "Which variable do you want to check? (0 to 31)", "1", "")
	if $sAnswer <> "" then
		local $totrig = "$uservar" & $sAnswer & "  == "
		local $name = "variable " & $sAnswer & " equals "
	else
		return
	endif
	Local $sAnswer = InputBox("Variable Equals Trigger", "What variable should it equal? ", "2", "")
	if $sAnswer <> "" then
		$totrig = $totrig & "$uservar" & $sAnswer
		$name = $name & "variable " & $sAnswer
		AddToTrigger($totrig, $name)
	endif
EndFunc

Func VariableModifiedTrigger() ;must put a escape chaaracter before and apostrophese \'
	Local $sAnswer = InputBox("Variable Modified Trigger", "Which variable do you want to check to see if it has been modified? (0 to 31)", "1", "")
	if $sAnswer <> "" then
		local $totrig = "$olduservar" & $sAnswer & " <> $uservar" & $sAnswer
		local $name = "varable " & $sAnswer & " has been changed."
		AddToTrigger($totrig, $name)
	endif
EndFunc




Func MouseClickTrigger()
	Local $hChild1 = GUICreate("Mouse Click Trigger", 400, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("Which button should be the trigger if cliked?", 20, 20, 360, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button1a1 = GUICtrlCreateButton("Primary (left)", 20, 80, 160, 60)
	local $button1a2 = GUICtrlCreateButton("Secondary (right)", 220, 80, 160, 60)
	GUISetState()

	local $totrig = ""
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild1)
				ExitLoop
			Case $button1a1
				$totrig = "_IsPressed('01')"
				$name = "primary mouse button clicked"
				AddToTrigger($totrig, $name)
				GUIDelete($hChild1)
				ExitLoop
			Case $button1a2
				$totrig = "_IsPressed('02')"
				$name = "secondary mouse button clicked"
				AddToTrigger($totrig, $name)
				GUIDelete($hChild1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func MouseAtTrigger()
	msgbox(64, "Mouse in Region Trigger", "Please select region by clicking and dragging your mouse.")
	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path
	local $i, $sFile
	While 1
		Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
		if $iX2 - $iX1 < 1 Or $iY2 - $iY1 < 1 then
			msgbox(64, "Mouse in Region Trigger", "Please click and drag to select a larger region.")
			return
		endif
		$totrig = "MouseGetPos(0) > " & $iX1 & " And MouseGetPos(1) > " & $iY1 & " And MouseGetPos(0) < " & $iX2 & " And MouseGetPos(1) < " & $iY2
		AddToTrigger($totrig, "the mouse is found between " & $iX1 & ", " & $iY1 & " and " & $iX2 & ", " & $iY2)
		ExitLoop
	WEnd
EndFunc


Func ProgramRunsTrigger()
	Local $hChild3 = GUICreate("Program is Running Trigger", 400, 640, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("Which program should this trigger watch for?", 20, 20, 360, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	$listview = GUICtrlCreateListView("List of Running Programs", 2, 50, 396, 496, BitOR($LVS_NOSORTHEADER, $LVS_SINGLESEL))
	;get programs
	local $processes = ProcessList()
	;_arrayDisplay($processes)
	; Add files
	for $i = 0 to ubound($processes)-1
		_GUICtrlListView_AddItem($listview, $processes[$i][0], 1)
	next
	local $button3a = GUICtrlCreateButton("Select Program", 20, 560, 113, 60)
	local $button3c = GUICtrlCreateButton("Other", 143, 560, 113, 60)
	local $button3b = GUICtrlCreateButton("Cancel", 266, 560, 113, 60)
	GUISetState()

	local $totrig = ""
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild3)
				ExitLoop
			Case $button3b
				GUIDelete($hChild3)
				ExitLoop
			Case $button3a
        $totrig = _GUICtrlListView_GetSelectedIndices($listview)
				$name = $processes[$totrig][0] & " is running"
				$totrig = "ProcessExists('" & $processes[$totrig][0] & "')"
				AddToTrigger($totrig, $name)
				GUIDelete($hChild3)
				ExitLoop
			Case $button3c
				$totrig = InputBox("Program is Running Trigger", "What is the name of the program?", "chrome.exe", "")
				$name = $totrig & " is running"
				$totrig = "ProcessExists('" & $totrig & "')"
				AddToTrigger($totrig, $name)
				GUIDelete($hChild3)
				ExitLoop
		EndSwitch
	WEnd

EndFunc



Func DateToTrigger()
	Local $hChild4 = GUICreate("Date and Time Trigger", 620, 130, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("What kind of date should this trigger be?", 20, 20, 600, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button4a = GUICtrlCreateButton("Everyday", 10, 50, 140, 60)
	local $button4b = GUICtrlCreateButton("On a day of the Week", 160, 50, 140, 60)
	local $button4c = GUICtrlCreateButton("On a day of the Month", 310, 50, 140, 60)
	local $button4d = GUICtrlCreateButton("Cancel", 460, 50, 140, 60) ; placeholder for "specific date trigger"
	GUISetState()

	local $datething = ""
	local $datenumber
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild4)
				ExitLoop
			Case $button4a
				TimeToTrigger($datething, $datenumber, "everyday at ")
				GUIDelete($hChild4)
				ExitLoop
			Case $button4b
				$datething = "week"
				Local $hChild4a = GUICreate("Date and Time Trigger", 220, 330, -1, -1, -1, -1, $hChild4)
				GUICtrlCreateLabel("What which day of the Week?", 20, 20, 180, 35)
				GUICtrlSetStyle(-1, $SS_CENTER)
				$listview1 = GUICtrlCreateListView("Days of the Week", 4, 50, 212, 200, BitOR($LVS_NOSORTHEADER, $LVS_SINGLESEL))
				_GUICtrlListView_AddItem($listview1, "Sunday", 1)
				_GUICtrlListView_AddItem($listview1, "Monday", 1)
				_GUICtrlListView_AddItem($listview1, "Tuesday", 1)
				_GUICtrlListView_AddItem($listview1, "Wednesday", 1)
				_GUICtrlListView_AddItem($listview1, "Thursday", 1)
				_GUICtrlListView_AddItem($listview1, "Friday", 1)
				_GUICtrlListView_AddItem($listview1, "Saturday", 1)

				local $button4a1 = GUICtrlCreateButton("Submit Day", 10, 260, 90, 60)
				local $button4b2 = GUICtrlCreateButton("Cancel", 120, 260, 90, 60)
				GUISetState()

				While 1
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($hChild4a)
							ExitLoop
						Case $button4a1
							if _GUICtrlListView_GetSelectedIndices($listview1) == "" then
								msgbox(64, "Date and Time Trigger", "You must select a day.")
							else
								$datenumber = _GUICtrlListView_GetSelectedIndices($listview1) + 1
								TimeToTrigger($datething, $datenumber, "every week on " & ControlListView("Date and Time Trigger", "", $listview1, "GetText", $datenumber-1) & " at ")
								ExitLoop
							endif
						Case $button4b2
							GUIDelete($hChild4a)
							ExitLoop
					EndSwitch
				WEnd
				GUIDelete($hChild4)
				ExitLoop
			Case $button4c
				$datething = "month"
				Local $hChild4a = GUICreate("Date and Time Trigger", 220, 750, -1, -1, -1, -1, $hChild4)
				GUICtrlCreateLabel("What which day of the Month?", 20, 20, 180, 35)
				GUICtrlSetStyle(-1, $SS_CENTER)
				$listview2 = GUICtrlCreateListView("Days of the Month", 4, 50, 212, 616, BitOR($LVS_NOSORTHEADER, $LVS_SINGLESEL))
				local $days = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15", _
											 "16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
			  for $i = 0 to Ubound($days)-1
					_GUICtrlListView_AddItem($listview2, $days[$i], 1)
				next

				local $button4a1 = GUICtrlCreateButton("Submit Day", 10, 680, 90, 60)
				local $button4b2 = GUICtrlCreateButton("Cancel", 120, 680, 90, 60)
				GUISetState()


				While 1
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($hChild4a)
							ExitLoop
						Case $button4a1
							if _GUICtrlListView_GetSelectedIndices($listview2) == "" then
								msgbox(64, "Date and Time Trigger", "You must select a day.")
							else
								$datenumber = $days[_GUICtrlListView_GetSelectedIndices($listview2)]
								TimeToTrigger($datething, $datenumber, "on the " & $datenumber & " of every month at ")
							endif
							ExitLoop
						Case $button4b2
							GUIDelete($hChild4a)
							ExitLoop
					EndSwitch
				WEnd
				GUIDelete($hChild4)
				ExitLoop
			Case $button4d
				GUIDelete($hChild4)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func TimeToTrigger($datething, $datenumber, $name)
	local $totrig
	if $datething == "everyday" then
	elseif $datething == "week" then
		$totrig = "@WDAY == " & $datenumber & " And "
	elseif $datething == "month" then
		$totrig = "@MDAY == '" & $datenumber & "' And "
	endif

	Local $hChild4a = GUICreate("Date and Time Trigger", 320, 630, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("For what time of the day should this trigger be set?", 20, 20, 270, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	$listview1 = _GUICtrlListView_Create($hChild4a, "Hour", 4, 50, 94, 500)
	$listview2 = _GUICtrlListView_Create($hChild4a, "Minutes", 108, 50, 100, 500)
	$listview3 = _GUICtrlListView_Create($hChild4a, "Seconds", 216, 50, 100, 500)
	local $hours = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15", _
								  "16","17","18","19","20","21","22","23"]
  local $minutes = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15", _
								   "16","17","18","19","20","21","22","23","24","25","26","27","28","29","30", _
									 "31","32","33","34","35","36","37","38","39","40","41","42","43","44","45", _
									 "46","47","48","49","50","51","52","53","54","55","56","57","58","59","50", _
									 "56","57","58","59"]
	local $seconds = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15", _
								   "16","17","18","19","20","21","22","23","24","25","26","27","28","29","30", _
									 "31","32","33","34","35","36","37","38","39","40","41","42","43","44","45", _
									 "46","47","48","49","50","51","52","53","54","55","56","57","58","59","50", _
									 "56","57","58","59"]
	for $i = 0 to Ubound($hours)-1
		_GUICtrlListView_AddItem($listview1, $hours[$i], 1)
	next
	for $i = 0 to Ubound($minutes)-1
		_GUICtrlListView_AddItem($listview2, $minutes[$i], 1)
		_GUICtrlListView_AddItem($listview3, $seconds[$i], 1)
	next

	local $button4a1 = GUICtrlCreateButton("Submit Time", 10, 560, 100, 60)
	local $button4b2 = GUICtrlCreateButton("Cancel", 210, 560, 100, 60)
	GUISetState()

	local $myhour
	local $mymin
	local $mysec
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild4a)
				ExitLoop
			Case $button4a1
				if $myhour <> "" Or $mymin <> "" Or $mysec <> "" then
					MsgBox(64, "Notification", "You must make selections.")
				else
					$myhour = $hours[_GUICtrlListView_GetSelectedIndices($listview1)]
					$mymin = $minutes[_GUICtrlListView_GetSelectedIndices($listview2)]
					$mysec = $seconds[_GUICtrlListView_GetSelectedIndices($listview3)]
					$totrig = $totrig & " @HOUR == '" & $myhour & "' And @MIN == '" & $mymin & "' And @SEC == '" & $mysec & "'"
					;$name = $
					AddToTrigger($totrig, $name & $myhour & ":" & $mymin & ":" & $mysec)
					GUIDelete($hChild4a)
					ExitLoop
				endif
			Case $button4b2
				GUIDelete($hChild4a)
				ExitLoop
		EndSwitch
	WEnd
EndFunc



Func ImageOnScreenTrigger()
	;local $w1 = (@desktopwidth/2)-100
	;local $w2 = (@desktopwidth/2)+100
	;local $h1 = (@desktopheight/2)-100
	;local $h2 = (@desktopheight/2)+100
	;local $x1,$y1
	;local $result = _ImageSearchArea("help.png",1,$w1,$h1,$w2,$h2,$x1,$y1,25)
	;if $result = 1 Then
	; $w = False
	;Else
	; ResetView(301)
	; $x = $x + 1
	;EndIf

	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path

	; Create GUI
	local $hMain_GUI = GUICreate("Image On Screen Trigger", 380, 80, -1, -1, -1, -1, $hGUI)
	local $hRect_Button   = GUICtrlCreateButton("Capture Image On Screen",  20, 20, 160, 40)
	local $sFile_Button   = GUICtrlCreateButton("Select Image From File",  200, 20, 160, 40)

	GUISetState()

	local $i, $sFile
	While 1

    Switch GUIGetMsg()
      Case $GUI_EVENT_CLOSE
				GUIDelete($hMain_GUI)
        ;FileDelete(@ScriptDir & "\Rect.bmp")
        ExitLoop
      Case $hRect_Button
	      GUISetState(@SW_HIDE, $hMain_GUI)
	      Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
	      ; Capture selected area
				$i = 0
				While FileExists(GetScriptsPath("images") & $i & ".bmp")
					$i = $i + 1
				WEnd
	      $sBMP_Path = GetScriptsPath("images") & $i & ".bmp"
	    	_ScreenCapture_Capture($sBMP_Path, $iX1, $iY1, $iX2, $iY2, False)
	      GUISetState(@SW_SHOW, $hMain_GUI)
	      ; Display image
	      ;$hBitmap_GUI = GUICreate("Selected Rectangle", $iX2 - $iX1 + 1, $iY2 - $iY1 + 1, 100, 100)
	      ;$hPic = GUICtrlCreatePic(@ScriptDir & "\Rect.bmp", 0, 0, $iX2 - $iX1 + 1, $iY2 - $iY1 + 1)
	      ;GUISetState()
				GUIDelete($hMain_GUI)
				GetAreaImageScreenTrigger($sBMP_Path)
        ExitLoop
			Case $sFile_Button
				local $sFile = FileOpenDialog("Choose Image...", @DesktopCommonDir, "All (*.*)")
				if $sFile == "" then
					GUIDelete($hMain_GUI)
					ExitLoop
				endif
				GUIDelete($hMain_GUI)
				GetAreaImageScreenTrigger($sFile)
        ExitLoop

	    EndSwitch

	WEnd

EndFunc
Func GetAreaImageScreenTrigger($imagefile)
	;local $w1 = (@desktopwidth/2)-100
	;local $w2 = (@desktopwidth/2)+100
	;local $h1 = (@desktopheight/2)-100
	;local $h2 = (@desktopheight/2)+100
	;local $x1,$y1
	;local $result = _ImageSearchArea("help.png",1,$w1,$h1,$w2,$h2,$x1,$y1,25)
	;if $result = 1 Then
	; $w = False
	;Else
	; ResetView(301)
	; $x = $x + 1
	;EndIf
	Local $acc = InputBox("Image On Screen Trigger", "how tolerant do you want this trigger to be? (0 = exact image, 255 = fully tolerant)", "25", "")
	if @error == 1 then
		return
	endif
	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path

	; Create GUI
	local $hMain_GUI = GUICreate("Image On Screen Trigger", 380, 80, -1, -1, -1, -1, $hGUI)

	local $sRect_Button   = GUICtrlCreateButton("Select Region on Screen",  20, 20, 160, 40)
	local $sFull_Button   = GUICtrlCreateButton("Search Full Screen",  200, 20, 160, 40)

	GUISetState()

	local $totrig

	While 1

    Switch GUIGetMsg()
      Case $GUI_EVENT_CLOSE
				GUIDelete($hMain_GUI)
        ;FileDelete(@ScriptDir & "\Rect.bmp")
        ExitLoop
      Case $sRect_Button
	      GUISetState(@SW_HIDE, $hMain_GUI)
	      Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
	      ; Capture selected area
	      GUISetState(@SW_SHOW, $hMain_GUI)
				$totrig = "_ImageSearchArea('" & $imagefile & "',1," & $iX1 & "," & $iY1 & "," & $iX2 & "," & $iY2 & ", $X1, $Y1, " & $acc & ")"
				AddToTrigger($totrig, "this image: " & $imagefile & " is found between " & $iX1 & ", " & $iY1 & " and " & $iX2 & ", " & $iY2)
				GUIDelete($hMain_GUI)
        ExitLoop
			Case $sFull_Button
				$totrig = "_ImageSearchArea('" & $imagefile & "',1," & 0 & "," & 0 & "," & @DesktopWidth & "," & @DesktopHeight & ", $X1, $Y1, " & $acc & ")"
				AddToTrigger($totrig, "this image: " & $imagefile & " is found anywhere on the screen")
				GUIDelete($hMain_GUI)
        ExitLoop
	    EndSwitch

	WEnd

EndFunc


; -------------

Func Mark_Rect(ByRef $iX1, ByRef $iY1, ByRef $iX2, ByRef $iY2, ByRef $aPos, ByRef $sMsg, ByRef $sBMP_Path)

		Local $aMouse_Pos, $hMask, $hMaster_Mask, $iTemp
		Local $UserDLL = DllOpen("user32.dll")

		Global $hRectangle_GUI = GUICreate("", @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST)
		_GUICreateInvRect($hRectangle_GUI, 0, 0, 1, 1)
		GUISetBkColor(0)
		WinSetTrans($hRectangle_GUI, "", 50)
		GUISetState(@SW_SHOW, $hRectangle_GUI)
		GUISetCursor(3, 1, $hRectangle_GUI)

		; Wait until mouse button pressed
		While Not _IsPressed("01", $UserDLL)
				Sleep(10)
		WEnd

		; Get first mouse position
		$aMouse_Pos = MouseGetPos()
		$iX1 = $aMouse_Pos[0]
		$iY1 = $aMouse_Pos[1]

		; Draw rectangle while mouse button pressed
		While _IsPressed("01", $UserDLL)

				$aMouse_Pos = MouseGetPos()

				; Set in correct order if required
				If $aMouse_Pos[0] < $iX1 Then
						$iX_Pos = $aMouse_Pos[0]
						$iWidth = $iX1 - $aMouse_Pos[0]
				Else
						$iX_Pos = $iX1
						$iWidth = $aMouse_Pos[0] - $iX1
				EndIf
				If $aMouse_Pos[1] < $iY1 Then
						$iY_Pos = $aMouse_Pos[1]
						$iHeight = $iY1 - $aMouse_Pos[1]
				Else
						$iY_Pos = $iY1
						$iHeight = $aMouse_Pos[1] - $iY1
				EndIf

				_GUICreateInvRect($hRectangle_GUI, $iX_Pos, $iY_Pos, $iWidth, $iHeight)

				Sleep(10)

		WEnd

		; Get second mouse position
		$iX2 = $aMouse_Pos[0]
		$iY2 = $aMouse_Pos[1]

		; Set in correct order if required
		If $iX2 < $iX1 Then
				$iTemp = $iX1
				$iX1 = $iX2
				$iX2 = $iTemp
		EndIf
		If $iY2 < $iY1 Then
				$iTemp = $iY1
				$iY1 = $iY2
				$iY2 = $iTemp
		EndIf

		GUIDelete($hRectangle_GUI)
		DllClose($UserDLL)

EndFunc   ;==>Mark_Rect

Func _GUICreateInvRect($hWnd, $iX, $iY, $iW, $iH)

		$hMask_1 = _WinAPI_CreateRectRgn(0, 0, @DesktopWidth, $iY)
		$hMask_2 = _WinAPI_CreateRectRgn(0, 0, $iX, @DesktopHeight)
		$hMask_3 = _WinAPI_CreateRectRgn($iX + $iW, 0, @DesktopWidth, @DesktopHeight)
		$hMask_4 = _WinAPI_CreateRectRgn(0, $iY + $iH, @DesktopWidth, @DesktopHeight)

		_WinAPI_CombineRgn($hMask_1, $hMask_1, $hMask_2, 2)
		_WinAPI_CombineRgn($hMask_1, $hMask_1, $hMask_3, 2)
		_WinAPI_CombineRgn($hMask_1, $hMask_1, $hMask_4, 2)

		_WinAPI_DeleteObject($hMask_2)
		_WinAPI_DeleteObject($hMask_3)
		_WinAPI_DeleteObject($hMask_4)

		_WinAPI_SetWindowRgn($hWnd, $hMask_1, 1)

EndFunc

Func ManageTextOnScreenTrigger()
	msgbox(64, "Text On Screen Trigger", "This feature is only supported on paid versions of ReflexMem.")

	local $hMain_GUI = GUICreate("Text on Screen Trigger",600, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("What text should the trigger look for?", 20, 20, 560, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $hmButton1 = GUICtrlCreateButton("a Value", 20, 80, 160, 60)
	local $hmButton2 = GUICtrlCreateButton("a Variable", 220, 80, 160, 60)
	local $hmButton3 = GUICtrlCreateButton("the Clipboard", 420, 80, 160, 60)
	GUISetState()

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton1
				TextOnScreenValueTrigger()
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton2
				TextOnScreenVariableTrigger()
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton3
				TextOnScreenClipTrigger()
				GUIDelete($hMain_GUI)
				ExitLoop
			EndSwitch
	WEnd
EndFunc

Func TextOnScreenValueTrigger()

	; This is like Image on screen but it will take a image of the full screen
	; and run ocr on it, then search the text for the text you want.

	;You'll have to get:
		;the region of the screen
		;the text to find
		;the score from 1 to 100 of how much it must match. text match percentage threshold.
	;and save it.

	Local $sAnswer = InputBox("Text On Screen Trigger", "What text would you like to look for?", "Mars, Bringer of War", "")
	if $sAnswer <> "" then
		local $mynewtext = $sAnswer
	else
		return
	endif

	Local $sAnswer = InputBox("Text On Screen Trigger", "What text-match percentage threshold would you like to set? (1 to 100)", "75", "")
	if $sAnswer <> "" then
		local $percentagetext = $sAnswer
	else
		return
	endif

	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path
	local $i, $sFile, $totrig
	While 1
		Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
		$totrig = "ScoreStringAgainstTesseract('" & $mynewtext & "', " & $iX1 & ", " & $iY1 & ", " & $iX2 & ", " & $iY2 & ", " & $percentagetext & ")"
		AddToTrigger($totrig, "the text '" & $mynewtext & "' is found within (" & $iX1 & ", " & $iY1 & ") to (" & $iX2 & ", " & $iY2 & ") at a required accuracy score of " & $percentagetext & "%")
		ExitLoop
	WEnd

	;example of how to test this when running:
	;$s1 = "abcdefghijklmnop"
	;$s2 = "abcdefghijklmno"
	;msgbox(64,"",
	;if GetAllLCS(savedtext,SaveScreen($throwaway, $left = 0, $top = 0, $right = -1, $bottom = -1, $scrub = false))*100 > $requiredscore then
EndFunc

Func TextOnScreenVariableTrigger()

	Local $sAnswer = InputBox("Text On Screen Trigger", "What variable would you like to look for on screen? (0-31)", "1", "")
	if $sAnswer <> "" then
		local $mynewtext = $sAnswer
		local $myvar = "$uservar" & $sAnswer
	else
		return
	endif

	Local $sAnswer = InputBox("Text On Screen Trigger", "What text-match percentage threshold would you like to set? (1 to 100)", "75", "")
	if $sAnswer <> "" then
		local $percentagetext = $sAnswer
	else
		return
	endif

	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path
	local $i, $sFile, $totrig
	While 1
		Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
		$totrig = "ScoreStringAgainstTesseract(" & "$uservar" & $sAnswer & ", " & $iX1 & ", " & $iY1 & ", " & $iX2 & ", " & $iY2 & ", " & $percentagetext & ")"
		AddToTrigger($totrig, "the variable " & $mynewtext & " is found within (" & $iX1 & ", " & $iY1 & ") to (" & $iX2 & ", " & $iY2 & ") at a required accuracy score of " & $percentagetext & "%")
		ExitLoop
	WEnd
EndFunc


Func TextOnScreenClipTrigger()

	local $mynewtext = "ClipGet()"
	Local $sAnswer = InputBox("Text On Screen Trigger", "What text-match percentage threshold would you like to set? (1 to 100)", "75", "")
	if $sAnswer <> "" then
		local $percentagetext = $sAnswer
	else
		return
	endif

	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path
	local $i, $sFile, $totrig
	While 1
		Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
		$totrig = "ScoreStringAgainstTesseract(" & $mynewtext & ", " & $iX1 & ", " & $iY1 & ", " & $iX2 & ", " & $iY2 & ", " & $percentagetext & ")"
		AddToTrigger($totrig, "text in the clipboard is found within (" & $iX1 & ", " & $iY1 & ") to (" & $iX2 & ", " & $iY2 & ") at a required accuracy score of " & $percentagetext & "%")
		ExitLoop
	WEnd
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


Func ClipboardBehavior()
	Local $hChild12 = GUICreate("Manage Clipboard Behavior", 400, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("What would you like to do with the Clipboard?", 20, 20, 360, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button121 = GUICtrlCreateButton("Copy Text", 20, 80, 160, 40)
	local $button122 = GUICtrlCreateButton("Paste Text", 220, 80, 160, 40)
	local $button123 = GUICtrlCreateButton("Copy Keystrokes", 20, 140, 160, 40)
	local $button124 = GUICtrlCreateButton("Paste Keystrokes", 220, 140, 160, 40)

	GUISetState()

	local $totrig = ""
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild12)
				ExitLoop
			Case $button121
				ClipCopyBehavior()
				GUIDelete($hChild12)
				ExitLoop
			Case $button122
				ClipPasteBehavior()
				GUIDelete($hChild12)
				ExitLoop
			Case $button123
				$totrig = "send " & "^c"
				AddToBehavior($totrig)
				GUIDelete($hChild12)
				ExitLoop
			Case $button124
				$totrig = "send " & "^v"
				AddToBehavior($totrig)
				GUIDelete($hChild12)
				ExitLoop
		EndSwitch
	WEnd
EndFunc


Func ClipCopyBehavior()
	Local $sAnswer = InputBox("Clipboard Behavior", "What text should be put onto the Clipboard?", "Planet Jupiter", "")
	if $sAnswer <> "" then
		local $totrig = "copy " & $sAnswer
		AddToBehavior($totrig)
	endif
EndFunc


Func ClipPasteBehavior()
	local $totrig = "paste"
	AddToBehavior($totrig)
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



Func WaitBehavior()
	Local $sAnswer = InputBox("Wait Behavior", "For how long should ReflexMem do nothing in miliseconds? (Max = 10000)", "1000", "")
	if $sAnswer <> "" then
		if StringIsDigit($sAnswer) And $sAnswer <= 10000 And $sAnswer >= 1 then
			local $totrig = "sleep " & $sAnswer
			AddToBehavior($totrig)
		else
			msgbox(64, "Wait Behavior", "The wait time must be a number from 1 to 10000 without punctuation.")
		endif

	endif
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



Func SendKeysBehavior()
	Local $hChild7 = GUICreate("Key Send Behavior", 400, 640, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("Which key(s) should be pressed?", 20, 20, 360, 40)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button71 = GUICtrlCreateButton("Text", 20, 60, 160, 30)
	local $button72 = GUICtrlCreateButton("Enter", 220, 60, 160, 30)
	local $button73 = GUICtrlCreateButton("Space", 20, 100, 160, 30)
	local $button74 = GUICtrlCreateButton("Shift", 220, 100, 160, 30)
	local $button75 = GUICtrlCreateButton("Alt", 20, 140, 160, 30)
	local $button76 = GUICtrlCreateButton("Control", 220, 140, 160, 30)
	local $button77 = GUICtrlCreateButton("Left", 20, 180, 160, 30)
	local $button78 = GUICtrlCreateButton("Right", 220, 180, 160, 30)
	local $button79 = GUICtrlCreateButton("Up", 20, 220, 160, 30)
	local $button710 = GUICtrlCreateButton("Down", 220, 220, 160, 30)
	local $button711 = GUICtrlCreateButton("Tab", 20, 260, 160, 30)
	local $button712 = GUICtrlCreateButton("Escape", 220,260, 160, 30)
	local $button713 = GUICtrlCreateButton("Page Up", 20, 300, 160, 30)
	local $button714 = GUICtrlCreateButton("Page Down", 220, 300, 160, 30)
	local $button715 = GUICtrlCreateButton("Home", 20, 340, 160, 30)
	local $button716 = GUICtrlCreateButton("End", 220, 340, 160, 30)
	local $button717 = GUICtrlCreateButton("Delete", 20, 380, 160, 30)
	local $button718 = GUICtrlCreateButton("Backspace", 220, 380, 160, 30)
	local $button719 = GUICtrlCreateButton("Caps Lock", 20, 420, 160, 30)
	local $button720 = GUICtrlCreateButton("Num Lock", 220, 420, 160, 30)
	local $button721 = GUICtrlCreateButton("Print Screen", 20, 460, 160, 30)
	local $button722 = GUICtrlCreateButton("Windows Key", 220, 460, 160, 30)
	local $button723 = GUICtrlCreateButton("Insert", 20, 500, 160, 30)
	local $button724 = GUICtrlCreateCheckbox("Shift + Other Keys", 220, 500, 160, 30)
	local $button725 = GUICtrlCreateCheckbox("Alt + Other Keys", 20, 540, 160, 30)
	local $button726 = GUICtrlCreateCheckbox("Control + Other Keys", 220, 540, 160, 30)
	local $button727 = GUICtrlCreateButton("Special Symbols ({}^+#!)", 20, 580, 160, 30)
	local $button728 = GUICtrlCreateButton("F Keys", 220, 580, 160, 30)
	GUISetState(@SW_SHOW, $hChild7)

	local $totrig = ""
	Local $sAnswer = ""
	local $Shift = false
	local $alt = false
	local $control = false

	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild7)
				ExitLoop
			Case $button71
				$sAnswer = InputBox("Send Keys Behavior", "What text should be entered? (Letters, numbers, single-spaces and these symbols allowed: @$%&*()-_=~/|\[];:?)", "Hello World?", "")
				$sAnswer = StringReplace($sAnswer, "{", "")
				$sAnswer = StringReplace($sAnswer, "}", "")
				$sAnswer = StringReplace($sAnswer, "^", "")
				$sAnswer = StringReplace($sAnswer, "+", "")
				$sAnswer = StringReplace($sAnswer, "!", "")
				$sAnswer = StringReplace($sAnswer, "#", "")
				$totrig = $sAnswer
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button72
				$totrig = "{ENTER}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button73
				$totrig = "{SPACE}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button74
				$totrig = "{LSHIFT}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button75
				$totrig = "{ALT}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button76
				$totrig = "{LCTRL}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button77
				$totrig = "{LEFT}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button78
				$totrig = "{RIGHT}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button79
				$totrig = "{UP}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button710
				$totrig = "{DOWN}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button711
				$totrig = "{TAB}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button712
				$totrig = "{ESCAPE}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button713
				$totrig = "{PGUP}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button714
				$totrig = "{PGDN}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button715
				$totrig = "{HOME}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button716
				$totrig = "{END}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button717
				$totrig = "{DELETE}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button718
				$totrig = "{BACKSPACE}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button719
				$totrig = "{CAPSLOCK}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button720
				$totrig = "{NUMLOCK}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button721
				$totrig = "{PRINTSCREEN}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button722
				$totrig = "{LWIN}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button723
				$totrig = "{INSERT}"
				addSendToBehavior($shift, $alt, $control, $totrig)
				GUIDelete($hChild7)
				ExitLoop
			Case $button724 ;shift
				If _IsChecked($button724) Then
					$shift = true
				Else
				  $shift = false
				EndIf
			Case $button725 ;alt
				If _IsChecked($button725) Then
					$alt = true
				Else
					$alt = false
				EndIf
			Case $button726 ;Control
				If _IsChecked($button726) Then
					$control = true
				Else
					$control = false
				EndIf
			Case $button727 ;Special keys
				$hChild7a = GUICreate("Insert special keys", 400, 280, -1, -1, -1, -1, $hChild7)
				GUICtrlCreateLabel("Which special symbol should be sent?", 20, 20, 360, 40)
				GUICtrlSetStyle(-1, $SS_CENTER)
				$button7a1 = GUICtrlCreateButton("{", 20, 80, 160, 40)
				$button7a2 = GUICtrlCreateButton("}", 220, 80, 160, 40)
				$button7a3 = GUICtrlCreateButton("^", 20, 140, 160, 40)
				$button7a4 = GUICtrlCreateButton("+", 220, 140, 160, 40)
				$button7a5 = GUICtrlCreateButton("#", 20, 200, 160, 40)
				$button7a6 = GUICtrlCreateButton("!", 220, 200, 160, 40)
				GUISetState()
				local $totrig = ""
				While 1
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a1
							$totrig = "{{}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a2
							$totrig = "{}}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a3
							$totrig = "{^}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a4
							$totrig = "{+}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a5
							$totrig = "{#}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a6
							$totrig = "{!}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
					EndSwitch
				WEnd
				GUIDelete($hChild7)
				ExitLoop
			Case $button728 ;F keys
				$hChild7a = GUICreate("Insert Function keys", 400, 440, -1, -1, -1, -1, $hChild7)
				GUICtrlCreateLabel("Which F key should be sent?", 20, 20, 360, 40)
				GUICtrlSetStyle(-1, $SS_CENTER)
				$button7a1 = GUICtrlCreateButton("F1", 20, 80, 160, 40)
				$button7a2 = GUICtrlCreateButton("F2", 220, 80, 160, 40)
				$button7a3 = GUICtrlCreateButton("F3", 20, 140, 160, 40)
				$button7a4 = GUICtrlCreateButton("F4", 220, 140, 160, 40)
				$button7a5 = GUICtrlCreateButton("F5", 20, 200, 160, 40)
				$button7a6 = GUICtrlCreateButton("F6", 220, 200, 160, 40)
				$button7a7 = GUICtrlCreateButton("F7", 20, 260, 160, 40)
				$button7a8 = GUICtrlCreateButton("F8", 220, 260, 160, 40)
				$button7a9 = GUICtrlCreateButton("F9", 20, 320, 160, 40)
				$button7a10 = GUICtrlCreateButton("F10", 220, 320, 160, 40)
				$button7a11 = GUICtrlCreateButton("F11", 20, 380, 160, 40)
				$button7a12 = GUICtrlCreateButton("F12", 220, 380, 160, 40)
				GUISetState()
				local $totrig = ""
				While 1
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a1
							$totrig = "{F1}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a2
							$totrig = "{F2}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a3
							$totrig = "{F3}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a4
							$totrig = "{F4}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a5
							$totrig = "{F5}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a6
							$totrig = "{F6}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a7
							$totrig = "{F7}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a8
							$totrig = "{F8}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a9
							$totrig = "{F9}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a10
							$totrig = "{F10}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a11
							$totrig = "{F11}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
						Case $button7a12
							$totrig = "{F12}"
							addSendToBehavior($shift, $alt, $control, $totrig)
							GUIDelete($hChild7a)
							ExitLoop
					EndSwitch
				WEnd
				GUIDelete($hChild7)
				ExitLoop
		EndSwitch
	WEnd
EndFunc


Func addSendToBehavior($shift, $alt, $control, $data)
;HotKeySet("^a", "GetPos") ;control
;HotKeySet("+a", "GetPos") ;  Shift
;HotKeySet("!a", "GetPos") ;alt
	local $totrig = ""
	if $shift then
		$totrig = $totrig & "+"
	endif
	if $alt then
		$totrig = $totrig & "!"
	endif
	if $control then
		$totrig = $totrig & "^"
	endif
	$totrig = "send " & $totrig & $data

	AddToBehavior($totrig)
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func KeyDownBehavior()
	Local $hChild8 = GUICreate("Key Down Behavior", 400, 360, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("Which key(s) should be pressed and held down?", 20, 20, 360, 40)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button81 = GUICtrlCreateButton("Single Letter or Number", 20, 60, 160, 30)
	local $button82 = GUICtrlCreateButton("Enter", 220, 60, 160, 30)
	local $button83 = GUICtrlCreateButton("Space", 20, 100, 160, 30)
	local $button84 = GUICtrlCreateButton("Shift", 220, 100, 160, 30)
	local $button85 = GUICtrlCreateButton("Alt", 20, 140, 160, 30)
	local $button86 = GUICtrlCreateButton("Control", 220, 140, 160, 30)
	local $button87 = GUICtrlCreateButton("Left", 20, 180, 160, 30)
	local $button88 = GUICtrlCreateButton("Right", 220, 180, 160, 30)
	local $button89 = GUICtrlCreateButton("Up", 20, 220, 160, 30)
	local $button810 = GUICtrlCreateButton("Down", 220, 220, 160, 30)
	local $button811 = GUICtrlCreateButton("Delete", 20, 260, 160, 30)
	local $button812 = GUICtrlCreateButton("Backspace", 220, 260, 160, 30)
	local $button813 = GUICtrlCreateButton("Tab", 20, 300, 160, 30)
	local $button814 = GUICtrlCreateButton("F Keys", 220, 300, 160, 30)
	GUISetState()

	local $totrig = ""
	Local $sAnswer = ""
	local $Shift = false
	local $alt = false
	local $control = false

	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild8)
				ExitLoop
			Case $button81
				$sAnswer = InputBox("Key Down Behavior", "What single key should be pressed and held down? (Letters, numbers and these symbols allowed: @$%&*()-_=~/|\[];:?)", "a", "")
				$sAnswer = StringReplace($sAnswer, "{", "")
				$sAnswer = StringReplace($sAnswer, "}", "")
				$sAnswer = StringReplace($sAnswer, "^", "")
				$sAnswer = StringReplace($sAnswer, "+", "")
				$sAnswer = StringReplace($sAnswer, "!", "")
				$sAnswer = StringReplace($sAnswer, "#", "")
				$totrig = "send {" & StringLeft($sAnswer, 1) & " down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button82
				$totrig = "send {ENTER down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button83
				$totrig = "send {SPACE down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button84
				$totrig = "send {LSHIFT down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button85
				$totrig = "send {ALT down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button86
				$totrig = "send {LCTRL down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button87
				$totrig = "send {LEFT down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button88
				$totrig = "send {RIGHT down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button89
				$totrig = "send {UP down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button810
				$totrig = "send {DOWN down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button811
				$totrig = "send {DELETE down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button812
				$totrig = "send {BACKSPACE down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button813
				$totrig = "send {TAB down}"
				AddToBehavior($totrig)
				GUIDelete($hChild8)
				ExitLoop
			Case $button814 ;F keys
				$hChild8a = GUICreate("Key Down Function keys", 400, 440, -1, -1, -1, -1, $hChild8)
				GUICtrlCreateLabel("Which F key should be pressed and held down?", 20, 20, 360, 40)
				GUICtrlSetStyle(-1, $SS_CENTER)
				$button8a1 = GUICtrlCreateButton("F1", 20, 80, 160, 40)
				$button8a2 = GUICtrlCreateButton("F2", 220, 80, 160, 40)
				$button8a3 = GUICtrlCreateButton("F3", 20, 140, 160, 40)
				$button8a4 = GUICtrlCreateButton("F4", 220, 140, 160, 40)
				$button8a5 = GUICtrlCreateButton("F5", 20, 200, 160, 40)
				$button8a6 = GUICtrlCreateButton("F6", 220, 200, 160, 40)
				$button8a7 = GUICtrlCreateButton("F7", 20, 260, 160, 40)
				$button8a8 = GUICtrlCreateButton("F8", 220, 260, 160, 40)
				$button8a9 = GUICtrlCreateButton("F9", 20, 320, 160, 40)
				$button8a10 = GUICtrlCreateButton("F10", 220, 320, 160, 40)
				$button8a11 = GUICtrlCreateButton("F11", 20, 380, 160, 40)
				$button8a12 = GUICtrlCreateButton("F12", 220, 380, 160, 40)
				GUISetState()
				local $totrig = ""
				While 1
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($hChild7a)
							ExitLoop
						Case $button8a1
							$totrig = "send {F1 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a2
							$totrig = "send {F2 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a3
							$totrig = "send {F3 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a4
							$totrig = "send {F4 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a5
							$totrig = "send {F5 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a6
							$totrig = "send {F6 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a7
							$totrig = "send {F7 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a8
							$totrig = "send {F8 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a9
							$totrig = "send {F9 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a10
							$totrig = "send {F10 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a11
							$totrig = "send {F11 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
						Case $button8a12
							$totrig = "send {F12 down}"
							AddToBehavior($totrig)
							GUIDelete($hChild8a)
							ExitLoop
					EndSwitch
				WEnd
				GUIDelete($hChild8)
				ExitLoop
		EndSwitch
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


Func KeyUpBehavior()
	Local $hChild9 = GUICreate("Key Up Behavior", 400, 360, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("Which key(s) should be unpressed?", 20, 20, 360, 40)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button91 = GUICtrlCreateButton("Single Letter or Number", 20, 60, 160, 30)
	local $button92 = GUICtrlCreateButton("Enter", 220, 60, 160, 30)
	local $button93 = GUICtrlCreateButton("Space", 20, 100, 160, 30)
	local $button94 = GUICtrlCreateButton("Shift", 220, 100, 160, 30)
	local $button95 = GUICtrlCreateButton("Alt", 20, 140, 160, 30)
	local $button96 = GUICtrlCreateButton("Control", 220, 140, 160, 30)
	local $button97 = GUICtrlCreateButton("Left", 20, 180, 160, 30)
	local $button98 = GUICtrlCreateButton("Right", 220, 180, 160, 30)
	local $button99 = GUICtrlCreateButton("Up", 20, 220, 160, 30)
	local $button910 = GUICtrlCreateButton("Down", 220, 220, 160, 30)
	local $button911 = GUICtrlCreateButton("Delete", 20, 260, 160, 30)
	local $button912 = GUICtrlCreateButton("Backspace", 220, 260, 160, 30)
	local $button913 = GUICtrlCreateButton("Tab", 20, 300, 160, 30)
	local $button914 = GUICtrlCreateButton("F Keys", 220, 300, 160, 30)
	GUISetState()

	local $totrig = ""
	Local $sAnswer = ""
	local $Shift = false
	local $alt = false
	local $control = false

	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild9)
				ExitLoop
			Case $button91
				$sAnswer = InputBox("Key Up Behavior", "What single key should be lifted up? (Letters, numbers and these symbols allowed: @$%&*()-_=~/|\[];:?)", "a", "")
				$sAnswer = StringReplace($sAnswer, "{", "")
				$sAnswer = StringReplace($sAnswer, "}", "")
				$sAnswer = StringReplace($sAnswer, "^", "")
				$sAnswer = StringReplace($sAnswer, "+", "")
				$sAnswer = StringReplace($sAnswer, "!", "")
				$sAnswer = StringReplace($sAnswer, "#", "")
				$totrig = "send {" & StringLeft($sAnswer, 1) & " up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button92
				$totrig = "send {ENTER up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button93
				$totrig = "send {SPACE up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button94
				$totrig = "send {LSHIFT up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button95
				$totrig = "send {ALT up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button96
				$totrig = "send {LCTRL up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button97
				$totrig = "send {LEFT up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button98
				$totrig = "send {RIGHT up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button99
				$totrig = "send {UP up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button910
				$totrig = "send {DOWN up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button911
				$totrig = "send {DELETE up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button912
				$totrig = "send {BACKSPACE up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button913
				$totrig = "send {TAB up}"
				AddToBehavior($totrig)
				GUIDelete($hChild9)
				ExitLoop
			Case $button914 ;F keys
				$hChild9a = GUICreate("Key Up Function keys", 400, 440, -1, -1, -1, -1, $hChild9)
				GUICtrlCreateLabel("Which F key should be unpressed?", 20, 20, 360, 40)
				GUICtrlSetStyle(-1, $SS_CENTER)
				$button9a1 = GUICtrlCreateButton("F1", 20, 80, 160, 40)
				$button9a2 = GUICtrlCreateButton("F2", 220, 80, 160, 40)
				$button9a3 = GUICtrlCreateButton("F3", 20, 140, 160, 40)
				$button9a4 = GUICtrlCreateButton("F4", 220, 140, 160, 40)
				$button9a5 = GUICtrlCreateButton("F5", 20, 200, 160, 40)
				$button9a6 = GUICtrlCreateButton("F6", 220, 200, 160, 40)
				$button9a7 = GUICtrlCreateButton("F7", 20, 260, 160, 40)
				$button9a8 = GUICtrlCreateButton("F8", 220, 260, 160, 40)
				$button9a9 = GUICtrlCreateButton("F9", 20, 320, 160, 40)
				$button9a10 = GUICtrlCreateButton("F10", 220, 320, 160, 40)
				$button9a11 = GUICtrlCreateButton("F11", 20, 380, 160, 40)
				$button9a12 = GUICtrlCreateButton("F12", 220, 380, 160, 40)
				GUISetState()
				local $totrig = ""
				While 1
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($hChild7a)
							ExitLoop
						Case $button9a1
							$totrig = "send {F1 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a2
							$totrig = "send {F2 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a3
							$totrig = "send {F3 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a4
							$totrig = "send {F4 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a5
							$totrig = "send {F5 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a6
							$totrig = "send {F6 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a7
							$totrig = "send {F7 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a8
							$totrig = "send {F8 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a9
							$totrig = "send {F9 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a10
							$totrig = "send {F10 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a11
							$totrig = "send {F11 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
						Case $button9a12
							$totrig = "send {F12 up}"
							AddToBehavior($totrig)
							GUIDelete($hChild9a)
							ExitLoop
					EndSwitch
				WEnd
				GUIDelete($hChild9)
				ExitLoop
		EndSwitch
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

Func ManageMouseMoveBehavior()

	local $hMain_GUI = GUICreate("Mouse Move Behavior",600, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("How would you like the mouse to move?", 20, 20, 560, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $hmButton1 = GUICtrlCreateButton("by X and Y Coordinates", 20, 80, 160, 60)
	local $hmButton2 = GUICtrlCreateButton("by X and Y Variables", 220, 80, 160, 60)
	local $hmButton3 = GUICtrlCreateButton("to an Image on the Screen", 420, 80, 160, 60)
	GUISetState()

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton1
				MouseMoveLocation()
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton2
				MouseMoveVariables()
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton3
				MouseMoveImage()
				GUIDelete($hMain_GUI)
				ExitLoop
			EndSwitch
	WEnd
EndFunc


Func MouseMoveLocation()
	$msgbox = msgbox(1, "Mouse Move Behavior", "Click ok, then click on the screen at the location you'd like the mouse to move")
	if $msgbox == 1 then
		Local $aPos
		While 1
		  $aPos = MouseGetPos()
			ToolTip("X: " & $aPos[0] & "  Y: " & $aPos[1])
		  If _IsPressed("01") Then
				$aPos = MouseGetPos()
		    ExitLoop
		  endIf
		WEnd
		Local $xcord = InputBox("Mouse Move Behavior", "What X coordinate would you like the mouse to move to?", $aPos[0], "")
		Local $ycord = InputBox("Mouse Move Behavior", "What X coordinate would you like the mouse to move to?", $aPos[1], "")
		local $totrig = "mouse " & $xcord & " " & $ycord
		MouseMoveSetSpeed($totrig)
	endif
EndFunc


Func MouseMoveVariables()
	Local $xcord
	Local $ycord
	Local $sAnswer = InputBox("Mouse Move by Variable Behavior", "Which variable is the X coordinate? (0 to 31)", "1", "")
	if $sAnswer <> "" then
		$xcord = "$uservar" & $sAnswer
		Local $sAnswer = InputBox("Mouse Move by Variable Behavior", "Which variable is the Y coordinate? (0 to 31)", "1", "")
		if $sAnswer <> "" then
			$ycord = "$uservar" & $sAnswer
			$totrig = "mouse " & $xcord & " " & $ycord
			MouseMoveSetSpeed($totrig)
		endif
	endif
EndFunc


Func MouseMoveImage()
	;$hImage = dialog box or screen
	;_ImageSearchArea('C:\Users\jmiller.ADS-WCF\AppData\Roaming\ReflexMem\scripts\images\2.bmp',1,0,0,3440,1440, $X1, $Y1, 25)

	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path

	; Create GUI
	local $hMain_GUI = GUICreate("Mouse Move to Image Behavior", 380, 80, -1, -1, -1, -1, $hGUI)
	local $hRect_Button   = GUICtrlCreateButton("Capture Image On Screen",  20, 20, 160, 40)
	local $sFile_Button   = GUICtrlCreateButton("Select Image From File",  200, 20, 160, 40)
	GUISetState()

	local $i, $sFile
	While 1
    Switch GUIGetMsg()
      Case $GUI_EVENT_CLOSE
				GUIDelete($hMain_GUI)
        ExitLoop
      Case $hRect_Button
	      GUISetState(@SW_HIDE, $hMain_GUI)
	      Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
	      ; Capture selected area
				$i = 0
				While FileExists(GetScriptsPath("images") & $i & ".bmp")
					$i = $i + 1
				WEnd
	      $sBMP_Path = GetScriptsPath("images") & $i & ".bmp"
	    	_ScreenCapture_Capture($sBMP_Path, $iX1, $iY1, $iX2, $iY2, False)
	      GUISetState(@SW_SHOW, $hMain_GUI)
	      ; Display image
	      ;$hBitmap_GUI = GUICreate("Selected Rectangle", $iX2 - $iX1 + 1, $iY2 - $iY1 + 1, 100, 100)
	      ;$hPic = GUICtrlCreatePic(@ScriptDir & "\Rect.bmp", 0, 0, $iX2 - $iX1 + 1, $iY2 - $iY1 + 1)
	      ;GUISetState()
				GUIDelete($hMain_GUI)
				GetAreaImageScreenBehavior($sBMP_Path)
        ExitLoop
			Case $sFile_Button
				local $sFile = FileOpenDialog("Choose Image...", @DesktopCommonDir, "All (*.*)")
				if $sFile == "" then
					GUIDelete($hMain_GUI)
					ExitLoop
				endif
				GUIDelete($hMain_GUI)
				GetAreaImageScreenBehavior($sFile)
        ExitLoop

	    EndSwitch

	WEnd

EndFunc


Func GetAreaImageScreenBehavior($imagefile)

	Local $acc = InputBox("Move Mouse to Image Behavior", "how tolerant do you want this image to be? (0 = exact image, 255 = fully tolerant)", "25", "")
	if @error == 1 then
		return
	endif
	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path
	; Create GUI
	local $hMain_GUI = GUICreate("Move Mouse to Image Behavior", 380, 80, -1, -1, -1, -1, $hGUI)
	local $sRect_Button   = GUICtrlCreateButton("Select Region on Screen",  20, 20, 160, 40)
	local $sFull_Button   = GUICtrlCreateButton("Search Full Screen",  200, 20, 160, 40)

	GUISetState()

	local $totrig

	_GDIPlus_Startup()
		Local $hImage = _GDIPlus_ImageLoadFromFile($imagefile)
			If @error Then
			    MsgBox(16, "Error", "Does the file exist?")
			    Exit 1
			EndIf
			local $xh = _GDIPlus_ImageGetHeight($hImage)
			local $xw = _GDIPlus_ImageGetWidth($hImage)
		_GDIPlus_ImageDispose($hImage)
	_GDIPlus_ShutDown()


	While 1
    Switch GUIGetMsg()
      Case $GUI_EVENT_CLOSE
				GUIDelete($hMain_GUI)
        ExitLoop
      Case $sRect_Button
	      GUISetState(@SW_HIDE, $hMain_GUI)
	      Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
	      ; Capture selected area
	      GUISetState(@SW_SHOW, $hMain_GUI)
				$totrig = "mouseimage " & $imagefile & " " & $iX1 & " " & $iY1 & " " & $iX2 & " " & $iY2 & " " & $acc
				MouseMoveSetSpeed($totrig)
				GUIDelete($hMain_GUI)
        ExitLoop
			Case $sFull_Button
				$totrig = "mouseimage " & $imagefile & " " & "0" & " " & "0" & " " & @DesktopWidth & " " & @DesktopHeight & " " & $acc
				MouseMoveSetSpeed($totrig)
				GUIDelete($hMain_GUI)
        ExitLoop
	    EndSwitch
	WEnd
EndFunc


Func MouseMoveSetSpeed($totrig)
	Local $sAnswer = InputBox("Mouse Move Set Speed Behavior", "At what speed should the mouse move? (0 = instant .... 100 = slow)", "10", "")
	if $sAnswer <> "" then
		$totrig = $totrig & " " & $sAnswer
		AddToBehavior($totrig)
	else
		$totrig = $totrig & " 10"
		AddToBehavior($totrig)
	endif
EndFunc














Func MessageBoxBehavior()
	Local $title = InputBox("Display Message Behavior", "What would you like the title of the message to be?", "Alert" , "")
	if $title <> "" then
		Local $message = InputBox("Display Message Behavior", "What would you like the message to be?", "Hello World!", "")
		if $message <> "" then
			local $totrig = "message " & $title & " " & $message
			AddToBehavior($totrig)
		else
			msgbox(64, "Display Message Behavior", "You must include both a title and a message to successfully create this Behavior")
		endif
	endif
EndFunc



Func TextOnScreenBehavior()

	msgbox(64, "Get Text On Screen Behavior", "This feature is only supported on paid versions of ReflexMem.")
	msgbox(64, "Get Text On Screen Behavior", "Press ok then select the region of the screen where the text will be.")

	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path
	local $throwaway, $totrig
	While 1
		Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
		$totrig = "gettext " & $iX1 & " " & $iY1 & " " & $iX2 & " " & $iY2
		AddToBehavior($totrig)
		ExitLoop
	WEnd
EndFunc



Func ManageReflexMemBehavior()
	Local $hChild12 = GUICreate("Manage ReflexMem Behavior", 600, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("What would you like ReflexMem to do?", 20, 20, 560, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button121 = GUICtrlCreateButton("Ignore Triggers", 20, 80, 160, 60)
	local $button122 = GUICtrlCreateButton("Observe Triggers", 220, 80, 160, 60)
	local $button123 = GUICtrlCreateButton("Exit ReflexMem", 420, 80, 160, 60)
	GUISetState()

	local $totrig = ""
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild12)
				ExitLoop
			Case $button121
				PauseReflexMemBehavior()
				GUIDelete($hChild12)
				ExitLoop
			Case $button122
				UnPauseReflexMemBehavior()
				GUIDelete($hChild12)
				ExitLoop
			Case $button122
				ExitReflexMemBehavior()
				GUIDelete($hChild12)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func PauseReflexMemBehavior()
	;Msgbox(64, "Pause ReflexMem Behavior", "Pause ReflexMem Behavior added successfully.")
	local $totrig = "pause"
	AddToBehavior($totrig)
EndFunc

Func UnPauseReflexMemBehavior()
	;Msgbox(64, "Pause ReflexMem Behavior", "UnPause ReflexMem Behavior added successfully.")
	local $totrig = "unpause"
	AddToBehavior($totrig)
EndFunc

Func ExitReflexMemBehavior()
	;Msgbox(64, "Pause ReflexMem Behavior", "Exit ReflexMem Behavior added successfully.")
	local $totrig = "exit"
	AddToBehavior($totrig)
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func MouseClickBehavior()
	Local $hChild11 = GUICreate("Mouse Click Behavior", 400, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("Which button should be cliked?", 20, 20, 360, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button111 = GUICtrlCreateButton("Primary (left)", 20, 80, 160, 60)
	local $button112 = GUICtrlCreateButton("Secondary (right)", 220, 80, 160, 60)
	GUISetState()

	local $totrig = ""
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild11)
				ExitLoop
			Case $button111
				$totrig = "click primary"
				AddToBehavior($totrig)
				GUIDelete($hChild11)
				ExitLoop
			Case $button112
				$totrig = "click secondary"
				AddToBehavior($totrig)
				GUIDelete($hChild11)
				ExitLoop
		EndSwitch
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


Func MouseWheelBehavior()
	Local $hChild12 = GUICreate("Mouse Wheel Behavior", 400, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("Which direction should mouse wheel scroll?", 20, 20, 360, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button121 = GUICtrlCreateButton("Up", 20, 80, 160, 60)
	local $button122 = GUICtrlCreateButton("Down", 220, 80, 160, 60)
	GUISetState()

	local $totrig = ""
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild12)
				ExitLoop
			Case $button121
				$totrig = "wheel up"
				AddToBehavior($totrig)
				GUIDelete($hChild12)
				ExitLoop
			Case $button122
				$totrig = "wheel down"
				AddToBehavior($totrig)
				GUIDelete($hChild12)
				ExitLoop
		EndSwitch
	WEnd
EndFunc


Func ManageVariableBehavior()
	Local $hChild12 = GUICreate("Manage Variable Behavior", 400, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("Would you like to View or Modify a variable?", 20, 20, 360, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button121 = GUICtrlCreateButton("View", 20, 80, 160, 60)
	local $button122 = GUICtrlCreateButton("Modify", 220, 80, 160, 60)
	GUISetState()

	local $totrig = ""
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild12)
				ExitLoop
			Case $button121
				GetVariableBehavior()
				GUIDelete($hChild12)
				ExitLoop
			Case $button122
				ModifyVariableBehavior()
				GUIDelete($hChild12)
				ExitLoop
		EndSwitch
	WEnd
EndFunc



Func ModifyVariableBehavior() ;must put a escape chaaracter before and apostrophese \' ;
	Local $sAnswer = InputBox("Modify Variable Behavior", "Which variable? (0 to 31)", "1", "")
	if $sAnswer <> "" then
		local $totrig = "setvar " & $sAnswer & " "
	endif
	local $hMain_GUI = GUICreate("Modify Variable Behavior",600, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("What should it contain?", 20, 20, 560, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $hmButton1 = GUICtrlCreateButton("a Value", 20, 80, 160, 60)
	local $hmButton2 = GUICtrlCreateButton("a Variable", 220, 80, 160, 60)
	local $hmButton3 = GUICtrlCreateButton("the Clipboard", 420, 80, 160, 60)
	GUISetState()
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton1
				Local $sAnswer = InputBox("Modify Variable Behavior", "What should it contain now? (don't use '')", "we feel a little better now", "")
				if $sAnswer <> "" then
					$totrig = $totrig & "'" & $sAnswer & "'"
					AddToBehavior($totrig)
				endif
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton2
				Local $sAnswer = InputBox("Modify Variable Behavior", "Which variable should this variable match? (mathmatical opperators allowed such as 1+1)", "1", "")
				if $sAnswer <> "" then
					$totrig = $totrig & "$uservar" & $sAnswer
					AddToBehavior($totrig)
				endif
				GUIDelete($hMain_GUI)
				ExitLoop
			Case $hmButton3
				$totrig = $totrig & "ClipGet()"
				AddToBehavior($totrig)
				GUIDelete($hMain_GUI)
				ExitLoop
			EndSwitch
	WEnd
EndFunc


Func GetVariableBehavior() ;must put a escape chaaracter before and apostrophese \' ;
	Local $sAnswer = InputBox("Get Variable Behavior", "Which variable? (0 to 31)", "1", "")
	Local $sAnswer1 = Msgbox(4,"Get Variable Behavior", "View variable in message box?")
	if $sAnswer1 == 6 then
		$sAnswer1 == "msg"
	elseif $sAnswer1 == 7 then
		$sAnswer1 == "nomsg"
		Local $sAnswer1 = Msgbox(4,"Get Variable Behavior", "Copy variable to clipboard?")
		if $sAnswer1 == 6 then
			$sAnswer1 == "clip"
		endif
		if $sAnswer1 == 7 then
			$sAnswer1 == "noclip"
		endif
	endif
	if $sAnswer <> "" And $sAnswer1 <> "" then
		local $totrig = "getvar " & $sAnswer & " " & $sAnswer1
		AddToBehavior($totrig)
	endif
EndFunc



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func ManageProgramsBehavior()
	Local $hChild12 = GUICreate("Manage Programs Behavior", 400, 200, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("Would you like to Run a Program or End a Program?", 20, 20, 360, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button121 = GUICtrlCreateButton("Run", 20, 80, 160, 60)
	local $button122 = GUICtrlCreateButton("End", 220, 80, 160, 60)
	GUISetState()

	local $totrig = ""
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild12)
				ExitLoop
			Case $button121
				RunProgramBehavior()
				GUIDelete($hChild12)
				ExitLoop
			Case $button122
				KillProgramBehavior()
				GUIDelete($hChild12)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func RunProgramBehavior()
	local $sFile = FileOpenDialog("Choose Program...", @TempDir, "All (*.*)")
	if $sFile == "" then
		return
	endif
	local $split = StringInStr($sFile, "\", 0, -1)
	local $program = stringright($sFile, StringLen($sFile)-$split)
	local $location = StringLeft($sFile, $split)


	Local $hChild14 = GUICreate("Run Program Behavior", 400, 220, -1, -1, -1, -1, $hGUI)
	GUICtrlCreateLabel("How should this program be run?", 20, 20, 360, 35)
	GUICtrlSetStyle(-1, $SS_CENTER)
	local $button141 = GUICtrlCreateButton("Maximized", 20, 80, 160, 40)
	local $button142 = GUICtrlCreateButton("Minimized", 220, 80, 160, 40)
	local $button143 = GUICtrlCreateButton("Hidden", 20, 140, 160, 40)
	local $button144 = GUICtrlCreateButton("No Preference", 220, 140, 160, 40)
	GUISetState()

	local $totrig = ""
	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hChild14)
				ExitLoop
			Case $button141
				$totrig = "run " & $program & " " & $location & " @SW_MAXIMIZE"
				AddToBehavior($totrig)
				GUIDelete($hChild14)
				ExitLoop
			Case $button142
				$totrig = "run " & $program & " " & $location & " @SW_MINIMIZE"
				AddToBehavior($totrig)
				GUIDelete($hChild14)
				ExitLoop
			Case $button143
				$totrig = "run " & $program & " " & $location & " @SW_HIDE"
				AddToBehavior($totrig)
				GUIDelete($hChild14)
				ExitLoop
			Case $button144
				$totrig = "run " & $program & " " & $location
				AddToBehavior($totrig)
				GUIDelete($hChild14)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func KillProgramBehavior()
	local $sFile = FileOpenDialog("Choose Program...", @TempDir, "All (*.*)")
	if $sFile == "" then
		return
	endif
	local $split = StringInStr($sFile, "\", 0, -1)
	local $program = stringright($sFile, StringLen($sFile)-$split)
	local $location = StringLeft($sFile, $split)
	$totrig = "kill " & $program
	AddToBehavior($totrig)
EndFunc

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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Save



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

	;save trigger text in if/filenumber.txt
  local $file = GetScriptsPath("if") & $triggerNumber & ".txt"
	local $filename = GetScriptsPath("names") & $triggerNumber & ".txt"
	FileWrite($filename, $triggerTextNames)

  If Not FileWrite($file, $triggerText) Then
    MsgBox($MB_SYSTEMMODAL, $triggerNumber, "couldn't write trigger")
    Return False
	else
		GUICtrlSetState($hButton16, $GUI_HIDE)
		sleep(1000)
		msgbox(64, "Trigger", "Successfully Saved")
	EndIf

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

	If Not FileWrite($file, $behaviorText) Then
		MsgBox($MB_SYSTEMMODAL, $triggerNumber, "couldn't write behavior")
		Return False
	else
		GUICtrlSetState($hButton17, $GUI_HIDE)
		sleep(1000)
		msgbox(64, "Behavior", "Successfully Saved")
	EndIf

EndFunc

LoadThenBypassIf()

Func WaitForIfInput()

	While 1
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hGUI)
				Exit
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
			;Case $hButton24
				;VariableEqualsTrigger()
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
				Exit
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
				Exit
			Case $hButton7
				SendKeysBehavior()
			Case $hButton8
				KeyDownBehavior()
			Case $hButton9
				KeyUpBehavior()
			Case $hButton10
				ManageMouseMoveBehavior()
			Case $hButton11
				MouseClickBehavior()
			Case $hButton12
				MouseWheelBehavior()
			Case $hButton13
				ClipboardBehavior()
			Case $hButton14
				ManageProgramsBehavior()
			Case $hButton18
				MessageBoxBehavior()
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




Func ReturnToMain()
	Run("reflexmem.exe")
	GUIDelete($hGUI)
	Exit
EndFunc


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
