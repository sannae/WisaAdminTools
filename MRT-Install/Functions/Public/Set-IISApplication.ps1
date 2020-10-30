# v1.0.0, tested
function Configure-IIS {

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

    # Crea application pool

    $manager = Get-IISServerManager
    $pool = $manager.ApplicationPools.Add("$AppPoolName")
    $pool.ManagedPipelineMode = "Integrated"
    $pool.ManagedRuntimeVersion = "v4.0"
    $pool.Enable32BitAppOnWin64 = $true
    $manager.CommitChanges()

    # Test

    Get-IISAppPool | Where-Object {$_.Name -eq "$AppPoolName"}

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