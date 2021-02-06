

function Test-SystemRequirement {

    [CmdletBinding()]
    [OutputType([System.Management.Automation.PSCustomObject])]

    ## Minimum System Requirements
    $Requirements = $Applications.SystemRequirements
    $Computer = Get-ComputerInfo


    # Verifica requisiti hardware (BLOCCANTE)
    # Logical CPUs
    $Computer.CsNumberOfLogicalProcessors -le $Requirements.MinimumLogicalProcessors
    # RAM
    $($Computer.CsTotalPhysicalMemory) / 1Gb -as [int] -le $Requirements.MinimumRamGB
    # Space on disk
    $(Get-CimInstance -Class CIM_LogicalDisk).FreeSpace / 1Gb -as [int] -le $Requirements.MinimumFreeSpaceGB


    # Verifica versione di OS (BLOCCANTE)
    if ( $(Get-ComputerInfo -Property WindowsInstallationType) -eq 'Client' ) {
        [System.Environment]::OSVersion.Version -le $Requirements.MinimumWindowsClient
    }
    elseif ( $(Get-ComputerInfo -Property WindowsInstallationType) -eq 'Server' ) {
        [System.Environment]::OSVersion.Version -le $Requirements.MinimumWindowsServer
    }

    # Framework (BLOCCANTE)
    $InstalledFramework = [version](Get-ItemProperty "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full").Version
    $InstalledFramework -le [version]($Requirements.MinimumFramework)


    ### Database server (SQL Server)
    # * SQL Server Express/Standard Edition 2012 SP2 or higher
    #    * Enable mixed authentication on the instance (SQL Server and Windows Authentication)
    # * SQL Server Management Studio 14 or higher

    # Verifica che sia installata un'istanza SQL (NON BLOCCANTE)
    $Instances = (get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances
    # Se è installata l'istanza, verifica che la versione sia compatibile (NON BLOCCANTE)
    foreach ($i in $Instances) {
        $p = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL').$i
        (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$p\Setup").Edition
        (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\$p\Setup").Version
    }
    # Se è installata l'istanza, verifica che sia attiva la mixed authentication (NON BLOCCANTE)
    # ...
    # Verifica che sia installato SSMS (NON BLOCCANTE)
    Get-CimInstance -Class CIM_Product | Where-Object { $_.Name -match "Management Studio" }


    ### Database server (Oracle)
    # * Oracle Database v12
    #    * Install Oracle Client 32-bit with OleDB
    #    * Do not install Oracle Data Provider for .NET

    ### Remote connections
    # * Connectivity via RDP with local admin user (BLOCCANTE)
    $principal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent()) 
    if (!( $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) ) {
        Write-Error "The currently logged user is not Administrator" -ForegroundColor Red; 
        break
    }

    # Rimuovi UAC (User Account Control) - cioè il pannello che chiede il prompt amministrativo all'utente (NON BLOCCANTE)
    New-ItemProperty -Path HKLM:Software\Microsoft\Windows\CurrentVersion\policies\system -Name EnableLUA -PropertyType DWord -Value 0 -Force

    ### Firewall inbound/outbound settings (BLOCCANTE)
    fOREACH ( $port in $Requirements.NecessaryTcpPorts) { Test-Port -ComputerName localhost -Port $port -Protocol TCP }

}
