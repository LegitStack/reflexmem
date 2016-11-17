#include <Array.au3>
#include <MsgBoxConstants.au3>

Global $e[2]
Global $d[2]
func doexecute($argument0, $argument1, $argument2)
   msgbox(64,'test','test')
   _ArrayDisplay($e, 'x1 array')

   $d[1] = 0

   ;$e[execute($argument0)] = execute($argument1)
   $e[execute($argument0)] = $argument1
   ;Execute($argument0)
   ;Execute($argument1)
   Execute($argument2)
EndFunc

func test1()
   doexecute("msgbox(64,'test','test')", "msgbox(64,'test','test')","msgbox(64,'test','test')")
EndFunc

func test2()
   doexecute("local $x", "$x = 0","msgbox(64,'test',$x)")
EndFunc

func test3()
   doexecute("_ArrayDisplay($e, 'x1 array')", "ReDim $e[UBound($e) + 1]","_ArrayDisplay($e, 'x1 array')")
EndFunc

func test4()
   doexecute("$d[1]", "8","_ArrayDisplay($e, 'x1 array')")
EndFunc


test4()
