#include <WinAPI.au3>
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
local $hDC = _WinAPI_GetWindowDC(0)
for $i = 0 to 1000
Local $result = DLLCall("gdi32.dll", "int", "GetPixel", "ptr", 0, "int", 100, "int", 100)
next
msgbox(64,"", "GetPixel  = 0x" & Hex($result[0], 6) & @LF)

;https://msdn.microsoft.com/en-us/library/ms646310(v=vs.85).aspx
;https://msdn.microsoft.com/query/dev10.query?appId=Dev10IDEF1&l=EN-US&k=k(mouse_event);k(DevLang-C);k(TargetOS-WINDOWS)&rd=true
;https://www.autoitscript.com/autoit3/docs/libfunctions/_WinAPI_Mouse_Event.htm
