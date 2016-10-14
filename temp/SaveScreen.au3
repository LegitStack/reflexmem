
; ------------------------------------------------------------------------------
;
; AutoIt Version: 3.1.1 (beta)
; Language:       English
; Author(s):      Steve Podhajecki [eltorro] gehossafats@netmdc.com
; Description:    Save PrtScr from clipboard as bmp file using AutoIt3 and API
;				  No extra dll's required.
;				  Works on XP  should work on OS >= Win2k
; Thanks to Valik for finding buffer error
; ------------------------------------------------------------------------------
;
#Compiler_AU3Check_Parameters= -q -d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w 7 ;Au3Check parameters
; ------------------------------------------------------------------------------
If Not (IsDeclared("DEBUG")) Then
	Global $DEBUG = True
EndIf
;http://www.autoitscript.com/forum/index.php?act=Attach&type=post&id=5084
#include <APIFileReadWrite.au3>
#Include <Clipboard.au3>
; ------------------------------------------------------------------------------
Global Const $SRCCOPY = 0x00CC0020
Global Const $DIB_RGB_COLORS = 0
;Global Const $CF_BITMAP = 2
Global Const $OBJ_PAL = 5
Global $TIMER =0
Global $DIFF = 5000
Global Const $SIZE_RESTORED = 0
Global Const $SIZE_MINIMIZED = 1
;----------------------------------------------------------
Global Const $tagBITS = "byte[1024]"
; 24bytes ptr is to BITS
Global Const $tagBITMAP = "int;int;int;int;ushort;ushort;ptr"
;Global Const $tagBITMAPINFOHEADER = "dword;int;int;ushort;ushort;dword;dword;int;int;dword;dword";
;Global Const $tagQUAD = "byte[4]"
Global Const $tagBITMAPFILEHEADER = "ushort;dword;ushort;ushort;dword"
; has BITMAPINFOHEADER and RGBQUAD
;Global Const $tagBITMAPINFO = "prt;ptr"
;----------------------------------------------------------
Global $StructError[5] = ["No error", "Variable passed to DllStructCreate was not a string. ", "There is an unknown Data Type in the string passed.", _
		"Failed to allocate the memory needed for the struct, or Pointer = 0.", "Error allocating memory for the passed string."]
;----------------------------------------------------------

Global $LOG = @ScriptDir & "\screenprint.log"
;If FileExists($LOG) then FileDelete($LOG)
;----------------------------------------------------------
;~ ClipPut("")



Global $wide
Global $tall
Global $bpp
;Local Const $WM_SIZE = 0x0005
Local $hWnd_ME = GUICreate("Save Screenshot", 312, 160, (@DesktopWidth - 312) / 2, (@DesktopHeight - 160) / 2, -1)
Local $GroupBox1 = GUICtrlCreateGroup("", 8, 1, 297, 113)
GUICtrlCreateLabel("Copy something to the clipboard",56, 17, 200, 25)
GUICtrlCreateLabel("Press Print Screen or Alt-Print Screen"&@LF&@LF&"This dialog will minimize shortly.", 56, 34, 211, 49)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Local $Button1 = GUICtrlCreateButton("Minimize", 121, 131, 75, 25, 0)
;GUIRegisterMsg($WM_SIZE,"WM_SIZE") ;auto minimize after a few seconds
GUISetState(@SW_SHOW)
;----------------------------------------------------------
;Application
;----------------------------------------------------------
$Timer = TimerInit(); display for a few seconds
_InitAsClipViewer ($hWnd_ME) ; add this app as cliboard viewer
;GUIRegisterMsg($WM_SIZE,"WM_SIZE")
Main(1) ; Main msg/event handler
_StopAsClipViewer ($hWnd_ME) ; Remove this app as viewer, unhook msg
Exit

