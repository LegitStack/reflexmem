#include <lib\levenshtein.au3>
#include <MsgBoxConstants.au3>

local $score = GetLevenshteinDistance("There was very little commercial activity in the Indian Ocean.","ring")
msgbox(64, "score",$score)
local $rescore = GetLevenshteinDistance("Following the rise of the Mongols durring the thirteenth centruy, the volume of Indian Ocean commerce fell sharply.","ring")
msgbox(64, "rescore",$rescore)

local $rrescore = GetLevenshteinDistance("There was very little commercial activity in the Indian Ocean.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx","ring")
msgbox(64, "rrescore",$rrescore)
local $rreescore = GetLevenshteinDistance("Following the rise of the Mongols durring the thirteenth centruy, the volume of Indian Ocean commerce fell sharply.","ring")
msgbox(64, "rreescore",$rreescore)
