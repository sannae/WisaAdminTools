<# 

.SYNOPSIS
The script automates the MRT Application Suite installation.

.DESCRIPTION
The script performs 1) installation of IIS on Windows client or server, 
2) installation of SQL Server Express (if needed), 
3) installation of SQL Server Management Studio or Azure Data Studio (if needed),
4) installation of MRT Application Suite, 
5) configuration of website and application pool on IIS,
6) initial configuration by using external query

.NOTES
Requisites:
    - CSV file with required IIS features in the same directory (maybe replace with JSON?)
    - SQLEXPR_x64_ENU.exe in same directory (if needed) (English only for now)
    - SSMS-SETUP-ENU.exe in same directory (if needed) (English only for now)
    - MRTxxx.exe in same directory
    - Modules/SqlServer PowerShell module (last release downloadable from https://www.powershellgallery.com/packages/Sqlserver)
To-do:
    - Insert CheckProgramInstallation function
    - Add speed-test
    - Add DSC test at the end of the script

.EXAMPLE
./Install-MRT.ps1 
.EXAMPLE
./Install-MRT.ps1 --InstallSQL --InstallSSMS

#>

# Specify --InstallSQL to install SQL Server Express
# Specify --InstallSSMS to install SSMS (or the equivalent Azure Data Studio)
Param(
    [Parameter(Mandatory=$false, Position=1)] [switch]$InstallSQL,
    [Parameter(Mandatory=$false, Position=2)] [switch]$InstallSSMS
)

# Writes a log
$InstallLocation = (Get-Location).Path
New-Item -ItemType Directory -Path $InstallLocation\LOGS | Out-Null
$LogPath = "$InstallLocation\LOGS\mrt_install.log"

function Write-Log {
    param ([string]$logstring)
    $datetime = Get-Date -format "[dd-MM-yyyy HH:mm:ss]"
    # Writes date-time and string
    Add-content $LogPath -value "$datetime $logstring"
    # Print to console the
    Write-Host $logstring
}

# SQL Server Express parameters
$SQLinstance = "MICRONTEL_SQLEXPRESS"
if ($InstallSQL -eq $true) {
    Write-Log "You chose to install SQL Server Express"
    Write-Log "The SQL Server new instance $SQLinstance will be installed"
    $SQLpassword = Read-Host -prompt "Insert SQL system administrator password [complexity restrictions are applied]: "
    
    # Check if setup file is present
    if(!(Test-Path ".\$Sqlexpress_Setupfile")) { 
        Write-Log "ERROR - Sqlexpress setup file not found! Please copy it to root folder."  
        break
    } 
        
    # Check if an instance with the same name already exists
    if ((Get-Service -displayname "*$($SQLinstance)*")){
        Write-Log "ERROR - Service $SQLinstance is already installed."
        Get-Service -displayname "*$($SQLinstance)*"
        break
    }
}

# SQL Server Management Studio parameters
if ($InstallSSMS -eq $true) {
    Write-Log "You chose to install SQL Server Management Studio"

    # Check if setup file is present
    if(!(Test-Path ".\$SSMS_Setupfile")) { 
        Write-Log "ERROR - SSMS setup file not found! Please copy it to root folder."  
        break
    } 
}    

."./Check-Requirements.ps1"
Check-Requirements

<# ------------------------------------ #>

./Install-IISfeatures.ps1

<# ------------------------------------ #>

if ($InstallSQL -eq $true){

    Write-Log ""; $step++ 
    Write-Log "$step. Installing SQL Server Express"
    $SQLexpress_Setupfile = (Get-Item SQLEXPR*.exe).Name
          
    Write-log "Starting installation: this may take a while..."   
    Write-Log "A SQLEXPR install log will be created in the current path to track SQL Server installation."
    # Silently extract setup media file
    Rename-Item $SQLexpress_Setupfile -NewName sql_install.exe
    ./sql_install.exe /q /x:".\SQL_Setup_files"
    Start-sleep -s 5
    # SQL Server Express installation
    ./SQL_Setup_files/setup.exe /Q /IACCEPTSQLSERVERLICENSETERMS /ACTION="install" /FEATURES=SQLengine /INSTANCENAME="$SQLinstance" /SECURITYMODE=SQL /SAPWD="$SQLpassword" /INDICATEPROGRESS | Out-file ".\LOGS\SQLEXPR_install.log"
    Start-sleep -s 30
    
    # Check if installation was successful by verifying the instance in the service name
    if (Get-Service -displayname "*$($SQLinstance)*" -ErrorAction SilentlyContinue){
       Write-Log "SQL instance $SQLinstance successfully installed"
    } else {
       Write-Log "ERROR - Something went wrong installing SQL instance $SQLinstance, please check SQL installation log"
       break
    }
}

# Installing SSMS

if ($InstallSSMS -eq "Y"){

    Write-Log ""; $step++ 
    Write-Log "$step. Installing SQL Server Management Studio"
    $SSMS_Setupfile = (Get-Item SSMS*.exe).Name

    Write-log "Starting installation: this may take a while..."
    Write-Log "A SSMS_install.log will be created in the current path to track the SSMS installation."
    # Move SSMS setup file into SQL install folder
    Rename-Item $SSMS_Setupfile -NewName SSMS_setup.exe
    if (!(Get-Item .\SQL_Setup_files)){
        New-Item -ItemType Directory -Path .\SQL_Setup_files
    }

    Move-Item -Path .\SSMS_setup.exe -Destination .\SQL_Setup_files\SSMS_Setup.exe
    # Silently installing SSMS with no restart, create SSMS_install.log
    # ./SQL_Setup_files/SSMS_setup.exe /INSTALL /QUIET /NORESTART /LOG SSMS_install.log
    $SSMSArguments = '/INSTALL','/QUIET','/NORESTART','/LOG "LOGS/SSMS_install.log"'
    $SSMSInstallProcess = Start-Process -PassThru -Wait ./SQL_Setup_files/SSMS_Setup.exe -ArgumentList $SSMSArguments
    Start-sleep -s 30

    # Check if install was good
    $Program = Get-CimInstance -Query "SELECT * FROM Win32_Product WHERE Name LIKE '%SQL Server Management Studio%'"
    Start-sleep -s 10
    $wmi_check = $null -ne $Program
    if (($SSMSInstallProcess.ExitCode -eq '0') -and ($wmi_check -eq $True )) {
        Write-Log "$($Program.Name) $($Program.Version) successfully installed!"
    } else {
        Write-Log "ERROR - Something went wrong installing $($Program.Name), please check install log"
        break
    }  
}

# Installing Azure Data Studio
# $ADSSetupFile = "azuredatastudio*.exe"
# Rename-Item $ADSSetupFile -NewName ads_install.exe
# .\ads_install.exe /SP- /VerySilent /LOG="LOGS/ADS_install.log" /NORESTART /SUPPRESSMSGBOXES /LAUNCHPROGRAM=0 | Out-Null

<# ------------------------------------ #>

Write-Log ""; $step++ 
Write-Log "$step. Install MRT Application Suite"

# Check if setup file is present
$mrtsetupfile = (Get-Item mrt*.exe).Name
if(!(Test-Path ".\$mrtsetupfile")) {
    Write-Log "ERROR - MRT setup file not found! Please copy it to root folder."  
    break
} 

# Create package msi in current dir
Rename-Item $mrtsetupfile -NewName mrt_install.exe
.\mrt_install.exe /s /x /b"$PWD" /v"/qn"
Start-sleep -s 20
# Silently install msi (cmd) and create error log
$msiArguments = '/qn','/i','"Micronpass Application Suite.msi"','/l*e ".\LOGS\MSI_install.log"'
$InstallProcess = Start-Process -PassThru -Wait msiexec -ArgumentList $msiArguments
Start-sleep -s 20
# Check if installation was successful
$Program = Get-CimInstance -Query "SELECT * FROM Win32_Product WHERE Name LIKE '%Micronpass Application Suite%'"
Start-sleep -s 10
$wmi_check = $null -ne $Program
if (($InstallProcess.ExitCode -eq '0') -and ($wmi_check -eq $True )) {
    Write-Log "$($Program.Name) $($Program.Version) successfully installed!"
} else {
    Write-Log "ERROR - Something went wrong installing $($Program.Name), please check install log"
    break
}  

# Define root folder
foreach ( $Disk in (Get-PSDrive -PSPRovider 'FileSystem' | Where-Object Used).Root ) {
    $Root = Get-ChildItem $Disk | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -match "MPW"}
    if ( $null -ne $Root) { break }
}

