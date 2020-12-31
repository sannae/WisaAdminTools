<#
.SYNOPSIS
    Installa il ruolo IIS e le corrispondenti funzionalità minime.
.DESCRIPTION
    Esistono due modi per fornire allo script la lista delle funzionalità da installare:
    1) Tramite file CSV senza header, rispettando l'ordine riportato sotto (ovvero "titolo;client;server")
    2) Alimentando la hash table a codice, così da non dipendere da un file esterno
    Lo script verifica su quale tipo di sistema operativo sta girando e installa le corrispondenti funzionalità.
.EXAMPLE
    PS> Install-IISFeatures
.NOTES
    TODO: aggiungere dei test automatici con Pester
    TODO: Aggiungere nei parametri uno switch che permetta di leggere da file CSV
.VERSION
    1.0 (testato)
#>

function Install-IISFeatures {

    [CmdletBinding()] param ()

    # Controlla il tipo di OS
    $OSType = $(Get-ComputerInfo).WindowsInstallationType
    Write-Verbose "Current OS type: $OSType"

    <#
    # Crea lista da file CSV ( in fase di dismissione )

        <# File CSV da salvare nella stessa cartella col nome di IIS_features.csv

        ".NET Framework Features";"NetFx4-AdvSrvs";"NET-Framework-45-features"
        ".NET Framework 4.6";"NetFx4-AdvSrvs";"NET-Framework-45-Core"
        "Extended ASP.NET 4.7";"NetFx4Extended-ASPNET45";"NET-Framework-45-ASPNET";
        "Web Server server role";"IIS-WebServerRole";"Web-Server";
        "Web Server role service";"IIS-WebServer";"Web-WebServer";
        "Application Development";"IIS-ApplicationDevelopment";"Web-App-Dev";
        ".NET Extensibility 4.6";"IIS-NetFxExtensibility45";"Web-Net-Ext45";
        "Application Initialization";"IIS-ApplicationInit";"Web-AppInit";
        "ISAPI Extensions";"IIS-ISAPIExtensions";"Web-ISAPI-Ext";
        "ISAPI Filters";"IIS-ISAPIFilter";"Web-ISAPI-Filter";
        "ASP.NET 4.7";"IIS-ASPNET45";"Web-Asp-Net45";
        "Web Sockets protocol";"IIS-WebSockets";"Web-WebSockets";
        "Basic Authentication";"IIS-BasicAuthentication";"Web-Basic-Auth";
        "Windows Authentication";"IIS-WindowsAuthentication";"Web-Windows-Auth";
        "Static Content";"IIS-StaticContent";"Web-Static-Content"
        "Management Tools";"IIS-WebServerManagementTools";"Web-Mgmt-Tools"
        "IIS Management Console";"IIS-ManagementConsole";"Web-Mgmt-Console";
        "IIS 6 Management Compatibility";"IIS-IIS6ManagementCompatibility";"Web-Mgmt-Compat";
        "IIS 6 Management Console";"IIS-LegacySnapIn";"Web-Lgcy-Mgmt-Console"
        "IIS 6 WMI Compatibility";"IIS-WMICompatibility";"Web-WMI"
        "IIS 6 Scripting Tools";"IIS-LegacyScripts";"Web-Lgcy-Scripting"
        "Telnet Client";"TelnetClient";"Telnet-Client"

        #>

        # $IISFeaturesList = @(Import-CSV "IIS_features.csv" -Delimiter ';' -header 'FeatureName','Client','Server').$OSType

    <#    
    # Verifica l'esistenza del file CSV

    if( !(Test-Path "./IIS_features.csv") ) { 
        Write-Host "IIS feature list not found! Please copy it to root folder." -ForegroundColor Red ; break
    } 
        #>

    # Crea array list da hash table: ogni chiave della hash table è una funzionalità con due sottochiavi client e server
    $IISFeaturesTable = @{
        ".NET Framework Features" = @{
            "Client" = "NetFx4-AdvSrvs"
            "Server" = "NET-Framework-45-features"}
        ".NET Framework 4.6" = @{
            "Client" = "NetFx4-AdvSrvs"
            "Server" = "NET-Framework-45-Core"}
        "Extended ASP.NET 4.7" = @{
            "Client" = "NetFx4Extended-ASPNET45"
            "Server" = "NET-Framework-45-ASPNET"}
        "Web Server server role" = @{
            "Client" = "IIS-WebServerRole"
            "Server" = "Web-Server"}        
        "Web Server role service" = @{
            "Client" = "IIS-WebServer"
            "Server" = "Web-WebServer"}
        "Application Development" = @{
            "Client" = "IIS-ApplicationDevelopment"
            "Server" = "Web-App-Dev"}
        ".NET Extensibility 4.6" = @{
            "Client" = "IIS-NetFxExtensibility45"
            "Server" = "Web-Net-Ext45"}
        "Application Initialization" = @{
            "Client" = "IIS-ApplicationInit"
            "Server" = "Web-AppInit"}
        "ISAPI Extensions" = @{
            "Client" = "IIS-ISAPIExtensions"
            "Server" = "Web-ISAPI-Ext"}
        "ISAPI Filters" = @{
            "Client" = "IIS-ISAPIFilter"
            "Server" = "Web-ISAPI-Filter"}
        "ASP.NET 4.7" = @{
            "Client" = "IIS-ASPNET45"
            "Server" = "Web-Asp-Net45"}
        "Web Sockets protocol" = @{
            "Client" = "IIS-WebSockets"
            "Server" = "Web-WebSockets"}
        "Basic Authentication" = @{
            "Client" = "IIS-BasicAuthentication"
            "Server" = "Web-Basic-Auth"}
        "Windows Authentication" = @{
            "Client" = "IIS-WindowsAuthentication"
            "Server" = "Web-Windows-Auth"}
        "Static Content" = @{
            "Client" = "IIS-StaticContent"
            "Server" = "Web-Static-Content"}
        "Management Tools" = @{
            "Client" = "IIS-WebServerManagementTools"
            "Server" = "Web-Mgmt-Tools"}
        "IIS Management Console" = @{
            "Client" = "IIS-ManagementConsole"
            "Server" = "Web-Mgmt-Console"}
        "IIS 6 Management Compatibility" = @{
            "Client" = "IIS-IIS6ManagementCompatibility"
            "Server" = "Web-Mgmt-Compat"}
        "IIS 6 Management Console" = @{
            "Client" = "IIS-LegacySnapIn"
            "Server" = "Web-Lgcy-Mgmt-Console"}
        "IIS 6 WMI Compatibility" = @{
            "Client" = "IIS-WMICompatibility"
            "Server" = "Web-WMI"}
        "IIS 6 Scripting Tools" = @{
            "Client" = "IIS-LegacyScripts"
            "Server" = "Web-Lgcy-Scripting"}
        "Telnet Client" = @{
            "Client" = "TelnetClient"
            "Server" = "Telnet-Client"}        
        }

    $IISFeaturesList = @()
    ForEach ( $feature in $IISFeaturesTable.Keys ) {
        $IISFeaturesList = $IISFeaturesList + $IISFeaturesTable.$feature.$OSType
    }
        

    # Installa su workstation (modulo DISM)
    if ($OSType -eq "Client"){
        foreach ($feature in $IISFeaturesList){
            Write-verbose -Message "Installing $feature..."
            Enable-WindowsOptionalFeature -All -Online -FeatureName $feature | Out-Null 
            if (!(Get-WindowsOptionalFeature -Online -FeatureName $feature).State -eq "Enabled"){
                Write-Error "Something went wrong installing $feature, please check again!" -ForegroundColor Red ; break
            } 
        }
    }

    # Installa su server modulo ServerManager
    elseif ($OSType -eq "Server"){
        foreach ($feature in $IISFeaturesList){
            Write-Verbose "Installing $feature..."
            Install-WindowsFeature -Name $feature  | Out-Null
            if (!(Get-WindowsFeature -name $feature).Installed -eq $True){
                Write-Error "Something went wrong installing $feature, please check again!" -ForegroundColor Red ; break
            }
        }
    }

    # Riavvia IIS
    Invoke-Command -ScriptBlock { iisreset } | Out-Null

    # Verifica versione di IIS
    if (Get-ChildItem 'HKLM:\SOFTWARE\Microsoft' | Where-Object {$_.Name -match 'InetStp'}) {
        $IISVersion = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\InetStp\).MajorVersion
        Write-Host "IIS $IISVersion successfully installed!"
    } else {
        Write-Error "IIS not fully installed, please check again" -ForegroundColor Red
    }

}