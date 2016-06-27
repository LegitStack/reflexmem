#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         Jordan Miller

 Script Function:
	This uses the tesseract library

 Requirements
  (Tesseract 3.04 installed on the machine)
  tesseract must be the folder called lib which is in the same folder as ocr.au3
  a folder called image must be in the same folder as ocr.au3
  a folder called output must be in the same folder as ocr.au3

#ce ----------------------------------------------------------------------------

;calls lib/tesseract.au3
#include <lib\tesseract.au3>
#include <lib\sqlitequery.au3>
#include <lib\levenshtein.au3>
#include <lib\linedistance.au3>
#include <lib\Array2.au3>
#include <lib\alllcs.au3>
#include <MsgboxConstants.au3>
#include <FileConstants.au3>
#include <File.au3>
#include <math.au3>
#include <Array.au3>
#include <Misc.au3>

HotKeySet('`', 'SetHotKeys')
HotKeySet("{ESC}", "Terminate")

Func SetHotKeys()
  ;;Msgbox($MB_SYSTEMMODAL, "SetHotKeys", "SetHotKeys")
  HotKeySet('1', 'Activate')
  HotKeySet('2', 'Define')
  HotKeySet('3', 'DoSubmit')
  HotKeySet('4', 'DoSubmitBackwards')
  HotKeySet('5', 'ExplicitDefine')
  HotKeySet('6', 'ExplicitSaveTD')
  HotKeySet('7', 'SaveTD')
  HotKeySet('8', 'CopySaveT')
  HotKeySet('9', 'CopySaveD')
  HotKeySet('0', 'Restart')
  HotKeySet('{F2}', 'BestGuess')
  HotKeySet('{F4}', 'AnswerAddition')
  HotKeySet('{F1}', 'SaveArea')
  HotKeySet('`', 'UnSetHotKeys')
EndFunc

Func UnSetHotKeys()
  HotKeySet('1')
  HotKeySet('2')
  HotKeySet('3')
  HotKeySet('4')
  HotKeySet('5')
  HotKeySet('6')
  HotKeySet('7')
  HotKeySet('0')
  HotKeySet('{F2}', '')
  HotKeySet('{F4}', '')
  HotKeySet('{F1}', '')

  HotKeySet('`', 'SetHotKeys')
EndFunc


Global $ACTIVE = false
Global $CLICKI = 0
Global $CLICKS[100]


While 1
  Sleep(1)
WEnd


Func Terminate()
  Exit
EndFunc


Func Activate()
  $ACTIVE = true
  ClearCache()
EndFunc


Func Restart()
  ClearCache()
  Local $iPID = Run(_PathFull(@ScriptDir & "\runocr.exe"))
  Exit
EndFunc


Func Define()
  If $ACTIVE = false Then
    return $ACTIVE
  EndIf

  $pos = MouseGetPos()

  ; 0 - top left corner of question
  If $CLICKI = 0 Then
    $CLICKS[0] = $pos[0]
    $CLICKS[1] = $pos[1]
  EndIf

  ; 1 - bottom right of question
  If $CLICKI = 1 Then
    $CLICKS[2] = $pos[0]
    $CLICKS[3] = $pos[1]
    SaveScreen($CLICKS[0],$CLICKS[1],$CLICKS[2],$CLICKS[3])
    WaitForLocationFile(0)
    IndicateMouseLeft(20)
  EndIf

  ; 2 - bottom left corner of first answer
    ; get image of answer
  If $CLICKI >1 Then
    $CLICKS[$CLICKI*2] = $pos[0]      ;4, 6, 8
    $CLICKS[($CLICKI*2)+1] = $pos[1]  ;5, 7, 9
    SaveScreen($CLICKS[$CLICKI*2],$CLICKS[($CLICKI*2)-1],$CLICKS[2],$CLICKS[($CLICKI*2)+1] )
    WaitForLocationFile($CLICKI-1)
    IndicateMouseDown(56)
  EndIf

    $CLICKI = $CLICKI +1
EndFunc