<# ------------------------------------ #>

Write-Log ""; $step++ 
Write-Log "$step. Activating product"

# Open GeneraABL
Set-Location $Root\GeneraAbl\
Start-process ./GeneraAbl.exe 
# Check virtual or physical server
if ($(get-wmiobject win32_computersystem).model -match "virtual,*"){
    $keys = "{TAB}{TAB}{ENTER}"
} else {
    $keys = "{TAB}{ENTER}"
}
$wshshell = New-Object -ComObject WScript.Shell
Start-Sleep -Seconds 2
$wshshell.sendkeys($keys)

# Open MicronStart and wait for input
Start-sleep -Seconds 5
Set-Location $Root\MicronStart
Start-process ./mStart.exe -Wait

# Check if Connection Strings have been updated before continuing


<# ------------------------------------ #>

Write-Log ""; $step++ 
Write-Log "$step. Configuring IIS application pool"

# Global variables
$ApplicationPoolName = "MICRONTEL_Accessi"
$WebSiteName = "Default Web Site"
$ApplicationName = "/mpassw"
Write-Log "Starting configuration of $WebSiteName$ApplicationName in application pool $ApplicationPoolName"

# Import IIS admin modules
$IISShiftVersion = '10'
Import-Module WebAdministration -ErrorAction SilentlyContinue # For IIS 7.5 (Windows Server 2008 R2 on)
Import-Module IISAdministration # For IIS 10.0 (Windows Server 2016 and 2016-nano on)
$manager = Get-IISServerManager

