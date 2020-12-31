# Installa un nuovo servizio, creando le cartelle e la configurazione necessari
# L'ideale sarebbe che funzionasse per TUTTI i servizi!

# Da finire!

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

    # Calcola Service Number sulla base dell'ultimo installato
    $LastService = Get-Service -Name $ServiceName,$ServiceName"??" |
        Sort-Object -Property Name | 
        Select-Object -Last 1
    if ( $($LastService).Name -eq 'btService' ) {
        $NewServiceLabel = '01'
        $NewServiceCode = '0002'
    } else {
        $CurrentServiceLabel = $LastService.DisplayName.Substring($LastService.DisplayName.length-2,2) -AS [Int]
        $NewServiceLabel = $CurrentServiceLabel + 1
        $NewServiceLabel = '{0:d2}' -f [int]$NewServiceLabel
    }

    # Componi nuovo nome servizio (es. btServiceXX)
    $NewServiceName = $ServiceName + $NewServiceLabel

    # Crea nuova cartella e copia tutto il contenuto dell'originale (es. MicronServiceXX)
    $NewServiceFolder = $ApplicationName + $NewServiceLabel
    New-Item -Path "$RootFolder\$NewServiceFolder" -ItemType Directory
    Copy-Item -Path "$RootFolder\$ApplicationName\*" -Destination "$RootFolder\$NewServiceFolder"

    # Installazione con New-Service
    $params = @{
        Name = "$NewServiceName"
        BinaryPathName = "$RootFolder\$NewServiceFolder\$ServiceName.exe"
        DisplayName = "$NewServiceName"
        StartupType = "Automatic"
        Description = "$ServiceDescription"
      }
    New-Service @params

    # Modifica parametro Code nel file config
    Update-MrtConfigFile("$RootFolder\$NewServiceFolder\$ServiceName.exe.config","codService",$NewServiceCode)

    # Duplicazione dei parametri nella T103COMPARAMS, copiandoli dal servizio precedente
    

    # Elaborazione dei parametri T03COMSERVICES
    # ... Questo è più un casino, c'è da calcolare tutte le porte
    
     

    
}