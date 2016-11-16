; Variables
; 0 - counter i
; 1 - counter j
; 2 - counter k
; 3 - tempvar
; 4 - tempvar
; 5 - tempvar
; 6 - tempvar
; 7 - tempvar
; 8 - tempvar
; 9 - counter for # of answer images. - A. B. C. D. E. ...
; 10 - question and answer section left
; 11 - question and answer section top
; 12 - question and answer section right
; 13 - question and answer section bottom
; 14 - TEMP (checkbox left)
; 15 - TEMP (checkbox top)
; 16 - TEMP (checkbox right)
; 17 - TEMP (checkbox bottom)
; 18 - (checkbox left)    array of x1 - created when image found on screen
; 19 - (checkbox top)     array of y1 - created when image found on screen
; 20 - (checkbox right)   array of x2 - created when image found on screen
; 21 - (checkbox bottom)  array of y2 - created when image found on screen


hkps {ESC} 1  ;Terminate
hkps ` 4      ;new qeustion
hkps 1 5      ;question top left
hkps 2 6      ;question bottom right
hkps 3 7      ;answer checkbox top left
hkps 4 8      ;answer checkbox bottom right


proc 0
  loop
  endl
endp


Proc 1 Terminate
  Exit
endp


Proc 2 Setup / Cleanup - Remove Files
  ift FileExists(GetScriptsPath("images") & "Cheetah\")
    FileDelete(GetScriptsPath("images") & "Cheetah\*.*")
  elif
    DirCreate(GetScriptsPath("images") & "Cheetah\")
  endi
endp


Proc 3 Setup / Cleanup - Clear Variables
  set 0 0
  loop
    set 0 $v[0]+1
    ;untested...
    set $v[$v[0]]=0
    ift $v[0] >= 200
      bklp
    endi
  endl
endp


Proc 4 indicate new question  - see proc 7 comments.
  ; find the locations of each of the questions
  set 0 0
  loop
    set 0 $v[0]+1
    ;untested...
    ift FileExists(GetScriptsPath("images") & "Cheetah\" & $v[0] &".bmp")
      _ImageSearchArea(GetScriptsPath("images") & "Cheetah\" & $v[0] &".bmp",1,0,0,@DesktopWidth,@DesktopHeight, $X1, $Y1, ,)

    ; 18 - (checkbox left)    array of x1 - created when image found on screen
    ; 19 - (checkbox top)     array of y1 - created when image found on screen
    ; 20 - (checkbox right)   array of x2 - created when image found on screen
    ; 21 - (checkbox bottom)  array of y2 - created when image found on screen

    elif
      bklp
    endi
  endl

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


Proc 5 indicate top of question
  ; this is the beginning of the setup so...
  ; delete all the existing files first.
  goto 2

  ; and clear all the variables
  goto 3

  ; set the first two variables to the top left of the question/area.
  set 10 MouseGetPos(0)
  set 11 MouseGetPos(1)
endp

Proc 6 indicate question right bottom
  set 12 MouseGetPos(0)
  set 13 MouseGetPos(0)
endp

Proc 7 indicate answer checkbox top left
  set 14 MouseGetPos(0)
  set 15 MouseGetPos(1)
endp

Proc 8 indicate answer checkbox bottom right
  set 16 MouseGetPos(0)
  set 17 MouseGetPos(1)

  ; increment counter
  set 9 $v[9]+1

  ; capture image and save it as the next number.
  $sBMP_Path = GetScriptsPath("images") & "Cheetah\" & $v[9] & ".bmp"
  _ScreenCapture_Capture($sBMP_Path, $v[14], $v[15], $v[16], $v[16], False)
endp


Proc 9 COMMENTS
;done
;  ; Setup
;    ; get the general area of questions.
;    ; get the answer icons.

  ; execute - when you press the button for new question
    ; find the x1, x2, y1, y2 of each answer icons. keep the main test area in mind.
      ; add those those icon coordinates to an array.
    ; take that array and the test area coordinates and send to partician screen
      ; PartitionScreenIntoAreas(ByRef $x1, ByRef $x2, ByRef $y1, ByRef $y2, ByRef $sx1, ByRef $sx2, ByRef $sy1, ByRef $sy2)
    ; take that array and the test area coordinates and send them to the trim blank area. one at a time
      ; TrimBlankArea(Byref $x1, Byref $x2, Byref $y1, Byref $y2)
    ; take images of the screen at those coordinates. and get the text of them using tesseract
    ; send question and answer text to the server
    ; await reply
    ; move mouse to the location of the answer.

;done
;  ; clean up
;    ; delete all files.
;    ; exit.
endp
