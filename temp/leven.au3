;http://codegolf.stackexchange.com/questions/67474/levenshtein-distance/68082
Func l($0,$1,$_=StringLen,$z=StringMid)
Dim $2=$_($0),$3=$_($1),$4[$2+1][$3+1]
For $5=0 To $2
$4[$5][0]=$5
Next
For $6=0 To $3
$4[0][$6]=$6
Next
For $5=1 To $2
For $6=1 To $3
$9=$z($0,$5,1)<>$z($1,$6,1)
$7=1+$4[$5][$6-1]
$8=$9+$4[$5-1][$6-1]
$m=1+$4[$5-1][$6]
$m=$m>$7?$7:$m
$4[$5][$6]=$m>$8?$8:$m
Next
Next
Return $4[$2][$3]
EndFunc