;----------------------------------------------------------
;Main msg/event loop
;----------------------------------------------------------
Func Main($bStartUp = 0)

	Local $nMsg
	While 1
		$nMsg = GUIGetMsg()
		Select
			Case $nMsg = $GUI_EVENT_CLOSE
				If Not ($bStartUp) Then
					ExitLoop
				Else
					GUISetState(@SW_MINIMIZE)
					$bStartUp = 0
				EndIf

			Case $nMsg = $Button1
				GUISetState(@SW_MINIMIZE)
			Case $EVENT = $WM_DRAWCLIPBOARD
				;supress Startup msgbox.
				If Not ($bStartUp) Then
					MsgBox($MB_OK + $MB_SYSTEMMODAL + $MB_TOPMOST, "Clipboard UDF", "The Clipboard has changed.",3)
					ContentHandler()
				Else
					$bStartUp = 0
				EndIf

			Case $EVENT = $WM_CHANGECBCHAIN
				MsgBox($MB_OK + $MB_SYSTEMMODAL + $MB_TOPMOST, "Clipboard UDF", "The Clipboard chain has changed.")
			Case Else
				;;
		EndSelect
		$EVENT = 0
		If $Timer >0 Then
			If TimerDiff($TIMER)> $DIFF Then
				$Timer = 0
				GUISetState(@SW_MINIMIZE)
			EndIf
		EndIf
		Sleep(10)
	WEnd
EndFunc   ;==>Main
Exit
Func ContentHandler()
	Local $buffer
	Local $clipbmp = GetClipBoard($buffer)
	If $DEBUG Then
		_FileWriteLog($LOG, ";----------------------------------------------------------" & @LF)
		_FileWriteLog($LOG, "Begin Process: " & @error & @LF)
	EndIf
	If $DEBUG Then _FileWriteLog($LOG, "Getting Clipboard>" & @error & @LF)
	If $clipbmp Then
		If $DEBUG Then _FileWriteLog($LOG, "Captured Screen>" & @error & @LF)
		PreviewImage($buffer, $wide, $tall)
		If FileExists(@DesktopCommonDir & "\clipboardtest.bmp") Then FileDelete(@DesktopCommonDir & "\clipboardtest.bmp")
		If $DEBUG Then _FileWriteLog($LOG, "Calling SaveDib>" & @error & @LF)
		CreateDib($clipbmp, @DesktopCommonDir & "\clipboardtest.bmp")
		If $DEBUG Then _FileWriteLog($LOG, "Return Error Status: " & @error & @LF)
	EndIf
	If $DEBUG Then
		_FileWriteLog($LOG, "Exiting Now.  Bye." & @LF)
		_FileWriteLog($LOG, ";----------------------------------------------------------" & @LF & @LF)
	EndIf
	DeleteObject($clipbmp)
	$buffer = 0
EndFunc   ;==>ContentHandler

