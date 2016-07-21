; #INDEX# =======================================================================================================================
; Title .........: AutoItObject v1.2.4.0
; AutoIt Version : 3.3
; Language ......: English (language independent)
; Description ...: Brings Objects to AutoIt.
; Author(s) .....: monoceres, trancexx, Kip, Prog@ndy
; Copyright .....: Copyright (C) The AutoItObject-Team. All rights reserved.
; License .......: Artistic License 2.0, see Artistic.txt
;
; This file is part of AutoItObject.
;
; AutoItObject is free software; you can redistribute it and/or modify
; it under the terms of the Artistic License as published by Larry Wall,
; either version 2.0, or (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
; See the Artistic License for more details.
;
; You should have received a copy of the Artistic License with this Kit,
; in the file named "Artistic.txt".  If not, you can get a copy from
; <http://www.perlfoundation.org/artistic_license_2_0> OR
; <http://www.opensource.org/licenses/artistic-license-2.0.php>
;
; ------------------------ AutoItObject CREDITS: ------------------------
; Copyright (C) by:
; The AutoItObject-Team:
; 	Andreas Karlsson (monoceres)
; 	Dragana R. (trancexx)
; 	Dave Bakker (Kip)
; 	Andreas Bosch (progandy, Prog@ndy)
;
; ===============================================================================================================================
#include-once
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6


; #CURRENT# =====================================================================================================================
;_AutoItObject_AddDestructor
;_AutoItObject_AddEnum
;_AutoItObject_AddMethod
;_AutoItObject_AddProperty
;_AutoItObject_Class
;_AutoItObject_CLSIDFromString
;_AutoItObject_CoCreateInstance
;_AutoItObject_Create
;_AutoItObject_DllOpen
;_AutoItObject_DllStructCreate
;_AutoItObject_IDispatchToPtr
;_AutoItObject_IUnknownAddRef
;_AutoItObject_IUnknownRelease
;_AutoItObject_ObjCreate
;_AutoItObject_ObjCreateEx
;_AutoItObject_ObjectFromDtag
;_AutoItObject_PtrToIDispatch
;_AutoItObject_RegisterObject
;_AutoItObject_RemoveMember
;_AutoItObject_Shutdown
;_AutoItObject_Startup
;_AutoItObject_UnregisterObject
;_AutoItObject_VariantClear
;_AutoItObject_VariantCopy
;_AutoItObject_VariantFree
;_AutoItObject_VariantInit
;_AutoItObject_VariantRead
;_AutoItObject_VariantSet
;_AutoItObject_WrapperAddMethod
;_AutoItObject_WrapperCreate
; ===============================================================================================================================

; #INTERNAL_NO_DOC# =============================================================================================================
;__Au3Obj_OleUninitialize
;__Au3Obj_IUnknown_AddRef
;__Au3Obj_IUnknown_Release
;__Au3Obj_GetMethods
;__Au3Obj_SafeArrayCreate
;__Au3Obj_SafeArrayDestroy
;__Au3Obj_SafeArrayAccessData
;__Au3Obj_SafeArrayUnaccessData
;__Au3Obj_SafeArrayGetUBound
;__Au3Obj_SafeArrayGetLBound
;__Au3Obj_SafeArrayGetDim
;__Au3Obj_CreateSafeArrayVariant
;__Au3Obj_ReadSafeArrayVariant
;__Au3Obj_CoTaskMemAlloc
;__Au3Obj_CoTaskMemFree
;__Au3Obj_CoTaskMemRealloc
;__Au3Obj_GlobalAlloc
;__Au3Obj_GlobalFree
;__Au3Obj_SysAllocString
;__Au3Obj_SysCopyString
;__Au3Obj_SysReAllocString
;__Au3Obj_SysFreeString
;__Au3Obj_SysStringLen
;__Au3Obj_SysReadString
;__Au3Obj_PtrStringLen
;__Au3Obj_PtrStringRead
;__Au3Obj_FunctionProxy
;__Au3Obj_EnumFunctionProxy
;__Au3Obj_ObjStructGetElements
;__Au3Obj_ObjStructMethod
;__Au3Obj_ObjStructDestructor
;__Au3Obj_ObjStructPointer
;__Au3Obj_PointerCall
;__Au3Obj_Mem_DllOpen
;__Au3Obj_Mem_FixReloc
;__Au3Obj_Mem_FixImports
;__Au3Obj_Mem_LoadLibraryEx
;__Au3Obj_Mem_FreeLibrary
;__Au3Obj_Mem_GetAddress
;__Au3Obj_Mem_VirtualProtect
;__Au3Obj_Mem_Base64Decode
;__Au3Obj_Mem_BinDll
;__Au3Obj_Mem_BinDll_X64
; ===============================================================================================================================

; #DATATYPES# =====================================================================================================================
; none - no value (only valid for return type, equivalent to void in C)
; byte - an unsigned 8 bit integer
; boolean - an unsigned 8 bit integer
; short - a 16 bit integer
; word, ushort - an unsigned 16 bit integer
; int, long - a 32 bit integer
; bool - a 32 bit integer
; dword, ulong, uint - an unsigned 32 bit integer
; hresult - an unsigned 32 bit integer
; int64 - a 64 bit integer
; uint64 - an unsigned 64 bit integer
; ptr - a general pointer (void *)
; hwnd - a window handle (pointer wide)
; handle - an handle (pointer wide)
; float - a single precision floating point number
; double - a double precision floating point number
; int_ptr, long_ptr, lresult, lparam - an integer big enough to hold a pointer when running on x86 or x64 versions of AutoIt
; uint_ptr, ulong_ptr, dword_ptr, wparam - an unsigned integer big enough to hold a pointer when running on x86 or x64 versions of AutoIt
; str - an ANSI string (a minimum of 65536 chars is allocated)
; wstr - a UNICODE wide character string (a minimum of 65536 chars is allocated)
; bstr - a composite data type that consists of a length prefix, a data string and a terminator
; variant - a tagged union that can be used to represent any other data type
; idispatch, object - a composite data type that represents object with IDispatch interface
; ===============================================================================================================================

;--------------------------------------------------------------------------------------------------------------------------------------
#region Variable definitions

Global Const $gh_AU3Obj_kernel32dll = DllOpen("kernel32.dll")
Global Const $gh_AU3Obj_oleautdll = DllOpen("oleaut32.dll")
Global Const $gh_AU3Obj_ole32dll = DllOpen("ole32.dll")

Global Const $__Au3Obj_X64 = @AutoItX64

Global Const $__Au3Obj_VT_EMPTY = 0
Global Const $__Au3Obj_VT_NULL = 1
Global Const $__Au3Obj_VT_I2 = 2
Global Const $__Au3Obj_VT_I4 = 3
Global Const $__Au3Obj_VT_R4 = 4
Global Const $__Au3Obj_VT_R8 = 5
Global Const $__Au3Obj_VT_CY = 6
Global Const $__Au3Obj_VT_DATE = 7
Global Const $__Au3Obj_VT_BSTR = 8
Global Const $__Au3Obj_VT_DISPATCH = 9
Global Const $__Au3Obj_VT_ERROR = 10
Global Const $__Au3Obj_VT_BOOL = 11
Global Const $__Au3Obj_VT_VARIANT = 12
Global Const $__Au3Obj_VT_UNKNOWN = 13
Global Const $__Au3Obj_VT_DECIMAL = 14
Global Const $__Au3Obj_VT_I1 = 16
Global Const $__Au3Obj_VT_UI1 = 17
Global Const $__Au3Obj_VT_UI2 = 18
Global Const $__Au3Obj_VT_UI4 = 19
Global Const $__Au3Obj_VT_I8 = 20
Global Const $__Au3Obj_VT_UI8 = 21
Global Const $__Au3Obj_VT_INT = 22
Global Const $__Au3Obj_VT_UINT = 23
Global Const $__Au3Obj_VT_VOID = 24
Global Const $__Au3Obj_VT_HRESULT = 25
Global Const $__Au3Obj_VT_PTR = 26
Global Const $__Au3Obj_VT_SAFEARRAY = 27
Global Const $__Au3Obj_VT_CARRAY = 28
Global Const $__Au3Obj_VT_USERDEFINED = 29
Global Const $__Au3Obj_VT_LPSTR = 30
Global Const $__Au3Obj_VT_LPWSTR = 31
Global Const $__Au3Obj_VT_RECORD = 36
Global Const $__Au3Obj_VT_INT_PTR = 37
Global Const $__Au3Obj_VT_UINT_PTR = 38
Global Const $__Au3Obj_VT_FILETIME = 64
Global Const $__Au3Obj_VT_BLOB = 65
Global Const $__Au3Obj_VT_STREAM = 66
Global Const $__Au3Obj_VT_STORAGE = 67
Global Const $__Au3Obj_VT_STREAMED_OBJECT = 68
Global Const $__Au3Obj_VT_STORED_OBJECT = 69
Global Const $__Au3Obj_VT_BLOB_OBJECT = 70
Global Const $__Au3Obj_VT_CF = 71
Global Const $__Au3Obj_VT_CLSID = 72
Global Const $__Au3Obj_VT_VERSIONED_STREAM = 73
Global Const $__Au3Obj_VT_BSTR_BLOB = 0xfff
Global Const $__Au3Obj_VT_VECTOR = 0x1000
Global Const $__Au3Obj_VT_ARRAY = 0x2000
Global Const $__Au3Obj_VT_BYREF = 0x4000
Global Const $__Au3Obj_VT_RESERVED = 0x8000
Global Const $__Au3Obj_VT_ILLEGAL = 0xffff
Global Const $__Au3Obj_VT_ILLEGALMASKED = 0xfff
Global Const $__Au3Obj_VT_TYPEMASK = 0xfff

Global Const $__Au3Obj_tagVARIANT = "word vt;word r1;word r2;word r3;ptr data; ptr"

Global Const $__Au3Obj_VARIANT_SIZE = DllStructGetSize(DllStructCreate($__Au3Obj_tagVARIANT, 1))
Global Const $__Au3Obj_PTR_SIZE = DllStructGetSize(DllStructCreate('ptr', 1))
Global Const $__Au3Obj_tagSAFEARRAYBOUND = "ulong cElements; long lLbound;"

Global $ghAutoItObjectDLL = -1, $giAutoItObjectDLLRef = 0

;===============================================================================
#interface "IUnknown"
Global Const $sIID_IUnknown = "{00000000-0000-0000-C000-000000000046}"
; Definition
Global $dtagIUnknown = "QueryInterface hresult(ptr;ptr*);" & _
		"AddRef dword();" & _
		"Release dword();"
; List
Global $ltagIUnknown = "QueryInterface;" & _
		"AddRef;" & _
		"Release;"
;===============================================================================
;===============================================================================
#interface "IDispatch"
Global Const $sIID_IDispatch = "{00020400-0000-0000-C000-000000000046}"
; Definition
Global $dtagIDispatch = $dtagIUnknown & _
		"GetTypeInfoCount hresult(dword*);" & _
		"GetTypeInfo hresult(dword;dword;ptr*);" & _
		"GetIDsOfNames hresult(ptr;ptr;dword;dword;ptr);" & _
		"Invoke hresult(dword;ptr;dword;word;ptr;ptr;ptr;ptr);"
; List
Global $ltagIDispatch = $ltagIUnknown & _
		"GetTypeInfoCount;" & _
		"GetTypeInfo;" & _
		"GetIDsOfNames;" & _
		"Invoke;"
;===============================================================================

#endregion Variable definitions
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#region Misc

DllCall($gh_AU3Obj_ole32dll, 'long', 'OleInitialize', 'ptr', 0)
OnAutoItExitRegister("__Au3Obj_OleUninitialize")
Func __Au3Obj_OleUninitialize()
	; Author: Prog@ndy
	DllCall($gh_AU3Obj_ole32dll, 'long', 'OleUninitialize')
	_AutoItObject_Shutdown(True)
EndFunc   ;==>__Au3Obj_OleUninitialize

Func __Au3Obj_IUnknown_AddRef($vObj)
	Local $sType = "ptr"
	If IsObj($vObj) Then $sType = "idispatch"
	Local $tVARIANT = DllStructCreate($__Au3Obj_tagVARIANT)
	; Actual call
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "DispCallFunc", _
			$sType, $vObj, _
			"dword", $__Au3Obj_PTR_SIZE, _ ; offset (4 for x86, 8 for x64)
			"dword", 4, _ ; CC_STDCALL
			"dword", $__Au3Obj_VT_UINT, _
			"dword", 0, _ ; number of function parameters
			"ptr", 0, _ ; parameters related
			"ptr", 0, _ ; parameters related
			"ptr", DllStructGetPtr($tVARIANT))
	If @error Or $aCall[0] Then Return SetError(1, 0, 0)
	; Collect returned
	Return DllStructGetData(DllStructCreate("dword", DllStructGetPtr($tVARIANT, "data")), 1)
EndFunc   ;==>__Au3Obj_IUnknown_AddRef

Func __Au3Obj_IUnknown_Release($vObj)
	Local $sType = "ptr"
	If IsObj($vObj) Then $sType = "idispatch"
	Local $tVARIANT = DllStructCreate($__Au3Obj_tagVARIANT)
	; Actual call
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "DispCallFunc", _
			$sType, $vObj, _
			"dword", 2 * $__Au3Obj_PTR_SIZE, _ ; offset (8 for x86, 16 for x64)
			"dword", 4, _ ; CC_STDCALL
			"dword", $__Au3Obj_VT_UINT, _
			"dword", 0, _ ; number of function parameters
			"ptr", 0, _ ; parameters related
			"ptr", 0, _ ; parameters related
			"ptr", DllStructGetPtr($tVARIANT))
	If @error Or $aCall[0] Then Return SetError(1, 0, 0)
	; Collect returned
	Return DllStructGetData(DllStructCreate("dword", DllStructGetPtr($tVARIANT, "data")), 1)
EndFunc   ;==>__Au3Obj_IUnknown_Release

Func __Au3Obj_GetMethods($tagInterface)
	Local $sMethods = StringReplace(StringRegExpReplace($tagInterface, "\h*(\w+)\h*(\w+\*?)\h*(\((.*?)\))\h*(;|;*\z)", "$1\|$2;$4" & @LF), ";" & @LF, @LF)
	If $sMethods = $tagInterface Then $sMethods = StringReplace(StringRegExpReplace($tagInterface, "\h*(\w+)\h*(;|;*\z)", "$1\|" & @LF), ";" & @LF, @LF)
	Return StringTrimRight($sMethods, 1)
EndFunc   ;==>__Au3Obj_GetMethods

Func __Au3Obj_ObjStructGetElements($sTag, ByRef $sAlign)
	Local $sAlignment = StringRegExpReplace($sTag, "\h*(align\h+\d+)\h*;.*", "$1")
	If $sAlignment <> $sTag Then
		$sAlign = $sAlignment
		$sTag = StringRegExpReplace($sTag, "\h*(align\h+\d+)\h*;", "")
	EndIf
	; Return StringRegExp($sTag, "\h*\w+\h*(\w+)\h*", 3) ; DO NOT REMOVE THIS LINE
	Return StringTrimRight(StringRegExpReplace($sTag, "\h*\w+\h*(\w+)\h*(\[\d+\])*\h*(;|;*\z)\h*", "$1;"), 1)
EndFunc   ;==>__Au3Obj_ObjStructGetElements

#endregion Misc
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#region SafeArray
Func __Au3Obj_SafeArrayCreate($vType, $cDims, $rgsabound)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "ptr", "SafeArrayCreate", "dword", $vType, "uint", $cDims, 'ptr', $rgsabound)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayCreate

Func __Au3Obj_SafeArrayDestroy($pSafeArray)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SafeArrayDestroy", "ptr", $pSafeArray)
	If @error Then Return SetError(1, 0, 1)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayDestroy

Func __Au3Obj_SafeArrayAccessData($pSafeArray, ByRef $pArrayData)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SafeArrayAccessData", "ptr", $pSafeArray, 'ptr*', 0)
	If @error Then Return SetError(1, 0, 1)
	$pArrayData = $aCall[2]
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayAccessData

Func __Au3Obj_SafeArrayUnaccessData($pSafeArray)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SafeArrayUnaccessData", "ptr", $pSafeArray)
	If @error Then Return SetError(1, 0, 1)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayUnaccessData

Func __Au3Obj_SafeArrayGetUBound($pSafeArray, $iDim, ByRef $iBound)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SafeArrayGetUBound", "ptr", $pSafeArray, 'uint', $iDim, 'long*', 0)
	If @error Then Return SetError(1, 0, 1)
	$iBound = $aCall[3]
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayGetUBound

Func __Au3Obj_SafeArrayGetLBound($pSafeArray, $iDim, ByRef $iBound)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SafeArrayGetLBound", "ptr", $pSafeArray, 'uint', $iDim, 'long*', 0)
	If @error Then Return SetError(1, 0, 1)
	$iBound = $aCall[3]
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SafeArrayGetLBound

Func __Au3Obj_SafeArrayGetDim($pSafeArray)
	Local $aResult = DllCall($gh_AU3Obj_oleautdll, "uint", "SafeArrayGetDim", "ptr", $pSafeArray)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>__Au3Obj_SafeArrayGetDim

Func __Au3Obj_CreateSafeArrayVariant(ByRef Const $aArray)
	; Author: Prog@ndy
	Local $iDim = UBound($aArray, 0), $pData, $pSafeArray, $bound, $subBound, $tBound
	Switch $iDim
		Case 1
			$bound = UBound($aArray) - 1
			$tBound = DllStructCreate($__Au3Obj_tagSAFEARRAYBOUND)
			DllStructSetData($tBound, 1, $bound + 1)
			$pSafeArray = __Au3Obj_SafeArrayCreate($__Au3Obj_VT_VARIANT, 1, DllStructGetPtr($tBound))
			If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
				For $i = 0 To $bound
					_AutoItObject_VariantInit($pData + $i * $__Au3Obj_VARIANT_SIZE)
					_AutoItObject_VariantSet($pData + $i * $__Au3Obj_VARIANT_SIZE, $aArray[$i])
				Next
				__Au3Obj_SafeArrayUnaccessData($pSafeArray)
			EndIf
			Return $pSafeArray
		Case 2
			$bound = UBound($aArray, 1) - 1
			$subBound = UBound($aArray, 2) - 1
			$tBound = DllStructCreate($__Au3Obj_tagSAFEARRAYBOUND & $__Au3Obj_tagSAFEARRAYBOUND)
			DllStructSetData($tBound, 3, $bound + 1)
			DllStructSetData($tBound, 1, $subBound + 1)
			$pSafeArray = __Au3Obj_SafeArrayCreate($__Au3Obj_VT_VARIANT, 2, DllStructGetPtr($tBound))
			If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
				For $i = 0 To $bound
					For $j = 0 To $subBound
						_AutoItObject_VariantInit($pData + ($j + $i * ($subBound + 1)) * $__Au3Obj_VARIANT_SIZE)
						_AutoItObject_VariantSet($pData + ($j + $i * ($subBound + 1)) * $__Au3Obj_VARIANT_SIZE, $aArray[$i][$j])
					Next
				Next
				__Au3Obj_SafeArrayUnaccessData($pSafeArray)
			EndIf
			Return $pSafeArray
		Case Else
			Return 0
	EndSwitch
EndFunc   ;==>__Au3Obj_CreateSafeArrayVariant

Func __Au3Obj_ReadSafeArrayVariant($pSafeArray)
	; Author: Prog@ndy
	Local $iDim = __Au3Obj_SafeArrayGetDim($pSafeArray), $pData, $lbound, $bound, $subBound
	Switch $iDim
		Case 1
			__Au3Obj_SafeArrayGetLBound($pSafeArray, 1, $lbound)
			__Au3Obj_SafeArrayGetUBound($pSafeArray, 1, $bound)
			$bound -= $lbound
			Local $array[$bound + 1]
			If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
				For $i = 0 To $bound
					$array[$i] = _AutoItObject_VariantRead($pData + $i * $__Au3Obj_VARIANT_SIZE)
				Next
				__Au3Obj_SafeArrayUnaccessData($pSafeArray)
			EndIf
			Return $array
		Case 2
			__Au3Obj_SafeArrayGetLBound($pSafeArray, 2, $lbound)
			__Au3Obj_SafeArrayGetUBound($pSafeArray, 2, $bound)
			$bound -= $lbound
			__Au3Obj_SafeArrayGetLBound($pSafeArray, 1, $lbound)
			__Au3Obj_SafeArrayGetUBound($pSafeArray, 1, $subBound)
			$subBound -= $lbound
			Local $array[$bound + 1][$subBound + 1]
			If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
				For $i = 0 To $bound
					For $j = 0 To $subBound
						$array[$i][$j] = _AutoItObject_VariantRead($pData + ($j + $i * ($subBound + 1)) * $__Au3Obj_VARIANT_SIZE)
					Next
				Next
				__Au3Obj_SafeArrayUnaccessData($pSafeArray)
			EndIf
			Return $array
		Case Else
			Return 0
	EndSwitch
EndFunc   ;==>__Au3Obj_ReadSafeArrayVariant

#endregion SafeArray
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#region Memory

Func __Au3Obj_CoTaskMemAlloc($iSize)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_ole32dll, "ptr", "CoTaskMemAlloc", "uint_ptr", $iSize)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_CoTaskMemAlloc

Func __Au3Obj_CoTaskMemFree($pCoMem)
	; Author: Prog@ndy
	DllCall($gh_AU3Obj_ole32dll, "none", "CoTaskMemFree", "ptr", $pCoMem)
	If @error Then Return SetError(1, 0, 0)
EndFunc   ;==>__Au3Obj_CoTaskMemFree

Func __Au3Obj_CoTaskMemRealloc($pCoMem, $iSize)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_ole32dll, "ptr", "CoTaskMemRealloc", 'ptr', $pCoMem, "uint_ptr", $iSize)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_CoTaskMemRealloc

Func __Au3Obj_GlobalAlloc($iSize, $iFlag)
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "ptr", "GlobalAlloc", "dword", $iFlag, "dword_ptr", $iSize)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_GlobalAlloc

Func __Au3Obj_GlobalFree($pPointer)
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "ptr", "GlobalFree", "ptr", $pPointer)
	If @error Or $aCall[0] Then Return SetError(1, 0, 0)
	Return 1
EndFunc   ;==>__Au3Obj_GlobalFree

#endregion Memory
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#region SysString

Func __Au3Obj_SysAllocString($str)
	; Author: monoceres
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "ptr", "SysAllocString", "wstr", $str)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SysAllocString
Func __Au3Obj_SysCopyString($pBSTR)
	; Author: Prog@ndy
	If Not $pBSTR Then Return SetError(2, 0, 0)
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "ptr", "SysAllocStringLen", "ptr", $pBSTR, "uint", __Au3Obj_SysStringLen($pBSTR))
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SysCopyString

Func __Au3Obj_SysReAllocString(ByRef $pBSTR, $str)
	; Author: Prog@ndy
	If Not $pBSTR Then Return SetError(2, 0, 0)
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "int", "SysReAllocString", 'ptr*', $pBSTR, "wstr", $str)
	If @error Then Return SetError(1, 0, 0)
	$pBSTR = $aCall[1]
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SysReAllocString

Func __Au3Obj_SysFreeString($pBSTR)
	; Author: Prog@ndy
	If Not $pBSTR Then Return SetError(2, 0, 0)
	DllCall($gh_AU3Obj_oleautdll, "none", "SysFreeString", "ptr", $pBSTR)
	If @error Then Return SetError(1, 0, 0)
EndFunc   ;==>__Au3Obj_SysFreeString

Func __Au3Obj_SysStringLen($pBSTR)
	; Author: Prog@ndy
	If Not $pBSTR Then Return SetError(2, 0, 0)
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "uint", "SysStringLen", "ptr", $pBSTR)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_SysStringLen

