package require sqlite3
source ./repo.tcl
source ./chain.tcl

namespace eval ::retina {}
namespace eval ::retina::set {}
namespace eval ::retina::helpers:: {}


proc ::retina::main {} {
  ::retina::set::globals
  ::retina::set::up [::retina::helpers::getMyName]

  chain [::retina::set::getQuestionText]                \
        [list ::retina::helpers::removePunctuation {}]  \
        [list ::retina::helpers::makeLower {}]          \
        [list ::retina::helpers::getUniqueWords {}]    \
        [list ::retina::set::questionText {}]
  chain [::retina::set::getQuestionAnsers]              \
        [list ::retina::helpers::removePunctuation {}]  \
        [list ::retina::helpers::makeLower {}]          \
        [list ::retina::helpers::getUniqueAnswers {}]    \
        [list ::retina::set::answers {}]
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
  set scores {}
  foreach answer $::answers {
    set rare [::retina::helpers::getRarity $answer $::question]
    foreach aword $answer {
      if {[lsearch $::words $aword] == -1} {
        foreach qword $::question {
          if {[lsearch $::words $qword] == -1} {
            set asdr [::repo::get::row $aword]
            set qsdr [::repo::get::row $qword]
            set asdr1 [::retina::helpers::modifySdr $asdr $qsdr 1]
            set qsdr1 [::retina::helpers::modifySdr $asdr $qsdr 1]
            set score [::retina::helpers::scoreSdrs $asdr1 $qsdr1]
            set score [::retina::helpers::modifyScore $score [lindex $asdr 4] [lindex $qsdr 4] $rare]
            set scores [lappend $scores $score]
          }
        }
      }
    }
    set ascores [lappend $ascores [::retina::helpers::addUpScores $scores]]
    set scores {}
  }
  return [::retina::helpers::findLargest $ascores]
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
}

proc ::retina::helpers::getUniqueQuestion {question} {
  set words {}
  foreach word $question {
    if {[lsearch $words $word] == -1} {
      set words [lappend $words $word]
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
                      - " " * " " = " " _ " " ) " " ( " " & " " ^ " " # " " ! " " \
                      ` " " ~ " " % " "} $text]
}

proc ::retina::helpers::makeLower {text} {
  return [string tolower $text]
}


proc ::retina::set::getQuestionAnswers {} {
  set tempanswer {}
  set answers {}
  while {$tempanswer ne ""} {
    puts "What are the available answers?"
    flush stdout
    set $tempanswer [gets stdin]
    if {$tempanswer ne ""} {
      set answers [lappend $::answers [::retina::helpers::removePunctuation $tempanswer]]
    }
  }
  return $answers
}

proc ::retina::helpers::getUniqueAnswers {answers} {
  set newanswers {}
  set words {}
  foreach answer $answers {
    foreach word $answer {
      if {[lsearch $words $word] == -1} {
        set words [lappend $words $word]
      }
    }
    set newanswers [lappend $newanswers $words]
    set words {}
  }
  return $newanswers
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
      set rarity $r
    }
  }
  foreach word $q {
    set r [::repo::get::rarity $word]
    if {$r < $rarity} {
      set rarity $r
    }
  }
  return $rarity
}
proc ::retina::helpers::modifySdr {a q option} {
  switch $options {
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
  foreach a [split $asdr] q [split $qsdr] {
    if {$a eq 1} {
      if {$q eq 1} {
        incr score
      }
    }
  }
}

proc ::retina::helpers::modifyScore {score arare qrare lowrarity} {
  return [expr $score * [expr $lowrarity/$arare] * [expr $lowrarity/$qrare]]
}

proc ::retina::helpers::addUpScores {scores} {
  set added {}
  foreach score $scores {
    set added [expr $added + $score]
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
