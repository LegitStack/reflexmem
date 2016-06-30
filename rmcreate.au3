#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <File.au3>

Global $hGUI = GUICreate("ReflexMem Create", 600, 540, -1, -1)
Global $triggerText = ""
Global $triggerNumber = 0
Global $behaviorText = ""

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
	GUICtrlSetState($hButton16, $GUI_HIDE)
	GUICtrlSetState($hGroup, $GUI_HIDE)
	GUICtrlSetState($hLabel1, $GUI_HIDE)
EndFunc


Func CreateTriggers()

	Global $hGroup = GUICtrlCreateGroup("Triggers", 				20, 	10, 	280, 450)

	Global $hButton = GUICtrlCreateButton("Key is Pressed", 		35, 	35, 	250, 35)
	Global $hButton1 = GUICtrlCreateButton("Mouse is Clicked", 	35, 	80, 	250, 35)
	Global $hButton2 = GUICtrlCreateButton("Clipboard Contains",35, 	125, 	250, 35)
	Global $hButton3 = GUICtrlCreateButton("Window Exists", 		35, 	170, 	250, 35)
	Global $hButton4 = GUICtrlCreateButton("Date and Time is", 	35, 	215, 	250, 35)
	Global $hButton5 = GUICtrlCreateButton("Image on Screen", 	35, 	260, 	250, 35)
	Global $hButton6 = GUICtrlCreateButton("Text on Screen", 		35, 	305, 	250, 35)

	Global $hButton16 = GUICtrlCreateButton("Done With Triggers", 20, 475, 280, 50)
	GUICtrlSetFont(-1, 10)

	Global $hLabel1 = GUICtrlCreateLabel("", 330, 35, 240, 400)
	GUICtrlSetStyle(-1, $SS_CENTER)

	GUISetState()

EndFunc


Func CreateBehaviors()

	Global $hGroup1 = GUICtrlCreateGroup("Behaviors", 						310, 	10, 	280, 450)

	Global $hButton7 = GUICtrlCreateButton("Send Keys",						330, 	35, 	250, 35)
	Global $hButton8 = GUICtrlCreateButton("Key Down", 						330, 	80, 	250, 35)
	Global $hButton9 = GUICtrlCreateButton("Key Up", 							330, 	125, 	250, 35)
	Global $hButton10 = GUICtrlCreateButton("Move Mouse", 				330, 	170, 	250, 35)
	Global $hButton11 = GUICtrlCreateButton("Click Mouse", 				330, 	215, 	250, 35)
	Global $hButton12 = GUICtrlCreateButton("Scroll Mouse Wheel", 330, 	260, 	250, 35)
	Global $hButton13 = GUICtrlCreateButton("Copy Text", 					330, 	305, 	250, 35)
	Global $hButton14 = GUICtrlCreateButton("Run Program", 				330, 	350, 	250, 35)
	Global $hButton15 = GUICtrlCreateButton("Wait", 							330, 	395, 	250, 35)

	Global $hButton17 = GUICtrlCreateButton("Done With Behaviors", 	310, 	475, 	280, 50)
	GUICtrlSetFont(-1, 10)

	Global $hLabel = GUICtrlCreateLabel("", 35, 35, 240, 400)
	GUICtrlSetStyle(-1, $SS_CENTER)

	GUISetState()

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
			$data = "Move the mouse to a particular location on the screen." & @CRLF & @CRLF & "What X coordinate?" & @CRLF & "What Y coordinate?"
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
			$data = "Run a program." & @CRLF & @CRLF & "What is the program's name?" & @CRLF & "Where is it located?"
			if GUICtrlRead($hlabel) <> $data Then
				GUICtrlSetData($hlabel, $data)
			EndIf
		elseif $a[4] == $hButton15 Then
			$data = "Do nothing for a certain period of time in miliseconds (1000 = 1 second)." & @CRLF & @CRLF & "how many miliseconds?"
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
			$data = "When you Press a specific key or set of keys on the keyboard." & @CRLF & @CRLF & "Which Key?" & @CRLF & "Include Shift?" & @CRLF & "Include Control?" & @CRLF & "Include Alt?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton1 Then
			$data = "When a button on the mouse is clicked." & @CRLF & @CRLF & "Which Button?" & @CRLF & "What protion of the screen?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton2 Then
			$data = "When the clipboard contains certain data." & @CRLF & @CRLF & "What Text?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton3 Then
			$data = "When a certain window is up (when a program is running)." & @CRLF & @CRLF & "Which Window?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton4 Then
			$data = "At a certain date and time." & @CRLF & @CRLF & "What Time?" & @CRLF & "Everyday? On one day of the week? Or on a specific date?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton5 Then
			$data = "When an image is found on the screen." & @CRLF & @CRLF & "Which Image?" & @CRLF & "What portion of the screen?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		elseif $a[4] == $hButton6 Then
			$data = "When certain text is found on the screen." & @CRLF & @CRLF & "What Text?" & @CRLF & "What portion of the screen?"
			if GUICtrlRead($hLabel1) <> $data Then
				GUICtrlSetData($hLabel1, $data)
			EndIf
		Else
			;GUICtrlSetData($g_idX, $a[0])
			;GUICtrlSetData($g_idY, $a[1])
		endIf
	EndIf
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Specific Triggers

