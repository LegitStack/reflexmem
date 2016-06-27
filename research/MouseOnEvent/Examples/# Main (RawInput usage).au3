#include <GUIConstantsEx.au3>
#include "..\MouseOnEvent.au3"

HotKeySet("{ESC}", "_Quit")

_Example_Intro()
_Example_Limit_Window()

Func _Example_Intro()
	MsgBox(64, "Attention!", "Let's set event function for mouse wheel *scrolling* up and down", 5)
	
	;Set event function for mouse wheel *scrolling* up/down and primary button *down* action (call our function when the events recieved)
	_MouseSetOnEvent_RI($MOUSE_WHEELSCROLLDOWN_EVENT, "_MouseWheel_Events")
	_MouseSetOnEvent_RI($MOUSE_WHEELSCROLLUP_EVENT, "_MouseWheel_Events")
	_MouseSetOnEvent_RI($MOUSE_PRIMARYDOWN_EVENT, "_MousePrimaryDown_Event")
	
	Sleep(3000)
	
	;UnSet the events
	_MouseSetOnEvent_RI($MOUSE_WHEELSCROLLDOWN_EVENT)
	_MouseSetOnEvent_RI($MOUSE_WHEELSCROLLUP_EVENT)
	_MouseSetOnEvent_RI($MOUSE_PRIMARYDOWN_EVENT)
	
	ToolTip("")
EndFunc

Func _Example_Limit_Window()
	Local $hGUI = GUICreate("MouseOnEvent UDF Example - Restrict events on specific window")
	
	GUICtrlCreateLabel("Try to click on that specific GUI window", 40, 40, 300, 30)
	GUICtrlSetFont(-1, 12, 800)
	GUICtrlCreateLabel("Press <ESC> to exit", 10, 10)
	GUISetState()
	
	_MouseSetOnEvent_RI($MOUSE_PRIMARYDOWN_EVENT, "_MousePrimaryDown_Event", $hGUI)
	_MouseSetOnEvent_RI($MOUSE_SECONDARYUP_EVENT, "_MouseSecondaryUp_Event", $hGUI)
	
	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $GUI_EVENT_PRIMARYDOWN
				MsgBox(0, "", "Should be shown ;)")
		EndSwitch
	WEnd
	
	_MouseSetOnEvent_RI($MOUSE_PRIMARYDOWN_EVENT)
	_MouseSetOnEvent_RI($MOUSE_SECONDARYUP_EVENT)
EndFunc

Func _MouseWheel_Events($iEvent)
	Switch $iEvent
		Case $MOUSE_WHEELSCROLLDOWN_EVENT
			ToolTip("Wheel Mouse Button (scrolling) DOWN")
		Case $MOUSE_WHEELSCROLLUP_EVENT
			ToolTip("Wheel Mouse Button (scrolling) UP")
	EndSwitch
	
	Return 1 ;Block
EndFunc

Func _MousePrimaryDown_Event()
	ToolTip("Primary Mouse Button Down")
EndFunc

Func _MouseSecondaryUp_Event()
	ToolTip("Secondary Mouse Button Up")
EndFunc

Func _Quit()
	Exit
EndFunc
