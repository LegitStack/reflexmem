#include "lib\reflection.au3"

; Demonstrating simple plugin loading, one-way

; This can be used when the main script knows which functions are in the plugin and how to use them
; and the plugin does not need to use any functions in the main script (more rare than you think)

$script = _RDoFile("plugins\hello world.au3")
$script.HelloWorld("Something different this time")

$script.Quit()


; Demonstrating plugin loading, two-way
; Both the plugin and the main script provide an interface
; This is the most common way to deal with plugins

; You simply load the plugins and the plugin defines the additional behavior,
; by adding items to your menus and handling the functionality for them etc.

$o = _RImplementInterface("pluginterface.au3", "Manadar.AutoIt.Main")

$called = False
$script2 = _RDoFile("plugins\hello forums.au3", True)

While Not $called
	Sleep(100)
WEnd

Func Print($obj, $s)
	$called = True
	MsgBox(0x30, "", $s)
EndFunc