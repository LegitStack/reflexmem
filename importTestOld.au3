Func RMPlugin_HelloWorld()
  Assign("message", "world")
  msgbox($MB_SYSTEMMODAL, "Hello", $message)
EndFunc

RMPlugin_HelloWorld()








;METHOD 2 (include Failure)
Func Plugin_Main()
  return "0x8182955261D61B90D543B1C709A68F25BC7E2A75334968842BC9BBA9D4D9A5AC3369CF73266DB94B279E4653D84FA580E378FF7696E45B18335B0C898B24B90306D1DBAFE358D9DAD2896C0A3677481CD8786B8A3799E7C8B1BAA4A6A86598963DF3133B66606830CA0166EE21BEE36F"
EndFunc
;Func HelloWorld()
;Assign("message", "world")
;msgbox(64, "Hello", $message)
;EndFunc
;HelloWorld()

Func test1()
  return "0x504E953636F75696BE36AE271BC942EBA8CDB1FD65F76DEBA4C46B7089D68E3CD73A4F6A3F19611754A605FCCD1B988C"
EndFunc
;msgbox($MB_SYSTEMMODAL,"Test","text")

Func test3()
  return "0xE3A8007BC8D15E26424CA8333D7BBAF61E4DDD6822A664F682705432344B7DBDBF0D6F3064D8137F1768459B3B96882863D3B9240E780E025AA4D885E994C740FEE81515FBB42BFE2405160AC7C6DBDB"
EndFunc
;#include <MsgBoxConstants.au3>
;msgbox($MB_SYSTEMMODAL,"Test","text")


Func maketest2()
  return "0xCE1F5DAE54F7D30D082E2458A50FFEF35C46CC8C7F4277F0FEFE75DEA3765B78E4C4FC8914865E41EF50EE1D00D882853303F77A7392281078E11BB6E6CE6AB9DC7C085F3460867313C8F723643821D6"
EndFunc
;Func test2($something)
;msgbox(64, "Hello", $something)
;EndFunc

Func pleasetest2()
  return "0xD7429CC894694D0C342AB22440F875D2B6D26F2CD5237640E8342F20047ECC8D"
EndFunc
;test2("world")

Func TestExample()
    Local Const $sUserKey = "CryptPassword" ; Declare a password string to decrypt/encrypt the data.
    Local $sData = "..upon a time there was a language without any standardized cryptographic functions. That language is no more." ; Data that will be encrypted.

    Local $bEncrypted = _Crypt_EncryptData($sData, $sUserKey, $CALG_AES_256) ; Encrypt the data using the generic password string.

    $bEncrypted = _Crypt_DecryptData($bEncrypted, $sUserKey, $CALG_AES_256) ; Decrypt the data using the generic password string. The return value is a binary string.
    MsgBox($MB_SYSTEMMODAL, "Decrypted data", BinaryToString($bEncrypted)) ; Convert the binary string using BinaryToString to display the initial data we encrypted.
EndFunc   ;==>Example
