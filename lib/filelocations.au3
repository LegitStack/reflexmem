#include-once
#include <File.au3>

Func GetScriptsPath($exact = "")

  if $exact == "scripts" then
    Return _PathFull(@AppDataDir & "\ReflexMem\scripts\")
  elseif $exact == "if" then
    Return _PathFull(@AppDataDir & "\ReflexMem\scripts\if\")
  elseif $exact == "then" then
    Return _PathFull(@AppDataDir & "\ReflexMem\scripts\then\")
  elseif $exact == "images" then
    Return _PathFull(@AppDataDir & "\ReflexMem\scripts\images\")
  elseif $exact == "names" then
    Return _PathFull(@AppDataDir & "\ReflexMem\scripts\if\names\")
  elseif $exact == "image" then
    Return _PathFull(@AppDataDir & "\ReflexMem\image\")
  elseif $exact == "plugins" then
    Return _PathFull(@AppDataDir & "\ReflexMem\plugins\")
  elseif $exact == "plib" then
    Return _PathFull(@AppDataDir & "\ReflexMem\lib\")
  else
    Return _PathFull(@AppDataDir & "\ReflexMem\")
  endif

EndFunc


Func VarifyFolders()
  local $exacts = ["", "scripts", "if", "names", "then", "images", "image", "plguins", "plib"]
  for $exact in $exacts
    if FileExists(GetScriptsPath($exact)) Then
    Else
      DirCreate (GetScriptsPath($exact))
    EndIf
  next

EndFunc
