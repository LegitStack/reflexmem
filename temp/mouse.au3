Opt('GUIOnEventMode', '1')
HotKeySet('!p', '_Pause')

Global $Pause = False

$GUI = GUICreate('Pixel Finder Tool v1.0', '150', '40', '-1', '-1', '-1', '128')
GUISetOnEvent(-3, '_Exit')
GUISetFont ('9', '600', '', 'Arial')
$Input = GUICtrlCreateInput('', '0', '0', '150', '20', '1')
$Input2 = GUICtrlCreateInput('', '0', '20', '150', '20', '1')
GUICtrlSetState($Input, 128)
GUICtrlSetState($Input2, 128)
GUISetState(@SW_SHOW, $GUI)
WinSetOnTop($GUI, '', '1')

While 1
If Not $Pause Then
$Pos = MouseGetPos()
$Pixel = PixelGetColor($Pos['0'], $Pos['1'])
$Pixel = '0x' & Hex($Pixel, '6')
GUICtrlSetData($Input, $Pixel)
GUICtrlSetData($Input2, "X: " & $Pos['0'] & "  Y: " & $Pos['1'])
EndIf
Sleep(15)
WEnd

Func _Pause()
If Not $Pause Then ClipPut(GUICtrlRead ($Input) & @CRLF & GUICtrlRead ($Input2))
$Pause = Not $Pause
EndFunc   ;==>_Pause

Func _Exit()
Exit
EndFunc   ;==>_Exit
