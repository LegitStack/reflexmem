;#include <lib\applieddpi.au3>

Func Load_ScreenCapture_High_DPI_Check()
  $R = GetScale()
  if $R == 1 then
    ; should fix this to work with dual monitors. later
  else
    msgbox(64, "r",$R)
    #Region ;**** Directives created by AutoIt3Wrapper_GUI ****
    #AutoIt3Wrapper_Res_HiDpi=Y
    #EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
    DllCall("User32.dll","bool","SetProcessDPIAware")
    ;(work around), first image doesn't work, so take one and throw away.
    _ScreenCapture_Capture("",0,0,@DesktopWidth,@DesktopHeight)
  endif
EndFunc

Load_ScreenCapture_High_DPI_Check()
