<#
.SYNOPSIS
    Cerca la cartella root dell'application suite nel file system.
.DESCRIPTION
    Fa una ricerca sulle partizioni principali cercando ogni cartella chiamata esattamente RootFolder.
    Il valore può essere ritornato su stdout oppure salvato in una variabile (v. esempi)
.EXAMPLE
    PS> $Root = Get-AppSuiteRootFolder
.EXAMPLE
    PS> Get-AppSuiteRootFolder
.NOTES
    0.9 (da testare dopo refactoring)
    NOTE : Attenzione alla differenza tra Windows PowerShell e PowerShell Core! (RootFolder e C:\RootFolder)
    NOTE : La cartella RootFolder non deve trovarsi in una sottocartella! Questo perché una ricerca ricorsiva su tutto il filesystem richiederebbe un sacco di tempo...
    NOTE : Magari implementare un primo livello di ricerca che si ferma alle partizioni di disco, e se non lo trova approfondisce con -Recurse...
#>

function Get-AppSuiteRootFolder {

    [CmdletBinding()]
    param ()

    # Root name
    $RootFolderName = $Applications.RootFolderName

    foreach ( $Disk in (Get-PSDrive -PSPRovider 'FileSystem' | Where-Object Used).Root ) {

        Write-Verbose "Sto cercando la cartella $RootFolderName nel disco $Disk"

        $Root = Get-ChildItem $Disk | Where-Object { $_.PSIsContainer -eq $true -and $_.Name -eq $RootFolderName }
        if ( $null -eq $Root) { 
            Write-Error "Non ho trovato la cartella $RootFolderName nel disco $Disk"
            continue 
        }
        else { 
            $($Root).FullName
            Write-Verbose "Ho trovato la cartella $RootFolderName nel disco $Root! "
            break 
        }
    }
 
}