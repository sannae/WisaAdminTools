# MrtAdminTools.psm1

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

$PrivateFunctionsFiles = [System.IO.Path]::Combine($PSScriptRoot,"Functions","Private","*.ps1")
Get-ChildItem -Path $PrivateFunctionsFiles -Exclude *.tests.ps1, *profile.ps1 | ForEach-Object {
    try {
        . $_.FullName
    } catch {
        Write-Warning "$($_.Exception.Message)"
    }
}
