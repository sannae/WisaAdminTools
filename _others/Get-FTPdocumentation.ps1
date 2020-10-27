<#
.Synopsis
    Automatically connects to Bitech's server and download some docs.
.DESCRIPTION
    The script uses WinSCP CLI to connect to Bitech's SFTP server and downloads the listed documents.
    The performance of the script is tracked via C# stopwatch class and logged.
.EXAMPLE
    PS> ./Get-FTPdocumentation.ps1
.NOTES
    It requires WinSCP installed in C:\Program Files(x86)\WinSCP\WinSCP.exe
    Just edit $LocalPath
#>


# Paths (CASE SENSITIVE)

$RemotePath = '/MRT/MRT_FascicoloTecnico/MRT_Fascicolo_work'
$LocalPath = 'C:\Users\edoardo.sanna\Desktop\Documentazione\_MT_MRT_Fascicolo_Tecnico'
$LocalLog = "$LocalPath\WinSCP_docs.log"

# Docs (CASE SENSITIVE)

$DocInstaller = 'MT_MRT_Installer_II.doc'
$DocMicronpass = 'MT_MRT_MicronPass_VI.doc'
$DocMicronpassMVC = 'MT_MRT_MicronPassMVC.docx'
$DocMicronService = 'MT_MRT_MicronService_III.doc'
$DocMicronServiceOffline = 'MT_MRT_MicronServiceOFFLine.doc'
$DocMicronConfig = 'MT_MRT_MicronConfig.doc'
$DocKARM_all_docs = "MT_MRT_KARM_*.doc"
$DocKARM_all_docxs = "MT_MRT_KARM_*.docx"

# Open connection and execute commands: execution is timed

$Clock = [Diagnostics.Stopwatch]::StartNew()

Remove-Item -Path "$LocalLog"

& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="$LocalLog" /ini=nul `
  /command `
    "open ftpes://sanna:edo89%2B0304@79.11.21.211/ -certificate=`"`"3f:3f:9f:7a:49:0e:4d:80:12:69:af:70:cb:5c:72:a4:e7:3a:eb:f1`"`"" `
    "cd $RemotePath" `
    "get $DocInstaller $LocalPath\" `
    "get $DocMicronpass $LocalPath\" `
    "get $DocMicronpassMVC $LocalPath\" `
    "get $DocMicronService $LocalPath\" `
    "get $DocMicronServiceOffline $LocalPath\" `
    "get $DocMicronConfig $LocalPath\" `
    "get $DocKARM_all_docs $DocKARM_all_docxs $LocalPath\" `
    "exit"

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

<#
TODO: Convertire tutto in PDF. Qui sotto un esempio:

$documents_path = 'c:\doc2pdf'
$word_app = New-Object -ComObject Word.Application
# This filter will find .doc as well as .docx documents
Get-ChildItem -Path $documents_path -Filter *.doc? | ForEach-Object {
    $document = $word_app.Documents.Open($_.FullName)
    $pdf_filename = "$($_.DirectoryName)\$($_.BaseName).pdf"
    $document.SaveAs([ref] $pdf_filename, [ref] 17)
    $document.Close()
}
$word_app.Quit()

#>