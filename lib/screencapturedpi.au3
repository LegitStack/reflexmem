;#include <lib\applieddpi.au3>

Func ScreenCapture_Capture_DPI_Aware($sBMP_Path, $iX1, $iY1, $iX2, $iY2, $bool)
  $R = GetScale()

  Local $bmp = _ScreenCapture_Capture($sBMP_Path, $iX1*$R, $iY1*$R, $iX2*$R, $iY2*$R, $bool)

;  _ScaleImage($bmp, $sBMP_Path, abs($iX2 - $iX1), abs($iY2 - $iY1), $R)

  ;return _ScreenCapture_Capture($sBMP_Path, $iX1*$R, $iY1*$R, $iX2*$R, $iY2*$R, $bool)
EndFunc
