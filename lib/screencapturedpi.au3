;#include <lib\applieddpi.au3>

Func ScreenCapture_Capture_DPI_Aware($sBMP_Path, $iX1, $iY1, $iX2, $iY2, $bool)
  $R = GetScale()

  Local $bmp = _ScreenCapture_Capture("", $iX1*$R, $iY1*$R, $iX2*$R, $iY2*$R, $bool)

  _ScaleImage($bmp, $sBMP_Path, abs($iX2 - $iX1), abs($iY2 - $iY1), $R)

  ;return _ScreenCapture_Capture($sBMP_Path, $iX1*$R, $iY1*$R, $iX2*$R, $iY2*$R, $bool)
EndFunc

Func _ScaleImage($bmp, $outimage, $w, $h, $scale)

  _GDIPlus_Startup()
  Local $gbmp = _GDIPlus_BitmapCreateFromHBITMAP($bmp)
  _WinAPI_DeleteObject($bmp)

  Local $gsbmp = _GDIPlus_ImageResize($gbmp, $w * $scale, $h * $scale)
  Local $ext = _GDIPlus_EncodersGetCLSID("PNG")
  _GDIPlus_ImageSaveToFileEx($gsbmp, $outimage, $ext)

  _GDIPlus_BitmapDispose($gbmp)
  _GDIPlus_BitmapDispose($gsbmp)
  _GDIPlus_Shutdown()
EndFunc
