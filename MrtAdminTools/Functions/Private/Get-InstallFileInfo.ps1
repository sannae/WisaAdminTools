<#
.SYNOPSIS
    Estrae nome dell'applicativo e relativa versione dal nome del file di installazione.
.DESCRIPTION
    La funzione riceve in input il percorso completo del file di installazione.
    Dal nome di quest'ultimo, separa i caratteri alfabetici (che diventano il nome dell'applicazione) da quelli numerici.
    I caratteri numerici sono poi interpretati come versione (la prima cifra Major, la seconda Minor e il resto Build)
    I caratteri di altro tipo vengono trascurati.
    La funzione restituisce un PSCustomObject chiamato FileProperties con due proprietà: FileName (string) e FileVersion (version).
.PARAMETER PATH
    Percorso completo del file. Specificare tutto, compreso di estensione.
    Se il percorso contiene simboli non alfanumerici oppure spazi, utilizzare i single quote ('').
    Verificata l'esistenza del percorso prima di procedere con l'elaborazione.
.EXAMPLE
    PS> Get-InstallFileInfo -Path 'C:\TEMP\$InstallFile12345'
    Scrive su host le proprietà FileName=InstallFile e FileVersion=1.2.345
.EXAMPLE
    PS> $FileProperties = Get-InstallFileInfo -Path 'C:\TEMP\$InstallFile54321'
    Salva nella variabile $FileProperties l'oggetto con proprietà FileName=InstallFile e FileVersion=5.4.321
.NOTES
    1.0 (testato)
    WARNING : Si dà per SCONTATO che la prima cifra sia la Major e la seconda sia la Minor !!
#>


function Get-InstallFileInfo {
    [CmdletBinding()]
    param (
        [ValidateScript( { Test-Path $_ } )]
        [string]$Path
    )

    # Get file
    $File = Get-Item $Path

    # Usa Regex per ottenere parte alfabetica
    $FileName = ( [regex]::matches($File.BaseName, "[a-zA-Z]").value ) -join ''

    # Ottieni parte numerica e converti in versione
    $NumericPart = ( [regex]::matches($File.BaseName, "\d").value ) -join ''
    $VersionString = $NumericPart[0] + '.' + $NumericPart[1] + '.' + $($NumericPart[2..$NumericPart.length] -join '')
    $FileVersion = [System.Version]::Parse($VersionString)

    # Oggetto in output
    $FileProperties = @{
        FileName = $FileName
        FileVersion = $FileVersion
    }
    $FileProperties
        
}