#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
while 1
   msgbox(64,"1","a")
   while 1
	  msgbox(64,"2","a")
	  ExitLoop
	  msgbox(64,"2","a")
   WEnd
   msgbox(64,"1","b")
   while 1
	  msgbox(64,"2","a")
	  ExitLoop 2
	  msgbox(64,"2","b")
   WEnd
   msgbox(64,"1","c")
WEnd
msgbox(64,"0","done")
