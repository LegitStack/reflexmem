#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <Misc.au3>
#include <GuiListView.au3>
#include <FileConstants.au3>
#include <File.au3>
#include <WindowsConstants.au3>
#include <lib\executeif.au3>
#include <lib\executethen.au3>
#include <lib\filelocations.au3>
#include <lib\alllcs.au3>
#include <lib\tesseract_stdout.au3>
#include <lib\combinealllcsandtesseract.au3>
#include <lib\levenshtein.au3>
#include <lib\imagesearcharea.au3>
#include <Crypt.au3>
#include <lib\applieddpi.au3>
#include <WinAPIFiles.au3>
;$R = GetScale()
$R = 1

VarifyFolders()

GetTriggers()
PopulateGui()

;Get a list of triggers and behaviors
Func GetTriggers()

  global $triggers[1]
  global $triggernames[1]
  global $behaviors[1000][1]
  global $behaviornames[1000][1]
  global $tcounts[1]
  global $recipes[1]


  local $i = 0
  While FileExists(GetScriptsPath("if") & $i & ".txt")
    ReDim $triggers[$i + 1]
    Redim $triggernames[$i + 1]
    ReDim $behaviors[1000][$i + 1]
    ReDim $behaviornames[1000][$i + 1]
    ReDim $tcounts[$i + 1]
    ReDim $recipes[$i + 1]
    $triggers[$i] = ReadFileIf($i)
    $triggernames[$i] = ReadFileIfNames($i)
    $recipes[$i] = ReadFileRecipe($i)
    $temp = ReadFileThen($i)
    $j = 0
    For $t In $temp
      $behaviors[$j][$i] = $t
      $j = $j + 1
    next
    $temp = ReadFileThenNames($i)
    $j = 0
    For $t In $temp
      if $t <> "" then
        $behaviornames[$j][$i] = $t
        $j = $j + 1
      endif
    next
    $i = $i + 1
  WEnd

;  global $hotkeys[100][Ubound($triggers)]
;  local $hotloc
;  local $endloc
;  local $middle
  ;_arrayDisplay($triggers)

;  for $i = 0 to Ubound($triggers)-1
;    while StringInStr($triggers[$i], "HotKeySet(", 1)
;      $hotloc = StringInStr($triggers[$i], "HotKeySet(", 1)
;      $endloc = StringInStr($triggers[$i], ")", 1,1,$hotloc+15)
;      $middle = StringMid($triggers[$i], $hotloc, $endloc-$hotloc+1)
;      $triggers[$i] = stringleft($triggers[$i], $hotloc-1) & stringright($triggers[$i], stringlen($triggers[$i])-$endloc)
;      for $j = 0 to 100
;        msgbox(64,$j, $i)
;        if $hotkeys[$j][$i] = "" then
;          $hotkeys[$j][$i] = $middle
;          $j = 100
;        endif
;        ;_arrayDisplay($hotkeys)
;      next
      ;MsgBox(64, $hotloc, $endloc)
      ;MsgBox(64, $middle, $trigger)
;      Execute($middle)
;    WEnd
;  next


EndFunc


Func HotKeyTrigger()
  ;$msg = GUIGetMsg()
  ;Switch $msg
  ;    Case -3
  ;        Exit
  ;    Case Else
  ;        For $i = 0 To $loop - 1
  ;            If $msg = $Guiarr[$i][0] Then _Enable ($Guiarr[$i][0],$Guiarr[$i][1])
  ;        Next
  ;EndSwitch
  ;  Switch @HotKeyPressed
  ;    Case "^!u"
  ;        SendUnicode("ü")
  ;    Case "^!o"
  ;        SendUnicode("ö")
  ;    Case "^!i"
  ;        SendUnicode("ï")
  ;  EndSwitch
  ;  Execute( the behavior that matches the trigger that contains the @hotkeypressed)


;  local $trigs[Ubound($triggers)]
;  For $i = 0 To ubound($idCheckbox) - 1
;    If $msg == $idCheckbox[$i] Then
;      If _IsChecked($idCheckbox[$i]) Then
;        $trigs[$i] = 1
;        ;MsgBox($MB_SYSTEMMODAL, $msg, "aThe checkbox is checked.", 0, $hGUI)
;      Else
;        $trigs[$i] = ""
;        ;MsgBox($MB_SYSTEMMODAL, $msg, "aThe checkbox is not checked.", 0, $hGUI)
;      EndIf
;    Endif
;  Next


  ;if $paused == false then