Func GetClipBoard(ByRef $pbuf)
	Local $hBitmap;
	Local $hMyDC
	Local $bmBitmap = DllStructCreate($tagBITMAP)
	If $DEBUG Then _FileWriteLog($LOG, "DllStructCreate Error>" & $StructError[@error] & @LF)
	Local $Me = DllCall("user32.dll", "hwnd", "GetDesktopWindow")
	If IsArray($Me) Then
		OpenClipboard($Me[0])
		If (IsClipboardFormatAvailable($CF_BITMAP)) Then
			$hBitmap = GetClipboardData($CF_BITMAP)
			If ($hBitmap) Then
				GetObject($hBitmap, DllStructGetSize($bmBitmap), DllStructGetPtr($bmBitmap))
				For $x = 1 To 7
					ConsoleWrite("BMP>" & $x & ">" & DllStructGetData($bmBitmap, $x) & @LF)
				Next

				$hMyDC = GetDC(0)
				If ($hMyDC) Then
					Local $width = DllStructGetData($bmBitmap, 2)
					Local $height = DllStructGetData($bmBitmap, 3)
					Local $DIBHead = DllStructCreate($tagBITMAPINFOHEADER & ";" & $tagBITS)
					DllStructSetData($DIBHead, 1, 40)
					DllStructSetData($DIBHead, 2, $width)
					DllStructSetData($DIBHead, 3, $height)
					DllStructSetData($DIBHead, 4, 1)
					$bpp = DllStructGetData($bmBitmap, 6)
					If $bpp > 16 Then $bpp = 24
					ConsoleWrite(">>$bbp>" & $bpp & @LF)
					DllStructSetData($DIBHead, 5, $bpp)

					Local $iBitmap = CreateDIBSection($hMyDC, $DIBHead, $DIB_RGB_COLORS, 0, 0, 0)
					Local $iSrc = CreateCompatibleDC(0)
					Local $hOldObj = SelectObject($iSrc, $hBitmap)
					Local $iDest = CreateCompatibleDC(0)
					Local $hNewObj = SelectObject($iDest, $iBitmap)
					if (DllStructGetData($DIBHead, 5) <= 8) Then
						;take the DFB's palette and set it to our DIB
						;not working with clipboard yet.
						Local $hPalette = GetCurrentObject($iSrc, $OBJ_PAL);
						if ($hPalette) Then
							Local $pal = DllStructCreate("byte[1024]")
							Local $nEntries = GetPaletteEntries($hPalette, 0, 256, DllStructGetPtr($pal));
							if ($nEntries) Then
								If $DEBUG Then ConsoleWrite("$nEntries:" & $nEntries & @LF)
								For $x = 1 to ($nEntries * 4) Step 4
									DllStructSetData($pal, 1, 0, $x)
								Next
								ConsoleWrite(SetDIBColorTable($iDest, 0, $nEntries * 4, DllStructGetPtr($pal)) & @LF)
							EndIf
						EndIf
					EndIf
					BitBlt($iDest, 0, 0, $width, $height, $iSrc, 0, 0, $SRCCOPY)
					$wide = DllStructGetData($DIBHead, 2)
					$tall = DllStructGetData($DIBHead, 3)
					Local $size = (((($wide * 32) + 31) / 32) * 4) * Abs($tall)
					DllStructSetData($DIBHead, 7, $size)
					;						$bmInfoHeader = DllStructCreate($tagBITMAPINFOHEADER, DllStructGetPtr($DIBHead, 1))
					ConsoleWrite("byte[" & DllStructGetData($DIBHead, 7) & "]" & @LF)
					$pbuf = DllStructCreate("byte[" & DllStructGetData($DIBHead, 7) & "]")
					GetDIBits($iDest, $iBitmap, 0, $tall, DllStructGetPtr($pbuf), DllStructGetPtr($DIBHead), 0)
				Else
					If $DEBUG Then _FileWriteLog($LOG, "Error retrieving Bitmap" & @LF)
				EndIf

				; Release struct.
				CloseClipboard()
				ReleaseDC(0, $iSrc)
				DeleteDC($iSrc)
				ReleaseDC(0, $iDest)
				DeleteDC($iDest)
				DeleteObject($hBitmap)
				$hBitmap = $iBitmap
				DeleteObject($hOldObj)
				DeleteObject($hNewObj)
				ReleaseDC(0, $hMyDC)
				DeleteDC($hMyDC)
				$bmBitmap = 0
				$pal = 0
				$DIBHead = 0

				If $DEBUG Then _FileWriteLog($LOG, "Bitmap Retrieved" & @LF)
			Else
				If $DEBUG Then _FileWriteLog($LOG, "Error creating DC" & @LF)
			EndIf
			;Return $iBitmap
			Return $hBitmap
		Else
			If $DEBUG Then _FileWriteLog($LOG, "No bitmap's in clipboard" & @LF)
		EndIf
	EndIf

EndFunc   ;==>GetClipBoard

