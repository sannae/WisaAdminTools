<#
.SYNOPSIS
    It gets the name and corresponding version of the application from the installation file name.
.DESCRIPTION
    The function gets as input the full path of the install file.
    From the file name, it distinguishes the alphabetical digits (becoming the applicatio name) and the numerical ones.
    The numerical digits are interpreted as the file version (first one is Major, second one is Minor and the rest is Build)
    Other digits are neglected.
    The function returns a PSCustomObject called FileProperties with two properties: FileName (string) and FileVersion (version).
.PARAMETER PATH
    File full path, including its extension.
    If the path contains non-alphanumeric symbols or spaces, use single quotes ('').
    The path existence is checked before proceeding.
.EXAMPLE
    PS> Get-InstallFileInfo -Path 'C:\TEMP\$InstallFile12345'
    It writes on host the properties FileName=InstallFile and FileVersion=1.2.345
.EXAMPLE
    PS> $FileProperties = Get-InstallFileInfo -Path 'C:\TEMP\$InstallFile54321'
    It saves in the $FileProperties variable the object with properties FileName=InstallFile and FileVersion=5.4.321
.NOTES
    WARNING : The script ASSUMES that the first digit is the Major release and the second one is the Minor release !!
#>


function Get-InstallFileInfo {
    [CmdletBinding()]
    param (
        [ValidateScript( { Test-Path $_ } )]
        [string]$Path
    )

    # Get file
    Write-Verbose "Getting file $File..."
    $File = Get-Item $Path

    # Use regex to get alphabetic part
    Write-Verbose "Getting numeric part in filename..."
    $FileName = ( [regex]::matches($File.BaseName, "[a-zA-Z]").value ) -join ''

    # Get numeric part and convert into version
    Write-Verbose "Getting alphabetic part in filename..."
    $NumericPart = ( [regex]::matches($File.BaseName, "\d").value ) -join ''
    $VersionString = $NumericPart[0] + '.' + $NumericPart[1] + '.' + $($NumericPart[2..$NumericPart.length] -join '')
    $FileVersion = [System.Version]::Parse($VersionString)

    # Output object
    $FileProperties = @{
        FileName = $FileName
        FileVersion = $FileVersion
    }
    $FileProperties
        
}