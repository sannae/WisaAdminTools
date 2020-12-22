# Installa un nuovo servizio, creando le cartelle e la configurazione necessari

function New-MrtService {

    $RootFolder = Get-MpwRootFolder

    # Selezione del tipo di servizio
    if ( $ApplicationName -eq "MicronService") 
        { $ServiceName = "btService" ; $ServiceDescription = 'MicronService communication service' ; $ServiceConfigFile = "$RootFolder\$ApplicationName\$Servicename.exe.config"}
        # ...

    # Crea l'oggetto Servizio
    [PSCustomObject]@{
        ServiceName = $ServiceName
        ApplicationName = $ApplicationName
        Description = $ServiceDescription
        ConfigFile = $ServiceConfigFile
    }

    # Calcola Service Number sulla base di quelli già esistenti
    $LastService = Get-Service -Name btService* -Exclude btServiceOffline* | 
        Sort-Object -Property Name | 
        Select-Object -Last 1
    if ( $LastService -eq 'btService' ) {
        $NewServiceLabel = '01'
        $NewServiceNumber = '0002'
    } else {
        $CurrentServiceLabel = $LastService.DisplayName.Substring($LastService.DisplayName.length-2,2) -AS [Int]
        $NewServiceLabel = $CurrentServiceLabel + 1
        $NewServiceLabel = '{0:d2}' -f [int]$NewServiceLabel
    }

    # Componi nuovo nome servizio (es. btServiceXX)
    $NewServiceName = $ServiceName + $NewServiceLabel

    # Installazione con New-Service
    $params = @{
        Name = "$NewServiceName"
        BinaryPathName = "$RootFolder\$ApplicationName\$NewServiceName.exe"
        DisplayName = "$NewServiceName"
        StartupType = "Automatic"
        Description = $Description
      }
    New-Service @params

    # Modifica parametro Code nel file config
    Update-MrtConfigFile("$RootFolder\$ApplicationName\$ServiceName.exe.config","codService",$NewServiceNumber)

    # Duplicazione dei parametri nella T103COMPARAMS, copiandoli dal servizio precedente
      # ...

}