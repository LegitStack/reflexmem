#include <ScreenCapture.au3>

; Animation from 0 to 21
Local $iAnimation = 0

; ATTENTION!
; This enables GDI acceleration. Disable this if the script does Not
; run as expected (i.e. too slow)
Local $bAndyMode = True

; m1, m2, k1, k2, z1, z2
Local $aAnimations[22][6] = [ _
	[2,2,128,128,1,1], _			; 0 - Melt (Good)
	[20,20,128,128,1,1], _			; 1 - Powder Blow
	[9,9,128,128,1,1], _			; 2 - Powder
	[0,0,128,128,1,1], _			; 3 - Evaporate
	[3,3,128,128,1,1], _			; 4 - Water Color
	[5,5,128,128,1,1], _			; 5 - Accumulate
	[10000,10000,128,128,1,1], _	; 6 - Checks
	[1000,1000,128,128,1,1], _		; 7 - Extreme Checks (Fast)
	[10,2,128,128,1,1], _			; 8 - Wind Blow (Good)
	[2,10,128,128,1,1], _			; 9 - Pour Down (Quite)
	[10,10,128,128,1,1], _			; 10 - Running
	[20,10,128,128,10,10], _		; 11 - Crazy Smoke (Good)
	[2,2,128,128,-100,2], _			; 12 - Super Fast Stream (Good)
	[2,2,100,10,1,1], _				; 13 - Moving Water (Good)
	[10,8,100,10,1,1], _			; 14 - Sort of Powder & Water
	[50,10,1,25,80,10], _			; 15 - Dissolve
	[2,10,12,1,5,10], _				; 16 - Blinds
	[1,1,1,1,-2,10], _				; 17 - Stars
	[5,5,8,4,-2,10], _				; 18 - Arrows (sort of.)
	[2,10,200,4,-2,10], _			; 19 - Fire
	[30,30,10,10,10,10], _			; 20 - Grained
	[25,25,25,255,250,25] _			; 21 - Shake
]

Global Const $hDwmApiDll = DllOpen("dwmapi.dll")
Global $sChkAero = DllStructCreate("int;")
DllCall($hDwmApiDll, "int", "DwmIsCompositionEnabled", "ptr", DllStructGetPtr($sChkAero))
Global $aero = DllStructGetData($sChkAero, 1)
If $aero Then DllCall($hDwmApiDll, "int", "DwmEnableComposition", "uint", False)
;Sleep(500)
Opt("GUIOnEventMode",1)
Local $c=b(0),$a=@DesktopWidth,$b=@DesktopHeight
_ScreenCapture_Capture("m.bmp",0,0,-1,-1,False)
$d = GUICreate(0,$a,$b,0,0,0x80000000)
GUISetOnEvent(-3,"a")
GUICtrlCreatePic("m.bmp",0,0,$a,$b)
$e=b($d)
GUISetState()

While 1;.
	$f=($a-$aAnimations[$iAnimation][2])*random(0,1)
	$g=($b-$aAnimations[$iAnimation][3])*random(0,1)
	$h = $aAnimations[$iAnimation][0]*random(0,1) - $aAnimations[$iAnimation][4]
	$i = $aAnimations[$iAnimation][1]*random(0,1) - $aAnimations[$iAnimation][5]
	If Not $bAndyMode Then
		DllCall("gdi32.dll","bool","BitBlt","handle",$e,"int",$f+$h,"int",$g+$i,"int",$aAnimations[$iAnimation][2],"int",$aAnimations[$iAnimation][3],"handle",$c,"int",$f,"int",$g,"dword",0x00CC0020);
	Else
		DllCall("gdi32.dll","bool","BitBlt","handle",$e,"int",int($f + $h), "int",int($g + $i),"int",128, "int",128,"handle",$e,"int",int($f),"int",int($g), "dword", 0x00CC0020) ;Andy's Variante
	EndIf
WEnd;

DllCall("user32.dll","int","ReleaseDC","hwnd",$d,"handle",$e)
DllCall("user32.dll","int","ReleaseDC","hwnd",0,"handle",$c)
Func a();
    If $aero Then DllCall($hDwmApiDll, "int", "DwmEnableComposition", "uint", True)
Exit;
EndFunc;.
Func b($j);
	$k=DllCall("user32.dll","handle","GetDC","hwnd",$j);
	Return $k[0];
EndFunc;.