;    for $c = 0 to ubound($triggers)-1
;      if $trigs[$c] == 1 then
;        for $j = 0 to 100
;          if StringInStr($hotkeys[$j][$c], @HotKeyPressed) > 0 then
;            for $i = 0 to 100
;              if $behaviors[$i][$c] == ""  then
;                $i = 101
;              else
;                if $paused then
;                  if $behaviors[$i][$c] == "$paused = false" then
;                    Execute($behaviors[$i][$c])
;                  endif
;                else
;                  Execute($behaviors[$i][$c])
;                endif
;              endif
;;            next
  ;        endif
  ;      next
  ;    endif
  ;  next
  ;endif
EndFunc

Func PopulateGui()

  Global $hGUI = GUICreate("Reflex Memory Run", 610*$R, 660*$R)
  Local $idCheckbox[Ubound($triggers)]
  Local $idDelete[Ubound($triggers)]
  Local $idModify[Ubound($triggers)]
  ;Local $idPlugin[Ubound($triggers)]
    ; put this below idmodify for everyone.
    ; it would open up another screen with settings and code to modify or add to.
    ; then a button that encrypts it approapriately.
  Local $idBlist[Ubound($triggers)]
  Local $locCx[Ubound($triggers)]
  Local $locDx[Ubound($triggers)]
  Local $locEx[Ubound($triggers)]
  Local $locBx[Ubound($triggers)]

  ;_arrayDisplay($triggers)
  local $j = 0
  local $k = 0

  for $i = 0 to Ubound($triggers)-1
    if $triggers[$i] <> "" then
      if $recipes[$i] <> "" then
        $rname = $recipes[$i]
      else
        $rname = "Behaviors                             "
      endif
      if $triggernames[$i] <> "" then
        $name = $triggernames[$i]
      else
        $name = $triggers[$i]
      endif
      $idCheckbox[$i] = GUICtrlCreateCheckbox(" If " & $name & " then", (($j*300)+10)*$R, (($k*150)+10)*$R, 290*$R, 25*$R)
      ;"Behaviors                             "
      $idBlist[$i] = GUICTRLCreateListView($rname, (($j*300)+10)*$R, (($k*150)+40)*$R, 180*$R, 100*$R)
      for $b = 0 to Ubound($behaviors, 1)-1
        if $behaviornames[$b][$i] <> "" then
          _GUICtrlListView_AddItem($idBlist[$i], $behaviornames[$b][$i], 1)
        endif
      next
      $idDelete[$i] = GUICtrlCreateButton("Delete", (($j*300)+200)*$R, (($k*150)+40)*$R, 100*$R, 27*$R)
      $idModify[$i] = GUICtrlCreateButton("Modify", (($j*300)+200)*$R, (($k*150)+72)*$R, 100*$R, 27*$R)
    endif
    $locCx[$i] = (($j*300)+10)*$R
    $locDx[$i] = (($j*300)+200)*$R
    $locEx[$i] = (($j*300)+200)*$R
    $locBx[$i] = (($j*300)+10)*$R

    $k = $k + 1
    if $k == 4 then
      $k = 0
      $j = $j+1
    endif
  next
  ;GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKTOP)
  Local $idClose = GUICtrlCreateButton("Close", 10*$R, 610*$R, 60*$R, 40*$R) ;10, 610, 100, 40)
  Local $idCreatePlugin = GUICtrlCreateButton("Create Plugin", 80*$R, 610*$R, 80*$R, 40*$R)
  Local $idSlider1 = GUICtrlCreateSlider(170*$R, 620*$R, 320*$R, 30*$R) ;(120, 620, 370, 30)
  GUICtrlSetLimit(-1, 100, 0) ; change min/max value GUICtrlSetPos ( controlID, left [, top [, width [, height]]] )
  local $pLabel = GUICtrlCreateLabel("", 535*$R, 600*$R, 80*$R, 20*$R)
  GUICtrlSetFont($pLabel, 7, $FW_NORMAL,  $GUI_FONTITALIC)
  Local $idStart = GUICtrlCreateButton("Start", 500*$R, 610*$R, 100*$R, 40*$R)

  GUISetState(@SW_SHOW, $hGUI)

  local $trigs[Ubound($triggers)]
  local $msg
  Global $paused = False
  Local $X1 = 0
  local $Y1 = 0

  local $loop1 = 1
  local $loop2 = 1
  local $loop3 = 1

  local $blanksfound = true
  local $throwaway

  local $olduservar0
  local $olduservar1
  local $olduservar2
  local $olduservar3
  local $olduservar4
  local $olduservar5
  local $olduservar6
  local $olduservar7
  local $olduservar8
  local $olduservar9
  local $olduservar10
  local $olduservar11
  local $olduservar12
  local $olduservar13
  local $olduservar14
  local $olduservar15
  local $olduservar16
  local $olduservar17
  local $olduservar18
  local $olduservar19
  local $olduservar20
  local $olduservar21
  local $olduservar22
  local $olduservar23
  local $olduservar24
  local $olduservar25
  local $olduservar26
  local $olduservar27
  local $olduservar28
  local $olduservar29
  local $olduservar30
  local $olduservar31
  local $uservar0
  local $uservar1
  local $uservar2
  local $uservar3
  local $uservar4
  local $uservar5
  local $uservar6
  local $uservar7
  local $uservar8
  local $uservar9
  local $uservar10
  local $uservar11
  local $uservar12
  local $uservar13
  local $uservar14
  local $uservar15
  local $uservar16
  local $uservar17
  local $uservar18
  local $uservar19
  local $uservar20
  local $uservar21
  local $uservar22
  local $uservar23
  local $uservar24
  local $uservar25
  local $uservar26
  local $uservar27
  local $uservar28
  local $uservar29
  local $uservar30
  local $uservar31
  local $temp
  local $returned

  while $loop1 == 1
    While $loop2 == 1
      $msg = GUIGetMsg()
      Switch $msg
        Case $GUI_EVENT_CLOSE, $idClose
          $loop2 = 0
          $loop1 = 0
          Guidelete($hGUI)
          ReturnToMain()
        Case $idStart
          SetUnPause($loop1, $loop2, $loop3, $idStart)
          for $i = 0 to ubound($triggers)-1
            GUICtrlSetState($idCheckbox[$i],$GUI_DISABLE)
            GUICtrlSetState($idDelete[$i],$GUI_DISABLE)
            GUICtrlSetState($idModify[$i],$GUI_DISABLE)
            GUICtrlSetState($idBlist[$i],$GUI_DISABLE)
          next
        Case $idCreatePlugin
          $codetemp = "proc 0" & @CRLF
          $codetemp = $codetemp & "while 1" & @CRLF
          for $c = 0 to ubound($trigs)-1
            $codetemp = $codetemp & "if " & $triggers[$c] & " then" & @CRLF
            for $i = 0 to 1000
              if $behaviors[$i][$c] == ""  then
                $i = 1001
              else
                $codetemp = $codetemp & $behaviors[$i][$c] & @CRLF
              endif
            next
            $codetemp = $codetemp & "endif" & @CRLF
          next
          $codetemp = $codetemp & "wend" & @CRLF
          $codetemp = $codetemp & "endp"
          ;msgbox(64,"code",$codetemp)
          $codetemp = _Crypt_EncryptData($codetemp, "a", $CALG_AES_256)
          ;msgbox(64,"code",$codetemp)
          If Not FileWrite(@DesktopDir & "\ProPlugin1.rmplugin", "") Then
            MsgBox($MB_SYSTEMMODAL, $name, "couldn't save plugin")
            Return False
          EndIf
          ;MsgBox($MB_SYSTEMMODAL, $name, "mde empty")
          FileWriteLine (@DesktopDir & "\ProPlugin1.rmplugin", "'" & $codetemp & "'")
          _Crypt_EncryptFile(@DesktopDir & "\ProPlugin1.rmplugin", @DesktopDir & "\ProPlugin.rmplugin", "thispasswordshouldcomefromourserversinordertobemoresecure", $CALG_AES_256)
          FileDelete(@DesktopDir & "\ProPlugin1.rmplugin")
          MsgBox($MB_SYSTEMMODAL, $name, "Plugin Saved to your Desktop as ProPlugin.rmplugin")
        Case Else
          ;if _IsPressed('2E') then
          ;  ;msgbox(64, "msg", $msg)
          ;  if $msg <> 0 then
          ;    ToolTip($msg)
          ;  endif
          ;endif
          For $i = 0 To ubound($idCheckbox) - 1
            If $msg == $idCheckbox[$i] Then
              If _IsChecked($idCheckbox[$i]) Then
                $trigs[$i] = 1
              Else
                $trigs[$i] = ""
              EndIf
            elseif $msg == $idModify[$i] then
                $temp = "rmcreate.exe " & $i
                run($temp)
                $loop2 = 0
                $loop1 = 0
                Guidelete($hGUI)
                Run("explorer.exe " & GetScriptsPath("scripts"))
                Exit
            elseif $msg == $idDelete[$i] then
              FileDelete(GetScriptsPath("if") & $i & ".txt")
              FileDelete(GetScriptsPath("then") & $i & ".txt")
              FileDelete(GetScriptsPath("names") & $i & ".txt")
              FileDelete(GetScriptsPath("recipe") & $i & ".txt")
              GUICtrlDelete ( $idCheckbox[$i] )
              GUICtrlDelete ( $idDelete[$i] )
              GUICtrlDelete ( $idModify[$i] )
              GUICtrlDelete ( $idBlist[$i] )
              $trigs[$i] = ""
              for $j = 0 to ubound($idCheckbox)-2
                if $j >= $i then
                  $trigs[$j]          = $trigs[$j+1]
                  $idCheckbox[$j]     = $idCheckbox[$j+1]
                  $idDelete[$j]       = $idDelete[$j+1]
                  $idModify[$j]       = $idModify[$j+1]
                  $idBlist[$j]        = $idBlist[$j+1]
                  $triggers[$j]       = $triggers[$j+1]
                  $recipes[$j]        = $recipes[$j+1]
                  $triggernames[$j]   = $triggernames[$j+1]
                  $tcounts[$j]        = $tcounts[$j+1]
                  $locCx[$j]          = $locCx[$j+1]
                  $locDx[$j]          = $locDx[$j+1]
                  $locBx[$j]          = $locBx[$j+1]
                  $locEx[$j]          = $locEx[$j+1]
                  for $k = 0 to Ubound($behaviors, 1)-1
                    $behaviors[$k][$j]  = $behaviors[$k][$j+1]
                    $behaviornames[$k][$j]  = $behaviornames[$k][$j+1]
                  next
                  if FileExists(GetScriptsPath("if") & $j+1 & ".txt") then
                    FileMove(GetScriptsPath("if") & $j+1 & ".txt", GetScriptsPath("if") & $j & ".txt", $FC_OVERWRITE)
                  endif
                  if FileExists(GetScriptsPath("then") & $j+1 & ".txt") then
                    FileMove(GetScriptsPath("then") & $j+1 & ".txt", GetScriptsPath("then") & $j & ".txt", $FC_OVERWRITE)
                  endif
                  if FileExists(GetScriptsPath("names") & $j+1 & ".txt") then
                    FileMove(GetScriptsPath("names") & $j+1 & ".txt", GetScriptsPath("names") & $j & ".txt", $FC_OVERWRITE)
                  endif
                  if $trigs[$j] <> "" then
                    $blanksFound = true
                  endif
                endif
              next
            else
              ;for $i = 0 to ubound($triggers)-1
                GUICtrlSetPos($idCheckbox[$i],$locCx[$i]-(GUICtrlRead($idSlider1)*50))
                GUICtrlSetPos($idBlist[$i],   $locBx[$i]-(GUICtrlRead($idSlider1)*50))
                GUICtrlSetPos($idDelete[$i],  $locDx[$i]-(GUICtrlRead($idSlider1)*50))
                GUICtrlSetPos($idModify[$i],  $locEx[$i]-(GUICtrlRead($idSlider1)*50))
              ;next
            Endif
          Next
      EndSwitch
    wend

    ; Loop until the user exits.
    While $loop3 == 1
      ;check for changes from user.
      $msg = GUIGetMsg()
      Switch $msg
        Case $GUI_EVENT_CLOSE, $idClose
          $loop3 = 0
          $loop1 = 0
          Guidelete($hGUI)
          ReturnToMain()
        Case $idStart
          SetPause($loop1, $loop2, $loop3, $idStart)
          SetPLabel($pLabel, "")
          for $i = 0 to ubound($idCheckbox)-1
            GUICtrlSetState($idCheckbox[$i],$GUI_ENABLE)
            GUICtrlSetState($idDelete[$i],$GUI_ENABLE)
            GUICtrlSetState($idModify[$i],$GUI_ENABLE)
            GUICtrlSetState($idBlist[$i],$GUI_ENABLE)
          next
        Case Else
          For $i = 0 To ubound($idCheckbox) - 1
            If $msg == $idCheckbox[$i] Then
              If _IsChecked($idCheckbox[$i]) Then
                $trigs[$i] = 1
              Else
                $trigs[$i] = ""
              EndIf
            Endif
          Next
          for $c = 0 to ubound($triggers)-1
            if $trigs[$c] == 1 then
              $tcounts[$c] = $tcounts[$c] + 1
              if Execute($triggers[$c]) then
                for $i = 0 to 1000
                  if $behaviors[$i][$c] == ""  then
                    $i = 1001
                  else
                    ;msgbox(64, $paused, $behaviors[$i][$c])
                    if $paused == true then
                      SetPLabel($pLabel, "Paused!") ;technically redundant
                      if $behaviors[$i][$c] == "Assign('paused',False,2)" then
                        SetPLabel($pLabel, "")
                        Execute($behaviors[$i][$c])
                      endif
                    else
                      if $behaviors[$i][$c] == "Exit" then
                        Exit
                      else
                        Execute($behaviors[$i][$c])
                        ;msgbox(64, "returned troubleshooting", $returned)
                        if $paused == true then
                          SetPLabel($pLabel, "Paused!")
                        endif
                        if StringInStr($triggers[$c], "$olduservar") > 0 then
                          $temp = "Assign('olduservar" & stringmid($behaviors[$i][$c],11,2) & "',$uservar" & stringmid($behaviors[$i][$c],11,2) & ",1)"
                          execute($temp)
                        endif
                      endif
                    endif
                  endif
                next
                $tcounts[$c] = 0
              endif
            endif
          next
      EndSwitch
    WEnd
  WEnd
  ; Delete the previous GUI and all controls.
  GUIDelete($hGUI)
  ReturnToMain()
