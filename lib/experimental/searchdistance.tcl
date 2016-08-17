source ./chain.tcl

namespace eval ::sd {}
namespace eval ::sd::set {}
namespace eval ::sd::helpers:: {}

proc ::sd::main {} {
  ::sd::set::globals
  chain [::sd::helpers::getTextFile]                \
        [list ::sd::helpers::openFile {}]           \
        [list ::sd::helpers::removePunctuation {}]  \
        [list ::sd::helpers::makeLower {}]          \
        [list ::sd::set::textbook {}]

  while continue {
    chain [::sd::helpers::getQuestion]                \
          [list ::sd::helpers::removePunctuation {}]  \
          [list ::sd::helpers::makeLower {}]          \
          [list ::sd::set::question {}]
    set answers [::sd::helpers::getAnswers]
    set newanswers {}
    foreach answer $answers {
      lappend newanswers [chain $answer                                     \
                                [list ::sd::helpers::removePunctuation {}]  \
                                [list ::sd::helpers::makeLower {}]          ]
    }
    ::sd::set::answers $newanswers
    set best [chain $::question
                    [list ::sd::helpers::findQuestion {}]       \
                    [list ::sd::helpers::findClosestAnswer {}]  \
                    [list ::sd::helpers::getBestAnswer {}]
    puts $best
  }
}

proc ::sd::set::globals {} {
  set ::textbook {}
  set ::question {}
  set ::answers {}
}

proc ::sd::helpers::getTextFile {} {
  puts "Where is the text file? (c:\\users\\john\\documents\\textbook.txt)"
  flush stdout
  set loc [gets stdin]
  return $loc
}

proc ::sd::helpers::openFile {loc} {
  set file [open $loc]
  set text [read $file]
  if {[catch {close $file} err]} {
    puts "ls command failed: $err"
  } else {
    puts [concat "imported successfully: " [string range $text 0 100] "..."]
  }
  close $file
  return $text
}

proc ::sd::helpers::removePunctuation {text} {
  return [string map {\<newline> " " ; " " : " " ' " " \" " " . " " / " " \\ " " ? " " \
                      > " " , " " < " " \[ " " \] " " | " " \} " " \{ " " + " " \
                      - " " * " " = " " _ " " ) " " ( " " & " " ^ " " # " " ! " " \
                      ` " " ~ " " % " "} $text]
}

proc ::sd::helpers::makeLower {text} {
  return [string tolower $text]
}

proc ::sd::set::textbook {text} {
  set ::textbook $text
}

proc ::sd::helpers::getQuestion {} {
  puts "What is the quesiton?"
  flush stdout
  set question [gets stdin]
  if {$question eq ""} {
    puts "bye"
    exit
  }
  return $question
}

proc ::sd::helpers::getAnswers {} {
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

proc ::sd::set::answers {answers} {
  set ::answers $answers
}

proc ::sd::helpers::getBestAnswer {scores} {
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

::sd::main