Func ExplicitDefine()
  If $ACTIVE = false Then
    return $ACTIVE
  EndIf

  $pos = MouseGetPos()

  If $CLICKI = 0 Then
    $CLICKS[0] = $pos[0]
    $CLICKS[1] = $pos[1]
  EndIf

  If $CLICKI = 1 Then
    $CLICKS[2] = $pos[0]
    $CLICKS[3] = $pos[1]
    SaveScreen($CLICKS[0],$CLICKS[1],$CLICKS[2],$CLICKS[3])
    WaitForLocationFile(0)
    IndicateMouseLeft(100)
  EndIf

  If $CLICKI >1 And IsEven($CLICKI) Then
    $CLICKS[$CLICKI*2] = $pos[0]      ;4, 6, 8
    $CLICKS[($CLICKI*2)+1] = $pos[1]  ;5, 7, 9
  EndIf

  If $CLICKI >1 And Not(IsEven($CLICKI)) Then
    $CLICKS[$CLICKI*2] = $pos[0]      ;4, 6, 8
    $CLICKS[($CLICKI*2)+1] = $pos[1]  ;5, 7, 9
    SaveScreen($CLICKS[($CLICKI*2)-2],$CLICKS[($CLICKI*2)-1],$CLICKS[$CLICKI*2],$CLICKS[($CLICKI*2)+1] )
    WaitForLocationFile(($CLICKI-1)/2)
    IndicateMouseLeft(100)
  EndIf

  $CLICKI = $CLICKI +1
EndFunc

Func Submit_Check()
  If $ACTIVE = false Then
    return true
  EndIf

  If Not FileExists(_PathFull(@ScriptDir & "\output\0.txt")) Then
    return true
  EndIf
EndFunc


Func Submit_OpenFile($i, ByRef $path, ByRef $file, ByRef $read)
  $path = GetOutputPath() & "\" & $i & ".txt"
  $file = FileOpen($path, $FO_READ)
  $read = FileRead($file)
  FileClose($file)
  ;Msgbox(64,"read", $read)
EndFunc



Func Submit_SetQA($i, ByRef $question, ByRef $answers, $read)
  ;_arrayDisplay($answers, "$answers")
  if $i == 0 then
    $question = $read
  elseif $i == 1 then
    $answers[0] = $read
  else
    _ArrayAdd($answers, $read)
  EndIf
EndFunc

Func Submit_SetScores($terms, $question, ByRef $scores)
  local $tlen
  local $lowscore = 0
  local $score = 0
  local $qlen = StringLen($question)
  ;msgbox(64, "qlen", $qlen)
  local $lastguy
  For $i = 0 To UBound($terms)-1 Step 1
    ToolTip($i)
    ;_arrayDisplay($terms)
    if $lastguy <> $terms[$i] then
      ;msgbox(64, "lastguy", $lastguy)
      ;msgbox(64, "terms[$i]", $terms[$i])
      $tlen = StringLen($terms[$i])
      ;msgbox(64, "tlen", $tlen)
      ;msgbox(64, "lowscore", $lowscore)
      if $tlen > $lowscore + 1 + $qlen And $lowscore <> 0 then
        $score = $lowscore + 1 + $tlen
        ;msgbox(64, "score1", $score)
      elseif $tlen < ($lowscore - 1 - $qlen) And $lowscore <> 0 then
        $score = $lowscore + 1 + $tlen
        ;msgbox(64, "score2", $score)
      else
        $score = (GetAllLCS($question,$terms[$i]))
        ;msgbox(64, "score3", $score)
        $lastguy = $terms[$i]
        if $score > $lowscore Then
          $lowscore = $score
        EndIf
      EndIf
    EndIf
    if $i == 0 then
      $scores[0] = $score
    else
      _ArrayAdd($scores,$score)
    EndIf
  Next
  ;msgbox(64, "lowscore", $lowscore)
  ;_arrayDisplay($scores, "scores")
  return $lowscore
EndFunc

Func Submit_SetMatches(ByRef $matches, $scores, $lowscore)
  local $n = 0
  local $score = 0
  For $i = 0 To UBound($scores)-1 Step 1
    $score = $scores[$i]
    if $score == $lowscore Then
      if $n == 0 then
        $matches[0] = $i + 1
      else
        _ArrayAdd($matches,$i+1)
      EndIf
      $n = $n + 1
    EndIf
  Next
