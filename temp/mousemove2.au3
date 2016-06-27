Opt('GUIOnEventMode', '1')
HotKeySet('p', '_Pause')
HotKeySet("{ESC}", "Terminate")

Global $Pause = False
Global $thex = @DesktopWidth/2
Global $they = @DesktopHeight/2

Global $lastx
Global $lasty

While 1
  If Not $Pause Then
    $Pos = MouseGetPos()
    $x = $Pos[0]
    $y = $Pos[1]
    ;if $lastx <> $x then
    ;  if $thex < $Pos[0] Then
    ;    $x = $Pos[0]-100
    ;  else
    ;    $x = $Pos[0]+100
    ;  EndIf
    ;EndIf
    ;if $lasty <> $y then
    ;  if $they < $Pos[1] Then
    ;    $y = $Pos[1]-100
    ;  else
    ;    $y = $Pos[1]+100
    ;  EndIf
    ;EndIf

    if $lastx <> $x then
      $x = ($Pos[0]+$thex)/2
    EndIf
    if $lasty <> $y then
      $y = ($Pos[1]+$they)/2
    EndIf
    MouseMove ($x, $y,1)
    $lastx = $x
    $lasty = $y
  EndIf
  Sleep(5)
WEnd

Func _Pause()
  $Pause = Not $Pause
EndFunc   ;==>_Pause

Func Terminate()
  Exit
EndFunc   ;==>_Exit
