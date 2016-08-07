
hkps ` 1      ;SetHotKeys
hkps {ESC} 2  ;Terminate

Proc 1 SetHotKeys
  hkps ` 3    ;UnsetHotkeys
endp

Proc 2 Terminate
  Exit
endp

Proc 3 UnsetHotkeys
  hkps ` 1      ;SetHotKeys
  hkps {ESC} 4  ;Donothing
endp

Proc 4 ;Donothing
endp

;Global $ACTIVE = false
;Global $CLICKI = 0
;Global $CLICKS[100]

proc 0
  ift true
    Sleep(10)

    goto 0
  endi
endp
