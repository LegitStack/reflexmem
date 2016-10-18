Func DemoClick($items)
  Local $a = GUIGetCursorInfo()
  For $item In $items
    if UBound($a) > 4 then
      if $a[4] == $item Then
        if _IsPressed("01") then
          MsgBox(64,"Demo Version","Disabled items are not available in the Demo version of this product. The Pro version gives you access to all triggers and behaviors. In addition, the Elite version allows you to use 3rd party plug-ins which can have finer detail capabilities. Please go to reflexmem.com to purchase the Pro or Elite version.")
        Endif
      EndIf
    EndIf
  Next
EndFunc
