#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <lib\levenshtein.au3>
#include <MsgBoxConstants.au3>

local $answer = "abc"
local $read = "azbzcz"

MsgBox(64,"abc azbzcz",GetLevenshteinDistance($answer, $read))

$answer = "abc"
$read = "azzzzz"

MsgBox(64,"abc azzzzz",GetLevenshteinDistance($answer, $read))

$answer = "abcabc"
$read = "azbzczazzzzz"

MsgBox(64,"abcabc azbzczazzzzz",GetLevenshteinDistance($answer, $read))





local $answer = "zyx"
local $read = "azbzcz"

MsgBox(64,"abc azbzcz",GetLevenshteinDistance($answer, $read))

$answer = "zyx"
$read = "azzzzz"

MsgBox(64,"abc azzzzz",GetLevenshteinDistance($answer, $read))

$answer = "zyxzyx"
$read = "azbzczazzzzz"

MsgBox(64,"abcabc azbzczazzzzz",GetLevenshteinDistance($answer, $read))