Func CreateDib($inDib, $sFile = "")
	If $DEBUG Then _FileWriteLog($LOG, "Bitmap Handle:" & $inDib & @LF)
	If $inDib = 0 Then
		If $DEBUG Then _FileWriteLog($LOG, "No bitmap to process." & @LF)
		SetError(1)
		Return 0
	EndIf
	If $sFile = "" Then $sFile = @DesktopCommonDir & "\" & @MON & @MDAY & @YEAR & @HOUR & @MIN & @SEC & ".bmp"
	If $DEBUG Then _FileWriteLog($LOG, "Filename is: " & $sFile & @LF)
	Local $vret, $biWidth, $biHeight, $biBitCount, $biCompression, $biClrUsed, $size;, $biSizeImage, $bmColors, $bmBit, $FileHead
	;----------------------------------------------------------
	;Structs
	;----------------------------------------------------------
	Local $DIBHead, $bmInfoHeader, $bmBitmap, $pbuf
	;----------------------------------------------------------
	$bmBitmap = DllStructCreate($tagBITMAP)
	If $DEBUG Then _FileWriteLog($LOG, "DllStructCreate Error>" & $StructError[@error] & @LF)
	;----------------------------------------------------------
	Local $NumCols, $DeskDC
	If (GetObject($inDib, DllStructGetSize($bmBitmap), DllStructGetPtr($bmBitmap)) = 0) Then
		MsgBox(266288, "Save", "Failed to Get Bitmap Object")
		Return 0
	EndIf
	If $DEBUG Then
		For $x = 1 To 7
			_FileWriteLog($LOG, "$bmBitmap>>" & DllStructGetData($bmBitmap, $x) & @LF)
		Next
	EndIf
	If (DllStructGetData($bmBitmap, 7) = 0) Then
		MsgBox(266288, "Save", "Error, Dib Section is required.")
		Return 0
	EndIf
	;----------------------------------------------------------
	$DIBHead = DllStructCreate($tagBITMAPINFOHEADER & ";" & $tagBITS)
	$bmInfoHeader = DllStructCreate($tagBITMAPINFOHEADER, DllStructGetPtr($DIBHead, 1))
	; Set Bitmap info header size
	DllStructSetData($DIBHead, 1, DllStructGetSize($bmInfoHeader)); 40 bytes??
	$bmInfoHeader = 0
	;----------------------------------------------------------
	; Get a reference DC to work with
	$DeskDC = GetDC(0)
	; Attempt to read DIBSection header
	If $DEBUG Then _FileWriteLog($LOG, "---------------" & @LF)
	$vret = GetDIBits($DeskDC, $inDib, 0, 0, 0, DllStructGetPtr($DIBHead), 0)
	If ($vret) Then
		;----------------------------------------------------------
		;set some easy to remember vars.
		$biWidth = DllStructGetData($DIBHead, 2)
		$biHeight = DllStructGetData($DIBHead, 3)
		$biBitCount = DllStructGetData($DIBHead, 5)
		$biCompression = DllStructGetData($DIBHead, 6)
		;$biSizeImage = DllStructGetData($DIBHead, 7)
		$biClrUsed = DllStructGetData($DIBHead, 10)
		;----------------------------------------------------------
		If $biBitCount < 8 Then
			If $DEBUG Then _FileWriteLog($LOG, "Bitcount 8 or less" & @LF)
			$NumCols = $biClrUsed
			If ($NumCols = 0) Then $NumCols = 2 ^ $biBitCount
		ElseIf ($biCompression) Then
			If ($biCompression = 3) Then
				$NumCols = 3
			Else
				; Don't support RLE compressed images
				MsgBox(266288, "Save", "RLE Compressed image not supported")
				ReleaseDC(0, $DeskDC)
				DeleteDC($DeskDC)
				Return 0
			EndIf
		EndIf
		$size = (((($biWidth * $biBitCount) + 31) / 32) * 4) * Abs($biHeight)
		DllStructSetData($DIBHead, 7, $size)
		$pbuf = DllStructCreate("byte[" & $size & "]")
		; Read image data
		$vret = GetDIBits($DeskDC, $inDib, 0, Abs($biHeight), DllStructGetPtr($pbuf), DllStructGetPtr($DIBHead), 0)
		If $vret = 0 Then
			MsgBox(266288, "Save", "GetDIBits Error. Unable to get pixel data")
			ReleaseDC(0, $DeskDC)
			DeleteDC($DeskDC)
			Return SetError(1)
		EndIf
		DllStructSetData($DIBHead, 10, $NumCols)
		DllStructSetData($DIBHead, 11, $NumCols)
		;$biSizeImage = DllStructGetData($DIBHead, 7)

		If $DEBUG Then _FileWriteLog($LOG, "Success." & @LF)
		For $x = 1 To 11
			If $DEBUG Then _FileWriteLog($LOG, "$DIBHead>" & $x & ">" & DllStructGetData($DIBHead, $x) & @LF)
		Next

		Local $bSaved = SaveDibToFile($sFile, $DIBHead, $pbuf)
		If $bSaved = True Then
			MsgBox(266288, "Save", "Bitmap saved as: " & $sFile,3)
		Else
			MsgBox(266288, "Save", "Errors were encounterd while saving")
		EndIf

		Sleep(100)
		;----------------------------------------------------------
		;clean Up
		;----------------------------------------------------------
		Sleep(1000)
		If $DEBUG Then _FileWriteLog($LOG, "Release DC" & @LF)
		ReleaseDC(0, $DeskDC)
		DeleteDC($DeskDC)
		DeleteObject($inDib)
		If $DEBUG Then _FileWriteLog($LOG, "De-alloclating structs" & @LF)
		$DIBHead = 0
		$bmBitmap = 0
		$pbuf = 0
		$DeskDC = 0

		If $DEBUG Then _FileWriteLog($LOG, "done." & @LF)
	EndIf