Func __Au3Obj_SysReadString($pBSTR, $iLen = -1)
	; Author: Prog@ndy
	If Not $pBSTR Then Return SetError(2, 0, '')
	If $iLen < 1 Then $iLen = __Au3Obj_SysStringLen($pBSTR)
	If $iLen < 1 Then Return SetError(1, 0, '')
	Return DllStructGetData(DllStructCreate("wchar[" & $iLen & "]", $pBSTR), 1)
EndFunc   ;==>__Au3Obj_SysReadString

Func __Au3Obj_PtrStringLen($pStr)
	; Author: Prog@ndy
	Local $aResult = DllCall($gh_AU3Obj_kernel32dll, 'int', 'lstrlenW', 'ptr', $pStr)
	If @error Then Return SetError(1, 0, 0)
	Return $aResult[0]
EndFunc   ;==>__Au3Obj_PtrStringLen

Func __Au3Obj_PtrStringRead($pStr, $iLen = -1)
	; Author: Prog@ndy
	If $iLen < 1 Then $iLen = __Au3Obj_PtrStringLen($pStr)
	If $iLen < 1 Then Return SetError(1, 0, '')
	Return DllStructGetData(DllStructCreate("wchar[" & $iLen & "]", $pStr), 1)
EndFunc   ;==>__Au3Obj_PtrStringRead

#endregion SysString
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#region Proxy Functions

Func __Au3Obj_FunctionProxy($FuncName, $oSelf) ; allows binary code to call autoit functions
	Local $arg = $oSelf.__params__ ; fetch params
	If IsArray($arg) Then
		Local $ret = Call($FuncName, $arg) ; Call
		If @error = 0xDEAD And @extended = 0xBEEF Then Return 0
		$oSelf.__error__ = @error ; set error
		$oSelf.__result__ = $ret ; set result
		Return 1
	EndIf
	; return error when params-array could not be created
EndFunc   ;==>__Au3Obj_FunctionProxy

Func __Au3Obj_EnumFunctionProxy($iAction, $FuncName, $oSelf, $pVarCurrent, $pVarResult)
	Local $Current, $ret
	Switch $iAction
		Case 0 ; Next
			$Current = $oSelf.__bridge__(Number($pVarCurrent))
			$ret = Execute($FuncName & "($oSelf, $Current)")
			If @error Then Return False
			$oSelf.__bridge__(Number($pVarCurrent)) = $Current
			$oSelf.__bridge__(Number($pVarResult)) = $ret
			Return 1
		Case 1 ;Skip
			Return False
		Case 2 ; Reset
			$Current = $oSelf.__bridge__(Number($pVarCurrent))
			$ret = Execute($FuncName & "($oSelf, $Current)")
			If @error Or Not $ret Then Return False
			$oSelf.__bridge__(Number($pVarCurrent)) = $Current
			Return True
	EndSwitch
EndFunc   ;==>__Au3Obj_EnumFunctionProxy

#endregion Proxy Functions
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#region Call Pointer

Func __Au3Obj_PointerCall($sRetType, $pAddress, $sType1 = "", $vParam1 = 0, $sType2 = "", $vParam2 = 0, $sType3 = "", $vParam3 = 0, $sType4 = "", $vParam4 = 0, $sType5 = "", $vParam5 = 0, $sType6 = "", $vParam6 = 0, $sType7 = "", $vParam7 = 0, $sType8 = "", $vParam8 = 0, $sType9 = "", $vParam9 = 0, $sType10 = "", $vParam10 = 0, $sType11 = "", $vParam11 = 0, $sType12 = "", $vParam12 = 0, $sType13 = "", $vParam13 = 0, $sType14 = "", $vParam14 = 0, $sType15 = "", $vParam15 = 0, $sType16 = "", $vParam16 = 0, $sType17 = "", $vParam17 = 0, $sType18 = "", $vParam18 = 0, $sType19 = "", $vParam19 = 0, $sType20 = "", $vParam20 = 0)
	; Author: Ward, Prog@ndy, trancexx
	Local Static $pHook, $hPseudo, $tPtr, $sFuncName = "MemoryCallEntry"
	If $pAddress Then
		If Not $pHook Then
			Local $sDll = "AutoItObject.dll"
			If $__Au3Obj_X64 Then $sDll = "AutoItObject_X64.dll"
			$hPseudo = DllOpen($sDll)
			If $hPseudo = -1 Then
				$sDll = "kernel32.dll"
				$sFuncName = "GlobalFix"
				$hPseudo = DllOpen($sDll)
			EndIf
			Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "ptr", "GetModuleHandleW", "wstr", $sDll)
			If @error Or Not $aCall[0] Then Return SetError(7, @error, 0) ; Couldn't get dll handle
			Local $hModuleHandle = $aCall[0]
			$aCall = DllCall($gh_AU3Obj_kernel32dll, "ptr", "GetProcAddress", "ptr", $hModuleHandle, "str", $sFuncName)
			If @error Then Return SetError(8, @error, 0) ; Wanted function not found
			$pHook = $aCall[0]
			$aCall = DllCall($gh_AU3Obj_kernel32dll, "bool", "VirtualProtect", "ptr", $pHook, "dword", 7 + 5 * $__Au3Obj_X64, "dword", 64, "dword*", 0)
			If @error Or Not $aCall[0] Then Return SetError(9, @error, 0) ; Unable to set MEM_EXECUTE_READWRITE
			If $__Au3Obj_X64 Then
				DllStructSetData(DllStructCreate("word", $pHook), 1, 0xB848)
				DllStructSetData(DllStructCreate("word", $pHook + 10), 1, 0xE0FF)
			Else
				DllStructSetData(DllStructCreate("byte", $pHook), 1, 0xB8)
				DllStructSetData(DllStructCreate("word", $pHook + 5), 1, 0xE0FF)
			EndIf
			$tPtr = DllStructCreate("ptr", $pHook + 1 + $__Au3Obj_X64)
		EndIf
		DllStructSetData($tPtr, 1, $pAddress)
		Local $aRet
		Switch @NumParams
			Case 2
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName)
			Case 4
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1)
			Case 6
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2)
			Case 8
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3)
			Case 10
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4)
			Case 12
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5)
			Case 14
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6)
			Case 16
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7)
			Case 18
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8)
			Case 20
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9)
			Case 22
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10)
			Case 24
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11)
			Case 26
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12)
			Case 28
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13)
			Case 30
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14)
			Case 32
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15)
			Case 34
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15, $sType16, $vParam16)
			Case 36
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15, $sType16, $vParam16, $sType17, $vParam17)
			Case 38
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15, $sType16, $vParam16, $sType17, $vParam17, $sType18, $vParam18)
			Case 40
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15, $sType16, $vParam16, $sType17, $vParam17, $sType18, $vParam18, $sType19, $vParam19)
			Case 42
				$aRet = DllCall($hPseudo, $sRetType, $sFuncName, $sType1, $vParam1, $sType2, $vParam2, $sType3, $vParam3, $sType4, $vParam4, $sType5, $vParam5, $sType6, $vParam6, $sType7, $vParam7, $sType8, $vParam8, $sType9, $vParam9, $sType10, $vParam10, $sType11, $vParam11, $sType12, $vParam12, $sType13, $vParam13, $sType14, $vParam14, $sType15, $vParam15, $sType16, $vParam16, $sType17, $vParam17, $sType18, $vParam18, $sType19, $vParam19, $sType20, $vParam20)
			Case Else
				If Mod(@NumParams, 2) Then Return SetError(4, 0, 0) ; Bad number of parameters
				Return SetError(5, 0, 0) ; Max number of parameters exceeded
		EndSwitch
		Return SetError(@error, @extended, $aRet) ; All went well. Error description and return values like with DllCall()
	EndIf
	Return SetError(6, 0, 0) ; Null address specified
EndFunc   ;==>__Au3Obj_PointerCall

#endregion Call Pointer
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#region Embedded DLL

Func __Au3Obj_Mem_DllOpen($bBinaryImage = 0, $sSubrogor = "cmd.exe")
	If Not $bBinaryImage Then
		If $__Au3Obj_X64 Then
			$bBinaryImage = __Au3Obj_Mem_BinDll_X64()
		Else
			$bBinaryImage = __Au3Obj_Mem_BinDll()
		EndIf
	EndIf
	; Make structure out of binary data that was passed
	Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinaryImage) & "]")
	DllStructSetData($tBinary, 1, $bBinaryImage) ; fill the structure
	; Get pointer to it
	Local $pPointer = DllStructGetPtr($tBinary)
	; Start processing passed binary data. 'Reading' PE format follows.
	Local $tIMAGE_DOS_HEADER = DllStructCreate("char Magic[2];" & _
			"word BytesOnLastPage;" & _
			"word Pages;" & _
			"word Relocations;" & _
			"word SizeofHeader;" & _
			"word MinimumExtra;" & _
			"word MaximumExtra;" & _
			"word SS;" & _
			"word SP;" & _
			"word Checksum;" & _
			"word IP;" & _
			"word CS;" & _
			"word Relocation;" & _
			"word Overlay;" & _
			"char Reserved[8];" & _
			"word OEMIdentifier;" & _
			"word OEMInformation;" & _
			"char Reserved2[20];" & _
			"dword AddressOfNewExeHeader", _
			$pPointer)
	; Move pointer
	$pPointer += DllStructGetData($tIMAGE_DOS_HEADER, "AddressOfNewExeHeader") ; move to PE file header
	$pPointer += 4 ; size of skipped $tIMAGE_NT_SIGNATURE structure
	; In place of IMAGE_FILE_HEADER structure
	Local $tIMAGE_FILE_HEADER = DllStructCreate("word Machine;" & _
			"word NumberOfSections;" & _
			"dword TimeDateStamp;" & _
			"dword PointerToSymbolTable;" & _
			"dword NumberOfSymbols;" & _
			"word SizeOfOptionalHeader;" & _
			"word Characteristics", _
			$pPointer)
	; Get number of sections
	Local $iNumberOfSections = DllStructGetData($tIMAGE_FILE_HEADER, "NumberOfSections")
	; Move pointer
	$pPointer += 20 ; size of $tIMAGE_FILE_HEADER structure
	; Determine the type
	Local $tMagic = DllStructCreate("word Magic;", $pPointer)
	Local $iMagic = DllStructGetData($tMagic, 1)
	Local $tIMAGE_OPTIONAL_HEADER
	If $iMagic = 267 Then ; x86 version
		If $__Au3Obj_X64 Then Return SetError(1, 0, -1) ; incompatible versions
		$tIMAGE_OPTIONAL_HEADER = DllStructCreate("word Magic;" & _
				"byte MajorLinkerVersion;" & _
				"byte MinorLinkerVersion;" & _
				"dword SizeOfCode;" & _
				"dword SizeOfInitializedData;" & _
				"dword SizeOfUninitializedData;" & _
				"dword AddressOfEntryPoint;" & _
				"dword BaseOfCode;" & _
				"dword BaseOfData;" & _
				"dword ImageBase;" & _
				"dword SectionAlignment;" & _
				"dword FileAlignment;" & _
				"word MajorOperatingSystemVersion;" & _
				"word MinorOperatingSystemVersion;" & _
				"word MajorImageVersion;" & _
				"word MinorImageVersion;" & _
				"word MajorSubsystemVersion;" & _
				"word MinorSubsystemVersion;" & _
				"dword Win32VersionValue;" & _
				"dword SizeOfImage;" & _
				"dword SizeOfHeaders;" & _
				"dword CheckSum;" & _
				"word Subsystem;" & _
				"word DllCharacteristics;" & _
				"dword SizeOfStackReserve;" & _
				"dword SizeOfStackCommit;" & _
				"dword SizeOfHeapReserve;" & _
				"dword SizeOfHeapCommit;" & _
				"dword LoaderFlags;" & _
				"dword NumberOfRvaAndSizes", _
				$pPointer)
		; Move pointer
		$pPointer += 96 ; size of $tIMAGE_OPTIONAL_HEADER
	ElseIf $iMagic = 523 Then ; x64 version
		If Not $__Au3Obj_X64 Then Return SetError(1, 0, -1) ; incompatible versions
		$tIMAGE_OPTIONAL_HEADER = DllStructCreate("word Magic;" & _
				"byte MajorLinkerVersion;" & _
				"byte MinorLinkerVersion;" & _
				"dword SizeOfCode;" & _
				"dword SizeOfInitializedData;" & _
				"dword SizeOfUninitializedData;" & _
				"dword AddressOfEntryPoint;" & _
				"dword BaseOfCode;" & _
				"uint64 ImageBase;" & _
				"dword SectionAlignment;" & _
				"dword FileAlignment;" & _
				"word MajorOperatingSystemVersion;" & _
				"word MinorOperatingSystemVersion;" & _
				"word MajorImageVersion;" & _
				"word MinorImageVersion;" & _
				"word MajorSubsystemVersion;" & _
				"word MinorSubsystemVersion;" & _
				"dword Win32VersionValue;" & _
				"dword SizeOfImage;" & _
				"dword SizeOfHeaders;" & _
				"dword CheckSum;" & _
				"word Subsystem;" & _
				"word DllCharacteristics;" & _
				"uint64 SizeOfStackReserve;" & _
				"uint64 SizeOfStackCommit;" & _
				"uint64 SizeOfHeapReserve;" & _
				"uint64 SizeOfHeapCommit;" & _
				"dword LoaderFlags;" & _
				"dword NumberOfRvaAndSizes", _
				$pPointer)
		; Move pointer
		$pPointer += 112 ; size of $tIMAGE_OPTIONAL_HEADER
	Else
		Return SetError(1, 0, -1) ; incompatible versions
	EndIf
	; Extract data
	Local $iEntryPoint = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "AddressOfEntryPoint") ; if loaded binary image would start executing at this address
	Local $pOptionalHeaderImageBase = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "ImageBase") ; address of the first byte of the image when it's loaded in memory
	$pPointer += 8 ; skipping IMAGE_DIRECTORY_ENTRY_EXPORT
	; Import Directory
	Local $tIMAGE_DIRECTORY_ENTRY_IMPORT = DllStructCreate("dword VirtualAddress; dword Size", $pPointer)
	; Collect data
	Local $pAddressImport = DllStructGetData($tIMAGE_DIRECTORY_ENTRY_IMPORT, "VirtualAddress")
;~ 	Local $iSizeImport = DllStructGetData($tIMAGE_DIRECTORY_ENTRY_IMPORT, "Size")
	$pPointer += 8 ; size of $tIMAGE_DIRECTORY_ENTRY_IMPORT
	$pPointer += 24 ; skipping IMAGE_DIRECTORY_ENTRY_RESOURCE, IMAGE_DIRECTORY_ENTRY_EXCEPTION, IMAGE_DIRECTORY_ENTRY_SECURITY
	; Base Relocation Directory
	Local $tIMAGE_DIRECTORY_ENTRY_BASERELOC = DllStructCreate("dword VirtualAddress; dword Size", $pPointer)
	; Collect data
	Local $pAddressNewBaseReloc = DllStructGetData($tIMAGE_DIRECTORY_ENTRY_BASERELOC, "VirtualAddress")
	Local $iSizeBaseReloc = DllStructGetData($tIMAGE_DIRECTORY_ENTRY_BASERELOC, "Size")
	$pPointer += 8 ; size of IMAGE_DIRECTORY_ENTRY_BASERELOC
	$pPointer += 40 ; skipping IMAGE_DIRECTORY_ENTRY_DEBUG, IMAGE_DIRECTORY_ENTRY_COPYRIGHT, IMAGE_DIRECTORY_ENTRY_GLOBALPTR, IMAGE_DIRECTORY_ENTRY_TLS, IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG
	$pPointer += 40 ; five more generally unused data directories
	; Load the victim
	Local $pBaseAddress = __Au3Obj_Mem_LoadLibraryEx($sSubrogor, 1) ; "lighter" loading, DONT_RESOLVE_DLL_REFERENCES
	If @error Then Return SetError(2, 0, -1) ; Couldn't load subrogor
	Local $pHeadersNew = DllStructGetPtr($tIMAGE_DOS_HEADER) ; starting address of binary image headers
	Local $iOptionalHeaderSizeOfHeaders = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "SizeOfHeaders") ; the size of the MS-DOS stub, the PE header, and the section headers
	; Set proper memory protection for writting headers (PAGE_READWRITE)
	If Not __Au3Obj_Mem_VirtualProtect($pBaseAddress, $iOptionalHeaderSizeOfHeaders, 4) Then Return SetError(3, 0, -1) ; Couldn't set proper protection for headers
	; Write NEW headers
	DllStructSetData(DllStructCreate("byte[" & $iOptionalHeaderSizeOfHeaders & "]", $pBaseAddress), 1, DllStructGetData(DllStructCreate("byte[" & $iOptionalHeaderSizeOfHeaders & "]", $pHeadersNew), 1))
	; Dealing with sections. Will write them.
	Local $tIMAGE_SECTION_HEADER
	Local $iSizeOfRawData, $pPointerToRawData
	Local $iVirtualSize, $iVirtualAddress
	Local $pRelocRaw
	For $i = 1 To $iNumberOfSections
		$tIMAGE_SECTION_HEADER = DllStructCreate("char Name[8];" & _
				"dword UnionOfVirtualSizeAndPhysicalAddress;" & _
				"dword VirtualAddress;" & _
				"dword SizeOfRawData;" & _
				"dword PointerToRawData;" & _
				"dword PointerToRelocations;" & _
				"dword PointerToLinenumbers;" & _
				"word NumberOfRelocations;" & _
				"word NumberOfLinenumbers;" & _
				"dword Characteristics", _
				$pPointer)
		; Collect data
		$iSizeOfRawData = DllStructGetData($tIMAGE_SECTION_HEADER, "SizeOfRawData")
		$pPointerToRawData = $pHeadersNew + DllStructGetData($tIMAGE_SECTION_HEADER, "PointerToRawData")
		$iVirtualAddress = DllStructGetData($tIMAGE_SECTION_HEADER, "VirtualAddress")
		$iVirtualSize = DllStructGetData($tIMAGE_SECTION_HEADER, "UnionOfVirtualSizeAndPhysicalAddress")
		If $iVirtualSize And $iVirtualSize < $iSizeOfRawData Then $iSizeOfRawData = $iVirtualSize
		; Set MEM_EXECUTE_READWRITE for sections (PAGE_EXECUTE_READWRITE for all for simplicity)
		If Not __Au3Obj_Mem_VirtualProtect($pBaseAddress + $iVirtualAddress, $iVirtualSize, 64) Then
			$pPointer += 40 ; size of $tIMAGE_SECTION_HEADER structure
			ContinueLoop
		EndIf
		; Clean the space
		DllStructSetData(DllStructCreate("byte[" & $iVirtualSize & "]", $pBaseAddress + $iVirtualAddress), 1, DllStructGetData(DllStructCreate("byte[" & $iVirtualSize & "]"), 1))
		; If there is data to write, write it
		If $iSizeOfRawData Then DllStructSetData(DllStructCreate("byte[" & $iSizeOfRawData & "]", $pBaseAddress + $iVirtualAddress), 1, DllStructGetData(DllStructCreate("byte[" & $iSizeOfRawData & "]", $pPointerToRawData), 1))
		; Relocations
		If $iVirtualAddress <= $pAddressNewBaseReloc And $iVirtualAddress + $iSizeOfRawData > $pAddressNewBaseReloc Then $pRelocRaw = $pPointerToRawData + ($pAddressNewBaseReloc - $iVirtualAddress)
		; Imports
		If $iVirtualAddress <= $pAddressImport And $iVirtualAddress + $iSizeOfRawData > $pAddressImport Then __Au3Obj_Mem_FixImports($pPointerToRawData + ($pAddressImport - $iVirtualAddress), $pBaseAddress) ; fix imports in place
		; Move pointer
		$pPointer += 40 ; size of $tIMAGE_SECTION_HEADER structure
	Next
	; Fix relocations
	If $pAddressNewBaseReloc And $iSizeBaseReloc Then __Au3Obj_Mem_FixReloc($pRelocRaw, $iSizeBaseReloc, $pBaseAddress, $pOptionalHeaderImageBase, $iMagic = 523)
	; Entry point address
	Local $pEntryFunc = $pBaseAddress + $iEntryPoint
	; DllMain simulation
	__Au3Obj_PointerCall("bool", $pEntryFunc, "ptr", $pBaseAddress, "dword", 1, "ptr", 0) ; DLL_PROCESS_ATTACH
	; Get pseudo-handle
	Local $hPseudo = DllOpen($sSubrogor)
	__Au3Obj_Mem_FreeLibrary($pBaseAddress) ; decrement reference count
	Return $hPseudo
EndFunc   ;==>__Au3Obj_Mem_DllOpen

Func __Au3Obj_Mem_FixReloc($pData, $iSize, $pAddressNew, $pAddressOld, $fImageX64)
	Local $iDelta = $pAddressNew - $pAddressOld ; dislocation value
	Local $tIMAGE_BASE_RELOCATION, $iRelativeMove
	Local $iVirtualAddress, $iSizeofBlock, $iNumberOfEntries
	Local $tEnries, $iData, $tAddress
	Local $iFlag = 3 + 7 * $fImageX64 ; IMAGE_REL_BASED_HIGHLOW = 3 or IMAGE_REL_BASED_DIR64 = 10
	While $iRelativeMove < $iSize ; for all data available
		$tIMAGE_BASE_RELOCATION = DllStructCreate("dword VirtualAddress; dword SizeOfBlock", $pData + $iRelativeMove)
		$iVirtualAddress = DllStructGetData($tIMAGE_BASE_RELOCATION, "VirtualAddress")
		$iSizeofBlock = DllStructGetData($tIMAGE_BASE_RELOCATION, "SizeOfBlock")
		$iNumberOfEntries = ($iSizeofBlock - 8) / 2
		$tEnries = DllStructCreate("word[" & $iNumberOfEntries & "]", DllStructGetPtr($tIMAGE_BASE_RELOCATION) + 8)
		; Go through all entries
		For $i = 1 To $iNumberOfEntries
			$iData = DllStructGetData($tEnries, 1, $i)
			If BitShift($iData, 12) = $iFlag Then ; check type
				$tAddress = DllStructCreate("ptr", $pAddressNew + $iVirtualAddress + BitAND($iData, 0xFFF)) ; the rest of $iData is offset
				DllStructSetData($tAddress, 1, DllStructGetData($tAddress, 1) + $iDelta) ; this is what's this all about
			EndIf
		Next
		$iRelativeMove += $iSizeofBlock
	WEnd
	Return 1 ; all OK!
EndFunc   ;==>__Au3Obj_Mem_FixReloc

