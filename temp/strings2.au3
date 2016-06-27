#include <File.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>


Func GetOutputPath()
  Local $path = _PathFull(@ScriptDir & "\output") ;"\..\output"
	Return $path
EndFunc

Func DetermineAnswer1($answer)

  local $substrings = _CreateListFrom($answer)

  ;loop through all ocr text files to find the file that most matches the answer
  local $val = 1
  Local $winner = 0
  Local $i = 0
  local $filepath
  local $file
  local $read
  local $count
  While FileExists(GetOutputPath() & "\" & $i & ".txt")

    ;read the contents
    $filepath = GetOutputPath() & "\" & $i & ".txt"
    $file = FileOpen($filepath, $FO_READ)
    $read = FileRead($file)
    FileClose($file)

    $lastcount = $count
    $count = 0

    ;look for matches in read
    For $sub In $substrings
      ;if StringInStr($read, $sub)
      local $res = StringRegExp($read, $sub, 3)
      $count = $count + UBound($res)
      $res = 0
      MsgBox(64, $sub, $count)
    Next

    if $count > $lastcount then
      $winner = $i
    endif

    $i = $i + 1
  WEnd

  MsgBox(64, "winner", $winner & " " & $count)


EndFunc

DetermineAnswer1("Japan")

Func _CreateListFrom($answer)
  ;loop through answer to compile list of all combinations.
  ;Convert to a suffix tree after prototype versions if needed
  Local $len = StringLen($answer)
  if $len = 0 Then
    return false
  endif
  $c = 1
  Local $substrings[1] = [0]
  local $match = ""
  While $c <= $len
    For $i = 1 To $len Step $c
      $match = StringMid($answer, $i, $c)
      if Not _ArraySearch($substrings, $match) Then
        _ArrayAdd($substrings, $match)
      endif
    Next
    $c = $c + 1
  WEnd

  return $substrings

EndFunc



Func DetermineAnswer($answer)

  local $substrings = _CreateListFrom($answer)

  ;loop through all ocr text files to find the file that most matches the answer
  local $val = 1
  Local $winner = 0
  Local $i = 0
  local $filepath
  local $file
  local $read
  local $count
  While FileExists(GetOutputPath() & "\" & $i & ".png")
    ;read the contents
    $filepath = GetOutputPath() & "\" & $i & ".txt"
    $file = FileOpen($filepath, $FO_READ)
    $read = FileRead($file)
    FileClose($file)

    $lastcount = $count
    $count = 0

    ;look for matches in read
    For $sub In $substrings
      ;if StringInStr($read, $sub)
      local $res = StringRegExp($read, $sub, 3)
      $count = $count + UBound($res)
      $res = 0
      MsgBox(64, $sub, $count)
    Next

    if $count > $lastcount then
      $winner = $i
    endif

    $i = $i + 1
  WEnd

  ;send the number of that file to the PresentAnswer.
  _PresentAnswer($winner)

EndFunc
