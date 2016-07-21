#include "..\MouseOnEvent.au3"

$iPaused = False

_MouseSetOnEvent($MOUSE_WHEELDOWN_EVENT, "_PausePlay", 0, 1)

Sleep(5000)

_MouseSetOnEvent($MOUSE_WHEELDOWN_EVENT)

Func _PausePlay()
	$iPaused = Not $iPaused
	ConsoleWrite("Paused: " & $iPaused & @CRLF)
EndFunc
