#include <lib\applieddpi.au3>

Func ScreenCapture_Capture_DPI_Aware($sBMP_Path, $iX1, $iY1, $iX2, $iY2, $bool)
  $R = GetScale()
  return _ScreenCapture_Capture($sBMP_Path, $iX1*$R, $iY1*$R, $iX2*$R, $iY2*$R, $bool)
EndFunc



Func SaveScreen(ByRef $imagecount, $left = 0, $top = 0, $right = -1, $bottom = -1, $scrub = false, $shouldkeep = true)

  Local $i = 0
  While FileExists(GetImagePath() & $i & ".png")
    $i = $i + 1
  WEnd

  local $outimage = GetImagePath() & $i & ".png"
  Local $bmp =ScreenCapture_Capture_DPI_Aware("", $left, $top, $right, $bottom)

  if $right = -1 then $right = @DesktopWidth
  if $bottom = -1 then $bottom = @DesktopHeight

  ;_SaveLocation($i, $left, $top, $right, $bottom) ;user knows location.

	;200,000px*20 = 4,000,000px ;4m/((r-l)*(b-t)) ;round(4,000,000/((1000-10)*(500-220))) == 14.4
	local $responsivescale = Round(4000000/(abs($right-$left)*abs($bottom-$top)))
	if $responsivescale < 2 then
		$responsivescale = 2
	elseif $responsivescale > 20 then
		$responsivescale = 20
	endif

  _ScaleImage($bmp, $outimage, abs($right - $left), abs($bottom - $top), $responsivescale)

  local $read = _GetOCR($outimage, $i, $scrub)
	$imagecount = $i
	if $shouldkeep then
		DeleteCache($i)
	endif
	return $read
	;if $addtoall then
	;	_AddToAnswers($i)
	;EndIf
EndFunc


Func _ScaleImage($bmp, $outimage, $w, $h, $scale) ;to make accuracy better.

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
