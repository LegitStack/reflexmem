#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <ScreenCapture.au3>
#Include <Misc.au3>


; from rmcreate
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <File.au3>
#include <Misc.au3>
#include <GuiListView.au3>
#include <GuiComboBox.au3>
#Include <ScreenCapture.au3>
#include <lib\filelocations.au3>
#include <lib\executeif.au3>
#include <lib\executethen.au3>

; from rmrun
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <Misc.au3>
#include <GuiListView.au3>
#include <FileConstants.au3>
#include <File.au3>
#include <lib\executeif.au3>
#include <lib\executethen.au3>
#include <lib\filelocations.au3>
#include <lib\alllcs.au3>
#include <lib\tesseract_stdout.au3>
#include <lib\combinealllcsandtesseract.au3>
#include <lib\levenshtein.au3>
#include <Crypt.au3>

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
            _ScreenCapture_Capture($sBMP_Path, $iX1, $iY1, $iX2, $iY2, False)
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

mousemove(0,0)







































;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; find the correct image on by first finding the correct zoom (see above)
; from rmcreate

Func ImageOnScreenTrigger()
	;local $w1 = (@desktopwidth/2)-100
	;local $w2 = (@desktopwidth/2)+100
	;local $h1 = (@desktopheight/2)-100
	;local $h2 = (@desktopheight/2)+100
	;local $x1,$y1
	;local $result = _ImageSearchArea("help.png",1,$w1,$h1,$w2,$h2,$x1,$y1,25)
	;if $result = 1 Then
	; $w = False
	;Else
	; ResetView(301)
	; $x = $x + 1
	;EndIf

	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path

	; Create GUI
	local $hMain_GUI = GUICreate("Image On Screen Trigger", 380, 80, -1, -1, -1, -1, $hGUI)
	local $hRect_Button   = GUICtrlCreateButton("Capture Image On Screen",  20, 20, 160, 40)
	local $sFile_Button   = GUICtrlCreateButton("Select Image From File",  200, 20, 160, 40)

	GUISetState()

	local $i, $sFile
	While 1

    Switch GUIGetMsg()
      Case $GUI_EVENT_CLOSE
				GUIDelete($hMain_GUI)
        ;FileDelete(@ScriptDir & "\Rect.bmp")
        ExitLoop
      Case $hRect_Button
	      GUISetState(@SW_HIDE, $hMain_GUI)
	      Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
	      ; Capture selected area
				$i = 0
				While FileExists(GetScriptsPath("images") & $i & ".bmp")
					$i = $i + 1
				WEnd
	      $sBMP_Path = GetScriptsPath("images") & $i & ".bmp"
	    	_ScreenCapture_Capture($sBMP_Path, $iX1, $iY1, $iX2, $iY2, False)
	      GUISetState(@SW_SHOW, $hMain_GUI)
	      ; Display image
	      ;$hBitmap_GUI = GUICreate("Selected Rectangle", $iX2 - $iX1 + 1, $iY2 - $iY1 + 1, 100, 100)
	      ;$hPic = GUICtrlCreatePic(@ScriptDir & "\Rect.bmp", 0, 0, $iX2 - $iX1 + 1, $iY2 - $iY1 + 1)
	      ;GUISetState()
				GUIDelete($hMain_GUI)
				GetAreaImageScreenTrigger($sBMP_Path)
        ExitLoop
			Case $sFile_Button
				local $sFile = FileOpenDialog("Choose Image...", @DesktopCommonDir, "All (*.*)")
				if $sFile == "" then
					GUIDelete($hMain_GUI)
					ExitLoop
				endif
				GUIDelete($hMain_GUI)
				GetAreaImageScreenTrigger($sFile)
        ExitLoop

	    EndSwitch

	WEnd

