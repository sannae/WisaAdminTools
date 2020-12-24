<#
.SYNOPSIS
  Lo script si collega automaticamente al server Bitech e scarica le VR (Versioni Rilasciate) e i MT (Manuali tecnici) di un determinato cliente.
.DESCRIPTION
  L'idea è quella di avere una panoramica delle personalizzazioni software/firmware richieste da un cliente.
  Lo script usa la CLI di WinSCP per connettersi al server Bitech via SFTP e scaricare i documenti indicati.
  La variabile $AllegedCustomer è la descrizione approssimativa del cliente, usata come filtro di ricerca nelle commesse.
  Per passare dal cliente 'approssimativo' $AllegedCustomer al cliente con dicitura 'reale' $RealCustomer viene chiamata la funzione Get-FtpCustomer.
  La variabile $RealCustomer, richiesta all'utente, è quella usata per cercare i documenti VR e MT.
  La cartella di destinazione è scritta nella variabile $LocalPath.
  I documenti vuoti (quelli che si chiamano "VR_Versione Rilasciata") vengono eliminati, e i rimanenti convertiti da DOC/DOCX in PDF.
  Un oggetto C# di classe Stopwatch misura la performance dello script e la scrive nel log.
.PARAMETER ALLEGEDCUSTOMER
  Nome del cliente cercato, anche approssimativo. 
  Lo script prevede uno step interattivo in cui l'utente deve selezionare il risultato corretto tra quelli trovati. 
.PARAMETER ROOTPATH
  Percorso in cui scaricare i file. La validità del percorso viene testata.
.EXAMPLE
  PS> ./Get-FTPcommesse.ps1 -AllegedCustomer Cliente -LocalPath "C:\.temp"
.NOTES
  1.0 (Testato)
  Richiede WinSCP installato e presente in C:\Program Files(x86)\WinSCP\WinSCP.exe
  IMPORTANTE: Questo script dà per scontate una serie di convenzioni di nomenclatura.
  TODO: Bisogna testare con commesse particolarmente vecchie che probabilmente non seguono queste convenzioni.
#>

function Get-FtpCommesseVR {

  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, Position = 0, 
    HelpMessage="Inserire il nome del cliente")]
      [string] $AllegedCustomer,
    [Parameter(Mandatory = $true, Position = 1, 
    HelpMessage="Digitare il percorso completo in cui salvare i file")]
    [ValidateScript ( { Test-Path $_} )]
          [string] $LocalPath  
  )

  # Fai selezionare all'utente il cliente
  Write-Verbose "Sto cercando il cliente $AllegedCustomer nel repository delle commesse..."
  $RealCustomer = Get-FtpCustomer $AllegedCustomer
  Write-Verbose "È stato selezionato il cliente $RealCustomer"
  $RemotePath = '""/MC_Commesse/CO ' + $RealCustomer + '""'

  # Dove si vogliono salvare i documenti finali; viene anche creato un log
  $LocalLog = "$LocalPath\WinSCP_commesse.log"
  if ( Test-Path "$LocalPath\WinSCP_commesse.log" ) {
    Remove-Item -Path "$LocalLog"
  }
  Write-Verbose "I file di commessa verranno scaricati in $LocalPath . È disponibile un log della connessione FTP in $LocalLog"

  # LocalPath (CASE SENSITIVE) : cartella temporanea in cui verranno salvati tutti i documenti prima di essere filtrati
  New-Item -Path $LocalPath -Name "temp" -ItemType "Directory" | Out-Null
  $LocalTempPath = "$LocalPath\temp"

  # Inizio orologio
  $Clock = [Diagnostics.Stopwatch]::StartNew()
  
  # Credenziali di connessione
  $OpenConnectionString = Open-FtpConnection 

  # Download
  Write-Verbose "Download in corso dal server FTP..."
  & "C:\Program Files (x86)\WinSCP\WinSCP.com" `
    /log="$LocalLog" /ini=nul `
    /command `
      $OpenConnectionString `
      "cd $RemotePath" `
      "get -filemask=VR_*.doc $RemotePath $LocalTempPath" `
      "get -filemask=MT_*.doc $RemotePath $LocalTempPath" `
      "exit" | Out-Null
 
  # Spostare i file ricavati da LocalPath a LocalPath, rimuovendo tutte le cartelle vuote e le commesse non chiuse
  Foreach ( $file in $(Get-ChildItem -Path "$LocalTempPath\*.doc", "$LocalTempPath\*.pdf" -Recurse) ) {
    Move-Item -Path $file -Destination $LocalPath
  }
  Remove-Item -Recurse $LocalTempPath
  if ( Test-Path -Path "$LocalPath\VR_Versione_rilasciata.doc" ) {
    Remove-Item -Path "$LocalPath\VR_Versione_rilasciata.doc"
  }

  # Rinomina i file come da oggetto di ciascun Word 
  Write-Verbose "Rinomino i file scaricati con la corrispondente descrizione..."
  Foreach ( $file in $(Get-ChildItem -Path "$LocalPath\*.doc", "$LocalPath\*.pdf") ) {
    $Titolo = $(Get-Content $file | Select-String -pattern "Progetto: ").Line.Split(": ")[1] # Titolo del progetto
    $Titolo = $Titolo.Substring(0,$Titolo.Length-2) # Gli ultimi due caratteri, non validi per la stringa, sono scartati
    $Titolo = $Titolo -Replace "/","-"
    $NewName = $file.BaseName + ' - ' + $Titolo + '.doc'
    Rename-Item -Path $file -NewName $NewName
    Write-Verbose "Ho rinominato il file $file"
  }
  
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
  ConvertTo-PdfFromWord $LocalPath

  # Track performance
  $Clock.Stop()
  Add-Content -Path "$LocalLog" -Value "Execution time approx. $($Clock.Elapsed.Minutes) minutes $($Clock.Elapsed.Seconds) seconds"
  Write-Verbose "Estrazione durata circa $($Clock.Elapsed.Minutes) minuti"

  # Open folder
  Write-Verbose "Sto aprendo la cartella $LocalPath..."
  Invoke-Item $LocalPath

}