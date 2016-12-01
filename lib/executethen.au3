#include-once
#include <MsgBoxConstants.au3>
#include <File.au3>
#include <Array.au3>

;executethen.exe nameofFile
;ReadFileThen($CmdLine[1])

Func ReadFileThenNames($name)
  local $read = OpenFileThen($name)
  local $file = StringSplit($read, @CRLF, $STR_NOCOUNT)

  return $file
EndFunc


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
    Case "clickdown" ; primary secondary, x, y
      return "MouseDown('" & $arguments & "')"
    Case "clickup" ; primary secondary, x, y
      return "MouseUp('" & $arguments & "')"
    Case "mouse" ; x, y
      $args = StringSplit($arguments, " ", 2)
      if ubound($args) > 2 then
        return "MouseMove(" & $args[0] & "," & $args[1] & "," & $args[2] & ")"
      else
        return "MouseMove(" & $args[0] & "," & $args[1] & ")"
      endif
    Case "mouseimage" ; x, y
      $args = StringSplit($arguments, " ", 2)
      ;return "_ImageSearchAreaMouseMove('" & $imagefile & "',1," & $iX1 & "," & $iY1 & "," & $iX2 & "," & $iY2 & ", $X1, $Y1, " & $acc & ")"
      if ubound($args) > 6 then
        return "_ImageSearchAreaMouseMove('" & $args[0] & "',1," & $args[1] & "," & $args[2] & "," & $args[3] & "," & $args[4] & ", $X1, $Y1, " & $args[5] & "," & $args[6] & ")"
      else
        return "_ImageSearchAreaMouseMove('" & $args[0] & "',1," & $args[1] & "," & $args[2] & "," & $args[3] & "," & $args[4] & ", $X1, $Y1, " & $args[5] & ")"
      endif
    Case "wheel" ; up down
      return "MouseWheel('" & $arguments & "')"
    case "copy" ; text
      return "ClipPut('" & $arguments & "')"
    case "paste" ; text
      return "Send(ClipGet())"
    case "kill" ; text
      return "processClose('" & $arguments & "')"
    case "unpause" ; text
      return "Assign('paused',False,2)"
    case "pause" ; text
      return "Assign('paused',True,2)"
    case "volume" ; text
      if $arguments == "up" then
        return "Send('{VOLUME_UP}')"
      elseif $arguments == "down" then
        return "Send('{VOLUME_DOWN}')"
      endif
    case "setvar" ; text
      $args = StringSplit($arguments, " ", 2)
      local $combined = ""
      For $i = 1 To Ubound($args) - 1
         $combined = $combined & " " & $args[$i]
      Next
      return "Assign('uservar" & $args[0] & "'," & $combined & ",1)"
    case "await"
      return "AwaitUserAction('" & $arguments & "')"
    case "gettext"
      $args = StringSplit($arguments, " ", 2)
      return "ClipPut(SaveScreen($throwaway, " & $args[0] & ", " & $args[1] & ", " & $args[2] & ", " & $args[3] & ", true))"
    case "getvar" ; text
      $args = StringSplit($arguments, " ", 2)
      if $args[1] == "msg" then
        return "MsgBox(64,'variable: " & $args[0] & "',$uservar" & $args[0] & ")"
      elseif $args[1] == "clip" then
        return "ClipPut($uservar" & $args[0] & ")"
      endif
    case "exit" ; text
      return "Exit"
    case "message" ; text
      $args = StringSplit($arguments, " ", 2)
      ;$restofargs = StringReplace ($arguments, $args[0] & " ", "", 1 , 1)
      local $last = ""
      local $title = ""
      local $messagebox = ""
      For $i = 0 To Ubound($args) - 1
        if $args[$i] == "|" then
          $last = $i
          $i = Ubound($args) + 1
        else
          $title = $title & " " & $args[$i]
        endif
      Next
      For $i = $last+1 To Ubound($args) - 1
        $messagebox = $messagebox & " " & $args[$i]
      Next
      return "MsgBox(64, '" & $title & "','" & $messagebox & "')"
      ;return "MsgBox(64, '" & $args[0] & "','" & $restofargs & "')"
    Case "tip" ; x y message
      $args = StringSplit($arguments, " ", 2)
      local $combined = ""
      For $i = 2 To Ubound($args) - 1
         $combined = $combined & " " & $args[$i]
      Next
      if $args[0] == "meh" then
        return "ToolTip(" & $combined & ")"
      else
        return "ToolTip(" & $combined & "," & $args[0] & "," & $args[1] & ")"
      endif
    Case "execute" ; programname.exe, .\ c:\somewhere\  , max min hide
      ;msgbox(64,"",$arguments)
      return $arguments
    Case Else
    ;case keydown
    ;case keyup
    ;case clickdown
    ;case clickup
    ;Msgbox(64,$command, $arguments)
  EndSwitch
EndFunc
