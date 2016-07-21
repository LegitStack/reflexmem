#include "AutoItObject.au3"
#include <Array.au3>
#include-once

Global $reflect_running_pid[1] = [0]

_AutoItObject_StartUp()
OnAutoItExitRegister("_ROnExitCleanUp")

; needs rewrite
Global Const $inject = '#NoTrayIcon ;tehee' & @CRLF & _
'#include "lib\AutoItObject.au3"' & @CRLF & _
'Global $oError = ObjEvent("AutoIt.Error", "_ErrFunc")' & @CRLF & _
'Func _ErrFunc()' & @CRLF & _
'    Return' & @CRLF & _
'EndFunc' & @CRLF & _
'_AutoItObject_StartUp()' & @CRLF & _
'Global $oObject = _SomeObject()' & @CRLF & _
'Global $hObj = _AutoItObject_RegisterObject($oObject, "Manadar.AutoIt.Plugin")' & @CRLF & _
';;REPLACEME-CONTINUE;;' & @CRLF & _
'Func _SomeObject()' & @CRLF & _
'    Local $oClassObject = _AutoItObject_Class()' & @CRLF & _
'    ;;;;;;REPLACEME;;;;;;' & @CRLF & _
'    $oClassObject.AddMethod("Quit", "_QuitObject")' & @CRLF & _
'    Return $oClassObject.Object' & @CRLF & _
'EndFunc' & @CRLF & _
'Func _QuitObject($oSelf)' & @CRLF & _
'    _AutoItObject_UnregisterObject($hObj)' & @CRLF & _
'    $oObject = 0' & @CRLF & _
'    Exit' & @CRLF & _
'EndFunc' & @CRLF

Func _RDoFile($file, $continue = False)
	$content = FileRead($file)
	If @error Then Return SetError(1, 0, 0)

	$functions = _RGetFunctionNames($content)
	If @error Then Return SetError(2, 0, 0)

	$replace = ""
	For $i = 0 To UBound($functions)-1
		$replace &= "$oClassObject.AddMethod(""" & $functions[$i] & """, """ & $functions[$i] & """)" & @CRLF
		$content = StringReplace($content, "Func " & $functions[$i] & "(","Func " & $functions[$i] & "($o___________________o, ")
	Next

	$result =  StringReplace($inject, ";;;;;;REPLACEME;;;;;;", $replace) & @CRLF & @CRLF & _
	"; ============= ACTUAL SCRIPT ============= " & @CRLF & @CRLF & $content ; needs work

	If Not $continue Then
		$result = StringReplace($result, ";;REPLACEME-CONTINUE;;", 'While 1' & @CRLF & _
				'    Sleep(100)' & @CRLF & _
				'WEnd' & @CRLF & _
				'_QuitObject(0)' & @CRLF) ; needs work
	Else
		$result &= @CRLF & @CRLF & '_QuitObject(0)' ; at end of script
	EndIf

	Local Const $temp = "temp.au3"

	FileWrite($temp, $result)
	If @error Then Return SetError(3, 0, 0)

	$pid = Run('"' & @AutoItExe & """ """ & @ScriptDir & "\" & $temp & '"')
	If @error Then Return SetError(4, 0, 0)
	_ArrayAdd($reflect_running_pid, $pid)
	Sleep(1000)

	FileDelete($temp)

	$obj = _AutoItObject_ObjCreate("cbi:Manadar.AutoIt.Plugin")
	If @error Then Return SetError(5, 0, 0)
	Return $obj
EndFunc

Func _RImplementInterface($file, $name)
	$content = FileRead($file)
	If @error Then Return SetError(1, 0, 0)

	$functions = _RGetFunctionNames($content)
	If @error Then Return SetError(2, 0, 0)

	Local $oClassObject = _AutoItObject_Class()

	For $i = 0 To UBound($functions)-1
		ConsoleWrite("Adding method: " & $functions[$i] & @CRLF)
		$oClassObject.AddMethod($functions[$i], $functions[$i])
	Next

	Local $oObject = $oClassObject.Object

	_AutoItObject_RegisterObject($oObject, $name)

	Return $oObject
EndFunc

Func _RAttach($name)
	$obj = _AutoItObject_ObjCreate("cbi:" & $name)
	Return $obj
EndFunc

Func _ROnExitCleanUp()
	; Clean any left over processes
	If UBound($reflect_running_pid) > 1 Then
		For $i = 1 To UBound($reflect_running_pid)-1
			ProcessClose($reflect_running_pid[$i])
		Next
	EndIf

	; Goodbye ~Portal 2 turret
	_AutoItObject_Shutdown()
EndFunc

Func _RGetFunctionNames($script)
	$a = StringRegExp($script, "Func ([_a-zA-Z0-9]*)", 3) ; needs work
	Return $a
EndFunc