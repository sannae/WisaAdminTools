<#
.SYNOPSIS
    Cerca la cartella root dell'application suite nel file system.
.DESCRIPTION
    Fa una ricerca sulle partizioni principali cercando ogni cartella chiamata esattamente RootFolder.
    Il valore può essere ritornato su stdout oppure salvato in una variabile (v. esempi)
    Per velocizzare, una prima ricerca viene fatta sui childrem item di primo livello delle root di partizione.
    In altre parole, le prime sottocartelle di C:\, D:\, ecc.
    Se non viene trovata al primo livello, la seconda ricerca viene fatta ricorsivamente in tutto il filesystem.
    Ovviamente la seconda ricerca potrebbe metterci molto di più!
.EXAMPLE
    PS> $Root = Get-AppSuiteRootFolder
.EXAMPLE
    PS> Get-AppSuiteRootFolder
.NOTES
    1.0 (testato)
    NOTE : Attenzione alla differenza tra Windows PowerShell e PowerShell Core! ("RootFolder" o "C:\RootFolder")
#>

function Get-AppSuiteRootFolder {

    [CmdletBinding()]
    param ()

    # Root name
    $RootFolderName = $Applications.RootFolderName

    # Ricerca di primo livello (cioè solo nei PSProvider FileSystem)
    foreach ( $Disk in (Get-PSDrive -PSPRovider 'FileSystem' | Where-Object Used).Root ) {

        Write-Verbose "Sto cercando la cartella $RootFolderName nel disco $Disk"

        $Root = Get-ChildItem $Disk | Where-Object { $_.PSIsContainer -eq $true -and $_.Name -eq $RootFolderName }
        if ( $null -eq $Root) { 
            Write-Error "Non ho trovato la cartella $RootFolderName nel disco $Disk"
            continue 
        }
        else { 
            $($Root).FullName
            Write-Verbose "Ho trovato la cartella $RootFolderName nel disco $Disk! "
            break 
        }
    }

    # Per ricerca ricorsiva usa:
    if ( $null -eq $Root ) {
        foreach ( $Disk in (Get-PSDrive -PSPRovider 'FileSystem' | Where-Object Used).Root ) {
            
            Write-Verbose "Non ho trovato la cartella $RootFolderName come child delle root di partizione del disco $Disk"
            Write-Verbose "Procedo ricorsivamente (Ci metterò un po'...)"
            Set-Location $Disk
            $Root = Get-Childitem -Path \ -Filter "$RootFolderName" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($null -eq $Root) {
                Write-Error "La cartella $RootFolderName non è stata trovata nel filesystem!"
                Set-Location -Path \
                break
            }
            else {
                Write-Verbose "Ho trovato la cartella $RootFolderName al percorso $($Root.FullName)"
                $($Root).FullName
                Set-Location -Path \
                break
            }
 
        }        
    }

}