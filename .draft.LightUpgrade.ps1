<# Light upgrade (ovvero da 7.5.x a ultima 7.5.xxx)

L'obiettivo è quello di mettere i file zip più aggiornati in una cartella e questo script nella stessa cartella, 
spostare tutto su server ed eseguire lo script andandosi a prendere un caffè nel mentre.

Solitamente un "light upgrade" consiste nel portare tutti gli applicativi (MicronService e NoService, Micronpass Web,
Micronsin Web, MicronConfig, MicronImport, MicronMail, MicronClear, ...) all'ultima 7.5.x disponibile.
Lo script deve:
- Verificare lo stato degli applicativi installati e in uso
- Stoppare l'impianto in maniera "sicura"
- Fare l'aggiornamento
- Riavviare l'impianto in maniera "sicura"

Lo script dà per scontato che venga lanciato da una cartella che contiene gli ZIP alle ultime release 
di tutto ciò che si vuole aggiornare (come preparare questa cartella potrebbe essere oggetto di un altro script).
La cartella dovrà anche contenere i moduli PowerShell 
    IISAdministration (https://www.powershellgallery.com/packages/IISAdministration/) 
    Dbatools (https://www.powershellgallery.com/packages/dbatools/)

#>

# Dependencies
Import-Module .\MrtAdminTools.psm1
Import-Module IISAdministration
Import-Module Dbatools

# Cartella in cui si trova lo script (e quindi tutti gli altri zip)
$PSScriptRoot

# Estraggo tutti gli zip sotto MPW_INSTALL

# Vedo se esiste MPW_INSTALL, se no la creo
$RootFolder = Get-MPWRootFolder
$RootParent = ( Get-Item $RootFolder ).parent
if ( !(Test-Path "$RootParent\MPW_INSTALL") ) {
    New-Item -Path "$RootParent\MPW_INSTALL" -ItemType Directory
}
# Ci sposto dentro tutti i file zip
Move-Item -Path "$PSScriptRoot\*.zip" -Destination "$RootParent\MPW_INSTALL"
#   Estraggo i file ZIP nelle corrispettive cartelle, rimuovo gli zip
ForEach ( $file in "$RootParent\MPW_INSTALL\*.zip") {
    Expand-Archive -LiteralPath $file.Name -DestinationPath $file.BaseName
    Remove-Item $file
}

<#

Interfaccia web:
+ Aggiorno Micronpass
# Update-MrtWebAppLight.ps1

Applicativi C di configurazione e diagnostica:
+ Aggiorno MicronConfig
    Verifico di chiudere MicronConfig prima di operare
    Sovrascrivo i file (eccetto .config e .LIC)
        Attenzione che .LIC è apparsa solo da una certa versione in poi
    Test Pester: qual è la versione dell'.exe applicato? Corrisponde a quella della cartella sotto MPW_INSTALL?
    Cancello la cartella sotto MPW_INSTALL
+ Aggiorno NoService
    Estraggo la lista delle cartelle NoService presenti
    Per ogni cartella
        Sovrascrivo i file (eccetto .config e .LIC)
    Test Pester: qual è la versione dell'.exe applicato? Corrisponde a quella della cartella sotto MPW_INSTALL?
    Cancello la cartella sotto MPW_INSTALL
+ Aggiorno MicronMail (se da aggiornare)
+ Aggiorno MicronClear (se da aggiornare)
    Stop MicronClear
    Sovrascrivo i file (eccetto .config e .LIC)
    Test Pester: qual è la versione dell'.exe applicato? Corrisponde a quella della cartella sotto MPW_INSTALL?

    + Stoppo application pool di Micronpass
    Individuo l'app pool di Micronpass 

Applicativi B che interagiscono con MicronService:
+ MicronImport
+ MicSync ?

Applicativi A principali:
+ Aggiorno tutti i MicronService
    
Lancio script SQL
+ Verifico quali script sono da lanciare
    Lancio solo quelli ancora da fare

Ripristino impianto
    Avvio servizi C
    Avvio servizi B
    Avvio servizi A
    Avvio IIS

Test di funzionamento

#>