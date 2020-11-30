<#
.SYNOPSIS
    Inserisce un'applicazione web già installata in un application pool.
.DESCRIPTION
    Lo script richiede il nome dell'applicazione web e l'application pool di destinazione.
    Se l'applicazione web non esiste, viene creata e assegnata all'application pool specificato.
    Se l'application pool non esiste, viene creato.
    L'application pool viene configurato con una serie di proprietà (app a 32bit, idle timeout, ecc.).
    Al termine del processo, se uscito senza errori, l'application pool viene riciclato.
.EXAMPLE
    PS> Set-MpwIISApplication -AppName "mpassw" -AppPoolName "MyAppPoolName"
.EXAMPLE
    PS> Set-MPWIISApplication "mpassw" "MyAppPoolName"
.EXAMPLE
    PS> Set-MPWIISApplication
.NOTES
    0.0
    TODO: Da rivedere completamente e testare
#>
function Set-MpwIISApplication {

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false, Position = 0)] 
            [string] $AppName = "mpassw",
        [Parameter(Mandatory = $false, Position = 1)] 
            [string] $AppPoolName = "Micronpass_AppPool"
    )

    # Inizio con Server Manager
    $manager = Get-IISServerManager

    # Aggiungo foreslash all'inizio del nome
    $AppName = "/" + $AppName

    # Crea application pool se non esiste
    if ( !( Get-IISAppPool | Where-Object {$_.Name -eq "$AppPoolName"} ) ) {
        $pool = $manager.ApplicationPools.Add("$AppPoolName")
    }
    $pool = Get-IISAppPool | Where-Object { $_.Name -eq "$AppPoolName" }

    # Setta le proprietà dell'app pool
    $pool.ManagedPipelineMode = "Integrated"
    $pool.ManagedRuntimeVersion = "v4.0"
    $pool.Enable32BitAppOnWin64 = $true
    $manager.CommitChanges()

    # Assegna l'application pool all'applicazione
    $manager.Sites["Default Web Site"].Applications["$AppName"].ApplicationPoolName = "$AppPoolName"
    $manager.CommitChanges()
    if ( !($manager.Sites["Default Web Site"].Applications["$AppName"].ApplicationPoolName -eq $AppPoolName )) {
        Write-Error "Qualcosa è andato storto assegnando l'application pool $AppPoolName all'applicazione $AppNAme"
        break
    }

    # Ricicla tutto!
    $manager.ApplicationPools["$AppPoolName"].Recycle()

}