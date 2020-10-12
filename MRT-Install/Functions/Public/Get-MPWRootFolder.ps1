<#
.SYNOPSIS
    Finds the MPW folder in the OS file system.
.DESCRIPTION
    It loops all the filesystem disks and search for any child item named 'MPW'.
.EXAMPLE
    PS> $Root = Get-MPWRootFolder
.NOTES

#>

function Get-MPWRootFolder {

    [CmdletBinding()]
    param ()

    foreach ( $Disk in (Get-PSDrive -PSPRovider 'FileSystem' | Where-Object Used).Root ) {

        Write-Verbose "Now looking for MPW in disk $Disk"

        $Root = Get-ChildItem $Disk | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -match "MPW"}
        if ( $null -eq $Root) { 
            Write-Error "MPW folder not found in disk $Disk, proceeding with the next one"
            continue 
        }
        else { 
            $Root
            Write-Verbose "MPW Folder found in $Root"
            break 
        }
    }

}