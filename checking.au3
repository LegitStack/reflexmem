#include <.\executeif.au3>
#include <.\executethen.au3>

;Get a list of triggers and behaviors
global $triggers[1]
global $behaviors[100][1]
global $tcounts[1]

local $i = 0
While FileExists(_PathFull(@ScriptDir & "\scripts\if") & "\" & $i & ".txt")

  ReDim $triggers[$i + 1]
  ReDim $behaviors[100][$i + 1]
  ReDim $tcounts[$i + 1]
  $triggers[$i] = ReadFileIf($i)
  $temp = ReadFileThen($i)
  $j = 0
  For $t In $temp
    $behaviors[$j][$i] = $t
    $j = $j + 1
  next
  $i = $i + 1
WEnd

;watch for triggers and do each behaviors
While 1
  sleep(3000)
  for $c = 0 to ubound($triggers)-1
    $tcounts[$c] = $tcounts[$c] + 1
    if Execute($triggers[$c]) then

      for $i = 0 to 100
        if $behaviors[$i][$c] == ""  then
          $i = 101
        else
          msgbox(64,"executing",$behaviors[$i][$c])
          sleep(2000)
          Execute($behaviors[$i][$c])
        endif
      next
      $tcounts[$c] = 0

    endif
  next
WEnd