EndFunc   ;==>CreateDib

Func SaveDibToFile($sFile, $hInfo, $hBuffer)
	Local $bSaved = False
	;----------------------------------------------------------
	;Write out bmp to file
	;----------------------------------------------------------
	If $DEBUG Then _FileWriteLog($LOG, "Setting up file header" & @LF)
	Local $hFileHead = DllStructCreate($tagBITMAPFILEHEADER)
	If $DEBUG Then _FileWriteLog($LOG, "DllStructCreate Error>" & $StructError[@error] & @LF)
	DllStructSetData($hFileHead, 1, 0x04d42)
	Local $bfOffBits = DllStructGetSize($hFileHead) + DllStructGetSize($hInfo)
	If $DEBUG Then _FileWriteLog($LOG, "$bfOffBits= " & $bfOffBits & @LF)
	DllStructSetData($hFileHead, 5, $bfOffBits)
	DllStructSetData($hFileHead, 2, DllStructGetData($hInfo, 7) + $bfOffBits)
	Local $hFile = _APIFileOpen ($sFile, 1)
	_FileWriteLog($LOG, "_APIFileOpen: " & $hFile & @LF)
	_FileWriteLog($LOG, "Error Status: " & @error & " Extended: " & @extended & @LF)
	If $hFile Then
		If _BinaryFileWrite ($hFile, $hFileHead) Then
			If $DEBUG Then
				_FileWriteLog($LOG, "Error Status: " & @error & " Extended: " & @extended & @LF)
				_FileWriteLog($LOG, "File header written" & @LF)
			EndIf
			Sleep(100)
			;bmp info
			If _BinaryFileWrite ($hFile, $hInfo) Then
				If $DEBUG Then
					_FileWriteLog($LOG, "Error Status: " & @error & " Extended: " & @extended & @LF)
					_FileWriteLog($LOG, "BITMAPINFO written" & @LF)
				EndIf
				Sleep(100)
				If _BinaryFileWrite ($hFile, $hBuffer) Then
					If $DEBUG Then
						_FileWriteLog($LOG, "Error Status: " & @error & " Extended: " & @extended & @LF)
						_FileWriteLog($LOG, "Image data written" & @LF)
					EndIf
					$bSaved = True
				EndIf
			EndIf
		EndIf
	EndIf
	_APIFileClose ($hFile)
	Return $bSaved
