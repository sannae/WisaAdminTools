<#
.SYNOPSIS
    Crea un file contenente lo stato di un'installazione MPW.
.DESCRIPTION
    
.EXAMPLE

.EXAMPLE

.NOTES
    TODO: Aggiungere i dettagli dei servizi dalla T103, es. parametri di scarico timbrature
    TODO: Lista delle operazioni pianificate che includono il percorso 'MPW' o che includono i percorsi di export presenze trovati in T103COMPARAMS
#>


function Get-MpwPlantStatus {

    [CmdletBinding()] param ()

    # Trova la cartella MPW e crea il file MpwPlantStatus

    $Root = Get-MPWRootFolder
    $StatusFile = "$Root\MpwPlantStatus.txt"

    # Scrivi la ragione sociale del cliente da MRT.LIC

    Add-Content -Path $StatusFile -Value "Cliente: " 
    $($(Get-Content -Path "$Root\MicronService\MRT.LIC" | Select-String -Pattern 'Licence') -Split '=')[1] | Out-File $StatusFile -Append

   # Lista dei servizi attivi, il cui percorso contiene \MPW
   # TODO: Export dei parametri importanti relativi ai servizi dalla T103COMPARAMS

    Get-Service | 
        Where-Object { $_.BinaryPathName -like "*$Root*" -AND $_.Status -eq 'Running' } | 
        Select-Object Name,DisplayName,Status,StartupType,BinaryPathName | 
        Format-Table | 
        Out-File $StatusFile -Append

    # Lista delle applicazioni web il cui percorso contiene \MPW

    $manager = Get-IISServerManager
    $manager.Sites.Applications | 
        Where-Object {$_.VirtualDirectories.PhysicalPath -like "*$Root*" } | 
        Select-Object path,applicationPoolName,enabledProtocols | 
        Format-Table | 
        Out-File $StatusFile -Append

    # Build connection string

    $ConnectionString = Get-MPWConnectionStrings

    # Query di stato impianto

    Add-Content -Path $StatusFile -Value "Versione installata: " 
    Invoke-MPWDatabaseQuery -ConnectionString $ConnectionString -Query $(Get-Content 'PlantStatus.sql') | 
        Out-File $StatusFile -Append

}