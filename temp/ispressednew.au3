#include <Misc.au3>

While 1
    If _IsPressed(11) Then; the control key is #11
        While _IsPressed(11)
          Beep(300, 110)
          sleep(10)
          Beep(300, 110)
        WEnd
    EndIf
WEnd
