#include <MsgBoxConstants.au3>
#include <Security.au3>

Local $aArrayOfData = _Security__LookupAccountName(@UserName)

; Print returned data if no error occured
If IsArray($aArrayOfData) Then
   msgbox(64, "SID String = ", $aArrayOfData[0] & @CRLF)
   msgbox(64, "Domain name = ", $aArrayOfData[1] & @CRLF)
   msgbox(64, "SID type = ", _Security__SidTypeStr($aArrayOfData[2]) & @CRLF)
EndIf



Local $sVar = RegRead("HKEY_USERS\" & $aArrayOfData[0] & "\Control Panel\Desktop\WindowMetrics", "AppliedDPI")
MsgBox($MB_SYSTEMMODAL, "Program files are in:", $sVar)