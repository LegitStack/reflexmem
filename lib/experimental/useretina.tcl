package require sqlite3
source ./repo.tcl
source ./chain.tcl

namespace eval ::retina {}
namespace eval ::retina::set {}
namespace eval ::retina::helpers:: {}


proc ::retina::main {} {
  ::retina::set::globals
  ::retina::set::up [::retina::helpers::getMyName]

  chain [::retina::helpers::getQuestionText]            \
        [list ::retina::helpers::removePunctuation {}]  \
        [list ::retina::helpers::makeLower {}]          \
        [list ::retina::helpers::getUniqueWords {}]  \
        [list ::retina::set::questionText {}]
  set answers [::retina::helpers::getQuestionAnswers]
  set newanswers {}
  foreach answer $answers {
    lappend newanswers [chain $answer                                         \
                              [list ::retina::helpers::removePunctuation {}]  \
                              [list ::retina::helpers::makeLower {}]          \
                              [list ::retina::helpers::getUniqueWords {}]     ]
    }
  ::retina::set::answers $newanswers
  ::retina::set::getWords
#how to do it.
#  foreach answer in answers
#    foreach aword in answers
#      if getwords contains aword then
#        get sdrs for aword
#        foreach word in question
#          if getwords contains word then
#            chain: score
#              get sdrs for word
#              loop through sdrs and get score
#              modify score according to rarity.
#          endif
#        next
#      endif
#    next
#    lappend scores score
#  next
#  lappend answerscore [addd up scores]
#exmaple:
  #a1: the 0001111000 .1
  #a2: cat 0001100000 1
  #q1: dad 0000100000 .5
  #q2: mom 0001010000 .7
  #the dad 1 * .1 * .5 = .05
  #the mom 2 * .1 * .7 = .14
  #cat dad 1 *  1 * .5 = .5
  #cat mom 1 *  1 * .7 = .7
  #         ascores  ... 1.39
  #other options:
  #1+2+1+1 = 5 *.1 * .1 * .5 * .5 * .7 * .7 = .006125
  # 5 * (.2) * (1) * (1.4) = 1.4
  # 5 * 2.6 = 13
  set scores {}
  set ascores {}
  foreach answer $::answers {
    set rare [::retina::helpers::getRarity $answer $::question]
    foreach aword $answer {
      if {[lsearch $::words $aword] ne "-1"} {
        foreach qword $::question {
          if {[lsearch $::words $qword] ne "-1"} {
            set asdr [::repo::get::row $aword]
            set qsdr [::repo::get::row $qword]
            set asdr1 [::retina::helpers::modifySdr $asdr $qsdr 2]
            set qsdr1 [::retina::helpers::modifySdr $asdr $qsdr 2]
            set score [::retina::helpers::scoreSdrs $asdr1 $qsdr1]
            set score [::retina::helpers::modifyScore $score [lindex $asdr 4] [lindex $qsdr 4] $rare]
            lappend scores $score
          }
        }
      }
    }
    lappend ascores [::retina::helpers::addUpScores $scores]
    set scores {}
  }
  set bestanswer [::retina::helpers::findLargest $ascores]
  puts $ascores
  puts $bestanswer
  return $bestanswer
}

proc ::retina::set::globals {} {
  set ::question {}
  set ::answers {}
  set ::words {}
}

proc ::retina::helpers::getMyName {} {
  puts "What topic is this?"
  flush stdout
  set name [gets stdin]
  return $name
}

proc ::retina::set::up {name} {
   ::repo::set $name
}

proc ::retina::helpers::getQuestionText {} {
  puts "What is the quesiton?"
  flush stdout
  set question [gets stdin]
  if {$question eq ""} {
    puts "bye"
    exit
  }
  return $question
}

proc ::retina::helpers::getUniqueWords {text} {
  set words {}
  foreach word $text {
    if {[lsearch $words $word] == -1} {
      lappend words $word
    }
  }
  return $words
}

proc ::retina::set::questionText {text} {
  set ::question $text
}

proc ::retina::helpers::removePunctuation {text} {
  return [string map {\<newline> " " ; " " : " " ' " " \" " " . " " / " " \\ " " ? " " \
                      > " " , " " < " " \[ " " \] " " | " " \} " " \{ " " + " " \
                      - " " — " " * " " = " " _ " " ) " " ( " " & " " ^ " " # " " ! " " \
                      ` " " ~ " " % " "} $text]
}

proc ::retina::helpers::makeLower {text} {
  return [string tolower $text]
}


proc ::retina::helpers::getQuestionAnswers {} {
  set tempanswer {}
  set answers {}
  set continue true
  while {$continue eq true} {
    puts "What is one of the available answers? (blank for end)"
    flush stdout
    set tempanswer [gets stdin]
    if {$tempanswer ne ""} {
      lappend answers $tempanswer
    } else {
      set continue false
    }
  }
  return $answers
}


proc ::retina::set::answers {answers} {
  set ::answers $answers
}

proc ::retina::set::getWords {} {
  set ::words [::repo::get::tableColumns main word]
}

proc ::retina::helpers::getRarity {a q} {
  set rarity 100000000000
  foreach word $a {
    set r [::repo::get::rarity $word]
    if {$r < $rarity} {
      if {$r ne ""} {
        set rarity $r
      }
    }
  }
  foreach word $q {
    set r [::repo::get::rarity $word]
    if {$r < $rarity} {
      if {$r ne ""} {
        set rarity $r
      }
    }
  }
  return $rarity
}
proc ::retina::helpers::modifySdr {a q option} {
  switch $option {
    1 {
      return [lindex $a 1]
    }
    2 {
      return [lindex $a 2]
    }
    3 {
      return [lindex $a 3]
    }
    12 {
      return "[lindex $a 1][lindex $a 2]"
    }
    23{
      return "[lindex $a 2][lindex $a 3]"
    }
    123 {
      return "[lindex $a 1][lindex $a 2][lindex $a 3]"
    }
    default {
      return [lindex $a 1]
    }
  }
}


proc ::retina::helpers::scoreSdrs {asdr qsdr} {
  set score 0
  foreach a [split $asdr {}] q [split $qsdr {}] {
    if {$a eq 1} {
      if {$q eq 1} {
        incr score
      }
    }
  }
  return $score
}

proc ::retina::helpers::modifyScore {score arare qrare lowrarity} {
  return [expr $score * ($lowrarity / ($arare + 0.0)) * ($lowrarity / ($qrare + 0.0))]
}

proc ::retina::helpers::addUpScores {scores} {
  set added {}
  foreach score $scores {
    set added [expr $added + $score + 0.0]
  }
  return $added
}

proc ::retina::helpers::findLargest {scores} {
  set largest {}
  set i 0
  set x 0
  foreach score $scores {
    incr i
    if {$score > $largest} {
      set largest $score
      set x $i
    }
  }
  return $x
}
::retina::main
