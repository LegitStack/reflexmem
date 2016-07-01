Local $List = WinList()
Local $Title = ""

For $i = 1 To $List[0][0]
   ;uncomment to show all visible programs
   ;If $List[$i][0] <> "" And IsVisible($List[$i][1]) Then
   ;uncomment to show all programs
   If $List[$i][0] <> "" Then
	  Dim $Process = IDtoName( WinGetProcess($List[$i][0]))
	  $Title &= $Process & @TAB & $List[$i][0] & @CRLF
   EndIf
Next

msgbox(0,"",$Title)

Func IDtoName($Handle)
   Dim $ProcList = ProcessList()

   For $i = 1 To $ProcList[0][0]
	  If $ProcList[$i][1] = $Handle Then
		 Return ($ProcList[$i][0])
	  EndIf
   Next
EndFunc

Func IsVisible($Handle)

   If BitAND( WinGetState($Handle), 2) Then
	  Return 1
   Else
   Return 0
   EndIf
EndFunc