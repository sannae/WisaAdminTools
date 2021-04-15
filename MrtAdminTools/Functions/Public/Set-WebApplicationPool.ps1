<#
.SYNOPSIS
    It configures a web application's app pool in IIS, creating it if non-existent.
.DESCRIPTION
    First of all, the script verifies that the searched application is actually installed.
    The application name is derived by the value ApplicationName in the ApplicationFullName  

    Lo script innanzitutto verifica che sia installata l'applicazione corrispondente a quella cercata.
    Il nome dell'applicazione viene ricavato dal valore ApplicationName corrispondente all'ApplicationFullName specificato dall'utente.
    I valori di ApplicationName e ApplicationFullName sono confrontati con quelli inseriti nel file ApplicationDetails.json.
    Lo script associa l'applicazione selezionata all'application pool selezionato, verificandone l'esistenza ed eventualmente creandolo.
    Vengono infine settate le impostazioni dell'application pool di destinazione.
.PARAMETER APPFULLNAME
    Nome completo dell'applicazione.
    I valori ammessi vengono letti da Json con dettagli della suite di applicazioni alla sezione WebApplications.WebApplicationFullName.
    Non ha valore di default.
.PARAMETER DESTINATIONAPPPOOLNAME
    Stringa col nome dell'Application Pool di destinazione.
    Se l'application pool in questione non esiste, ne viene creato uno omonimo.
    In ogni caso ne vengono settate le impostazioni principali (pipeline, framework, idle timeout, ecc.)
.EXAMPLE
    PS> Set-WebApplicationPool -AppFullName MYWEBAPP -DestinationAppPoolName MYWEBAPPPOOL
    Associa (ed eventualmente crea) l'application pool MYWEBAPPPOOL all'applicazione corrispondente alla descrizione MYWEBAPP
    Se MYWEBAPPPOOL è già l'application pool di appartenenza di MYWEBAPP, questo viene comunque configurato con le impostazioni di default.
.NOTES
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
        $NewAppPool = $IIS.ApplicationPools | Where-Object { $_.Name -eq "/mpassw" }
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
    $NewAppPool.ManagedRuntimeVersion = "v4.0"
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
    Restart-WebApplicationPool -AppFullName $AppFullName

} 