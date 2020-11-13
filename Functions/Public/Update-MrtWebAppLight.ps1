<#
.SYNOPSIS
    Aggiorna un'applicazione web all'ultima versione (entro la stessa minor).
.DESCRIPTION
    Lo script richiede il .zip di Micronpass Web alla versione minor/patch più recente.
    Ad esempio, questo script può aggiornare una 7.5.4 a una 7.5.600, ma NON a una 7.6.0.
    I file della versione 'vecchia' vengono salvati in una cartella Applicazione_OLDVERSION
    
.EXAMPLE
    PS> Update-MrtWebAppLight "mpassw"
.NOTES
    Richiede IISAdministration (https://www.powershellgallery.com/packages/IISAdministration/) 
    TODO:
#>

# Dependencies
Import-Module IISAdministration



# Trovo app pool in cui si trova l'app web
$AppPoolName = $manager.Sites.Applications | Where-Object { $_.Path -eq "$AppName" } | Select-Object ApplicationPoolName
$AppPool = $manager.ApplicationPools | Where-Object { $_.Name -eq $AppPoolName.ApplicationPoolName }

# Stoppo suddetto app pool
$AppPool.Stop()

# Tolgo il simbolo '$' dal nome dei file da installare, se no fa casino
$InstallFile = $(Get-Childitem "$PSScriptRoot\*.zip")
Rename-Item $InstallFile -NewName $InstallFile.Name.Substring(1)

# Copio cartella Micronpass in Micronpass_OLDVER
$RootFolder = Get-MPWRootFolder
$VersionString = $(Get-Item "$RootFolder\Micronpass\bin\mpassw.dll").versioninfo.filversion.substring(0,7)
$OldFolder = "Micronpass_$VersionString"
New-Item -Path "$RootFolder\$OldFolder" -ItemType Directory
Copy-Item -Path "$RootFolder\Micronpass\*" -Destination "$RootFolder\$OldFolder"

#Installo cartella virtuale aggiornata
    # msiexec /a mpassinst.msi /qb targetvdir="mpassw_NEWVER"
#>