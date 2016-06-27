#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         Jordan Miller

 Script Function:
	Library for building, populating and querying SQLite3 database

 Requirements:
  sqlite3.dll in folder called dll in same folder as the top level.
  db must be in db folder in same file as the top level.

 For More Information:
  https://www.autoitscript.com/autoit3/docs/libfunctions/SQLite%20Management.htm

#ce ----------------------------------------------------------------------------


#include <MsgBoxConstants.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#include <Array.au3>

Func SetupDB()
  Global $SQL = _SQLite_Startup("dll\sqlite3.dll")
  If @error Then
    MsgBox($MB_SYSTEMMODAL, "SQLite Error", "SQLite3.dll Can't be Loaded!" & @CRLF & @CRLF & _
      "Not FOUND in @SystemDir, @WindowsDir, @ScriptDir, @WorkingDir, @LocalAppDataDir\AutoIt v3\SQLite")
    Exit -1
  EndIf
EndFunc


Func OpenDB()
  Global $DB = _SQLite_Open('db\db.db') ;
  If @error Then
    MsgBox($MB_SYSTEMMODAL, "SQLite Error", "Can't create a memory Database!")
    Exit -1
  EndIf
EndFunc


Func GetAllTerms()
  local $t, $terms[1], $term
  ;_SQLite_Exec($DB, "Insert into mira values ('1',2,3);")
  ;Local $d = _SQLite_Exec($DB, "SELECT def FROM mira WHERE term == 'bus'") ; _cb will be called for each row
  _SQLite_Query($DB, "SELECT term FROM mira;", $t) ; the query

  local $i = 0
  While _SQLite_FetchData($t, $term) = $SQLITE_OK
    if $i == 0 then
      $terms[$i] = $term[0]
    else
      _ArrayAdd($terms,$term[0])
    EndIf
    $i += 1
  WEnd
  return $terms
EndFunc


Func GetDefinition($row)
  Local $d, $defmsg
  local $def
  ;_SQLite_Exec($DB, "Insert into mira values ('1',2,3);")
  ;Local $d = _SQLite_Exec($DB, "SELECT def FROM mira WHERE term == 'bus'") ; _cb will be called for each row
  _SQLite_Query($DB, "SELECT def FROM mira WHERE rowid = '" & $row & "';", $d) ; the query

  While _SQLite_FetchData($d, $def) = $SQLITE_OK
      $defmsg &= $def[0]
  WEnd
  return $defmsg
EndFunc


Func InsertTermAndDef($term, $def)
  _SQLite_Exec($DB, "INSERT INTO mira values ('" & $term & "','" & $def & "');")
EndFunc

Func CloseDB()
  _SQLite_Close($DB) ;
EndFunc


Func SetdownDB()
  _SQLite_Shutdown()
EndFunc



;_SetupDB()
  ;_OpenDB()
    ;local $terms = GetAllTerms()
    ;MsgBox($MB_SYSTEMMODAL, "SQLite", "Get Data using a Query123 : " & $terms[1])
    ;GetDefinition(1)
  ;_CloseDB()
;_SetdownDB()
