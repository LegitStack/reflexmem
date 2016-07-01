#include <Date.au3>
#include <MsgBoxConstants.au3>

if @MDAY == 1 then
   MsgBox($MB_SYSTEMMODAL, @Hour, "The time is:" & _NowTime())
EndIf

