#include <Array.au3>
#include <MsgBoxConstants.au3>

Func test1(ByRef $x1)

   $x1[3] = "ABCD"

EndFunc


Func test2()
   local $x1[6]
   _ArrayAdd($x1, "1")
   _ArrayAdd($x1, "2")
   _ArrayAdd($x1, "3")
   _ArrayAdd($x1, "4")
   _ArrayAdd($x1, "5")
   _ArrayAdd($x1, "6")

   _ArrayDisplay($x1, "x1 array")

   test1($x1)
   _ArrayDisplay($x1, "x1 array2")

EndFunc



Func test3()
   local $x1[6][6]
   _ArrayAdd($x1, "1")
   _ArrayAdd($x1, "2")
   _ArrayAdd($x1, "3")
   _ArrayAdd($x1, "4")
   _ArrayAdd($x1, "5")
   _ArrayAdd($x1, "6")

   _ArrayDisplay($x1, "x1 array")

   test1($x1)
   _ArrayDisplay($x1[0], "x1 array2")

EndFunc


Func test4()
   local $x1[6]
   local $x2[6]
   $x2[0] = "this"
   $x2[1] = " is a "
   $x2[2] = "test"
   $x1[2] = $x2

   _ArrayDisplay($x1, "x1 array")
   _ArrayDisplay($x1[2], "x1 array2")

   test1($x1[2])
   _ArrayDisplay($x1[2], "x1 array2")

EndFunc

Func test5()
   local $x1[6]
   local $x2[6]
      $x2[0] = "this"
   $x2[1] = " is a "
   local $i =  0
   While $i < 5
	  _ArrayConcatenate($x1[2], [$x2])
	  $i = $i + 1
   WEnd

   _ArrayDisplay($x1, "x1 array")
   _ArrayDisplay($x1, "x1 array2")

   test1($x1)
   _ArrayDisplay($x1, "x1 array3")

EndFunc


test4()