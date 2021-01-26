<#
.SYNOPSIS
    Sposta un'applicazione su un application pool, verificandone l'esistenza.
.DESCRIPTION
    Lo script innanzitutto verifica che sia installata l'applicazione corrispondente a quella cercata.
    Il nome dell'applicazione viene ricavato dal valore ApplicationName corrispondente all'ApplicationFullName specificato dall'utente.
    I valori di ApplicationName e ApplicationFullName sono confrontati con quelli inseriti nel file ApplicationDetails.json.
    Lo script associa l'applicazione selezionata all'application pool selezionato, verificandone l'esistenza ed eventualmente creandolo.
    Vengono infine settate le impostazioni dell'application pool di destinazione.
.EXAMPLE
    PS> Set-WebApplicationPool -AppFullName MYWEBAPP -DestinationAppPoolName MYWEBAPPPOOL
    Associa (ed eventualmente crea) l'application pool MYWEBAPPPOOL all'applicazione corrispondente alla descrizione MYWEBAPP
.NOTES
    0.9 (da finire di testare)
    Big thanks to https://octopus.com/blog/iis-powershell#assigning-application-pools !
    Per cancellare un application pool,
        $IIS = Get-IISServerManager
        $pool = $IIS.ApplicationPools["MyAppPool"]
        $IIS.ApplicationPools.Remove($pool)
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

        # Aggiungi il nuovo application pool
        Write-Verbose "L'application pool $DestinationAppPoolName cercato non esiste! Lo creo..."
        $NewAppPool = $IIS.ApplicationPools.Add($DestinationAppPoolName)

    } else {

        # Assegna variable application pool
        $NewAppPool = $IIS.ApplicationPools | Where-Object { $_.Name -eq $DestinationAppPoolName }
    }

    # Salva applicazione
    $App = $IIS.Sites.Applications | Where-Object { $_.Path -eq $AppName}

    # Assegna applicazione all'application pool di destinazione
    Write-Verbose "Assegno l'applicazione $AppName all'application pool $DestinationAppPoolName..."
    $App.ApplicationPoolName = $DestinationAppPoolName
    if ( !($App.ApplicationPoolName -eq $DestinationAppPoolName) ) {
        Write-Error "Non sono riuscito ad associare l'applicazione $AppName all'application pool $DestinationAppPoolName!"
        break
    }

    # Impostazioni avanzate application pool
    $NewAppPool.ManagedPipelineMode = "Integrated"
    $NewAppPool.ManagedRuntimeVersion = "4.0"
    $NewAppPool.Enable32BitAppOnWin64 = $true
    $NewAppPool.AutoStart = $true
    $NewAppPool.StartMode = "OnDemand"
    $NewAppPool.ProcessModel.IdentityType = "ApplicationPoolIdentity"
    $NewAppPool.ProcessModel.idleTimeout = "08:00:00"

    # Salva (e dai il tempo di salvare)
    Write-Verbose "Sto salvando le modifiche su IIS..."
    $IIS.CommitChanges()
    Start-Sleep -Seconds 5

    # Ricicla tutto!
    Write-Verbose "Sto avviando l'application pool $DestinationAppPoolName..."
    $IIS.ApplicationPools[$DestinationAppPoolName].Recycle() | Out-null

} 