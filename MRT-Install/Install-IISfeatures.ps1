# Check OS type 

$OSDetails = Get-ComputerInfo
$OSType = $OSDetails.WindowsInstallationType
Write-Host "Current OS type: $OSType"

# Check if features file is present

if(!(Test-Path ".\IIS_features.csv")) { 
    Write-Host "ERROR - IIS feature list not found! Please copy it to root folder."  ; break
} 

# Load IIS Features from CSV file

$IISFeaturesList = @(Import-CSV ".\IIS_features.csv" -Delimiter ';' -header 'FeatureName','Client','Server').$OSType

# Install on workstation (DISM installation module)

if ($OSType -eq "Client"){
    foreach ($feature in $IISFeaturesList){
        Enable-WindowsOptionalFeature -All -Online -FeatureName $feature | Out-Null 
        if (!(Get-WindowsOptionalFeature -Online -FeatureName $feature).State -eq "Enabled"){
            Write-Host "ERROR - Something went wrong installing $feature, please check again!" ; break
        }
    }
} 

# Install on server (ServerManager installation module)

elseif ($OSType -eq "Server"){
    foreach ($feature in $IISFeaturesList){
        Install-WindowsFeature -Name $feature  | Out-Null
        if (!(Get-WindowsFeature -name $feature).Installed -eq $True){
            Write-Host "ERROR - Something went wrong installing $feature, please check again!" ; break
        }
    }
}

# Reset IIS

Invoke-Command -ScriptBlock {iisreset} | Out-Null
$IISVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo(“C:\Windows\system32\notepad.exe”).FileVersion
Write-Host "IIS $IISVersion successfully installed!"