EndFunc   ;==>SaveDibToFile

Func WM_SIZE($hWndGUI, $MsgID, $WParam, $LParam)
	ConsoleWrite("SIZE>" &$WParam& @LF)
	if $WParam =$SIZE_RESTORED then
		$Timer = TimerInit()
	Else
		$TIMER =0
	EndIf
 EndFunc

;~
;----------------------------------------------------------
;UDF Helper Functions
;WinUser.au3
;----------------------------------------------------------
Func GetDC($hWnd)
	Local $hDC = DllCall('user32.dll', 'int', 'GetDC', _
			'hwnd', $hWnd)
	Return $hDC[0]
EndFunc   ;==>GetDC
Func ReleaseDC($hWnd, $hDC)
	Local $bResult = DllCall('user32.dll', 'int', 'ReleaseDC', _
			'hwnd', $hWnd, _
			'hwnd', $hDC)
	Return $bResult[0]
EndFunc   ;==>ReleaseDC
;----------------------------------------------------------
;UDF Helper Functions
;Additional user32.dll functions
;----------------------------------------------------------
Func OpenClipboard($hWnd)
	Local $v_ret = DllCall("user32.dll", "int", "OpenClipboard", "hwnd", $hWnd)
	Return $v_ret[0]
EndFunc   ;==>OpenClipboard

Func CloseClipboard()
	Local $v_ret = DllCall("user32.dll", "int", "CloseClipboard")
	Return $v_ret[0]
EndFunc   ;==>CloseClipboard

Func IsClipboardFormatAvailable($CB_Format)
	Local $v_ret = DllCall("user32.dll", "int", "IsClipboardFormatAvailable", "int", $CB_Format)
	Return $v_ret[0]
EndFunc   ;==>IsClipboardFormatAvailable

Func GetClipboardData($CB_Format)
	Local $v_ret = DllCall("user32.dll", "int", "GetClipboardData", "int", $CB_Format)
	Return $v_ret[0]
EndFunc   ;==>GetClipboardData
;----------------------------------------------------------
;UDF Helper Functions
;WinGDI.au3
;----------------------------------------------------------
Func GetObject($hObj, $nCount, $ptrObj)
	;	Private Declare Function GetObject Lib "GDI32.dll" Alias "GetObjectA" ( ByVal hObject As Long, ByVal nCount As Long, ByRef lpObject As Any) As Long
	Local $v_ret = DllCall('gdi32.dll', 'int', 'GetObject', _
			'hwnd', $hObj, _
			'int', $nCount, _
			'ptr', $ptrObj)
	Return $v_ret[0]
EndFunc   ;==>GetObject

Func GetDIBits($aHdc, $hBitmap, $nStartScan, $nNumScans, $ptrBits, $ptrBI, $wUsage)
	Local $v_ret = DllCall("gdi32.dll", "int", "GetDIBits", _
			"int", $aHdc, _
			"hwnd", $hBitmap, _
			"int", $nStartScan, _
			"int", $nNumScans, _
			"ptr", $ptrBits, _
			"ptr", $ptrBI, _
			"int", $wUsage)

	Return $v_ret[0]
EndFunc   ;==>GetDIBits

Func SelectObject($hDC, $hObj)
	Local $hOldObj = DllCall('gdi32.dll', 'int', 'SelectObject', _
			'hwnd', $hDC, _
			'hwnd', $hObj)
	Return $hOldObj[0]
EndFunc   ;==>SelectObject

Func DeleteObject($hObj)
	Local $bResult = DllCall('gdi32.dll', 'int', 'DeleteObject', _
			'hwnd', $hObj)
	Return $bResult[0]
