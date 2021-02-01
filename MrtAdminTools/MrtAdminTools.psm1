# MrtAdminTools.psm1
#-----------------------------------------------------------------------------------------------------
# Write PowerShell to automate your business processes in order to reduce human input, errors and cost!

# Requirements
#Requires -Version 5.1
#Requires -Modules IISAdministration
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

# Load application suite details from JSON file located in module root folder
$ModuleName = Split-Path $PSScriptRoot -Leaf
$global:Applications = Get-Content -Raw -Path "$PSScriptRoot\$ModuleName.json" | ConvertFrom-Json
