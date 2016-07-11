
#include <Crypt.au3>
;#include <MsgBoxConstants.au3>

Func test2()
  return "0x8182955261D61B90D543B1C709A68F25BC7E2A75334968842BC9BBA9D4D9A5AC3369CF73266DB94B279E4653D84FA580E378FF7696E45B18335B0C898B24B90306D1DBAFE358D9DAD2896C0A3677481CD8786B8A3799E7C8B1BAA4A6A86598963DF3133B66606830CA0166EE21BEE36F"
EndFunc
;Func HelloWorld()
;Assign("message", "world")
;msgbox(64, "Hello", $message)
;EndFunc
;HelloWorld()

Func test3()
  return "0xE3A8007BC8D15E26424CA8333D7BBAF61E4DDD6822A664F682705432344B7DBDBF0D6F3064D8137F1768459B3B96882863D3B9240E780E025AA4D885E994C740FEE81515FBB42BFE2405160AC7C6DBDB"
EndFunc
;#include <MsgBoxConstants.au3>
;msgbox($MB_SYSTEMMODAL,"Test","text")

Func TestExample()
    Local Const $sUserKey = "CryptPassword" ; Declare a password string to decrypt/encrypt the data.
    Local $sData = "..upon a time there was a language without any standardized cryptographic functions. That language is no more." ; Data that will be encrypted.

    Local $bEncrypted = _Crypt_EncryptData($sData, $sUserKey, $CALG_AES_256) ; Encrypt the data using the generic password string.

    $bEncrypted = _Crypt_DecryptData($bEncrypted, $sUserKey, $CALG_AES_256) ; Decrypt the data using the generic password string. The return value is a binary string.
    MsgBox($MB_SYSTEMMODAL, "Decrypted data", BinaryToString($bEncrypted)) ; Convert the binary string using BinaryToString to display the initial data we encrypted.
EndFunc   ;==>Example
