Func GetLineDistance($x1,$y1,$x2,$y2)
  Local $xs
  Local $ys

  $xs = $x2 - $x1
  $xs = $xs * $xs

  $ys = $y2 - $y1
  $ys = $ys * $ys

  return Sqrt($xs + $ys)
EndFunc
