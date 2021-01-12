<#
.SYNOPSIS
    Restituisce l'application pool a cui appartiene l'applicazione web specificata.
.DESCRIPTION
    Utilizza il modulo IISAdministration per cercare l'application pool a cui appartiene la web app data come input.
    Al di là della Micronpass suite, può essere usato per qualsiasi applicazione web di cui si conosca il nome.
    Se non viene specificata alcuna web app, il default è "mpassw".
    Ritorna un oggetto Microsoft.WebAdministration.ConfigurationElement.
.PARAMETER APPNAME
    Nome esatto dell'applicazione (valori ammessi: mpassw, msinw, micronpassmvc
    Valore di default uguale a "mpassw".
.EXAMPLE
    PS> $AppPool = Get-MpwApplicationPool -AppName "mpassw"
.EXAMPLE
    PS> Get-MpwApplicationPool
.NOTES
    1.0 (testato)
    TODO: Introdurre la funzione Get-Application
#>


function Get-MpwApplicationPool {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0)] 
            [string] $AppFullName = "Micronpass"
    )

    # Seleziona l'application name
    if ( $AppFullName -eq "Micronpass" ) {
        $AppName = "mpassw"
    } elseif ( $AppFullName -eq "Micronsin" ) {
        $AppName = "msinw"
    } elseif ( $AppFullName -eq "MicronpassMVC") {
        $AppName = "micronpassmvc"
    } else {
        Write-Error "Applicazione $AppFullName non trovata! Inserire un nome valido."
        break
    }

    # Inizializza IISAdministration
    $manager = Get-IISServerManager

    # Formatta nome dell'applicazione
    $AppName = "/" + $AppName

    # Trovo app pool in cui si trova l'app web
    $AppPoolName = $manager.Sites.Applications | Where-Object { $_.Path -eq "$AppName" } | Select-Object ApplicationPoolName
    $AppPool = $manager.ApplicationPools | Where-Object { $_.Name -eq $AppPoolName.ApplicationPoolName }

    # Ritorna oggetto application pool
    $AppPool

}