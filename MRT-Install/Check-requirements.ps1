function Check-Requirements {

    [CmdletBinding()]
    param ()

    # Set execution policy on the shell session

    Write-Verbose -Message "Checking shell session execution policy"
    Set-Executionpolicy -ExecutionPolicy Unrestricted -Force -ErrorAction SilentlyContinue
    if ((Get-ExecutionPolicy) -ne "Unrestricted" ) {
        Write-Error "The Execution Policies on the current session prevents this script from working!" ; break
    } else {
        Write-Output "PowerShell execution policy: $(Get-ExecutionPolicy)"
    }

    # Check if user is Administrator

    Write-Verbose -Message "Checking currently logged user's role"
    $principal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent()) 
    if (!( $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) ) {
        Write-Error "The currently logged user is not Administrator" ; break
    } else {
        Write-Output "Current user role: Administrator"
    }

    # Check .NET Framework version 

    Write-Verbose -Message "Checking .NET Framework compatibility"
    $BenchmarkFramework = [version]("4.5.2")
    $InstalledFramework = [version](Get-ItemProperty "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full").Version
    if ($InstalledFramework -lt $BenchmarkFramework) {
        Write-Error "The installed .NET Framework $($InstalledFramework) does not meet the minimum requirements. Please install .NET Framework 4.5.2" ; break
    } else {
        Write-Output "Installed .NET Framework version: $($InstalledFramework)"
    }

}