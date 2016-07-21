#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <File.au3>
#include <Misc.au3>
#include <GuiListBox.au3>
Global $hGUI = GUICreate("ReflexMem Create", 600, 540, -1, -1)

Local $hChild3 = GUICreate("Program is Running Trigger", 400, 200, -1, -1, -1, -1, $hGUI)
GUICtrlCreateLabel("Which program should this trigger watch for?", 20, 20, 360, 35)
GUICtrlSetStyle(-1, $SS_CENTER)
local $g_hListBox = _GUICtrlListBox_Create($hChild3, "String upon creation", 2, 2, 396, 196)

GUISetState()
    GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

    ; Add files
    _GUICtrlListBox_BeginUpdate($g_hListBox)
    _GUICtrlListBox_ResetContent($g_hListBox)
    _GUICtrlListBox_InitStorage($g_hListBox, 100, 4096)
    _GUICtrlListBox_Dir($g_hListBox, @WindowsDir & "\win*.exe")
    _GUICtrlListBox_AddFile($g_hListBox, @WindowsDir & "\notepad.exe")
    _GUICtrlListBox_Dir($g_hListBox, "", $DDL_DRIVES)
    _GUICtrlListBox_Dir($g_hListBox, "", $DDL_DRIVES, False)
    _GUICtrlListBox_EndUpdate($g_hListBox)

    ; Loop until the user exits.
    Do
    Until GUIGetMsg() = $GUI_EVENT_CLOSE


Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
    #forceref $hWnd, $iMsg
    Local $hWndFrom, $iIDFrom, $iCode, $hWndListBox
    If Not IsHWnd($g_hListBox) Then $hWndListBox = GUICtrlGetHandle($g_hListBox)
    $hWndFrom = $lParam
    $iIDFrom = BitAND($wParam, 0xFFFF) ; Low Word
    $iCode = BitShift($wParam, 16) ; Hi Word

    Switch $hWndFrom
        Case $g_hListBox, $hWndListBox
            Switch $iCode
			Case $LBN_DBLCLK ; Sent when the user double-clicks a string in a list box
			   ;MsgBox(64, "hello","")
                    ; no return value
                Case $LBN_ERRSPACE ; Sent when a list box cannot allocate enough memory to meet a specific request
                    ; no return value
                Case $LBN_KILLFOCUS ; Sent when a list box loses the keyboard focus
                    ; no return value
                Case $LBN_SELCANCEL ; Sent when the user cancels the selection in a list box
                    ; no return value
                Case $LBN_SELCHANGE ; Sent when the selection in a list box has changed
                    ; no return value
				  local $aItems
				  local $sItems
				  $aItems = _GUICtrlListBox_GetSelItemsText($hWndListBox)
				   For $iI = 1 To $aItems[0]
					   $sItems &= @CRLF & $aItems[$iI]
				   Next
				   MsgBox(64, "Information", "Items Selected: " & "$LBN_SELCHANGE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
                            "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
                            "-->Code:" & @TAB & $iCode)

				 Case $LBN_SETFOCUS ; Sent when a list box receives the keyboard focus
					;MsgBox(64, "hello","")
                    ; no return value
            EndSwitch
    EndSwitch
    ; Proceed the default AutoIt3 internal message commands.
    ; You also can complete let the line out.
    ; !!! But only 'Return' (without any value) will not proceed
    ; the default AutoIt3-message in the future !!!
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

