#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
local $b[100]
local $a = "Assign('$b[1]',25,1)"
execute($a)
msgbox(64, $b[1],"")

local $b1
local $a = "Assign('b1',25,1)"
execute($a)
msgbox(64, $b1,"")