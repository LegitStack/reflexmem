
#include <ScreenCapture.au3>


#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_HiDpi=Y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

If Not (@Compiled) Then DllCall("User32.dll","bool","SetProcessDPIAware")

$sFileName='test.jpg'
_ScreenCapture_Capture($sFileName,0,0,@DesktopWidth,@DesktopHeight)
ShellExecute($sFileName)