EndFunc
Func GetAreaImageScreenTrigger($imagefile)
	;local $w1 = (@desktopwidth/2)-100
	;local $w2 = (@desktopwidth/2)+100
	;local $h1 = (@desktopheight/2)-100
	;local $h2 = (@desktopheight/2)+100
	;local $x1,$y1
	;local $result = _ImageSearchArea("help.png",1,$w1,$h1,$w2,$h2,$x1,$y1,25)
	;if $result = 1 Then
	; $w = False
	;Else
	; ResetView(301)
	; $x = $x + 1
	;EndIf
	Local $acc = InputBox("Image On Screen Trigger", "how tolerant do you want this trigger to be? (0 = exact image, 255 = fully tolerant)", "25", "")
	if @error == 1 then
		return
	endif
	Local $iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path

	; Create GUI
	local $hMain_GUI = GUICreate("Image On Screen Trigger", 380, 80, -1, -1, -1, -1, $hGUI)

	local $sRect_Button   = GUICtrlCreateButton("Select Region on Screen",  20, 20, 160, 40)
	local $sFull_Button   = GUICtrlCreateButton("Search Full Screen",  200, 20, 160, 40)

	GUISetState()

	local $totrig

	While 1

    Switch GUIGetMsg()
      Case $GUI_EVENT_CLOSE
				GUIDelete($hMain_GUI)
        ;FileDelete(@ScriptDir & "\Rect.bmp")
        ExitLoop
      Case $sRect_Button
	      GUISetState(@SW_HIDE, $hMain_GUI)
	      Mark_Rect($iX1, $iY1, $iX2, $iY2, $aPos, $sMsg, $sBMP_Path)
	      ; Capture selected area
	      GUISetState(@SW_SHOW, $hMain_GUI)
				$totrig = "_ImageSearchArea('" & $imagefile & "',1," & $iX1 & "," & $iY1 & "," & $iX2 & "," & $iY2 & ", $X1, $Y1, " & $acc & ")"
				AddToTrigger($totrig, "this image: " & $imagefile & " is found between " & $iX1 & ", " & $iY1 & " and " & $iX2 & ", " & $iY2)
				GUIDelete($hMain_GUI)
        ExitLoop
			Case $sFull_Button
				$totrig = "_ImageSearchArea('" & $imagefile & "',1," & 0 & "," & 0 & "," & @DesktopWidth & "," & @DesktopHeight & ", $X1, $Y1, " & $acc & ")"
				AddToTrigger($totrig, "this image: " & $imagefile & " is found anywhere on the screen")
				GUIDelete($hMain_GUI)
        ExitLoop
	    EndSwitch

	WEnd

EndFunc


; -------------

Func Mark_Rect(ByRef $iX1, ByRef $iY1, ByRef $iX2, ByRef $iY2, ByRef $aPos, ByRef $sMsg, ByRef $sBMP_Path)

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
		$iX1 = $aMouse_Pos[0]
		$iY1 = $aMouse_Pos[1]

		; Draw rectangle while mouse button pressed
		While _IsPressed("01", $UserDLL)

				$aMouse_Pos = MouseGetPos()

				; Set in correct order if required
				If $aMouse_Pos[0] < $iX1 Then
						$iX_Pos = $aMouse_Pos[0]
						$iWidth = $iX1 - $aMouse_Pos[0]
				Else
						$iX_Pos = $iX1
						$iWidth = $aMouse_Pos[0] - $iX1
				EndIf
				If $aMouse_Pos[1] < $iY1 Then
						$iY_Pos = $aMouse_Pos[1]
						$iHeight = $iY1 - $aMouse_Pos[1]
				Else
						$iY_Pos = $iY1
						$iHeight = $aMouse_Pos[1] - $iY1
				EndIf

				_GUICreateInvRect($hRectangle_GUI, $iX_Pos, $iY_Pos, $iWidth, $iHeight)

				Sleep(10)

		WEnd

		; Get second mouse position
		$iX2 = $aMouse_Pos[0]
		$iY2 = $aMouse_Pos[1]

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




































; find the correct image on by first finding the correct zoom









Func _ImageSearchAreaMouseMove($findImage,$resultPosition,$x1,$y1,$right,$bottom,ByRef $x, ByRef $y, $tolerance, $speed = 10)

	if $tolerance>0 then $findImage = "*" & $tolerance & " " & $findImage

  ;method 1
  ;This works, when running from script, but not from exe.
	;$result = DllCall(".\lib\dll\ImageSearchDLL.dll", "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)

  ;method 2
  ;This works, when running from script, but not from exe.
  ;here I call it by a handle instead of by filepath or name
  $hDLL = DllOpen(_PathFull(@scriptdir & "\lib\dll\ImageSearchDLL.dll"))
    $result = DllCall($hDLL, "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)
  DllClose($hDLL)

  ; If error exit
    if $result[0]="0" then return 0

	; Otherwise get the x,y location of the match and the size of the image to
	; compute the centre of search
	$array = StringSplit($result[0],"|")

   $x=Int(Number($array[2]))
   $y=Int(Number($array[3]))
   if $resultPosition=1 then
      $x=$x + Int(Number($array[4])/2)
      $y=$y + Int(Number($array[5])/2)
   endif
   mousemove($x,$y,$speed)
   return 1
EndFunc
