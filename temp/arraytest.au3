#include <Array.au3>
global $arr[3] = ['a','b','c']
_arrayDisplay($arr, "arr")
global $ar[ubound($arr)] = $arr
_arrayDisplay($ar, "ar")
global $a[ubound($arr)] 
_arrayDisplay($a, "a")
