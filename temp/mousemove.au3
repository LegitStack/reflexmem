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
    MouseMove ($thex, $they,50)
  EndIf
  Sleep(100)
WEnd

Func _Pause()
  $Pause = Not $Pause
EndFunc   ;==>_Pause

Func Terminate()
  Exit
EndFunc   ;==>_Exit
