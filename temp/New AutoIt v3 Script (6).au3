#include <WinAPI.au3>
#include <GDIPlus.au3>
Local $hWnd = ControlGetHandle("[CLASS:Notepad]","","Edit1")
Local $pos = ControlGetPos($hWnd,"","")
;MsgBox($MB_OK, "OK", $pos[0])
Local $Width = $pos[2]
Local $Height = $pos[3]

Local $hDC = _WinAPI_GetDC($hWnd)
Local $memDC = _WinAPI_CreateCompatibleDC($hDC)
Local $memBmp = _WinAPI_CreateCompatibleBitmap($hDC, $Width, $Height)

Local $bmpOriginal = _WinAPI_SelectObject ($memDC, $memBmp)  ;store original DC bitmap

DllCall("User32.dll","int","PrintWindow","hwnd",$hWnd,"hdc",$memDC,"int",0)

;_WinAPI_BitBlt($hDC, 0, 0, $Width, $Height, $memDC, 0,0, $SRCCOPY)
_WinAPI_BitBlt($memDC, 0, 0, $Width, $Height, $hDC, 0,0, "SRCCOPY") ;this is working now!

_GDIPlus_Startup()
Local $hBMP=_GDIPlus_BitmapCreateFromHBITMAP($memBmp)
Local $hHBITMAP=_GDIPlus_BitmapCreateHBITMAPFromBitmap($hBMP)

$sPath = @ScriptDir & '\capture.bmp'
_WinAPI_SaveHBITMAPToFile($sPath, $hHBITMAP)

_WinAPI_DeleteObject($hDC)
_WinAPI_ReleaseDC($hWnd, $hDC)
_WinAPI_DeleteDC($memDC)
_WinAPI_DeleteObject ($memBmp)
_WinAPI_DeleteDC($hDC)


; when done with the DC, first select back the original bitmap
_WinAPI_SelectObject( $memDC, $bmpOriginal )
; now we can delete memory bitmap since it is no longer needed
_WinAPI_DeleteObject( $memBmp )
; delete memory DC since we performed proper cleanup
_WinAPI_DeleteDC( $memDC )
; release window's DC
_WinAPI_ReleaseDC( $hwnd, $hDC )


