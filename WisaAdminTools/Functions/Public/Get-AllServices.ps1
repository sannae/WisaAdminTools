<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE
 
.NOTES

#>

function Get-AllServices {
    [CmdletBinding()]
    param ()
    
    Write-Verbose "Fetching all the services.."
    if ($PSVersionTable.PSVersion.Major -ge '6') {

        # On PowerShell Core (6.0+)
        $AllServices = Get-CimInstance win32_service
        
    } else {
        # On PowerShell 5.1
        $AllServices = Get-WmiObject win32_service
    }

    Write-Verbose "Writing only services whose root folder contains $($Applications.RootFolderName)..."
    $AllServices | Where-object { $_.PathName -like "*$($Applications.RootFolderName)*" } | 
        Select-Object -Property Name, PathName, StartMode, State | 
        Format-Table

}
