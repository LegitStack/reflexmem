#include <sqlitequery.au3>

_SetupDB()
  _OpenDB()
    local $terms = GetAllTerms()
    MsgBox($MB_SYSTEMMODAL, "SQLite", "Get Data using a Query123 : " & $terms[1])
    GetDefinition(1)
  _CloseDB()
_SetdownDB()
