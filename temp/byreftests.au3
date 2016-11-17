#include <Array.au3>
#include <MsgBoxConstants.au3>

Global $e[2]
Global $d[2]
global $c
func dobyref(byref $argument0, byref $argument1)
   $e[1] = "H"
   $c = "w"
EndFunc

func test1()
   $e[1] = "Hello"
   $c = "world"
   MsgBox(64, "", $e[1] & " " & $c)
   dobyref($e[1], $c)
   MsgBox(64, "hell", $e[1] & " " & $c)
EndFunc


test1()
