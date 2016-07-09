#include <lib\tesseract_stdout.au3>
#include <FileConstants.au3>
#include <File.au3>
#include <Misc.au3>
#include <lib\filelocations.au3>

local $ocri
local $ocrt = SaveScreen($ocri, 256,256,512,512, true)

MsgBox(64, "ocri", $ocri)
MsgBox(64, "ocrt", $ocrt)