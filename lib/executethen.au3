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
  local $path = GetScriptsPath("then") & $i & ".txt" ;_PathFull(@ScriptDir & "\scripts\then") & "\" & $i & ".txt"
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
      $line = StringReplace($file[$i], " ", @CRLF, 1)
      $statement = StringSplit($line, @CRLF)
      if $statement[0] < 3 then
        $ret[ubound($ret) - 1] = ActionMapThen($statement[1], "")
      else
        $ret[ubound($ret) - 1] = ActionMapThen($statement[1], $statement[3])
      endif
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
      return "MouseClick('" & $arguments & "')"
    Case "mouse" ; x, y
      $args = StringSplit($arguments, " ", 2)
      return "MouseMove(" & $args[0] & "," & $args[1] & ")"
    Case "wheel" ; up down
      return "MouseWheel('" & $arguments & "')"
    case "clip" ; text
      return "ClipPut('" & $arguments & "')"
    case "kill" ; text
      return "processClose('" & $arguments & "')"
    case "unpause" ; text
      return "Assign('paused',False,2)"
    case "pause" ; text
      return "Assign('paused',True,2)"
    case "setvar" ; text
      $args = StringSplit($arguments, " ", 2)
      return "Assign('uservar" & $args[0] & "'," & $args[1] & ",1)"
    case "getvar " ; text
      return "MsgBox(64,'variable: " & $arguments & "',$uservar" & $arguments & ")"
    case "exit" ; text
      return "Exit"
    case "message" ; text
      $args = StringSplit($arguments, " ", 2)
      $restofargs = StringReplace ($arguments, $args[0] & " ", "", 1 , 1)
      return "MsgBox(64, '" & $args[0] & "','" & $restofargs & "')"
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
