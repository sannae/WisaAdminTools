# Installa un nuovo servizio, creando le cartelle e la configurazione necessari

function New-MrtService {

    # Selezione del tipo di servizio
    if ( $ApplicationName -eq "MicronService") { $ServiceName = "btService" ; $Description = 'MicronService communication service'}
        # ...

    # Installazione con New-Service
    $params = @{
        Name = "$ServiceName"
        BinaryPathName = "$RootFolder\$ApplicationName\$ServiceName.exe"
        DisplayName = "$ServiceName"
        StartupType = "Automatic"
        Description = $Description
      }
    New-Service @params

    # Modifica parametro Code nel file config
    $XmlConfigFile = [xml](Get-Content "$RootPath\$ApplicationName\$ServiceName.exe.config")
    $XmlConfigFile.SelectSingleNode

    # Duplicazione dei parametri nella T103COMPARAMS, copiandoli dal servizio precedente

}