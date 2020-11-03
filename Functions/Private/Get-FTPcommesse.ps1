<#
.SYNOPSIS
    Automatically connects to Bitech's server and download VR (Released Version) from a specific order.
.DESCRIPTION
    The script uses WinSCP CLI to connect to Bitech's SFTP server and downloads the listed documents.
    The $AllegedCustomer is the approximate description of the customer, used to search the corresponding order.
    The script looks for $AllegedCustomer in the MC_COMMESSE folder
    The $RealCustomer is the one used to download the files.
    The documents must match the VR_ (Released Version) prefix and can be .doc and .pdf.
    The destination path is customizable via the $RootPath variable.
    All the empty documents and folders are then removed.
    Finally, the documents are converted from DOC/DOCX into PDF.
    The performance of the script is tracked via C# stopwatch class and logged.
.EXAMPLE
    PS> ./Get-FTPcommesse.ps1
.NOTES
    It requires WinSCP installed in C:\Program Files(x86)\WinSCP\WinSCP.exe
    The order's name must be precise and case-sensitive.
    Just edit $Customer and $RootPath.
#>

# Ricerca commesse per descrizione

Write-host "Questo script effettua il download dei documenti VR contenuti in tutte le commesse di un determinato cliente."
$AllegedCustomer = Read-Host -Prompt "Cliente cercato"
$AllegedRemotePath = '""/MC_Commesse/CO ' + $AllegedCustomer + '"*"'

Write-Host "Sono state trovate le seguenti commesse: "
& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="$LocalLog" /ini=nul `
  /command `
    "open ftpes://sanna:edo89%2B0304@79.11.21.211/ -certificate=`"`"3f:3f:9f:7a:49:0e:4d:80:12:69:af:70:cb:5c:72:a4:e7:3a:eb:f1`"`"" `
    "ls $AllegedRemotePath" `
    "close" `
    "exit" `
    | Select-String -pattern "CO "

# Remote Path (CASE SENSITIVE)

Write-Host "`n"
$RealCustomer = Read-Host -Prompt "Digitare di seguito il cliente di cui scaricare le commesse (ATTENZIONE: inserire la dicitura PRECISA del cliente, la ricerca sarà case-sensitive)"
$RemotePath = '""/MC_Commesse/CO ' + $RealCustomer + '""'

# RootPath: dove si vogliono salvare i documenti finali; viene anche creato un log

$RootPath = Read-Host -Prompt "Digitare il percorso completo in cui salvare i file"
$LocalLog = "$RootPath\WinSCP_commesse.log"
Write-Host "I file di commessa verranno scaricati in $RootPath . È disponibile un log della connessione FTP in $LocalLog"

# LocalPath (CASE SENSITIVE) : cartella temporanea in cui verranno salvati tutti i documenti prima di essere filtrati

New-Item -Path $RootPath -Name "temp" -ItemType "Directory" | Out-Null
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
    "get -filemask=MT_*.doc $RemotePath $LocalPath" `
    "exit"

# Spostare i file ricavati da LocalPath a RootPath, rimuovendo tutte le cartelle vuote e le commesse non chiuse

Foreach ( $file in $(Get-ChildItem -Path "$LocalPath\*.doc", "$LocalPath\*.pdf" -Recurse) ) {
  Move-Item -Path $file -Destination $RootPath
}
Remove-Item -Recurse $LocalPath
if ( Test-Path -Path "$RootPath\VR_Versione_rilasciata.doc" ) {
  Remove-Item -Path "$RootPath\VR_Versione_rilasciata.doc"
}

<# TODO: Aggiungere la descrizione del progetto al filename, leggendolo dal contenuto del file con Get-Content

Foreach ( $file in $(Get-ChildItem -Path "$RootPath\*.doc", "$RootPath\*.pdf") ) {

  $OldName = $file.FullName
  $OldName
  $NewName = $file.BaseName + ' - ' + $(Get-Content $file | Select-String -pattern "Progetto: ").Line.Split(": ")[1] + '.doc'
  $NewName
  Rename-Item -Path ($OldName) -NewName ($NewName)

}

#>

# Exit code

$winscpResult = $LastExitCode
if ($winscpResult -eq 0) {
  Add-Content -Path "$LocalLog" -Value "Download completed with success"
  Write-Host "Tutti i file scaricati con successo!"
} else {
  Add-Content -Path "$LocalLog" -Value " !!! Download NOT completed !!! "
  Write-Host "C'è stato qualche problema con il download, controllare il log"
}

# Convert to PDF (thanks to Patrick Gruenauer, https://sid-500.com )

Write-Host "Inizio conversione file DOC in PDF"
$word = New-Object -ComObject word.application 
$FormatPDF = 17
$word.visible = $false 
$types = '*.docx','*.doc'
  
$files = Get-ChildItem -Path $RootPath -Include $Types -Recurse -ErrorAction Stop
      
foreach ($f in $files) {
  $path = $RootPath + '\' + $f.Name.Substring(0,($f.Name.LastIndexOf('.')))
  $doc = $word.documents.open($f.FullName) 
  $doc.saveas($path,$FormatPDF) 
  $doc.close()
}

Start-Sleep -Seconds 2 
$word.Quit()

Remove-item -Path "$RootPath\*.doc","$RootPath\*.docx"
Write-Host "Fine conversione file DOC in PDF"

# Track performance

$Clock.Stop()

Add-Content -Path "$LocalLog" -Value "Execution time approx. $($Clock.Elapsed.Minutes) minutes $($Clock.Elapsed.Seconds) seconds"
Write-Host "Estrazione durata circa $($Clock.Elapsed.Minutes) minuti"

