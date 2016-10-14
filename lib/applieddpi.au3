#include <Security.au3>

Func _GetAppliedDPI()

  ;Local $aArrayOfData = _Security__LookupAccountName(@UserName)

  ;If IsArray($aArrayOfData) Then
    ;msgbox(64, "SID String = ", $aArrayOfData[0] & @CRLF)
    ;msgbox(64, "Domain name = ", $aArrayOfData[1] & @CRLF)
    ;msgbox(64, "SID type = ", _Security__SidTypeStr($aArrayOfData[2]) & @CRLF)
    ;Local $AppliedDPI = RegRead("HKEY_USERS\" & $aArrayOfData[0] & "\Control Panel\Desktop\WindowMetrics", "AppliedDPI")
    ;return $AppliedDPI
  ;EndIf
  Local $AppliedDPI = RegRead("HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics", "AppliedDPI")
  return $AppliedDPI

EndFunc

Func GetScale()
  $applied = _GetAppliedDPI()
  if $applied == "" then
    return 1
  else
    return $applied / 96
  EndIf
EndFunc

;RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion \ProfileList","")
