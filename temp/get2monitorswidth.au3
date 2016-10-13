#include <WinAPI.au3>

$iFullDesktopWidth = _WinAPI_GetSystemMetrics(78)
$iFullDesktopWidth = @desktopwidth
$iFullDesktopHeight = _WinAPI_GetSystemMetrics(79)
while 1
tooltip($iFullDesktopWidth)
wend
