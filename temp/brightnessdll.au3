#include <WinAPI.au3>
#include <ScreenCapture.au3>
#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <WinAPIGdi.au3>
Func _findTargetPixel(ByRef $tHnd, ByRef $targetCoord, $targetPixelColor)
    local $h = _WinAPI_GetWindowHeight($tHnd)
    local $w = _WinAPI_GetWindowWidth($tHnd)

    local $hDC = _WinAPI_GetWindowDC($tHnd)
    if not $hDC then
        MsgBox(0, "hDC", _WinAPI_GetLastError())
        return 0
    EndIf

    local $hdcMem = _WinAPI_CreateCompatibleDC($hDC)
    if not $hdcMem then
        MsgBox(0, "hdcMem", _WinAPI_GetLastError())
        return 0
    EndIf

    local $hBmp = _WinAPI_CreateCompatibleBitmap($hDC, $w, $h)
    if not $hBmp then
        MsgBox(0, "hBmp", _WinAPI_GetLastError())
        return 0
    EndIf

    local $hOld = _WinAPI_SelectObject($hdcMem, $hBmp)

    For $i = 0 to UBound($targetCoord) - 1
        _WinAPI_SetLastError(0)
        Local $result = DLLCall("gdi32.dll", "int", "GetPixel", "ptr", $hDC, "int", $targetCoord[$i][0], "int", $targetCoord[$i][1])
        if @error or _WinAPI_GetLastError() then
             MsgBox(0, "Error", "Error in _GetPixelColor" & @CR & "AutoIT @error " & @error & @CR & _WinAPI_GetLastError() & _WinAPI_GetLastErrorMessage() & @CR & "Found Color " & Hex($result[0],6) & @CR)
        else
          _WinAPI_ReleaseDC($tHnd, $hDC)
          If $result[0] = $targetPixelColor Then
              return $i
          Else
              return -2
          EndIF
        EndIf
        If $result[0] = $targetPixelColor Then
            _WinAPI_ReleaseDC($tHnd, $hDC)
            return $i ; target found in position $i
        EndIf
    Next

    _WinAPI_ReleaseDC($tHnd, $hDC)
    return -1
EndFunc
Local $hTimer = TimerInit() ; Begin the timer and store the handle in a variable.
local $hDC = _WinAPI_GetWindowDC(0)
for $i = 0 to 100
Local $result = DLLCall("gdi32.dll", "int", "GetPixel", "ptr", $hDC, "int", 100, "int", 100)
next
msgbox(64, TimerDiff($hTimer), "GetPixel  = 0x" & Hex($result[0], 6) & @LF)
Local $hTimer = TimerInit()
;https://msdn.microsoft.com/en-us/library/ms646310(v=vs.85).aspx
;https://msdn.microsoft.com/query/dev10.query?appId=Dev10IDEF1&l=EN-US&k=k(mouse_event);k(DevLang-C);k(TargetOS-WINDOWS)&rd=true
;https://www.autoitscript.com/autoit3/docs/libfunctions/_WinAPI_Mouse_Event.htm

;Using GDI+ BitmapGetPixel

for $i = 0 to 100
  $sc =_ScreenCapture_Capture ( "" , 100 , 100, 100, 100, false)
  $iArgb = _GDIPlus_BitmapGetPixel($sc, 0, 0)
next
msgbox(64,TimerDiff($hTimer), "GetPixel  = 0x" & Hex($iArgb, 6) & @LF)
Local $hTimer = TimerInit()


for $i = 0 to 100
  $pix = PixelGetColor(100, 100)
next
msgbox(64,TimerDiff($hTimer), "GetPixel  = 0x" & Hex($pix, 6) & @LF)
Local $hTimer = TimerInit()


for $i = 0 to 100
  $pix = _WinAPI_GetPixel($hDC, 100, 100)
next
msgbox(64,TimerDiff($hTimer), "GetPixel  = 0x" & Hex($pix, 6) & @LF)
