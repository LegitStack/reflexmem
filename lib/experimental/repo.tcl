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
                                                      rarity char) }
	set csv ""
	foreach data $datas {
		set csv "$csv, '$data' char"
	}
	brain eval "create table if not exists smoke(time char, env char$csv)"
#	brain eval { create_function('regexp', 2) do |func, pattern, expression|
#	  						func.result = expression.to_s.match(
#	      				Regexp.new(pattern.to_s, Regexp::IGNORECASE)) ? 1 : 0
#							 end
#						 }
# brain function { regexp -deterministic {regexp --} }
# brain function regexp -deterministic {REGEXP --}
}
proc ::repo::createConcert {id datas} {
	file mkdir brain
	sqlite3 brain "./brain/$id.sqlite" -create true

	brain eval { create table if not exists setup(
																											type char,
																											data char) }
	set csv ""
	foreach data $datas {
		set csv "$csv, '$data\_i' char"
		set csv "$csv, '$data\_r' char"
	}
	brain eval "create table if not exists concert(time char, actor char, act char$csv)"
	brain eval "create table if not exists draft(time char, actor char, act char$csv)"
}


################################################################################################################################################################
# insert #########################################################################################################################################################
################################################################################################################################################################


#data is a dictionary - column, data
proc ::repo::insert {table datas} {
	if [dict exists $datas time] {
		set time [dict get $datas time]
	}
	if [dict exists $datas type] {
		set type [dict get $datas type]
	}
	if [dict exists $datas data] {
		set data [dict get $datas data]
	}
	if [dict exists $datas input] {
		set input [dict get $datas input]
	}
	if [dict exists $datas action] {
		set action [dict get $datas action]
		if {[llength $action] > 1 } {
			set action [lrange $action 0 [expr [llength $action]-1] ]
		}
	}
	if [dict exists $datas result] {
		set result [dict get $datas result]
	}
	if [dict exists $datas last_used] {
		set last_used [dict get $datas last_used]
	}
	if [dict exists $datas times_used] {
		set times_used [dict get $datas times_used]
	}
	if [dict exists $datas state] {
		set state [dict get $datas state]
	}
	if [dict exists $datas address] {
		set address [dict get $datas address]
	}
	if [dict exists $datas sdr] {
		set sdr [dict get $datas sdr]
	}
	if [dict exists $datas rule] {
		set rule [dict get $datas rule]
	}
	if [dict exists $datas ruleid] {
		set ruleid [dict get $datas ruleid]
	}
	if [dict exists $datas mainids] {
		set mainids [dict get $datas mainids]
	}
	switch $table {
		setup {
			brain eval {INSERT INTO setup VALUES ($type,$data)}
		}
		main {
			brain eval {INSERT INTO main VALUES ($time,$input,$action,$result)}
		}
		uniq {
			brain eval {INSERT INTO uniq VALUES ($time,$input,$action,$result)}
		}
		chains {
			brain eval {INSERT INTO chains VALUES ($time,$input,$action,$result,$last_used,$times_used)}
		}
		bad {
			brain eval {INSERT INTO bad VALUES ($time,$input,$action,$result)}
		}
		states {
			brain eval {INSERT INTO states VALUES ($state,$sdr)}
		}
		map {
			brain eval {INSERT INTO map VALUES ($state,$address)}
		}
		rules {
			brain eval {INSERT INTO rules VALUES ($rule,$type,$mainids)}
		}
		predictions {
			brain eval {INSERT INTO predictions VALUES ($input,$action,$result,$ruleid)}
		}
		default {
			return "No data saved, please supply valid table name."
		}
	}
}

#data is a list with all the columns used in the same order each time. _ ==
proc ::repo::insert::smoke {time env datas} {
	set csv "'$time'"
	set csv "$csv,'$env'"
	foreach data $datas {
		set csv "$csv,'$data'"
	}
	puts "insert: $csv"
	brain eval "INSERT INTO smoke VALUES ($csv)"
}

proc ::repo::insert::mainSmoke {time input result} {
	brain eval {INSERT INTO main VALUES ($time,$input,$action,$result)}
}

################################################################################################################################################################
# update #########################################################################################################################################################
################################################################################################################################################################

#generic update for updating anything (only 1 table. column is always 'perm')
proc ::repo::update::oneWhere {table column data input result} {
	brain eval "UPDATE '$table' SET '$column'='$data' WHERE input='$input' AND result='$result'"
}

#update an incorrect environment state correlation. - make another one for multiple ids
proc ::repo::update::smoke {id env} {
	brain eval "UPDATE 'smoke' SET 'env'='$env' WHERE rowid='$id'"
}

#generic update for updating anything (only 1 table. column is always 'perm')
proc ::repo::update::onId {table column data id} {
	brain eval "UPDATE '$table' SET '$column'='$data' WHERE rowid='$id'"
}

################################################################################################################################################################
# Get #########################################################################################################################################################
################################################################################################################################################################

#can be used to get connections of cells or connections of bits and columns.
#table, one, two, perm are strings | columns, ones, twos are all lists.
#make perm = 0 to get all connections

proc ::repo::get::actions {} {
	#return [brain eval "SELECT data FROM setup WHERE type='ooutput'"]
	return [brain eval "SELECT rule FROM rules WHERE type='available actions'"]
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
