#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <lib\tesseract_stdout.au3>
#include <lib\filelocations.au3>
local $throwaway
  local $returned = SaveScreen($throwaway, 200,200,600,600, true)
  MsgBox(64,"",$returned)