# Create application pool, integrated pipeline, Runtime v4.0, Enable32bitApps, idleTimeout 8hrs
# Using IISAdministration (IIS 10.0)
if ($IISVersion.Substring(0,2) -ge $IISShiftVersion) {
	if ($null -eq $manager.ApplicationPools["$ApplicationPoolName"]) {
	$pool = $manager.ApplicationPools.Add("$ApplicationPoolName")
	$pool.ManagedPipelineMode = "Integrated"
	$pool.ManagedRuntimeVersion = "v4.0"
	$pool.Enable32BitAppOnWin64 = $true
	$pool.AutoStart = $true
	$pool.ProcessModel.IdentityType = "ApplicationPoolIdentity"
	$pool.ProcessModel.idleTimeout = "08:00:00"
	$manager.CommitChanges()
	Write-Log "Application pool $ApplicationPoolName successfully created"
	} else {Write-Log "Application pool $ApplicationPoolName already exists, please choose a different name"}
} 
# On WebAdministration (IIS 7.5)
else {
	if ((Test-Path "IIS:\AppPools\$ApplicationPoolName") -eq $False) {
	New-WebAppPool -name "$ApplicationPoolName"  -force
	$appPool = Get-Item IIS:\AppPools\$ApplicationPoolName 
	$appPool.processModel.identityType = "ApplicationPoolIdentity"
	$appPool.enable32BitAppOnWin64 = 1
	$appPool.processModel.idleTimeout = "08:00:00"
	$appPool | Set-Item
	Write-Log "Application Pool $ApplicationPoolName successfully created"
	} else {Write-Log "Application Pool $ApplicationPoolName already exists, please choose a different name"}
}

# Assign the web application mpassw to the application pool
# Using IISAdministration (IIS 10.0)
if ($IISVersion.Substring(0,2) -ge $IISShiftVersion) {
	$website = $manager.Sites["$WebSiteName"]
	$website.Applications["$ApplicationName"].ApplicationPoolName = "$ApplicationPoolName"
	$manager.CommitChanges()
	Write-Log "Application $WebSiteName$ApplicationName successfully assigned to Application pool $ApplicationPoolName"
}
# Using WebAdministration (IIS 7.5)
else {
	Set-ItemProperty -Path "IIS:\Sites\$WebSiteName\$ApplicationName" -name "applicationPool" -value "$ApplicationPoolName"
	Write-Log "Application $WebSiteName$ApplicationName successfully assigned to Application pool $ApplicationPoolName"
}    

<# ------------------------------------ #>

Write-Log ""; $step++ 
Write-Log "$step. Initialize MRT"

# Move module in the $Env:PATH folder
Set-Location $InstallLocation
$ModulesFolder = "C:\windows\System32\WindowsPowerShell\v1.0\Modules"
if(!(Test-Path ".\Modules")) {
    Write-Log "ERROR - Modules folder not found!"  
    break
} 
Copy-Item -Path "$InstallLocation\Modules\*" -Destination $ModulesFolder -Recurse

