global $d = 321
global $e = 321

func dosomething($argument0)
   local $temp = stringleft($argument0,1)
   if IsNumber($temp) == 1 Then
	  MsgBox(64, $argument0, "is number")
   ElseIf stringleft($argument0,1) == '"' then
	  MsgBox(64, $argument0, "is text")
   ElseIf stringleft($argument0,1) == "'" then
	  MsgBox(64, $argument0, "is text")
   else
	  MsgBox(64, $argument0, "is code")
	  $d = Execute($argument0)
   EndIf
EndFunc

func test1()
   local $c = "code"
   local $c = "1-1+1"
   dosomething(1)
   dosomething(12)
   dosomething("text1")
   dosomething('text2')
   dosomething("'text3'")
   dosomething('"text4"')
   dosomething($c)
   MsgBox(64, $d, "")
	  $e = $e + 1
	  $e = $e + '100'
	  MsgBox(64,"e", $e)

EndFunc

func test2()
   ;$temp = 1
   ;$temp = "1"
   ;$temp = "'1'"
   ;if IsInt($temp) == 1 Then
   ;  MsgBox(64, "", "is number")
   ;else
   ;  MsgBox(64, "", "code")
   ;EndIf
   $temp = 1
   $temp = "1"
   ;$temp = "'test2()'"
   $temp = "test2()"
   if StringIsInt($temp) == 1 Then
     MsgBox(64, "", "is number")
   else
     MsgBox(64, "", "code")
	 execute($temp)
   EndIf
EndFunc


test2()
