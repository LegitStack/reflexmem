package require sqlite3
source ./repo.tcl
source ./chain.tcl

namespace eval ::retina {}
namespace eval ::retina::set {}
namespace eval ::retina::helpers:: {}


proc ::retina::main {} {
  ::retina::set::globals
  ::retina::set::up [::retina::helpers::getMyName]
  ::retina::helpers::getCut
  chain [::retina::helpers::getTextFile]                \
        [list ::retina::helpers::openFile {}]           \
        [list ::retina::helpers::removePunctuation {}]  \
        [list ::retina::helpers::makeLower {}]          \
        [list ::retina::set::saveUniqueWords {}]        \
        [list ::retina::set::saveWordCounts {}]         \
        [list ::retina::helpers::cutUp {} $::cutamount] \
        [list ::retina::helpers::saveSDRsToDB {}]
}

proc ::retina::set::globals {} {
  set ::words {}
  set ::wordcounts {}
  set ::cuttext {}
  set ::cutamount {}
}

proc ::retina::helpers::getMyName {} {
  puts "What topic is this?"
  flush stdout
  set name [gets stdin]
  return $name
}

proc ::retina::helpers::getCut {} {
  puts "How many words would you like to cut by? (30 is default. 20-50 is usually a good range.)"
  flush stdout
  set ::cutamount [gets stdin]
  if {$::cutamount eq ""} {
    set ::cutamount 30
  }
}

proc ::retina::set::up {name} {
  ::repo::create $name
}

proc ::retina::helpers::getTextFile {} {
  puts "Where is the text file? (c:\\users\\john\\documents\\textbook.txt)"
  flush stdout
  set loc [gets stdin]
  return $loc
}

proc ::retina::helpers::openFile {loc} {
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

proc ::retina::helpers::removePunctuation {text} {
  return [string map {\<newline> " " ; " " : " " ' " " \" " " . " " / " " \\ " " ? " " \
                      > " " , " " < " " \[ " " \] " " | " " \} " " \{ " " + " " \
                      - " " * " " = " " _ " " ) " " ( " " & " " ^ " " # " " ! " " \
                      ` " " ~ " " % " "} $text]
}

proc ::retina::helpers::makeLower {text} {
  return [string tolower $text]
}

proc ::retina::set::saveUniqueWords {text} {
  foreach word $text {
    if {[lsearch $::words $word] == -1} {
      lappend ::words $word
    }
  }
  return $text
}

proc ::retina::set::saveWordCounts {text} {
  foreach word $::words {
    lappend ::wordcounts [llength [lsearch -all $text $word]]
  }
  return $text
}

proc ::retina::helpers::cutUp {text count} {
  set cuttext {}
  set i 0
  while {$i < [llength $text]} {
    set cuttext [lappend cuttext [lrange $text $i [expr $i + $count - 1]]]
    incr i $count
  }
  return $cuttext
}

proc ::retina::helpers::saveSDRsToDB {text} {
  set sdr {}
  set sdr2 {}
  set sdr4 {}
  set i 0
  set c 1
  set templist2 {}
  set templist4 {}
  puts "processing words: "
  foreach word $::words {
    set sdr {}
    set sdr2 {}
    set sdr4 {}
    puts -nonewline "$word "
    #puts "processing words: $word"
    foreach list $text {
      if {[lsearch $list $word] == -1} {
        set sdr [string cat $sdr 0]
      } else {
        set sdr [string cat $sdr 1]
      }
      set templist2 [concat $templist2 $list]
      set templist4 [concat $templist4 $list]
      if {$c == 2} {
        if {[lsearch $templist2 $word] == -1} {
          set sdr2 [string cat $sdr2 0]
        } else {
          set sdr2 [string cat $sdr2 1]
        }
        set templist2 {}
      } elseif {$c == 4} {
        if {[lsearch $templist4 $word] == -1} {
          set sdr4 [string cat $sdr4 0]
        } else {
          set sdr4 [string cat $sdr4 1]
        }
        if {[lsearch $templist2 $word] == -1} {
          set sdr2 [string cat $sdr2 0]
        } else {
          set sdr2 [string cat $sdr2 1]
        }
        set templist2 {}
        set templist4 {}
        set c 0
      }
      incr c
    }
    ::repo::insert main $word $sdr $sdr2 $sdr4 [lindex $::wordcounts $i]
    incr i
  }
  puts "Done processing words."
}

::retina::main
