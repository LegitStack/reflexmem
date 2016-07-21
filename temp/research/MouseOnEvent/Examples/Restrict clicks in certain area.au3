#include "..\MouseOnEvent.au3"

HotKeySet("{ESC}", "_Quit")

Global $iLimit_Coord_Left 		= 0
Global $iLimit_Coord_Top 		= 40
Global $iLimit_Coord_Width 		= 350
Global $iLimit_Coord_Height 	= 25

;This will disable primary down event, double clicks included (see next)
_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT, "_MousePrimaryDown_Event", 0, -1)

;Enable Double click, comment next line if double clicks should be disabled
_MouseSetOnEvent($MOUSE_PRIMARYDBLCLK_EVENT)

While 1
	Sleep(100)
WEnd

Func _MousePrimaryDown_Event()
	Local $aMPos = MouseGetPos()
	
	If ($aMPos[0] >= $iLimit_Coord_Left And $aMPos[0] <= $iLimit_Coord_Left + $iLimit_Coord_Width) And _
		($aMPos[1] >= $iLimit_Coord_Top And $aMPos[1] <= $iLimit_Coord_Top + $iLimit_Coord_Height) Then
		Return $MOE_BLOCKDEFPROC ;Block mouse click
	EndIf
	
	Return $MOE_RUNDEFPROC
EndFunc

Func _Quit()
	Exit
EndFunc
