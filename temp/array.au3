#include <MsgBoxConstants.au3>
#include <Array.au3>
Func CreateGlobal()
  Global $foo[1] = [0]

EndFunc

Func AddMe()

  For $i=1 to 10
      _ArrayAdd($foo,$i)
  Next
  _ArrayDisplay($foo, "foo")
  ;MsgBox($MB_SYSTEMMODAL, "foo", $foo[1])
EndFunc

CreateGlobal()
AddMe()

Func Deleteme()

  Global $food[2][2]
  $food[0][0] = "1"
  $food[1][1] = "2"
  $food[0][1] = "3"
  $food[1][0] = "4"
  _ArrayDisplay($food, "food")
  _ArrayDelete($food, 0)
  _ArrayDisplay($food, "food")
  ;MsgBox($MB_SYSTEMMODAL, "foo", $foo[1])
EndFunc
Deleteme()


Func PopMe()

  Local $avArray[10]

  $avArray[0] = "JPM"
  $avArray[1] = "Holger"
  $avArray[2] = "Jon"
  $avArray[3] = "Larry"
  $avArray[4] = "Jeremy"
  $avArray[5] = "Valik"
  $avArray[6] = "Cyberslug"
  $avArray[7] = "Nutster"
  $avArray[8] = "JdeB"
  $avArray[9] = "Tylo"

  _ArrayDisplay($avArray, "$avArray BEFORE _ArrayPop()")
  While UBound($avArray)
    _ArrayPop($avArray)
      ;MsgBox($MB_SYSTEMMODAL, '_ArrayPop() return value', _ArrayPop($avArray))
      ;_ArrayDisplay($avArray, "$avArray AFTER _ArrayPop()")
  WEnd
  _ArrayDisplay($avArray, "$avArray AFTER _ArrayPop()")
  Local $avArray[2]
  _ArrayPush($avArray, "15fe")
  $avArray[0] = "15fe"
  $avArray[1] = "16fe"

  _ArrayDisplay($avArray, "$avArray AFTER _ArrayPop()")
  Local $i = 0

  While $i < UBound($avArray)
    $avArray[$i] = ""
    $i = $i + 1
  WEnd
  _ArrayDisplay($avArray, "$avArray AFTER _ArrayPop()")
EndFunc

;PopMe()
