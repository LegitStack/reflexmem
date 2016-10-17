#include-once
#include <MsgBoxConstants.au3>
#include <File.au3>
#include <Array.au3>

;executeif.exe nameofFile
;ReadFileIf($CmdLine[1])


Func ReadFileIf($name)
  local $read = OpenFileIf($name)
  local $file = StringSplit($read, @CRLF)
  return InterpretFileIf($file)
EndFunc

Func OpenFileIf($i)
  local $path = GetScriptsPath("if") & $i & ".txt" ;_PathFull(@ScriptDir & "\scripts\if") & "\" & $i & ".txt"
  local $file = FileOpen($path, $FO_READ)
  $read = FileRead($file)
  FileClose($file)
  return $read
EndFunc




Func ReadFileIfNames($name)
  return OpenFileIfNames($name)
EndFunc

Func OpenFileIfNames($i)
  local $path = GetScriptsPath("names") & $i & ".txt" ;_PathFull(@ScriptDir & "\scripts\if") & "\" & $i & ".txt"
  local $file = FileOpen($path, $FO_READ)
  $read = FileRead($file)
  FileClose($file)
  return $read
EndFunc






Func ReadFileRecipe($name)
  return OpenFileRecipe($name)
EndFunc

Func OpenFileRecipe($i)
  local $path = GetScriptsPath("recipe") & $i & ".txt"
  local $file = FileOpen($path, $FO_READ)
  $read = FileRead($file)
  FileClose($file)
  return $read
EndFunc




Func InterpretFileIf($file)
  Local $i = 1
  local $statement
  local $line
  local $ret
  ;$ret[0][0] = "command"
  ;$ret[0][1] = "skip"
  ;$ret[0][2] = "arg1"
  ;$ret[0][3] = "arg2"
  While $i < UBound($file)
    if $file[$i] == "" or $file[$i] == " " then
    else
      ;$line = StringReplace ($file[$i], " ", @CRLF, 1)
      ;$statement = StringSplit($line, @CRLF)
      ;_arrayDisplay($statement)
      $ret = $file[$i]
    endif
    $i = $i + 1
  WEnd
  return $ret
EndFunc
;Planet Earth

Func ActionMapIf($command);, $arguments)
  ;if $arguments == "" then
  ;  return $command
  ;else
  ;  return $command  & " " & $arguments
  ;endif
  ;Switch $command
    ;Case "clipboard" ; text
    ;  $args = StringSplit($arguments, " ", 2)
    ;  local $mytext
    ;  for $ii = 1 to Ubound($args)-1
    ;    $mytext = $mytext & " " & $args[$ii]
    ;  next
    ;  $mytext = StringTrimLeft ($mytext, 1)
    ;  return "ClipGet() " & $args[0] & " " & "'" & $mytext & "'"
    ;Case "window" ; up down
      ;if $tcounts[$c] > 250
    ;Case "time" ; skip, mon tue wed thu fri sat sun, @hour, @min, @Sec
    ;  $args = StringSplit($arguments, " ", 2)
    ;  return "@HOUR $args[2]"
    ;Case "image" ; miliseconds
    ;  return "Image " & "ar"
    ;  $args = StringSplit($arguments, " ", 2)
    ;  MouseClick($args[0], $args[1], $args[2])
    ;Case "text" ; keystrokes {KEY}
    ;  $args = StringSplit($arguments, " ", 2)
    ;  MouseMove($args[0], $args[1])
  ;  Case Else
    ;case keypress ; - set to hotkey
    ;Case "running" ; iPID
  ;    Msgbox(64,"if", $command)
  ;EndSwitch
EndFunc
