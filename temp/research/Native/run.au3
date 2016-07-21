Opt("MouseCoordMode", 0)
Opt("PixelCoordMode", 0)

HotKeySet("{F7}", "GetString")

Func GetString()
    $string = _OCR(321, 231, 512, 242, 0xFFFFFF)
    MsgBox(0, "", $string)
EndFunc