Func __Au3Obj_Mem_FixImports($pImportDirectory, $hInstance)
	Local $hModule, $tFuncName, $sFuncName, $pFuncAddress
	Local $tIMAGE_IMPORT_MODULE_DIRECTORY, $tModuleName
	Local $tBufferOffset2, $iBufferOffset2
	Local $iInitialOffset, $iInitialOffset2, $iOffset
	While 1
		$tIMAGE_IMPORT_MODULE_DIRECTORY = DllStructCreate("dword RVAOriginalFirstThunk;" & _
				"dword TimeDateStamp;" & _
				"dword ForwarderChain;" & _
				"dword RVAModuleName;" & _
				"dword RVAFirstThunk", _
				$pImportDirectory)
		If Not DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAFirstThunk") Then ExitLoop ; the end
		$tModuleName = DllStructCreate("char Name[64]", $hInstance + DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAModuleName"))
		$hModule = __Au3Obj_Mem_LoadLibraryEx(DllStructGetData($tModuleName, "Name")) ; load the module, full load
		$iInitialOffset = $hInstance + DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAFirstThunk")
		$iInitialOffset2 = $hInstance + DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAOriginalFirstThunk")
		If $iInitialOffset2 = $hInstance Then $iInitialOffset2 = $iInitialOffset
		$iOffset = 0 ; back to 0
		While 1
			$tBufferOffset2 = DllStructCreate("ptr", $iInitialOffset2 + $iOffset)
			$iBufferOffset2 = DllStructGetData($tBufferOffset2, 1) ; value at that address
			If Not $iBufferOffset2 Then ExitLoop ; zero value is the end
			If BitShift(BinaryMid($iBufferOffset2, $__Au3Obj_PTR_SIZE, 1), 7) Then ; MSB is set for imports by ordinal, otherwise not
				$pFuncAddress = __Au3Obj_Mem_GetAddress($hModule, BitAND($iBufferOffset2, 0xFFFFFF)) ; the rest is ordinal value
			Else
				$tFuncName = DllStructCreate("word Ordinal; char Name[64]", $hInstance + $iBufferOffset2)
				$sFuncName = DllStructGetData($tFuncName, "Name")
				$pFuncAddress = __Au3Obj_Mem_GetAddress($hModule, $sFuncName)
			EndIf
			DllStructSetData(DllStructCreate("ptr", $iInitialOffset + $iOffset), 1, $pFuncAddress) ; and this is what's this all about
			$iOffset += $__Au3Obj_PTR_SIZE ; size of $tBufferOffset2
		WEnd
		$pImportDirectory += 20 ; size of $tIMAGE_IMPORT_MODULE_DIRECTORY
	WEnd
	Return 1 ; all OK!
EndFunc   ;==>__Au3Obj_Mem_FixImports

Func __Au3Obj_Mem_Base64Decode($sData) ; Ward
	Local $bOpcode
	If $__Au3Obj_X64 Then
		$bOpcode = Binary("0x4156415541544D89CC555756534C89C34883EC20410FB64104418800418B3183FE010F84AB00000073434863D24D89C54889CE488D3C114839FE0F84A50100000FB62E4883C601E8B501000083ED2B4080FD5077E2480FBEED0FB6042884C00FBED078D3C1E20241885500EB7383FE020F841C01000031C083FE03740F4883C4205B5E5F5D415C415D415EC34863D24D89C54889CE488D3C114839FE0F84CA0000000FB62E4883C601E85301000083ED2B4080FD5077E2480FBEED0FB6042884C078D683E03F410845004983C501E964FFFFFF4863D24D89C54889CE488D3C114839FE0F84E00000000FB62E4883C601E80C01000083ED2B4080FD5077E2480FBEED0FB6042884C00FBED078D389D04D8D7501C1E20483E03041885501C1F804410845004839FE747B0FB62E4883C601E8CC00000083ED2B4080FD5077E6480FBEED0FB6042884C00FBED078D789D0C1E2064D8D6E0183E03C41885601C1F8024108064839FE0F8536FFFFFF41C7042403000000410FB6450041884424044489E84883C42029D85B5E5F5D415C415D415EC34863D24889CE4D89C6488D3C114839FE758541C7042402000000410FB60641884424044489F04883C42029D85B5E5F5D415C415D415EC341C7042401000000410FB6450041884424044489E829D8E998FEFFFF41C7042400000000410FB6450041884424044489E829D8E97CFEFFFFE8500000003EFFFFFF3F3435363738393A3B3C3DFFFFFFFEFFFFFF000102030405060708090A0B0C0D0E0F10111213141516171819FFFFFFFFFFFF1A1B1C1D1E1F202122232425262728292A2B2C2D2E2F3031323358C3")
	Else
		$bOpcode = Binary("0x5557565383EC1C8B6C243C8B5424388B5C24308B7424340FB6450488028B550083FA010F84A1000000733F8B5424388D34338954240C39F30F848B0100000FB63B83C301E8890100008D57D580FA5077E50FBED20FB6041084C00FBED078D78B44240CC1E2028810EB6B83FA020F841201000031C083FA03740A83C41C5B5E5F5DC210008B4C24388D3433894C240C39F30F84CD0000000FB63B83C301E8300100008D57D580FA5077E50FBED20FB6041084C078DA8B54240C83E03F080283C2018954240CE96CFFFFFF8B4424388D34338944240C39F30F84D00000000FB63B83C301E8EA0000008D57D580FA5077E50FBED20FB6141084D20FBEC278D78B4C240C89C283E230C1FA04C1E004081189CF83C70188410139F374750FB60383C3018844240CE8A80000000FB654240C83EA2B80FA5077E00FBED20FB6141084D20FBEC278D289C283E23CC1FA02C1E006081739F38D57018954240C8847010F8533FFFFFFC74500030000008B4C240C0FB60188450489C82B44243883C41C5B5E5F5DC210008D34338B7C243839F3758BC74500020000000FB60788450489F82B44243883C41C5B5E5F5DC210008B54240CC74500010000000FB60288450489D02B442438E9B1FEFFFFC7450000000000EB99E8500000003EFFFFFF3F3435363738393A3B3C3DFFFFFFFEFFFFFF000102030405060708090A0B0C0D0E0F10111213141516171819FFFFFFFFFFFF1A1B1C1D1E1F202122232425262728292A2B2C2D2E2F3031323358C3")
	EndIf
	Local $tCodeBuffer = DllStructCreate("byte[" & BinaryLen($bOpcode) & "]")
	DllStructSetData($tCodeBuffer, 1, $bOpcode)
	__Au3Obj_Mem_VirtualProtect(DllStructGetPtr($tCodeBuffer), DllStructGetSize($tCodeBuffer), 64)
	If @error Then Return SetError(1, 0, "")
	Local $iLen = StringLen($sData)
	Local $tOut = DllStructCreate("byte[" & $iLen & "]")
	Local $tState = DllStructCreate("byte[16]")
	Local $Call = __Au3Obj_PointerCall("int", DllStructGetPtr($tCodeBuffer), "str", $sData, "dword", $iLen, "ptr", DllStructGetPtr($tOut), "ptr", DllStructGetPtr($tState))
	If @error Then Return SetError(2, 0, "")
	Return BinaryMid(DllStructGetData($tOut, 1), 1, $Call[0])
EndFunc   ;==>__Au3Obj_Mem_Base64Decode

Func __Au3Obj_Mem_LoadLibraryEx($sModule, $iFlag = 0)
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "handle", "LoadLibraryExW", "wstr", $sModule, "handle", 0, "dword", $iFlag)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_Mem_LoadLibraryEx

Func __Au3Obj_Mem_FreeLibrary($hModule)
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "bool", "FreeLibrary", "handle", $hModule)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return 1
EndFunc   ;==>__Au3Obj_Mem_FreeLibrary

Func __Au3Obj_Mem_GetAddress($hModule, $vFuncName)
	Local $sType = "str"
	If IsNumber($vFuncName) Then $sType = "int" ; if ordinal value passed
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "ptr", "GetProcAddress", "handle", $hModule, $sType, $vFuncName)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>__Au3Obj_Mem_GetAddress

Func __Au3Obj_Mem_VirtualProtect($pAddress, $iSize, $iProtection)
	Local $aCall = DllCall($gh_AU3Obj_kernel32dll, "bool", "VirtualProtect", "ptr", $pAddress, "dword_ptr", $iSize, "dword", $iProtection, "dword*", 0)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return 1
EndFunc   ;==>__Au3Obj_Mem_VirtualProtect

