# MrtAdminTools.psm1

# Controllo di versione di Powershell: ALMENO la 5.0!
<#
if ( $PVersionTable.PSVersion.Major -lt 5 ) {
    Write-Host "La tua versione di Powershell è obsoleta! Non posso eseguire questo script..."
    Write-Host "Per aggiornare Windows Powershell: https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/install/installing-windows-powershell?view=powershell-7"
    Write-Host "Per passare direttamente a Powershell Core: https://github.com/PowerShell/PowerShell"
    break
}
#>

# Export public functions

$PublicFunctionsFiles = [System.IO.Path]::Combine($PSScriptRoot,"Functions","Public","*.ps1")
Get-ChildItem -Path $PublicFunctionsFiles -Exclude *.tests.ps1, *profile.ps1 | ForEach-Object {
    try {
        . $_.FullName
    } catch {
        Write-Warning "$($_.Exception.Message)"
    }
}

# Export private functions
<#
$PrivateFunctionsFiles = [System.IO.Path]::Combine($PSScriptRoot,"Functions","Private","*.ps1")
Get-ChildItem -Path $PrivateFunctionsFiles -Exclude *.tests.ps1, *profile.ps1 | ForEach-Object {
    try {
        . $_.FullName
    } catch {
        Write-Warning "$($_.Exception.Message)"
    }
}
#>