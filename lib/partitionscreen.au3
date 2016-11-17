Func PartitionScreenIntoAreas(ByRef $x1, ByRef $x2, ByRef $y1, ByRef $y2, ByRef $sx1, ByRef $sx2, ByRef $sy1, ByRef $sy2)

  local $lowesty = 1000000
  local $lowestx = 1000000
  local $i = 0
  while $i < ubound($sy1)
    if $sy1[$i] == "" then
      break
    endif
    if $lowesty > $sy1[$i] Then
      $lowesty = $sy1[$i]
    endif
    if $lowestx > $sx1[$i] Then
      $lowestx = $sx1[$i]
    endif
    $i = $i + 1
  Wend
  $y2 = $lowesty

  ;;;;;;;;;;;;;;;;;;;;;;;;;

  local $sx4 = $sx2
  local $sx3 = $sx1
  $i = 0
  While $i < Ubound($sx1)
    if $sx1[$i] == "" then
      break
    endif

    $sx1[$i] = $sx2[$i]
    $sx2[$i] = _GetClosestRightX($i, $x2,       $sx3, $sx4      )
    $sy2[$i] = _GetClosestDownY( $i, $y2, $sx2, $sx3, $sx4, $sy1)

    $i = $i + 1
  WEnd

EndFunc


Func _GetClosestRightX($j, $x, $sx3, $sx4)
  Local $i    = 0
  local $lowestx1 = 10000000
  while $i < ubound($sx3)
    if $sx3[$i] == "" then
      break
    endif
    if $i == $j then
    elseif $sx3[$i] > $sx4[$j] + 100 then
      if $lowestx1 > $sx3[$i] then
        $lowestx1 = $sx3[$i]
      endif
    endif
    $i + 1
  Wend
  if $lowestx1 = 10000000 then
    $lowestx1 = $x
  endif
  return $lowestx1
EndFunc


Func _GetClosestDownY($j, $y, $sx2, $sx3, $sx4, $sy1)
  Local $i    = 0
  local $lowesty1 = 10000000
  while $i < ubound($sx3)
    if $sx3[$i] == "" then
      break
    endif
    if $i == $j then
    elseif $sx4[$i] < $sx3[$j] then
    elseif $sx3[$i] > $sx2[$j] then
    else
      if $lowesty1 > $sy1[$i] then
          $lowesty1 = $sy1[$i]
      endif
    endif
    $i + 1
  Wend
  if $lowesty1 = 10000000 then
    $lowesty1 = $y
  endif
  return $lowesty1
EndFunc
