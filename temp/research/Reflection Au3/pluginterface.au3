#include "lib\reflection.au3"

$main = _RAttach("Manadar.AutoIt.Main")

Func Print($s)
	$main.Print($s)
EndFunc