# TODO: Dettagli servizi SQL Server

# Modules
Import-Module WebAdministration -SkipEditionCheck
Import-Module IISAdministration
Import-Module SQLServer


# Controllo di versione di Powershell: ALMENO la 5.0!
if ( $PVersionTable.PSVersion.Major -lt 5 ) {
    Write-Host "La tua versione di Powershell è obsoleta! Non posso eseguire questo script..."
    Write-Host "Per aggiornare Windows Powershell: https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/install/installing-windows-powershell?view=powershell-7"
    Write-Host "Per passare direttamente a Powershell Core: https://github.com/PowerShell/PowerShell"
    Write-Host ""
}

# Define root folder
foreach ( $Disk in (Get-PSDrive -PSPRovider 'FileSystem' | Where-Object Used).Root ) {
    $Root = Get-ChildItem $Disk | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -match "MPW"}
    if ( $null -ne $Root) { break }
}
$StatusFile = "$Root\PlantStatus.txt"

# Ragione sociale del cliente
Add-Content -Path $StatusFile -Value "Cliente: " 
$($(Get-Content -Path "$Root\MicronService\MRT.LIC" | Select-String -Pattern 'Licence') -Split '=')[1] | Out-File $StatusFile -Append
Add-Content -Path $StatusFile -Value "--------------" 

# Lista dei servizi il cui percorso contiene \MPW
Add-Content -Path $StatusFile -Value "Servizi installati: " 
Get-Service | Where-Object {$_.BinaryPathName -like "*$Root*"} | Select-Object Name,DisplayName,Status,StartupType,BinaryPathName | Format-Table | Out-File $StatusFile -Append

# Lista delle applicazioni web il cui percorso contiene \MPW
Add-Content -Path $StatusFile -Value "Applicazioni web installate: " 
Get-Webapplication | Where-Object {$_.PhysicalPath -like "*$Root*" } | Select-Object path,PhysicalPath,applicationPool,enabledProtocols | Format-Table | Out-File $StatusFile -Append

# Build connection string
$ConfigFile = "$Root\MicronConfig\config.exe.config"
$ConfigXml = [xml] (Get-Content $ConfigFile)
$DBEngine = $ConfigXml.SelectSingleNode('//add[@key="dbEngine"]').Value
$MyDBEngine = "$("//add[@key='")$($DBEngine)$("Str']")"
$ConnectionString = $ConfigXml.SelectSingleNode($MyDBEngine).Value
$DBDataSource = [regex]::Match($ConnectionString, 'Data Source=([^;]+)').Groups[1].Value
$DBInitialCatalog = [regex]::Match($ConnectionString, 'Initial Catalog=([^;]+)').Groups[1].Value
$DBUserId = [regex]::Match($ConnectionString, 'User ID=([^;]+)').Groups[1].Value
$DBPassword = [regex]::Match($ConnectionString, 'Password=([^;]+)').Groups[1].Value
$ConnectionString = "Persist Security Info=False;User ID=$DBUserID;Password=$DBPassword;Initial Catalog=$DBInitialCatalog;Data Source=$DBDataSource"

# Query di stato impianto
$VersioneInstallata = "SELECT T05VALORE AS [Versione installata] FROM T05COMFLAGS WHERE T05TIPO='DBVER'"
$ServiziAttivi= "SELECT T03CODICE AS Codice, T03DESCRIZIONE AS Descrizione, 
CASE T03CONFIGGN WHEN '' THEN 'KARM' ELSE T03CONFIGGN END AS [GNet Path] FROM T03COMSERVICES" # TODO: Parametri di scarico timbrature
$FamiglieFirmware = "SELECT T22GNTYPE AS [Versione Firmware],COUNT(T22CODICE) AS [Terminali base attivi] FROM T22ACCTERMINALI WHERE T22KK='0' AND T22ABILITATO='1' GROUP BY T22GNTYPE"
$TerminaliBaseAttivi = "SELECT T22CODICE AS Codice, T22DESCRIZIONE AS Descrizione, T22GNTYPE AS [Firmware], T22GNNUN AS RamoNodo, T22GNIP AS IndirizzoIP FROM T22ACCTERMINALI WHERE T22KK='0' AND T22ABILITATO='1'"

Add-Content -Path $StatusFile -Value "Versione installata: " 
Invoke-Sqlcmd -ConnectionString $ConnectionString -Query $VersioneInstallata | Out-File $StatusFile -Append
Add-Content -Path $StatusFile -Value "Parametri dei servizi: " 
Invoke-Sqlcmd -ConnectionString $ConnectionString -Query $ServiziAttivi | Out-File $StatusFile -Append
Add-Content -Path $StatusFile -Value "Famiglie di firmware: " 
Invoke-Sqlcmd -ConnectionString $ConnectionString -Query $FamiglieFirmware | Out-File $StatusFile -Append
Add-Content -Path $StatusFile -Value "Terminali base attivi: " 
Invoke-Sqlcmd -ConnectionString $ConnectionString -Query $TerminaliBaseAttivi | Format-Table | Out-File $StatusFile -Append