EndFunc


Func Submit_SetDefs($matches)
  local $defs[Ubound($matches)]
  For $i = 0 To UBound($matches)-1 Step 1
    $defs[$i] = GetDefinition($matches[$i])
  Next
  return $defs
EndFunc


Func Submit_SetDefinition($matches)
  local $definition
  For $i = 0 To UBound($matches)-1 Step 1
    $definition &= GetDefinition($matches[$i])
  Next
  return $definition
EndFunc

Func Submit_ScoreAnswers($answers, $definition, ByRef $scoresofanswers)
  local $score
  For $i = 0 To UBound($answers)-1 Step 1
    ;msgbox(64,$answers[$i], $definition)
    if StringLen($definition) > StringLen($answers[$i]) then
      $score = (GetAllLCS($answers[$i], $definition))
    else
      $score = (GetAllLCS($definition, $answers[$i]))
    endif
    $scoresofanswers[$i][0] = $score
    $scoresofanswers[$i][1] = $i+1
  next
  _ArraySort($scoresofanswers, 1, 0, 0, 0)
EndFunc


Func Submit_CalculateSurity($scoreofquestion, $scoresofanswers)
  local $surities[ubound($scoresofanswers)]
  for $i = 0 To Ubound($scoresofanswers)-1
    $surities[$i] = 1/(($scoreofquestion + $scoresofanswers[$i][0])+1)
  next
  return $surities
EndFunc


Func Submit_NextAnswer($scoresofanswers, $surities)
  Local $hDLL = DllOpen("user32.dll")
  local $nextscore = 1
  While 1
    If _IsPressed("04", $hDLL) Then
      PresentAnswer($scoresofanswers[$nextscore][1], $surities[$nextscore])
      $nextscore += 1
      if $nextscore >= Ubound($scoresofanswers) or $nextscore >= Ubound($surities) Then
        $nextscore = 0
      EndIf
    ElseIf _IsPressed("51", $hDLL) Then
      ExitLoop
    EndIf
    Sleep(1)
  WEnd
  DllClose($hDLL)
EndFunc


