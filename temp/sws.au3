#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

Local $sString = StringStripWS("   This   is   a   sentence   with   whitespace.    ", $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
MsgBox($MB_SYSTEMMODAL, "", $sString)
local $sString = " " & @LF & " Full-mesh topology " & @CR & "hello " & @CRLF & "_ world . "

MsgBox($MB_SYSTEMMODAL, "", $sString)
$sString = StringStripWS($sString, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
MsgBox($MB_SYSTEMMODAL, "", $sString)
