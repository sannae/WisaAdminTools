<#
.SYNOPSIS
    Lo script si collega automaticamente al server Bitech e scarica le VR (Versioni Rilasciate) e i MT (Manuali tecnici) di un determinato cliente
.DESCRIPTION
    Lo script usa la CLI di WinSCP per connettersi al server Bitech via SFTP e scaricare i documenti indicati.
    La variabile $AllegedCustomer è la descrizione approssimativa del cliente, usata come filtro di ricerca nelle commesse.
    Lo script cerca la stringa $AllegedCustomer nella cartella /MC_COMMESSE per mostrare all'utente quali clienti corrispondono alla stringa cercata.
    La variabile $RealCustomer, richiesta all'utente, è quella usata per cercare i documenti VR e MT.
    La cartella di destinazione è scritta nella variabile $RootPath.
    I documenti vuoti (quelli che si chiamano "VR_Versione Rilasciata") vengono eliminati, e i rimanenti convertiti da DOC/DOCX in PDF.
    Un oggetto C# di classe Stopwatch misura la performance dello script e la scrive nel log.
.PARAMETER CLIENTE

.EXAMPLE
    PS> ./Get-FTPcommesse.ps1
.NOTES
    Richiede WinSCP installato e presente in C:\Program Files(x86)\WinSCP\WinSCP.exe
    Il nome del cliente nella variabile $RealCustomer deve essere preciso e case-sensitive.
    
    ### IMPORTANTE: Questo script dà per scontate una serie di convenzioni di nomenclatura.
    ### Bisogna testare con commesse particolarmente vecchie che probabilmenten non seguono queste convenzioni.

    ### TODO: E se volessi invece i documenti di una specifica commessa?
#>

# Ricerca commesse per descrizione

function Get-FTPCommesse {



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

  # Crea un sommario
  Foreach ( $file in $(Get-ChildItem -Path "$RootPath\*.doc", "$RootPath\*.pdf") ) {
    # $OldName = $file.FullName
    $NewName = $file.BaseName + ' - ' + $(Get-Content $file | Select-String -pattern "Progetto: ").Line.Split(": ")[1] + '.doc'
    Add-Content -Path "$RootPath\Sommario.txt" -value $NewName
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

  # Pulizia dei file DOC
  Remove-item -Path "$RootPath\*.doc","$RootPath\*.docx"
  Write-Host "Fine conversione file DOC in PDF"

  # Track performance
  $Clock.Stop()
  Add-Content -Path "$LocalLog" -Value "Execution time approx. $($Clock.Elapsed.Minutes) minutes $($Clock.Elapsed.Seconds) seconds"
  Write-Host "Estrazione durata circa $($Clock.Elapsed.Minutes) minuti"

}