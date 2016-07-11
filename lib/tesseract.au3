#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         Jordan Miller

 Script Function:
	this is a library that helps you interact with tesseract through the cmd

 Requirements:
  Tesseract 3.04 installed on the machine

#ce ----------------------------------------------------------------------------
#include-once

;#include <File.au3>
#include <ScreenCapture.au3>
#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <StringConstants.au3>
;#include <FileConstants.au3>
;#include <MsgBoxConstants.au3>
;#include <Array.au3>
;#include <levenshtein.au3>
;===============================================================================
;= Constants ===================================================================
;===============================================================================

Func GetImagePath()
	Return _PathFull(@ScriptDir & "\image")
EndFunc


Func GetOutputPath()
	Return _PathFull(@ScriptDir & "\output") ;"\..\output"
EndFunc


Func GetLocationPath()
	Return _PathFull(@ScriptDir & "\location")
EndFunc


Func GetTesseractPath()
  Return _PathFull(@ScriptDir & "\tesseract")
EndFunc

;===============================================================================
;= Image =======================================================================
;===============================================================================

Func SaveScreen($left = 0, $top = 0, $right = -1, $bottom = -1, $addtoall = false)

  Local $i = 0
  While FileExists(GetImagePath() & "\" & $i & ".png")
    $i = $i + 1
  WEnd

  local $outimage = GetImagePath() & "\" & $i & ".png"
  Local $bmp =_ScreenCapture_Capture("", $left, $top, $right, $bottom)

  if $right = -1 then $right = @DesktopWidth
  if $bottom = -1 then $bottom = @DesktopHeight

  _SaveLocation($i, $left, $top, $right, $bottom)

  _ScaleImage($bmp, $outimage, ($right - $left), ($bottom - $top), 20)

  _GetOCR($outimage, $i)

	if $addtoall then
		_AddToAnswers($i)
	EndIf
EndFunc

Func _AddToAnswers($i)
	;wait for ocr to finish
	sleep(2000)
	;open outimage get information
	local $filepath = GetOutputPath() & "\" & $i & ".txt"
	local $file = FileOpen($filepath, $FO_READ)
	local $read = FileRead($file)
	FileClose($file)
	local $write = $read
	;delete files
	FileDelete(GetImagePath() & "\" & $i & ".png")
	FileDelete(GetOutputPath() & "\" & $i & ".txt")
	FileDelete(GetLocationPath() & "\" & $i & ".txt")
	;loop through all output
	$i = 1
	While FileExists(GetOutputPath() & "\" & $i & ".txt")
		$filepath = GetOutputPath() & "\" & $i & ".txt"
		$file = FileOpen($filepath, $FO_READ)
		$read = FileRead($file)
		FileClose($file)

		;add contents to that file.
		$read = $read & " " & $write
		$filepath = GetOutputPath() & "\" & $i & ".txt"
		$file = FileOpen($filepath, $FO_OVERWRITE)
		FileWrite($file, $read)
		FileClose($file)

		$i = $i + 1
	WEnd
EndFunc


Func _SaveLocation($name, $left = 0, $top = 0, $right = @DesktopWidth, $bottom = @DesktopHeight)
  local $file = GetLocationPath() & "\" & $name & ".txt"

  If Not FileWrite($file, $left & "," & $top & "," & $right & "," & $bottom & ",") Then
    MsgBox($MB_SYSTEMMODAL, $name, "couldn't write")
    Return False
  EndIf
EndFunc


Func _ScaleImage($bmp, $outimage, $w, $h, $scale)

  _GDIPlus_Startup()
  Local $gbmp = _GDIPlus_BitmapCreateFromHBITMAP($bmp)
  _WinAPI_DeleteObject($bmp)

  Local $gsbmp = _GDIPlus_ImageResize($gbmp, $w * $scale, $h * $scale)
  Local $ext = _GDIPlus_EncodersGetCLSID("PNG")
  _GDIPlus_ImageSaveToFileEx($gsbmp, $outimage, $ext)

  _GDIPlus_BitmapDispose($gbmp)
  _GDIPlus_BitmapDispose($gsbmp)
  _GDIPlus_Shutdown()

EndFunc


Func _GetOCR($image, $i)
  ;get environment variable, set it correctly if its not set:
  _ManageEnv()

  $tess = _PathFull(@ScriptDir & "\tesseract\tesseract.exe ")
  $tess = $tess & $image & " "
  $tess = $tess & GetOutputPath() & "\" & $i
  ;$tess = $tess & " -psm 4"
  Local $iPID = Run($tess, "", @SW_HIDE)
	_ScrubClean($i)
EndFunc

Func _ScrubClean($i = -1)
	local $filepath, $file, $read
	if $i = -1 Then
		local $i = 0
		While FileExists(GetOutputPath() & "\" & $i & ".txt")
			$filepath = GetOutputPath() & "\" & $i & ".txt"
			$file = FileOpen($filepath, $FO_READ)
			$read = FileRead($file)
			FileClose($file)

			$read = StringReplace($read, "|", "")
			$read = StringStripWS($read, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)

			$filepath = GetOutputPath() & "\" & $i & ".txt"
			$file = FileOpen($filepath, $FO_OVERWRITE)
			FileWrite($file, $read)
			FileClose($file)

			$i = $i + 1
		WEnd
	else
		$filepath = GetOutputPath() & "\" & $i & ".txt"
		$file = FileOpen($filepath, $FO_READ)
		$read = FileRead($file)
		FileClose($file)

		$read = StringReplace($read, "|", "")
		$read = StringStripWS($read, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)

		$filepath = GetOutputPath() & "\" & $i & ".txt"
		$file = FileOpen($filepath, $FO_OVERWRITE)
		FileWrite($file, $read)
		FileClose($file)
	endif
EndFunc


Func _ManageEnv()
  Local $envvar = EnvGet("TESSDATA_PREFIX")
  if $envvar <> GetTesseractPath() Then
    EnvSet("TESSDATA_PREFIX", GetTesseractPath())
  EndIf
EndFunc

Func _ManageEnvPermanent() ;not used
  Local $envvar = EnvGet("TESSDATA_PREFIX")
  ;MsgBox($MB_SYSTEMMODAL, "it is set to", "%TESSDATA_PREFIX%: " & @CRLF & @CRLF & $envvar)
  if $envvar <> GetTesseractPath() Then
    RegWrite("HKEY_CURRENT_USER\Environment", "TESSDATA_PREFIX", "REG_SZ", GetTesseractPath())
    EnvUpdate()
    Sleep(1000)
    EnvSet("TESSDATA_PREFIX", GetTesseractPath())
    Local $envvar = EnvGet("TESSDATA_PREFIX")
    ;MsgBox($MB_SYSTEMMODAL, "Had to set it", "%TESSDATA_PREFIX%: " & @CRLF & @CRLF & $envvar)
  EndIf
EndFunc


;===============================================================================
;= Answer ======================================================================
;===============================================================================


Func DetermineAnswer($answer, $surity = 1.00)

  Local $winner = 0
  Local $i = 1
  local $filepath
  local $file
  local $read
  local $score = 1000000
  local $lastscore = 1000000

  While FileExists(GetOutputPath() & "\" & $i & ".txt")
    ;read the contents
    $filepath = GetOutputPath() & "\" & $i & ".txt"
    $file = FileOpen($filepath, $FO_READ)
    $read = FileRead($file)
    FileClose($file)

    $lastscore = $score
    $score = GetLevenshteinDistance($answer, $read)

    if $score < $lastscore then
      $winner = $i
    endif

    $i = $i + 1
  WEnd
  ;send the number of that file to the PresentAnswer.
  PresentAnswer($winner, $surity)
EndFunc


Func PresentAnswer($name, $surity = 1.00)
  ;open the #text in location
  Local $filepath = GetLocationPath() & "\" & $name & ".txt"
  Local $file = FileOpen($filepath, $FO_READ)
  If $file = -1 Then
    if $name = 0 then
      Beep(300, 100)
    else
      PresentAnswer(0)
    endif
    Return False
  EndIf
  ;read the contents
  Local $read = FileRead($file)
  FileClose($file)
  ;split into an array or whatever
  Local $coords = StringSplit($read, ",")
  ;move cursor to the middle of that location
  local $x = ($coords[1]+$coords[3])/2
  local $y = ($coords[2]+$coords[4])/2
	local $dist = ($x - $coords[1])
	local $sx = ($dist * $surity) + $coords[1]
	MouseMove ($sx, $y, 1000)
EndFunc


;===============================================================================
;= Delete ======================================================================
;===============================================================================

Func _DeleteImages($startingat = 0)
	local $i = $startingat
	if $startingat == 0 then
  	FileDelete(GetImagePath() & "\*")
	else
		While FileExists(GetImagePath() & "\" & $i & ".png")
			FileDelete(GetImagePath() & "\" & $i & ".png")
			$i = $i + 1
		WEnd
	endif
EndFunc

Func _DeleteOutput($startingat = 0)
	local $i = $startingat
	if $startingat == 0 then
  	Local $iDelete = FileDelete(GetOutputPath() & "\*")
	else
		While FileExists(GetOutputPath() & "\" & $i & ".txt")
			FileDelete(GetOutputPath() & "\" & $i & ".txt")
			$i = $i + 1
		WEnd
	endif
EndFunc

Func _DeleteLocation($startingat = 0)
	local $i = $startingat
	if $startingat == 0 then
  	Local $iDelete = FileDelete(GetLocationPath() & "\*")
	else
		While FileExists(GetLocationPath() & "\" & $i & ".txt")
			FileDelete(GetLocationPath() & "\" & $i & ".txt")
			$i = $i + 1
		WEnd
	endif
EndFunc

Func DeleteCache($startingat = 0)
  _DeleteOutput($startingat)
  _DeleteLocation($startingat)
  _DeleteImages($startingat)
EndFunc


;===============================================================================
;= Detect ======================================================================
;===============================================================================

Func _GetPixelOfWords()
; calculate the where the answer is based upon $LEFT and $TOP
; (that should be the questions answers )
EndFunc


Func _DetectEmptySpaces()
EndFunc


Func _DetectTextLine()
EndFunc


Func _DetectQuestion()
EndFunc


Func _DetectAnswers()
EndFunc


Func _DetectIndividualAnswers()
EndFunc
