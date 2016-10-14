#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPIGdi.au3>
#include <WinAPIMisc.au3>
#include <WinAPISys.au3>
Local $hWnd = ControlGetHandle("[CLASS:Notepad]","","Edit1")
Local $pos = ControlGetPos($hWnd,"","")
;MsgBox($MB_OK, "OK", $pos[0])
Local $Width = $pos[2]
Local $Height = $pos[3]

; Create DDB from DIB to correct display in control
Local $hDC = _WinAPI_GetDC($hWnd)
Local $memDC = _WinAPI_CreateCompatibleDC($hDC)
Local $memBmp = _WinAPI_CreateCompatibleBitmap($hDC, 100,100 )
Local $bmpOriginal = _WinAPI_SelectObject($memDC, $memBmp)  ;store original DC bitmap

DllCall("User32.dll","int","PrintWindow","hwnd",$hWnd,"hdc",$memDC,"int",0)



    DllCall("User32.dll","int","BitBlt", "hdc", $memDC, 0,0,100,100, "hdc" , $hDC, 0,0,"SRCCOPY")
   ;_WinAPI_BitBlt($memDC, 0, 0, $Width, $Height, $hDC, 0,0, $SRCCOPY) ;this is working now!



; Save 8 bits-per-pixel bitmap to .bmp file
Local $sPath = FileSaveDialog('Save Image', @TempDir, 'Bitmap Image Files (*.bmp)', 2 + 16, 'MyImage.bmp')
If $sPath Then
    _WinAPI_SaveHBITMAPToFile($sPath, $hBitmap, 2834, 2834)
EndIf

_WinAPI_SelectObject( $memDC, $bmpOriginal )
_WinAPI_DeleteObject( $memBmp )
_WinAPI_DeleteDC( $memDC )
_WinAPI_ReleaseDC( $hwnd, $hDC )
