; _APIFileOpen( <FileName> )
;
; Returns a "REAL" file handle for reading and writing.
; The return value comes directly from "CreateFile" api.
Func _APIFileOpen( $szFile,$Optioins = 0 )
	Local $GENERIC_READ = 0x80000000, $GENERIC_WRITE = 0x40000000
	Local $STANDARD_RIGHTS_REQUIRED = 0x000f0000
	Local $SYNCHRONIZE = 0x00100000
	Local $FILE_ALL_ACCESS = BitOR(0x1FF, $STANDARD_RIGHTS_REQUIRED, $SYNCHRONIZE)

	Local $OPEN_ALWAYS = 4, $CREATE_ALWAYS = 2, $FILE_ATTRIBUTE_NORMAL = 0x00000080
	Local $AFO_h, $AFO_ret
	Local $AFO_bWrite = 1

		$AFO_h = DllCall( "kernel32.dll", "hwnd", "CreateFile", _
				"str", $szFile, _
				"long", $FILE_ALL_ACCESS, _
				"long", 7, _
				"ptr", 0, _
				"long", $OPEN_ALWAYS, _
				"long", $FILE_ATTRIBUTE_NORMAL, _
				"long", 0 )
		If $AFO_h[0] = 0xFFFFFFFF Then
			If $Optioins = 1 Then
				$AFO_bWrite = 1
				$AFO_h = DllCall( "kernel32.dll", "hwnd", "CreateFile", _
						"str", $szFile, _
						"long", $GENERIC_WRITE, _
						"long", 7, _
						"ptr", 0, _
						"long", $CREATE_ALWAYS, _
						"long", $FILE_ATTRIBUTE_NORMAL, _
						"long", 0 )
			Else
				$AFO_bWrite = 0
				$AFO_h = DllCall( "kernel32.dll", "hwnd", "CreateFile", _
						"str", $szFile, _
						"long", $GENERIC_READ, _
						"long", 7, _
						"ptr", 0, _
						"long", $CREATE_ALWAYS, _
						"long", $FILE_ATTRIBUTE_NORMAL, _
						"long", 0 )	
			Endif
	EndIf
	$AFO_ret = DLLCall("kernel32.dll","int","GetLastError")
	SetError($AFO_ret[0],$AFO_bWrite)
	Return $AFO_h[0]
EndFunc
; _APIFileClose( <FileHandle> )
;
; The return value comes directly from "CloseHandle" api.
Func _APIFileClose( ByRef $hFile )
	Local $AFC_r
	$AFC_r = DllCall( "kernel32.dll", "int", "CloseHandle", _
			"hwnd", $hFile )
	Return $AFC_r[0]
EndFunc


; _APIFileSetPos( <FileHandle>, <Position in the file to read/write to/from> )
;
; The return value comes directly from "SetFilePointer" api.
Func _APIFileSetPos( ByRef $hFile, ByRef $nPos )
	Local $FILE_BEGIN = 0 
	Local $AFSP_r
	$AFSP_r = DllCall( "kernel32.dll", "long", "SetFilePointer", _
			"hwnd",$hFile, _
			"long",$nPos, _
			"long_ptr",0, _
			"long",$FILE_BEGIN )
	Return $AFSP_r[0] 
EndFunc


; _BinaryFileRead( <FileHandle>, <ptr buffer>)
;
; Reads file into struct <ptr buffer>
; Return from ReadFile api.
Func _BinaryFileRead( ByRef $hFile, ByRef $buff_ptr, $buff_bytes = 0)
	Local $AFR_r
	If $buff_bytes = 0 Then $buff_bytes = DllStructGetSize($buff_ptr)
	$AFR_r = DllCall( "kernel32.dll", "int", "ReadFile", _
			"hwnd", $hFile, _
			"ptr",DllStructGetPtr($buff_ptr), _
			"long",$buff_bytes, _
			"long_ptr",0, _
			"ptr",0 )
	Return $AFR_r[0]
EndFunc


; _BinaryFileWrite( <FileHandle>, <ptr buffer>)
;
; Returns # of Bytes written. 
; Sets @error to the return from WriteFile api.
Func _BinaryFileWrite( ByRef $hFile, ByRef $buff_ptr, $buff_bytes = 0)
	Local $AFW_r
	If $buff_bytes = 0 Then $buff_bytes = DllStructGetSize($buff_ptr)
	$AFW_r = DllCall( "kernel32.dll", "int", "WriteFile", _
			"hwnd", $hFile, _
			"ptr",DllStructGetPtr($buff_ptr), _
			"long",$buff_bytes, _
			"long_ptr",0, _
			"ptr",0 )
	SetError($AFW_r[0],$AFW_r[4])
	Return $AFW_r[4]
EndFunc

