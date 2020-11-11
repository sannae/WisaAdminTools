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
    IISAdministration (https://www.powershellgallery.com/packages/IISAdministration/1.1.0.0) 
    Dbatools (https://www.powershellgallery.com/packages/dbatools/1.0.130)

#>

# Dependencies
Import-Module .\MrtAdminTools.psm1
Import-Module IISAdministration
Import-Module Dbatools


# Estraggo tutti gli zip sotto MPW_INSTALL

# Vedo se esiste MPW_INSTALL, se no la creo
$RootFolder = Get-MPWRootFolder
$RootDisk = $RootFolder.PSDrive.Root
#   Verifico che siano presenti gli ZIP di tutti gli applicativi interdipendenti
##  Es. warning nel caso in cui ci fosse MicronService ma non NoService
# ...
#   Estraggo i file ZIP nelle corrispettive cartelle
ForEach ( $file in $(Get-ChildItem "$(Get-Location)\*.zip") ) {
    $FileBaseName = $file.BaseName 
    $FileName = $file.Name
    Expand-Archive -LiteralPath $FileName -DestinationPath $FileBaseName
    Remove-Item $file
}

<#

Interfaccia web:
+ Aggiorno Micronpass
    Trovo app pool in cui si trova mpassw
    Stoppo suddetto app pool
    Copio cartella Micronpass in Micronpass_VERSIONE
    Installo cartella virtuale aggiornata
    (DA FINIRE)

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