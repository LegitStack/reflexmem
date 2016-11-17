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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; extra ARRAYs
; b - (checkbox left)    array of x1 - created when image found on screen
; c - (checkbox top)     array of y1 - created when image found on screen
; d - (checkbox right)   array of x2 - created when image found on screen
; e - (checkbox bottom)  array of y2 - created when image found on screen


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
    set  0     $v[0]+1
    set  $v[0] ""
    setb $v[0] ""
    setc $v[0] ""
    setd $v[0] ""
    sete $v[0] ""
    ift $v[0] >= 200
      bklp
    endi
  endl

endp


Proc 4 indicate new question - see proc 7 comments.
  ; find the locations of each of the answers
  set 0 0
  loop
    set 0 $v[0]+1
    ift FileExists(GetScriptsPath("images") & "Cheetah\" & $v[0] & ".bmp")

      ; find the image on the screen
      ift _ImageSearchArea(GetScriptsPath("images") & "Cheetah\" & $v[0] & ".bmp",1,0,0,@DesktopWidth,@DesktopHeight, $v[3], $v[4], 0) == 1

        ; get the dimentions of it.
        _GDIPlus_Startup ()
          set 7 _GDIPlus_ImageLoadFromFile(GetScriptsPath("images")&"Cheetah\"&$v[0]&".bmp")
          set 5 _GDIPlus_ImageGetWidth($hImage)+$v[3]
          set 6 _GDIPlus_ImageGetHeight($hImage)+$v[4]
          _GDIPlus_ImageDispose ($v[7])
        _GDIPlus_ShutDown ()

        ; save the dimentions in an array
        setb $v[0] $v[3]
        setc $v[0] $v[4]
        setd $v[0] $v[5]
        sete $v[0] $v[6]
      endi
    elif
      bklp
    endi
  endl

  ; take that array and the test area coordinates and send to partician screen
  set 14 $v[10]
  set 15 $v[11]
  set 16 $v[12]
  set 17 $v[13]
  PartitionScreenIntoAreas($v[14], $v[16], $v[15], $v[17], $b, $c, $d, $e)

  ; take that array and the test area coordinates and send them to the trim blank area. one at a time
  TrimBlankArea($v[14], $v[16], $v[15], $v[17])
  set 0 0
  loop
    ift $b[$i] == ""
      bklp
    endi
    TrimBlankArea($b[$v[0]], $c[$v[0]], $d[$v[0]], $e[$v[0]])
    set 0 $v[0]+1
  endl

  ; take images of the screen at those coordinates
  ; and get the text of them using tesseract
  set 99 SaveScreen($v[1],$v[14],$v[15],$v[16],$v[17],true)
  set 0 0
  loop
    ift $b[$i] == ""
      bklp
    endi
    set $v[0]+100 SaveScreen($v[1],$b[14],$d[15],$c[16],$e[17],true)
    set 0 $v[0]+1
  endl

  ; compile question and answer texts into one list
  set 98 "'::::START::::' "
  set 0 0
  loop
    ift $b[$i] == ""
      bklp
    endi
    set 98 $v[98]&" '::::NEXT::::' "& $v[99]+$v[0]
    set 0 $v[0]+1
  endl

  ; send question and answer text to the server and await reply
  ;set $v[5] = toweb .... returns a number - 0 for the first answer

  ; move mouse to the location of the answer.
  MouseMove($b[$v[5]],$c[$v[5]])

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
