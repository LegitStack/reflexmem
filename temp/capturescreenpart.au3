#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <ScreenCapture.au3>
#Include <Misc.au3>

Global $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path

; Create GUI
$hMain_GUI = GUICreate("Select Rectangle", 240, 50)

$hRect_Button   = GUICtrlCreateButton("Mark Area",  10, 10, 80, 30)
$hCancel_Button = GUICtrlCreateButton("Cancel",    150, 10, 80, 30)

GUISetState()

While 1

    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE, $hCancel_Button
            FileDelete(@ScriptDir & "\Rect.bmp")
            Exit
        Case $hRect_Button
            GUISetState(@SW_HIDE, $hMain_GUI)
            Mark_Rect()
            ; Capture selected area
            $sBMP_Path = @ScriptDir & "\Rect.bmp"
            ScreenCapture_Capture_DPI_Aware($sBMP_Path, $iX1, $iY1, $iX2, $iY2, False)
            GUISetState(@SW_SHOW, $hMain_GUI)
            ; Display image
            $hBitmap_GUI = GUICreate("Selected Rectangle", $iX2 - $iX1 + 1, $iY2 - $iY1 + 1, 100, 100)
            $hPic = GUICtrlCreatePic(@ScriptDir & "\Rect.bmp", 0, 0, $iX2 - $iX1 + 1, $iY2 - $iY1 + 1)
            GUISetState()

    EndSwitch

WEnd

; -------------

Func Mark_Rect()

    Local $aMouse_Pos, $hMask, $hMaster_Mask, $iTemp
    Local $UserDLL = DllOpen("user32.dll")

    Global $hRectangle_GUI = GUICreate("", @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST)
    _GUICreateInvRect($hRectangle_GUI, 0, 0, 1, 1)
    GUISetBkColor(0)
    WinSetTrans($hRectangle_GUI, "", 50)
    GUISetState(@SW_SHOW, $hRectangle_GUI)
    GUISetCursor(3, 1, $hRectangle_GUI)

    ; Wait until mouse button pressed
    While Not _IsPressed("01", $UserDLL)
        Sleep(10)
    WEnd

    ; Get first mouse position
    $aMouse_Pos = MouseGetPos()
    $iX1 = $aMouse_Pos[0]*2
    $iY1 = $aMouse_Pos[1]*2

  ;  ; Draw rectangle while mouse button pressed
 ;   While _IsPressed("01", $UserDLL)
;
 ;       $aMouse_Pos = MouseGetPos()
;
;      ;  ; Set in correct order if required
     ;   If $aMouse_Pos[0] < $iX1 Then
    ;        $iX_Pos = $aMouse_Pos[0]
   ;         $iWidth = $iX1 - $aMouse_Pos[0]
  ;      Else
 ;           $iX_Pos = $iX1
;            $iWidth = $aMouse_Pos[0] - $iX1
        ;EndIf
       ; If $aMouse_Pos[1] < $iY1 Then
      ;      $iY_Pos = $aMouse_Pos[1]
     ;       $iHeight = $iY1 - $aMouse_Pos[1]
    ;    Else
   ;         $iY_Pos = $iY1
  ;          $iHeight = $aMouse_Pos[1] - $iY1
 ;       EndIf
;
 ;       _GUICreateInvRect($hRectangle_GUI, $iX_Pos, $iY_Pos, $iWidth, $iHeight)
;
 ;       Sleep(10)
;
;    WEnd


	    ; Draw rectangle while mouse button pressed
    While _IsPressed("01", $UserDLL)

        $aMouse_Pos = MouseGetPos()
	      $jmp0 = $aMouse_Pos[0]*2 ; $aMouse_Pos[0]
		    $jmp1 = $aMouse_Pos[1]*2 ; $aMouse_Pos[1]
        ; Set in correct order if required
        If $jmp0 < $iX1 Then
            $iX_Pos = $jmp0
            $iWidth = $iX1 - $jmp0
        Else
            $iX_Pos = $iX1
            $iWidth = $jmp0 - $iX1
        EndIf
        If $jmp1 < $iY1 Then
            $iY_Pos = $jmp1
            $iHeight = $iY1 - $jmp1
        Else
            $iY_Pos = $iY1
            $iHeight = $jmp1 - $iY1
        EndIf

        _GUICreateInvRect($hRectangle_GUI, $iX_Pos/2, $iY_Pos/2, $iWidth/2, $iHeight/2)

        Sleep(10)

    WEnd

    ; Get second mouse position
    $iX2 = $aMouse_Pos[0]*2
    $iY2 = $aMouse_Pos[1]*2

    ; Set in correct order if required
    If $iX2 < $iX1 Then
        $iTemp = $iX1
        $iX1 = $iX2
        $iX2 = $iTemp
    EndIf
    If $iY2 < $iY1 Then
        $iTemp = $iY1
        $iY1 = $iY2
        $iY2 = $iTemp
    EndIf

    GUIDelete($hRectangle_GUI)
    DllClose($UserDLL)

EndFunc   ;==>Mark_Rect

Func _GUICreateInvRect($hWnd, $iX, $iY, $iW, $iH)

    $hMask_1 = _WinAPI_CreateRectRgn(0, 0, @DesktopWidth, $iY)
    $hMask_2 = _WinAPI_CreateRectRgn(0, 0, $iX, @DesktopHeight)
    $hMask_3 = _WinAPI_CreateRectRgn($iX + $iW, 0, @DesktopWidth, @DesktopHeight)
    $hMask_4 = _WinAPI_CreateRectRgn(0, $iY + $iH, @DesktopWidth, @DesktopHeight)

    _WinAPI_CombineRgn($hMask_1, $hMask_1, $hMask_2, 2)
    _WinAPI_CombineRgn($hMask_1, $hMask_1, $hMask_3, 2)
    _WinAPI_CombineRgn($hMask_1, $hMask_1, $hMask_4, 2)

    _WinAPI_DeleteObject($hMask_2)
    _WinAPI_DeleteObject($hMask_3)
    _WinAPI_DeleteObject($hMask_4)

    _WinAPI_SetWindowRgn($hWnd, $hMask_1, 1)

EndFunc
