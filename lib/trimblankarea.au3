
;while 1
;  $pos = MouseGetPos()
;  $result = IsHorizontalLineBlank($pos[0], $pos[0]+100, $pos[1])
;  tooltip($result)
;wend


Func _IsHorizontalLineBlank($x1, $x2, $y)
  $w = $x2 - $x1
  If Mod($w, 2) = 0 Then
    $w = $w / 2
  else
    $w = floor($w / 2)
  endif

  Local $iCheckSum1 =PixelChecksum($x1     ,  $y,   $x1 + $w     ,  $y)
  Local $iCheckSum2 =PixelChecksum($x1 + $w,  $y,   $x1 + $w + $w,  $y)

  return $iCheckSum1 - $iCheckSum2

EndFunc

Func _IsVerticalLineBlank($y1, $y2, $x)
  $h = $y2 - $y1
  If Mod($h, 2) = 0 Then
    $h = $h / 2
  else
    $h = floor($h / 2)
  endif

  Local $iCheckSum1 =PixelChecksum($x,  $y1     ,  $x,  $y1 + $h     )
  Local $iCheckSum2 =PixelChecksum($x,  $y1 + $h,  $x,  $y1 + $h + $h)

  return $iCheckSum1 - $iCheckSum2

EndFunc

Func TrimBlankArea(Byref $x1, Byref $x2, Byref $y1, Byref $y2)

  ;go from top        down  till you hit text
  $i = 0
  $result = 0
  while $result == 0
    $i = $i + 5
    $result = _IsHorizontalLineBlank($x1, $x2, $y1 + $i)
    tooltip($i)
  wend
  $y1 = $y1 + $i - 5

  ;go from bottom     up    till you hit text
  $i = 0
  $result = 0
  while $result == 0
    $i = $i + 5
    $result = _IsHorizontalLineBlank($x1, $x2, $y2 - $i)
    tooltip($i)
  wend
  $y2 = $y2 - $i + 5

  ;go from left   to  right till you hit text
  $i = 0
  $result = 0
  while $result == 0
    $i = $i + 5
    $result = _IsVerticalLineBlank($y1, $y2, $x1 + $i)
    tooltip($i)
  wend
  $x1 = $x1 + $i - 5

  ;go from right  to  left  till you hit text
  $i = 0
  $result = 0
  while $result == 0
    $i = $i + 5
    $result = _IsVerticalLineBlank($y1, $y2, $x2 - $i)
    tooltip($i)
  wend
  $x2 = $x2 - $i + 5

EndFunc


;$xx1 = 2192
;$xx2 = 2991
;$yy1 = 522
;$yy2 = 895
;TrimBlankArea($xx1, $xx2, $yy1, $yy2)
;msgbox(64, $xx1 & " " & $xx2, $yy1 & " " & $yy2)
