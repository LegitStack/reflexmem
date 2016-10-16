;#include <lib\applieddpi.au3>
DllCall("User32.dll", "bool", "SetProcessDPIAwareness")

Func ScreenCapture_Capture_DPI_Aware($sBMP_Path, $iX1, $iY1, $iX2, $iY2, $bool)
  $R = GetScale()
  if $R == 1 then
    ; should fix this to work with dual monitors.
    return _ScreenCapture_Capture($sBMP_Path, $iX1, $iY1, $iX2, $iY2, $bool)
  else
    ; get contents of clipboard, save to variable
    ; put a screen capture on the clipboard by pressing the print screen button
    ; get the region of the bitmap from the clipboard image
    ; save that region image to a file
    ; put the stuff back on the clipboard from that variable
  endif
EndFunc