Func Submit($gotonextanswer = true)

  If Submit_Check() then
    return false
  endif

  SetupDB()
  OpenDB()

  local $question
  local $answers[1]
  local $read, $file, $path
  local $i = 0

  While FileExists(GetOutputPath() & "\" & $i & ".txt")
    Submit_OpenFile($i, $path, $file, $read)
    Submit_SetQA($i, $question, $answers, $read)
    $i = $i + 1
  WEnd
  ;Msgbox(64, "question", $question)
  ;_ArrayDisplay($answers, "answers")
  local $scores[1]
  local $scoreofquestion = Submit_SetScores(GetAllTerms(), $question, $scores)
  ;Msgbox(64, "scoreofquestion", $scoreofquestion)
  ;_ArrayDisplay($scores, "s1cores")
  IndicateMouseRight()
  local $matches[1]
  Submit_SetMatches($matches, $scores, $scoreofquestion)
  IndicateMouseDown()
  local $definition = Submit_SetDefinition($matches)
  ;Msgbox(64, "def", $definition)
  IndicateMouseLeft()
  local $scoresofanswers[Ubound($answers)][2]
  Submit_ScoreAnswers($answers, $definition, $scoresofanswers)
  ;Msgbox(64, "4", $question)
  IndicateMouseUp()
  local $surities[Ubound($scoresofanswers)] = Submit_CalculateSurity($scoreofquestion, $scoresofanswers)
  ;_ArrayDisplay($matches, "matches")
  ;_ArrayDisplay($answers, "answers")
  ;_ArrayDisplay($scoresofanswers, "scoresofanswers")
  ;_ArrayDisplay($surities, "surities")

  PresentAnswer($scoresofanswers[0][1], $surities[0])

  if $gotonextanswer then
    Submit_NextAnswer($scoresofanswers, $surities)
  endif

  CloseDB()
  SetdownDB()

  return $surities[0]
  ;ClearCache()
EndFunc

Func DoSubmit()
   Submit(true)
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                        SubmitModifiedBackwards                               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func SubmitB_SetScores($terms, $answers, ByRef $scores, $qlen, $j)
  local $score = 0
  local $lowscore = 0
  local $tlen
  local $lastguy
  For $i = 0 To UBound($terms)-1 Step 1
    ToolTip($i)
    if $lastguy <> $terms[$i] then
      $tlen = StringLen($terms[$i])
      if $tlen > $lowscore + 1 + $qlen And $lowscore <> 0 then
        $score = $score + 1 + $tlen
      elseif $tlen < ($lowscore - 1 - $qlen) And $lowscore <> 0 then
        $score = $score + 1 + $tlen
      else
        $score = (GetAllLCS($answers[$j],$terms[$i]))
        $lastguy = $terms[$i]
        if $score > $lowscore Then
          $lowscore = $score
        EndIf
      EndIf
    endif
    if $j == 0 then
      if $i == 0 then
        $scores[$j][0] = $score
      else
        $scores = _ArrayAdd2($scores,$score,$j)
      EndIf
    else
      $scores[$j][$i] = $score
    endif
  Next
  ;_ArrayDisplay($scores, "scores")
  return $lowscore
EndFunc


Func SubmitB_SetMatches(ByRef $matches, $scores, $lowscore, $j)
  local $score
  local $n = 0
  For $c = 0 To UBound($scores,2)-1 Step 1
    $score = $scores[$j][$c]
    if $score == $lowscore And $lowscore <> 0 Then
      if $j == 0 then
        if $n == 0 then
          $matches[$j][0] = $c + 1
        else
          $matches = _ArrayAdd2($matches,$c+1,$j)
        EndIf
      else
        if $n >= Ubound($matches,2) then
          $matches = _ArrayAdd2($matches,$c+1,$j)
        else
          $matches[$j][$n] = $c +1
        endif
      endif
      $n = $n + 1
    EndIf
  Next
EndFunc


Func SubmitB_SetDefs($matches, ByRef $defs, $answers)
  local $def
  for $j = 0 to UBound($answers)-1
    For $i = 0 To UBound($matches,2)-1 Step 1
      if $matches[$j][$i] <> "" then
        $def = GetDefinition($matches[$j][$i])
        if $i >= Ubound($defs,2) then
          $defs = _ArrayAdd2($defs,$def,$j)
        else
          $defs[$j][$i] = $def
        endif
      endif
    Next
  Next
EndFunc


Func SubmitB_SetDefinition($defs, $matches, ByRef $definitions, $answers)
  local $alen
  for $j = 0 to UBound($answers)-1
    For $i = 0 To UBound($defs,2)-1 Step 1
      $alen = $defs[$j][$i]
      if $alen <> "" and $alen <> " " then
        $definitions[$j] &= $defs[$j][$i]
      endif
    Next
  Next
EndFunc


Func SubmitB_ScoreAnswers($question, $answers, $definitions, $scoresofquestions, ByRef $scoresofanswers)
  local $score
  for $i = 0 to UBound($answers)-1
    if StringLen($question) > StringLen($definitions[$i]) then
      $score = (GetAllLCS($definitions[$i], $question))
    else
      $score = (GetAllLCS($question, $definitions[$i]))
    endif
    $scoresofanswers[$i][0] = $score
    $scoresofanswers[$i][1] = $i+1
    $scoresofanswers[$i][2] = $scoresofquestions[$i]
  Next
  _ArraySort($scoresofanswers, 1, 0, 0, 0)
EndFunc


Func SubmitB_CalculateSurity($scoresofanswers)
  local $surities[ubound($scoresofanswers)]
  for $i = 0 To Ubound($scoresofanswers)-1
    $surities[$i] = 1/(($scoresofanswers[$i][2] + $scoresofanswers[$i][0])+1)
  next
  return $surities
EndFunc


Func SubmitBackwards($gotonextanswer = true)

  If Submit_Check() then
    return false
  endif

  SetupDB()
  OpenDB()

  local $question
  local $answers[1]
  local $read, $file, $path
  local $i = 0
  While FileExists(GetOutputPath() & "\" & $i & ".txt")
    Submit_OpenFile($i, $path, $file, $read)
    Submit_SetQA($i, $question, $answers, $read)
    $i = $i + 1
  WEnd

  local $lowscore = 0
  local $scores[Ubound($answers)][1]
  local $qlen = StringLen($question)
  local $matches[UBound($answers)][1]
  local $scoresofquestions[ubound($answers)]
  for $j = 0 to UBound($answers)-1
    $lowscore = SubmitB_SetScores(GetAllTerms(), $answers, $scores, $qlen, $j)
    $scoresofquestions[$j] = $lowscore
    SubmitB_SetMatches($matches, $scores, $lowscore, $j)
  next

  local $defs[Ubound($answers)][Ubound($matches)]
  SubmitB_SetDefs($matches, $defs, $answers)

  local $definitions[Ubound($answers)]
  SubmitB_SetDefinition($defs, $matches, $definitions, $answers)

  local $scoresofanswers[Ubound($answers)][3]
  SubmitB_ScoreAnswers($question, $answers, $definitions, $scoresofquestions, $scoresofanswers)

  local $surities[Ubound($scoresofanswers)] = SubmitB_CalculateSurity($scoresofanswers)
  ;_ArrayDisplay($scoresofquestions, "scoresofquestions")
  ;_ArrayDisplay($answers, "answers")
  ;_ArrayDisplay($definitions, "definitions")
  ;_ArrayDisplay($scoresofanswers, "scoresofanswers")
  ;_ArrayDisplay($surities, "surities")
  PresentAnswer($scoresofanswers[0][1], $surities[0])

  if $gotonextanswer then
    Submit_NextAnswer($scoresofanswers, $surities)
  endif

  CloseDB()
  SetdownDB()

  return $surities[0]

  ;ClearCache()
EndFunc

Func DoSubmitBackwards()
   SubmitBackwards(true)
EndFunc


;not a perfect meausre because doesn't take into account how sure we are about
;the other answers compared to this one, but its good enough. The further to
;the left it is the better a guess we've come up with. = surities

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                   BestGuess                                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




Func BestGuess()
  local $sb = SubmitBackwards(false)
  ;Msgbox(64, "submitb",$sb)

  sleep(250)
  local $pos = MouseGetPos()

  local $sf = Submit(false)
  ;Msgbox(64, "submit",$sf)

  sleep(250)
  if $sb < $sf then
    MouseMove($pos[0], $pos[1])
  endif

  ;ClearCache()

EndFunc




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                   SAVE                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func SaveTD() ; this is not working - its for when users click on the right answer

  If Not FileExists(_PathFull(@ScriptDir & "\output\0.txt")) Then
    return FileExists(_PathFull(@ScriptDir & "\output\0.txt"))
  EndIf

  local $pos = MouseGetPos()

  local $question
  local $answers[1]
  local $read, $file, $filepath
  local $i = 0
  While FileExists(GetOutputPath() & "\" & $i & ".txt")
    $filepath = GetOutputPath() & "\" & $i & ".txt"
    $file = FileOpen($filepath, $FO_READ)
    $read = FileRead($file)
    FileClose($file)

    if $i == 0 then
      $question = $read
    elseif $i == 1 then
      $answers[0] = $read
    else
      _ArrayAdd($answers, $read)
    EndIf
    $i = $i + 1
  WEnd
  local $answerx[1]
  local $answery[1]
  local $splitread[1]
  local $i = 1
  While FileExists(GetLocationPath() & "\" & $i & ".txt")
    $filepath = GetLocationPath() & "\" & $i & ".txt"
    $file = FileOpen($filepath, $FO_READ)
    $read = FileRead($file)
    FileClose($file)
    $splitread = Split($read, ",")

    if $i == 1 then
      $answerx[0] = $splitread[0]
      $answery[0] = $splitread[1]
    else
      _ArrayAdd($answerx, $splitread[0])
      _ArrayAdd($answery, $splitread[1])
    EndIf
    $i = $i + 1
  WEnd

  ;Msgbox(64, "question is", $question)
  ;_ArrayDisplay($answers, "answers")

  local $dist = 99999
  local $shortdist = 99999
  local $thei
  For $i = 0 To UBound($answers)-1 Step 1
    $dist = GetLineDistance($pos[0],$pos[1],$answerx[$i],$answery[$i])
    if $dist < $shortdist then
      $shortdist = $dist
      $thei = $i
    endif
  Next

  InsertQAIntoDB($question, $answers[$thei])
  InsertQAIntoDB($answers[$thei], $question)

  ClearCache()
EndFunc


Func ExplicitSaveTD()

  If $ACTIVE = false Then
    return $ACTIVE
  EndIf

  If Not FileExists(_PathFull(@ScriptDir & "\output\0.txt")) Then
    return FileExists(_PathFull(@ScriptDir & "\output\0.txt"))
  EndIf

  If Not FileExists(_PathFull(@ScriptDir & "\output\1.txt")) Then
    return FileExists(_PathFull(@ScriptDir & "\output\1.txt"))
  EndIf

  local $read, $file, $filepath, $term, $definition
  $filepath = GetOutputPath() & "\0.txt"
  $file = FileOpen($filepath, $FO_READ)
  $read = FileRead($file)
  FileClose($file)
  $term = $read

  $filepath = GetOutputPath() & "\1.txt"
  $file = FileOpen($filepath, $FO_READ)
  $read = FileRead($file)
  FileClose($file)
  $definition = $read

  ;Msgbox(64, "term is", $term)
  ;Msgbox(64, "definition is", $definition)

  InsertQAIntoDB($term, $definition)

  ClearCache()
EndFunc



Func CopySaveD()

  If $ACTIVE = false Then
    return $ACTIVE
  EndIf

  If Not FileExists(_PathFull(@ScriptDir & "\output\0.txt")) Then
    return FileExists(_PathFull(@ScriptDir & "\output\0.txt"))
  EndIf

  local $read, $file, $filepath, $term, $definition
  $filepath = GetOutputPath() & "\0.txt"
  $file = FileOpen($filepath, $FO_READ)
  $read = FileRead($file)
  FileClose($file)
  $term = $read

  $definition = GetText()

  ;Msgbox(64, "term is", $term)
  ;Msgbox(64, "definition is", $definition)

  InsertQAIntoDB($term, $definition)

  ClearCache()
EndFunc



Func CopySaveT()

  If $ACTIVE = false Then
    return $ACTIVE
  EndIf

  If Not FileExists(_PathFull(@ScriptDir & "\output\0.txt")) Then
    return FileExists(_PathFull(@ScriptDir & "\output\0.txt"))
  EndIf

  local $read, $file, $filepath, $term, $definition
  $filepath = GetOutputPath() & "\0.txt"
  $file = FileOpen($filepath, $FO_READ)
  $read = FileRead($file)
  FileClose($file)
  $definition = $read

  $term = GetText()

  ;Msgbox(64, "term is", $term)
  ;Msgbox(64, "definition is", $definition)

  InsertQAIntoDB($term, $definition)

  ClearCache()
EndFunc



Func SaveArea()
  If $ACTIVE = false Then
    return $ACTIVE
  EndIf

  If $CLICKI > 1 And IsEven($CLICKI) Then
    SaveScreen($CLICKS[0],$CLICKS[1],$CLICKS[2],$CLICKS[3])
    local $term, $definition
    local $path, $file, $read
    for $i = 0 to 30
      sleep(1000)
      Submit_OpenFile($CLICKI-2, $path, $file, $read)
      $read = StringStripWS($read, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
      $term = $read
      Submit_OpenFile($CLICKI-1, $path, $file, $read)
      $read = StringStripWS($read, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
      $definition = $read
      if $definition <> "" and $term <> "" Then
        $i = 30
      elseif $i == 30 Then
        msgbox(64, "Timed Out", $definition)
        msgbox(64, "Timed Out", $term)
        $i = 0
      endif
    next
    ;msgbox(64, "term", $term)
    ;msgbox(64, "definition", $definition)
    InsertQAIntoDB($term, $definition)
    IndicateMouseRight(100)
    MouseClick("primary")
    ;mousemove(,)
    Sleep(2000)
  EndIf

  If $CLICKI > 1 And Not(IsEven($CLICKI)) Then
    Sleep(5000)
    ;ClearFiles()
    SaveScreen($CLICKS[0],$CLICKS[1],$CLICKS[2],$CLICKS[3])
    ;mousemove(1030,1055)
    IndicateMouseLeft(100)
    MouseClick("primary")
    Sleep(2000)
  EndIf

  $CLICKI = $CLICKI +1
  send("{F1}")
EndFunc





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                              AnswerAddition                                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func AnswerAddition()
  If $ACTIVE = false Then
    return $ACTIVE
  EndIf

  $pos = MouseGetPos()

  If $CLICKI = 0 Then
    $CLICKS[0] = $pos[0]
    $CLICKS[1] = $pos[1]
  EndIf

  If $CLICKI = 1 Then
    $CLICKS[2] = $pos[0]
    $CLICKS[3] = $pos[1]
    SaveScreen($CLICKS[0],$CLICKS[1],$CLICKS[2],$CLICKS[3],true)
    IndicateMouseRight(100)
  EndIf

  If $CLICKI > 1 And IsEven($CLICKI) Then
    $CLICKI = 0
    $CLICKS[0] = $pos[0]
    $CLICKS[1] = $pos[1]
  EndIf

  $CLICKI = $CLICKI +1
EndFunc


























;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                              WaitForLocationFile                                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Func WaitForLocationFile($i)
  local $read
  for $i = 0 to 10
    $read = OpenLocationFile($i)
    if $read <> "" Then
      $i = 30
    elseif $i == 10 Then
      ToolTip(" ", 0,0)
      $i = 0
    endif
    sleep(500)
  next
  return $read
EndFunc


Func OpenLocationFile($i)
  local $path = GetLocationPath() & "\" & $i & ".txt"
  local $file = FileOpen($path, $FO_READ)
  local $read = FileRead($file)
  FileClose($file)
  return $read
EndFunc


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                              Helpers                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



Func ClearCache($startingat = 0)
  $CLICKI = 0
  Local $i = 0
  While $i < UBound($CLICKS)
    $CLICKS[$i] = ""
    $i = $i + 1
  WEnd
  DeleteCache($startingat)
EndFunc

Func ClearFiles($startingat = 0)
  Local $i = 0
  DeleteCache($startingat)
EndFunc




Func InsertQAIntoDB($term, $definition)
  SetupDB()
  OpenDB()
    ;insert term into term part of database.
    InsertTermAndDef($term, $definition)
    ;insert definition into definition part of database
    ;InsertTermAndDef($definition, $term)
  CloseDB()
  SetdownDB()
EndFunc

Func IsEven($i)
    Return ($i/2)=Round($i/2)
EndFunc



Func AddLetter($n = 1)
  local $letters = ""
  for $i = 1 to $n
    $letters &= "♫"
  next
  return $letters
EndFunc

Func GetText()
  Send ("^c")
  Sleep (10)
  ;ClipPut ($clipboard)
  ;ToolTip (ClipGet ())
  ;$clipboard = ClipGet ()
  return ClipGet()
EndFunc



Func IndicateMouseRight($i = 15)
  local $aPos = MouseGetPos()
  MouseMove($aPos[0]+$i,$aPos[1])
EndFunc

Func IndicateMouseLeft($i = 15)
  local $aPos = MouseGetPos()
  MouseMove($aPos[0]-$i,$aPos[1])
EndFunc

Func IndicateMouseUp($i = 15)
  local $aPos = MouseGetPos()
  MouseMove($aPos[0],$aPos[1]-$i)
EndFunc

Func IndicateMouseDown($i = 15)
  local $aPos = MouseGetPos()
  MouseMove($aPos[0],$aPos[1]+$i)
EndFunc

Func IndicateMouseRandom($i = 15)
  $r = Random(0, 3, 1)
  If $r == 0 Then ; Return an integer between 0 and 1.
    IndicateMouseRight($i)
  Elseif $r == 1 then
    IndicateMouseLeft($i)
  Elseif $r == 2 then
    IndicateMouseUp($i)
  Else
    IndicateMouseDown($i)
  EndIf
EndFunc
