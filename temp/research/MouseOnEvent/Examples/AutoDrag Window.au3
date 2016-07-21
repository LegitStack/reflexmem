#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#include "..\MouseOnEvent.au3"

Global $iDrag_Is_Active = False

HotKeySet("{ESC}", "_Quit")
Opt("GUIOnEventMode", 1)

$hForm = GUICreate("Form1", 500, 40)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Quit")

$iLabel = GUICtrlCreateLabel("Click on title, and move the mouse", 10, 10, 480, 20)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")

GUISetState(@SW_SHOW)

_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT, "_PrimaryDown", $hForm, -1)
_MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT, "_PrimaryUp", $hForm, -1)

While 1
	Sleep(10)
WEnd

Func _Quit()
	;GUIDelete()
	
	_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT)
	_MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT)
	
	Exit
EndFunc

Func _PrimaryDown()
	GUICtrlSetData($iLabel, "Mouse Left Down")
	
	Return 0 ;Do not Block the default processing
EndFunc

Func _PrimaryUp()
	If GUICtrlRead($iLabel) = "Mouse Left Down" Then Send("{Enter}")
	GUICtrlSetData($iLabel, "Mouse Left Up - Drag the window and press ENTER, or click again.")
	
	Return 1 ;Block the default processing
EndFunc
