;global $test
;HotKeySet("{ESC}", "Terminate")
Func HelloWorld($str)

	MsgBox(0x40, @ScriptName, $str)

;	$test = "love"
	;While 1
	;  Sleep(1000)
	;WEnd
	;call("hellocow")
EndFunc

;Func hellocow($str = $test)

;	MsgBox(0x40, @ScriptName, $str)
	;While 1
	;  Sleep(1000)
	;WEnd

;EndFunc
;HelloWorld("Hello world")


;While 1
;  Sleep(1)
;WEnd

;Func Terminate($str)
;  exit
;EndFunc
