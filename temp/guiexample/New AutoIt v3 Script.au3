#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIListView.au3>
#include <StructureConstants.au3>

$hGUI = GUICreate("Test", 500, 500)

$hListView_1 = _GUICtrlListView_Create($hGUI, "LV 1              ", 10, 10, 230, 200)
$hListView_2 = _GUICtrlListView_Create($hGUI, "LV 2              ", 260, 10, 230, 200)

For $i = 1 To 30
    _GUICtrlListView_AddItem($hListView_1, "LV 1 Item " & $i)
    _GUICtrlListView_AddItem($hListView_2, "LV 2 Item " & $i)
Next

GUISetState()

GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd

Func _WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)

    #forceref $hWnd, $iMsg, $wParam

    Local $tStruct = DllStructCreate($tagNMHDR, $lParam) ; struct;hwnd hWndFrom;uint_ptr IDFrom;int Code;endstruct
    If @error Then Return
    Switch DllStructGetData($tStruct, "Code") ; Look for the message code
        Case $NM_DBLCLK
            Switch DllStructGetData($tStruct, "hWndFrom") ; Now look for the control that sent it
                Case $hListView_1
                    ConsoleWrite("You clicked LV 1" & @CRLF)
                Case $hListView_2
                    ConsoleWrite("You clicked LV 2" & @CRLF)
            EndSwitch
    EndSwitch

EndFunc   ;==>_WM_NOTIFY