Func __Au3Obj_Mem_BinDll()
    Local $sData = "TVpAAAEAAAACAAAA//8AALgAAAAAAAAACgAAAAAAAAAOH7oOALQJzSG4AUzNIVdpbjMyIC5ETEwuDQokQAAAAFBFAABMAQMAOtOhTQAAAAAAAAAA4AACIwsBCgAAPAAAABgAAAAAAABbkwAAABAAAABQAAAAAAAQABAAAAACAAAFAAEAAAAAAAUAAQAAAAAAALAAAAACAAAAAAAAAgAABQAAEAAAEAAAAAAQAAAQAAAAAAAAEAAAAACQAABUAgAAVJIAAAgBAAAAoAAAcAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALiSAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAALk1QUkVTUzEAgAAAABAAAAAqAAAAAgAAAAAAAAAAAAAAAAAA4AAA4C5NUFJFU1MyFgYAAACQAAAACAAAACwAAAAAAAAAAAAAAAAAAOAAAOAucnNyYwAAAHADAAAAoAAAAAQAAAA0AAAAAAAAAAAAAAAAAABAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAdjIuMTcIADApAABVAIvs/3UIagj/ABVYUAAQUP8VSlQM0DXMQgAsBgXIUoPsIIPk8NkAwNlUJBjffCQCEN9sJBCLFrAIQEQCUQhMx+MNkF4oneeRzUECsMhAEhgPAAAAABgY/P///zcIAg3ABBSD0gDraCw65DLYLqMNsI5EARH3wipRh5sNwUWCYRDJw1aLAPGDJgCDZhgAFI1GCBUAhBUAi8ZIXi6xaEAOB1DoQBPOkDVojGD1D1KBqANew4sBwwGNQQjDi0EYZxAAi0UIiUEYXcIFBACLQRwgxgESgBhgdbWY33iHIGA26ANAdyBIaiAIWP8AZokG/xVBvByQeATx5cVF" & _
            "gC4wGIwQ9V8BGQ8DhFUBbAT/FQQ+ADCTrCYApHUvDvAAGXyfvYAcRYDO6P//zxOJBriTAABXEIRUAjAKAAacHIEJjUYYUMcGCExRABAdMItGCECL9QBRCINmCABAXoMgTQiLQQRAGIlBBH70ImC1WAfAcDWTPANslgjSRG8A5GoEWY0AffAz0olF8McARfYAAMAAiUUA+mbHRf4ARvMAp8dF4AQEAgAUx0XmMKMOA+4AGEZ0G4oAJ+Az0gDzp3QMi00QiQABuAJAAIDrEOBJABySAUIwA/zlhZEszJASYxONSBgBUf9wCP9wDHMTgJsQi00UiQEzyQCFwA+UwYvBXSTCENVAagBWRqEGFGA199gbwEBdI8IIRA8AoSZApOdBgskBTgSLRgT24CyA/hgAAGC1HzMjBpwauDdhRgCwGZMI+BhEsFjEkGjEALNYJAJxABSJRhTm5RG3Y1FwowQnIt7DUHQVE/DLZPUqAFwToIQxFfPLA1IHTVF1AgiLBlb/UMwAoZII0xTR1RQzFTVhRIJxVTW72FM18X8dmDX+xf//v9ixNBHKFIlDENOLRhx6isXg9gEnbkATiUYcs2ICIqbSL1C/LyYdAUYgYvDltRUG9AVCANCIFLDjhGBnFJg7oEbQSAQgQJdAunSwiD8DnJUDYERg57DosMgAEJjIcAi0Y0TAICf/b4MuhJDVCMAEIJDok+iEAPRFBFUIiRSB/zxGBE8ixuBEiJBogJFoRNAkkEzyn0QAnEygBTvQcwiLCQKLBIGJBJFkMQV4ZhA/839swCMFAACR4wdh57EIuCnAgVu4TeewSLGMfmsJU90wRzsBfhBy4o1eDCyA8kdQAdDzWdFohCIA9X/daISkIDjwCrAikBSYHLtoB1J4Zl9zoDH/Mw6TFBBhAlKFkTkwyI4xtQigPBgeYHX1UAgkzAP2wgIPhbmAEMLwQDgiAAAA0sO3IlDXtljHITHoh4ADFgcxITMA24M4/Q+UwzMAwIXbD5XAi/gAiwbB5wQDxw8A" & _
            "twiD+RV0GYMA+RR0FIP5GnQAG4P5E3QWg/kAA3QR6UgGAAAFahNqAFBlBLBlFEA2fEIJHAxOMABgDPVP54OQboZpBD165hEEgDCIR4AA8EAoagKDwAA4i00c/zFQ6xFtPXk88FBYWFcwSmR/RIK0vv0Fs06Q+AUR8FDoGYsGLUBjHi0QNwAadCAtEDcAAAN0FrgFAAKAFOmVDDfABocWdSCSYTkzwEDSs4cbXelRBbigDgm40Fi0RUBgB/NfweoEhcAydTlNAA8KaCDHAmZyiUkHExomkBiUgMAhoJaAZZYYlGfAoZEIh7FdgyeoSDBoYIxitc6YD5NsgKBYDgCVPvYRgUcSEpDZYJIF2RBY6+E9QHcw4bLYhzD4NwoTeTCwWAeysVexIXNHcgDTQ5DO1hSBX8Ffx1QIgkEGRmQB0QdyRUYNWGooA2aJB+ib+LMFmQMAE/92IIvI/3YBHP92GFbo1yEDA+sCM8CJRyFIoBIws70z/MDY30QBuHLgB3G0c/zQCOTOEX4MizyHiQB9CGY7yw+FR9p48DviAyG/A8pG8QyDvv49QA0JOV4IFA+EtiajbQJIDyGEX8cCSA+FobayxPG5MIgPCIE4YARC1gyQywACsLDAMWCWg/BQmKEFaxIrFaSbEfj7AgcisEWBlLxFoDawqTADvCVSmBxGkNgEckZmRrCDQbcw1UKbUxQE8kLWSHSDADUmIEoroECQzqoQezCgtJUtUFjaEg7SEtJoDAQtgQJ1fx1RTgiRL7J4LHUQg+ACiRAGhAXhBoPAEFnxAoX/ge0BA8CLRMYIdgsAykNAQHP/vfE/SHDuP3gsUCWQWBRAP+DfWAR/FR7QAJIeh5BtkLOS0k7Q8m8THLBSNlBf8i+HABjP6NMZEpIAkmhEAuwJkN0Ci1gIg2XsAACNQwKJReiNAEXoUGoBagz/IBWcRgHRxBAFlQhShF+vNlW47WcksjhcJXBcRJ8zAACQ2MW/2EWfWISpCxADw64JFQUAsNh0gNFIhAAfGAA2"
    $sData &= "nRwAg20YEIPDEP8DTfx1z/91WQBdGwCLXmCLRfjHRkZgyQEA6TkdDYF3cL2BN4BZAiVIrRQpOGtQEV19lC5gWFq3iI/bWiFglnPwUCgRfXHHGn0JEH1h0GeQVS+AMIiA8183EslnluihbmARNg/QAIFptBAGXTR12U4JwBSUTBBrUZLgCVCoESqaEfoFguHXdIsGNYs9+RBFQQdFMdeRZ7BAZpMqkHWwaIeRGFBHP+j/X3fSGResRxGlEYN98AJW0ReeRUrpki0KrQGtB0RlOkwEAQR0CrgOxVHeFbBZGpJOrkMQyc0DBRQV+DFX/BX4CvgV+CL4FRhZABVoCPyDZmAxEolGMIAFJ2oDZolGKFhcVhSAFShSTiI/EYleB2CNXkhTZQNhBVkwgUEyU//X/04I7QCBTSb9//1/BQOZAxjrBbgYoccAycIk7H4d5OoAlg4BYukAvhPBgGsYOAKFvnUj0gB2BPFA6Okg4IPI/54ds3gcs27vSyG4EY/OWU4hgD24/+83kgBwVbDIg1n4b/oAz6YPAnTl4zBTjU4M6Jb+fgNgLyFmHxZcEQtCCxkg8JA9B3QzWGU2iOMHQFeyeMQwtcgBB6sP8QBgEDnBALu1HrSQEtD4xICOkQgSaSEhM9vuEnC12NNQAegiMYleBIleCIkMXgyJXiwglQEoUACJXhiJXhyJXg0giV4kthFlHlFYFECgBoJ+I++IADvDA3QLi8jon1UtbgiQ8j9VHOBNA2oCIND0DgJoaAobwAI/mQhOV8obYNFQEmCrAR4SEgUXlRNPo8AApgGQ8wVhp9RXFtAZXxbDUBaUGFCEsD6Q2IXQNRLAv8iAmNiEbxAgr5UDULUhi0BgBiBA4UYQ/0BRuQEkGRJA0bcCFC0SxI0WNTL/RfxpCTtHAhByg4tHGN0ADgD/dyCLzv93HApQ6GcDtULJcTZRRVEGIPdQaCksED29GREAdH0NDYNl/I0DAX4QQE/HRfj6AnAEoJUBdE5TmhhRj1RuIVCH0+iFMtX1" & _
            "0xhThF/S2LVlljjAPENWVbtPdbRbLhnVYnOdtNGz8JUiIJt44CJyvUGDtQEQ/zZogA0G3WqK1iTBcQzgHgH/0iKCYamUAGiUhLpAKC4WsZ7FDQescB/gUhHrv3BQRgz3ARIUsS4KB9hwH1DpfxHrhXAAD6cOcJLoShHpxQ+aC4HGEIPAz9fKFMFHNRxxLHYWEDAohe+UAS1JArgG1gNxDEwILS1qIIv56Exo7zoUk6oGn6pgrxbgXj1Qf+GREs6VJ1E3eTcMryTAzwRW8QrRKj4lFQWUcu8eBT8gEAU02Bd1wKeQBlOUEQQTCZsGO5gHwABwHMAwBQChU5dgIBLuLaLdYgjaLYBwHvCheyK4gBvAEeIqUmkUhdU7H8CZNJD+JdFDYoXG9wGbfIjHp7E1mpV8sC4HB4xwH5AJF1VVcEAK9wGYcIEDB1XAcB9wCRcbcAANp18NcGJZlqJkACkWgSkRIwAMg/mcdRD2RQQYAnUQuDYOwkwxqKIBRRgB6+6OK1BFAGLEILMRdA+D+Zuq+gsAgRjKiHAFHi6XaQA5WIYOkJz3ocxxRh8hdlDjIMUBx0YMjhICnMwMCQB1QWUIOVnIoGSJBTvDVQVGVUVqCmjo+OySAZOQb4BH32Ag1iF85C8ADBVAmnUAYYt9HIt3CIMA/gJ0CYP+Aw8ghUgBEQeLzgPJADPSZoN8yPAIAo1O/g+VwjywDWA2yIOM8FA5bLAw/VD4wgnKGeAPMFCXYJaDhEAHMKAmkLVoHTVQIP1PB43OAPhiNAGARLDeN5ifWZfkpNMQSAimHkCIXo9BkD/wcPhdlQGxKBE8AJwJIAwfIsANiCYBdgSLXMLoIDP/lFAnsKi/COBEcDX1TyeMH4F+D5Evhln3kgTQbiwCShXgKRCL7gGRAJDJEhJOBFNSAYDGHl8hqsp8l7GSBeURX6HyEHUcSrnwHQCdMokAdTqMHQJRi9ad0i4Fso50MJhvWXdUFuQ+A44TQbPOExeDAwg40bJYgIdwhUZfhnrgiSIn" & _
            "6xKtEujX1Q+BKM4PRNfl/EBqBpKBgFDdIhUBLXfTWjeCYAUEDABqaCPHBqkd6PDqGT8d9wOAxkCxGDyIBPE/A5CciJCIRJCIZEoBDBZBYkSgEZQaQCAR8W/HQCP/dghU45RFD0EEHjgDzLI/j/DlHRRhbiMEtj9pAAAhEBIzlAPkkwsvsNiFMJNsVpCz8EAYW2kxHEUAsFP3YDaIJwBAQDdwtF6QYZAIgRDUSLAEBgB14QSFyXQBRw4jQDhISQuNQco9oCZpQ4k+ky0x0+ktAVNQ1jtQEqNJCARa8iRQGxdLGItETtY4gJCIwAEzwAEz/2Y5AXQ2oBHixJB5ELBTZ9F7AJHIEcADjUQBAgCLTgiJBAqDwkIEPHDUSPDDCAgGAHXS6wPCRqBRQYs5QRDGRaZLdCo9XEfSa3CQYwRDV+FhA71FICCtGhRxBzt+BLJOo9vDdXke0BTzAF3WPbdubFcg4z4GI1gwTj+VGEQTEpRQAdOH4A8A+RWNdEf+gBJIoFKnMwN8pcYpfxToes0pEkPgHwNqKokSMIH7/687EgF0EgIQqSgAQ4kiHQBxDCDsAJCRBesbzRUPdBKLRcdZBTp0E4EFT4ElwIYp0DMCAdBI89TIYCSABhec4K8xM9sqWUNZGwXZERh2ITAo4eev0g9Ql+LSAf6UCfEARv4NYaoaQ4GxnmWYGq6TGtZ5kBMQ6kCwKJxueiHSMDP2gNECDDl1CH4P/yA0t70oRlk7dQg6fPEmHCO6ABxEwUEYoxzEwSGDxBRVFCoHEhMVpT0hIgzxX4GuEiII+ItV/IoV1VjEbwOF5gAVhIRrJTISBFCkxK9OAusRVEKbk7ITgLwBfI99j81eQN0+SVD0DxUV1Q3F4V0DYORToFj0X7KOgAboKlkAyc4Mk4o6/KgFjDoGZioY0Mr6DsSsn4GcEIT6EcyoBJWNCglokN3FkO1SxMD6BNBZ8Am6EBBgEQFAp7IYfDXYxwCsIQE5CCx1EGou64DCUoDjUmegxvIVYJaII9RI"
    $sData &= "EBWKAqL9ZdBEUTPAOEVjEMJJIVQ0xwZ8yQj5DsXGS6C7BIlGNFo2cKWpAWCNykehgUIIi10MgyBlCLIbgPFgW0RBMVhGgQI4KIAxdZBoxJPY1f4gKiBGURDAn1iF0Ugw5QMkEHx1DuEKiQiNREBTTiqAsE42mK8QQFdgVphcp6UJAIZFCQjoVOVuBSMCEilAFSIgAbFOMFgGcShTIU0Q6GtMYFMRKDBFiyIUKBFqkZNiZhKA2iSxWITxX0TRSEVkvhIM4kUg1BCwU8XA/2A4pxkBbh9EAbDvhlS9EtYoYu0hckjWkwcgh6R4W3kQbkhRMqMSEYN+MGgAWgCnkQA0vgbyX8EQCyc4cKDxA/8VGIZWAe9eQEJIoHcgzihxB7GuYaw4Aq4qAot+VgzgqpJOrwYp8OeqgsauKuKaQrAikwEiiht6M/Ff16CNguteJz0G8O4k4ZpiNYKuKebFthVxEMFjFc5iwALXGa6CRfFf00rdxKi3ASobgdeBAQAgHFLwneKLXb7ZSv8f3PS/Ap68CP8fjPDfwEr/DIBljhP0Z+4DiVUK/N9t+BnwB/gZoHyJGUDdRfgZ8AszwFYu8IHTxZDhkNvQ4CTlsgkOwU4KUdwCcZXohVPaECizASBqFOjf4WIb9x3NITQRUDFc3X7lK8JXZtWlcA8VCVZdLr0QEP83aGoo0hRhA8LcRiiBJcUkPBwAdDzlHE064haxeBCQaAS0rvN/UwYw36ehe1JKF+AHEusiGhCgjwWTvLJOjel02SpdIxEygt5V0MQQyM6UIjBIIB5gVWegExJ0KCWB+QkRdSD2TjhhsxCZcgIBhCEyAAZSEPYiPCWAaQQ5WDx1CTvLAHwQO0gQfQtmKTvTViKk4JMh6WCgQQDFsEih2BCwmASAMKCQWMW9GA0SKO7zAYCJTeB5AwVKg8r+Qrgg+COAuPEPhNAY9J8ZsCK8CH8V7e9RISSLxiYVUwctSjFI4Af//4lF7AYVwzZgU/UCJgxgD2ABJvRgoAQBtv3fYEEO" & _
            "9gDkgGCwWAeeWITdCGLkrwcCxBSJfczIvkAg1xKO/xZLsFiEDhIWUiGQV4A0iEzgD/RA2A0VTdwBOTl1Yot16PIfoXEwYC9kAbIhsc4G/zB08K4NZEYUB4tE8MCKRKBbA+SL88HmBBiNPAYaFFCDMVCHjR1O4IMw3EoJUD5RhE5HAoPUNBCNb+kUAesQK+iwiQaLyIvGHytF6Fzi9gX6S2AYBH4IARgIsG66mDAA3MhAFAwPVQMgDRSLTWLwyQ0WQtBIhORZAThFKpTwUDihdRBNehQAKlwRARYTslgFn5UloKaS9XALbBYBV0ZXWQBmiQriSVQc0KTA3gAAZGYTBIhgAKllAvgIJlFgNtjHHwCQ2AT/QOgv5hUATfxmg/kRdTcBagHomd7//7JHYAKQFQJA16DYAZoFcQHEkZjwoBahBmAF3ReQBqEobgRN/IgBEen8JHI4kb9QJ74BOuhc8Ol6APBimeqQnhIpouYDC/z38KuVBcBQwQ4CdSJqAuhQIOHwApLhEDhqAutEJpwgUZfDCfjdopwfQMUZEGoSgXBm1BZx0SWQmBg2kQlAgB6Vi/8C0PhxozaRCUI00DFAgB7J+QINHbodIwOZcJUwkXAMkQAQLuhU8JBVaJN2oQkA/IhdRun4JZxC8UDYRprFQAIV8lpAMgThIFUY4fACSuEwBOFw2eEACkX82RjhUAXwgFCBvs0N/wGR8FMAf1Hd8NINbx51YF0HxyIyUamxrqLmIwespSIAIBOLISBqAVaJdUD8hgayfnBcxI8jbDQAmgYQAIBOlg2QBbXYlQDlbRABAFZqqFIBwO8/FRTNgh91U6CV8CE8lTACAOj+246CKMK/CA8NViYRBoWQUqcUBlEQALBeUgU8BlEFlgRT4AsUBMAHg25jUkTdWEStJRZqIEDAg5mukdIDovEQQ3hbyhC5UVJXkUUARlgOkEVVx6FGsV70whYmdUJsgMZGjmiQRVeRTKSnEF0niQNRBOtJahXBhxJQQcavjCJaLbDeEgKR" & _
            "8GBTeNcLEG+wEQNgVQIJvaEgEXFYCRKuJhTkwNAbAJDIk7nYRJ9IIJGZHpIcgEbklqBj0wUAmfQfTDFml9ox9gp2aJCg5rF+RgRoUNWgV3PV8CJccWYh1RBxlqEQeh/6AWAeEKo7klhwFy6AObBYRJ9IgxkuUhGxBVYRWlQRUnJfwYYOhQCZwmtCkNUIEAiQXpW0AOpiQEWmf8DfyINFd0CghrD+4GUAdgYhWgAHD7cEwVAOKQMN5gQAkpUrmSI7wQ+E1ab6TGBmAAiE9iARE/AAUrhsniMIiU38gwj4C3Upog30cHuAL1wAfVHlEq4DJK0CCOkUg3UCg/gRdSi0r6BVEEaIsFZQ54H4AO0e3VteiEWA+AJuAJGNaH5tEOeqEwCYD5CkkY6PwkhsiowbLHGHBIoIYDX4gD9Q55dx0x4vQANhEgEIikX86Q8nORBxEso9YF8WehuRHm6CFFATghTBHzJHUIewrQoHVbxSADMyMFIhKCcE+BQPhfmRFEUj/JmJQQUPhdpSISoANN1dPmiQEX9Q4ZQBUVHOfQJ2KYAunSjRFES2/ddkkRYjQLYpKQjRYWRaVUUW6zUgBGQLSBaqLTIDZMvKfBVVExQ4dSR4ILkiojlhxbCORhEjL9C2QRO2MUiCCeiuBuBDM///TegAg33o/w+PAfeAbhPQxJ3YB35cFIJeVEOQk0NHZhQxLDBWXQprTimhsQF17IDqWFCH/V9H/l/HQD+FvlIs4BQEuCdXgKoW8KVqAb4k4Z8irBFMyn4Y8I+EsGhMOlgEehpB7VkmshMwYLwYAIf/cAsEb9W8E967EbzjrhY7wXVJLnxBqHYWjUXgUD5M4ozOdqNfA80NIPZR0gv5XwcGXQySE7J+mNMHLkDHcFzEUeEoAethA+zgQwAcHnQHGEHwUefwcGvMB0XMyICh+hNFvBIflOPHQ0BHdXWFpqITjYVQtFKHAGUpAHZAM9twV2IW4CkQVPRvR/MfUoHAAzvHdTEx8QhYL5UTlXEEpQSLXhgg"
    $sData &= "6J0qLhAMLrBYdwDd2MQbxQ3UYGcGBRz/dehQBl2AZ8IlAQGJRbSNRbQeXVKR2IcrtVYYanSBLrU2Eotd5GkMhSaZAYkBfdw79w+ONDJJMDJj7/YCjUQGqpqhjjGk7jPAbRUASKmuFvFAKEXlDgA1KHKLjApRjaxxBQVlEABiF2Zm2wc+hAuc4CIDIQuOe+G6BPgCEA+UwgvKTj7AhDCDoJigDQKITBYMGOlbLS4CIR8AGos2RDOqReDTBJWGkyDRBmYDiUQOGOlhfNPgIMgXZosA6+Q4IPFCF08BEwaCAAXKbQKbEQN06BTAUHdDJ4BsUET9cAsA1WjA5ABxFSWcCZ0x1NNOTVARkFgRsAjUjpAAgcWRAEWRBkR4BOvcqlxQkQZCQDfZIjSRrcJlEA5WwDXdXNG9yIUedXBEoOZlA7EjwQVBpHB1pfYPZcYRC+T/FRDmSqSVGyAQgiZj0/YJQp1YoKC7EOTFGRis8V8HrnJYGCwwHjAhiDLVUB91IdXwAMptQGwPAtiRnruCKQh1VQ8VpOuSDoDvGQH8hp0wSAIldRdqA1FHFWAR6Q4s7GJSR6CmAWjhJCAKASQSV1GFoXaUoJ4ATBYQnRaukdA/I9gJQafQSDAjdkOLMUXYfo3BIuklLqkLhQkBD7dI+MYXQVYBQYOQFTdRAgPQON/wI23ZOO+xjiN9ERyhMJEg/+zOi0BKFSMX5gKQrvBPI4ZYtKfJEf9F3A4OYRwAsVME/cDorIwWYnUGOhC7cV/EUbZBhwTTAKBWYe4AAYtFUMQskGnaGEUYiVAYDOkLZiphKoBT6fyMYhfSx+xh8QjYgIClni2DHtUi1NWiHNWCSVvR1SIcXhIQLUEdLWWQQbU1AFbhAL1CLo0QH5UMyI0gGpBRRxwsF4Sw/tegICApEmZ54iMgdRVeAKCrR0Z9EQLojXc6L6CgB0d3KFpuZHYKWSNP0qiVJyG5B+p1IiICqAwDWzY1QAICQMiKM6AiAonQKkJzsIgskk4vywUzwMMSYTCn" & _
            "T4XyWEEFljEABlpghDCwiNyVLuBAFiapJ4NuIR8A5QDoghEJWX9Z7kVkLySlBE0RUl7iI0oFNf7OW0L6AlZdQWpcqAIWXKTmgISu/NwTo54CPRDIvRUR2D4jIXcDVUCUQEpJXBeUQUEZKRCsIaFxzVpFIFaeOHAHS/5s4YkT7/5so8k2YkZDQQIyRkQChkbBmBdghT5sZwOypTXIDgRjoBc5XQx1EFdovpJWoaAKpQDwtV7RrLEQ+RAVDMJEoG8QhG4SUSk2BEXQei/B70tB20YKcookAKBDiIwEOGAFE4j+AvDgiMsDagRoSZieGqBGIJsIaABqMlFTgcEnMomAmQCCoJQQTgQJIHUcCj9hphhIgMCPJGoO4E4EZkcitQPOSMAA4NBYhS9ldQF2hcEVGPiWRSAWAogijhMgsjNfBwStNxUIjVX0Uo0CVeBSUP8RfQC8AIt19DldEHVVyeUSmmGw3ppPUOJs3jMqn1PGRoDcV1MZEMBxHRCg1gh19QkQKOCaGG0THWoBU90Sng3QN0SW5yCzWGdBAy0A2c0tIA8khE9QMDUVpwCxKIJs1WGS3hfjdCWDJOw8Klswsw0HFfSDMg/RBfFQKJ4y0FHURt1Roc8FjXEOvYSp4nPxGkdYHEdDGkdvoHgZLQcBAarpBjC2EsFufhnxzgzgC+lFIugtrQFWi/joSSUcoEakqQjoGyTBqJUC+OgRJNBFgT9IRGzMRY1F5FkHCImhqR48SiLDhPb/p5wlpCUCOPUeNTQUgAbLmBRw9W8NCxSARv5MM5o6sE5jqwINAJ61kIY0QlihLCfptTVCUWIGIIvyJIFGQAUdFTkQJgCwhh9CAABXfALDBMoCAOwcMLpblZWV04VAF0bnbAG+cVCAi7vQNiCgMCOddR/vPwiJAF0Yi/g7+3Y6gq0Y/zb/FSwJAIEnfQgGkFFX0jiT3lE5RlGXoaagAygiBoKRU9CHIWc8hR0kQIFgs9gDwhHX/3ZWBIaQ0FXvgJ8QYl5EWSDpszECOF0Y" & _
            "dQ3SdpWgjxT4uLCegCIcxJETKQEPhAfhAmgg2JUyfhYybFkGylKTLjUjWEvQRB+FxtVz0YRAHPUPHUsQPmOvWwUhVLihaAs5EGQZNS/olQjtA3IUgAY0BWoCFF7rGVTGVg0Bfw/gvWE/aO4/aIwq2gD0XRvwXQvUUlOgtQsMOgBQtzNPN6bYwdJYhVG7ECXlCnUASU5OdAVOdBzKOmdgcwVwFPIMoGGIC1HGHKB5Af8VcJYNQvYCdP6aFuPDGj0d1ktQ2BYPABLpLFs0dngw77sEaJ7TJS4OArES3k8Avy6UxSBYpZzYw1LEAR/ZxUEGWmhkJBHLIj8g8LksiynYV8pVoCLiAYvDfpMiaqIkVhEIEDP2qpLxT1IBlFPjX2fXC+s/oDEAGzEQOXUMdRIKO8Z0JGIbEBD0RvFLBBI8EGUhYgBJPtpIYEgAoY0gxp6DNsgOYRVZcV0J4SVAdIEQd15RAQ9UYK4mMAoGkC61/m0HEGQAP15gQhZyAoOwvg0JEgLR34ngxwn6UeEAA9EVeR3w5VPQtNRCZyx6GffQI0V89EIMIBk25SeJD01RMsA+6x7AUjMBDZEH/FZIZ68wBWJT1brQ6mYIdTAIgX0M7/EPdSdWB2r1/xVMmjPRMJDF0aAmgkZTo1AggGQHMX9EAnUjGFzKb2MKfJUwPEdCuY4RwQARjQJCAokuoAUsgH4RgIBAV6CmgMVsbhwpBGhY0QD6NPZASMRtJwBWaGRQWXdQoBaR3qfDFXCwW8UKK4BQewkljAXAVQIFQJiwawYrqFBLFQUltFDbXfiBBqwMtb4LgsYMtbNQgl0KtfnyBoFGDrXkUFLFnhrMkBrEz8UUXKSCUMW1FVyEwcUEqlxEwsUFXETDxROqXETExR5cxMTFH6pchMXFCFxExpV0CKBWaGxA+miFRsQHlA+EekoEYIVWhQi1wDUkmFC7CiVjrFAraxhWaLxQ62wb1oUFUBsRCgIOtSYjYbWCRg+151CCoGEAUAglDSUYUEmHYYWGxQKk"
    $sData &= "B0J4or0ECesKAGoD6wZqEusCAWoLWF5dw3vquwCwVCTlVMQ0IwPgQsbGBsA2R0cgNwaXdwUibGUAblcAR2V0UHIAb2NBZGRyZXMAcwBGcmVlTGkAYnJhcnkATXUAbHRpQnl0ZVQAb1dpZGVDaGEkcgAgRfVGZwBDAG9tcGFyZVN0AHJpbmdXAExvIGFkCUBXAENsbwBzZUhhbmRsZQAAVGVybWluYTB0ZcEQsRBTbGVlQHAFEUV4aXRDb0ZkYDYkV4Z5sTFjIGF0sSFNb2R1bABlRmlsZU5hbVBlSCIUBSCXR5UHBocD8YBFeFcARghsdXNosCFUZwZgViY3B3AllyZGRy/gMUVHlhaEhFEWBpcuASJBbGw4b2NhUwEBTAEAQOmYZ/DGVhZCVBhTDkCGMUSHVzAAH1VudSFzZfVAaWVzRVwB2BMIMMQ0lURkxCH31lY6w3OdAGdJQkTFEFJ1bm5o8AQgplY2RkcVJgacFlAKk0RX1tb0FuCWtlYmB5BUAQvyVoUMaXRpYWwwaXoxFcDkNkcXBuI2BhRUYXNrTSJlbX0iQ29JrAcABFSX8MRUFFRFBZolFKCGC7cAAaMAAAG6AQG6AAG7AAEBkgABVAABAEoAAQgAAQkAgL6FEKAAEJABEAAwARDwABCgAQAQEAEQgAEQcAEAEMAAEHAAEADQBxAgABBQEAAQMAMQIBEQcCQAENADEICIDwECATYAARUBghcyNYDEdBUEldQM0iFQRFUVQGdDU1wBkBQA8L+IR7DwD0UHULMIhbAIMwAPsCK/6L2IBLECsUw3Im0GA/ID/gArwCvSC9CswQDiB9DocvYL0AAL0nQIA9opCwA793Lk6Hs9ABgAWAX23KD9AwPwAQBABgFADFgDAAQKwHVvLRqpAAAIgNNUV7aIxzMAgL8CbLZ4RDEwgD94/IOuSw2tWwAA6GU+AAALwAh0PujXWGCVJrdAVxfGlllAl1WgfAdEa3QDAkXlqQV4VwiL2P/QOAABCwaAeIB4hIIFRQUE" & _
            "RQX/01iL/q2EemvRM4BvVQSyiI3AqgAMK7IE/3X2gCRAF84DYkfgBGG1nhAS0OpkbBABADXVBrIqA8wIgYRQZ79+jb5EBAhfgcfuLQ+w6aohuB4qBrAalm5m7gJEILYvUTJFVD1QchVMAQD/bxxgHAEAUcsABbcSABBEDBDHAEiUDFAY4rgHAF8AAGQAZQBmAGEABXUAbAB0PPAVpADxBeBEBXcARQBYblzQlqhCFmIAci4AacRwRgekwzVwovwgxwBtAHNcWtZIBXIAbwzQBfXFAnhllFAL2QBFGnAAY+0dAK4MwKZubSDNcEOMpBXEDGcUUg+RxyYnSBO9MvcejTImJwABEKcfABA+FX660FogoNYBMNYOABBDNSF0YTTgYwAAENQmQAZQ1EQDdABoNQFkTNYGVRdUJEFXCsI1RDUiXnRUUFcF0irBVvVzUq2U0MYGdhxQB9HWEaBdAgEQfgIA1FJv0NcgwEbJANQkPXKNHBAn4ttfA1cPUjYFcFUxAHNXS6MA9QA8O1YOMlYNkAAAIGvSP9Pk0gtHFccC9gwwRg5pAOLWF8AsLAcC8NIsULfaL5JEATPtAnhFIEzBUQYwRQLlF60RIADWNncAACLUMkUE7Rd0+CRQNFE40RVD9wpEbGyDvg4wxBY2N2frMEwAwPTG5gKS9VYHAGL2VudGBkIHgFYGUhY2R1cGINdSdnbmAtKwbS0NPQVvDNBqI1Zh0G21JcYFb/UCLRduPAgQf3MlJw0RPiVAo10ULFF5oQdAATTXX1EKccYiaeokwDtUB0BldoUiaeflIDzBNTYA0i3AbjRTL2gEBSC9Gb0Qb3wgVh3yCxBoZaz9du2W3ZbdN9zxWg5B1gF4xyMAUQ/TiHXfH0d0TNENy1bzCBANUvvM2TdHdf1zTHfXAuwOEG1prQBUQdeEIA8Zb03OewD6/wAQQiEBAEaNWjwFb9AbAMHXAP+/hxJE4QAC4DBgwUPoIQMEQATiwTAgh2UEAKhEQiJCqFMAgGM2ADqAwwEF" & _
            "4CGhBOqBNGAJQCckBqbirMUBICWjYs2DQoKCAKeh500jXiYFACgMxE4MA+hwAhxAFGZEOgAARDCgbgcERBL4BQCCkKrEAwJGAwAUAxJqqOIDqABELEhWWFhWWADSOlIDVG46HggDfHp8COAIJwqAN2BUIMpDIQegomgLKOysZAEgqYfFg4TE4wIgJONgLqvEgwTgocTjgkUkIw/AAcRhZOSEpAPAIc8x4MdRIAZABCLqwsEkNgAANUCAgiWhRQGAJ4jhhSVBBQRgg2vlAKVCIQHAQ3FA4sJi4gEAAoJiMiBgoQJhyKHCAsomDAoAHCo2Cg4ohkwAIhBeFh4OFhwAQCIstDQDSsYALDTIkB4ODpINPCowKggBIDAABSIiQkQqKiIb3ksIADIAy0FwHIND/9qZ/9/YAP//i03ciX3gx0XoRSkAADk5dGTosBUAAIswVmoI62v/dQyLdQj/deyLzv912P915P919FPoKxgAAP9OCLgngAKA6V8vAAC+J4ACgP91DItNCP917P912P915P919FPoKxgAAItFCP9ICIvG6V8vAAC+BAACgOvUi0UciwDB5gQDxotw+A+3QPBWUOh6NwAAD7fAWVm5//8AAIlFHGY7wXVJjUUcUI1F6FCNReBQVot1CIvO6DcXAACFwHUg/3UMi87/dez/ddj/deQAAAAAOdOhTQAAAAB4kAAAAQAAABQAAAAUAAAAKJAAAImQAAApkgAA/D8AANI/AAAUQAAAx0AAAENCAACcPwAAhj8AAHA/AADARQAALEAAAFJAAAA1RwAARUcAALk/AAD1RgAAI0YAAOo/AABVRwAAu0YAAH5AAABBdXRvSXRPYmplY3QuZGxsANmQAADhkAAA65AAAPeQAAAQkQAAK5EAAD2RAABQkQAAaJEAAHyRAACQkQAAppEAALWRAADFkQAA0JEAAOCRAADvkQAA/JEAAAeSAAAYkgAAQWRkRW51bQBBZGRNZXRob2QAQWRkUHJvcGVydHkAQXV0b0l0T2Jq"
    $sData &= "ZWN0Q3JlYXRlT2JqZWN0AEF1dG9JdE9iamVjdENyZWF0ZU9iamVjdEV4AENsb25lQXV0b0l0T2JqZWN0AENyZWF0ZUF1dG9JdE9iamVjdABDcmVhdGVBdXRvSXRPYmplY3RDbGFzcwBDcmVhdGVEbGxDYWxsT2JqZWN0AENyZWF0ZVdyYXBwZXJPYmplY3QAQ3JlYXRlV3JhcHBlck9iamVjdEV4AElVbmtub3duQWRkUmVmAElVbmtub3duUmVsZWFzZQBJbml0aWFsaXplAE1lbW9yeUNhbGxFbnRyeQBSZWdpc3Rlck9iamVjdABSZW1vdmVNZW1iZXIAUmV0dXJuVGhpcwBVblJlZ2lzdGVyT2JqZWN0AFdyYXBwZXJBZGRNZXRob2QAAAABAAIAAwAEAAUABgAHAAgACQAKAAsADAANAA4ADwAQABEAEgATAAAAALiSAAAAAAAAAAAAAAyTAAC4kgAAxJIAAAAAAAAAAAAAGZMAAMSSAADMkgAAAAAAAAAAAAAykwAAzJIAANSSAAAAAAAAAAAAAD+TAADUkgAAAAAAAAAAAAAAAAAAAAAAAAAAAADokgAA+5IAAAAAAAAjkwAAAAAAAIUAAIAAAAAAS5MAAAAAAAAAAAAAAAAAAAAAAAAAAEdldE1vZHVsZUhhbmRsZUEAAABHZXRQcm9jQWRkcmVzcwBLRVJORUwzMi5ETEwAb2xlMzIuZGxsAAAAQ29Jbml0aWFsaXplAE9MRUFVVDMyLmRsbABTSExXQVBJLmRsbAAAAFN0clRvSW50NjRFeFcAYOgAAAAAWAWfAgAAizAD8CvAi/5mrcHgDIvIUK0ryAPxi8hXUUmKRDkGiAQxdfaL1ovP6FwAAABeWivAiQQytBAr0CvJO8pzJovZrEEk/jzodfJDg8EErQvAeAY7wnPl6wYDw3jfA8Irw4lG/OvW6AAAAABfgceM////sOmquJsCAACr6AAAAABYBRwCAADpDAIAAFWL7IPsFIoCVjP2Rjl1CIlN" & _
            "8IgBiXX4xkX/AA+G4wEAAFNXgH3/AIoMMnQMikQyAcDpBMDgBArIRoNl9ACITf4PtkX/i30IK/g79w+DoAEAAITJD4kXAQAAgH3/AIscMnQDwesEgeP//w8ARoF9+IEIAACL+3Mg0e/2wwF0FIHn/wcAAAPwgceBAAAAgHX/AetLg+d/60WD4wPB7wKD6wB0N0t0J0t0FUt1MoHn//8DAI10MAGBx0FEAADrz4Hn/z8AAIHHQQQAAEbrEYHn/wMAAAPwg8dB67OD5z9HgH3/AHQJD7ccMsHrBOsMM9tmixwygeP/DwAAD7ZF/4B1/wED8IvDg+APg/gPdAWNWAPrOEaB+/8PAAB0CMHrBIPDEusngH3/AHQNiwQywegEJf//AADrBA+3BDJGjZgRAQAARoH7EAEBAHRfi0X4K8eF23RCi33wA8eJXeyLXfiKCP9F+ED/TeyIDB9174pN/uskgH3/AA+2HDJ0DQ+2RDIBwesEweAEC9iLffiLRfD/RfiIHDhG/0X00OGDffQIiE3+D4ya/v//60kzwDhF/3QTikQy/MZF/wAl/AAAAMHgBUbrDGaLRDL7JcAPAADR4IPhfwPIjUQJCIXAdBaLDDKLXfiLffCDRfgEg8YESIkMH3XqD7ZF/4tNCCvIO/EPgiH+//9fW4tF+F7JwgQA6T23//8Aev//YgEAAAAQAAAAgAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" & _
            "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAQAAAAGAAAgAAAAAAAAAAAAAAAAAAAAQABAAAAMAAAgAAAAAAAAAAAAAAAAAAAAQAJBAAASAAAAFigAAAYAwAAAAAAAAAAAAAYAzQAAABWAFMAXwBWAEUAUgBTAEkATwBOAF8ASQBOAEYATwAAAAAAvQTv/gAAAQACAAEAAAAEAAIAAQAAAAQAAAAAAAAAAAAEAAAAAgAAAAAAAAAAAAAAAAAAAHYCAAABAFMAdAByAGkAbgBnAEYAaQBsAGUASQBuAGYAbwAAAFICAAABADAANAAwADkAMAA0AEIAMAAAADAACAABAEYAaQBsAGUAVgBlAHIAcwBpAG8AbgAAAAAAMQAuADIALgA0AC4AMAAAADQACAABAFAAcgBvAGQAdQBjAHQAVgBlAHIAcwBpAG8AbgAAADEALgAyAC4ANAAuADAAAAB6ACkAAQBGAGkAbABlAEQAZQBzAGMAcgBpAHAAdABpAG8AbgAAAAAAUAByAG8AdgBpAGQAZQBzACAAbwBiAGoAZQBjAHQAIABmAHUAbgBjAHQAaQBvAG4AYQBsAGkAdAB5ACAAZgBvAHIAIABBAHUAdABvAEkAdAAAAAAAOgANAAEAUAByAG8AZAB1AGMAdABOAGEAbQBlAAAAAABBAHUAdABvAEkAdABPAGIA"
    $sData &= "agBlAGMAdAAAAAAAWAAaAAEATABlAGcAYQBsAEMAbwBwAHkAcgBpAGcAaAB0AAAAKABDACkAIABUAGgAZQAgAEEAdQB0AG8ASQB0AE8AYgBqAGUAYwB0AC0AVABlAGEAbQAAAEoAEQABAE8AcgBpAGcAaQBuAGEAbABGAGkAbABlAG4AYQBtAGUAAABBAHUAdABvAEkAdABPAGIAagBlAGMAdAAuAGQAbABsAAAAAAB6ACMAAQBUAGgAZQAgAEEAdQB0AG8ASQB0AE8AYgBqAGUAYwB0AC0AVABlAGEAbQAAAAAAbQBvAG4AbwBjAGUAcgBlAHMALAAgAHQAcgBhAG4AYwBlAHgAeAAsACAASwBpAHAALAAgAFAAcgBvAGcAQQBuAGQAeQAAAAAARAAAAAEAVgBhAHIARgBpAGwAZQBJAG4AZgBvAAAAAAAkAAQAAABUAHIAYQBuAHMAbABhAHQAaQBvAG4AAAAAAAkEsAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="
    Return __Au3Obj_Mem_Base64Decode($sData)
