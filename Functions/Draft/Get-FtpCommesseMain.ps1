# Pensato per ottenere tutti i documenti /docs/main di una commessa specifica

# DA FINIRE
function Get-FtpCommesseMain {

  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, Position = 0, 
      HelpMessage = "Inserire il nome del cliente")]
    [string] $AllegedCustomer,
    [Parameter(Mandatory = $true, Position = 1,
      HelpMessage = "Inserire il numero di commessa (3 cifre)")]
    [string] $Number,
    [Parameter(Mandatory = $true, Position = 2, 
      HelpMessage = "Digitare il percorso completo in cui salvare i file")]
    [ValidateScript ( { Test-Path $_ } )]
    [string] $LocalPath  
  )

  # Cliente reale
  $RealCustomer = Get-FtpCustomer -AllegedCustomer $AllegedCustomer

  # Percorso remoto della commessa
  $RemotePath = '""/MC_Commesse/CO ' + $RealCustomer + '/' + $Number + "*"
  $RemoteCommessa = '/Docs/Main/'

  # Credenziali di connessione
  $OpenConnectionString = Open-FtpConnection 

  # Download
  Write-Verbose "Download in corso dal server FTP..."
  & "C:\Program Files (x86)\WinSCP\WinSCP.com" `
    /ini=nul `
    /command `
      $OpenConnectionString `
      "ls $RemotePath" `
      "ls $RemoteCommessa" `
      "get -filemask=AP_$RealCustomer-$Number*.doc $RemotePath $LocalPath" `
      "get -filemask=CN_$RealCustomer-$Number*.doc $RemotePath $LocalPath" `
      "get -filemask=VR_$RealCustomer-$Number*.doc $RemotePath $LocalPath" `
      "get -filemask=VL_$RealCustomer-$Number*.doc $RemotePath $LocalPath" `
      "exit"

}