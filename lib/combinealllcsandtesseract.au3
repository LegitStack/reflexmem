#include-once
Func ScoreStringAgainstTesseract($s1, $iX1, $iY1, $iX2, $iY2, $threshold)
  local $throwaway
  local $s2 = SaveScreen($throwaway, $iX1, $iY1, $iX2,$iY2, true)
  local $sl1 = stringlen($s1)
  local $sl2 = stringlen($s2)
  if $sl1 < $sl2 then
    for $i = 0 to $sl2-$sl1
      ;levenshteinDistance seems like a more intuitive solution than AllLCS.
      ;msgbox(64,AllLCSPercentize($s1, stringmid($s2,$i,$sl1), GetAllLCS($s1, stringmid($s2,$i,$sl1)))*100, stringmid($s2,$i,$sl1))
      if GetNormalLevenshteinDistance($s1, stringmid($s2,$i,$sl1))*100 > $threshold then
        return true
      endif
    next
  else
    return eval(GetNormalLevenshteinDistance($s1, $s2))*100 > $threshold)
  endif
  return false
EndFunc
