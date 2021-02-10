# Aggiornamento servizio di Windows
# Prende in input la cartella dove risiedono gli zip di installazione
$ZipPath
# Prende in input il nome del servizio btServiceXX
[AcceptPipelineInput]$ServiceName

# Controlla che il nome del servizio sia incluso (-IN) nel range dei nomi di servizi compatibili (btService, DBIservice, ecc.)
# i.e. Controlla che btServiceXX contenga il nome del servizio specificato in ServiceType
# Questo pezzo confronta i nomi dei servizi, quindi attenzione che siano coerenti!
# Restituisce il ServiceType corrispondente
foreach ( $Service in $Applications.WinServices.WinServiceName ) {
    $Comparison = $ServiceName -match $Service
    if ($Comparison) { $ServiceType = $Service ; break }
}

# Ferma il servizio btServiceXX, se avviato; se non riesce a fermarlo, killa il processo corrispondente
$Serv = Get-Service $ServiceName -ErrorAction SilentlyContinue 
$Serv.Stop() | Out-Null 
Start-Sleep -Seconds 3 # Ci provo gentilmente, ma aspetto al massimo 5 secondi
if ($Serv.Status -ne 'Stopped') {
    Write-Warning "Non sono riuscito ad arrestare con calma $($_.Name), quindi lo uccido :P" # E invece!
    Get-Process | Where-Object { $_.Path -eq $ServExecutable } | Stop-process -Force
}

# Da btServiceXX ricava il percorso dell'eseguibile btService.exe (MicronServiceXX)
$ServExecutable = Get-CimInstance -ClassName Win32_Service | Where-Object { $_.Name -eq $ServiceName } | Select-Object -ExpandProperty PathName
$ServicePath = (get-item $ServExecutable).Directory.FullName

# Ricavo la versione precedente
$OldVersion = [version]$(Get-Item -Path "$ServExecutable").VersionInfo.FileVersion

# Fa un backup della cartella MicronServiceXX come MicronServiceXX_OLD
$OldFolder = $ServicePath + "_" + $OldVersion
if ( !(Test-Path "$OldFolder")) {
    New-Item -Path "$OldFolder" -ItemType Directory | Out-Null
}
else {
    Write-Warning "La cartella $OldFolder esiste già!"
}
Copy-Item -Path "$ServicePath" -Destination "$OldFolder" -Recurse -Force
Write-Verbose "Ho copiato il contenuto di $ServicePath dentro a $OldFolder"

# Se non esiste la cartella MSI già spacchettata: spacchetta lo zip btServiceNEW.zip in una cartella omonima

# Se non esiste la cartella MSI già spacchettata: Spacchetta il file MSI in una cartella MSI omonima
# Copia tutti i file della cartella MSI (eccetto -EXCLUDE) e sovrascrive al percorso dell'eseguibile di btServiceXX
# Riavvia il servizio btServiceXX
# Se l'avvio non va a buon fine, effettua il rollback alla versione precedente usando MicronServiceXX_OLD

