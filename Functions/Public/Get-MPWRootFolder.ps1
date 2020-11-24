<#
.SYNOPSIS
    Cerca la cartella MPW nel file system.
.DESCRIPTION
    Fa una ricerca ricorsiva su tutto il filesystem cercando ogni cartella chiamata esattamente MPW.
    Il valore può essere ritornato su stdout oppure salvato in una variabile (v. esempi)
.EXAMPLE
    PS> $Root = Get-MPWRootFolder
.EXAMPLE
    PS> Get-MPWRootFolder
.NOTES
    1.0.0
#>

function Get-MPWRootFolder {

    [CmdletBinding()]
    param ()

    foreach ( $Disk in (Get-PSDrive -PSPRovider 'FileSystem' | Where-Object Used).Root ) {

        Write-Verbose "Now looking for MPW in disk $Disk"

        $Root = Get-ChildItem $Disk | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -eq "MPW"}
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