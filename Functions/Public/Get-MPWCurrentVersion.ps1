<#
.SYNOPSIS
    Restituisce la versione completa di Micronpass Web.
.DESCRIPTION
    Richiama la funzione Get-MpwRootFolder per trovare la cartella MPW nel file system.
    Legge la proprietà fileversion dal file Micronpass/bin/mpassw.dll.
    L'oggetto restituito è di tipo Version (Major, Minor, Build, Revision).
.EXAMPLE
    PS> $Version = Get-MpwCurrentVersion
.EXAMPLE
    PS> Get-MpwCurrentVersion
.NOTES
    1.0.0
#>

function Get-MpwCurrentVersion {

    [CmdletBinding()] param()

    # Root folder
    Write-Verbose "Looking for MPW folder in system drive..."
    $RootFolder = Get-MpwRootFolder

    # Version
    Write-Verbose "Looking for mpassw.dll file in Micronpass folder..."
    if ( !(Test-Path "$RootFolder\Micronpass\bin\mpassw.dll") ) {
        Write-Error -Message "File mpassw.dll not found! Please check manually."
        break
    }
    $VersionString = $(Get-Item "$RootFolder\Micronpass\bin\mpassw.dll").versioninfo.fileversion
    $Version = [version]$VersionString
    $Version

}