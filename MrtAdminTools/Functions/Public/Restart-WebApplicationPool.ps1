<#
.SYNOPSIS
    Ricicla l'application pool cui appartiene l'applicazione web indicata.
.DESCRIPTION
    Lo script richiama la funzione Get-WebApplicationPool per restituire un oggetto Microsoft.WebAdministration.ConfigurationElement.
    L'oggetto contiene i dettagli dell'application pool a cui appartiene l'applicazione web definita come input.
    Se lo stato dell'application pool è "Started", allora viene riciclato.
    Se lo stato invece è "Stopped", allora viene avviato.
.PARAMETER APPNAME
    Nome completo dell'applicazione.
    I valori ammessi vengono letti da Json con dettagli della suite di applicazioni alla sezione WebApplications.WebApplicationFullName.
    Non ha valore di default.
.EXAMPLE
    PS> Restart-WebApplicationPool -AppFullName MYWEBAPP
    Ricicla l'application pool dell'applicazione MYWEBAPP.
.NOTES
    0.9 (da testare)
#>

function Restart-WebApplicationPool {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateScript( { $_ -in $Applications.WebApplications.WebApplicationFullName } )]
        [string] $AppFullName
    )

    # Ricava l'application pool dell'app web
    $AppPool = Get-WebApplicationPool -AppFullName $AppFullName

    # Casistica
    if ( $AppPool.State -eq 'Started' ) {
        $AppPool.Recycle() | Out-Null
        Write-Verbose "Ho riciclato l'application pool $($AppPool.Name)."
    } elseif ( $AppPool.State -eq 'Stopped' )  {
        $AppPool.Start() | Out-Null
        Write-Verbose "Ho avviato l'application pool $($AppPool.Name)."
    }
     
}