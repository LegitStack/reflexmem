
#include <Misc.au3>
#include <MsgBoxConstants.au3>

Local $hDLL = DllOpen("user32.dll")

While 1
    If _IsPressed("01", $hDLL) Then
      MsgBox($MB_SYSTEMMODAL, "_IsPressed", "1")
      ExitLoop
    elseIf _IsPressed("02", $hDLL) Then
      MsgBox($MB_SYSTEMMODAL, "_IsPressed", "2")
      ExitLoop
    elseIf _IsPressed("03", $hDLL) Then
      MsgBox($MB_SYSTEMMODAL, "_IsPressed", "3")
      ExitLoop
    elseif _IsPressed("04", $hDLL) Then
      MsgBox($MB_SYSTEMMODAL, "_IsPressed", "4")
      ExitLoop
    elseif _IsPressed("05", $hDLL) Then
      MsgBox($MB_SYSTEMMODAL, "_IsPressed", "5")
      ExitLoop
    elseif _IsPressed("06", $hDLL) Then
      MsgBox($MB_SYSTEMMODAL, "_IsPressed", "6")
      ExitLoop
    EndIf
    Sleep(250)
WEnd

DllClose($hDLL)
