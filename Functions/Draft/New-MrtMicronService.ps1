function New-MrtMicronService {

    # Nuovo nome del servizio (attenzione al primo btService)
    if ( ( $(Get-Service -Name "btService*") | Measure-Object ).Count -eq 1 ) {
        $ServiceNumber = '001'
        $ServiceCode = '002'
    } 

    # Nuova cartella
    $Root = Get-MPWRootFolder
    New-Item -Path "$Root\MicronService$ServiceNumber" -ItemType Directory

    # Installazione con New-Service

    # Modifica parametro Code nel file config

    # Duplicazione dei parametri nella T103COMPARAMS, copiandoli dal servizio precedente

}