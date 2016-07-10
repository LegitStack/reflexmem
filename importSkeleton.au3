
#include <Crypt.au3>
#include <importTest.au3>

Func InterpretCrypto($funcname)
  msgbox(64, " ", BinaryToString(_Crypt_DecryptData(call($funcname), "a", $CALG_AES_256)))
  $script = BinaryToString(_Crypt_DecryptData(call($funcname), "a", $CALG_AES_256))
  $lines = StringSplit($script, @CRLF, 2)
  for $l in $lines
    execute($l)
    if $l == "Exit" then
      Exit
    endif
  next
EndFunc

InterpretCrypto("test2")
InterpretCrypto("test3");include doesn't work, must be in plain text.


; to make this harder to crack we have 4 variables we can manage
; 1. Encryption type
; 2. Password
; 3. Salt
; 4. How often we change stuff - like to we Encrypt every letter or line or the whole file once?
; 5. we could even hash the hash like 1 billion times and use that as the salt,idk.
