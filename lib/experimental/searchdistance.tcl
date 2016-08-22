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

  set continue true
  while $continue {
    chain [::sd::helpers::getQuestion $continue]      \
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
    puts "processed stuff"
    tracer "test"
    set best [chain $::question                                                         \
                    [list ::sd::helpers::searchForList {} $::textbook]                  \
                    [list ::sd::helpers::getAnswerLocations {} $::textbook $::answers]  \
                    [list ::sd::helpers::findClosestAnswer {}]                          \
                    [list ::sd::helpers::getBestAnswer {}]                              ]
    #set a [::sd::helpers::searchForList $::question $::textbook]
    #set b [::sd::helpers::getAnswerLocations $a $::textbook $::answers]
    #set c [::sd::helpers::findClosestAnswer $b]
    #set best [::sd::helpers::getBestAnswer $c]

    puts $best
  }
}
proc tracer {thing} {
  puts thing
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
  #close $file
  return $text
}

proc ::sd::helpers::removePunctuation {text} {
  return [string map {\<newline> " " ; " " : " " ' " " \" " " . " " / " " \\ " " ? " " \
                      > " " , " " < " " \[ " " \] " " | " " \} " " \{ " " + " " \
                      - " " — " " * " " = " " _ " " ) " " ( " " & " " ^ " " # " " ! " " \
                      ` " " ~ " " % " "} $text]
}

proc ::sd::helpers::makeLower {text} {
  return [string tolower $text]
}

proc ::sd::set::textbook {text} {
  set ::textbook $text
}

proc ::sd::helpers::getQuestion {continue} {
  puts "What is the quesiton?"
  flush stdout
  set question [gets stdin]
  if {$question eq ""} {
    upvar 1 $continue continue
    set continue false
  }
  return $question
}

proc ::sd::set::question {question} {
  set ::question $question
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

proc ::sd::helpers::searchForList {question textbook} {
  set continue true
  set i   0
  set s   0
  set si  0
  set len [llength $question]
  set fi  $len
  set f   $len
  set index ""
  set score 0
  set tempstring ""
  while {$continue eq true} {
    after 100
    #puts -nonewline "$i    $s    $si    $f    $fi"
    #set index [lsearch $textbook [lrange $question $s $f]]
    set index [string first [lrange $question $s $f] $textbook]
    set score [expr ($f-$s+0.0)/$len]
    puts "$i    $s    $si    $f    $fi    $len    $index    [lrange $question $s $f]"
    if {$index eq "-1"} {
      if {$s == $si} {
        incr si
        set s 0
      } else { incr s }
      if {$f == $len} {
        incr fi -1
        set f $fi
      } else { incr f }
    } else {
      set continue false
    }
    if {$si == $len} {
      set continue false
    }
  }
  return [list $index $score]
}

proc ::sd::helpers::getAnswerLocations {index textbook answers} {
  set indexes $index
  foreach answer $answers {
    lappend indexes [::sd::helpers::searchForList $answer $textbook]
  }
  return $indexes
}

proc ::sd::helpers::findClosestAnswer {indexes} {
  set scores [dict values $indexes]
  set indexes [dict keys $indexes]
  set return {}
  set i 0
  set in 0
  set smallest {}
  set qindex [lindex $indexes 0]
  puts $indexes
  set dist {}
  foreach index $indexes {
    ######### move this to get best answer?
    if {$i > 0} {
      puts $index
      set dist [expr $index - $qindex - 0.0]
      if {$dist < 0.0} {
        set dist [expr $dist*-1]
      }
      if {$smallest = "" ||
          $dist < $smallest
      } then {
        set smallest $dist
        set in $i
      }
    }
    incr i
    #############only make a dictionary in this part?
    dict set return $index $dist
  }
  return [list $in $return]
}

proc ::sd::helpers::getBestAnswer {scores} {
  #??
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
