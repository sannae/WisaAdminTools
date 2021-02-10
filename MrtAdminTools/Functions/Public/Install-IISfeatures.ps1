<#
.SYNOPSIS
    Installa il ruolo IIS e le corrispondenti funzionalità minime.
.DESCRIPTION
    Lo script ricava la lista delle funzionalità necessarie dal file JSON contenente la sezione SystemRequirements.IISFeatures.
    Verifica su quale tipo di sistema operativo sta girando (client/server) e installa le corrispondenti funzionalità.
.EXAMPLE
    PS> Install-IISFeatures
.VERSION
    1.0 (testato)
    TODO: Inserire lo switch per il caricamento delle features da CSV
#>

function Install-IISFeatures {

    [CmdletBinding()] 
    param ()

    # Controlla il tipo di OS
    $OSType = $(Get-ComputerInfo).WindowsInstallationType
    Write-Verbose "Il tipo di OS corrente è: $OSType"

    # Carica features da JSON
    $IIS = $Applications.SystemRequirements.IISfeatures

    # Crea lista delle features
    $IISFeaturesList = @()
    foreach ( $feature in $IIS.PSObject.Properties ) {
        $IISFeaturesList = $IISFeaturesList + $feature.value.$OSType
    }

    # Installa su workstation (modulo DISM)
    if ($OSType -eq "Client") {
        foreach ($feature in $IISFeaturesList) {
            Write-verbose -Message "Sto installando la feature $feature..."
            Enable-WindowsOptionalFeature -All -Online -FeatureName $feature | Out-Null 
            if (!(Get-WindowsOptionalFeature -Online -FeatureName $feature).State -eq "Enabled") {
                Write-Error "Non sono riuscito ad installare $feature, verificare!" -ForegroundColor Red ; break
            } 
        }
    }

    # Installa su server (modulo ServerManager)
    elseif ($OSType -eq "Server") {
        foreach ($feature in $IISFeaturesList) {
            Write-Verbose "Installing $feature..."
            Install-WindowsFeature -Name $feature  | Out-Null
            if (!(Get-WindowsFeature -name $feature).Installed -eq $True) {
                Write-Error "Non sono riuscito a installare $feature, verificare!" -ForegroundColor Red ; break
            }
        }
    }

    # Riavvia IIS
    Invoke-Command -ScriptBlock { iisreset } | Out-Null

    # Verifica versione di IIS come test di installazione
    if (Get-ChildItem 'HKLM:\SOFTWARE\Microsoft' | Where-Object { $_.Name -match 'InetStp' }) {
        $IISVersion = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\InetStp\).MajorVersion
        Write-Host "IIS versione $IISVersion è stato installato con sucesso!" -ForegroundColor Green
    }
    else {
        Write-Error "IIS non è stato installato in maniera completa, verificare!"
    }

}