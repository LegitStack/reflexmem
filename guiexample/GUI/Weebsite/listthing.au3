#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>

GUICreate("Lokyweb Uploader", -1, -1, -1, -1, BitOr($WS_SIZEBOX, $WS_SYSMENU, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX), $WS_EX_ACCEPTFILES);x il drag & drop

$listview = GUICtrlCreateListView("List of Running Programs", 2, 40, 394, 268, BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT, $LVS_SINGLESEL))
_GUICtrlListView_AddItem($listview, "test1", 1)
_GUICtrlListView_AddItem($listview, "test2", 2)

$button = GUICtrlCreateButton("Selected program", 10, 325)
$button1 = GUICtrlCreateButton("SCancel", 200, 325)
GUISetState()

While (1)
    $msg = GUIGetMsg()

    if $msg = $button Then
        $iIndex = _GUICtrlListView_GetSelectedIndices($listview)
        msgbox (0, "Selected item", $iIndex)
    EndIf
    If $msg = $GUI_EVENT_CLOSE Then ExitLoop
WEnd