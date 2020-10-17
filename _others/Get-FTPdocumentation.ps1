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
#>


# Paths (CASE SENSITIVE)

$RemotePath = '/MRT/MRT_FascicoloTecnico/MRT_Fascicolo_work'
$LocalPath = 'C:\Users\edoardo.sanna\Desktop\Documentazione\_MT_MRT_Fascicolo_Tecnico'

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

Remove-Item -Path "$LocalPath\WinSCP.log"

& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="$LocalPath\WinSCP.log" /ini=nul `
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
  Add-Content -Path "$LocalPath\WinSCP.log" -Value "Download completed with success"
} else {
  Add-Content -Path "$LocalPath\WinSCP.log" -Value " !!! Download NOT completed !!! "
}

# Track performance

$Clock.Stop()
Add-Content -Path "$LocalPath\WinSCP.log" -Value "Execution time approx. $($Clock.Elapsed.Minutes) minutes"

