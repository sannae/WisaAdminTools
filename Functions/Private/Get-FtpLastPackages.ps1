<#
.SYNOPSIS
  Scarica l'ultimo file ZIP disponibile di un certo pacchetto selezionato.
.DESCRIPTION
  Lo script utilizza la WinSCP CLI per connettersi al server FTP Bitech e scaricare l'ultima versione di un determinato pacchetto software.
  Lo script accetta in input il nome del pacchetto: è possibile usare la Tab-completion per trovare il nome completo tra quelli disponibili.
  Il nome del pacchetto viene valutato in modalità case-sensitive e viene usato per trovare la cartella omonima sul server FTP remoto.
  Per scaricare l'ultimissima versione, viene usata la flag -latest della WinSCP CLI.
  Viene inoltre richiesto il percorso di scarico locale dei file.
.PARAMETER PACKAGELIST
  Lista dei nomi dei file ZIP di cui scaricare l'ultima versione, separati da virgola.
  Il default è "MRTInstaller".
  Deve corrispondere a uno dei valori nel ValidateSet, ovvero nell'array di possibili pacchetti scaricabili.
.PARAMETER LOCALPATH
  Percorso locale in cui salvare i pacchetti scaricati.
  Lo script ne testa l'esistenza prima di procedere.
.EXAMPLE
  PS> Get-FtpLastPackages Micronpass C:\.temp
  Scarica l'ultimo pacchetto disponibile dell'applicativo Micronpass nella cartella locale C:\.temp
.EXAMPLE
  PS> Get-FtpLastPackages -PackageList MicronService,NoService,MicronConfig -LocalPath C:\MPW
  Scarica l'ultimo pacchetto disponibile degli applicativi MicronService, NoService e MicronConfig nella cartella locale C:\MPW
.NOTES
  1.0 (testato per tutti i programmi elencati nel ValidateSet)
  TODO: Incorporare NoService quando si scarica MicronService, invece di doverlo specificare separatamente
#>

function Get-FtpLastPackages {

  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, Position = 0, 
      HelpMessage = "Digitare il percorso completo in cui salvare i file")]
    [ValidateScript ( { Test-Path $_ } )]
    [string] $LocalPath,
    [Parameter(Mandatory = $true, Position = 1, 
      HelpMessage = "Inserire i nome dei pacchetti separati da virgola (ATTENZIONE: Case-sensitive) (Tab-completion disponibile)")]
    [ValidateSet(
      "MRTInstaller",
      "Micronpass",
      "MicronService",
      "MicronServiceOffline",
      "MicronConfig",
      "MicronMail",
      "NoService",
      "TrayClient",
      IgnoreCase = $false)]
    [string[]] $PackageList
  )

  # Version
  $Version = "V750"
  Write-Verbose "Versione corrente: $Version"

  Foreach ( $Package in $PackageList) {

    # File mask (con l'eccezione di NoService)
    if ( $Package -eq "NoService" ) {
      $FileMask = "*NOSRV.zip" # Quando scarichi MicronService, scarica anche NoService
      $RemotePath = "/MRT/MRT_FX4_PC_EXE/MicronService" + "/$Version"
    }
    else {
      if ($Package -eq "TrayClient") {
        # Eccezioni che non hanno la sottocartella $VERSION
        $Version = ''
      }
      $FileMask = "$*.zip"
      $RemotePath = "/MRT/MRT_FX4_PC_EXE/$Package" + "/$Version"
    }

    # Download
    $OpenConnectionString = Open-FtpConnection
    Write-Verbose "Sto scaricando il pacchetto $Package..."
    & "C:\Program Files (x86)\WinSCP\WinSCP.com" `
      /ini=nul `
      /command `
      $OpenConnectionString `
      "cd $RemotePath" `
      "get -latest $FileMask $LocalPath\" `
      "close" `
      "exit"    

  }

  Write-Verbose "I pacchetti selezionati sono stati scaricati in $LocalPath"

}