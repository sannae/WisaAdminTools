<#
.SYNOPSIS
    Verifica che un programma sia installato nel sistema operativo.
.DESCRIPTION
    Lo script va a leggere le chiavi di registro contenenti l'elenco dei programmi installati.
    Si tratta solo dei programmi "disinstallabili" listabili dal menu Programs And Features del Pannello di Controllo.
    Vengono lette sia la chiave di registro con i programmi a 32bit sia quella con i programmi a 64bit.
    Per ogni record, viene confrontata la proprietà DisplayName con la stringa inserita come input.
    Per ogni risultato, scrive le proprietà DisplayName, DisplayVersion, InstallDate e Version.
.PARAMETER NAME
    Descrizione anche parziale del programma da cercare.
    Il confronto è fatto con operatore -match rispetto alla proprietà DisplayName.
.EXAMPLE
    PS> Test-InstalledProgram SQL
    Verifica che esistano programmi installati la cui descrizione contiene "SQL"
.NOTES
    1.0 (tested)
#>

function Test-InstalledProgram {
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
        $Name
    )

    # Programmi a 64 bit
    $app64 = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" |
    Where-Object { $_.DisplayName -match $Name } | 
    Select-Object DisplayName, DisplayVersion, InstallDate, Version

    # Programmi a 32 bit
    $app32 = Get-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
    Where-Object { $_.DisplayName -match $Name } | 
    Select-Object DisplayName, DisplayVersion, InstallDate, Version
    
    if ($app32 -or $app64) {
        return $app32, $app64 | Format-Table
    } else {
        Write-Error "Non è stato trovato alcun programma installato con descrizione $Name"
    }
}