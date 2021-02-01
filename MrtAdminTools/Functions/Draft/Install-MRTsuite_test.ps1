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
    - Root folder is C:/MPW_INSTALL
    - ./IIS_features.csv: CSV file with required IIS features in the same directory (maybe replace with JSON?)
    - ./Packages/SQLEXPR_x64_ENU.exe in same directory (if needed) (English only for now)
    - ./Packages/SSMS-SETUP-ENU.exe in same directory (if needed) (English only for now)
    - ./Packages/MRTxxx.exe in same directory
    - ./Modules/dbatools: PowerShell dbatools module (https://octopus.com/blog/sql-server-powershell-dbatools)
    - ./Modules/IISAdministration: PowerShell IISAdministration module (https://octopus.com/blog/iis-powershell)

.EXAMPLE
./Install-MRT.ps1 --InstallSQL --InstallSSMS

#>

Param(
    [Parameter(Mandatory=$false, Position=1)] [switch]$InstallSQL,
    [Parameter(Mandatory=$false, Position=2)] [switch]$InstallSSMS
)

$InstallLocation = 'C:\MPW_INSTALL'
Set-Location $InstallLocation

# Modules
# (Automatically download a PS module and save it locally: Save-Module -Name MODULENAME -Path LOCALPATH)
## TODO: Offline install still not working ...

if(!(Test-Path "$InstallLocation\Modules")) {
    Write-Host "Modules folder not found!" -ForegroundColor Red
    break
} 

Import-Module IISAdministration # For IIS 10.0 (Windows Server 2016 and 2016-nano on)
Import-Module Dbatools # https://dbatools.io/offline/

<#
Copy-Item -Path "$InstallLocation\Modules\*" -Destination "C:\windows\System32\WindowsPowerShell\v1.0\Modules" -Recurse
#>

# Writes a log

New-Item -ItemType Directory -Path $InstallLocation\LOGS | Out-Null
$LogPath = "$InstallLocation\LOGS\MRT_install.log"

function Write-Log {
    param ([string]$logstring)
    $datetime = Get-Date -format "[dd-MM-yyyy HH:mm:ss]"
    Add-content $LogPath -value "$datetime $logstring"
    Write-Host $logstring
}

# SQL Server Express parameters

$SQLinstance = "MICRONTEL_SQLEXPRESS"
$SQLexpress_Setupfile = (Get-Item $InstallLocation/SQLEXPR*.exe).Name

if ($InstallSQL -eq $true) {

    Write-Host "You chose to install SQL Server Express"
    Write-Host "The SQL Server new instance $SQLinstance will be installed"
    $SQLpassword = Read-Host -prompt "Insert SQL system administrator password [complexity restrictions are applied]: "
    
    # Check if setup file is present
    if(!(Test-Path ".\$Sqlexpress_Setupfile")) { 
        Write-Host 'Sqlexpress setup file not found! Please copy it to root folder.' -ForegroundColor Red  
        break
    } 
        
    # Check if an instance with the same name already exists
    if ((Get-Service -displayname "*$($SQLinstance)*")){
        Write-Host "Service $SQLinstance is already installed." -ForegroundColor Red
        Get-Service -displayname "*$($SQLinstance)*"
        break
    }
}

# SQL Server Management Studio parameters
if ($InstallSSMS -eq $true) {
    Write-Host "You chose to install SQL Server Management Studio"

    # Check if setup file is present
    if(!(Test-Path "$InstallLocation\$SSMS_Setupfile")) { 
        Write-Host "SSMS setup file not found! Please copy it to root folder."  -ForegroundColor Red
        break
    } 
}    

# Check System requirements (framework, user, etc.)

Get-SystemRequirements

# Install IIS features

Install-IISFeatures

# Install SQL Server

if ($InstallSQL -eq $true){
          
    # Silently extract setup media file
    Rename-Item $SQLexpress_Setupfile -NewName sql_install.exe
    Start-Process sql_install.exe -ArgumentList '/q /x:".\SQL_Setup_files"'
    Start-sleep -s 5
    # SQL Server Express installation
    Start-Process "./SQL_Setup_files/setup.exe" -ArgumentList "/Q /IACCEPTSQLSERVERLICENSETERMS /ACTION='install' /FEATURES=SQLengine /INSTANCENAME="$SQLinstance" /SECURITYMODE=SQL /SAPWD="$SQLpassword" /INDICATEPROGRESS | Out-file '.\LOGS\SQLEXPR_install.log'"
    Start-sleep -s 30
    
    # Check if installation was successful by verifying the instance in the service name
    if (Get-Service -displayname "*$($SQLinstance)*" -ErrorAction SilentlyContinue){
       Write-Host "SQL instance $SQLinstance successfully installed" -ForegroundColor Green
    } else {
       Write-Host "Something went wrong installing SQL instance $SQLinstance, please check SQL installation log" -ForegroundColor Red
    }
}

# Installing SSMS

if ($InstallSSMS -eq "Y"){

    $SSMS_Setupfile = (Get-Item SSMS*.exe).Name

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
        Write-Host "$($Program.Name) $($Program.Version) successfully installed!"
    } else {
        Write-Host "ERROR - Something went wrong installing $($Program.Name), please check install log"
        break
    }  
}

# Installing Azure Data Studio
# $ADSSetupFile = "azuredatastudio*.exe"
# Rename-Item $ADSSetupFile -NewName ads_install.exe
# .\ads_install.exe /SP- /VerySilent /LOG="LOGS/ADS_install.log" /NORESTART /SUPPRESSMSGBOXES /LAUNCHPROGRAM=0 | Out-Null

# Install MRT Application Suite
function Install-MRTSuite {

    [CmdletBinding()] param()

    # Check if setup file is present

    if(!(Test-Path ".\mrt*.exe")) {
        Write-Host "MRT setup file not found! Please copy it to root folder."  -ForegroundColor Red
        break
    } else {
        $mrtsetupfile = (Get-Item mrt*.exe).Name
    }

    # Create package msi in current dir

    Rename-Item $InstallLocation/$mrtsetupfile -NewName mrt_install.exe
    .\mrt_install.exe /s /x /b"$InstallLocation" /v"/qn"
    Start-sleep -s 20

    # Silently install msi and create error log using msiexec

    $msiArguments = '/qn','/i','"Micronpass Application Suite.msi"',"/l*e '$InstallLocation\LOGS\MRT_MSI_install.log'"
    $InstallProcess = Start-Process -PassThru -Wait msiexec -ArgumentList $msiArguments
    Start-sleep -s 20

    # Check if installation was successful in the list of Programs

    $Program = Get-CimInstance -Query "SELECT * FROM Win32_Product WHERE Name LIKE '%Micronpass Application Suite%'"
    Start-sleep -s 10
    $wmi_check = $null -ne $Program
    if (($InstallProcess.ExitCode -eq '0') -and ($wmi_check -eq $True )) {
        Write-Host "$($Program.Name) $($Program.Version) successfully installed!" -ForegroundColor Green
    } else {
        Write-Host "Something went wrong installing $($Program.Name), please check install log" -ForegroundColor Red
        break
    }  

}

$Root = 'C:/MPW'

# Open GeneraABL and generate ABL code

Start-process $Root/GeneraABL/GeneraAbl.exe 
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
Start-process $Root/MicronStart/mStart.exe -Wait

### TODO: Check if Connection Strings have been updated before continuing

# Acquire database connection string from a config file (it acquires an array with server\instance, database, username, password)

$global:DBDataSource = $(Get-MPWConnectionStrings)[0]       # Does not accept (local) as server name
$global:DBInitialCatalog = $(Get-MPWConnectionStrings)[1]
$global:DBUserId = $(Get-MPWConnectionStrings)[2]
$global:DBPassword = $(Get-MPWConnectionStrings)[3]

# Test db connection

Get-DbaDatabase -SqlInstance $DBDataSource -Database $DBInitialCatalog

# Configure IIS 


# GDPR configuration query

$SQLGDPR = "
    -- Set GDPR flags to default
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEDIP'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEEST'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEVIS'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEUSR'
    UPDATE T05COMFLAGS SET T05VALORE='ANONYMOUS' WHERE T05TIPO='GDPRANONYMTEXT' "

Invoke-DbaQuery -sqlinstance $DBDataSource -Database $DBInitialCatalog -Query $SQLGDPR -MessagesToOutput

# Utilities configuration query

$SQLUtilities = 
    "-- Create utilities internal company
    INSERT INTO T71COMAZIENDEINTERNE VALUES (N'UTIL',N'_UTILITIES',N'INSTALLATORE',N'20000101000000',N'',N'')
    -- Create reference employee
    INSERT INTO T26COMDIPENDENTI VALUES (N'00000001',N'_DIP.RIF', N'_DIP.RIF', N'', N'', N'', N'', N'0', N'', N'INSTALLATORE', N'20000101000000', N'', N'', N'', N'', N'20000101', N'', N'0', N'', N'UTIL', N'M', N'', N'1', N'20000101000000', N'99991231235959', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'')
    -- Assign ref.empl. to admin user
    UPDATE T21COMUTENTI SET T21DEFDIPRIFEST='00000001',T21DEFAZINTEST='UTIL',T21DEFDIPRIFVIS='00000001',T21DEFAZINTVIS='UTIL' WHERE T21UTENTE='admin'
"

Invoke-DbaQuery -sqlinstance $DBDataSource -Database $DBInitialCatalog -File $SQLUtilities -MessagesToOutput

# 7.5 ONLY # Database correction scripts

$MicronpassVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("$Root\Micronpass\bin\mpassw.dll").FileVersion
$ScriptPath = "$Root\DBUpgrade750Scripts\SQLServer"

if (($MicronpassVersion -ge '7.5.600.0') -and ($MicronpassVersion -lt '7.6.0.0')) {

    Invoke-DbaQuery -sqlinstance $DBDataSource -Database $DBInitialCatalog -File "$ScriptPath\201912121059478_ExtendendVisitors.sql" -MessagesToOutput
    Invoke-DbaQuery -sqlinstance $DBDataSource -Database $DBInitialCatalog -File "$ScriptPath\202001031132139_CongedoVisitatore.sql" -MessagesToOutput
    Invoke-DbaQuery -sqlinstance $DBDataSource -Database $DBInitialCatalog -File "$ScriptPath\202002251338486_Mrt7510.sql" -MessagesToOutput
    Invoke-DbaQuery -sqlinstance $DBDataSource -Database $DBInitialCatalog -File "$ScriptPath\202004111624012_Mrt7513.sql" -MessagesToOutput
    Invoke-DbaQuery -sqlinstance $DBDataSource -Database $DBInitialCatalog -File "$ScriptPath\202007291526523_Mrt7514.sql" -MessagesToOutput
    Invoke-DbaQuery -sqlinstance $DBDataSource -Database $DBInitialCatalog -File "$ScriptPath\202009011504100_Mrt7515.sql" -MessagesToOutput

}

### TODO: Test the whole thing with Pester (https://octopus.com/blog/testing-powershell-code-with-pester)

# Open config as administrator

Start-Process -FilePath "$Root\MicronConfig\config.exe" -Verb RunAs

# Open browser

Start-Process "http://localhost/$ApplicationName"

