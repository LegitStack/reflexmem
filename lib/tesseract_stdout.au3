#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         Jordan Miller

 Script Function:
	this is a library that helps you interact with tesseract through the cmd

 Requirements:
  Tesseract 3.04 installed on the machine

#ce ----------------------------------------------------------------------------


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
	Return _PathFull(GetScriptsPath("image"))
EndFunc

Func GetTesseractPath()
  Return _PathFull(@ScriptDir & "\tesseract")
EndFunc

;===============================================================================
;= Image =======================================================================
;===============================================================================

Func SaveScreen(ByRef $imagecount, $left = 0, $top = 0, $right = -1, $bottom = -1, $scrub = false, $shoulddelete = true)

  Local $i = 0
  While FileExists(GetImagePath() & $i & ".png")
    $i = $i + 1
  WEnd

  local $outimage = GetImagePath() & $i & ".png"
  Local $bmp =_ScreenCapture_Capture("", $left, $top, $right, $bottom)

  if $right = -1 then $right = @DesktopWidth
  if $bottom = -1 then $bottom = @DesktopHeight

  ;_SaveLocation($i, $left, $top, $right, $bottom) ;user knows location.

	;200,000px*20 = 4,000,000px ;4m/((r-l)*(b-t)) ;round(4,000,000/((1000-10)*(500-220))) == 14.4
	local $responsivescale = Round(4000000/(abs($right-$left)*abs($bottom-$top)))
	if $responsivescale < 2 then
		$responsivescale = 2
	elseif $responsivescale > 20 then
		$responsivescale = 20
	endif

  _ScaleImage($bmp, $outimage, abs($right - $left), abs($bottom - $top), $responsivescale)

  local $read = _GetOCR($outimage, $i, $scrub)
	$imagecount = $i
	if $shoulddelete then
		DeleteCache($i)
	endif
	return $read
	;if $addtoall then
	;	_AddToAnswers($i)
	;EndIf
EndFunc


Func _ScaleImage($bmp, $outimage, $w, $h, $scale) ;to make accuracy better.

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


Func _GetOCR($image, $i, $scrub)
  ;get environment variable, set it correctly if its not set:
  _ManageEnv()

  $tess = _PathFull(GetTesseractPath() & "\tesseract.exe ")
  $tess = $tess & $image & " "
	$tess = $tess & "stdout"
  Local $iPID = Run($tess, "", @SW_HIDE, $STDOUT_CHILD)
	ProcessWaitClose($iPID)
	local $read = StdoutRead($iPID)
	if $scrub then
		return _ScrubClean($read)
	else
		return $read
	endif

EndFunc

Func _ScrubClean($read)

	$read = StringReplace($read, "|", "")
	$read = StringStripWS($read, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)

	return $read

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
;= Delete ======================================================================
;===============================================================================

Func _DeleteImages($specificfilenumber = 0, $dorest = false)
	local $i = $specificfilenumber
	if $specificfilenumber == 0 then
  	FileDelete(GetImagePath() & "*")
	else
		if $dorest == false then
			While FileExists(GetImagePath() & $i & ".png")
				FileDelete(GetImagePath() & $i & ".png")
				$i = $i + 1
			WEnd
		else
			FileDelete(GetImagePath() & $specificfilenumber & ".png")
		endif
	endif
EndFunc


Func DeleteCache($startingat = 0)
  _DeleteImages($startingat)
EndFunc