EndFunc   ;==>__Au3Obj_Mem_BinDll

Func __Au3Obj_Mem_BinDll_X64()
    Local $sData = "TVpAAAEAAAACAAAA//8AALgAAAAAAAAACgAAAAAAAAAOH7oOALQJzSG4AUzNIVdpbjY0IC5ETEwuDQokQAAAAFBFAABkhgMAVdOhTQAAAAAAAAAA8AAiIgsCCgAATgAAACAAAAAAAACLwwAAABAAAAAAAIABAAAAABAAAAACAAAFAAIAAAAAAAUAAgAAAAAAAOAAAAACAAAAAAAAAgAAAQAAEAAAAAAAACAAAAAAAAAAABAAAAAAAAAQAAAAAAAAAAAAABAAAAAAwAAAWAIAAFjCAAA4AQAAANAAAHADAAAAkAAAoAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC8wgAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC5NUFJFU1MxALAAAAAQAAAAKgAAAAIAAAAAAAAAAAAAAAAAAOAAAOAuTVBSRVNTMpUOAAAAwAAAABAAAAAsAAAAAAAAAAAAAAAAAADgAADgLnJzcmMAAABwAwAAANAAAAAEAAAAPAAAAAAAAAAAAAAAAAAAQAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAdjIuMTcLAEApAAAAAQAgFf9LwNUagdOS+vXucGtQtg9DS6IQmf+s8pSAof/lzpNbvs5vGDaqkwL0lyayt6KDCqSJQ4o1tatkkGwANofdA3647PF5FGwILMgS5aEUdVtvkW6rTHOAvhd/a9y0WQ4MHZHy2qEgIvEEBckQ6CS6rwHy7TpXo9nOBCnegq45yeUp9j6ERmDQm/pXlELC/cskifa6KYRzbr93Bun1SbzBGy3q/e2ig/wDy0np/VEDLst8DIQyaum9A8IzVkuBweTYu/SUcpp61sr0o+UIQOKCUGcx7rfvGV/5SRb7qLnzD/EoTl+yT7nSGAl5yu6m27jMGbTHWIdP" & _
            "BcO5oaS1ojADtzEC88OGmD377D157rqdBPhXqqQ5ch5+xqS1D1y8vMMAOw3YjWPuhyFNftT7+S9niKfbp3hY/J30gM4XSj+7ALAPI+0naBPxHCl9f4dGpz9zR48bX23uToVMlxVcAqVgQgLEkicA6Qeu4h+PzWcDYSlBTT7td4NBtZnDrfSGjzESSSUjGPd6DKk1sQ1xi98gMryhy1BnowzKAQW/a7PAetqKogR2FwR0bCQRN4+3IiJhLxa+5ypaqrPmJ1wo71zSLk+fbfMzOq3Tc6iWGzJT9Dp7qt/Bk4Won9TZdykRGrz/kQL84d/5UQLh/zgD6n7PQKm6Zg2WcCML+5Af7QCINbv7WQToq0OlPgc7JZgeJGYBhX7k+A9ghawAXiVXnpLUrekoMyZ7ZJtjWV5KpZAC7AL+bGAtR0A0vacQJaLtqwFNRxCjDSGSExj4HyZGgKy/CViTq9NA9+3wdoMRdCYMBR0yIMxpyATR0zEqHispFSa6lHOHeimg2jhNhzrJEgcwODz81IGmlg9vbYxhcz5c+DfUnLCEgA4VocuiCHFw3YYyQGw/b6VcwPnM8LW0YetS76d8lugDAcxFmETPdiAF+eoZZEHZQAqS0GfGXM9JYP66AXgJJjGxgb/pkbkQQFA/j7ZF3Y63t1bS5iNQHWfGTyQXwHxu4cgfBzEG2ajf3/L/yLB98GEAnGSHua/LD8edxiRBRGj0OGMVwmpU+wBV7bzYDWGoAer2kPKugN5zFq71KHRpYuC+ZgiyzFkCMpNSXaZncU/zh3TB7LQvQC9WKD1B3bBj2Pr36XNBqspcwFhLNtZGxGGJcw2WFJdbFi4Y+zHeAtrnTrzCxnuDBproPEXo93dkVPO2swMV9Hgs2ZzK9XLaX7KZX1zJtS46OP+8DE7T0BfjVkOxVCA4CIL9oGL1KO0iMb87Nnv5u37ckey2ao1w1zgCzc7IxUdSAjyz2/CLRUMir4jAJcATn9hZZI4gx/yxRUqvf8qhITO9c38ZmLdR7Sel" & _
            "n9gFa6lkgtLqxSEIumXqky+yYFXkgOH1ltl2Kb41pUi8HalS8NXxiQ34hNzwePwdOylCvQWMehjISmJ38cgDLbyeuBAkNHGge5shHsVml2ouST7V2I+YqDBOK9ddVjYlg0PoEpRn7I5cvVwtJNhZiEoqrcMyzjd5+2P+FvaB53sxRWNu4xkgJEAhLjN14JezSGL0zuEkEFpwDdE+uLRvVYvSNqdZiJixNXnK3flzEL0B0UHdIRaPqZb7/mFG1SLBM4UqeFsjCD7SpaZgDIxHgfPG7Cgtyd/hQfg1whZl8i444Jm49Mx0AjBeVt1BwaHv/C1LMh/yG+9zlp4ru34sorsJ2tjIELsMhfd1hTTawIDZUup56DL+xyw3l9tW4gFcubOOA76RXL8SAV9kTvd1ShlMqAXTbN8Ux7n8pZs7kk5gAN6wUUuRF98r3co5IEaCg7htxIV3h28gCIXtWhFgyeiiOViWrTgly/rou2mq0n0TUlnBKqmQiUrZfAgbDuUJq2au5GYTdmVRRFHIByHDDM9dd+j0siDT5YgsBYZHJz1y4aUhAp5x5hGPSeoIC5d0he5shi1kAexWrcXEKibBGCiQrJzUzRflEfL4NVSoXD4KYIrWkJekG2T8/iWc1xu6LFi8mEAmq5d8XMuWo2jwzaZLkGzALv0o4yn+yhXSFuVdnfWI2H7Sq2Rg4joizZDwrLdNdmIyEZAayB7zaeIbnGJhmII4roS7fVuEtxkItSPWwDSXqlSuLgIdXjtz/IW+5x3+RRgEhlxc0HRd4672zYAUcqEeva8yU7VsYc6IYoZ6V53X1+KFeIgEwhKgtjniAdecEp2mdk5Js2PzfwCT4HehqFKYh+qZ7CvXYpmLWD78ruySBgTZFdlpZ1IY66Yq8AlTMSBlHNx9ZJQ737y2/UAWJSpr8JLUmCkLBd5l82wzN0PBGhANYlbm/604OVheW8gWVbif5r5mYQrQZakPk/IhSm/4Gl4iVQFtjop/QlN7qYXXY74wLWLJSPJjI7Fh"
    $sData &= "X8/fn0W0Qe2LxiNuCTNXOQfCQnhEmqYdqoqreazX6T8hB71ry8KSRSBgSN5wJo9g+K+IyWeP4Q64o+0TBacMF6BJdhrS6a/iBs2eWOWGBhK0gqXZ5vQj165ZvxgJ48zkSPIk9H8J7/e35V55GLqUKbEJ7BgGl6A5OWc3XXGxMZllbT/CGJ4H98ADkXCO97bPqvGhYUUxDKLslidHZW2bZUJjP58yYPbzcp/WUwdGM6mbuOURZ2lSlVwOH/BDauvaJ+tsr45G1q413cX3TVEpR1JjOO7pwXntV1Ow7HMdXWe51ur3ijiXS8gEaJE4dFoSTOZdIpqR76b2MKOK2Nkg5+le6uloqx+970Rv+z+i0QDoyAbIz6Xz+HvzuhvPw9PRif5MaO+ghyZnxVZMJSqJu3XDqt2JNoZTmaCvDXEx+321o3rE8dtvxXJT0q1+SESzyH94lIVxR1bnW+A7xIJxdh79XLxjU8eevF/9OtRfn1ekz/e7vfvGgQ8VFZd2Q0dWAFrpy+GpD9z6nY4hfjtMihsMcvavnTshDhYSSttkGw+ThH4z46ZUD67XP/WPeKNamVkGIjbUUmlltgv3hYEHDDjFCteHlLsx+MaqzEn8BOKLBJ9vis1hb7wyQGNc7pG5xkwUxDe9ea+r3r+/SqJNKb+EqKpQ/bzmdxbPoVyvULfmK7hbrVhKUBAFA8bJdHLAnxRxkqhcX95YfFW+vMmqx0InmffuZGmr1fixz5MsV5JrPWxIz6yQeydI70Ps3OjGxq8p/XEzGmRnbmaOIHD1q4FVs28aRWosXZzak5VJP6ygxXknxMkyvjrsfOHlFvljUxmgTgXdrIYZuZ1fdYBhqrlb13xFgR0/wMllclJ3LrxQN7iPgYst6cbusCK8o99U4iG6a2DO793o51DT/AJP9nahprF7V/weWD4doaumJDtOn8sJf4GXNSWlOzy2y7qIa/AFPJZsQzme7GsnQ7rD3G60JGqGTG+C40WqhCqf48Q/9bXqYZcLnvmvhOK+grLR" & _
            "gHKGqKouQyocJjwzqPAgIH3sR9LEjWVNBngkRlHd0Y+yxTXnK1nEcsP5qLA5lJaCS35Zth05kfiF8ZR6QjjPgjotGi0n8EH8wPZADjE4wwAscyLv2QuoNu3Vq+qzNX/u1okcLBagg8TeUOw8NzlIS4WTe4IUoiEoNegZfGo0YjpnLCmV7YOlQLoDyOMYQq37fWL2ffa04O8ub4sDAFcyiR7k1GbYYe+jzpbEqHGkBkQt+iB2AsAWG4f9IdkKulXj3GbOi3F2z5Gl5HsKihW6qBETRZtPZ0bzAgjBfV2tDz4dSmMqtBEgrgojpe+u+iHha6gN90uYQeRPndcPmKmjL1sT46LFNBe3KQf+1hTdp0Q3ezcefoflsD7Mdd7AvTCkzdyjmLBzrjusQqDU5ualhzcfS+0dNc3IFR1fPi5KMkjDAngih524TbaOt3YHiOLFVxl9I5RSn/4TC8SNJxdtyGpyNx4YB7WaARyqZmHwuvTBxRwf427Nc2RUlhtVuOZNg+f84gao3w3qbXHS99F79iVMlRj3H8M98ejbnzrZ47CQjvq/cO67E1Vwo8MjvZIpisEWJdap9TYmtWui42cLR58p8r6Or1mn3Y0yDLg9X9X6NsyDny863Y3czxAh/NTZIbqTBNvY1BNkxkozekMtgibe88OTu1JPhrKqqf4lbsyZgJ/ECHvRFAgs47Ooojh7yFw1MnoPlMIAvQzSsF1dPpZrTPWMKRH6t8cOCPvdg5u+W9gO+bQxBq0ElhqPBjdX94HPdxtfbPaLIc8SVYK/EFiC7g4vLcFYkcalzerIQdO2uI7c9D/6gYdyb19/BW55KWx5IOE4JW4JGX11mUf/XBiWHupQ+UQsy66FwDaaIwEneYONPvPvJ5wHpVXKqqkfSHQEL1LJPYUltUYdZJK9x+KMJsxZQNi9VhRtKsVOEIZnZC/Hv2YLpUpiBTEOtiSqzzYoDD7wqHICAK/fNDiIMEcTod9TX7g+uT/60o53wSgTHuejz7ZT4Yqx1tOf7sBy" & _
            "dmMlm11cTnJCUWPyG0/Or4PrZT29vzDSM8BFHn9Xh87AohP6BJHqYbVyBqiu90LrLcCl7P25IZIVsOZgqHZT8NqqQY1+IukxIFvt2sFL2IkO19iuWoVCcaZrj3B9Xxiz1Crskcf6rTgrAaSBQRE/LU1KZ+GZV9BOz3YNOMUfmAe35dXBEqLstVUd9Rlg8EIYQcJ68EjFWcbHdRVYPu+QgHlJqkAvJx5gNzomVFJDpqso1E9u7Ezwd7YzWRkJEwWKD1YqbRZ+tT/FenYIw1grKt42YFQ5yP4byKYAF0opKXgtRdok9RMLmSG5rN+JTLWuqeOcAo+cReqjO1tRooM3FceEtmSGw9M1BlFJRJZ/Eh0xrvg3JDh8KQtH33bnkc1bGXJmhETvaiNzsUQyFMyDUFLv8zOgQePNvYP2LZQX0XsNdsWhCM5a8kr2/aqBiMb/qqNbrhq+ntR92zqiKgaeXv5+b/wf8/gt8McOBV/MZVuLP6URpGC7ZZLztIMr7YAEBoVrfNTOCHQilgtX8ANQCOV95PEQRAKv03Axc2Ig+yna/tuCluafmAYDZN5t6vpPG//goLpKCFLrTUnQkIjXtZo2roOyw0qP932wbxrm3RudrKdUsLRM+jyCgGYNjcA31ql4mU8OOBQaE61miQS0LEgNosDIh2qzBcV5dwkZd8jJgcWOOhQrTHEsdwFvUyTmpzjMlsvYylvhAHFG26q+6Hl5mBvEryPEyUGQyjHP+1U5L3f+10RWnSo+oBgSRuybfJhLXHmrJoqx82tpJD9ur24hA/QsjrV+NoD6GoDgx/ugoM7/9IrEGkNz+g0u8YjZnVqIv2NYjWeeBHI6uTtcR5yeHtA4tbZzHYXygI/0gp26cci6SqIUCve58bs+XOKi6+n+9Vpzc4vGT4xoG1OETkh/oRZLrm1tAq9tJoA8Tso7lL1kzGYz92DnK4JzLsO4X75DSUonoSLOATYFw6+5dkG/ss8XuWDFTF8dQ6I7dz28JesV6aHbZdCNky6n6JDc"
    $sData &= "6kT9cCdQvV8TOZhEebkpk6fRZRv2mTllvrVIHB+BrOvowY/Tl+v5ub3zqdv7maugjMfF9WsARlKfg4tsYGlPy5cuaerjM0Iwa2qq7VCvl4LNTY9WDPdVlRGg2mD/56ZEPdrsjaR3GdXSxWiedUWs3CwEmJLiCS70pmCyrLkQyjxfM019n/kKkiauwgvYJfmerRE5eb9yW9NA5jx+e0XExBDqlJvLQQDHllP+LmrzMOPxziBAGTS4IBuZp+narFWUIBl0tYgCbf/OcEjU3/2gJq6lv6zyC7tx6dKB4r5VoV3sftUUBDM/UX8ZvjnId+kt8LEiETocD0pGfihsu5hRkwbkSOZXrMpuCiAjjXIES+0DoFW4NKavWfT+rDKhqPI+beOHQbPTxJpHakRBN4baxykaSAGgYWTLaDNsM+u3hM5J8ckGSenGbafXkfnSHm0N6jpEZ7hHSl7Z/DI/8kd/LA8xJEtEl4El5TmGNviSLJkv8LdbJFXnr+qe2dlsu2zR4fB8IZ0wAUwrhc3b1tnW1Gu0GUGCHUmg/LmQeAle2WrfwXOQ9ZwXVaHnWCD/e/N14dvojfsN4td9Fh8RiJHzj0UMgUlJN5lVbaVbS+m/9GObxv4gCpYR4LsvVGAfz9KCRuMh2zH2KuW7UKake5nGVFdaWdcfVXDA2QDGk22cRDjqluQpiMbhOVUf+/UqXCHzuR9lnRN6CihS0vZ8G6t+XjByWtP0qEm+e0kVlK1cjoUJ95zpHYpi0s/YMN9wzpm3ZnhgLXd+76cncW8hExVmvQX/uRMITpRCbFBLUt5XSon2yn9WVpviDGfVoOutAePhhI4d2yxhwkl8E4SWFGIx71Pm8FQbJkP7uxZcaUX4aHlhORfDPt04ifg4KrGM+pnDM3Se9dZOLXln/FINPUAyD2p62B5Z8Bh9vzmXNJ+dOgmYIbbeppof5/3K3sZ7zl+X/cBV26d8GtbzYcOcT06u1KVuVEhsiwLSnCIwebQ3cqs8dpfMAx0cqWXtqHLyutPm" & _
            "OHERnfK+X72R0CTNtgoZ9waaaOuPyGYgRixClo9zJNVCwpq79VBCoX0XuIqD+G2hzQe4ELHsjjyeT+5OpzEfztVgPPG6VA4Bgi6a78aX5VHmnCl5emDw36nkbcGBkaHIUWY+3JrV+QojV8FVgl0v8ckgo0+N9hT69abK9HN+THIM6RMx/SkPp9Jt8crbQuoY5gPF/2xsclPIlkTXNn6Z3mYW+hm92uB35itx6WE+1D773ypnLRZvk2xNyfW5S4QbqJGvlUiAS52YNbHil6bBdYznc8qg3CqQNTQpz5GDiBkP1VD9BS/fxTtg3y/WWM3y5pUMbShpB7Um5rsR1XTgyBPBRN9YrboWBKnyPmeLomJNmEErHbjFssw8OKCh/ZEZkRyhdd7hqX6M14eaB4/beIJ3Iz0y377ZDZZUUA8QpS0uY3pIn46EDd+K90G5lLQL+7Am4ZUNAFK/h8TA1GNI+wXBq+lluDp+x7mqapbN8olRp+z6Or+lOfkxUSeHM7HKtHu/gtqdRLX53XSxMZEk7cx7ul24jpRhY+SaNHeNBoZTkQuioVzzwGJsaQkppcLKZ7oJ0lif6Npf+eImJrqXMUzC2oHHuRHVrRDxQcWf8dXrlm6z5TCbYHiTLHEo99M4XF10wOcaSY0ULD1e73+IXuVFy3nh76ppi3RfKe5v9IiPxlWuI/yStPsXzAQ65ID5vLTFCNsIf+OExPKrR6aFWsR61OejULW5bwtUc86JPHJx2VrdY0BKEcGaNLkxQ7DjRcdsQPNjc3R0WgdU5CSNl5/Igv7z2TUBtNdWmzGwwCvcaOezT0nLYGxTc6JX7LvshdiC/OfhQqvUS4ibjV/b7Xqi4IZLk5zYVAVyK4H6ukDaIF5o/swFpDv5UgD5aEcbtzGD+pdeZa4absQSzNR2BxBozBCF1QOhOLwcg3fV2bAtSySVUkcM0BziI1hKpzuNNeEr8GG8OOllqY5yCCFjhw/PohVjKDV5UZEeIz8FzubSjh9Rk0EBS3X2cIcyfeTG" & _
            "jF4+kmRyTpVTnuymftAwmzBqX0yOhH5kgh/TjE9rXALYa8L4VvX+vxRyfhY30yvjXz/A5n1yESd9H3ZL4WaujLi9HTtkaCH6RIuWdaA3LK9bFXbJZYpL8apMvC98s7w6wGgM8txf3uYMKRoKlK5uHz3gvcF8X1Cxci8PB13MmXCawFfLba/2G3v7H//T85BwK71ns0DfHPjmQfN9zSzO8t9tb1vnDIzYvcGe4lZOVy5qnOktCURerkSAdE/TBCI05gApiLo/vHuumlnqCeDbBWg5y3ZMwrJjEN1lURBtWBb/SyRcgPUzrT8+A3M5EfaGxaLCoJXpLZKwQImlFFyCTqFvBWtSNc6T2toyjWINVhFFsCt3DM3cNClwy+4WjSS1uW9MK/DY1aR87HqXBI7kT+pMYb0WVwx1KfI6L2a9EMtf6mC540n01/ywxTC5ZCULt4doJlQuiW/KZnIGEOHQgYDurhzS37RDI6PUoOLcc0yADGTGbtuhKGSEklOb/HpfmN2xxmgARTKw7ixaiY4lShJfM8wmqCcDb5uV/6K2uDevEUOgk+G8Y/PTdhwSDrCiHVIJvzz3rAwrqrTiShpVbs/EVlP415kBgYa0v83b4JVP6vAWGDQJLIW74jiVUMxeFA4crsjhXOMD7QyNiwFk3SrXMSo/n7N0MAsrX4KaX2ao/0/+zRmSonHWipCznBDhuEvfkl2svUEcVzJ0tc5gd5O/ljXcb8gt+6Fls1BCa6Yp/Ku9ts6ddav2aDWqpinUDuvJKN9sc4lxPAXCqoc2RclC4jOJBTBi+sQFdeiiMiNxFLID4LkNllrZGoIU81VfojAZAQOjIge88IyzeH7CkQU8rSo2rho8ncVbSz7oFN6Hg+kI+/8P0+m0c2BDhL7D/5aIKMFEaVxdOCjJoTCRPQlmus6+wHEaWJVqubRMcEe9ApOnhRdEpzB9MBf+HFoj6TxIcdkCuSwqpMHHiVfbUVMFzZmmdfoP+NMqxSfBWDTDQWQjNxUU9u0gKu2a/Ff+"
    $sData &= "0mR+gYV3gx9cBCnExgtTNkkJ2PJ6rFxoiacTacG5ZPI/1bhMaY1yAfLtUqn8vdcCwKqYqUca/1BqK2xiAJ0ArozXZ5RQ/mj1Z9h58uRZheSMqxGv8J84MMNnPKc1plee/vSJ3ztCrSrlCoGjezckcl4FTYR3ybe9uflbaBIBlDylSHqWCfn69UGBlMwVi7wOjAf1KxlcE1FbeFnHOX4fQ445etGEJVKQWIRcI51JtKSG39WoFkNzUZzP8NBYT6z3Hw/4ue8Bks6KYXICwBDEXmgid5wo5DTUaCpcW43hCPMH3PFrbGGvxII/jSNRQ7yuhq6qsmJKE+jgH9oWR9c53s4C/gDWb0NoNXIix4fA7ynKpA6s6TC22AdbdYjCVdktqM+BLL+LyOsHa7rAqrDQTw7j5Odqo6cvcLLu5wW7f/YrdP/QNQ55HDcixpyuM9JfApCwtnRb/z5SPtRf1fJhqGVD884Sif7oXgQSVjDwpFQCyLD4qZfYxiW2hjkrGDkPWmBEsuLgu0T4X8xiicFHxwm9+CESZuhdif3rKWYs789zMVzYdfzPN7V1tXPdqyxSELRVa/cOQhNFcqvMfDAixrIA0LSS4uiZwsLqEtulDEUi6NMkyegw5G/Gz2wqcPIih3pAcZQQOqyJdaNJyxJTqwwc1z4fwPHQ9Vhzz3o43X2DL8rRCTRGWO9o6xxF2Oo1lAwFjdFwKVYj6SN0ckBY9BZgk6qq7U71ZZnixDIJxqZ/gOjs1AUxd3wsuwU8CBmtYCweTPdmoPx69zzf2rY1APnBagc9ay4vEpKG87PKRCiPA1AbEK5x8ZPKl64BAuHiTQyWyHd6sPKTa31F4fr4+NZlxMMEKH8nxZhw0H5yyENWDP1Cpv6cNKZ5tVWDvNx1tTEnpO6kWiqD9iqtisDO2uy2U0jMa42VQDdoaRglxQ8LVH7BldlAnnpprd4FVXC1BFjnAKVc/Zb1T1uDBzQFlNLHr01fGCoPgx7l2oVBHbmMu3n+7lv20DafwJYdrfwF" & _
            "BM26C3sUPifMOUWoDuqF760FWwoukScNjdHNTTsK9IsUaPVvM6qaE6CWBPU72P/YgvKA6ZXdZSty7/wIZYD0S6HD4EY9I6I0Ezvqeq3M2AWQzdjAMVoLrnP91sD3Lwpr7WdHdQgJQqvlr5IJ2L3Y6Rx5DHyYM9wdpWhOh7RhXVhnufk6sKHqrvPKC1DowlicPs22vwsXTMKskhAi/oQzzvKxzkmcbZFH7kcvn1ev8x8h8rNrAjIudg+CLxvsw+0i/66BPAf7b+Chz6/ksL/OHG806Nvfhm4oM+lx9g3ibUa5iDMSdaW9ipgNpNR2r0B3tEajxjO03jTXxkT7pw2o0nSsw00G9iE88ce9alASSs/HMV0EYm0UhNsVhQTqctFP90Of+Lv4OuPbXAvY0aka6yIAkvYOmcdD6Rf8BJAm6HpCQgrwYEHuLhQo7FteH7PhPD9OcL4f138Tn6A+HP1bzmog+rFM1lUVfnSK3wW6NPSc7yYBk5I16Ll4GFrYocUubp8IA4zl2k1EBHXapQvAq4vYgXQq4oiNE3KKlUeZ4J0UD86zAMrHVag+e6LACffSVRhFuGGKv0sfs97H7bul+PrGgiCKlDHOmFI2UmUyyXux71XVOb5vo7SkZaOdhkBpzlk1mhskD9yihTta/BarBsDkiafIwm/b2vTAASKxCDuo77NXHQRAxl+z7y8G60kqqleve61cICXBzu4a4Y1D89vSZHeVG8w3KFquEf5bgRngDj1ywJeJOpfdt2hPXAGyo/C3nyVFPB1qSIXEJN0yYf18rmDibBBN9lKXFNlU3nWjDsQTjs6aMEfUMzC5NVxWlcV0ArCOz/I3W637Ie2Va7AJ+KB8ktsOU8dhAwnpIb+Nx2d8aAwrU9M7O6OmqzrE9LNZSzlvXJBHTflsLuVMZOhoxCzywA3+vlBgkmC/tnEuxDQCUObY4ipcddOvxGXAntLH/MpUyMMIAWxGyMVaxs43CQLCGUhzId2+C1P0RUPd+B0Bq1WM/kwO8AQJRpqo" & _
            "kotPWicko26twBQ7/e2Sn4kCiLpUVv+oyr72WQTxwA5WCiRn0sawrf3QSLUbIABp/ZuK9fSaBnGYM4Wo3QRgQR0dlhBPpfUdqkpulE/7+0wmDN2zteg2l2GLNFSql03vvOE5zZL20YYHl5vtOmdfsio2mIj97Rs55JSGAc3EiHGReYn05+RqkV3farSILVl6x6YZaYQWuAYEInD5o/NNzOzKx99iBogw6USSpbceyQ3DCG6m5fmVJxD3AZTPG99GZRsLsGAbWQHxGu95tEAQK8kN23mMalctjL2zXu0jLraBHGwdL5wy4g1evJ9tLUUW+2wbLBvAYQGRSRQ+I19NSotCI2DfhVnoj7Lvmk80AaPxuJiFhAuKsCilqVFyYT7mL0Lu98mannHB2kODI6rkx9dbcMC4ENTToQGcXgon38LOUqdCRG4YlXxpF6w29UQyWkiJvvujUt0AKiQO8IrivKHqqGdH1kflWeUQhzahCrxsUnyHM3iwwWdgBTpehsTC/SwE0LiJPQxIC/GZv+RgFxJHmmRpSSXNXLUD9CBmzOnN7h78f2IZRsqmi6A1DR2iTl185WuVzB/ynhaKwWXQUhh8Zza3M1pe6L7mN+RLYYmRj2Y3Y80YWLPNPr2wSHzRrdQrD2Dw6schR5AVUWM4vHgbDxbubNdvTWRTyzQXYDejJHlTb5ZKxIFzjM0shrUaXrL0QIEFaJBkb/3G7athgYA6bQ/Net/10ZaPiKqU05z7fX5joq7knObBVxL4mVzgkaMP33PZ7gIiLOCN2wjmr5hjgC3AGCcs7Cvlbveg5RhSYMdXIHfBwKcUvrR4R3N1YabQ7y2dyEAEdjBv6d0IcP5tvUuzARFnhJB1iD1pMhyd3TB2e6GxWV/itN8vQek+ZTAYO06KKykp++37qZXOAU62FCqrNvgNt3vA8f9v59FCtyVOEBAUqyB2iLE/fweo9wn01PNLx2DY0aePMBH88+SdZQKtqFpFFQdrMMCF+puRiAeKgI0m3ydGb79+nQZq"
    $sData &= "t3wq1T1ar+CoZL2EGdMSv/gMWDjR6uORUBIpFoTdTu4ypX8n6AuAuNixWeNAzypCo0GzlbuvrwgopZ6KDUBbhaAHjiB1O2w6eg0XwpIPBCtpkl2nxjDImxcIXkGzJtOSaTg/1c1fng/qJFPdcK6cusTfKGUcycUOz1HuP/FpBTh9Dm50G3JiYoaD9Va+pj83qT5qfB0Fe3Gf6bCSQXeMrwVMj4iuWB157IFD7rIKUcqjtquql3S4fEjlpnZb/at70+svTrJ4Y+hlLzmjbZPSt2RxK8MdzQbTxmHwoOKLQbq/Rx4QVIFVQeHKdX/I/S/oHxCWuQN4HPf1RiiF5FCxUHIJ8l10/MiVZKPEN/0H+0swMajsqM+3Ftg8pLlkDEyF2ppgvuwHl7Ul5sWVOVfuLBdulRD+0Et9EXXkWk66Mf9iSTI9ygI5X5tvWTCo30sDJS9KVSm7XfH2Zt5NYOL3+S5gyG+e/MIt6ySL7dFn3UEXgTyCBZh9JL4mJiHc6INyuzGkFOUJ7bXK0oLWMM/Sa7NPd55TCFHPhEMz+PT9lR8MvVAHSnVIPxxgnf66JkCfB41H5Ws7HeMc86I1ruAs04BBldOvcWwvR5FXsa+nALOgOFLb9jilLwUtPEifI1jd4BEwf6PhCWLK+yCljT5BqUgbG5Bbi8Piy30yNPhubEKwfaUgVFaLlF/9M2/bpqcwjXRTRvtn2qs25riNyojXr0cdNG4rI+HqRf90GKRM/NQpdm59LkJ87H7Z2LNNkPohC95FTjtQG9vmLsTXLLbFxZIdBeUq2Kw6pL+tdoXRauG5c+ui+2RxMGkRBemegeP5VEHOI2JMUdr2eXRV8PluExdzTqoyt4tMPjaCS058eKcZjZw0n+ztCfRzDXwTsAPi+ElF5s8EOST5HUS5Y3WdjJtpmyRaX6DBxlk6+E7+e4Jha6kYiz7EctzJ3T99K9oMZ4CKVCtJNohXZpH0/WBEANfPSplR/mVvav96Lvr0eFveHNsTvE9xPXs2Snmnz3FM" & _
            "MOn1KAa0Pr9l809fI14yTg65nuvvUQXmWMtpbEwzolmvj9j2G5eelQn640y+FfBCfSScgYfhsjw9pSrCgTghL5EWdcsjej2daUg4M1IpJZpfawmfCgWbbj6zKzdLLCPkZtW1PCYNZFjKRqcTnt5/5L/KENf/KFhwdSlqkoaEzKFyqJs1/paWUG45ArOXxl+MKSadTstg8yeyMGPrihlnANc+xzWCKc7RoRD+rTZ8SO/U+8eDTcrA+pK8JJJOR+HVlcdiXbliYMJ8b2Inz4yU/jXpu3N7/o/gIa4qku+S1fZ5bRPf4+6hk/GoJZMhXTFDQDh4EZ4TPDRq1VD2gCfoh7jMUhYNxmpnYKri65jZFtpiQt0WTtlI9/c43MEOMeKk1knuZvCNZr99iuZGWwVe7cdgOATdn0PS2fIQyKUzlEMt93z0nIPyegrke1LXiR49k0B1NmdZp97oGuKPPqKS74jT84IomnOuJY6bbISCd/JkLQ0Yc/PFnFSDb4d9OZuY92J9UlxHYzWMVjuALuwOJPR82tD1Q+xYOOXbI52MSJW8L9AuVQH0whjoKrqIC2FBcqy3LKQFK6R7kgfBYZXWnYn9H83of+OKpNL8oAK2TciEjtTW0sS9CNchjPIrnXX5VcEed36XCO+xC87Rw5Iwv3vPJxiMEZ5n1fB5JTvKJsIw8TIksUW3BJqddkQ/WkBxj+QvLoclIcgo/zpTAapLrv6nHr9QM87jZRtgY6/9N8AYbO7r/oVRHu9HbdSenPFRO1cLO0TrNTwTlsnkKi5vE/F6+nuYHmeEEM+vjOs54qCYFEiuePD7CJSDyIRiDdxaxJRZ+LY3NO6BNT9ytmQvgbx5eWGshQY1CzA5sZF8hL073dN6HRTcjQbWgCtvKSqsJQuCfmZF6jAPYVrByUjvFdPfJSvfAgivbHPEbYdlFZfKMv1XS18Iu4Ak2k8W/uXXPLWmuytGUEI5dIxEUnjVfYexvxbPxxDQ+6/Y0cKLL8NMtjB1qlFWFqsaRu/+Smer" & _
            "BUjCJOZIWgu+Dwcpfg2xGsG4rznZ7Y+rCRUlDAkdzi+H+HqNM7xIOAYJDocEVuoO+56VsROLg+PieBYqKSaGKaCFU59oAPOV65omzm1j5/kdCD1NTSKuSIzjg71tyshFz7Pbp1Y+8nknTfwnlvxnbyQVQRAq91muodlHxZlQiOLeDrk74uN8XlD+ft3ILqCGPEHo328HAhLZH9+1Bb7rWHLBpPTT/c2t7tRIx4BSH4+U0MsKCydvqFTVOKSVuD1i+m/WM0WBpEjod4dVl7s4vBJHehOud1urC9MenNJrul9LN/K0plfpmnG4S7pd8WFO6JyMfiz8P61c2qCZnp/rhqU9ejzf/8XM1fQXqaq/4S1GyK/XIckDjJKzPqgpxS6SujWLvNCCijp6TUvTFBo6bkAvdKVgC4qMMQpb2I+Eh6yyPn0wAAAPjjoNAAAlAQAAgH0H/8iDyP7/wIXAD4STDAAARDkHdT9Ii4VYBAAASI08SUiLCLgIAAAAZjkE+Q+FfwwAAEiLTPkI/xVkUQAAiYVQBAAASIuFWAQAAEiLAEiLfPgI6y1Ii8/ocBsAAEyL2ItFgCtEJGCZK8LR+EhjyEmLPMtIi8//FQRQAACJhVAEAABIY0QkZEiNHEBJjQTfSIvISIlEJFj/FQRRAABJjXTdAEiLzv8VBFEAAEiLXCQAAAAAVNOhTQAAAAB4wAAAAQAAABQAAAAUAAAAKMAAAI3AAAAtwgAABE8AAPROAAAMTwAAOFAAACRSAACsTgAAiE4AAGROAACgVgAAFE8AAFBPAACEWAAAjFgAANhOAAAwWAAALFcAAPxOAACUWAAA7FcAALBPAABBdXRvSXRPYmplY3RfWDY0LmRsbADdwAAA5cAAAO/AAAD7wAAAFMEAAC/BAABBwQAAVMEAAGzBAACAwQAAlMEAAKrBAAC5wQAAycEAANTBAADkwQAA88EAAADCAAALwgAAHMIAAEFkZEVudW0AQWRkTWV0aG9kAEFkZFByb3BlcnR5AEF1dG9J"
    $sData &= "dE9iamVjdENyZWF0ZU9iamVjdABBdXRvSXRPYmplY3RDcmVhdGVPYmplY3RFeABDbG9uZUF1dG9JdE9iamVjdABDcmVhdGVBdXRvSXRPYmplY3QAQ3JlYXRlQXV0b0l0T2JqZWN0Q2xhc3MAQ3JlYXRlRGxsQ2FsbE9iamVjdABDcmVhdGVXcmFwcGVyT2JqZWN0AENyZWF0ZVdyYXBwZXJPYmplY3RFeABJVW5rbm93bkFkZFJlZgBJVW5rbm93blJlbGVhc2UASW5pdGlhbGl6ZQBNZW1vcnlDYWxsRW50cnkAUmVnaXN0ZXJPYmplY3QAUmVtb3ZlTWVtYmVyAFJldHVyblRoaXMAVW5SZWdpc3Rlck9iamVjdABXcmFwcGVyQWRkTWV0aG9kAAAAAQACAAMABAAFAAYABwAIAAkACgALAAwADQAOAA8AEAARABIAEwAAAAC8wgAAAAAAAAAAAABAwwAAvMIAANTCAAAAAAAAAAAAAEnDAADUwgAA5MIAAAAAAAAAAAAAYsMAAOTCAAD0wgAAAAAAAAAAAABvwwAA9MIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHMMAAAAAAAAvwwAAAAAAAAAAAAAAAAAAU8MAAAAAAAAAAAAAAAAAAIUAAAAAAACAAAAAAAAAAAB7wwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABHZXRNb2R1bGVIYW5kbGVBAAAAR2V0UHJvY0FkZHJlc3MAS0VSTkVMMzIAb2xlMzIuZGxsAAAAQ29Jbml0aWFsaXplAE9MRUFVVDMyLmRsbABTSExXQVBJLmRsbAAAAFN0clRvSW50NjRFeFcAV1ZTUVJBUEiNBd4KAABIizBIA/BIK8BIi/5mrcHgDEiLyFCtK8hIA/GLyFdEi8H/yYpEOQaIBDF19UFRVSvArIvIwekEUSQPUKyLyAIMJFBIx8UA/f//SNPlWVhIweAgSAPIWEiL3EiNpGyQ8f//UFFIK8lR" & _
            "UUiLzFFmixfB4gxSV0yNSQhJjUkIVlpIg+wg6MgAAABIi+NdQVleWoHqABAAACvJO8pzSovZrP/BPP91DYoGJP08FXXrrP/B6xc8jXUNigYkxzwFddqs/8HrBiT+POh1z1Fbg8EErQvAeAY7wnPB6wYDw3i7A8Irw4lG/OuySI09Bv///7DpqrjiCgAAq0iNBeIJAACLUAyLeAgL/3Q9SIswSAPwSCvySIveSItIFEgry3Qoi1AQSAPySAP+K8Ar0gvQrMHiB9DocvYL0AvSdAtIA9pIKQtIO/dy4UiNBZQJAADpigkAAEyJTCQgSIlUJBBTVVZXQVRBVUFWQVdIg+woM/ZMi/JIi8GNXgFMjWkMi0kIRIvTi9NMi/5B0+KLSAREit7T4kiLjCSgAAAARCvTK9OL7kSL44lUJAyLEEmJMYlUJAhIiTGLSAQDyroAAwAARIlUJBDT4omcJIAAAACJXCRwgcI2BwAAiVwkBHQNi8pJi/24AAQAAPNmq02Lzk0D8Iv+QYPI/4vOTTvOD4TKCAAAQQ+2AcHnCAPLC/hMA8uD+QV85Eg5tCSYAAAAD4aKCAAAi8VBi/e6CAAAAMHgBEEj8kG6AAAAAUhj2EhjxkgD2EU7wnMaTTvOD4Q/CAAAQQ+2AcHnCEHB4AgL+EmDwQFBD7dMXQBBi8DB6AsPr8E7+A+DtQEAAESLwLgACAAAQboBAAAAK8HB+AVmA8GLykEPttNmQYlEXQCLXCQIi0QkDEkjxyrLSNPqi8tI0+BIA9BIjQRSSMHgCYP9B0mNtAVsDgAAD4y7AAAAQYvESYvPSCvISIuEJJAAAAAPthwIA9tJY8JEi9tBgeMAAQAASWPTSAPQQYH4AAAAAXMaTTvOD4SIBwAAQQ+2AcHnCEHB4AgL+EmDwQEPt4xWAAIAAEGLwMHoCw+vwTv4cyhEi8C4AAgAAEUD0ivBwfgFZgPBZomEVgACAAAzwEQ72A+FmwAAAOsjRCvAK/gPt8FmwegFR41UEgFmK8gzwEQ7" & _
            "2GaJjFYAAgAAdHZBgfoAAQAAfXbpWv///0GB+AAAAAFJY9JzGk07zg+E9AYAAEEPtgHB5whBweAIC/hJg8EBD7cMVkGLwMHoCw+vwTv4cxlEi8C4AAgAACvBwfgFZgPBRQPSZokEVusYRCvAK/gPt8FmwegFR41UEgFmK8hmiQxWQYH6AAEAAHyPSIuEJJAAAABFitpGiBQ4SYPHAYP9BH0JM8CL6OljBgAAg/0KfQiD7QPpVgYAAIPtBulOBgAARCvAK/gPt8FmwegFSGPVZivIRTvCZkGJTF0AcyFNO84PhDwGAABBD7YBwecIQbsBAAAAC/hBweAITQPL6wZBuwEAAABBD7eMVYABAABBi8DB6AsPr8E7+HNRRIvAuAAIAAArwcH4BWYDwYP9B2ZBiYRVgAEAAItEJHBJjZVkBgAAiUQkBIuEJIAAAABEiaQkgAAAAIlEJHC4AwAAAI1Y/Q9Mw41rCOlOAgAARCvAK/gPt8FmwegFZivIRTvCZkGJjFWAAQAAcxlNO84PhJgFAABBD7YBwecIQcHgCAv4TQPLRQ+3lFWYAQAAQYvIwekLQQ+vyjv5D4PIAAAAuAAIAABEi8FBK8LB+AVmQQPCQboAAAABQTvKZkGJhFWYAQAAcxlNO84PhD4FAABBD7YBwecIQcHgCAv4TQPLQQ+3jF3gAQAAQYvAwegLD6/BO/hzVkSLwLgACAAAK8HB+AVmA8FmQYmEXeABAAAzwEw7+A+E9AQAAEiLlCSQAAAAuAsAAACD/QeNSP4PTMFJi8+L6EGLxEgryESKHApGiBw6SYPHAemnBAAARCvAK/gPt8FmwegFZivIZkGJjF3gAQAA6R4BAABBD7fCRCvBK/lmwegFZkQr0GZFiZRVmAEAAEG6AAAAAUU7wnMZTTvOD4R3BAAAQQ+2AcHnCEHB4AgL+E0Dy0EPt4xVsAEAAEGLwMHoCw+vwTv4cyVEi8C4AAgAACvBwfgFZgPBZkGJhFWwAQAAi4QkgAAAAOmaAAAARCvA"
    $sData &= "K/gPt8FmwegFZivIRTvCZkGJjFWwAQAAcxlNO84PhAYEAABBD7YBwecIQcHgCAv4TQPLQQ+3jFXIAQAAQYvAwegLD6/BO/hzH0SLwLgACAAAK8HB+AVmA8FmQYmEVcgBAACLRCRw6yREK8Ar+A+3wWbB6AVmK8iLRCQEZkGJjFXIAQAAi0wkcIlMJASLjCSAAAAAiUwkcESJpCSAAAAARIvgg/0HuAsAAABJjZVoCgAAjWj9D0zFM9tFO8KJBCRzGU07zg+EXwMAAEEPtgHB5whBweAIC/hNA8sPtwpBi8DB6AsPr8E7+HMlRIvAuAAIAABEi9MrwcH4BWYDwWaJAovGweADSGPITI1cSgTraEQrwCv4D7fBZsHoBWYryEU7wmaJCnMZTTvOD4T6AgAAQQ+2AcHnCEHB4AgL+E0Dyw+3SgJBi8DB6AsPr8E7+HMuRIvAuAAIAABEi9UrwcH4BWYDwWaJQgKLxsHgA0hjyEyNnEoEAQAAuwMAAADrIkQrwCv4D7fBZsHoBUyNmgQCAABBuhAAAABmK8iL3WaJSgKL870BAAAAQYH4AAAAAUhj1XMaTTvOD4RmAgAAQQ+2AcHnCEHB4AgL+EmDwQFBD7cMU0GLwMHoCw+vwTv4cxlEi8C4AAgAACvBwfgFZgPBA+1mQYkEU+sYRCvAK/gPt8FmwegFjWwtAWYryGZBiQxTg+4BdZKNRgGLy9PgRCvQiwQkQQPqg/gED42gAQAAg8AHg/0EjV4GiQQkjUYDjVYBD0zFweAGSJhNjZxFYAMAAEGB+AAAAAFMY9JzGk07zg+EvQEAAEEPtgHB5whBweAIC/hJg8EBQw+3DFNBi8DB6AsPr8E7+HMZRIvAuAAIAAArwcH4BWYDwQPSZkOJBFPrGEQrwCv4D7fBZsHoBY1UEgFmK8hmQ4kMU4PrAXWSg+pAg/oERIviD4z7AAAAQYPkAUSL0kHR+kGDzAJBg+oBg/oOfRlBi8pIY8JB0+RBi8xIK8hJjZxNXgUAAOtQQYPq" & _
            "BEGB+AAAAAFzGk07zg+EDwEAAEEPtgHB5whBweAIC/hJg8EBQdHoRQPkQTv4cgdBK/hBg8wBQYPqAXXFSY2dRAYAAEHB5ARBugQAAAC+AQAAAIvWQYH4AAAAAUxj2nMaTTvOD4S5AAAAQQ+2AcHnCEHB4AgL+EmDwQFCD7cMW0GLwMHoCw+vwTv4cxlEi8C4AAgAACvBwfgFZgPBA9JmQokEW+sbRCvAK/gPt8FmwegFjVQSAWYryEQL5mZCiQxbA/ZBg+oBdYxBg8QBdGBBi8SDxQJJY8xJO8d3RkiLlCSQAAAASYvHSCvBSAPCRIoYSIPAAUaIHDpJg8cBg+0BdApMO7wkmAAAAHLiiywkTDu8JJgAAABzFkSLVCQQ6ZT3//+4AQAAAOs4QYvD6zNBgfgAAAABcwlNO8505kmDwQFIi4QkiAAAAEwrTCR4TIkISIuEJKAAAABMiTgzwOsCi8NIg8QoQV9BXkFdQVxfXl1bw+nJnv//iUH///////8gAAAAABAAAACwAAAAAACAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" & _
            "AAAAAAAAAAAAAAAAAAABABAAAAAYAACAAAAAAAAAAAAAAAAAAAABAAEAAAAwAACAAAAAAAAAAAAAAAAAAAABAAkEAABIAAAAWNAAABgDAAAAAAAAAAAAABgDNAAAAFYAUwBfAFYARQBSAFMASQBPAE4AXwBJAE4ARgBPAAAAAAC9BO/+AAABAAIAAQAAAAQAAgABAAAABAAAAAAAAAAAAAQAAAACAAAAAAAAAAAAAAAAAAAAdgIAAAEAUwB0AHIAaQBuAGcARgBpAGwAZQBJAG4AZgBvAAAAUgIAAAEAMAA0ADAAOQAwADQAQgAwAAAAMAAIAAEARgBpAGwAZQBWAGUAcgBzAGkAbwBuAAAAAAAxAC4AMgAuADQALgAwAAAANAAIAAEAUAByAG8AZAB1AGMAdABWAGUAcgBzAGkAbwBuAAAAMQAuADIALgA0AC4AMAAAAHoAKQABAEYAaQBsAGUARABlAHMAYwByAGkAcAB0AGkAbwBuAAAAAABQAHIAbwB2AGkAZABlAHMAIABvAGIAagBlAGMAdAAgAGYAdQBuAGMAdABpAG8AbgBhAGwAaQB0AHkAIABmAG8AcgAgAEEAdQB0AG8ASQB0AAAAAAA6AA0AAQBQAHIAbwBkAHUAYwB0AE4AYQBtAGUAAAAAAEEAdQB0AG8ASQB0AE8AYgBqAGUAYwB0AAAAAABYABoAAQBMAGUAZwBhAGwAQwBvAHAAeQByAGkAZwBoAHQAAAAoAEMAKQAgAFQAaABlACAAQQB1AHQAbwBJAHQATwBiAGoAZQBjAHQALQBUAGUAYQBtAAAASgARAAEATwByAGkAZwBpAG4AYQBsAEYAaQBsAGUAbgBhAG0AZQAAAEEAdQB0AG8ASQB0AE8AYgBqAGUAYwB0AC4AZABsAGwAAAAAAHoAIwABAFQAaABlACAAQQB1AHQAbwBJAHQATwBiAGoAZQBjAHQALQBUAGUAYQBtAAAAAABtAG8AbgBvAGMAZQByAGUAcwAsACAAdAByAGEA"
    $sData &= "bgBjAGUAeAB4ACwAIABLAGkAcAAsACAAUAByAG8AZwBBAG4AZAB5AAAAAABEAAAAAQBWAGEAcgBGAGkAbABlAEkAbgBmAG8AAAAAACQABAAAAFQAcgBhAG4AcwBsAGEAdABpAG8AbgAAAAAACQSwBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=="
    Return __Au3Obj_Mem_Base64Decode($sData)
