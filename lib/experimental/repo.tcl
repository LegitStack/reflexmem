#taken from naisen - we'll want to trim this.
package provide repo 1.0

package require sqlite3

namespace eval ::repo {}
namespace eval ::repo::insert {}
namespace eval ::repo::update {}
namespace eval ::repo::delete {}
namespace eval ::repo::get {}
namespace eval ::repo::helpers {}

################################################################################################################################################################
# set #########################################################################################################################################################
################################################################################################################################################################


proc ::repo::set {id} {
	sqlite3 brain "./brain/$id.sqlite" -create false

}


################################################################################################################################################################
# create #########################################################################################################################################################
################################################################################################################################################################


proc ::repo::create {id} {
	file mkdir brain
	sqlite3 brain "./brain/$id.sqlite" -create true
  #entity atribute value
  brain eval { create table if not exists main(
																								word char,
                                                SDR1 char,
                                                SDR2 char,
                                                SDR3 char,
                                              	rarity int) }
}

################################################################################################################################################################
# insert #########################################################################################################################################################
################################################################################################################################################################


#data is a dictionary - column, data
proc ::repo::insert {table word sdr sdr2 sdr4 rarity} {
	switch $table {
		main {
			brain eval {INSERT INTO main VALUES ($word,$sdr,$sdr2,$sdr4,$rarity)}
		}
		default {
			return "No data saved, please supply valid table name."
		}
	}
}


################################################################################################################################################################
# update #########################################################################################################################################################
################################################################################################################################################################

#generic update for updating anything (only 1 table. column is always 'perm')
proc ::repo::update::oneWhere {table column data input result} {
	brain eval "UPDATE '$table' SET '$column'='$data' WHERE input='$input' AND result='$result'"
}


################################################################################################################################################################
# Get #########################################################################################################################################################
################################################################################################################################################################

#can be used to get connections of cells or connections of bits and columns.
#table, one, two, perm are strings | columns, ones, twos are all lists.
#make perm = 0 to get all connections

proc ::repo::get::sdr1 {word} {
	return [brain eval "SELECT SDR1 FROM main WHERE word='$word'"]
}

proc ::repo::get::sdr2 {word} {
	return [brain eval "SELECT SDR2 FROM main WHERE word='$word'"]
}

proc ::repo::get::sdr3 {word} {
	return [brain eval "SELECT SDR3 FROM main WHERE word='$word'"]
}
proc ::repo::get::rarity {word} {
	return [brain eval "SELECT rarity FROM main WHERE word='$word'"]
}

proc ::repo::get::row {word} {
	return [brain eval "SELECT word,SDR1,SDR2,SDR3,rarity FROM main WHERE word='$word'"]
}

proc ::repo::get::tableColumns {table cols} {
	set csv ""
	foreach col $cols {
		if {$csv eq ""} {
			set csv "$col"
		} else {
			set csv "$csv,$col"
		}
	}
	return [brain eval "SELECT $csv FROM $table"]
}

proc ::repo::get::tableColumnsWhere {table cols where} {
	set csv ""
	foreach col $cols {
		if {$csv eq ""} {
			set csv "$col"
		} else {
			set csv "$csv,$col"
		}
	}
	set csv2 ""
	foreach key [dict keys $where] {
		if {$csv2 eq ""} {
			set csv2 "$key='[dict get $where $key]'"
		} else {
			set csv2 "$csv2 AND $key='[dict get $where $key]'"
		}
	}
	return [brain eval "SELECT $csv FROM $table WHERE $csv2"]
}

proc ::repo::get::allMatch {table input action result} {
	return [brain eval "SELECT input,action,result FROM $table WHERE input='$input' AND result='$result' AND action='$action'"]
}
proc ::repo::get::randomSet {} {
	return [brain eval "SELECT input,action,result FROM main ORDER BY RANDOM() LIMIT 1"]
}
proc ::repo::get::actMatch {table input result} {
	return [brain eval "SELECT action FROM $table WHERE input='$input' AND result='$result'"]
}

