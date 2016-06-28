#Include <Array.au3>
Run("notepad.exe",'', @SW_MAXIMIZE)
; Create internal array
Global $a[3] = ["a", "b", "c"]
Global $b[3] = ["z", "y", "x"]
_ArrayDisplay($a)
; Create wrapper array with internal array internally
Global $arr[1][2] = [ [2, $a] ]
;$arr[1][1] = [ [$b, 2] ]
_ArrayDisplay($arr)
; Extract internal array
Global $sub = $arr[0][0] ; Note use of 2 dimensions to address element <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;Global $sub2 = $arr[1][0] ; Note use of 2 dimensions to address element <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  ;for $i = 0 to ubound($arr[0][0])-1
  ;  MsgBox(64, "arr", $arr[0][$i])
  ;next
; Display internal array
_ArrayDisplay($sub)
;_ArrayDisplay($sub2)
