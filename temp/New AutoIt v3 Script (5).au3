$gui = GUICreate("")
$pic = GUICtrlCreatePic("",0,0,200,200)

GUISetState()

SetBitmapResourceToPicCtrl($gui,$pic,"C:\Users\jmiller.ADS-WCF\Downloads\TestServer.dll",101)

While 1
    If GUIGetMsg() = -3 Then Exit
WEnd

Func SetBitmapResourceToPicCtrl($hwnd,$ctrl,$file,$resource)
    Local Const $STM_SETIMAGE = 0x0172
    Local Const $IMAGE_BITMAP = 0
    Local Const $LR_CREATEDIBSECTION = 0x2000
    Local $A = ControlGetHandle($hwnd,"",$ctrl)
    Local $DLLinst = DLLCall("kernel32.dll","hwnd","LoadLibrary","str",$file)
    $DLLinst = $DLLinst[0]
    Local $hBitmap = DLLCall("user32.dll","hwnd","LoadImage","hwnd",$DLLinst,"short",$resource, _
            "int",$IMAGE_BITMAP,"int",0,"int",0,"int",0)
    $hBitmap = $hBitmap[0]
    _SendMessage($A,$STM_SETIMAGE,$IMAGE_BITMAP,$hBitmap);
    DLLCall("gdi32.dll","int","DeleteObject","hwnd",$hBitmap)
    DLLCall("kernel32.dll","int","FreeLibrary","hwnd",$DLLinst)
EndFunc

Func _SendMessage($hWnd, $msg, $wParam = 0, $lParam = 0, $r = 0, $t1 = "int", $t2 = "int")
    Local $ret = DllCall("user32.dll", "long", "SendMessage", "hwnd", $hWnd, "int", $msg, $t1, $wParam, $t2, $lParam)
    If @error Then Return SetError(@error, @extended, "")
    If $r >= 0 And $r <= 4 Then Return $ret[$r]
    Return $ret
EndFunc ; _SendMessage()
