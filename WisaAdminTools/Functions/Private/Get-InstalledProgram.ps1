<#
.SYNOPSIS
    It verifies that a program is installed on the current OS.
.DESCRIPTION
    The scripts reads the registry keys containing the list of installed programs.
    It's just the list of "uninstallable" program, available on the Programs and Features menu in the Control Panel.
    Both the 32- and the 64-bit related keys are read.
    For each record, the DisplayName property is matched with the input parameter.
    For each result, the properties DisplayName, DisplayVersion, InstalledDate and Version are printed.
.PARAMETER NAME
    Description, even a partial one, of the searched program.
    The match is performed with the -match operator on the propriety DisplayName.
.EXAMPLE
    PS> Get-InstalledProgram SQL
    It checks the existence of any installed program whose description contains "SQL"
.NOTES
    TODO: Maybe improving it using Get-CimInstance -Class CIM_Product...
#>

function Get-InstalledProgram {
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
        $Name
    )

    $Programs = [System.Collections.ArrayList]@()

    # 64-bit programs
    Write-Verbose "Getting all 64-bit installed programs matching $Name..."
    $app64 = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" |
    Where-Object { $_.DisplayName -match $Name } | 
    Select-Object DisplayName, DisplayVersion, InstallDate

    if ($app64) {
        foreach ($app in $app64) {
            $Program = [PSCustomObject]@{
                DisplayName    = $app.DisplayName
                DisplayVersion = $app.DisplayVersion
                InstallDate    = $app.InstallDate
            }
            $Programs.Add($Program) | Out-Null
        }
    }

    # 32-bit programs
    Write-Verbose "Getting all 32-bit installed programs matching $Name..."
    $app32 = Get-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
    Where-Object { $_.DisplayName -match $Name } | 
    Select-Object DisplayName, DisplayVersion

    if ($app32) {
        foreach ($app in $app32) {
            $Program = [PSCustomObject]@{
                DisplayName    = $app.DisplayName
                DisplayVersion = $app.DisplayVersion
                InstallDate    = $app.InstallDate
            }
            $Programs.Add($Program) | Out-Null
        }
    }

    # Output
    if ($app32 -or $app64) {
        return $Programs
    }
    else {
        Write-Error "I couldn't find any installed program with description like $Name"
    }
}