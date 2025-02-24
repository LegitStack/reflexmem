#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <GuiDateTimePicker.au3>
#include <GuiEdit.au3>
#include <GuiReBar.au3>
#include <GuiToolbar.au3>
#include <WindowsConstants.au3>

Global $g_hReBar

Example()

Func Example()
    Local $hGui, $idBtnExit, $hToolbar, $hCombo, $hDTP, $hInput
    Local Enum $e_idNew = 1000, $e_idOpen, $e_idSave, $idHelp

    $hGui = GUICreate("Rebar", 400, 396, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_MAXIMIZEBOX))

    GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

    ; create the rebar control
    $g_hReBar = _GUICtrlRebar_Create($hGui, BitOR($CCS_TOP, $WS_BORDER, $RBS_VARHEIGHT, $RBS_AUTOSIZE, $RBS_BANDBORDERS))

    ; create a toolbar to put in the rebar
    $hToolbar = _GUICtrlToolbar_Create($hGui, BitOR($TBSTYLE_FLAT, $CCS_NORESIZE, $CCS_NOPARENTALIGN))

    ; Add standard system bitmaps
    Switch _GUICtrlToolbar_GetBitmapFlags($hToolbar)
        Case 0
            _GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_SMALL_COLOR)
        Case 2
            _GUICtrlToolbar_AddBitmap($hToolbar, 1, -1, $IDB_STD_LARGE_COLOR)
    EndSwitch

    ; Add buttons
    _GUICtrlToolbar_AddButton($hToolbar, $e_idNew, $STD_FILENEW)
    _GUICtrlToolbar_AddButton($hToolbar, $e_idOpen, $STD_FILEOPEN)
    _GUICtrlToolbar_AddButton($hToolbar, $e_idSave, $STD_FILESAVE)
    _GUICtrlToolbar_AddButtonSep($hToolbar)
    _GUICtrlToolbar_AddButton($hToolbar, $idHelp, $STD_HELP)

    ; create a combobox to put in the rebar
    $hCombo = _GUICtrlComboBox_Create($hGui, "", 0, 0, 120)

    _GUICtrlComboBox_BeginUpdate($hCombo)
    _GUICtrlComboBox_AddDir($hCombo, @WindowsDir & "\*.exe")
    _GUICtrlComboBox_EndUpdate($hCombo)

    ; create a date time picker to put in the rebar
    $hDTP = _GUICtrlDTP_Create($hGui, 0, 0, 190)

    ; create a input box to put in the rebar
    ; $hInput = GUICtrlCreateInput("Input control", 0, 0, 120, 20)
    $hInput = _GUICtrlEdit_Create($hGui, "Input control", 0, 0, 120, 20)

    ; default for add is append

    ; add band with control
    _GUICtrlRebar_AddBand($g_hReBar, $hCombo, 120, 200, "Dir *.exe")

    ; add band with date time picker
    _GUICtrlRebar_AddBand($g_hReBar, $hDTP, 120)

    ; add band with toolbar to beginning of rebar
    _GUICtrlRebar_AddToolBarBand($g_hReBar, $hToolbar, "", 0)

    ;add another control
    ; _GUICtrlRebar_AddBand($g_hReBar, GUICtrlGetHandle($hInput), 120, 200, "Name:")
    _GUICtrlRebar_AddBand($g_hReBar, $hInput, 120, 200, "Name:")

    $idBtnExit = GUICtrlCreateButton("Exit", 150, 360, 100, 25)
    GUISetState(@SW_SHOW)

    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE, $idBtnExit
                Exit
        EndSwitch
    WEnd
