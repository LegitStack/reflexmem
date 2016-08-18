proc count {{coroutine false}} {
  #if $coroutine yield
  set continue true
  set i   0
  set s   0
  set si  0
  set len 3
  set fi  $len
  set f   $len
  set index "-1"
  while {$continue} {
    if {$index eq "-1"} {
      puts "$s $si $f $fi"
      if {$s == $si} {
        incr si
        set s 0
        if $coroutine yield
      } else { incr s }
      if {$f == $len} {
        incr fi -1
        set f $fi
        if $coroutine yield
      } else { incr f }
      puts -
      puts "$s $si $f $fi"
      puts --------------
    } else {
      set continue false
    }
    if {$s == $len} {
      set continue false
    }
  }
  return $index
}

proc allNumbers {} {
    yield
    set i 0
    while 1 {
        yield $i
        incr i 2
    }
}
#coroutine nextNumber count
#for {set k 0} {$k < 10} {incr k} {
#    puts "received [nextNumber] $k"
#}
#rename nextNumber {}

coroutine nextNumber count true


# len q = 3
# index = 4
# mid = 3/2=1+4=5
# text= A B C D E F G H I J K
# answers =
#             ZB
#             AB
#             HIJ
#
# patterns:
#      F
#     EF
#     EFG
#    DEFG
#    DEFGH
#   CDEFGH
#   CDEFGHI
#  BCDEFGHI
#  BCDEFGHIJ
# ABCDEFGHIJ
# ABCDEFGHIJK
#
# ZB
# AB
# HIJ
# ---
# Z
# A
# HI
# ---
# B
# B
# IJ
# ---
# H
# ---
# I
# ---
# J
#
# use yield and coroutines to produce those patterns and interweave them.
#
#
