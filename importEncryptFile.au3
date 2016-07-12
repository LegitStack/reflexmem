#include <Crypt.au3>

local $sFile = FileOpenDialog("Choose Image...", @scriptDir & "\plugins\", "ReflexMem Plugins (*.au3)")
local $namestart = StringInStr($sFile, ".", 1, -1)
local $file = stringleft($sFile, $namestart)
_Crypt_EncryptFile($sFile, $file & "rmplugin", "thispasswordshouldcomefromourserversinordertobemoresecure", $CALG_AES_256)