# Import SqlServer module
Import-Module -name SqlServer

# Convert .config file to readable .XML
$ConfigFile = "$Root\MicronConfig\config.exe.config"
$ConfigXml = [xml] (Get-Content $ConfigFile)

# Read value from dbengine
$DBEngine = $ConfigXml.SelectSingleNode('//add[@key="dbEngine"]').Value
$MyDBEngine = "$("//add[@key='")$($DBEngine)$("Str']")"

# Read value from SqlStr
$ConnectionString = $ConfigXml.SelectSingleNode($MyDBEngine).Value

# Get Connection String parameters
$DBDataSource = [regex]::Match($ConnectionString, 'Data Source=([^;]+)').Groups[1].Value
$DBInitialCatalog = [regex]::Match($ConnectionString, 'Initial Catalog=([^;]+)').Groups[1].Value
$DBUserId = [regex]::Match($ConnectionString, 'User ID=([^;]+)').Groups[1].Value
$DBPassword = [regex]::Match($ConnectionString, 'Password=([^;]+)').Groups[1].Value

# Extract SQL Server version as connection test
Invoke-Sqlcmd -ServerInstance $DBDataSource -Database $DBInitialCatalog -Username $DBUserID -Password $DBPassword -Query "SELECT @@VERSION"

# Check if connection test was successful
###########################################

# Configuration query 
# (this will be outsourced to an external file)
# (TODO: Add admin's default authorizations)
$InitialConfigurationQuery = "
    -- Set GDPR flags to default
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEDIP'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEEST'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEVIS'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEUSR'
    UPDATE T05COMFLAGS SET T05VALORE='ANONYMOUS' WHERE T05TIPO='GDPRANONYMTEXT'
    -- Create utilities internal company
    INSERT INTO T71COMAZIENDEINTERNE VALUES (N'UTIL',N'_UTILITIES',N'INSTALLATORE',N'20000101000000',N'',N'')
    -- Create reference employee
    INSERT INTO T26COMDIPENDENTI VALUES (N'00000001',N'_DIP.RIF', N'_DIP.RIF', N'', N'', N'', N'', N'0', N'', N'INSTALLATORE', N'20000101000000', N'', N'', N'', N'', N'20000101', N'', N'0', N'', N'UTIL', N'M', N'', N'1', N'20000101000000', N'99991231235959', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'')
    -- Assign ref.empl. to admin user
    UPDATE T21COMUTENTI SET T21DEFDIPRIFEST='00000001',T21DEFAZINTEST='UTIL',T21DEFDIPRIFVIS='00000001',T21DEFAZINTVIS='UTIL' WHERE T21UTENTE='admin'
"

# Apply query
Invoke-Sqlcmd -ServerInstance $DBDataSource -Database $DBInitialCatalog -Username $DBUserID -Password $DBPassword -Query $InitialConfigurationQuery

# Check if query was correctly applied
###########################################

# Database correction scripts (only in 7.5)
$MicronpassVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("$Root\Micronpass\bin\mpassw.dll").FileVersion
$ScriptPath = "$Root\DBUpgrade750Scripts\SQLServer"
if (($MicronpassVersion -ge '7.5.400.0') -and ($MicronpassVersion -lt '7.6.0.0')) {
    Invoke-Sqlcmd -ServerInstance $DBDataSource -Database $DBInitialCatalog -Username $DBUserID -Password $DBPassword -Query "$ScriptPath\201912121059478_ExtendendVisitors.sql"
    Invoke-Sqlcmd -ServerInstance $DBDataSource -Database $DBInitialCatalog -Username $DBUserID -Password $DBPassword -Query "$ScriptPath\202001031132139_CongedoVisitatore.sql"
    Invoke-Sqlcmd -ServerInstance $DBDataSource -Database $DBInitialCatalog -Username $DBUserID -Password $DBPassword -Query "$ScriptPath\202002251338486_Mrt7510.sql"      
    Invoke-Sqlcmd -ServerInstance $DBDataSource -Database $DBInitialCatalog -Username $DBUserID -Password $DBPassword -Query "$ScriptPath\202004111624012_Mrt7513.sql"
}

Write-Log ""

<# ------------------------------------ #>

# Insert final DSC checks here

# Open config as administrator
Start-Process -FilePath "$Root\MicronConfig\config.exe" -Verb RunAs

# Open browser
Start-Process "http://localhost/$ApplicationName"

<# ------------------------------------ #>
