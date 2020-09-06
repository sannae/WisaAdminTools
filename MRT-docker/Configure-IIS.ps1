# v1.0.0, tested

Import-Module IISAdministration

# Crea application pool

$manager = Get-IISServerManager
$pool = $manager.ApplicationPools.Add("TEST")
$pool.ManagedPipelineMode = "Integrated"
$pool.ManagedRuntimeVersion = "v4.0"
$pool.Enable32BitAppOnWin64 = $true
$manager.CommitChanges()

# Test

Get-IISAppPool | Where-Object {$_.Name -eq "TEST"}

# Crea applicazione in directory virtuale sotto Default Web Site

$app = $manager.Sites["Default Web Site"].Applications.Add("/mpassw", "C:\MPW\Micronpass")
$manager.CommitChanges()

# Test

$manager.Sites["Default Web Site"].Applications | Where-Object {$_.Path -eq '/mpassw'}

# Assegna l'application pool all'applicazione

$manager.Sites["Default Web Site"].Applications["/mpassw"].ApplicationPoolName = "TEST"
$manager.CommitChanges()

# Test

$manager.Sites["Default Web Site"].Applications["/mpassw"] | Select-Object ApplicationPoolName

