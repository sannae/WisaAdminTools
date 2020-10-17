# Remote Path (CASE SENSITIVE: triple quotes are required for the script to consider the spaces)
# Purtroppo bisogna inserire il nome esatto della commessa

$RemotePath = '""/MC_Commesse/CO BCube""'
$LocalPath = 'C:\_TEMP'
$LocalLog = "$LocalPath\WinSCP_commesse.log"

# Open connection and execute commands: execution is timed

$Clock = [Diagnostics.Stopwatch]::StartNew()

Remove-Item -Path "$LocalLog"

& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="C:\_TEMP\WinSCP_commesse.log" /ini=nul `
  /command `
    "open ftpes://sanna:edo89%2B0304@79.11.21.211/ -certificate=`"`"3f:3f:9f:7a:49:0e:4d:80:12:69:af:70:cb:5c:72:a4:e7:3a:eb:f1`"`"" `
    "cd $RemotePath" `
    "get -filemask=VR_*.doc $RemotePath $LocalPath"
    # TODO: da completare, adesso esporta anche le cartelle vuote

# Exit code

$winscpResult = $LastExitCode
if ($winscpResult -eq 0) {
  Add-Content -Path "$LocalLog" -Value "Download completed with success"
} else {
  Add-Content -Path "$LocalLog" -Value " !!! Download NOT completed !!! "
}

# Track performance

$Clock.Stop()
Add-Content -Path "$LocalLog" -Value "Execution time approx. $($Clock.Elapsed.Minutes) minutes"
