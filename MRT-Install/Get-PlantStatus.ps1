# TODO: Dettagli servizi SQL Server

# Modules

Import-Module IISAdministration
Import-Module dbatools

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

# Ragione sociale del cliente da MRT.LIC

Add-Content -Path $StatusFile -Value "Cliente: " 
$($(Get-Content -Path "$Root\MicronService\MRT.LIC" | Select-String -Pattern 'Licence') -Split '=')[1] | Out-File $StatusFile -Append

# Lista dei servizi il cui percorso contiene \MPW

Get-Service | Where-Object {$_.BinaryPathName -like "*$Root*"} | Select-Object Name,DisplayName,Status,StartupType,BinaryPathName | Format-Table | Out-File $StatusFile -Append

# Lista delle applicazioni web il cui percorso contiene \MPW

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

Invoke-DbaQuery -sqlinstance $DBDataSource -Database $DBInitialCatalog -File 'PlantStatus.sql' -MessagesToOutput | Out-File $StatusFile -Append

# Commesse su server Bitech

