package require sqlite3
source ./repo.tcl
source ./chain.tcl

#puts [chain "  THIS IS THE SEED, THE OTHER ARGUMENTS MUTATE THE STRING ONE AT A TIME.  " \
            [list string trim {}] \
            [list string tolower {}] \
            [list string map -nocase {"THE OTHER ARGUMENTS MUTATE THE STRING ONE AT A TIME" "the other arguments can have more than one argument \nand you can specify which one to pass the seed to by indicating an empty \nargument ( {} )"} {}] \
     ]

namespace eval ::retina {}
namespace eval ::retina::set {}
namespace eval ::retina::helpers:: {}

############################################################################
# Setup ####################################################################
############################################################################


proc ::retina::main {} {
  ::retina::set::globals
  ::retina::set::up [::retina::helpers::getMyName]
  chain [::retina::helpers::getTextFile]                \
        [list ::retina::helpers::openFile {}]           \
        [list ::retina::helpers::removePunctuation {}]  \
        [list ::retina::helpers::makeLower {}]          \
        [list ::retina::set::saveUniqueWords {}]        \
        [list ::retina::set::saveWordCounts {}]         \
        [list ::retina::helpers::cutUp {} 30]           \
        [list ::retina::helpers::saveSDRsToDB {}]

# cutup will cut it into 30 word increments. we'll go with 30 (1), 60 (2), and 120 (4)
# this means the number of bits in the sparse rep is variable. but we still stick to 5% sparsity.
}

proc ::retina::set::globals {} {
  set ::words {}
  set ::wordcounts {}
  set ::cuttext {}
}

proc ::retina::helpers::getMyName {} {
  puts "What topic is this?"
  flush stdout
  set name [gets stdin]
  return $name
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
    #puts [concat "imported successfully: " [lrange $text 0 0] "..."]
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
  foreach word $::words {
    set sdr {}
    set sdr2 {}
    set sdr4 {}
    puts "processing word: $word"
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
    #savesdr to db
    #puts [concat $word $sdr $sdr2 $sdr4 [lindex $::wordcounts $i]]
    ::repo::insert main $word $sdr $sdr2 $sdr4 [lindex $::wordcounts $i]
    # now that thats working you may just want to record the indicies of the one bits.
    incr i
  }
}






::retina::main
