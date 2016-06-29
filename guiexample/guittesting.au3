#include <WindowsConstants.au3>
#Include <winapi.au3>
ShellExecute("SnippingTool.exe")
$winHndl = wingethandle("[CLASS:Microsoft-Windows-Tablet-SnipperToolbar]")
$toolbarHndl = ControlGetHandle($winHndl,"","[CLASS:ToolbarWindow32; INSTANCE:1]")
_sendclick()

Func _sendclick()
    Local $lParam = $toolbarHndl
    Local $BN_CLICKED = 0x0000FFFF
    Local $NID = 219
    local $wParam = _WinAPI_MakeLong($NID, $BN_CLICKED)
    $message = _WinAPI_PostMessage($winHndl,$WM_COMMAND,$wParam,$lParam)
EndFunc   ;==>_sendclick
