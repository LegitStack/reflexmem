#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
;VBScript
;Function lcs(string1,string2)
;	For i = 1 To Len(string1)
;		tlcs = tlcs & Mid(string1,i,1)
;		If InStr(string2,tlcs) Then
;			If Len(tlcs) > Len(lcs) Then
;				lcs = tlcs
;			End If
;		Else
;			tlcs = ""
;		End If
;	Next
;End Function
;WScript.Echo lcs(WScript.Arguments(0),WScript.Arguments(1))

#include <Array.au3>
#include <malkey.au3>
Global $Matches[1]
Global $Main

Func SetupLCS($string1)
   Local $i = 0
   While $i < UBound($Matches)
	  $Matches[$i] = ""
	  $i = $i + 1
   WEnd
   $Main = $string1
   Local $match
   for $i = 0 to StringLen($string1)
	  $match &= StringMid($string1, $i, 1)
	  if $n >= Ubound($matches,2) then
		 $matches = _ArrayAdd2($matches,$c+1,$j)
	  else
         $matches[$j][$n] = $c +1
      endif
	  ArrayAdd($Matches, $match)
   Next
EndFunc

Func FindLCS($string1, $string2)
   If $string1 <> $main Then
	  SetupLCS($string1)
   EndIf
   for $i = 0 to StringLen($string1)
	  $match &= StringMid($string1, $i, 1)
	  If StringInStr($string2, $match) Then
		 ArrayAdd($matches, $match)
	  EndIf
   Next
EndFunc

Func DynamicLCS($x, $y, int m, int n)
{
    int LCSuff[m+1][n+1];
    int result = 0;  // To store length of the longest common substring

    /* Following steps build LCSuff[m+1][n+1] in bottom up fashion. */
    for (int i=0; i<=m; i++)
    {
        for (int j=0; j<=n; j++)
        {
            if (i == 0 || j == 0)
                LCSuff[i][j] = 0;

            else if (X[i-1] == Y[j-1])
            {
                LCSuff[i][j] = LCSuff[i-1][j-1] + 1;
                result = max(result, LCSuff[i][j]);
            }
            else LCSuff[i][j] = 0;
        }
    }
    return result;
}