;#include <lib\applieddpi.au3>

Func Load_ScreenCapture_High_DPI_Check()
  $R = GetScale()
  if $R == 1 then
    ; should fix this to work with dual monitors.
  else
    msgbox(64, "r",$R)
    #Region ;**** Directives created by AutoIt3Wrapper_GUI ****
    #AutoIt3Wrapper_Res_HiDpi=Y
    #EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
    ;If Not (@Compiled) Then
    DllCall("User32.dll","bool","SetProcessDPIAware")
    _ScreenCapture_Capture("",0,0,@DesktopWidth,@DesktopHeight)
    ; get contents of clipboard, save to variable
    ; put a screen capture on the clipboard by pressing the print screen button
    ; get the region of the bitmap from the clipboard image
    ; save that region image to a file
    ; put the stuff back on the clipboard from that variable
  endif
EndFunc

Func ScreenCapture_Capture_DPI_Aware($sBMP_Path, $iX1, $iY1, $iX2, $iY2, $bool)

  return _ScreenCapture_Capture($sBMP_Path, $iX1, $iY1, $iX2, $iY2, $bool)

EndFunc


Load_ScreenCapture_High_DPI_Check()
