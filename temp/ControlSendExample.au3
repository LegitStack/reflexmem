local $sleeptime = 2000
ShellExecute("calc.exe")
winwaitactive("[CLASS:CalcFrame]") ; only for test propourses, you can avoid this line.
tooltip("sleeping.")
Sleep($sleeptime*2)
;A way to do it.
ControlClick("[CLASS:CalcFrame]", "", "[CLASS:Button; INSTANCE:13]" ) ; press button "C" for cleaning propourses.
tooltip("press button ´C´ for cleaning propourses.")
sleep($sleeptime)
Controlsend("[CLASS:CalcFrame]", "", "[CLASS:#32770]","1{NUMPADADD}2{ENTER}") ; sending keys "1 + 2 ENTER" to control.
tooltip("sending keys `1 + 2 ENTER` to control.")
Sleep($sleeptime)
tooltip("sleeping.")
Sleep($sleeptime*2)
;Another way to do it.
ControlClick("[CLASS:CalcFrame]", "", "[CLASS:Button; INSTANCE:13]" ) ; press button "C" for cleaning propourses.
tooltip("press button ´C´ for cleaning propourses.")
sleep($sleeptime)
Controlsend("[CLASS:CalcFrame]", "", "[CLASS:#32770]","1") ; sending 1 to control.
tooltip("sending 1 to control.")
sleep($sleeptime)
Controlsend("[CLASS:CalcFrame]", "", "[CLASS:#32770]","{NUMPADADD}") ; sending + to control.
tooltip("sending + to control.")
sleep($sleeptime)
Controlsend("[CLASS:CalcFrame]", "", "[CLASS:#32770]","2") ; sending 2 to control.
tooltip("sending 2 to control.")
sleep($sleeptime)
Controlsend("[CLASS:CalcFrame]", "", "[CLASS:#32770]","{ENTER}") ; sending ENTER to control.
tooltip("sending ENTER to control.")
Sleep($sleeptime)
tooltip("sleeping.")
Sleep($sleeptime*2)
;And another way to do it.
ControlClick("[CLASS:CalcFrame]", "", "[CLASS:Button; INSTANCE:13]" ) ; press button "C" for cleaning propourses.
tooltip("press button ´C´ for cleaning propourses.")
sleep($sleeptime)
ControlClick("[CLASS:CalcFrame]", "", "[CLASS:Button; INSTANCE:5]" ) ; press button "1".
tooltip("press button `1`.")
sleep($sleeptime)
ControlClick("[CLASS:CalcFrame]", "", "[CLASS:Button; INSTANCE:23]" ) ; press button "+".
tooltip("press button `+`.")
sleep($sleeptime)
ControlClick("[CLASS:CalcFrame]", "", "[CLASS:Button; INSTANCE:11]" ) ; press button "2".
tooltip("press button `2`.")
sleep($sleeptime)
ControlClick("[CLASS:CalcFrame]", "", "[CLASS:Button; INSTANCE:23]" ) ; press button "=".
tooltip("press button `=`.")
Sleep($sleeptime)
tooltip("Exiting.")
Sleep($sleeptime*3)