EndFunc   ;==>__Au3Obj_Mem_BinDll_X64

#endregion Embedded DLL
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#region DllStructCreate Wrapper

Func __Au3Obj_ObjStructMethod(ByRef $oSelf, $vParam1 = 0, $vParam2 = 0)
	Local $sMethod = $oSelf.__name__
	Local $tStructure = DllStructCreate($oSelf.__tag__, $oSelf.__pointer__)
	Local $vOut
	Switch @NumParams
		Case 1
			$vOut = DllStructGetData($tStructure, $sMethod)
		Case 2
			If $oSelf.__propcall__ Then
				$vOut = DllStructSetData($tStructure, $sMethod, $vParam1)
			Else
				$vOut = DllStructGetData($tStructure, $sMethod, $vParam1)
			EndIf
		Case 3
			$vOut = DllStructSetData($tStructure, $sMethod, $vParam2, $vParam1)
	EndSwitch
	If IsPtr($vOut) Then Return Number($vOut)
	Return $vOut
EndFunc   ;==>__Au3Obj_ObjStructMethod

Func __Au3Obj_ObjStructDestructor(ByRef $oSelf)
	If $oSelf.__new__ Then __Au3Obj_GlobalFree($oSelf.__pointer__)
EndFunc   ;==>__Au3Obj_ObjStructDestructor