EndFunc   ;==>DeleteObject

Func CreateCompatibleDC($hDC)
	Local $hCompDC = DllCall('gdi32.dll', 'hwnd', 'CreateCompatibleDC', _
			'hwnd', $hDC)
	Return $hCompDC[0]
EndFunc   ;==>CreateCompatibleDC

Func DeleteDC($hDC)
	Local $bResult = DllCall('gdi32.dll', 'int', 'DeleteDC', _
			'hwnd', $hDC)
	Return $bResult[0]
EndFunc   ;==>DeleteDC

Func BitBlt($hDCDest, $nXDest, $nYDest, $nWidth, $nHeight, $hDCSrc, $nXSrc, $nYSrc, $nOpCode)
	Local $bResult = DllCall('gdi32.dll', 'int', 'BitBlt', _
			'hwnd', $hDCDest, _
			'int', $nXDest, _
			'int', $nYDest, _
			'int', $nWidth, _
			'int', $nHeight, _
			'hwnd', $hDCSrc, _
			'int', $nXSrc, _
			'int', $nYSrc, _
			'long', $nOpCode)
	Return $bResult[0]
EndFunc   ;==>BitBlt

Func GetCurrentObject($hDC, $uiType)
	Local $v_ret = DllCall("gdi32.dll", "hwnd", "GetCurrentObject", "hwnd", $hDC, "int", $uiType)
	Return $v_ret[0]
EndFunc   ;==>GetCurrentObject

Func GetPaletteEntries($hPal, $uiStart, $uiEntries, $ptrPalArray)
	Local $v_ret = DllCall("gdi32.dll", "int", "GetPaletteEntries", "hwnd", $hPal, "int", $uiStart, "int", $uiEntries, "ptr", DllStructGetPtr($ptrPalArray))
	Return $v_ret[0]
EndFunc   ;==>GetPaletteEntries

Func SetDIBColorTable($hPal, $uiStart, $uiEntries, $ptrPalArray)
	Local $v_ret = DllCall("gdi32.dll", "int", "SetDIBColorTable", "hwnd", $hPal, "int", $uiStart, "int", $uiEntries, "ptr", DllStructGetPtr($ptrPalArray))
	Return $v_ret[0]
EndFunc   ;==>SetDIBColorTable

Func CreateDIBSection($hDC, $pBmi, $iUsage = 0, $ppvBits = 0, $hSection = 0, $dwOffset = 0)
	Local $iBitmap = DllCall("gdi32.dll", "hwnd", "CreateDIBSection", "int", $hDC, "ptr", DllStructGetPtr($pBmi), _
			"int", $iUsage, "ptr", $ppvBits, "hwnd", $hSection, "int", $dwOffset)
	Return $iBitmap[0]
EndFunc   ;==>CreateDIBSection
Func CreateCompatibleBitmap($hDC, $nWidth, $nHeight)
	Local $hBitmap = DllCall('gdi32.dll', 'hwnd', 'CreateCompatibleBitmap', _
			'hwnd', $hDC, _
			'int', $nWidth, _
			'int', $nHeight)
	Return $hBitmap[0]
EndFunc   ;==>CreateCompatibleBitmap

Func SetDIBits($aHdc, $hBitmap, $nStartScan, $nNumScans, $ptrBits, $ptrBI, $wUsage)
	Local $v_ret = DllCall("gdi32.dll", "int", "SetDIBits", _
			"int", $aHdc, _
			"hwnd", $hBitmap, _
			"int", $nStartScan, _
			"int", $nNumScans, _
			"ptr", $ptrBits, _
			"ptr", $ptrBI, _
			"int", $wUsage)

	Return $v_ret[0]
