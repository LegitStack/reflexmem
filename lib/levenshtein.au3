Func GetLevenshteinDistance($string1,$string2)
  Dim $s1len=StringLen($string1),$s2len=StringLen($string2),$arr[$s1len+1][$s2len+1]
  For $i=0 To $s1len
    $arr[$i][0]=$i
  Next
  For $c=0 To $s2len
    $arr[0][$c]=$c
  Next
  For $i=1 To $s1len
    For $c=1 To $s2len
      $9=StringMid($string1,$i,1)<>StringMid($string2,$c,1)
      $7=1+$arr[$i][$c-1]
      $8=$9+$arr[$i-1][$c-1]
      $m=1+$arr[$i-1][$c]
      $m=$m>$7?$7:$m
      $arr[$i][$c]=$m>$8?$8:$m
    Next
  Next
  Return $arr[$s1len][$s2len]
EndFunc
