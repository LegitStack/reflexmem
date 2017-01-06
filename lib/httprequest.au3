Func HttpRequest($username, $password)
  Dim $obj = ObjCreate ("WinHttp.WinHttpRequest.5.1")
  $Header = "Content-Type: application/x-www-form-urlencoded"
  ;$Host = "login.reflexmem.com"
  ;$File = "/register.html"
  $Host = "www.reflexmem.com"
  $File = "/api/v1/customer/testconnection"
  $URL = "http://" & $Host & $File
  ;$PostData = "UserID=" & $username & "&Password=" & $password
  $PostData = "{'email': '" & $username & "','password': '" & $password & "'}"
  $obj.Open("PUT", $URL, false)
  $obj.Send($PostData)
  msgbox(64,"title",$obj.ResponseText)
EndFunc
