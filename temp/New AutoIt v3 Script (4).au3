#include <GUIConstants.au3>

GUICreate("Lupe",202,202,@DesktopWidth-204,0,$WS_BORDER)
GUISetState (@SW_SHOW)

$hwnd = DllCall("user32.dll","hwnd","GetDesktopWindow")
$DC = DllCall("user32.dll","ptr","GetWindowDC","hwnd",$hwnd[0])

$lpRect = DllStructCreate("int;int;int;int")
DllCall("user32.dll","int","GetWindowRect","hwnd",$hwnd[0],"ptr",DllStructGetPtr($lpRect))

$cDC = DllCall("gdi32.dll","ptr","CreateCompatibleDC","ptr",$DC[0])
$hbmp = DllCall("gdi32.dll","hwnd","CreateCompatibleBitmap","ptr",$DC[0],"int",DllStructGetData($lpRect,3),"int",DllStructGetData($lpRect,3))
DllCall("gdi32.dll","hwnd","SelectObject","ptr",$cDC[0],"hwnd",$hbmp[0])

While 1
    $msg = GUIGetMsg()
    Lupe()
    If $msg = $GUI_EVENT_CLOSE Then ExitLoop
Wend

DllCall("user32.dll","int","ReleaseDC","hwnd",$hwnd[0],"ptr",$cDC[0])
DllCall("user32.dll","int","ReleaseDC","hwnd",$hwnd[0],"ptr",$DC[0])

Exit

Func Lupe()
$pos = MouseGetPos()
If $pos[0] < 50 Then $pos[0] = 50
If $pos[1] < 50 Then $pos[1] = 50
If $pos[0] >= (@DesktopWidth - 50) Then $pos[0] = @DesktopWidth - 50
If $pos[1] >= (@DesktopHeight - 50) Then $pos[1] = @DesktopHeight - 50

DllCall("gdi32.dll","int","BitBlt","ptr",$cDC[0],"int",0,"int",0,"int",100,"int",100,"ptr",$DC[0],"int",$pos[0]-50,"int",$pos[1]-50,"int",0x00CC0020)

$GUIhwnd = WinGetHandle("Lupe")
$GUIDC = DllCall("user32.dll","ptr","GetWindowDC","hwnd",$GUIhwnd)
;DllCall("gdi32.dll","int","StretchBlt","ptr",$GUIDC[0],"int",2,"int",2,"int",200,"int",200,"ptr",$cDC[0],"int",0,"int",0,"int",100,"int",100,"int",0x00CC0020)
;DllCall("gdi32.dll","int","StretchBlt","ptr",$GUIDC[0],"int",2,"int",2,"int",100,"int",100,"ptr",$cDC[0],"int",0,"int",0,"int",100,"int",100,"int",0x00CC0020)
;DllCall("gdi32.dll","int","BitBlt"    ,"ptr",$GUIDC[0],"int",2,"int",2,"int",100,"int",100,"ptr",$DC[0],"int",$pos[0]-50,"int",$pos[1]-50,"int",0x00CC0020)
EndFunc
