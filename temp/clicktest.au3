

#include <Misc.au3>
;#include <WindowsConstants.au3>
;#include <WinAPIFiles.au3>











local $waiting = true

   While $waiting
	  If _IsPressed("01") Then
		 MsgBox(64, "", "primary")
		 $waiting = False
	  elseif _IsPressed("02") Then
		 MsgBox(64, "", "02")
		 ;$waiting = False
	  elseif _IsPressed("03") Then
		 MsgBox(64, "", "03")
		 ;$waiting = False
	  elseif _IsPressed("04") Then
		 MsgBox(64, "", "04")
		 ;$waiting = False
	  elseif _IsPressed("05") Then
		 MsgBox(64, "", "05")
		 ;$waiting = False
	  elseif _IsPressed("06") Then
		 MsgBox(64, "", "06")
		 ;$waiting = False
	  elseif _IsPressed("07") Then
		 MsgBox(64, "", "07")
		 ;$waiting = False
	  EndIf
   WEnd
