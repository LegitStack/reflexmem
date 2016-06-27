#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <MsgBoxConstants.au3>

$answer = "abcd"
MsgBox(64, "00", StringMid($answer, 0,0))
MsgBox(64, "01", StringMid($answer, 0,1))
MsgBox(64, "10", StringMid($answer, 1,0))
MsgBox(64, "11", StringMid($answer, 1,1))
MsgBox(64, "21", StringMid($answer, 2,1))
MsgBox(64, "22", StringMid($answer, 2,2))
MsgBox(64, "30", StringMid($answer, 3,0))
MsgBox(64, "14", StringMid($answer, 1,4))