Func ClipboardTrigger()
	Local $sAnswer = InputBox("Clipboard Trigger", "What text?", "Planet Earth", "")
	local $totrig = "ClipGet() == '" & $sAnswer &"'"
	AddToTrigger($totrig)
EndFunc


Func AddToTrigger($data)
	if $triggerText == "" then
		$triggerText = $data
	else
		$triggerText = $triggerText & " And " & $data
	endif
	msgbox(64,"trigger text", $triggerText)
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Specific Behaviors

Func ClipboardBehavior()
	Local $sAnswer = InputBox("Clipboard Behavior", "What text should be put onto the Clipboard?", "Planet Jupiter", "")
	local $totrig = "clip " & $sAnswer
	AddToBehavior($totrig)
EndFunc

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

Func AddToBehavior($data)
	if $behaviorText == "" then
		$behaviorText = $data
	else
		$behaviorText = $behaviorText & @CRLF & $data
	endif
	msgbox(64,"Behavior text", $behaviorText)
EndFunc



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Save



Func SaveTrigger()
	;get trigger file number, save as global
	local $i = 0
	While FileExists(_PathFull(@ScriptDir & "\scripts\if") & "\" & $i & ".txt")
		$i = $i + 1
	WEnd
	$triggerNumber = $i

	;save trigger text in if/filenumber.txt
  local $file = _PathFull(@ScriptDir & "\scripts\if") & "\" & $triggerNumber & ".txt"

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

	local $file = _PathFull(@ScriptDir & "\scripts\then") & "\" & $triggerNumber & ".txt"

	If Not FileWrite($file, $behaviorText) Then
		MsgBox($MB_SYSTEMMODAL, $triggerNumber, "couldn't write behavior")
		Return False
	else
		GUICtrlSetState($hButton17, $GUI_HIDE)
		sleep(1000)
		msgbox(64, "Behavior", "Successfully Saved")
	EndIf

EndFunc



CreateTriggers()



While 1
	$hMsg = GUIGetMsg()
	Switch $hMsg
		Case $GUI_EVENT_CLOSE
			GUIDelete($hGUI)
			Exit
		Case $hButton2
			ClipboardTrigger()
		Case $hButton16
			SaveTrigger()
			HideTriggers()
			CreateBehaviors()
			ExitLoop
		case Else
			SetLabel1()
	EndSwitch
WEnd


While 1
	$hMsg = GUIGetMsg()
	Switch $hMsg
		Case $GUI_EVENT_CLOSE
			GUIDelete($hGUI)
			Exit
		Case $hButton11
			MouseClickBehavior()
		Case $hButton13
			ClipboardBehavior()
		Case $hButton17
			SaveBehavior()
			ExitLoop
		case Else
			SetLabel()
	EndSwitch
WEnd


ReturnToMain()

Func ReturnToMain()
	Run("reflexmem.exe")
	GUIDelete($hGUI)
	Exit
EndFunc
