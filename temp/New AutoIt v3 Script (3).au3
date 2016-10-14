Local $Me = DllCall("user32.dll", "hwnd", "GetDesktopWindow")
DllCall("captdll.dll", "int", "CaptureRegion", "str", "?.bmp", "int", 100, "int", 100, "int", 300, "int", 200, "int", -1)
