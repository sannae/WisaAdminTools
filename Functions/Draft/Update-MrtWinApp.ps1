function Update-MrtWinApp {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0)] 
            [string] $AppName
    )

    # Root folder
    $Root = Get-MPWRootFolder

    # Zip con aggiornamento
    $UpdatePackage = Get-Item "$PSScriptRoot\*.zip" | Where-Object { $_.Name -match $AppName }

    # Verifica che ci sia lo ZIP di aggiornamento
    if ( !($UpdatePackage) ) {
        Write-Error "File ZIP non trovato per l'aggiornamento! Depositare il file ZIP nella stessa cartella di questo script."
    }

    # Verifica se l'app è un servizio (la flag è True se AppName è un servizio)
    $serviceflag = ( $null -eq $(Get-Service | Where-Object { $_.BinaryPathName -match $appname }) )

    # Se è un servizio stoppalo, se è un'applicazione chiudila
    if ( $serviceflag ) {
        Get-Service | Where-Object { $_.BinaryPathName -match $AppName } | Stop-Service
    } else {
        Get-Process | Where-Object { $_.Path -match $AppName } | Stop-Process
    }

    # Estrai dall'archivio in una cartella omonima
    Expand-Archive -Path $( Get-Item $UpdatePackage ).Name -DestinationPath $( Get-Item $UpdatePackage ).BaseName

    # Copia la cartella originale come NomeApplicazione_VersioneOld
    # Se servizi, fallo per tutti i servizi

    # Sovrascrivi il contenuto dell'archivio nella cartella originale NomeApplicazione

    # Se è un servizio: riavvialo , Se l'avvio va in errore, effettua un rollback
    # Se non è un servizio: aprilo ,  Se l'apertura va in errore, effettua un rollback 

}