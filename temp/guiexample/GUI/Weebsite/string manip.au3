local $trigger = "hello world HotKeySet( 'k', 'whatever') This is a test hello world HotKeySet( 'k', 'whatever') This is a test"
local $hotloc
local $endloc
local $middle

   while StringInStr($trigger, "HotKeySet(", 1)
      $hotloc = StringInStr($trigger, "HotKeySet(", 1)
      $endloc = StringInStr($trigger, ")", 1,1,$hotloc+13)
	  $middle = StringMid($trigger, $hotloc, $endloc-$hotloc+1)
	  $trigger = stringleft($trigger, $hotloc-1) & stringright($trigger, stringlen($trigger)-$endloc)
	  MsgBox(64, $hotloc, $endloc)
	  MsgBox(64, $trigger, $middle)
   WEnd


@HotKeyPressed
