# https://winscp.net/eng/docs/library_powershell

& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="C:\_TEMP\WinSCP.log" /ini=nul `
  /command `
    "open ftps://sanna:edo89%2B0304@79.11.21.211/ -certificate=`"`"3f:3f:9f:7a:49:0e:4d:80:12:69:af:70:cb:5c:72:a4:e7:3a:eb:f1`"`"" `
    "cd MC_Commesse" ` # Spostati in MC_Commesse
    "ls" `          # Elenca il contenuto
    "exit"

$winscpResult = $LastExitCode
if ($winscpResult -eq 0)
{
  Write-Host "Success"
}
else
{
  Write-Host "Error"
}

exit $winscpResult