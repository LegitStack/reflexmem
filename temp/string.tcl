proc substrings {word} {
  set a 1
  set b [string length $word]
  set letters {}
  while {$a <= $b} {
    puts "$a $b"
    for {set i 0} {$i < $b} {incr i $a} {
      if {$i - ($a - 1) > 0} {
        set match [string range $word [expr $i - ($a - 1)] $i]
      } else {
        set match [string range $word 0 [expr $a - 1]]
      }
      if {[lsearch $letters $match] == -1} {
        lappend letters $match
      }
    }
    incr a
  }
  puts $letters
  puts [llength $letters]
}
substrings "For everybody asking, yes this is his song. I have a good handful of his tracks that were on his soundcloud before the release of While (1<2). There was 4 versions of this song before he split it into Avaritia, and Phantoms Can't Hang. Unfortunately this was the time that he had told everyone to keep an eye out for a date in November of 2013, leading people to believe it was an album release date, only to delete everything from his twitter, and Soundcloud, and leave the 7 tracks that are the 7 deadly sins. I'm glad I managed to grab a lot of that stuff before it was gone. He is without doubt one of the best producers in the world. I get the feeling his emotional state reflects in his music, hence the sudden darkening of his tracks.﻿"
