<#
.SYNOPSIS
    Cerca la cartella MPW nel file system.
.DESCRIPTION
    Fa una ricerca sulle partizioni principali cercando ogni cartella chiamata esattamente MPW.
    Il valore può essere ritornato su stdout oppure salvato in una variabile (v. esempi)
.EXAMPLE
    PS> $Root = Get-MPWRootFolder
.EXAMPLE
    PS> Get-MPWRootFolder
.NOTES
    1.0 (testato)
    NOTA : La cartella MPW non deve trovarsi in una sottocartella! Questo perché una ricerca ricorsiva su tutto il filesystem richiederebbe un sacco di tempo...
#>

function Get-MPWRootFolder {

    [CmdletBinding()]
    param ()

    foreach ( $Disk in (Get-PSDrive -PSPRovider 'FileSystem' | Where-Object Used).Root ) {

        Write-Verbose "Sto cercando la cartella MPW nel disco $Disk"

        $Root = Get-ChildItem $Disk | Where-Object {$_.PSIsContainer -eq $true -and $_.Name -eq "MPW"}
        if ( $null -eq $Root) { 
            Write-Error "Non ho trovato la cartella MPW nel disco $Disk, provo con il prossimo"
            continue 
        }
        else { 
            $Root
            Write-Verbose "Ho trovato la cartella MPW nel disco $Root"
            break 
        }
    }
 
}