Func __Au3Obj_ObjStructPointer(ByRef $oSelf, $vParam = Default)
	If $oSelf.__propcall__ Then Return SetError(1, 0, 0)
	If @NumParams = 1 Or IsKeyword($vParam) Then Return $oSelf.__pointer__
	Return Number(DllStructGetPtr(DllStructCreate($oSelf.__tag__, $oSelf.__pointer__), $vParam))
EndFunc   ;==>__Au3Obj_ObjStructPointer

#endregion DllStructCreate Wrapper
;--------------------------------------------------------------------------------------------------------------------------------------


;--------------------------------------------------------------------------------------------------------------------------------------
#region Public UDFs

Global Enum $ELTYPE_NOTHING, $ELTYPE_METHOD, $ELTYPE_PROPERTY
Global Enum $ELSCOPE_PUBLIC, $ELSCOPE_READONLY, $ELSCOPE_PRIVATE

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_AddDestructor
; Description ...: Adds a destructor to an AutoIt-object
; Syntax.........: _AutoItObject_AddDestructor(ByRef $oObject, $sAutoItFunc)
; Parameters ....: $oObject     - the object to modify
;                  $sAutoItFunc - the AutoIt-function wich represents this destructor.
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: monoceres (Andreas Karlsson)
; Modified.......:
; Remarks .......: Adding a method that will be called on object destruction. Can be called multiple times.
; Related .......: _AutoItObject_AddProperty, _AutoItObject_AddEnum, _AutoItObject_RemoveMember, _AutoItObject_AddMethod
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_AddDestructor(ByRef $oObject, $sAutoItFunc)
	Return _AutoItObject_AddMethod($oObject, "~", $sAutoItFunc, True)
EndFunc   ;==>_AutoItObject_AddDestructor

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_AddEnum
; Description ...: Adds an Enum to an AutoIt-object
; Syntax.........: _AutoItObject_AddEnum(ByRef $oObject, $sNextFunc, $sResetFunc [, $sSkipFunc = ''])
; Parameters ....: $oObject     - the object to modify
;                  $sNextFunc   - The function to be called to get the next entry
;                  $sResetFunc  - The function to be called to reset the enum
;                  $sSkipFunc   - [optional] The function to be called to skip elements (not supported by AutoIt)
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_AddMethod, _AutoItObject_AddProperty, _AutoItObject_RemoveMember
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_AddEnum(ByRef $oObject, $sNextFunc, $sResetFunc, $sSkipFunc = '')
	; Author: Prog@ndy
	If Not IsObj($oObject) Then Return SetError(2, 0, 0)
	DllCall($ghAutoItObjectDLL, "none", "AddEnum", "idispatch", $oObject, "wstr", $sNextFunc, "wstr", $sResetFunc, "wstr", $sSkipFunc)
	If @error Then Return SetError(1, @error, 0)
	Return True
EndFunc   ;==>_AutoItObject_AddEnum

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_AddMethod
; Description ...: Adds a method to an AutoIt-object
; Syntax.........: _AutoItObject_AddMethod(ByRef $oObject, $sName, $sAutoItFunc [, $fPrivate = False])
; Parameters ....: $oObject     - the object to modify
;                  $sName       - the name of the method to add
;                  $sAutoItFunc - the AutoIt-function wich represents this method.
;                  $fPrivate    - [optional] Specifies whether the function can only be called from within the object. (default: False)
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The first parameter of the AutoIt-function is always a reference to the object. ($oSelf)
;                  This parameter will automatically be added and must not be given in the call.
;                  The function called '__default__' is accesible without a name using brackets ($return = $oObject())
; Related .......: _AutoItObject_AddProperty, _AutoItObject_AddEnum, _AutoItObject_RemoveMember
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_AddMethod(ByRef $oObject, $sName, $sAutoItFunc, $fPrivate = False)
	; Author: Prog@ndy
	If Not IsObj($oObject) Then Return SetError(2, 0, 0)
	Local $iFlags = 0
	If $fPrivate Then $iFlags = $ELSCOPE_PRIVATE
	DllCall($ghAutoItObjectDLL, "none", "AddMethod", "idispatch", $oObject, "wstr", $sName, "wstr", $sAutoItFunc, 'dword', $iFlags)
	If @error Then Return SetError(1, @error, 0)
	Return True
EndFunc   ;==>_AutoItObject_AddMethod

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_AddProperty
; Description ...: Adds a property to an AutoIt-object
; Syntax.........: _AutoItObject_AddProperty(ByRef $oObject, $sName [, $iFlags = $ELSCOPE_PUBLIC [, $vData = ""]])
; Parameters ....: $oObject     - the object to modify
;                  $sName       - the name of the property to add
;                  $iFlags      - [optional] Specifies the access to the property
;                  $vData       - [optional] Initial data for the property
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: The property called '__default__' is accesible without a name using brackets ($value = $oObject())
;                  + $iFlags can be:
;                  |$ELSCOPE_PUBLIC   - The Property has public access.
;                  |$ELSCOPE_READONLY - The property is read-only and can only be changed from within the object.
;                  |$ELSCOPE_PRIVATE  - The property is private and can only be accessed from within the object.
;                  +
;                  + Initial default value for every new property is nothing (no value).
; Related .......: _AutoItObject_AddMethod, _AutoItObject_AddEnum, _AutoItObject_RemoveMember
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_AddProperty(ByRef $oObject, $sName, $iFlags = $ELSCOPE_PUBLIC, $vData = "")
	; Author: Prog@ndy
	Local Static $tStruct = DllStructCreate($__Au3Obj_tagVARIANT)
	If Not IsObj($oObject) Then Return SetError(2, 0, 0)
	Local $pData = 0
	If @NumParams = 4 Then
		$pData = DllStructGetPtr($tStruct)
		_AutoItObject_VariantInit($pData)
		$oObject.__bridge__(Number($pData)) = $vData
	EndIf
	DllCall($ghAutoItObjectDLL, "none", "AddProperty", "idispatch", $oObject, "wstr", $sName, 'dword', $iFlags, 'ptr', $pData)
	Local $error = @error
	If $pData Then _AutoItObject_VariantClear($pData)
	If $error Then Return SetError(1, $error, 0)
	Return True
