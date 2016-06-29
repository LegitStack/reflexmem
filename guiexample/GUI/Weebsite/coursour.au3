#include <GUIConstantsEx.au3>

Global $g_idX = 0, $g_idY = 0

Example()

Func Example()
    ;HotKeySet("^a", "GetPos") ;control
    ;HotKeySet("+a", "GetPos") ;  Shift
    ;HotKeySet("!a", "GetPos") ;alt

    HotKeySet("+!^a", "GetPos") ;  Shift

    GUICreate("Press Esc to Get Pos", 400, 400)
    $g_idX = GUICtrlCreateLabel("0", 10, 10, 50)
    $g_idY = GUICtrlCreateLabel("0", 10, 30, 50)
    GUISetState(@SW_SHOW)

    ; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                ExitLoop
			case Else
			   ;GetPos()
        EndSwitch
    WEnd

    GUIDelete()
EndFunc   ;==>Example

Func GetPos()
    Local $a = GUIGetCursorInfo()

	if $a[4] == $g_idX Then
	  if GUICtrlRead($g_idX) == "overme!" Then
	  Else
		GUICtrlSetData($g_idX, "overme!")
	  EndIf

   Else
    GUICtrlSetData($g_idX, $a[0])
    GUICtrlSetData($g_idY, $a[1])
   endIf
EndFunc   ;==>GetPos
