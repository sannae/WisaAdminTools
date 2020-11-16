<#
.SYNOPSIS
    Inserisce un'applicazione web già installata in un application pool.
.DESCRIPTION
    Lo script richiede il nome dell'applicazione web e l'application pool di destinazione.
    Se l'application pool non esiste, viene creato.
    L'application pool viene configurato con una serie di proprietà (app a 32bit, idle timeout, ecc.).

.EXAMPLE
    PS> Set-IISApplication "/mpassw" "MyAppPoolName"
.NOTES
    Richiede IISAdministration (https://www.powershellgallery.com/packages/IISAdministration/) 
    TODO:
#>
function Set-MpwIISApplication {

    [CmdletBinding()]
    Param(
        [Parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)] 
            [string] $AppName = "/mpassw",
        [Parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true,
            Position = 1)] 
            [string] $AppPoolName = "Micronpass",
        [Parameter(
            Mandatory = $false,
            Position = 2)]
            [string] $Root
        )

    Import-Module IISAdministration

    # Crea application pool se non esiste

    $manager = Get-IISServerManager
    if ( !( Get-IISAppPool | Where-Object {$_.Name -eq "$AppPoolName"} ) ) {
        $pool = $manager.ApplicationPools.Add("$AppPoolName")
    }
    $pool.ManagedPipelineMode = "Integrated"
    $pool.ManagedRuntimeVersion = "v4.0"
    $pool.Enable32BitAppOnWin64 = $true
    $manager.CommitChanges()

    # Crea applicazione in directory virtuale sotto Default Web Site

    $app = $manager.Sites["Default Web Site"].Applications.Add("$AppName", "$Root\Micronpass")
    $manager.CommitChanges()

    # Test

    $manager.Sites["Default Web Site"].Applications | Where-Object {$_.Path -eq "$AppName"}

    # Assegna l'application pool all'applicazione

    $manager.Sites["Default Web Site"].Applications["$AppName"].ApplicationPoolName = "$AppPoolName"
    $manager.CommitChanges()

    # Test

    $manager.Sites["Default Web Site"].Applications["$AppName"] | Select-Object ApplicationPoolName

    # Ricicla tutto!

    $manager.ApplicationPools["$AppPoolName"].Recycle()

}