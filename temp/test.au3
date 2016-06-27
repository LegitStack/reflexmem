#include <MsgBoxConstants.au3>

; An alternative to the limitation of $CmdLine[] only being able to return a maximum of 63 parameters.
Msgbox(64,"read", $CmdLineRaw)
