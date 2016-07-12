#include "lib\pluginterface.au3"

msgbox(64,"this is a test", "worked")

HotKeySet("{ESC}", "Terminate")

While 1
  Sleep(1)
WEnd

Func Terminate($str)
msgbox(64,"this is a test", "worked")

  RM_Interface_Terminate("Hello AutoIt forums!")
  exit
EndFunc
