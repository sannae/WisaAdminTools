

function Get-MRTSystemRequirements {

    [CmdletBinding()] param ()

    # Set execution policy on the shell session

    Write-Verbose "Checking shell session execution policy"
    Set-Executionpolicy -ExecutionPolicy Unrestricted -Force -ErrorAction SilentlyContinue
    if ((Get-ExecutionPolicy) -ne "Unrestricted" ) {
        Write-Error "The Execution Policies on the current session prevents this script from working!" -ForegroundColor Red; 
        break
    }

    # Check OS version

    Write-Verbose "Checking OS version"
    $OSversion = (Get-ComputerInfo).OSName
    Write-Verbose "The OS version is $OSversion"

    # Check if user is Administrator

    Write-Host "Checking currently logged user's role"
    $principal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent()) 
    if (!( $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) ) {
        Write-Error "The currently logged user is not Administrator" -ForegroundColor Red; 
        break
    }

    # Check .NET Framework version 

    Write-Host "Checking .NET Framework compatibility"
    $BenchmarkFramework = [version]("4.5.2")
    $InstalledFramework = [version](Get-ItemProperty "HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full").Version
    if ($InstalledFramework -lt $BenchmarkFramework) {
        Write-Host "The installed .NET Framework $($InstalledFramework) does not meet the minimum requirements. Please install .NET Framework 4.5.2" -ForegroundColor Red 
        break
    }

}