EndFunc   ;==>Example

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
    #forceref $hWnd, $iMsg, $wParam
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR
    Local $tAUTOBREAK, $tAUTOSIZE, $tNMREBAR, $tCHEVRON, $tCHILDSIZE, $tOBJECTNOTIFY

    $tNMHDR = DllStructCreate($tagNMHDR, $lParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $g_hReBar
            Switch $iCode
                Case $RBN_AUTOBREAK
                    ; Notifies a rebar's parent that a break will appear in the bar. The parent determines whether to make the break
                    $tAUTOBREAK = DllStructCreate($tagNMREBARAUTOBREAK, $lParam)
                    _DebugPrint("$RBN_AUTOBREAK" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tAUTOBREAK, "hWndFrom") & @CRLF & _
                            "-->IDFrom:" & @TAB & DllStructGetData($tAUTOBREAK, "IDFrom") & @CRLF & _
                            "-->Code:" & @TAB & DllStructGetData($tAUTOBREAK, "Code") & @CRLF & _
                            "-->uBand:" & @TAB & DllStructGetData($tAUTOBREAK, "uBand") & @CRLF & _
                            "-->wID:" & @TAB & DllStructGetData($tAUTOBREAK, "wID") & @CRLF & _
                            "-->lParam:" & @TAB & DllStructGetData($tAUTOBREAK, "lParam") & @CRLF & _
                            "-->uMsg:" & @TAB & DllStructGetData($tAUTOBREAK, "uMsg") & @CRLF & _
                            "-->fStyleCurrent:" & @TAB & DllStructGetData($tAUTOBREAK, "fStyleCurrent") & @CRLF & _
                            "-->fAutoBreak:" & @TAB & DllStructGetData($tAUTOBREAK, "fAutoBreak"))
                    ; Return value not used
                Case $RBN_AUTOSIZE
                    ; Sent by a rebar control created with the $RBS_AUTOSIZE style when the rebar automatically resizes itself
                    $tAUTOSIZE = DllStructCreate($tagNMRBAUTOSIZE, $lParam)
                    _DebugPrint("$RBN_AUTOSIZE" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tAUTOSIZE, "hWndFrom") & @CRLF & _
                            "-->IDFrom:" & @TAB & DllStructGetData($tAUTOSIZE, "IDFrom") & @CRLF & _
                            "-->Code:" & @TAB & DllStructGetData($tAUTOSIZE, "Code") & @CRLF & _
                            "-->fChanged:" & @TAB & DllStructGetData($tAUTOSIZE, "fChanged") & @CRLF & _
                            "-->TargetLeft:" & @TAB & DllStructGetData($tAUTOSIZE, "TargetLeft") & @CRLF & _
                            "-->TargetTop:" & @TAB & DllStructGetData($tAUTOSIZE, "TargetTop") & @CRLF & _
                            "-->TargetRight:" & @TAB & DllStructGetData($tAUTOSIZE, "TargetRight") & @CRLF & _
                            "-->TargetBottom:" & @TAB & DllStructGetData($tAUTOSIZE, "TargetBottom") & @CRLF & _
                            "-->ActualLeft:" & @TAB & DllStructGetData($tAUTOSIZE, "ActualLeft") & @CRLF & _
                            "-->ActualTop:" & @TAB & DllStructGetData($tAUTOSIZE, "ActualTop") & @CRLF & _
                            "-->ActualRight:" & @TAB & DllStructGetData($tAUTOSIZE, "ActualRight") & @CRLF & _
                            "-->ActualBottom:" & @TAB & DllStructGetData($tAUTOSIZE, "ActualBottom"))
                    ; Return value not used
                Case $RBN_BEGINDRAG
                    ; Sent by a rebar control when the user begins dragging a band
                    $tNMREBAR = DllStructCreate($tagNMREBAR, $lParam)
                    _DebugPrint("$RBN_BEGINDRAG" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMREBAR, "hWndFrom") & @CRLF & _
                            "-->IDFrom:" & @TAB & DllStructGetData($tNMREBAR, "IDFrom") & @CRLF & _
                            "-->Code:" & @TAB & DllStructGetData($tNMREBAR, "Code") & @CRLF & _
                            "-->dwMask:" & @TAB & DllStructGetData($tNMREBAR, "dwMask") & @CRLF & _
                            "-->uBand:" & @TAB & DllStructGetData($tNMREBAR, "uBand") & @CRLF & _
                            "-->fStyle:" & @TAB & DllStructGetData($tNMREBAR, "fStyle") & @CRLF & _
                            "-->wID:" & @TAB & DllStructGetData($tNMREBAR, "wID") & @CRLF & _
                            "-->lParam:" & @TAB & DllStructGetData($tNMREBAR, "lParam"))
                    Return 0 ; to allow the rebar to continue the drag operation
                    ; Return 1 ; nonzero to abort the drag operation
                Case $RBN_CHEVRONPUSHED
                    ; Sent by a rebar control when a chevron is pushed
                    ; When an application receives this notification, it is responsible for displaying a popup menu with items for each hidden tool.
                    ; Use the rc member of the NMREBARCHEVRON structure to find the correct position for the popup menu
                    $tCHEVRON = DllStructCreate($tagNMREBARCHEVRON, $lParam)
                    _DebugPrint("$RBN_CHEVRONPUSHED" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tCHEVRON, "hWndFrom") & @CRLF & _
                            "-->IDFrom:" & @TAB & DllStructGetData($tCHEVRON, "IDFrom") & @CRLF & _
                            "-->Code:" & @TAB & DllStructGetData($tCHEVRON, "Code") & @CRLF & _
                            "-->uBand:" & @TAB & DllStructGetData($tCHEVRON, "uBand") & @CRLF & _
                            "-->wID:" & @TAB & DllStructGetData($tCHEVRON, "wID") & @CRLF & _
                            "-->lParam:" & @TAB & DllStructGetData($tCHEVRON, "lParam") & @CRLF & _
                            "-->Left:" & @TAB & DllStructGetData($tCHEVRON, "Left") & @CRLF & _
                            "-->Top:" & @TAB & DllStructGetData($tCHEVRON, "Top") & @CRLF & _
                            "-->Right:" & @TAB & DllStructGetData($tCHEVRON, "Right") & @CRLF & _
                            "-->lParamNM:" & @TAB & DllStructGetData($tCHEVRON, "lParamNM"))
                    ; Return value not used
                Case $RBN_CHILDSIZE
                    ; Sent by a rebar control when a band's child window is resized
                    $tCHILDSIZE = DllStructCreate($tagNMREBARCHILDSIZE, $lParam)
                    _DebugPrint("$RBN_CHILDSIZE" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tCHILDSIZE, "hWndFrom") & @CRLF & _
                            "-->IDFrom:" & @TAB & DllStructGetData($tCHILDSIZE, "IDFrom") & @CRLF & _
                            "-->Code:" & @TAB & DllStructGetData($tCHILDSIZE, "Code") & @CRLF & _
                            "-->uBand:" & @TAB & DllStructGetData($tCHILDSIZE, "uBand") & @CRLF & _
                            "-->wID:" & @TAB & DllStructGetData($tCHILDSIZE, "wID") & @CRLF & _
                            "-->CLeft:" & @TAB & DllStructGetData($tCHILDSIZE, "CLeft") & @CRLF & _
                            "-->CTop:" & @TAB & DllStructGetData($tCHILDSIZE, "CTop") & @CRLF & _
                            "-->CRight:" & @TAB & DllStructGetData($tCHILDSIZE, "CRight") & @CRLF & _
                            "-->CBottom:" & @TAB & DllStructGetData($tCHILDSIZE, "CBottom") & @CRLF & _
                            "-->BLeft:" & @TAB & DllStructGetData($tCHILDSIZE, "BandLeft") & @CRLF & _
                            "-->BTop:" & @TAB & DllStructGetData($tCHILDSIZE, "BTop") & @CRLF & _
                            "-->BRight:" & @TAB & DllStructGetData($tCHILDSIZE, "BRight") & @CRLF & _
                            "-->BBottom:" & @TAB & DllStructGetData($tCHILDSIZE, "BBottom"))
                    ; Return value not used
                Case $RBN_DELETEDBAND
                    ; Sent by a rebar control after a band has been deleted
                    $tNMREBAR = DllStructCreate($tagNMREBAR, $lParam)
                    _DebugPrint("$RBN_DELETEDBAND" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMREBAR, "hWndFrom") & @CRLF & _
                            "-->IDFrom:" & @TAB & DllStructGetData($tNMREBAR, "IDFrom") & @CRLF & _
                            "-->Code:" & @TAB & DllStructGetData($tNMREBAR, "Code") & @CRLF & _
                            "-->dwMask:" & @TAB & DllStructGetData($tNMREBAR, "dwMask") & @CRLF & _
                            "-->uBand:" & @TAB & DllStructGetData($tNMREBAR, "uBand") & @CRLF & _
                            "-->fStyle:" & @TAB & DllStructGetData($tNMREBAR, "fStyle") & @CRLF & _
                            "-->wID:" & @TAB & DllStructGetData($tNMREBAR, "wID") & @CRLF & _
                            "-->lParam:" & @TAB & DllStructGetData($tNMREBAR, "lParam"))
                    ; Return value not used
                Case $RBN_DELETINGBAND
                    ; Sent by a rebar control when a band is about to be deleted
                    $tNMREBAR = DllStructCreate($tagNMREBAR, $lParam)
                    _DebugPrint("$RBN_DELETINGBAND" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMREBAR, "hWndFrom") & @CRLF & _
                            "-->IDFrom:" & @TAB & DllStructGetData($tNMREBAR, "IDFrom") & @CRLF & _
                            "-->Code:" & @TAB & DllStructGetData($tNMREBAR, "Code") & @CRLF & _
                            "-->dwMask:" & @TAB & DllStructGetData($tNMREBAR, "dwMask") & @CRLF & _
                            "-->uBand:" & @TAB & DllStructGetData($tNMREBAR, "uBand") & @CRLF & _
                            "-->fStyle:" & @TAB & DllStructGetData($tNMREBAR, "fStyle") & @CRLF & _
                            "-->wID:" & @TAB & DllStructGetData($tNMREBAR, "wID") & @CRLF & _
                            "-->lParam:" & @TAB & DllStructGetData($tNMREBAR, "lParam"))
                    ; Return value not used
                Case $RBN_ENDDRAG
                    ; Sent by a rebar control when the user stops dragging a band
                    $tNMREBAR = DllStructCreate($tagNMREBAR, $lParam)
                    _DebugPrint("$RBN_ENDDRAG" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMREBAR, "hWndFrom") & @CRLF & _
                            "-->IDFrom:" & @TAB & DllStructGetData($tNMREBAR, "IDFrom") & @CRLF & _
                            "-->Code:" & @TAB & DllStructGetData($tNMREBAR, "Code") & @CRLF & _
                            "-->dwMask:" & @TAB & DllStructGetData($tNMREBAR, "dwMask") & @CRLF & _
                            "-->uBand:" & @TAB & DllStructGetData($tNMREBAR, "uBand") & @CRLF & _
                            "-->fStyle:" & @TAB & DllStructGetData($tNMREBAR, "fStyle") & @CRLF & _
                            "-->wID:" & @TAB & DllStructGetData($tNMREBAR, "wID") & @CRLF & _
                            "-->lParam:" & @TAB & DllStructGetData($tNMREBAR, "lParam"))
                    ; Return value not used
                Case $RBN_GETOBJECT
                    ; Sent by a rebar control created with the $RBS_REGISTERDROP style when an object is dragged over a band in the control
                    $tOBJECTNOTIFY = DllStructCreate($tagNMOBJECTNOTIFY, $lParam)
                    _DebugPrint("$RBN_GETOBJECT" & @CRLF & "--> hWndFrom:" & @TAB & DllStructGetData($tOBJECTNOTIFY, "hWndFrom") & @CRLF & _
                            "-->IDFrom:" & @TAB & DllStructGetData($tOBJECTNOTIFY, "IDFrom") & @CRLF & _
                            "-->Code:" & @TAB & DllStructGetData($tOBJECTNOTIFY, "Code") & @CRLF & _
                            "-->Item:" & @TAB & DllStructGetData($tOBJECTNOTIFY, "Item") & @CRLF & _
                            "-->piid:" & @TAB & DllStructGetData($tOBJECTNOTIFY, "piid") & @CRLF & _
                            "-->pObject:" & @TAB & DllStructGetData($tOBJECTNOTIFY, "pObject") & @CRLF & _
                            "-->Result:" & @TAB & DllStructGetData($tOBJECTNOTIFY, "Result"))
                    ; Return value not used
                Case $RBN_HEIGHTCHANGE
                    ; Sent by a rebar control when its height has changed
                    ; Rebar controls that use the $CCS_VERT style send this notification message when their width changes
                    _DebugPrint("$RBN_HEIGHTCHANGE" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
                            "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
                            "-->Code:" & @TAB & $iCode)
                    ; Return value not used
                Case $RBN_LAYOUTCHANGED
                    ; Sent by a rebar control when the user changes the layout of the control's bands
                    _DebugPrint("$RBN_LAYOUTCHANGED" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
                            "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
                            "-->Code:" & @TAB & $iCode)
                    ; Return value not used
                Case $RBN_MINMAX
                    ; Sent by a rebar control prior to maximizing or minimizing a band
                    _DebugPrint("$RBN_MINMAX" & @CRLF & "--> hWndFrom:" & @TAB & $hWndFrom & @CRLF & _
                            "-->IDFrom:" & @TAB & $iIDFrom & @CRLF & _
                            "-->Code:" & @TAB & $iCode)
                    ; Return 1 ; a non-zero value to prevent the operation from taking place
                    Return 0 ; zero to allow it to continue
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _DebugPrint($s_Text, $sLine = @ScriptLineNumber)
    ConsoleWrite( _
            "!===========================================================" & @CRLF & _
            "+======================================================" & @CRLF & _
            "-->Line(" & StringFormat("%04d", $sLine) & "):" & @TAB & $s_Text & @CRLF & _
            "+======================================================" & @CRLF)
EndFunc   ;==>_DebugPrint
