; this is for the module to make it easy for the computer to find the question
; and answers automatically so that the user doesn't have to manually say where
; everything is everytime.
;   to that end also make a module that the user can specify the checkbox image
;   for it to look for. that way it can automatically know where the question is
;   (everything above the first checkbox) and where every individual question is
;   (everything before the next checkbox).

; Maybe this module is irrevant. If we specify where the begining of a question
; may be, then specify what the answer checkboxes look like, we might not need
; this. all we need is four buttons. plus one more for specifing 'new question'

#include-once


Func IndicateQuestionTop()
  $pos = MouseGetPos()

  $CLICKS[0] = $pos[0]
  $CLICKS[1] = $pos[1]

EndFunc

Func IndicateQuestionBottom()

EndFunc

Func IndicateCheckboxTop()

EndFunc

Func IndicateCheckboxBottom()

EndFunc