EndFunc   ;==>Example

Func SetPLabel($pLabel, $data)
  if GUICtrlRead($pLabel) <> $data Then
    GUICtrlSetData($pLabel, $data)
  EndIf
EndFunc


Func SetUnPause(ByRef $loop1, ByRef $loop2, ByRef $loop3, ByRef $idStart)
  $loop1 = 1
  $loop2 = 0
  $loop3 = 1
  GUICtrlSetData ( $idStart, "Pause" )
EndFunc
Func SetPause(ByRef $loop1, ByRef $loop2, ByRef $loop3, ByRef $idStart)
  $loop1 = 1
  $loop2 = 1
  $loop3 = 0
  GUICtrlSetData ( $idStart, "Start" )
  $paused = False
EndFunc

;Func _IsChecked($idControlID)
;  Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
;EndFunc   ;==>_IsChecked


Func OpenReadFile($sFilePath)
  Local $hFileOpen = FileOpen($sFilePath, $FO_READ)
  If $hFileOpen = -1 Then
    Return "File Not Found"
  EndIf

    ; Read the contents of the file using the handle returned by FileOpen.
    Local $sFileRead = FileRead($hFileOpen)

  ; Close the handle returned by FileOpen.
  FileClose($hFileOpen)

  return $sFileRead
EndFunc


