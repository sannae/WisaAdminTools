<#
.SYNOPSIS
    Aggiorna Micronpass all'ultima versione (entro la stessa minor).
.DESCRIPTION
    Lo script richiede il .zip di Micronpass Web alla versione minor/patch più recente.
    Ad esempio, questo script può aggiornare una 7.5.4 a una 7.5.600, ma NON a una 7.6.0.
    I file della versione 'vecchia' vengono salvati in una cartella Applicazione_OLDVERSION
    Attenzione : vengono esclusi dalla sovrascrittura i file web.config e LIC
.EXAMPLE
    PS> Update-MrtWebAppLight "mpassw"
.NOTES
    TODO: da testare alla prima installazione 'vergine'
#>

function Update-MrtWebAppLight {

    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)] 
            [string] $AppName = "mpassw"
    )

    # Trovo app pool in cui si trova l'app web
    $AppPoolName = $manager.Sites.Applications | Where-Object { $_.Path -eq "$AppName" } | Select-Object ApplicationPoolName
    $AppPool = $manager.ApplicationPools | Where-Object { $_.Name -eq $AppPoolName.ApplicationPoolName }
    Write-Verbose "Micronpass Web trovato nell'application pool $AppPool, arresto in corso..."

    # Stoppo suddetto app pool
    $AppPool.Stop()

    # Tolgo il simbolo '$' dal nome dei file da installare, se no fa casino
    $InstallFile = $(Get-Childitem "$PSScriptRoot\*.zip")
    Rename-Item $InstallFile -NewName $InstallFile.Name.Substring(1)
    $InstallFile = $(Get-Childitem "$PSScriptRoot\*.zip")

    # Copio cartella Micronpass in Micronpass_OLDVER ricavando vecchia versione
    $RootFolder = Get-MPWRootFolder
    $OldVersionString = $(Get-Item "$RootFolder\Micronpass\bin\mpassw.dll").versioninfo.fileversion.substring(0,7)
    $OldVersion = [version]$OldVersionString
    $OldFolder = "Micronpass_$OldVersionString"
    New-Item -Path "$RootFolder\$OldFolder" -ItemType Directory
    Copy-Item -Path "$RootFolder\Micronpass\*" -Destination "$RootFolder\$OldFolder"

    # Estraggo installer dallo zip e ricavo nuova versione
    Expand-Archive -Path $( Get-Item "$PSScriptRoot\*.zip" ).Name -DestinationPath $( Get-Item "$PSScriptRoot\*.zip" ).BaseName
    $NewVersionString = $( Get-Item "$PSSCriptRoot\bin\mpassw.dll").versioninfo.fileversion.substring(0,7)
    $NewVersion = [version]$NewVersionString

    #Installo cartella virtuale aggiornata sotto \inetpub\wwwroot\MpassUpgrade
    $msiArguments = '/a',"$PSScriptRoot\Micronpass*\*.msi",'/qb','targetvdir="MpassUpgrade"'
    Start-Process -PassThru -Wait msiexec -ArgumentList $msiArguments
    if ( !(Test-Path "C:\inetpub\wwwroot\MpassUpgrade") ) {
        Write-Host "Something went wrong installing $InstallFile!" -ForegroundColor Red
        break
    }

    # Sovrascrivo ricorsivamente i file appena unzippati in MPW\Micronpass (escludi web.config e licenza)
    Get-Item -Path  "C:\inetpub\wwwroot\MpassUpgrade\*" -Exclude @('Web.config','MRT.lic') |
        Copy-Item  -Path  "C:\inetpub\wwwroot\MpassUpgrade\*" -Destination "$RootFolder\Micronpass\*" -Recurse -force

    # Comparazione di versioni
    Write-Host "Applicazione aggiornata da $OldVersion a $NewVersion"

    # Riavvio app pool
    $AppPool.Start()
    Start-Sleep -Seconds 5

    # Apri browser
    Start-Process "http://localhost/mpassw"

}