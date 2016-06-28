#include <MsgBoxConstants.au3>
#include <File.au3>
#include <Array.au3>

;executethen.exe nameofFile
;ReadFileThen($CmdLine[1])


Func ReadFileThen($name)
  local $read = OpenFileThen($name)
  local $file = StringSplit($read, @CRLF)
  return InterpretFileThen($file)
EndFunc


Func OpenFileThen($i)
  local $path = _PathFull(@ScriptDir & "\scripts\then") & "\" & $i & ".txt"
  local $file = FileOpen($path, $FO_READ)
  $read = FileRead($file)
  FileClose($file)
  return $read
EndFunc


Func InterpretFileThen($file)
  Local $i = 1
  local $statement
  local $line
  local $ret[1]
  While $i < UBound($file)
    if $file[$i] == "" or $file[$i] == " " then
    else
      $line = StringReplace ($file[$i], " ", @CRLF, 1)
      $statement = StringSplit($line, @CRLF)
      $ret[ubound($ret) - 1] = ActionMapThen($statement[1], $statement[3])
      ReDim $ret[ubound($ret) + 1]
    endif
    $i = $i + 1
  WEnd
  return $ret
EndFunc


Func ActionMapThen($command, $arguments)
  Switch $command
    Case "sleep" ; miliseconds
      return "Sleep(" & $arguments & ")"
    Case "send" ; keystrokes {KEY}
      return "Send('" & $arguments & "')"
    Case "click" ; primary secondary, x, y
      $args = StringSplit($arguments, " ", 2)
      return "MouseClick('" & $args[0] & "'," & $args[1] & "," & $args[2] & ")"
    Case "mouse" ; x, y
      $args = StringSplit($arguments, " ", 2)
      return "MouseMove(" & $args[0] & "," & $args[1] & ")"
    Case "wheel" ; up down
      return "MouseWheel('" & $arguments & "')"
    case "clip" ; text
      return "ClipPut(" & $arguments & ")"
    Case "run" ; programname.exe, .\ c:\somewhere\  , max min hide
      $args = StringSplit($arguments, " ", 2)
      if Ubound($args) == 3 then
          ;_arrayDisplay($args, "args")
          return "Run('" & $args[0] & "', '" & $args[1] & "'," & Execute($args[2]) & ")"
      elseif Ubound($args) == 2 then
        return "Run('" & $args[0] & "', '" & $args[1] & "')"
      else
        return "Run('" & $arguments & "')"
      endif
    Case Else
    ;case keydown
    ;case keyup
    ;case clickdown
    ;case clickup
      Msgbox(64,"Else", "What are you still doing up?")
  EndSwitch
EndFunc