proc ::repo::get::exactResult {table goal} {
	return [brain eval "SELECT input FROM $table WHERE result='$goal'"]
}
proc ::repo::get::chain {table column result} {
		return [brain eval "SELECT $column FROM $table WHERE result='$result'"]
}

proc ::repo::get::chainMatch {table mod thelist} {
	set newlist ""
	foreach item $thelist {
		if {$newlist ne ""} { set newlist "$newlist OR" }
		set newlist "$newlist $mod='$item'"
	}
	return [brain eval "SELECT input,action,result FROM $table WHERE $newlist"]
}
proc ::repo::get::smokeChainMatch {mod thelist} {
	set newlist ""
	foreach item $thelist {
		if {$newlist ne ""} { set newlist "$newlist OR" }
		set newlist "$newlist $mod='$item'"
	}
	#if {$mod eq "result"} {
	#	set col "input"
	#} elseif {$mod eq "input"} {
	#	set col "result"
	#}
	return [brain eval "SELECT input,result FROM main WHERE $newlist"]
}
proc ::repo::get::smokeMatch {colist valist} {
	set newlist ""
	foreach item $valist thing $colist {
		if {$newlist ne ""} { set newlist "$newlist AND" }
		set newlist "$newlist smoke.'$thing'='$item'"
	}
	puts $newlist
	return [brain eval "SELECT env FROM smoke WHERE $newlist"]
}

proc ::repo::get::smokeLatest {} {
	return [brain eval "SELECT * FROM smoke WHERE rowid = (SELECT MAX(rowid) FROM smoke)"]
}
proc ::repo::get::smokeLatestId {} {
	return [brain eval "SELECT rowid FROM smoke WHERE rowid = (SELECT MAX(rowid) FROM smoke)"]
}
proc ::repo::get::smokeSinceTimeIdEnv time {
	return [brain eval "SELECT rowid,env FROM smoke WHERE time >= $time "]
}

proc ::repo::get::smokeMainMatch {input result} {
	return [brain eval "SELECT input,result FROM main WHERE input='$input' AND result='$result'"]
}
proc ::repo::get::smokeList {input} {
	return [brain eval "SELECT * FROM smoke WHERE env='$input'"]
}

proc ::repo::get::chainActions {input result} {
	return [brain eval "SELECT action FROM chains WHERE input='$input' AND result='$result'"]
}

proc ::repo::get::actsDoneHere {input} {
	set a [brain eval "SELECT action FROM bad WHERE input='$input'"]
	set b [brain eval "SELECT action FROM main WHERE input='$input'"]
	return "$a $b"
}

proc ::repo::get::mapMatch {input} {
	return [brain eval "SELECT state FROM map WHERE state='$input'"]
}

proc ::repo::get::statesMatch {input} {
	return [brain eval "SELECT state FROM states WHERE state='$input'"]
}

proc ::repo::get::mapAddress {input} {
	return [brain eval "SELECT address FROM map WHERE state='$input'"]
}

proc ::repo::get::maxAction {} {
	return [brain eval "SELECT max(action) FROM main"]
}
proc ::repo::get::minAction {} {
	return [brain eval "SELECT min(action) FROM bad"]
}

################################################################################
# Like #########################################################################
################################################################################


#select * from uniq WHERE input like '_0_'
proc ::repo::get::byResultsLike {table result} {
	puts $table$result
	return [brain eval "SELECT DISTINCT result FROM $table WHERE result LIKE '$result'"]
}
#select * from uniq WHERE input like '_0_'
proc ::repo::get::smokeLike {env} {
	return [brain eval "SELECT DISTINCT * FROM smoke WHERE env LIKE '$env'"]
}



################################################################################################################################################################
# Delete #########################################################################################################################################################
################################################################################################################################################################
proc ::repo::delete::rowsTableColumnValue {table col value} {
	return [brain eval "DELETE FROM $table WHERE $col='$value'"]
}
################################################################################################################################################################
# Help #########################################################################################################################################################
################################################################################################################################################################
