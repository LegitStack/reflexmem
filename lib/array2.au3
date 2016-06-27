;#include <Array.au3>
;Global $2D_arr[6][1]
;_ArrayDisplay($2D_arr, '$2D_arr') ; show it
Func _ArrayAdd2($input_array, $data, $x = 0)
  $rows     = UBound($input_array, 1)
  $columns  = UBound($input_array, 2)
  ReDim $input_array[$rows][$columns+1]
  $input_array[$x][$columns] = $data
  return $input_array
EndFunc
;_ArrayAdd2($2D_arr, "Hello",0)
;_ArrayAdd2($2D_arr, "World",1)
;_ArrayDisplay($2D_arr, '$2D_arr') ; show it
;for $i = 0 to 5
;  _ArrayAdd2($2D_arr, "World",$i)
;  _ArrayDisplay($2D_arr, '$2D_arr') ; show it
;next
