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
#>


function Get-MpwApplicationPool {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0)] 
            [string] $AppName = "mpassw"
    )

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