;Func one()
;  #include <Array.au3>
;  Global $2D_arr[6][1]
  ;_ArrayDisplay($2D_arr, '$2D_arr') ; show it
  ;_ArrayAdd($2D_arr, "Hello")
  ;_ArrayAdd($2D_arr, "World",0,1)
  ;_ArrayDisplay($2D_arr, '$2D_arr') ; show it
  ;for $i = 0 to 5
  ;  _ArrayAdd2($2D_arr, "World",$i)
  ;  _ArrayDisplay($2D_arr, '$2D_arr') ; show it
  ;next
;EndFunc

;Func two()
#include <Array.au3>

Local $aArray, $sFill

Local $aArray_Base[2][2] = [["Item 0 - 0", "Item 0 - 1"], ["Item 1 - 0", "Item 1 - 1"]]

; Add a 2D array - Single item/column - load in col 1
$aArray = $aArray_Base
Local $aFill[2][1] = [["New Item 2 - 1"], ["New Item 3 - 1"]]
_ArrayAdd($aArray, $aFill,1)
_ArrayDisplay($aArray, "2D - 2D Array")

;EndFunc

;two()