EndFunc   ;==>SetDIBits
;----------------------------------------------------------
;UDF Helper Functions
;File.au3
;----------------------------------------------------------
;===============================================================================
;
; Description:      Writes the specified text to a log file.
; Syntax:           _FileWriteLog( $sLogPath, $sLogMsg )
; Parameter(s):     $sLogPath - Path and filename to the log file
;                   $sLogMsg  - Message to be written to the log file
; Requirement(s):   None
; Return Value(s):  On Success - Returns 1
;                   On Failure - Returns 0 and sets:
;                                @error = 1: Error opening specified file
;                                @error = 2: File could not be written to
; Author(s):        Jeremy Landes <jlandes@landeserve.com>
; Note(s):          If the text to be appended does NOT end in @CR or @LF then
;                   a DOS linefeed (@CRLF) will be automatically added.
;
;===============================================================================
Func _FileWriteLog($sLogPath, $sLogMsg)
	;==============================================
	; Local Constant/Variable Declaration Section
	;==============================================
	Local $sDateNow
	Local $sTimeNow
	Local $sMsg
	Local $hOpenFile
	Local $hWriteFile

	$sDateNow = @YEAR & "-" & @MON & "-" & @MDAY
	$sTimeNow = @HOUR & ":" & @MIN & ":" & @SEC
	$sMsg = $sDateNow & " " & $sTimeNow & " : " & $sLogMsg

	$hOpenFile = FileOpen($sLogPath, 1)

	If $hOpenFile = -1 Then
		SetError(1)
		Return 0
	EndIf

	$hWriteFile = FileWriteLine($hOpenFile, $sMsg)

	If $hWriteFile = -1 Then
		SetError(2)
		Return 0
	EndIf

	FileClose($hOpenFile)
	Return 1
EndFunc   ;==>_FileWriteLog
Func PreviewImage(ByRef $byteStruct, $wid, $hgt)
	; Local Const $DIB_RGB_COLORS = 0
	; Local Const $SRCCOPY = 0xCC0020
	Local Const $STM_SETIMAGE = 0x0172
	Local Const $IMAGE_BITMAP = 0

	Local $preview = GUICreate("Preview", 500, 400, (@DesktopWidth - 500) / 2, (@DesktopHeight - 400) / 2)
	Local $pic = GUICtrlCreatePic("", 0, 0, $wid, $hgt)
	Local $pic_hWnd = DllCall("user32.dll", "hwnd", "GetDlgItem", "hwnd", $preview, "int", $pic)
	$pic_hWnd = $pic_hWnd[0]
	GUISetState()
	Local $lpInfo = DllStructCreate($tagBITMAPINFOHEADER & ";" & $tagBITS)

	DllStructSetData($lpInfo, 1, 40)
	DllStructSetData($lpInfo, 2, $wid)
	DllStructSetData($lpInfo, 3, $hgt)
	DllStructSetData($lpInfo, 4, 1)
	DllStructSetData($lpInfo, 5, $bpp)
	Local $dc = GetDC($pic_hWnd)
	if ($dc) Then
		ConsoleWrite("Dc>" & $dc & @LF)
		Local $hBitmap = CreateCompatibleBitmap($dc, $wid, $hgt)
		If $hBitmap Then
			ConsoleWrite("$hBitmap>" & $hBitmap & @LF)
			Local $v_ret = SetDIBits($dc, $hBitmap, 0, $hgt, DllStructGetPtr($byteStruct), DllStructGetPtr($lpInfo), $DIB_RGB_COLORS)
			if ($v_ret) Then
				ConsoleWrite("$v_ret>" & $v_ret & @LF)
				Local $vret = DllCall("user32.dll", "int", "SendMessage", "hwnd", $pic_hWnd, "int", $STM_SETIMAGE, "int", $IMAGE_BITMAP, "hwnd", $hBitmap)
				If $vret[0] Then ConsoleWrite("SendMessage>" & $v_ret[0] & @LF)

			EndIf
		EndIf
		Sleep(3000)
		GUIDelete($preview)
		ReleaseDC($pic_hWnd, $dc)
	EndIf
	$lpInfo = 0
EndFunc   ;==>PreviewImage
