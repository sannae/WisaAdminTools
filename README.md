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
Un altro modo è aggiungere il percorso della cartella `MrtAdminTools` nel percorso salvato nella variabile `$profile`.
Nel caso in cui tale file non esistesse, è sufficiente eseguire:
```powershell
New-Item $profile
Add-content -Value 'Import-Module -Value \PATH\TO\MrtAdminTools -Path $profile'
```
In questa maniera, ogni nuova sessione Powershell importa il modulo dal percorso specificato.


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
Il modulo è stato strutturato come descritto da [Rambling Cookie Monster](http://ramblingcookiemonster.github.io/Building-A-PowerShell-Module/).

Per avere l'elenco dei _cmdlet_ inclusi nel modulo:
```powershell
Get-command -Module MrtAdminTools
```
Per avere informazioni e aiuto riguardo ad una specifica funzione:
```powershell
Get-Help FUNCTIONNAME
```

### Prerequisiti
File `ApplicationDetails.json` da mettere nella cartella root del modulo. Un template del contenuto è disponibile in `ApplicationDetails.template.json`.
Va rispettato il seguente formato:
```json
{
  "RootFolderName": "RootFolderNameValue",
  "SetupFolderName": "SetupFolderNameValue",
  "WebApplications": [
    {
      "WebApplicationFullName": "WebApplicationFullName",
      "WebApplicationName": "WebApplicationName"
    },
    ...
  ],
  "WinServices": [
    {
      "WinServiceName": "WinServiceName",
      "WinServiceDescription": "WinServiceDescription",
      "WinServiceRestartPriority": 2
    },
    ...
  ],
  "WinApplications": [
    {
      "WinApplicationFullName": "WinApplicationFullName",
      "WinApplicationName": "WinApplicationName",
      "ReferenceConfigFile": true
    }

  ]
}
```

### Funzioni testate:
Le funzioni testate sono disponibili nella sottocartella `Functions\Public`:
* `Get-AppConnectionStrings`: restituisce la stringa di connessione SQL Server al database
* `Get-AppSuiteRootFolder`: trova nel file system la cartella root dell'application suite
* `Get-WebAppCurrentVersion`: restituisce la versione corrente dell'app web
* `Get-WebApplicationPool`: restituisce l'application pool di una specifica applicazione web
* `Install-AppSuite` :star: : installa l'application Suite
* `Install-CrystalReports` :star: : installa i file MSI dei Crystal Reports
* `Install-IISFeatures` :star: : installa tutti i ruoli e funzionalità IIS
* `Invoke-DatabaseQuery` : esegue una specifica query sul database
* `Restart-WebApplicationPool` : ricicla l'application pool di una web app specifica
* `Start-WebApplicationPool` : avvia l'application pool di una web app specifica
* `Stop-WebApplicationPool` : arresta l'application pool di una web app specifica
* `Update-WebApplicationMinor` :star: : aggiorna la minor release di una web app specifica
* `Update-WinApplicationMinor` :star: : aggiorna la minor release di una Windows app specifica

Altre funzioni _helper_ sono salvate in `Functions\Private`:
* `Get-Applications` : carica l'oggetto array contenente i dettagli dell'application suite
* `Get-InstalledProgram`: verifica che un programma sia installato nel sistema
* `Get-InstallFileInfo`: ricava nome dell'applicativo e versione dal nome del file di installazione
* `Remove-InstalledProgram`: disinstalla un programma installato dal sistema
* `Test-SqlConnection`: testa la connettività verso un'istanza di SQL Server 
