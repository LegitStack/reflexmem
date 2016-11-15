Func ScreenArea($x1, $x2, $y1, $y2, $sx1, $sx2, $sy1, $sy2)

  local $lowesty = 1000000
  local $lowestx = 1000000
  local $i = 0
  while $i < ubound($sy1)
    if $lowesty > $sy1[$i] Then
      $lowesty = $sy1[$i]
    endif
    if $lowestx > $sx1[$i] Then
      $lowestx = $sx1[$i]
    endif
    $i = $i + 1
  Wend
  local $qx1 = $x1
  local $qx2 = $x2
  local $qy1 = $y1
  local $qy2 = $lowesty

  $y1 = $lowesty
  $x1 = $lowestx

  ;;;;;;;;;;;;;;;;;;;;;;;;;

  local $setx1 = $sx1
  local $setx2 = $sx2
  local $sety1 = $sy1
  local $sety2 = $sy2

  $i = 0
  While $i < Ubound($sx1)
    $setx1[$i] = 0
    $setx2[$i] = 0
    $sety1[$i] = 0
    $sety2[$i] = 0
    $i = $i + 1
  WEnd

  local $newx2 = 0
  local $newy2 = 0
  local $temp1 = 0
  local $subx1 = $sx1
  local $subx2 = $sx2
  local $suby1 = $sy1
  local $suby2 = $sy2
  local $lowin = -1
  $i = 0
  While $i < Ubound($sx1)
    $lowin = _GetLowestDistanceToBottomRight($x2, $y2, $subx1, $subx2, $suby1, $suby2)

    $temp1 = $sx1[$lowin]

    $sx1[$lowin] = $sx2[$lowin]

    if $sx2[$lowin] < $newx2 then
      $sx2[$lowin] = $newx2
    else
      ;loop through to determine if anyone we've seen before is in our way.
      if $sety1[$j] >= $sy1 then
        if $sety1[$j] < $newy2
      $sx2[$lowin] = $x2
    endif

    if $sy2[$lowin] < $newy2 then
      $sy2[$lowin] = $newy2
    else
      $sy2[$lowin] = $y2
    endif

    $newx2 = $temp1
    $newy2 = $sy1[$lowin]

    ;effectively remove it from the pool, and add it to the list of ones we've seen
    $setx2[$lowin] = $subx2[$lowin]
    $sety1[$lowin] = $suby1[$lowin]
    $subx2[$lowin] = 0
    $suby1[$lowin] = 0

    $i = $i + 1
  WEnd


EndFunc


Func _GetLowestDistanceToBottomRight($x, $y, $sx1, $sx2, $sy1, $sy2)
  Local $lowd = 1000000
  Local $lowi = -1
  Local $i    = 0
  while $i < ubound($sy1)
    if $lowd > ($x - $sx2[$i]) + ($y - $sy1[$i])
      $lowd = ($x - $sx2[$i]) + ($y - $sy1[$i])
      $lowi = $i
    endif
    $i + 1
  Wend
  return $lowi
EndFunc

Func _GetLowestDistanceToTopLeft($x, $y, $sx1, $sx2, $sy1, $sy2)
  Local $lowd = 1000000
  Local $lowi = -1
  Local $i    = 0
  while $i < ubound($sy1)
    if $lowd > ($sx2[$i] - $x) + ($sy1[$i] - $y)
      $lowd = ($sx2[$i] - $x) + ($sy1[$i] - $y)
      $lowi = $i
    endif
    $i + 1
  Wend
  return $lowi
EndFunc
