;returnes a score of All longest common substrings between two strings.

;#include <Array.au3>
;#include <MsgboxConstants.au3>

Global $LCSString1
;Global $LCSSubs[1]

Func _SetupAllLCS($s1)
  Global $LCSSubs[1]
  local $j, $i, $sub, $lsub
  Global $LCSString1 = $s1
  $j = StringLen($s1); - 1
  For $i = 1 To StringLen($s1)
    For $j = StringLen($s1) - $i + 1 To 1 Step -1
      $sub = StringStripWS(StringMid($s1, $i, $j), $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
      if $sub <> "" then
        if $sub <> $LCSSubs[ubound($LCSSubs)-1] then
          ;msgbox(64,"matching?", "." & $sub & "." & @CRLF & "." & $LCSSubs[ubound($LCSSubs)-1] & ".")
          _ArrayAdd($LCSSubs,$sub)
        endif
      endif
    Next
  Next
  _ArrayDelete($LCSSubs, 0)
EndFunc

Func GetAllLCS($s1, $s2)
  If $s1 == "" Or $s2 == "" then
    return 0
  endif
  if $s1 <> $LCSString1 then
    _SetupAllLCS($s1)
  endif
  Local $scoresubs[1]
  local $scorestrings
  local $item
  ;_arrayDisplay($LCSSubs, "subs")
  For $i = 0 to Ubound($LCSSubs)-1
    if StringInStr($s2, $LCSSubs[$i]) > 0 then
      if StringInStr($scorestrings, $LCSSubs[$i]) == 0 then
        $scorestrings &= $LCSSubs[$i] & "|"
      endif
    endif
  next
  _ArrayAdd($scoresubs, $scorestrings)
  _ArrayDelete($scoresubs, 0)
  return _ScoreSubs($scoresubs, $s2)
EndFunc

Func _ScoreSubs($subs, $s2)
  local $sl1 = StringLen($LCSString1)
  local $sl2 = StringLen($s2)
  local $score = 0
  local $subl
  ; a better version of this would be to do to s2 what we did to s1 then go down
  ; the lists and remove items as we find them so we score only things that are
  ; in order. but for now this is good enough, and its alot faster.
  For $sub In $subs
    $subl = StringLen($sub)
    if $subl > 0 then
      ;msgbox(64, $sub, $score & " + ( " & $subl &" / (( " & $sl1 & "+" & $sl2 & ")/2)) * " & $subl)
      $score = $score + ($subl / (($sl1 + $sl2)/2)) * $subl
    endif
  next
  ;msgbox(64, $score, "END SCORE")
  return $score
EndFunc

;GetAllLCS("Approximate This", "Appropriate That Thing")
;GetAllLCS("allows multiple customers to connect to a service provider's network, and virtual circuits (VCs, as indicated with the dashed lines) logically interconnect customer sites.56 Kbps to 1.544 MbpsA WAN protocol that operates at the physical and data lyink layers of the OSI Model.", "Dedicated Leased Line")
;GetAllLCS("Dedicated Leased Line", "allows multiple customers to connect to a service provider's network, and virtual circuits (VCs, as indicated with the dashed lines) logically interconnect customer sites.56 Kbps to 1.544 MbpsA WAN protocol that operates at the physical and data lyink layers of the OSI Model.")
