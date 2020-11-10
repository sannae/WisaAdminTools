function Install-IISFeatures {

    [CmdletBinding()] param ()

    # Controlla il tipo di OS

    $OSType = $(Get-ComputerInfo).WindowsInstallationType
    Write-Host "Current OS type: $OSType"

    # Verifica l'esistenza del file CSV

    if( !(Test-Path "./IIS_features.csv") ) { 
        Write-Host "IIS feature list not found! Please copy it to root folder." -ForegroundColor Red ; break
    } 

    # Crea lista da file CSV

    $IISFeaturesList = @(Import-CSV "IIS_features.csv" -Delimiter ';' -header 'FeatureName','Client','Server').$OSType

    # Installa su workstation (modulo DISM)

    if ($OSType -eq "Client"){
        foreach ($feature in $IISFeaturesList){
            Enable-WindowsOptionalFeature -All -Online -FeatureName $feature | Out-Null 
            if (!(Get-WindowsOptionalFeature -Online -FeatureName $feature).State -eq "Enabled"){
                Write-Host "Something went wrong installing $feature, please check again!" -ForegroundColor Red ; break
            } 
        }
    }

    # Installa su server modulo ServerManager

    elseif ($OSType -eq "Server"){
        foreach ($feature in $IISFeaturesList){
            Install-WindowsFeature -Name $feature  | Out-Null
            if (!(Get-WindowsFeature -name $feature).Installed -eq $True){
                Write-Host "Something went wrong installing $feature, please check again!" -ForegroundColor Red ; break
            }
        }
    }

    # RiavviaIIS

    Invoke-Command -ScriptBlock { iisreset } | Out-Null

    # Verifica versione di IIS

    if (Get-ChildItem 'HKLM:\SOFTWARE\Microsoft' | Where-Object {$_.Name -match 'InetStp'}) {
        $IISVersion = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\InetStp\).MajorVersion
        Write-Host "IIS $IISVersion successfully installed!"
    } else {
        Write-Host "IIS not fully installed, please check again" -ForegroundColor Red
    }

}