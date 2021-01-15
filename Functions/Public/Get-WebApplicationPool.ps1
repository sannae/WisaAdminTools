<#
.SYNOPSIS
    Restituisce l'application pool a cui appartiene l'applicazione web specificata.
.DESCRIPTION
    Utilizza il modulo IISAdministration per cercare l'application pool a cui appartiene la web app data come input.
    Può essere usato per qualsiasi applicazione web di cui si conosca il nome.
    Ritorna un oggetto Microsoft.WebAdministration.ConfigurationElement.
.PARAMETER APPNAME
    Nome completo dell'applicazione.
    I valori ammessi vengono letti da Json con dettagli della suite di applicazioni alla sezione WebApplications.WebApplicationFullName.
    Non ha valore di default.
.EXAMPLE
    PS> $AppPool = Get-WebApplicationPool -AppFullName MyWebApplicationName
.EXAMPLE
    PS> Get-WebApplicationPool
.NOTES
    0.9 (testare dopo refactoring)
#>


function Get-WebApplicationPool {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateScript( { $_ -in $Applications.WebApplications.WebApplicationFullName } )]
            [string] $AppFullName
    )

    # Seleziona l'application name
    $AppName = $($Applications.WebApplications | Where-Object {$_.WebApplicationFullName -eq $AppFullName }).WebApplicationName

    # Inizializza IISAdministration
    $manager = Get-IISServerManager

    # Formatta nome dell'applicazione
    $AppName = "/" + $AppName

    # Trovo app pool in cui si trova l'app web
    $AppPoolName = $manager.Sites.Applications | Where-Object { $_.Path -eq "$AppName" } | Select-Object ApplicationPoolName
    if ($null -eq $AppPoolName ) {
        Write-Error "Application Pool associato all'applicazione $AppName non trovato!"
        break
    }    
    $AppPool = $manager.ApplicationPools | Where-Object { $_.Name -eq $AppPoolName.ApplicationPoolName }

    # Ritorna oggetto application pool
    $AppPool

}