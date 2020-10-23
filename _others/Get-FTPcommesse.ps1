<#
.Synopsis
    Automatically connects to Bitech's server and download VR (Released Version) from a specific order.
.DESCRIPTION
    The script uses WinSCP CLI to connect to Bitech's SFTP server and downloads the listed documents.
    The $Customer variable contains the order's end customer.
    The documents must match the VR_ (Released Version) prefix and can be .doc and .pdf.
    The destination path is customizable via the $RootPath variable.
    All the empty documents and folders are then removed.
    The performance of the script is tracked via C# stopwatch class and logged.
.EXAMPLE
    PS> ./Get-FTPcommesse.ps1
.NOTES
    It requires WinSCP installed in C:\Program Files(x86)\WinSCP\WinSCP.exe
    The order's name must be precise and case-sensitive.
    Just edit $Customer and $RootPath.
#>

# TODO: inserire una ricerca delle commesse per descrizione

# Remote Path (CASE SENSITIVE)

$Customer = 'RealeS' # Inserire il nome esatto della commessa!

$RemotePath = '""/MC_Commesse/CO ' + $Customer + '""'   # triple quotes are required for the script to consider the spaces

# RootPath: dove si vogliono salvare i documenti finali; viene anche creato un log

$RootPath = 'C:\_TEMP'
$LocalLog = "$RootPath\WinSCP_commesse.log"

# LocalPath (CASE SENSITIVE) : cartella temporanea in cui verranno salvati tutti i documenti prima di essere filtrati

New-Item -Path $RootPath -Name "temp" -ItemType "Directory"
$LocalPath = "$RootPath\temp"

# Open connection and execute commands: execution is timed

$Clock = [Diagnostics.Stopwatch]::StartNew()

if ( Test-Path "$RootPath\WinSCP_commesse.log" ) {
  Remove-Item -Path "$LocalLog"
}

& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="$LocalLog" /ini=nul `
  /command `
    "open ftpes://sanna:edo89%2B0304@79.11.21.211/ -certificate=`"`"3f:3f:9f:7a:49:0e:4d:80:12:69:af:70:cb:5c:72:a4:e7:3a:eb:f1`"`"" `
    "cd $RemotePath" `
    "get -filemask=VR_*.doc $RemotePath $LocalPath" `
    "exit"

# Spostare i file ricavati da LocalPath a RootPath, rimuovendo tutte le cartelle vuote e le commesse non chiuse

Foreach ( $file in $(Get-ChildItem -Path "$LocalPath\*.doc", "$LocalPath\*.pdf" -Recurse) ) {
  Move-Item -Path $file -Destination $RootPath
}
Remove-Item -Recurse $LocalPath
if ( Test-Path -Path "$RootPath\VR_Versione_rilasciata.doc" ) {
  Remove-Item -Path "$RootPath\VR_Versione_rilasciata.doc"
}

<# TODO: 
Foreach ...

  $NewName = $file.BaseName + " - " + $(Get-Content $file | Select-String -pattern "Progetto: ").Line.Split(":")[1] + ".doc"
  Rename-Item -Path "$RootPath\$file" -NewName $NewName

#>

# Exit code

$winscpResult = $LastExitCode
if ($winscpResult -eq 0) {
  Add-Content -Path "$LocalLog" -Value "Download completed with success"
} else {
  Add-Content -Path "$LocalLog" -Value " !!! Download NOT completed !!! "
}

# Track performance

$Clock.Stop()
Add-Content -Path "$LocalLog" -Value "Execution time approx. $($Clock.Elapsed.Minutes) minutes $($Clock.Elapsed.Seconds) seconds"
