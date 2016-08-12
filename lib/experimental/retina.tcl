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

proc ::retina::helpers::getMyName {} {
  puts "What textbook is this?"
  flush stdout
  set name [gets stdin]
  return name
}

proc ::retina::set::up {name} {
  ::repo::create $name
}
