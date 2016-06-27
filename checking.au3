#include <.\executeif.au3>
#include <.\executethen.au3>


;Get a list of triggers

global $triggers[1]
;$triggers[0] = "ClipGet() == 'whatever'"
;$triggers[0] = "$xcount == 2"
$triggers[0] = ReadFileIf(0);"ClipGet() == 'whatever' and $xcount == 3"


global $behavior[1]
;$triggers[0] = "ClipGet() == 'whatever'"
;$triggers[0] = "$xcount == 2"
$behavior[0] = ReadFileThen(0)

;MsgBox(64,$behavior[0], $triggers[0])

global $xcount = 0
While 1
  sleep(3)
  ;check for triggers
  if Execute($triggers[0]) then
    ;if it exists then do this stuff
    ;MsgBox(64, $triggers[0],$behavior[0])
    Execute($behavior[0])
  endif

  ;maintain loop
  if $xcount == 1000 then
    $xcount = 0
  else
    $xcount = $xcount +1
  endif
WEnd
