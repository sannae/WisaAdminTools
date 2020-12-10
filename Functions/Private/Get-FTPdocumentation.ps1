<#
.Synopsis
    Scarica la documentazione aggiornata dal server FTP Bitech.
.DESCRIPTION
    Lo script usa la WinSCP CLI per connettersi al server FTP Bitech e scaricare la documentazione specificata (hard-coded, per il momento)
    I documenti vengono scaricati nel percorso indicato nella variabile $LocalPath.
    Il tutto viene tracciato da $LocalLog.
.EXAMPLE
    Get-FTPdocumentation
.NOTES
    0.9 (da finire di testare)
    Richiede WinSCP installato in C:\Program Files(x86)\WinSCP\WinSCP.exe
    TODO: Per ora i percorsi locali e i documenti da scaricare sono hard-coded, studiare un modo di renderli parametrici
#>


function Get-FTPdocumentation {

  # Paths (CASE SENSITIVE)
  $RemotePath = '/MRT/MRT_FascicoloTecnico/MRT_Fascicolo_work'
  $LocalPath = 'C:\_Docs\_MT_MRT_Fascicolo_Tecnico'
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

  # Cancella log se esiste
  if ( Test-Path $LocalLog) {
    Remove-Item -Path "$LocalLog"
  }

  # Download
  $OpenConnectionString = Open-FtpConnection
  & "C:\Program Files (x86)\WinSCP\WinSCP.com" `
    /log="$LocalLog" /ini=nul `
    /command `
      $OpenConnectionString `
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

  # Scheduled Task (se non esiste, lo crea)

}