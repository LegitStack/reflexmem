;
#include <Math.au3>
#include <array.au3>
;Edit distance, Levenshtein distance, or Dynamic time warping
; http: www.csse.monash.edu.au/~lloyd/tildeAlgDS/Dynamic/Edit/

; String alignment, sequence alignment, longest common subsequence. or _TraceBack approach.
; http: books.google.com.au/books?id=STGlsyqtjYMC&pg=PA215&lpg=PA215&dq=string+difference+edit+distane&source=bl&ots=kiQ8vAL_v3&sig=TovNa041KRZDRGIa5bVI9HBMp1E&hl=en&ei=nd-iSt-SGIGYkQXd3OWBBA&sa=X&oi=book_result&ct=result&resnum=9#v=onepage&q=&f=false
; http: en.wikipedia.org/wiki/Sequence_alignment
; http: en.wikipedia.org/wiki/Longest_common_subsequence_problem

; [url="http://www.autoitscript.com/forum/index.php?showtopic=40843&view=findpost&p=303848"]http://www.autoitscript.com/forum/index....p?showtopic=40843&view=findpost&p=303848[/url]
Local $sD
Local $s1 = "appropriate meaning", $s2 = "approximate matching"
;Local $s1 = "vintner", $s2 = "writers"
;Local  $s1='test', $s2='jesT'
;Local  $s1 = "456043",  $s2 =  "1234567"

Local $aArr = _EditDistance($s1, $s2)
_TraceBack('', '', '', $aArr, StringLen($s1), StringLen($s2), $s1, $s2, $sD)

ConsoleWrite(@CRLF & $sD & @CRLF & "No. of Differences: " & $aArr[StringLen($s1)][StringLen($s2)] & @CRLF)
;MsgBox(0, "", $sD & @CRLF & @CRLF & "No. of Differences: " & $aArr[StringLen($s1)][StringLen($s2)])
;_ArrayDisplay($aArr)

Func _EditDistance($s1, $s2)
    Local $m[StringLen($s1) + 1][StringLen($s2) + 1], $i, $j
    $m[0][0] = 0;   boundary conditions
    For $j = 1 To StringLen($s2)
        $m[0][$j] = $m[0][$j - 1] + 1;   boundary conditions
    Next
    For $i = 1 To StringLen($s1)
        $m[$i][0] = $m[$i - 1][0] + 1;   boundary conditions
    Next
    For $j = 1 To StringLen($s2);                      outer loop
        For $i = 1 To StringLen($s1) ;                      inner loop
            If (StringMid($s1, $i, 1) = StringMid($s2, $j, 1)) Then
                $diag = 0;
            Else
                $diag = 1
            EndIf
            $m[$i][$j] = _Min($m[$i - 1][$j] + 1, _ ;  insertion
                    (_Min($m[$i][$j - 1] + 1, _  ;      deletion
                    $m[$i - 1][$j - 1] + $diag))) ;   substitution
        Next
    Next
    ;_TraceBack('', '', '', $m, StringLen($s1), StringLen($s2), $s1, $s2, $Dis);
    _ArrayDisplay($m)
    Return $m ; $m[StringLen($s1)][StringLen($s2)]
EndFunc   ;==>_EditDistance


Func _TraceBack($row1, $row2, $row3, $m, $i, $j, $s1, $s2, ByRef $sD)
    Local $diag, $diagCh
    If ($i > 0) And ($j > 0) Then
        $diag = $m[$i - 1][$j - 1]
        $diagCh = '|';
        If (StringMid($s1, $i, 1) <> StringMid($s2, $j, 1)) Then
            $diag += 1
            $diagCh = ' '; }
        EndIf
        If ($m[$i][$j] >= $diag) Then
            _TraceBack(StringMid($s1, $i, 1) & $row1, $diagCh & $row2, StringMid($s2, $j, 1) & $row3, $m, $i - 1, $j - 1, $s1, $s2, $sD);  change or match
        ElseIf $m[$i][$j] = ($m[$i - 1][$j] + 1) Then ;  delete
            _TraceBack(StringMid($s1, $i, 1) & $row1, $diagCh & $row2, '-' & $row3, $m, $i - 1, $j, $s1, $s2, $sD);
        Else
            _TraceBack("-" & $row1, $diagCh & $row2, StringMid($s2, $j, 1) & $row3, $m, $i, $j - 1, $s1, $s2, $sD);  insertion
        EndIf
    ElseIf ($i > 0) Then
        _TraceBack(StringMid($s1, $i, 1) & $row1, " " & $row2, '-' & $row3, $m, $i - 1, $j, $s1, $s2, $sD);
    ElseIf ($j > 0) Then
        _TraceBack("-" & $row1, " " & $row2, StringMid($s2, $j, 1) & $row3, $m, $i, $j - 1, $s1, $s2, $sD);
    Else ;   $i==0 and $j==0
        ;ConsoleWrite( @CRLF & $row1 & @CRLF & $row2 & @CRLF & $row3 & @CRLF)
        $sD = $row1 & @CRLF & $row2 & @CRLF & $row3 & @CRLF
    EndIf
EndFunc   ;==>_TraceBack
;