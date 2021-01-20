<#
.SYNOPSIS
    Sposta un'applicazione su un application pool, verificandone l'esistenza.
.DESCRIPTION

.EXAMPLE

.EXAMPLE

.NOTES
    Big thanks to https://octopus.com/blog/iis-powershell#assigning-application-pools !
#>
function Set-WebApplicationPool {

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateScript( { $_ -in $Applications.WebApplications.WebApplicationFullName } )]
        [string] $AppFullName,
        [Parameter(Mandatory = $false, Position = 1)] 
        [string] $DestinationAppPoolName
    )

    # Inizio con server manager
    $IIS = Get-IISServerManager

    # Verifica se c'è l'applicazione
    $AppName = $($Applications.WebApplications | Where-Object {$_.WebApplicationFullName -eq $AppFullName }).WebApplicationName
    $AppName = "/" + $AppName
    if ( !($AppName -in $IIS.Sites.Applications.Path) ){
        Write-Error "Non ho trovato alcuna applicazione con nome $AppName!"
        break
    }

    # Verifica se c'è l'app pool
    if ( !($DestinationAppPoolName -in $IIS.ApplicationPools.Name) ){
        Write-Verbose "L'application pool $DestinationAppPoolName cercato non esiste! Lo creo..."
        # Crea application pool
    }

    # Assegna applicazione all'application pool di destinazione

    # Setta le proprietà dell'application pool di destinazione

    # Ricicla tutto!

} 