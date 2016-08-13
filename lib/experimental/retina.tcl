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
    puts "imported successfully: [lrange $text 0 5]..."
  }
  close $file
  return $text
}

proc ::retina::helpers::removePunctuation {text} {
  return [string map {; {} : {} ' {} \" {} . {} / {} \\ {} ? {} > {} , {} < {} \[ {} \] {} | {} \} {} \{ {} + {} - {} * {} = {} _ {} ) {} ( {} & {} ^ {} # {} ! {} ` {} ~ {} % {}} $text]
}

proc ::retina::set::saveUniqueWords {text} {
  foreach word $text {
    if {[lsearch $::words $word] eq ""} {
      lappend ::words $word
    }
  }
  return $text
}

proc ::retina::set::saveWordCounts {text} {

  foreach word $::words {
    lappend ::wordcounts [llength [lsearch $text $word]]
  }
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
  set templist {}
  foreach word $::words {
    foreach list $text {
      if {[lsearch -all $list $word] eq ""} {
        set sdr [concat $sdr 0]
      } else {
        set sdr [concat $sdr 1]
      }
      set templist [concat $templist $list]
      if {$c == 2} {
        if {[lsearch -all $templist $word] eq ""} {
          set sdr2 [concat $sdr2 0]
        } else {
          set sdr2 [concat $sdr2 1]
        }
      } elseif {$c == 4} {
        if {[lsearch -all $templist $word] eq ""} {
          set sdr4 [concat $sdr4 0]
        } else {
          set sdr4 [concat $sdr4 1]
        }
        set templist {}
        set c 0
      }
      incr c
    }
    incr i
    #savesdr to db
    #$word $sdr $sdr2 $sdr4 [lindex $::wordcounts $i]
    puts $sdr
    puts $sdr2
    puts $sdr4
    set sdr {}
  }
}






::retina::main
