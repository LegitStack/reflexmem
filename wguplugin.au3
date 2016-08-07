
hkps ` 1      ;new qeustion
hkps 1 2      ;question top left
hkps 2 3      ;question bottom right
hkps 3 4      ;answer checkbox top left
hkps 4 5      ;answer checkbox bottom right
hkps {ESC} 6  ;Terminate


; Variables
; 0 - question left
; 1 - question top
; 2 - question right
; 3 - TEMP (checkbox left)
; 4 - TEMP (checkbox top)
; 5 - TEMP (checkbox right)
; 6 - TEMP (checkbox bottom)
; 7 - Counter for answers (while creating)
; 11 - answer 1 x
; ...
; 20 - answer 10 x
; 21 - answer 1 y
; ...
; 30 - answer 10 y
; 31 - answer 1 text
; ...
; 40 - answer 10 text

Proc 1 indicate new question
  ; get question
  ; get all answers
    ;use counter to save 3,4,5,6 in approapriate variables
    ift $v[7] < 10
      set $v[7]+10 $v[3]
      set $v[7]+20 $v[4]
      set $v[7]+30 "answer_text"
    endi
  ; send in to get result
  ; move mouse to answer that website indicates
  ; wait for next click that is in an answer
  ; send corresponding answer to website.
endp

Proc 6 Terminate
  Exit
endp

Proc 2 indicate top of question
  set 0 MouseGetPos(0)
  set 1 MouseGetPos(1)
endp

Proc 3 indicate question right (technically we dont care about the bottom)
  set 2 MouseGetPos(0)
endp

Proc 4 indicate answer checkbox top left
  set 3 MouseGetPos(0)
  set 4 MouseGetPos(1)
endp

Proc 5 indicate answer checkbox bottom right
  set 5 MouseGetPos(0)
  set 6 MouseGetPos(1)
  ;capture image
endp


proc 0
  loop
  endl
endp
