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
    PS> Get-InstalledProgram SQL
    Verifica che esistano programmi installati la cui descrizione contiene "SQL"
.NOTES
    1.0 (testato)
    TODO: Magari migliora usando (Get-CimInstance -Class CIM_Product)...
#>

function Get-InstalledProgram {
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
        $Name
    )

    $Programs = [System.Collections.ArrayList]@()

    # Programmi a 64 bit
    $app64 = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" |
    Where-Object { $_.DisplayName -match $Name } | 
    Select-Object DisplayName, DisplayVersion, InstallDate

    if ($app64) {
        foreach ($app in $app64) {
            $Program = [PSCustomObject]@{
                DisplayName    = $app.DisplayName
                DisplayVersion = $app.DisplayVersion
                InstallDate    = $app.InstallDate
            }
            $Programs.Add($Program) | Out-Null
        }
    }

    # Programmi a 32 bit
    $app32 = Get-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | 
    Where-Object { $_.DisplayName -match $Name } | 
    Select-Object DisplayName, DisplayVersion

    if ($app32) {
        foreach ($app in $app32) {
            $Program = [PSCustomObject]@{
                DisplayName    = $app.DisplayName
                DisplayVersion = $app.DisplayVersion
                InstallDate    = $app.InstallDate
            }
            $Programs.Add($Program) | Out-Null
        }
    }

    # Output
    if ($app32 -or $app64) {
        return $Programs
    }
    else {
        Write-Error "Non è stato trovato alcun programma installato con descrizione $Name"
    }
}