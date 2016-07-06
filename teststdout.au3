#include <lib\tesseract_stdout.au3>
#include <FileConstants.au3>
#include <File.au3>
#include <Misc.au3>
local $imagecount
local $sOutput = SaveScreen($imagecount, 10,220,1000,500)
;local $index = StringInStr($sOutput, " ", 1, 1)
;local $ocri = stringleft($sOutput, $index-1)
;local $ocrt = stringreplace($sOutput, $ocri & " ","",1)

$ocri = $imagecount
$ocrt = $sOutput
MsgBox(64, "output", $sOutput)
MsgBox(64, "ocri", $ocri)
MsgBox(64, "ocrt", $ocrt)