EndFunc   ;==>_AutoItObject_AddProperty

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_Class
; Description ...: AutoItObject COM wrapper function
; Syntax.........: _AutoItObject_Class()
; Parameters ....:
; Return values .: Success      - object with defined:
;                   -methods:
;                  |	Create([$oParent = 0]) - creates AutoItObject object
;                  |	AddMethod($sName, $sAutoItFunc [, $fPrivate = False]) - adds new method
;                  |	AddProperty($sName, $iFlags = $ELSCOPE_PUBLIC, $vData = 0) - adds new property
;                  |	AddDestructor($sAutoItFunc) - adds destructor
;                  |	AddEnum($sNextFunc, $sResetFunc [, $sSkipFunc = '']) - adds enum
;                  |	RemoveMember($sMember) - removes member
;                   -properties:
;                  |	Object - readonly property representing the last created AutoItObject object
; Author ........: trancexx
; Modified.......:
; Remarks .......: "Object" propery can be accessed only once for one object. After that new AutoItObject object is created.
;                  +Method "Create" will discharge previous AutoItObject object and create a new one.
; Related .......: _AutoItObject_Create
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_Class()
	Local $aCall = DllCall($ghAutoItObjectDLL, "idispatch", "CreateAutoItObjectClass")
	If @error Then Return SetError(1, @error, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_Class

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_CLSIDFromString
; Description ...: Converts a string to a CLSID-Struct (GUID-Struct)
; Syntax.........: _AutoItObject_CLSIDFromString($sString)
; Parameters ....: $sString     - The string to convert
; Return values .: Success      - DLLStruct in format $tagGUID
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_CoCreateInstance
; Link ..........: http://msdn.microsoft.com/en-us/library/ms680589(VS.85).aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_CLSIDFromString($sString)
	Local $tCLSID = DllStructCreate("dword;word;word;byte[8]")
	Local $aResult = DllCall($gh_AU3Obj_ole32dll, 'long', 'CLSIDFromString', 'wstr', $sString, 'ptr', DllStructGetPtr($tCLSID))
	If @error Then Return SetError(1, @error, 0)
	If $aResult[0] <> 0 Then Return SetError(2, $aResult[0], 0)
	Return $tCLSID
EndFunc   ;==>_AutoItObject_CLSIDFromString

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_CoCreateInstance
; Description ...: Creates a single uninitialized object of the class associated with a specified CLSID.
; Syntax.........: _AutoItObject_CoCreateInstance($rclsid, $pUnkOuter, $dwClsContext, $riid, ByRef $ppv)
; Parameters ....: $rclsid       - The CLSID associated with the data and code that will be used to create the object.
;                  $pUnkOuter    - If NULL, indicates that the object is not being created as part of an aggregate.
;                  +If non-NULL, pointer to the aggregate object's IUnknown interface (the controlling IUnknown).
;                  $dwClsContext - Context in which the code that manages the newly created object will run.
;                  +The values are taken from the enumeration CLSCTX.
;                  $riid         - A reference to the identifier of the interface to be used to communicate with the object.
;                  $ppv          - [out byref] Variable that receives the interface pointer requested in riid.
;                  +Upon successful return, *ppv contains the requested interface pointer. Upon failure, *ppv contains NULL.
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_ObjCreate, _AutoItObject_CLSIDFromString
; Link ..........: http://msdn.microsoft.com/en-us/library/ms686615(VS.85).aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_CoCreateInstance($rclsid, $pUnkOuter, $dwClsContext, $riid, ByRef $ppv)
	$ppv = 0
	Local $aResult = DllCall($gh_AU3Obj_ole32dll, 'long', 'CoCreateInstance', 'ptr', $rclsid, 'ptr', $pUnkOuter, 'dword', $dwClsContext, 'ptr', $riid, 'ptr*', 0)
	If @error Then Return SetError(1, @error, 0)
	$ppv = $aResult[5]
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_AutoItObject_CoCreateInstance

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_Create
; Description ...: Creates an AutoIt-object
; Syntax.........: _AutoItObject_Create( [$oParent = 0] )
; Parameters ....: $oParent     - [optional] an AutoItObject whose methods & properties are copied. (default: 0)
; Return values .: Success      - AutoIt-Object
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_Class
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_Create($oParent = 0)
	; Author: Prog@ndy
	Local $aResult
	Switch IsObj($oParent)
		Case True
			$aResult = DllCall($ghAutoItObjectDLL, "idispatch", "CloneAutoItObject", 'idispatch', $oParent)
		Case Else
			$aResult = DllCall($ghAutoItObjectDLL, "idispatch", "CreateAutoItObject")
	EndSwitch
	If @error Then Return SetError(1, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_AutoItObject_Create

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_DllOpen
; Description ...: Creates an object associated with specified dll
; Syntax.........: _AutoItObject_DllOpen($sDll [, $sTag = "" [, $iFlag = 0]])
; Parameters ....: $sDll - Dll for which to create an object
;                  $sTag - [optional] String representing function return value and parameters.
;                  $iFlag - [optional] Flag specifying the level of loading. See MSDN about LoadLibraryEx function for details. Default is 0.
; Return values .: Success      - Dispatch-Object
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_WrapperCreate
; Link ..........: http://msdn.microsoft.com/en-us/library/ms684179(VS.85).aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_DllOpen($sDll, $sTag = "", $iFlag = 0)
	Local $sTypeTag = "wstr"
	If $sTag = Default Or Not $sTag Then $sTypeTag = "ptr"
	Local $aCall = DllCall($ghAutoItObjectDLL, "idispatch", "CreateDllCallObject", "wstr", $sDll, $sTypeTag, __Au3Obj_GetMethods($sTag), "dword", $iFlag)
	If @error Or Not IsObj($aCall[0]) Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_DllOpen

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_DllStructCreate
; Description ...: Object wrapper for DllStructCreate and related functions
; Syntax.........: _AutoItObject_DllStructCreate($sTag [, $vParam = 0])
; Parameters ....: $sTag     - A string representing the structure to create (same as with DllStructCreate)
;                  $vParam   - [optional] If this parameter is DLLStruct type then it will be copied to newly allocated space and maintained during lifetime of the object. If this parameter is not suplied needed memory allocation is done but content is initialized to zero. In all other cases function will not allocate memory but use parameter supplied as the pointer (same as DllStructCreate)
; Return values .: Success      - Object-structure
;                  Failure      - 0, @error is set to error value of DllStructCreate() function.
; Author ........: trancexx
; Modified.......:
; Remarks .......: AutoIt can't handle pointers properly when passed to or returned from object methods. Use Number() function on pointers before using them with this function.
;                  +Every element of structure must be named. Values are accessed through their names.
;                  +Created object exposes:
;                  +  - set of dynamic methods in names of elements of the structure
;                  +  - readonly properties:
;                  |	__tag__ - a string representing the object-structure
;                  |	__size__ - the size of the struct in bytes
;                  |	__alignment__ - alignment string (e.g. "align 2")
;                  |	__count__ - number of elements of structure
;                  |	__elements__ - string made of element names separated by semicolon (;)
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_DllStructCreate($sTag, $vParam = 0)
	Local $fNew = False
	Local $tSubStructure = DllStructCreate($sTag)
	If @error Then Return SetError(@error, 0, 0)
	Local $iSize = DllStructGetSize($tSubStructure)
	Local $pPointer = $vParam
	Select
		Case @NumParams = 1
			; Will allocate fixed 128 extra bytes due to possible misalignment and other issues
			$pPointer = __Au3Obj_GlobalAlloc($iSize + 128, 64) ; GPTR
			If @error Then Return SetError(3, 0, 0)
			$fNew = True
		Case IsDllStruct($vParam)
			$pPointer = __Au3Obj_GlobalAlloc($iSize, 64) ; GPTR
			If @error Then Return SetError(3, 0, 0)
			$fNew = True
			DllStructSetData(DllStructCreate("byte[" & $iSize & "]", $pPointer), 1, DllStructGetData(DllStructCreate("byte[" & $iSize & "]", DllStructGetPtr($vParam)), 1))
		Case @NumParams = 2 And $vParam = 0
			Return SetError(3, 0, 0)
	EndSelect
	Local $sAlignment
	Local $sNamesString = __Au3Obj_ObjStructGetElements($sTag, $sAlignment)
	Local $aElements = StringSplit($sNamesString, ";", 2)
	Local $oObj = _AutoItObject_Class()
	For $i = 0 To UBound($aElements) - 1
		$oObj.AddMethod($aElements[$i], "__Au3Obj_ObjStructMethod")
	Next
	$oObj.AddProperty("__tag__", $ELSCOPE_READONLY, $sTag)
	$oObj.AddProperty("__size__", $ELSCOPE_READONLY, $iSize)
	$oObj.AddProperty("__alignment__", $ELSCOPE_READONLY, $sAlignment)
	$oObj.AddProperty("__count__", $ELSCOPE_READONLY, UBound($aElements))
	$oObj.AddProperty("__elements__", $ELSCOPE_READONLY, $sNamesString)
	$oObj.AddProperty("__new__", $ELSCOPE_PRIVATE, $fNew)
	$oObj.AddProperty("__pointer__", $ELSCOPE_READONLY, Number($pPointer))
	$oObj.AddMethod("__default__", "__Au3Obj_ObjStructPointer")
	$oObj.AddDestructor("__Au3Obj_ObjStructDestructor")
	Return $oObj.Object
EndFunc   ;==>_AutoItObject_DllStructCreate

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_IDispatchToPtr
; Description ...: Returns pointer to AutoIt's object type
; Syntax.........: _AutoItObject_IDispatchToPtr(ByRef $oIDispatch)
; Parameters ....: $oIDispatch  - Object
; Return values .: Success      - Pointer to object
;                  Failure      - 0
; Author ........: monoceres, trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_PtrToIDispatch, _AutoItObject_CoCreateInstance, _AutoItObject_ObjCreate
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_IDispatchToPtr($oIDispatch)
	Local $aCall = DllCall($ghAutoItObjectDLL, "ptr", "ReturnThis", "idispatch", $oIDispatch)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_IDispatchToPtr

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_IUnknownAddRef
; Description ...: Increments the refrence count of an IUnknown-Object
; Syntax.........: _AutoItObject_IUnknownAddRef($vUnknown)
; Parameters ....: $vUnknown    - IUnkown-pointer or object itself
; Return values .: Success      - New reference count.
;                  Failure      - 0, @error is set.
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_IUnknownRelease
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_IUnknownAddRef(Const $vUnknown)
	; Author: Prog@ndy
	Local $sType = "ptr"
	If IsObj($vUnknown) Then $sType = "idispatch"
	Local $aCall = DllCall($ghAutoItObjectDLL, "dword", "IUnknownAddRef", $sType, $vUnknown)
	If @error Then Return SetError(1, @error, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_IUnknownAddRef

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_IUnknownRelease
; Description ...: Decrements the refrence count of an IUnknown-Object
; Syntax.........: _AutoItObject_IUnknownRelease($vUnknown)
; Parameters ....: $vUnknown    - IUnkown-pointer or object itself
; Return values .: Success      - New reference count.
;                  Failure      - 0, @error is set.
; Author ........: trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_IUnknownAddRef
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_IUnknownRelease(Const $vUnknown)
	Local $sType = "ptr"
	If IsObj($vUnknown) Then $sType = "idispatch"
	Local $aCall = DllCall($ghAutoItObjectDLL, "dword", "IUnknownRelease", $sType, $vUnknown)
	If @error Then Return SetError(1, @error, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_IUnknownRelease

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_ObjCreate
; Description ...: Creates a reference to a COM object
; Syntax.........: _AutoItObject_ObjCreate($sID [, $sRefId = Default [, $tagInterface = Default ]] )
; Parameters ....: $sID - Object identifier. Either string representation of CLSID or ProgID
;                  $sRefId - [optional] String representation of the identifier of the interface to be used to communicate with the object. Default is the value of IDispatch
;                  $tagInterface - [optional] String defining the methods of the Interface, see Remarks for _AutoItObject_WrapperCreate function for details
; Return values .: Success      - Dispatch-Object
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......: Prefix object identifier with "cbi:" to create object from ROT.
; Related .......: _AutoItObject_ObjCreateEx, _AutoItObject_WrapperCreate
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_ObjCreate($sID, $sRefId = Default, $tagInterface = Default)
	Local $sTypeRef = "wstr"
	If $sRefId = Default Or Not $sRefId Then $sTypeRef = "ptr"
	Local $sTypeTag = "wstr"
	If $tagInterface = Default Or Not $tagInterface Then $sTypeTag = "ptr"
	Local $aCall = DllCall($ghAutoItObjectDLL, "idispatch", "AutoItObjectCreateObject", "wstr", $sID, $sTypeRef, $sRefId, $sTypeTag, __Au3Obj_GetMethods($tagInterface))
	If @error Or Not IsObj($aCall[0]) Then Return SetError(1, 0, 0)
	If $sTypeRef = "ptr" And $sTypeTag = "ptr" Then _AutoItObject_IUnknownRelease($aCall[0])
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_ObjCreate

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_ObjCreateEx
; Description ...: Creates a reference to a COM object
; Syntax.........: _AutoItObject_ObjCreateEx($sModule, $sCLSID [, $sRefId = Default [, $tagInterface = Default [, $fWrapp = False]]] )
; Parameters ....: $sModule - Full path to the module with class (object)
;                  $sCLSID - Object identifier. String representation of CLSID.
;                  $sRefId - [optional] String representation of the identifier of the interface to be used to communicate with the object. Default is the value of IDispatch
;                  $tagInterface - [optional] String defining the methods of the Interface, see Remarks for _AutoItObject_WrapperCreate function for details
;                  $fWrapped - [optional] Specifies whether to wrapp created object.
; Return values .: Success      - Dispatch-Object
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......: This function doesn't require any additional registration of the classes and interaces supported in the server module.
;                 +In case $tagInterface is specified $fWrapp parameter is ignored.
;                 +If $sRefId is left default then first supported interface by the coclass is returned (the default dispatch).
;                 +If used to for ROT objects $sModule parameter represents the full path to the sercer (any form: exe, a3x or au3). Default time-out value for the function is 3000ms in that case.
;                 +If required object isn't created in that time function will return failure. This function sends "/StartServer" command to the server to initialize it.
; Related .......: _AutoItObject_ObjCreate, _AutoItObject_WrapperCreate
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_ObjCreateEx($sModule, $sID, $sRefId = Default, $tagInterface = Default, $fWrapp = False, $iTimeOut = Default)
	Local $sTypeRef = "wstr"
	If $sRefId = Default Or Not $sRefId Then $sTypeRef = "ptr"
	Local $sTypeTag = "wstr"
	If $tagInterface = Default Or Not $tagInterface Then
		$sTypeTag = "ptr"
	Else
		$fWrapp = True
	EndIf
	If $iTimeOut = Default Then $iTimeOut = 0
	Local $aCall = DllCall($ghAutoItObjectDLL, "idispatch", "AutoItObjectCreateObjectEx", "wstr", $sModule, "wstr", $sID, $sTypeRef, $sRefId, $sTypeTag, __Au3Obj_GetMethods($tagInterface), "bool", $fWrapp, "dword", $iTimeOut)
	If @error Or Not IsObj($aCall[0]) Then Return SetError(1, 0, 0)
	If Not $fWrapp Then _AutoItObject_IUnknownRelease($aCall[0])
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_ObjCreateEx

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_ObjectFromDtag
; Description ...: Creates custom object defined with "dtag" interface description string
; Syntax.........: _AutoItObject_ObjectFromDtag($sFunctionPrefix, $dtagInterface [, $fNoUnknown = False])
; Parameters ....: $sFunctionPrefix  - The prefix of the functions you define as object methods
;                  $dtagInterface - string describing the interface (dtag)
;                  $fNoUnknown - [optional] NOT an IUnkown-Interface. Do not call "Release" method when out of scope (Default: False, meaining to call Release method)
; Return values .: Success      - object type
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......: Main purpose of this function is to create custom objects that serve as event handlers for other objects.
;                  +Registered callback functions (defined methods) are left for AutoIt to free at its convenience on exit.
; Related .......: _AutoItObject_ObjCreate, _AutoItObject_ObjCreateEx, _AutoItObject_WrapperCreate
; Link ..........: http://msdn.microsoft.com/en-us/library/ms692727(VS.85).aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_ObjectFromDtag($sFunctionPrefix, $dtagInterface, $fNoUnknown = False)
	Local $sMethods = __Au3Obj_GetMethods($dtagInterface)
	$sMethods = StringReplace(StringReplace(StringReplace(StringReplace($sMethods, "object", "idispatch"), "variant*", "ptr"), "hresult", "long"), "bstr", "ptr")
	Local $aMethods = StringSplit($sMethods, @LF, 3)
	Local $iUbound = UBound($aMethods)
	Local $sMethod, $aSplit, $sNamePart, $aTagPart, $sTagPart, $sRet, $sParams
	; Allocation. Read http://msdn.microsoft.com/en-us/library/ms810466.aspx to see why like this (object + methods):
	Local $tInterface = DllStructCreate("ptr[" & $iUbound + 1 & "]", __Au3Obj_CoTaskMemAlloc($__Au3Obj_PTR_SIZE * ($iUbound + 1)))
	If @error Then Return SetError(1, 0, 0)
	For $i = 0 To $iUbound - 1
		$aSplit = StringSplit($aMethods[$i], "|", 2)
		If UBound($aSplit) <> 2 Then ReDim $aSplit[2]
		$sNamePart = $aSplit[0]
		$sTagPart = $aSplit[1]
		$sMethod = $sFunctionPrefix & $sNamePart
		$aTagPart = StringSplit($sTagPart, ";", 2)
		$sRet = $aTagPart[0]
		$sParams = StringReplace($sTagPart, $sRet, "", 1)
		$sParams = "ptr" & $sParams
		DllStructSetData($tInterface, 1, DllCallbackGetPtr(DllCallbackRegister($sMethod, $sRet, $sParams)), $i + 2) ; Freeing is left to AutoIt.
	Next
	DllStructSetData($tInterface, 1, DllStructGetPtr($tInterface) + $__Au3Obj_PTR_SIZE) ; Interface method pointers are actually pointer size away
	Return _AutoItObject_WrapperCreate(DllStructGetPtr($tInterface), $dtagInterface, $fNoUnknown, True) ; and first pointer is object pointer that's wrapped
EndFunc   ;==>_AutoItObject_ObjectFromDtag

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_PtrToIDispatch
; Description ...: Converts IDispatch pointer to AutoIt's object type
; Syntax.........: _AutoItObject_PtrToIDispatch($pIDispatch)
; Parameters ....: $pIDispatch  - IDispatch pointer
; Return values .: Success      - object type
;                  Failure      - 0
; Author ........: monoceres, trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_IDispatchToPtr, _AutoItObject_WrapperCreate
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_PtrToIDispatch($pIDispatch)
	Local $aCall = DllCall($ghAutoItObjectDLL, "idispatch", "ReturnThis", "ptr", $pIDispatch)
	If @error Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_PtrToIDispatch

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_RegisterObject
; Description ...: Registers the object to ROT
; Syntax.........: _AutoItObject_RegisterObject($vObject, $sID)
; Parameters ....: $vObject - Object or object pointer.
;                  $sID - Object's desired identifier.
; Return values .: Success      - Handle of the ROT object.
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_UnregisterObject
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_RegisterObject($vObject, $sID)
	Local $sTypeObj = "ptr"
	If IsObj($vObject) Then $sTypeObj = "idispatch"
	Local $aCall = DllCall($ghAutoItObjectDLL, "dword", "RegisterObject", $sTypeObj, $vObject, "wstr", $sID)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_RegisterObject

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_RemoveMember
; Description ...: Removes a property or a function from an AutoIt-object
; Syntax.........: _AutoItObject_RemoveMember(ByRef $oObject, $sMember)
; Parameters ....: $oObject     - the object to modify
;                  $sMember     - the name of the member to remove
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_AddMethod, _AutoItObject_AddProperty, _AutoItObject_AddEnum
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_RemoveMember(ByRef $oObject, $sMember)
	; Author: Prog@ndy
	If Not IsObj($oObject) Then Return SetError(2, 0, 0)
	If $sMember = '__default__' Then Return SetError(3, 0, 0)
	DllCall($ghAutoItObjectDLL, "none", "RemoveMember", "idispatch", $oObject, "wstr", $sMember)
	If @error Then Return SetError(1, @error, 0)
	Return True
EndFunc   ;==>_AutoItObject_RemoveMember

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_Shutdown
; Description ...: frees the AutoItObject DLL
; Syntax.........: _AutoItObject_Shutdown()
; Parameters ....: $fFinal    - [optional] Force shutdown of the library? (Default: False)
; Return values .: Remaining reference count (one for each call to _AutoItObject_Startup)
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: Usage of this function is optonal. The World wouldn't end without it.
; Related .......: _AutoItObject_Startup
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_Shutdown($fFinal = False)
	; Author: Prog@ndy
	If $giAutoItObjectDLLRef <= 0 Then Return 0
	$giAutoItObjectDLLRef -= 1
	If $fFinal Then $giAutoItObjectDLLRef = 0
	If $giAutoItObjectDLLRef = 0 Then DllCall($ghAutoItObjectDLL, "ptr", "Initialize", "ptr", 0, "ptr", 0)
	Return $giAutoItObjectDLLRef
EndFunc   ;==>_AutoItObject_Shutdown

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_Startup
; Description ...: Initializes AutoItObject
; Syntax.........: _AutoItObject_Startup( [$fLoadDLL = False [, $sDll = "AutoitObject.dll"]] )
; Parameters ....: $fLoadDLL    - [optional] specifies whether an external DLL-file should be used (default: False)
;                  $sDLL        - [optional] the path to the external DLL (default: AutoitObject.dll or AutoitObject_X64.dll)
; Return values .: Success      - True
;                  Failure      - False
; Author ........: trancexx, Prog@ndy
; Modified.......:
; Remarks .......: Automatically switches between 32bit and 64bit mode if no special DLL is specified.
; Related .......: _AutoItObject_Shutdown
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_Startup($fLoadDLL = False, $sDll = "AutoitObject.dll")
	Local Static $__Au3Obj_FunctionProxy = DllCallbackGetPtr(DllCallbackRegister("__Au3Obj_FunctionProxy", "int", "wstr;idispatch"))
	Local Static $__Au3Obj_EnumFunctionProxy = DllCallbackGetPtr(DllCallbackRegister("__Au3Obj_EnumFunctionProxy", "int", "dword;wstr;idispatch;ptr;ptr"))
	If $ghAutoItObjectDLL = -1 Then
		If $fLoadDLL Then
			If $__Au3Obj_X64 And @NumParams = 1 Then $sDll = "AutoItObject_X64.dll"
			$ghAutoItObjectDLL = DllOpen($sDll)
		Else
			$ghAutoItObjectDLL = __Au3Obj_Mem_DllOpen()
		EndIf
		If $ghAutoItObjectDLL = -1 Then Return SetError(1, 0, False)
	EndIf
	If $giAutoItObjectDLLRef <= 0 Then
		$giAutoItObjectDLLRef = 0
		DllCall($ghAutoItObjectDLL, "ptr", "Initialize", "ptr", $__Au3Obj_FunctionProxy, "ptr", $__Au3Obj_EnumFunctionProxy)
		If @error Then
			DllClose($ghAutoItObjectDLL)
			$ghAutoItObjectDLL = -1
			Return SetError(2, 0, False)
		EndIf
	EndIf
	$giAutoItObjectDLLRef += 1
	Return True
EndFunc   ;==>_AutoItObject_Startup

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_UnregisterObject
; Description ...: Unregisters the object from ROT
; Syntax.........: _AutoItObject_UnregisterObject($iHandle)
; Parameters ....: $iHandle - Object's ROT handle as returned by _AutoItObject_RegisterObject function.
; Return values .: Success      - 1
;                  Failure      - 0
; Author ........: trancexx
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_RegisterObject
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_UnregisterObject($iHandle)
	Local $aCall = DllCall($ghAutoItObjectDLL, "dword", "UnRegisterObject", "dword", $iHandle)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, 0)
	Return 1
EndFunc   ;==>_AutoItObject_RegisterObject

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantClear
; Description ...: Clears the value of a variant
; Syntax.........: _AutoItObject_VariantClear($pvarg)
; Parameters ....: $pvarg       - the VARIANT to clear
; Return values .: Success      - 0
;                  Failure      - nonzero
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_VariantFree
; Link ..........: http://msdn.microsoft.com/en-us/library/ms221165.aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantClear($pvarg)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "VariantClear", "ptr", $pvarg)
	If @error Then Return SetError(1, 0, 1)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_VariantClear

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantCopy
; Description ...: Copies a VARIANT to another
; Syntax.........: _AutoItObject_VariantCopy($pvargDest, $pvargSrc)
; Parameters ....: $pvargDest   - Destionation variant
;                  $pvargSrc    - Source variant
; Return values .: Success      - 0
;                  Failure      - nonzero
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_VariantRead
; Link ..........: http://msdn.microsoft.com/en-us/library/ms221697.aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantCopy($pvargDest, $pvargSrc)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "VariantCopy", "ptr", $pvargDest, 'ptr', $pvargSrc)
	If @error Then Return SetError(1, 0, 1)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_VariantCopy

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantFree
; Description ...: Frees a variant created by _AutoItObject_VariantSet
; Syntax.........: _AutoItObject_VariantFree($pvarg)
; Parameters ....: $pvarg       - the VARIANT to free
; Return values .: Success      - 0
;                  Failure      - nonzero
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: Use this function on variants created with _AutoItObject_VariantSet function (when first parameter for that function is 0).
; Related .......: _AutoItObject_VariantClear
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantFree($pvarg)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "VariantClear", "ptr", $pvarg)
	If @error Then Return SetError(1, 0, 1)
	If $aCall[0] = 0 Then __Au3Obj_CoTaskMemFree($pvarg)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_VariantFree

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantInit
; Description ...: Initializes a variant.
; Syntax.........: _AutoItObject_VariantInit($pvarg)
; Parameters ....: $pvarg       - the VARIANT to initialize
; Return values .: Success      - 0
;                  Failure      - nonzero
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_VariantClear
; Link ..........: http://msdn.microsoft.com/en-us/library/ms221402.aspx
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantInit($pvarg)
	; Author: Prog@ndy
	Local $aCall = DllCall($gh_AU3Obj_oleautdll, "long", "VariantInit", "ptr", $pvarg)
	If @error Then Return SetError(1, 0, 1)
	Return $aCall[0]
EndFunc   ;==>_AutoItObject_VariantInit

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantRead
; Description ...: Reads the value of a VARIANT
; Syntax.........: _AutoItObject_VariantRead($pVariant)
; Parameters ....: $pVariant    - Pointer to VARaINT-structure
; Return values .: Success      - value of the VARIANT
;                  Failure      - 0
; Author ........: monoceres, Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_VariantSet
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantRead($pVariant)
	; Author: monoceres, Prog@ndy
	Local $var = DllStructCreate($__Au3Obj_tagVARIANT, $pVariant), $data
	; Translate the vt id to a autoit dllcall type
	Local $VT = DllStructGetData($var, "vt"), $type
	Switch $VT
		Case $__Au3Obj_VT_I1, $__Au3Obj_VT_UI1
			$type = "byte"
		Case $__Au3Obj_VT_I2
			$type = "short"
		Case $__Au3Obj_VT_I4
			$type = "int"
		Case $__Au3Obj_VT_I8
			$type = "int64"
		Case $__Au3Obj_VT_R4
			$type = "float"
		Case $__Au3Obj_VT_R8
			$type = "double"
		Case $__Au3Obj_VT_UI2
			$type = 'word'
		Case $__Au3Obj_VT_UI4
			$type = 'uint'
		Case $__Au3Obj_VT_UI8
			$type = 'uint64'
		Case $__Au3Obj_VT_BSTR
			Return __Au3Obj_SysReadString(DllStructGetData($var, "data"))
		Case $__Au3Obj_VT_BOOL
			$type = 'short'
		Case BitOR($__Au3Obj_VT_ARRAY, $__Au3Obj_VT_UI1)
			Local $pSafeArray = DllStructGetData($var, "data")
			Local $bound, $pData, $lbound
			If 0 = __Au3Obj_SafeArrayGetUBound($pSafeArray, 1, $bound) Then
				__Au3Obj_SafeArrayGetLBound($pSafeArray, 1, $lbound)
				$bound += 1 - $lbound
				If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
					Local $tData = DllStructCreate("byte[" & $bound & "]", $pData)
					$data = DllStructGetData($tData, 1)
					__Au3Obj_SafeArrayUnaccessData($pSafeArray)
				EndIf
			EndIf
			Return $data
		Case BitOR($__Au3Obj_VT_ARRAY, $__Au3Obj_VT_VARIANT)
			Return __Au3Obj_ReadSafeArrayVariant(DllStructGetData($var, "data"))
		Case $__Au3Obj_VT_DISPATCH
			Return _AutoItObject_PtrToIDispatch(DllStructGetData($var, "data"))
		Case $__Au3Obj_VT_PTR
			Return DllStructGetData($var, "data")
		Case $__Au3Obj_VT_ERROR
			Return Default
		Case Else
			_AutoItObject_VariantClear($pVariant)
			Return SetError(1, 0, '')
	EndSwitch

	$data = DllStructCreate($type, DllStructGetPtr($var, "data"))

	Switch $VT
		Case $__Au3Obj_VT_BOOL
			Return DllStructGetData($data, 1) <> 0
	EndSwitch
	Return DllStructGetData($data, 1)

EndFunc   ;==>_AutoItObject_VariantRead

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_VariantSet
; Description ...: sets the value of a varaint or creates a new one.
; Syntax.........: _AutoItObject_VariantSet($pVar, $vVal, $iSpecialType = 0)
; Parameters ....: $pVar        - Pointer to the VARIANT to modify (0 if you want to create it new)
;                  $vVal        - Value of the VARIANT
;                  $iSpecialType - [optional] Modify the automatic type. NOT FOR GENERAL USE!
; Return values .: Success      - Pointer to the VARIANT
;                  Failure      - 0
; Author ........: monoceres, Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_VariantRead
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_VariantSet($pVar, $vVal, $iSpecialType = 0)
	; Author: monoceres, Prog@ndy
	If Not $pVar Then
		$pVar = __Au3Obj_CoTaskMemAlloc($__Au3Obj_VARIANT_SIZE)
		_AutoItObject_VariantInit($pVar)
	Else
		_AutoItObject_VariantClear($pVar)
	EndIf
	Local $tVar = DllStructCreate($__Au3Obj_tagVARIANT, $pVar)
	Local $iType = $__Au3Obj_VT_EMPTY, $vDataType = ''

	Switch VarGetType($vVal)
		Case "Int32"
			$iType = $__Au3Obj_VT_I4
			$vDataType = 'int'
		Case "Int64"
			$iType = $__Au3Obj_VT_I8
			$vDataType = 'int64'
		Case "String", 'Text'
			$iType = $__Au3Obj_VT_BSTR
			$vDataType = 'ptr'
			$vVal = __Au3Obj_SysAllocString($vVal)
		Case "Double"
			$vDataType = 'double'
			$iType = $__Au3Obj_VT_R8
		Case "Float"
			$vDataType = 'float'
			$iType = $__Au3Obj_VT_R4
		Case "Bool"
			$vDataType = 'short'
			$iType = $__Au3Obj_VT_BOOL
			If $vVal Then
				$vVal = 0xffff
			Else
				$vVal = 0
			EndIf
		Case 'Ptr'
			If $__Au3Obj_X64 Then
				$iType = $__Au3Obj_VT_UI8
			Else
				$iType = $__Au3Obj_VT_UI4
			EndIf
			$vDataType = 'ptr'
		Case 'Object'
			_AutoItObject_IUnknownAddRef($vVal)
			$vDataType = 'ptr'
			$iType = $__Au3Obj_VT_DISPATCH
		Case "Binary"
			; ARRAY OF BYTES !
			Local $tSafeArrayBound = DllStructCreate($__Au3Obj_tagSAFEARRAYBOUND)
			DllStructSetData($tSafeArrayBound, 1, BinaryLen($vVal))
			Local $pSafeArray = __Au3Obj_SafeArrayCreate($__Au3Obj_VT_UI1, 1, DllStructGetPtr($tSafeArrayBound))
			Local $pData
			If 0 = __Au3Obj_SafeArrayAccessData($pSafeArray, $pData) Then
				Local $tData = DllStructCreate("byte[" & BinaryLen($vVal) & "]", $pData)
				DllStructSetData($tData, 1, $vVal)
				__Au3Obj_SafeArrayUnaccessData($pSafeArray)
				$vVal = $pSafeArray
				$vDataType = 'ptr'
				$iType = BitOR($__Au3Obj_VT_ARRAY, $__Au3Obj_VT_UI1)
			EndIf
		Case "Array"
			$vDataType = 'ptr'
			$vVal = __Au3Obj_CreateSafeArrayVariant($vVal)
			$iType = BitOR($__Au3Obj_VT_ARRAY, $__Au3Obj_VT_VARIANT)
		Case Else ;"Keyword" ; all keywords and unknown Vartypes will be handled as "default"
			$iType = $__Au3Obj_VT_ERROR
			$vDataType = 'int'
	EndSwitch
	If $vDataType Then
		DllStructSetData(DllStructCreate($vDataType, DllStructGetPtr($tVar, 'data')), 1, $vVal)

		If @NumParams = 3 Then $iType = $iSpecialType
		DllStructSetData($tVar, 'vt', $iType)
	EndIf
	Return $pVar
EndFunc   ;==>_AutoItObject_VariantSet

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_WrapperAddMethod
; Description ...: Adds additional methods to the Wrapper-Object, e.g if you want alternative parameter types
; Syntax.........: _AutoItObject_WrapperAddMethod(ByRef $oWrapper, $sReturnType, $sName, $sParamTypes, $ivtableIndex)
; Parameters ....: $oWrapper     - The Object you want to modify
;                  $sReturnType  - the return type of the function
;                  $sName        - The name of the function
;                  $sParamTypes  - the parameter types
;                  $ivTableIndex - Index of the function in the object's vTable
; Return values .: Success      - True
;                  Failure      - 0
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......:
; Related .......: _AutoItObject_WrapperCreate
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_WrapperAddMethod(ByRef $oWrapper, $sReturnType, $sName, $sParamTypes, $ivtableIndex)
	; Author: Prog@ndy
	If Not IsObj($oWrapper) Then Return SetError(2, 0, 0)
	DllCall($ghAutoItObjectDLL, "none", "WrapperAddMethod", 'idispatch', $oWrapper, 'wstr', $sName, "wstr", StringRegExpReplace($sReturnType & ';' & $sParamTypes, "\s|(;+\Z)", ''), 'dword', $ivtableIndex)
	If @error Then Return SetError(1, @error, 0)
	Return True
EndFunc   ;==>_AutoItObject_WrapperAddMethod

; #FUNCTION# ====================================================================================================================
; Name...........: _AutoItObject_WrapperCreate
; Description ...: Creates an IDispatch-Object for COM-Interfaces normally not supporting it.
; Syntax.........: _AutoItObject_WrapperCreate($pUnknown, $tagInterface [, $fNoUnknown = False [, $fCallFree = False]])
; Parameters ....: $pUnknown     - Pointer to an IUnknown-Interface not supporting IDispatch
;                  $tagInterface - String defining the methods of the Interface, see Remarks for details
;                  $fNoUnknown   - [optional] $pUnknown is NOT an IUnkown-Interface. Do not release when out of scope (Default: False)
;                  $fCallFree   - [optional] Internal parameter. Do not use.
; Return values .: Success      - Dispatch-Object
;                  Failure      - 0, @error set
; Author ........: Prog@ndy
; Modified.......:
; Remarks .......: $tagInterface can be a string in the following format (dtag):
;                  +  "FunctionName ReturnType(ParamType1;ParamType2);FunctionName2 ..."
;                  +    - FunctionName is the name of the function you want to call later
;                  +    - ReturnType is the return type (like DLLCall)
;                  +    - ParamType is the type of the parameter (like DLLCall) [do not include the THIS-param]
;                  +
;                  +Alternative Format where only method names are listed (ltag) results in different format for calling the functions/methods later. You must specify the datatypes in the call then:
;                  +  $oObject.function("returntype", "1stparamtype", $1stparam, "2ndparamtype", $2ndparam, ...)
;                  +
;                  +The reuturn value of a call is always an array (except an error occured, then it's 0):
;                  +  - $array[0] - containts the return value
;                  +  - $array[n] - containts the n-th parameter
; Related .......: _AutoItObject_WrapperAddMethod
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _AutoItObject_WrapperCreate($pUnknown, $tagInterface, $fNoUnknown = False, $fCallFree = False)
	If Not $pUnknown Then Return SetError(1, 0, 0)
	Local $sMethods = __Au3Obj_GetMethods($tagInterface)
	Local $aResult
	If $sMethods Then
		$aResult = DllCall($ghAutoItObjectDLL, "idispatch", "CreateWrapperObjectEx", 'ptr', $pUnknown, 'wstr', $sMethods, "bool", $fNoUnknown, "bool", $fCallFree)
	Else
		$aResult = DllCall($ghAutoItObjectDLL, "idispatch", "CreateWrapperObject", 'ptr', $pUnknown, "bool", $fNoUnknown)
	EndIf
	If @error Then Return SetError(2, @error, 0)
	Return $aResult[0]
EndFunc   ;==>_AutoItObject_WrapperCreate

#endregion Public UDFs
;--------------------------------------------------------------------------------------------------------------------------------------