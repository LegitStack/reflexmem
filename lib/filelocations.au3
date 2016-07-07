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
  elseif $exact == "image" then
    Return _PathFull(@AppDataDir & "\ReflexMem\image\")
  else
    Return _PathFull(@AppDataDir & "\ReflexMem\")
  endif

EndFunc


Func VarifyFolders()
   if FileExists(GetScriptsPath()) Then
   Else
	  DirCreate (GetScriptsPath())
   EndIf

   if FileExists(GetScriptsPath("scripts")) Then
   Else
    DirCreate (GetScriptsPath("scripts"))
   EndIf

   if FileExists(GetScriptsPath("if")) Then
   Else
    DirCreate (GetScriptsPath("if"))
   EndIf

   if FileExists(GetScriptsPath("then")) Then
   Else
    DirCreate (GetScriptsPath("then"))
   EndIf

   if FileExists(GetScriptsPath("images")) Then
   Else
    DirCreate (GetScriptsPath("images"))
   EndIf

   if FileExists(GetScriptsPath("image")) Then
   Else
    DirCreate (GetScriptsPath("image"))
   EndIf
EndFunc
