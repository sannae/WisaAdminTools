<#
.SYNOPSIS
    Restituisce la versione completa di un'applicazione web.
.DESCRIPTION
    Richiama la funzione Get-AppSuiteRootFolder per trovare la cartella root della suite nel file system.
    Legge la proprietà fileversion dal file WebApplicationFullName/bin/.dll che la contiene.
    L'oggetto restituito è di tipo Version (Major, Minor, Build, Revision).
.PARAMETER APPFULLNAME
    Nome completo dell'applicazione.
    Viene controllato che rientri entro il range descritto nel file JSON alla sezione WebApplications.WebApplicationFullName.
.EXAMPLE
    PS> $Version = Get-WebAppCurrentVersion
.EXAMPLE
    PS> Get-WebAppCurrentVersion
.NOTES
    0.9 (da testare dopo refactoring)
#>

function Get-WebAppCurrentVersion {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateScript( { $_ -in $Applications.WebApplications.WebApplicationFullName } )]
            [string] $AppFullName
    )

    # Application Name
    $AppName = $($Applications.WebApplications | Where-Object {$_.WebApplicationFullName -eq $AppFullName }).WebApplicationName

    # Root folder
    Write-Verbose "Looking for $($Applications.RootFolderName) folder in system drive..."
    $RootFolder = Get-AppSuiteRootFolder

    # Version
    Write-Verbose "Looking for dll file in $RootFolder/$AppFullName/bin folder..."
    if ( !(Test-Path "$RootFolder\$AppFullName\bin\$AppName.dll") ) {
        Write-Error -Message "File dll not found! Please check manually."
        break
    }
    $VersionString = $(Get-Item "$RootFolder\$AppFullName\bin\.dll").versioninfo.fileversion
    $Version = [version]$VersionString

    # Output
    $Version

}