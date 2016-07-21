#include "..\MouseOnEvent.au3"

_BlockMouseClicksInput(0)

ToolTip('MouseClicks are disabled')
Sleep(5000)

_BlockMouseClicksInput(1)

ToolTip('MouseClicks are enabled')
Sleep(3000)

Func _BlockMouseClicksInput($iOpt = 0)
	If $iOpt = 0 Then
		_MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT, "__Dummy", 0, 1)
		_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT, "__Dummy", 0, 1)
		_MouseSetOnEvent($MOUSE_SECONDARYUP_EVENT, "__Dummy", 0, 1)
		_MouseSetOnEvent($MOUSE_SECONDARYDOWN_EVENT, "__Dummy", 0, 1)
	Else
		_MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT)
		_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT)
		_MouseSetOnEvent($MOUSE_SECONDARYUP_EVENT)
		_MouseSetOnEvent($MOUSE_SECONDARYDOWN_EVENT)
	EndIf
EndFunc
