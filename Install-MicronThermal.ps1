#-----------------------------------------------------------------------
# MicronpassMVC
#-----------------------------------------------------------------------

# Moduli
Import-Module IISAdministration
Import-Module SqlServer

# Variabili
$ApplicationPoolName = "MICRONTEL_MicronpassMVC"
$WebSiteName = "Default Web Site"
$ApplicationName = "/micronpassmvc"
$manager = Get-IISServerManager

# Controlla che il database sia coerente (script MrtCore) guardando che esista la tabella T08
$ConfigFile = "$Root\MicronConfig\config.exe.config"
$DBEngine = [xml](Get-Content $ConfigFile).SelectSingleNode('//add[@key="dbEngine"]').Value
$MyDBEngine = "$("//add[@key='")$($DBEngine)$("Str']")"
$ConnectionString = [xml](Get-Content $ConfigFile).SelectSingleNode($MyDBEngine).Value
$DBDataSource = [regex]::Match($ConnectionString, 'Data Source=([^;]+)').Groups[1].Value
$DBInitialCatalog = [regex]::Match($ConnectionString, 'Initial Catalog=([^;]+)').Groups[1].Value
$DBUserId = [regex]::Match($ConnectionString, 'User ID=([^;]+)').Groups[1].Value
$DBPassword = [regex]::Match($ConnectionString, 'Password=([^;]+)').Groups[1].Value
$MRT75ConsistencyQuery = "SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%T08%'"
IF ($null -eq (Invoke-Sqlcmd -ServerInstance $DBDataSource -Database $DBInitialCatalog -Username $DBUserID -Password $DBPassword -Query $MRT75ConsistencyQuery)){
	Write-Host "Database not consistent!"
	Break
}

# Trova la cartella MPW
foreach ( $Disk in (Get-PSDrive -PSPRovider 'FileSystem' | Where-Object Used).Root ) {
    $Root = Get-ChildItem $Disk | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -match "MPW"}
    if ( $null -ne $Root) { break }
}

# Crea la cartella MicronpassMVC
New-Item -ItemType Directory -Path "$Root\MicronpassMVC" | Out-Null

# Spacchetta il contenuto dello zip di installazione
Expand-Archive ".\MicronpassMVC*" "$Root\MicronpassMVC"

# Copia file di licenza da Micronpass
Copy-Item "$Root\Micronpass\MRT.LIC" "$Root\MicronpassMVC"

# Aggiorna stringhe di connessione in web.config
# DA FINIRE
$ConfigXml = [xml] (Get-Content "$Root\MicronConfig\config.exe.config")
$DBEngine = $ConfigXml.SelectSingleNode('//add[@key="dbEngine"]').Value
$MyDBEngine = "$("//add[@key='")$($DBEngine)$("Str']")"
$ConnectionString = $ConfigXml.SelectSingleNode($MyDBEngine).Value
$DBDataSource = [regex]::Match($ConnectionString, 'Data Source=([^;]+)').Groups[1].Value
$DBInitialCatalog = [regex]::Match($ConnectionString, 'Initial Catalog=([^;]+)').Groups[1].Value
$DBUserId = [regex]::Match($ConnectionString, 'User ID=([^;]+)').Groups[1].Value
$DBPassword = [regex]::Match($ConnectionString, 'Password=([^;]+)').Groups[1].Value

$ConfigFile = [xml](Get-Content "$Root\MicronpassMVC\web.config")
$conn = $ConfigFile.Configuration.ConnectionStrings.add
$conn.connectionString = "Data Source=$DBDataSource;Initial Catalog=$DBInitialCatalog;User Id=$DBUserId;Password=$DBPassword;MultipleActiveResultSets=True"
$ConfigFile.Save("Web.config") # Non funza!

# IIS: Crea application pool dedicato
if ($null -eq $manager.ApplicationPools["$ApplicationPoolName"]) {
	$pool = $manager.ApplicationPools.Add("$ApplicationPoolName")
	$pool.ManagedPipelineMode = "Integrated"
	$pool.ManagedRuntimeVersion = "v4.0"
	$pool.Enable32BitAppOnWin64 = $true
	$pool.AutoStart = $true
	$pool.ProcessModel.IdentityType = "ApplicationPoolIdentity"
	$pool.ProcessModel.idleTimeout = "08:00:00"
    $manager.CommitChanges()
}

# IIS: Crea l'applicazione MicronpassMVC sotto lo stesso Site di Mpassw


# IIS: Inserisci MicronpassMVC nell'app pool dedicato
$website = $manager.Sites["$WebSiteName"]
$website.Applications["$ApplicationName"].ApplicationPoolName = "$ApplicationPoolName"
$manager.CommitChanges()

# Configurazione servizio MicronThermal
# Parametri

# Configurazione utente MicronpassMVC
# Configurazione utente di monitoraggio
# Scegli utente leggendolo dalla tabella degli utenti (con default=admin se esistente)
# Autorizzazioni al Reg.Anag. su Micronpass Web
# Tutti i widget visibili in organigramma
# Dashboard MONITOR importata con JSON
