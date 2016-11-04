#include <lib\choosebuttonhelper.au3>
#include <Misc.au3>


MsgBox(64,"","press key")

local $nameofthing
local $cho = ChooseButtonHelper($nameofthing)

MsgBox(64,$nameofthing,$cho)

