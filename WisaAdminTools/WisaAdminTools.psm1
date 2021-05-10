# Module file template

# Requirements
#Requires -Version 5.1
#Requires -RunAsAdministrator

# Export public functions (tested ones)
$PublicFunctionsFiles = [System.IO.Path]::Combine($PSScriptRoot, "Functions", "Public", "*.ps1")
Get-ChildItem -Path $PublicFunctionsFiles -Exclude *.tests.ps1, *profile.ps1 | ForEach-Object {
    try {
        . $_.FullName
    }
    catch {
        Write-Warning "$($_.Exception.Message)"
    }
}

# Export private functions (maintenance)
$PrivateFunctionsFiles = [System.IO.Path]::Combine($PSScriptRoot, "Functions", "Private", "*.ps1")
Get-ChildItem -Path $PrivateFunctionsFiles -Exclude *.tests.ps1, *profile.ps1 | ForEach-Object {
    try {
        . $_.FullName
    }
    catch {
        Write-Warning "$($_.Exception.Message)"
    }
}

# Load application suite details from JSONC file located in module root folder
$ModuleName = Split-Path $PSScriptRoot -Leaf
$global:Applications = Get-Content -Raw -Path "$PSScriptRoot\Functions\.Internal\$ModuleName.json" | ConvertFrom-Json

