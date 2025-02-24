;ultimate work around
; get contents of clipboard, save to variable
; put a screen capture on the clipboard by pressing the print screen button
; get the region of the bitmap from the clipboard image
; save that region image to a file
; put the stuff back on the clipboard from that variable






;#include <lib\applieddpi.au3>

;Func _ScreenCapture_Capture($sBMP_Path, $iX1, $iY1, $iX2, $iY2, $bool)
;  $R = GetScale()

;  Local $bmp = _ScreenCapture_Capture("", $iX1*$R, $iY1*$R, $iX2*$R, $iY2*$R, $bool)

;  _ScaleImage($bmp, $sBMP_Path, abs($iX2 - $iX1), abs($iY2 - $iY1), $R)

  ;return _ScreenCapture_Capture($sBMP_Path, $iX1*$R, $iY1*$R, $iX2*$R, $iY2*$R, $bool)
;EndFunc

;Func _ScaleImage($bmp, $outimage, $w, $h, $scale)

;  _GDIPlus_Startup()
    ;Get the encoder of to save the resized image in the format you want.
;    Local $Ext = StringUpper(StringMid($outimage, StringInStr($outimage, ".", 0, -1) + 1))
;    $CLSID = _GDIPlus_EncodersGetCLSID($Ext)
    ; code found here : https://www.autoitscript.com/autoit3/docs/libfunctions/_GDIPlus_ImageSaveToStream.htm
;    Local $sImgCLSID = _GDIPlus_EncodersGetCLSID("png") ;create CLSID for a JPG image file type
;    Local $tGUID = _WinAPI_GUIDFromString($sImgCLSID) ;convert CLSID GUID to binary form and returns $tagGUID structure
;    Local $tParams = _GDIPlus_ParamInit(1) ;initialize an encoder parameter list and return $tagGDIPENCODERPARAMS structure
;    Local $tData = DllStructCreate("int Quality") ;create struct to set JPG quality setting
;    DllStructSetData($tData, "Quality", 100) ;quality 0-100 (0: lowest, 100: highest)
;    Local $pData = DllStructGetPtr($tData) ;get pointer from quality struct
;    _GDIPlus_ParamAdd($tParams, $GDIP_EPGQUALITY, 1, $GDIP_EPTLONG, $pData) ;add a value to an encoder parameter list

;    Local $gbmp = _GDIPlus_BitmapCreateFromHBITMAP($bmp)
;    _WinAPI_DeleteObject($bmp)

;    Local $gsbmp = _GDIPlus_ImageResize($gbmp, $w * $scale, $h * $scale)
    ;Local $ext = _GDIPlus_EncodersGetCLSID("PNG")
;    _GDIPlus_ImageSaveToFileEx($gsbmp, $outimage, $sImgCLSID)

;    _GDIPlus_BitmapDispose($gbmp)
;    _GDIPlus_BitmapDispose($gsbmp)
;  _GDIPlus_Shutdown()
;EndFunc


#include <GUIConstantsEx.au3>
#include <ScreenCapture.au3>

Func _ScreenCapture_Capture($sBMP_Path, $iX1, $iY1, $iX2, $iY2, $bool)
  $R = GetScale()
    _GDIPlus_Startup()
    Local Const $iW = @DesktopWidth / 2, $iH = @DesktopHeight / 2
    Local $hGUI = GUICreate("GDI+ test", $iW, $iH, -1, -1)
    GUISetState(@SW_SHOW)

    Local $hHBmp = _ScreenCapture_Capture("", $iX1*$R, $iY1*$R, $iX2*$R, $iY2*$R, $bool) ;create a GDI bitmap by capturing 1/4 of desktop
    Local $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hHBmp) ;convert GDI bitmap to GDI+ bitmap
    _WinAPI_DeleteObject($hHBmp) ;release GDI bitmap resource because not needed anymore

    Local $sImgCLSID = _GDIPlus_EncodersGetCLSID("bmp") ;create CLSID for a JPG image file type
    Local $tGUID = _WinAPI_GUIDFromString($sImgCLSID) ;convert CLSID GUID to binary form and returns $tagGUID structure
    Local $tParams = _GDIPlus_ParamInit(1) ;initialize an encoder parameter list and return $tagGDIPENCODERPARAMS structure
    Local $tData = DllStructCreate("int Quality") ;create struct to set JPG quality setting
    DllStructSetData($tData, "Quality", 100) ;quality 0-100 (0: lowest, 100: highest)
    Local $pData = DllStructGetPtr($tData) ;get pointer from quality struct
    _GDIPlus_ParamAdd($tParams, $GDIP_EPGQUALITY, 1, $GDIP_EPTLONG, $pData) ;add a value to an encoder parameter list
    Local $pStream = _WinAPI_CreateStreamOnHGlobal() ;create stream

    ;DllCall("gdi32.dll","int","StretchBlt","ptr",$GUIDC[0],"int",2,"int",2,"int",100,"int",100,"ptr",$cDC[0],"int",0,"int",0,"int",100,"int",100,"int",0x00CC0020)

    Local $w = abs($iX2 - $iX1)
    Local $h = abs($iY2 - $iY1)
    $hBitmap = _GDIPlus_ImageResize($hBitmap, $w, $h,7)
    ;_GDIPlus_GraphicsSetInterpolationMode($hBitmap, 4)
    ;msgbox(64,"hBitmap",_GDIPlus_GraphicsGetInterpolationMode($hBitmap))
    ;$hBitmap = _GDIPlus_ImageScale($hBitmap, .5,.5, 2)
    ;msgbox(64,"hBitmap",_GDIPlus_GraphicsGetInterpolationMode($hBitmap))

    ;_GDIPlus_ImageSaveToStream($hBitmap, $pStream, $tGUID, $tParams) ;save the bitmap in JPG format in memory
    ;Local $hBitmapFromStream = _GDIPlus_BitmapCreateFromStream($pStream) ;create bitmap from a stream (here from the JPG in memory)

    Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI) ;create a graphics object from a window handle
    msgbox(64,"hGraphics",_GDIPlus_GraphicsGetInterpolationMode($hGraphics))
    _GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)
    msgbox(64,"hGraphics",_GDIPlus_GraphicsGetInterpolationMode($hGraphics))
    _GDIPlus_GraphicsDrawImage($hGraphics, $hBitmap, 0, 0) ;display streamed image

    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
              _GDIPlus_ImageSaveToFileEx($hBitmap, $sBMP_Path, $sImgCLSID)
              ExitLoop
        EndSwitch
    WEnd

    ;cleanup resources
    _GDIPlus_GraphicsDispose($hGraphics)
    _GDIPlus_BitmapDispose($hBitmap)
    ;_GDIPlus_BitmapDispose($hBitmapFromStream)
    _GDIPlus_Shutdown()
    GUIDelete($hGUI)
EndFunc   ;==>Example
