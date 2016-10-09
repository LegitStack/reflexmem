#include <Misc.au3>
	Local $aPos
	While 1
	  $aPos = MouseGetPos()
		ToolTip("X: " & $aPos[0] & "  Y: " & $aPos[1],0,0)
	  If _IsPressed("01") Then
	    MsgBox(64, "_IsPressed", "The Esc Key was pressed, therefore we will close the application.")
	    ExitLoop
	  endIf
	WEnd
