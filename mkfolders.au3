Func VarifyFolders()
   if FileExists(@ScriptDir & "\scripts\") Then
   Else
	  DirCreate ( @ScriptDir & "\scripts\" )
   EndIf

   if FileExists(@ScriptDir & "\scripts\if\") Then
   Else
    DirCreate ( @ScriptDir & "\scripts\if\" )
   EndIf

   if FileExists(@ScriptDir & "\scripts\then\") Then
   Else
    DirCreate ( @ScriptDir & "\scripts\then\" )
   EndIf

   if FileExists(@ScriptDir & "\images\") Then
   Else
    DirCreate ( @ScriptDir & "\images\" )
   EndIf
EndFunc