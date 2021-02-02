<#
.SYNOPSIS
    Stoppa l'application pool cui appartiene l'applicazione web indicata.
.DESCRIPTION
    Lo script richiama la funzione Get-WebApplicationPool per restituire un oggetto Microsoft.WebAdministration.ConfigurationElement.
    L'oggetto contiene i dettagli dell'application pool a cui appartiene l'applicazione web definita come input.
    Se lo stato dell'application pool è "Started", allora viene stoppato; in caso contrario, viene restituito un errore.
.PARAMETER APPNAME
    Nome completo dell'applicazione.
    I valori ammessi vengono letti da Json con dettagli della suite di applicazioni alla sezione WebApplications.WebApplicationFullName.
    Non ha valore di default.
.EXAMPLE
    PS> Get-WebApplicationPool -AppFullName MyWebApplicationName | Stop-WebApplicationPool
    Stoppa l'application pool restituito a monte della pipeline, ovvero quello di cui fa parte l'applicazione MyWebApplicationName.
.NOTES
    0.9 (testato dopo refactoring)
#>

function Stop-WebApplicationPool {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateScript( { $_ -in $Applications.WebApplications.WebApplicationFullName } )]
        [string] $AppFullName
    )

    # Ricava l'application pool dell'app web
    $AppPool = Get-WebApplicationPool -AppFullName $AppFullName

    # Se attivo, stoppalo
    if ( $AppPool.State -eq 'Started' ) {
        $AppPool.Stop() | Out-Null
        Write-Verbose "L'application pool $($AppPool.Name) è stato arrestato."
    }
    else {
        Write-Warning "Non posso stoppare l'application pool $($AppPool.Name) perché è già arrestato!"
    }
     
}