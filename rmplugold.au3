#NoTrayIcon
#include <File.au3>
#include <Crypt.au3>
#include <Array.au3>
#include <lib\filelocations.au3>
;METHOD 2 (Raw Execute)
Func ImportPlugin()
  local $path = GetScriptsPath("plugins") & "temporaryplugin.rmplug"
  local $file = FileOpen($path, $FO_READ)
  local $read = FileRead($file)
  FileClose($file)
  local $nread = Stringsplit($read, @CRLF, 2)
  msgbox(64, "$read", $nread[0] &".")
  local $newread = BinaryToString(_Crypt_DecryptData($nread[0], "a", $CALG_AES_256))
    msgbox(64, "$read", $newread)
  local $newnewread = Stringsplit($newread, @CRLF, 2)
  _arrayDisplay($newnewread, "$read")
  ExecutePlugin($newnewread)
EndFunc

Func ExecutePlugin($__READ__)
  for $__R__ in $__READ__
    if $__R__ <> "" then
      Execute($__R__)
      if $__R__ == "Exit" then
        Exit
      endif
    endif
  next
EndFunc

msgbox(64, "running", "")
ImportPlugin()

;how to prepare plugins
  ;1. create a plugin script
  ;2. encrypt the data, replace code
  ;3. encryptfile, put in the plugins folder in scriptdir.

;plugin requirements:
  ;1. cannot have a function called "ImportPlugin"
  ;2. cannot have a function called "ExecutePlugin"
  ;3. cannot have a variable called "$__R__"
  ;4. cannot have a variable called "$__READ__"
  ;5. you must load everything into Memory before you being to execute.
  ;6. Your plugin cannot have more than 30k lines of code.
  ;7. cannot #include anything.
  ;8. cannot assign variables the normal way. you must use Assign("message", "world") (Assign, Call, Eval)
  ;9. convention suggests you use RMPlugin_ at the beginning of all function and variables in order to avoid duplicates because all the includes have to be

;METHOD 2 (plug failure)
;#include <plugins\temporaryplugin.au3>
;Func InterpretCrypto($funcname)
;  msgbox(64, " ", BinaryToString(_Crypt_DecryptData(call($funcname), "a", $CALG_AES_256)))
;  $script = BinaryToString(_Crypt_DecryptData(call($funcname), "a", $CALG_AES_256))
;  $lines = StringSplit($script, @CRLF, 2)
;  for $l in $lines
;    execute($l)
;    if $l == "Exit" then
;      Exit
;    endif
;  next
;EndFunc

;InterpretCrypto("Plugin_Main")
;InterpretCrypto("test1");include doesn't work, must be in plain text.
;InterpretCrypto("test3");include doesn't work, must be in plain text.
;InterpretCrypto("maketest2")
;InterpretCrypto("pleasetest2")

; to make this harder to crack we have 4 variables we can manage
; 1. Encryption type
; 2. Password
; 3. Salt
; 4. How often we change stuff - like to we Encrypt every letter or line or the whole file once?
; 5. we could even hash the hash like 1 billion times and use that as the salt,idk.
