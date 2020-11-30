<#
.SYNOPSIS
    Crea un file contenente lo stato di un'installazione MPW.
.DESCRIPTION
    
.EXAMPLE

.EXAMPLE

.NOTES
    TODO: Aggiungere i dettagli dei servizi dalla T103, es. parametri di scarico timbrature
    TODO: Lista delle operazioni pianificate che includono il percorso 'MPW' o che includono i percorsi di export presenze trovati in T103COMPARAMS
    TODO. Tecnologie usate nell'impianto (T22ACCTERMINALI) ed evemtuali codifiche (T54)
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

    # Versione installata

    Add-Content -Path $StatusFile -Value "Versione installata: " 
    $SqlVersioneInstallata = "
        -- Versione installata
        SELECT T05VALORE AS [Versione installata] 
        FROM T05COMFLAGS 
        WHERE T05TIPO='DBVER'"
    Invoke-MPWDatabaseQuery -ConnectionString $ConnectionString -Query $SqlVersioneInstallata | 
        Out-File $StatusFile -Append

    # Servizi btService con rispettiva GNetPath

    Add-Content -Path $StatusFile -Value "Servizi btService con rispettiva GNetPath: " 
    $SqlBtServices = "
        SELECT 
        T03CODICE AS Codice, T03DESCRIZIONE AS Descrizione, 
        CASE T03CONFIGGN 
            WHEN '' THEN 'KARM' 
            ELSE T03CONFIGGN 
            END AS [GNet Path] 
        FROM T03COMSERVICES"
    Invoke-MPWDatabaseQuery -ConnectionString $ConnectionString -Query $SqlBtServices | 
        Out-File $StatusFile -Append

    # Famiglie di firmware presenti sul campo

    Add-Content -Path $StatusFile -Value "Famiglie di firmware presenti sul campo: " 
    $SqlFirmwareFamilies = "
        SELECT T22GNTYPE AS [Versione Firmware],COUNT(T22CODICE) AS [Terminali base attivi] 
        FROM T22ACCTERMINALI 
        WHERE T22KK='0' AND T22ABILITATO='1' 
        GROUP BY T22GNTYPE"
    Invoke-MPWDatabaseQuery -ConnectionString $ConnectionString -Query $SqlFirmwareFamilies | 
        Out-File $StatusFile -Append    
    
    # Terminali base attivi

    Add-Content -Path $StatusFile -Value "Terminali base attivi: " 
    $SqlTerminaliBase = "
        SELECT T22CODICE AS Codice, T22DESCRIZIONE AS Descrizione, T22GNTYPE AS [Firmware], 
            T22GNNUN AS RamoNodo, T22GNIP AS IndirizzoIP 
        FROM T22ACCTERMINALI 
        WHERE T22KK='0' AND T22ABILITATO='1'"
    Invoke-MPWDatabaseQuery -ConnectionString $ConnectionString -Query $SqlTerminaliBase | 
        Out-File $StatusFile -Append  


}