# :hammer: MrtAdminTools :wrench:
Questo è un modulo PowerShell con alcuni strumenti utili (si spera!) per amministratori e installatori della MRT Application Suite!

## Ottenere il modulo

### Installare il modulo
Il modulo _non_ è pubblicato sulla [Powershell Gallery](https://www.powershellgallery.com/). 
Per averlo disponibile in ogni sessione PowerShell, copiare l'intera cartella `MrtAdminTools` nei propri percorsi di default dei moduli.
La lista dei percorsi di default dei moduli è visibile col comando:
```powershell
$env:PSModulePath -split ';' | Where-Object { Test-Path $_ }
``` 

### Importare il modulo nella propria sessione PowerShell
Se già copiato nei percorsi di default dei moduli:
```powershell
Import-Module MrtAdminTools
```
Altrimenti,
```powershell
Import-Module \path\to\module\MrtAdminTools\MrtAdminTools.psm1
```
Il comando `Import-module` esporterà nella sessione (tramite _dot-source_) tutte le funzioni pubbliche e private.

## Usare il modulo
Per avere l'elenco dei _cmdlet_ inclusi nel modulo:
```powershell
Get-command -Module MrtAdminTools
```
Per avere informazioni e aiuto riguardo ad una specifica funzione:
```powershell
Get-Help FUNCTIONNAME
```

### Funzioni testate:
Le funzioni testate sono disponibili nella sottocartella `Functions\Public`:
* `Get-MpwApplicationPool`: restituisce l'application pool di una specifica applicazione web
* `Get-MpwCurrentVersion`: restituisce la versione corrente di Micronpass Web
* `Get-MpwRootFolder`: trova la cartella `MPW` nel filesystem
* `Get-MrtConnectionStrings`: restituisce la stringa di connessione SQL Server al database MRT
* `Get-MrtEventLogs` :star: : raccoglie e visualizza il contenuto di tutti i log di una specifica applicazione
* `Install-IISFeatures` :star: : installa tutti i ruoli e funzionalità IIS
* `Invoke-MpwDatabaseQuery`: esegue una specifica query sul database MRT
* `Update-MrtWebApp` :star: : esegue l'aggiornamento di un'applicazione web all'ultima release

Sono disponibili anche alcune funzioni private di manutenzione (`Functions\Private`):
* `Get-FtpCommesseVR`: scarica via FTPES tutti i documenti VR (Versione Rilasciata) di uno specifico cliente
* `Get-FtpLastPackages`: scarica via FTPES il pacchetto ZIP corrispondente all'ultima release di una o più applicazioni
* `Open-FtpConnection`: apre una connessione FTPES verso il repository di sviluppo
* `Test-InstalledProgram` : verifica che un programma risulti tra i programmi installati di Windows