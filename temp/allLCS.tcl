set ::String1 {}
set ::Subs {}
#set ::ScoreSubs {}
proc setupLCS {s1} {
  set ::String1 $s1
  set sl [expr ([string length $s1]-1)]
  set j $sl
  for {set i 0} {$i <= $sl} {incr i} {
    for {set j $sl} {$j >= $i} {set j [expr $j - 1]} {
      set sub [string range $s1 $i $j]
      puts "$i $j [string length $s1] $sub"
      lappend ::Subs $sub
    }
  }
}

proc allLongestCommonSubstrings {s1 s2} {
  if {$s1 ne $::String1} {
    setupLCS $s1
  }
  set scoresubs {}
  foreach item $::Subs {
    if {[string match -nocase *$item* $s2] > 0} {
      if {[string match -nocase *$item* $scoresubs] == 0} {
      #if {[lsearch -glob $::ScoreSubs $item*] == 0}
        lappend scoresubs $item
      }
    }
  }
  puts $scoresubs
  scoreSubs $scoresubs $s2
}

proc scoreSubs {subs s2} {
  set sl1 [string length $::String1]
  set sl2 [string length $s2]
  set score 0
  # a better version of this would be to do to s2 what we did to s1 then go down
  # the lists and remove items as we find them so we score only things that are
  # in order. but for now this is good enough, and its alot faster.
  foreach sub $subs {
    set subl [string length $sub]
    set score [expr $score + ($subl.0 / (($sl1 + $sl2)/2)) * $subl]
  }
  puts ""
  puts "String 1: $::String1"
  puts "String 2: $s2"
  puts "Matches: $subs"
  puts "Score: $score"
  puts ""
}
allLongestCommonSubstrings "Approximate This" "Appropriate That Thing"
#http://meta.codegolf.stackexchange.com/questions/2140/sandbox-for-proposed-challenges/9236#9236
