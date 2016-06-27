#include <GUIConstantsEx.au3>
#include <GUIButton.au3>
#include <Misc.au3>

#include "..\MouseOnEvent.au3"

Global $iPrimaryUpEvent = 0, $iPrimaryDownEvent = 0
Global $sCalc_CLASS = "[REGEXPCLASS:(SciCalc|CalcFrame)]"

Run("Calc")
WinWait($sCalc_CLASS)
$hCalc = WinGetHandle($sCalc_CLASS)
$hButton = _GUICtrlButton_Create($hCalc, "Button", 10, 25, 40, 15)

_MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT, "PRIMARYUP_EVENT", $hButton, 0)
_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT, "PRIMARYDOWN_EVENT", $hButton, 0)

While 1
    Sleep(10)
	
	If Not WinExists($sCalc_CLASS) Then
		Exit
	EndIf
	
	If $iPrimaryUpEvent Then
		$iPrimaryUpEvent = 0
		MsgBox(64, 'Title', 'Button Pressed', 0, $hCalc)
	EndIf
	
	If $iPrimaryDownEvent And Not _IsPressed(1) Then
		$iPrimaryDownEvent = 0
	EndIf
WEnd

Func PRIMARYDOWN_EVENT()
	$iPrimaryDownEvent = 1
EndFunc

Func PRIMARYUP_EVENT()
	If $iPrimaryDownEvent Then
		$iPrimaryDownEvent = 0
		$iPrimaryUpEvent = 1
	EndIf
EndFunc
