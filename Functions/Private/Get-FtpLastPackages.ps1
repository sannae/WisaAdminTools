<#
.SYNOPSIS
  Scarica l'ultimo file ZIP disponibile di un certo pacchetto selezionato.
.DESCRIPTION
  Lo script utilizza la WinSCP CLI per connettersi al server FTP Bitech e scaricare l'ultima versione di un determinato pacchetto software.
  Lo script accetta in input il nome del pacchetto: è possibile usare la Tab-completion per trovare il nome completo tra quelli disponibili.
  Il nome del pacchetto viene valutato in modalità case-sensitive e viene usato per trovare la cartella omonima sul server FTP remoto.
  Per scaricare l'ultimissima versione, viene usata la flag -latest della WinSCP CLI.
  Viene inoltre richiesto il percorso di scarico locale dei file.
.PARAMETER PACKAGENAME
  Nome del file ZIP di cui scaricare l'ultima versione.
  Il default è "MRTInstaller".
  Deve corrispondere a uno dei valori nel ValidateSet, ovvero nell'array di possibili pacchetti scaricabili.
.PARAMETER LOCALPATH
  Percorso locale in cui salvare i pacchetti scaricati.
  Lo script ne testa l'esistenza prima di procedere.
.EXAMPLE
  Get-FtpLastPackages Micronpass C:\.temp
.NOTES
  1.0 (testato per tutti i programmi elencati)
  TODO: Incorporare NoService quando si scarica MicronService, invece di doverlo specificare separatamente
#>

function Get-FtpLastPackages {

  [CmdletBinding()]
  param(
  [Parameter(Mandatory = $true, Position = 0, 
  HelpMessage="Digitare il percorso completo in cui salvare i file")]
  [ValidateScript ( { Test-Path $_} )]
    [string] $LocalPath,
  [Parameter(Mandatory = $true, Position = 1, 
  HelpMessage="Inserire il nome del pacchetto (ATTENZIONE: Case-sensitive) (Tab-completion disponibile)")]
  [ValidateSet(
    "MRTInstaller",
    "Micronpass",
    "MicronService",
    "MicronServiceOffline",
    "MicronConfig",
    "MicronMail",
    "NoService",
    IgnoreCase = $false)]
    [string] $PackageName
  )

  # Version
  $Version = "V750"
  Write-Verbose "Versione corrente: $Version"

  # File mask (con l'eccezione di NoService)
  if ( $PackageName -eq "NoService" ) {
    $FileMask = "*NOSRV.zip" # Quando scarichi MicronService, scarica anche NoService
    $RemotePath = "/MRT/MRT_FX4_PC_EXE/MicronService" + "/$Version"
  } else {
    $FileMask = "$*.zip"
    $RemotePath = "/MRT/MRT_FX4_PC_EXE/$PackageName" + "/$Version"
  }

  # Download
  $OpenConnectionString = Open-FtpConnection

  & "C:\Program Files (x86)\WinSCP\WinSCP.com" `
    /ini=nul `
    /command `
      $OpenConnectionString `
      "cd $RemotePath" `
      "get -latest $FileMask $LocalPath\" `
      "close" `
      "exit"    

  Write-Verbose "I pacchetti selezionati sono stati scaricati in $LocalPath"

}