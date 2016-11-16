Func _ImageSearchArea($findImage,$resultPosition,$x1,$y1,$right,$bottom,ByRef $x, ByRef $y, $tolerance)
  ;MsgBox(0,"asd","" & $x1 & " " & $y1 & " " & $right & " " & $bottom)
  if $tolerance>0 then $findImage = "*" & $tolerance & " " & $findImage

  ;method 1
  ;This works, when running from script, but not from exe.
  ;$result = DllCall(".\lib\dll\ImageSearchDLL.dll", "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)

  ;method 2
  ;This works, when running from script, but not from exe.
  ;here I call it by a handle instead of by filepath or name
  $hDLL = DllOpen(_PathFull(@scriptdir & "\lib\dll\ImageSearchDLL.dll"))
    $result = DllCall($hDLL, "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)
  DllClose($hDLL)

  ; If error exit
  if $result[0]="0" then return 0

  ; Otherwise get the x,y location of the match and the size of the image to
  ; compute the centre of search
  $array = StringSplit($result[0],"|")

  $x=Int(Number($array[2]))
  $y=Int(Number($array[3]))
  if $resultPosition=1 then
    $x=$x + Int(Number($array[4])/2)
    $y=$y + Int(Number($array[5])/2)
  endif
  return 1
EndFunc


Func _ImageSearchAreaMouseMove($findImage,$resultPosition,$x1,$y1,$right,$bottom,ByRef $x, ByRef $y, $tolerance, $speed = 10)

  if $tolerance>0 then $findImage = "*" & $tolerance & " " & $findImage

  ;method 1
  ;This works, when running from script, but not from exe.
  ;$result = DllCall(".\lib\dll\ImageSearchDLL.dll", "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)

  ;method 2
  ;This works, when running from script, but not from exe.
  ;here I call it by a handle instead of by filepath or name
  $hDLL = DllOpen(_PathFull(@scriptdir & "\lib\dll\ImageSearchDLL.dll"))
    $result = DllCall($hDLL, "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)
  DllClose($hDLL)

  ; If error exit
  if $result[0]="0" then return 0

  ; Otherwise get the x,y location of the match and the size of the image to
  ; compute the centre of search
  $array = StringSplit($result[0],"|")

  $x=Int(Number($array[2]))
  $y=Int(Number($array[3]))
  if $resultPosition=1 then
    $x=$x + Int(Number($array[4])/2)
    $y=$y + Int(Number($array[5])/2)
  endif
  mousemove($x,$y,$speed)
  return 1
EndFunc