Func OpenWriteFile($sFilePath, $data)
  Local $hFileOpen = FileOpen($sFilePath, $FO_CREATEPATH + $FO_OVERWRITE)
    ; Create a temporary file to read data from.
    If Not FileWrite($sFilePath, $data) Then
      Return "File Not Created"
    EndIf
  FileClose($hFileOpen)
EndFunc


Func SetYesNo($data)
  if $data == 6 then
    return 'Yes'
  else
    return 'No'
  endif

EndFunc   ;==>Example


Func ReturnToMain()
	if FileExists("reflexmem-pro.exe") then
		Run("reflexmem-pro.exe")
	elseif FileExists("reflexmem-elite.exe") then
		Run("reflexmem-elite.exe")
	else
		Run("reflexmem.exe")
	endif
	GUIDelete($hGUI)
	Exit
EndFunc

Func AwaitUserAction($data = "click")
  local $waiting = true
  if $data == "any" then
    While $waiting
      If _IsPressed("01") Then
        $waiting = False
      elseif _IsPressed("02") Then
        $waiting = False
      elseif _IsPressed("04") Then
        $waiting = False
      elseif _IsPressed("05") Then
        $waiting = False
      elseif _IsPressed("06") Then
        $waiting = False
      elseif _IsPressed("03") Then
        $waiting = False
      elseif _IsPressed("08") Then
        $waiting = False
      elseif _IsPressed("09") Then
        $waiting = False
      elseif _IsPressed("0C") Then
        $waiting = False
      elseif _IsPressed("0D") Then
        $waiting = False
      elseif _IsPressed("10") Then
        $waiting = False
      elseif _IsPressed("11") Then
        $waiting = False
      elseif _IsPressed("12") Then
        $waiting = False
      elseif _IsPressed("13") Then
        $waiting = False
      elseif _IsPressed("14") Then
        $waiting = False
      elseif _IsPressed("20") Then
        $waiting = False
      elseif _IsPressed("1B") Then
        $waiting = False
      elseif _IsPressed("21") Then
        $waiting = False
      elseif _IsPressed("22") Then
        $waiting = False
      elseif _IsPressed("23") Then
        $waiting = False
      elseif _IsPressed("24") Then
        $waiting = False
      elseif _IsPressed("25") Then
        $waiting = False
      elseif _IsPressed("26") Then
        $waiting = False
      elseif _IsPressed("27") Then
        $waiting = False
      elseif _IsPressed("28") Then
        $waiting = False
      elseif _IsPressed("29") Then
        $waiting = False
      elseif _IsPressed("2A") Then
        $waiting = False
      elseif _IsPressed("2B") Then
        $waiting = False
      elseif _IsPressed("2C") Then
        $waiting = False
      elseif _IsPressed("2D") Then
        $waiting = False
      elseif _IsPressed("2E") Then
        $waiting = False
      elseif _IsPressed("30") Then
        $waiting = False
      elseif _IsPressed("31") Then
        $waiting = False
      elseif _IsPressed("32") Then
        $waiting = False
      elseif _IsPressed("33") Then
        $waiting = False
      elseif _IsPressed("34") Then
        $waiting = False
      elseif _IsPressed("35") Then
        $waiting = False
      elseif _IsPressed("36") Then
        $waiting = False
      elseif _IsPressed("37") Then
        $waiting = False
      elseif _IsPressed("38") Then
        $waiting = False
      elseif _IsPressed("39") Then
        $waiting = False
      elseif _IsPressed("41") Then
        $waiting = False
      elseif _IsPressed("42") Then
        $waiting = False
      elseif _IsPressed("43") Then
        $waiting = False
      elseif _IsPressed("44") Then
        $waiting = False
      elseif _IsPressed("45") Then
        $waiting = False
      elseif _IsPressed("46") Then
        $waiting = False
      elseif _IsPressed("47") Then
        $waiting = False
      elseif _IsPressed("48") Then
        $waiting = False
      elseif _IsPressed("49") Then
        $waiting = False
      elseif _IsPressed("4A") Then
        $waiting = False
      elseif _IsPressed("4B") Then
        $waiting = False
      elseif _IsPressed("4C") Then
        $waiting = False
      elseif _IsPressed("4D") Then
        $waiting = False
      elseif _IsPressed("4E") Then
        $waiting = False
      elseif _IsPressed("4F") Then
        $waiting = False
      elseif _IsPressed("50") Then
        $waiting = False
      elseif _IsPressed("52") Then
        $waiting = False
      elseif _IsPressed("51") Then
        $waiting = False
      elseif _IsPressed("53") Then
        $waiting = False
      elseif _IsPressed("54") Then
        $waiting = False
      elseif _IsPressed("55") Then
        $waiting = False
      elseif _IsPressed("56") Then
        $waiting = False
      elseif _IsPressed("57") Then
        $waiting = False
      elseif _IsPressed("58") Then
        $waiting = False
      elseif _IsPressed("59") Then
        $waiting = False
      elseif _IsPressed("5A") Then
        $waiting = False
      elseif _IsPressed("5B") Then
        $waiting = False
      elseif _IsPressed("5C") Then
        $waiting = False
      elseif _IsPressed("60") Then
        $waiting = False
      elseif _IsPressed("61") Then
        $waiting = False
      elseif _IsPressed("62") Then
        $waiting = False
      elseif _IsPressed("63") Then
        $waiting = False
      elseif _IsPressed("64") Then
        $waiting = False
      elseif _IsPressed("65") Then
        $waiting = False
      elseif _IsPressed("66") Then
        $waiting = False
      elseif _IsPressed("67") Then
        $waiting = False
      elseif _IsPressed("68") Then
        $waiting = False
      elseif _IsPressed("69") Then
        $waiting = False
      elseif _IsPressed("6A") Then
        $waiting = False
      elseif _IsPressed("6B") Then
        $waiting = False
      elseif _IsPressed("6C") Then
        $waiting = False
      elseif _IsPressed("6D") Then
        $waiting = False
      elseif _IsPressed("6E") Then
        $waiting = False
      elseif _IsPressed("6F") Then
        $waiting = False
      elseif _IsPressed("70") Then
        $waiting = False
      elseif _IsPressed("71") Then
        $waiting = False
      elseif _IsPressed("72") Then
        $waiting = False
      elseif _IsPressed("73") Then
        $waiting = False
      elseif _IsPressed("74") Then
        $waiting = False
      elseif _IsPressed("75") Then
        $waiting = False
      elseif _IsPressed("76") Then
        $waiting = False
      elseif _IsPressed("77") Then
        $waiting = False
      elseif _IsPressed("78") Then
        $waiting = False
      elseif _IsPressed("79") Then
        $waiting = False
      elseif _IsPressed("7A") Then
        $waiting = False
      elseif _IsPressed("7B") Then
        $waiting = False
      elseif _IsPressed("7C") Then
        $waiting = False
      elseif _IsPressed("7D") Then
        $waiting = False
      elseif _IsPressed("7E") Then
        $waiting = False
      elseif _IsPressed("7F") Then
        $waiting = False
      elseif _IsPressed("80H") Then
        $waiting = False
      elseif _IsPressed("81H") Then
        $waiting = False
      elseif _IsPressed("82H") Then
        $waiting = False
      elseif _IsPressed("83H") Then
        $waiting = False
      elseif _IsPressed("84H") Then
        $waiting = False
      elseif _IsPressed("85H") Then
        $waiting = False
      elseif _IsPressed("86H") Then
        $waiting = False
      elseif _IsPressed("87H") Then
        $waiting = False
      elseif _IsPressed("90") Then
        $waiting = False
      elseif _IsPressed("91") Then
        $waiting = False
      elseif _IsPressed("A0") Then
        $waiting = False
      elseif _IsPressed("A1") Then
        $waiting = False
      elseif _IsPressed("A2") Then
        $waiting = False
      elseif _IsPressed("A3") Then
        $waiting = False
      elseif _IsPressed("A4") Then
        $waiting = False
      elseif _IsPressed("A5") Then
        $waiting = False
      elseif _IsPressed("BA") Then
        $waiting = False
      elseif _IsPressed("BB") Then
        $waiting = False
      elseif _IsPressed("BC") Then
        $waiting = False
      elseif _IsPressed("BD") Then
        $waiting = False
      elseif _IsPressed("BE") Then
        $waiting = False
      elseif _IsPressed("BF") Then
        $waiting = False
      elseif _IsPressed("C0") Then
        $waiting = False
      elseif _IsPressed("DB") Then
        $waiting = False
      elseif _IsPressed("DC") Then
        $waiting = False
      elseif _IsPressed("DD") Then
        $waiting = False
      EndIf
    WEnd
  elseif $data == "key" then
    While $waiting
      If _IsPressed("03") Then
        $waiting = False
      elseif _IsPressed("08") Then
        $waiting = False
      elseif _IsPressed("09") Then
        $waiting = False
      elseif _IsPressed("0C") Then
        $waiting = False
      elseif _IsPressed("0D") Then
        $waiting = False
      elseif _IsPressed("10") Then
        $waiting = False
      elseif _IsPressed("11") Then
        $waiting = False
      elseif _IsPressed("12") Then
        $waiting = False
      elseif _IsPressed("13") Then
        $waiting = False
      elseif _IsPressed("14") Then
        $waiting = False
      elseif _IsPressed("20") Then
        $waiting = False
      elseif _IsPressed("1B") Then
        $waiting = False
      elseif _IsPressed("21") Then
        $waiting = False
      elseif _IsPressed("22") Then
        $waiting = False
      elseif _IsPressed("23") Then
        $waiting = False
      elseif _IsPressed("24") Then
        $waiting = False
      elseif _IsPressed("25") Then
        $waiting = False
      elseif _IsPressed("26") Then
        $waiting = False
      elseif _IsPressed("27") Then
        $waiting = False
      elseif _IsPressed("28") Then
        $waiting = False
      elseif _IsPressed("29") Then
        $waiting = False
      elseif _IsPressed("2A") Then
        $waiting = False
      elseif _IsPressed("2B") Then
        $waiting = False
      elseif _IsPressed("2C") Then
        $waiting = False
      elseif _IsPressed("2D") Then
        $waiting = False
      elseif _IsPressed("2E") Then
        $waiting = False
      elseif _IsPressed("30") Then
        $waiting = False
      elseif _IsPressed("31") Then
        $waiting = False
      elseif _IsPressed("32") Then
        $waiting = False
      elseif _IsPressed("33") Then
        $waiting = False
      elseif _IsPressed("34") Then
        $waiting = False
      elseif _IsPressed("35") Then
        $waiting = False
      elseif _IsPressed("36") Then
        $waiting = False
      elseif _IsPressed("37") Then
        $waiting = False
      elseif _IsPressed("38") Then
        $waiting = False
      elseif _IsPressed("39") Then
        $waiting = False
      elseif _IsPressed("41") Then
        $waiting = False
      elseif _IsPressed("42") Then
        $waiting = False
      elseif _IsPressed("43") Then
        $waiting = False
      elseif _IsPressed("44") Then
        $waiting = False
      elseif _IsPressed("45") Then
        $waiting = False
      elseif _IsPressed("46") Then
        $waiting = False
      elseif _IsPressed("47") Then
        $waiting = False
      elseif _IsPressed("48") Then
        $waiting = False
      elseif _IsPressed("49") Then
        $waiting = False
      elseif _IsPressed("4A") Then
        $waiting = False
      elseif _IsPressed("4B") Then
        $waiting = False
      elseif _IsPressed("4C") Then
        $waiting = False
      elseif _IsPressed("4D") Then
        $waiting = False
      elseif _IsPressed("4E") Then
        $waiting = False
      elseif _IsPressed("4F") Then
        $waiting = False
      elseif _IsPressed("50") Then
        $waiting = False
      elseif _IsPressed("52") Then
        $waiting = False
      elseif _IsPressed("51") Then
        $waiting = False
      elseif _IsPressed("53") Then
        $waiting = False
      elseif _IsPressed("54") Then
        $waiting = False
      elseif _IsPressed("55") Then
        $waiting = False
      elseif _IsPressed("56") Then
        $waiting = False
      elseif _IsPressed("57") Then
        $waiting = False
      elseif _IsPressed("58") Then
        $waiting = False
      elseif _IsPressed("59") Then
        $waiting = False
      elseif _IsPressed("5A") Then
        $waiting = False
      elseif _IsPressed("5B") Then
        $waiting = False
      elseif _IsPressed("5C") Then
        $waiting = False
      elseif _IsPressed("60") Then
        $waiting = False
      elseif _IsPressed("61") Then
        $waiting = False
      elseif _IsPressed("62") Then
        $waiting = False
      elseif _IsPressed("63") Then
        $waiting = False
      elseif _IsPressed("64") Then
        $waiting = False
      elseif _IsPressed("65") Then
        $waiting = False
      elseif _IsPressed("66") Then
        $waiting = False
      elseif _IsPressed("67") Then
        $waiting = False
      elseif _IsPressed("68") Then
        $waiting = False
      elseif _IsPressed("69") Then
        $waiting = False
      elseif _IsPressed("6A") Then
        $waiting = False
      elseif _IsPressed("6B") Then
        $waiting = False
      elseif _IsPressed("6C") Then
        $waiting = False
      elseif _IsPressed("6D") Then
        $waiting = False
      elseif _IsPressed("6E") Then
        $waiting = False
      elseif _IsPressed("6F") Then
        $waiting = False
      elseif _IsPressed("70") Then
        $waiting = False
      elseif _IsPressed("71") Then
        $waiting = False
      elseif _IsPressed("72") Then
        $waiting = False
      elseif _IsPressed("73") Then
        $waiting = False
      elseif _IsPressed("74") Then
        $waiting = False
      elseif _IsPressed("75") Then
        $waiting = False
      elseif _IsPressed("76") Then
        $waiting = False
      elseif _IsPressed("77") Then
        $waiting = False
      elseif _IsPressed("78") Then
        $waiting = False
      elseif _IsPressed("79") Then
        $waiting = False
      elseif _IsPressed("7A") Then
        $waiting = False
      elseif _IsPressed("7B") Then
        $waiting = False
      elseif _IsPressed("7C") Then
        $waiting = False
      elseif _IsPressed("7D") Then
        $waiting = False
      elseif _IsPressed("7E") Then
        $waiting = False
      elseif _IsPressed("7F") Then
        $waiting = False
      elseif _IsPressed("80H") Then
        $waiting = False
      elseif _IsPressed("81H") Then
        $waiting = False
      elseif _IsPressed("82H") Then
        $waiting = False
      elseif _IsPressed("83H") Then
        $waiting = False
      elseif _IsPressed("84H") Then
        $waiting = False
      elseif _IsPressed("85H") Then
        $waiting = False
      elseif _IsPressed("86H") Then
        $waiting = False
      elseif _IsPressed("87H") Then
        $waiting = False
      elseif _IsPressed("90") Then
        $waiting = False
      elseif _IsPressed("91") Then
        $waiting = False
      elseif _IsPressed("A0") Then
        $waiting = False
      elseif _IsPressed("A1") Then
        $waiting = False
      elseif _IsPressed("A2") Then
        $waiting = False
      elseif _IsPressed("A3") Then
        $waiting = False
      elseif _IsPressed("A4") Then
        $waiting = False
      elseif _IsPressed("A5") Then
        $waiting = False
      elseif _IsPressed("BA") Then
        $waiting = False
      elseif _IsPressed("BB") Then
        $waiting = False
      elseif _IsPressed("BC") Then
        $waiting = False
      elseif _IsPressed("BD") Then
        $waiting = False
      elseif _IsPressed("BE") Then
        $waiting = False
      elseif _IsPressed("BF") Then
        $waiting = False
      elseif _IsPressed("C0") Then
        $waiting = False
      elseif _IsPressed("DB") Then
        $waiting = False
      elseif _IsPressed("DC") Then
        $waiting = False
      elseif _IsPressed("DD") Then
        $waiting = False
      EndIf
    WEnd
  elseif $data == "click" then
    While $waiting
      If _IsPressed("01") Then
        $waiting = False
      elseif _IsPressed("02") Then
        $waiting = False
      elseif _IsPressed("04") Then
        $waiting = False
      elseif _IsPressed("05") Then
        $waiting = False
      elseif _IsPressed("06") Then
        $waiting = False
      EndIf
    WEnd
  else
    While $waiting
      If _IsPressed($data) Then
        $waiting = False
      EndIf
    WEnd
  endif
EndFunc   ;==>Example
