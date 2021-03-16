<#
.SYNOPSIS
    Aggregatore di log: restituisce una lista di array contenenti DataOra, LogName e contenuto della riga del log per un'applicazione specificata.
.DESCRIPTION
    Lo script legge riga per riga tutti i file di log all'interno della cartella di una specifica applicazione.
    L'applicazione può essere un servizio di Windows o un'app web e viene indicata nella variabile $Path.
    Lo script cerca ricorsivamente tutti i file .log contenuti nella cartella dell'applicazione, ne effettua il parsing della data e del contenuto.
    Data e contenuto di ogni riga sono poi usati per costruire un PSCustomObject.
    La data è filtrata con i parametri $StartDate e $StopDate.
    Eventualmente è possibile fare in modo che vengano filtrate solo le righe contenenti una cerca stringa, indicata nella variabile $SearchString.
    L'oggetto ritornato è un ArrayList che viene outputato su host ordinato per DateTime crescente.
.PARAMETER PATH
    Percorso della cartella contenente i file di log: vengono cercati tutti i file *.log contenuti all'interno.
    Il parametro viene validato verificando l'esistenza del percorso.
.PARAMETER STARTDATE
    È la data di inizio del periodo indicato.
    Va inserita in formato 'dd-MM-yyyy hh:mm:ss'.
    Se non inserita, il valore di default è oggi alle 00:00:00.
.PARAMETER STOPDATE
    È la data di fine del periodo indicato.
    Va inserita in formato 'dd-MM-yyyy hh:mm:ss'.
    Se non inserita, il valore di default è oggi alle 23:59:59. 
.PARAMETER SEARCHSTRING
    È la stringa che si vuole cercare nei log, da usare come filtro.
    Se non specificata, è uguale a "*", ovvero non viene fatto alcun filtro.
.PARAMETER EXTENSION
    Array di stringhe che specifica le estensioni dei file da aggregare.
    Il valore di default è "log" ovvero vengono presi in considerazione solo i file .log.
.PARAMETER SILENT
    Switch per sovrascrivere la variabile $ErrorActionPreference da Continue a SilentlyContinue.
    Attenzione: questo zittisce gli errori su host, serve solo per accelerare.
.EXAMPLE
    PS> Get-AllFolderLogs -Path MYAPPFOLDER
    Restituisce tutti i log dell'applicativo MYAPPFOLDER della giornata odierna
.EXAMPLE
    PS> Get-AllFolderLogs -Path MYAPPFOLDER -StartDate '01-01-2020 00:00:00' -StopDate '02-01-2020 00:00:00'
    Restituisce tutti i log dell'applicativo MYAPPFOLDER nella giornata del 01-01-2020
.EXAMPLE
    PS> Get-AllFolderLogs -PAth MYAPPFOLDER -SearchString "Disconnessione"
    Restituisce tutti i log dell'applicativo MYAPPFOLDER contenenti la stringa "Disconnessione" 
.NOTES
    0.9 (refactoring)
    TODO : Error handling su IF contenente il parseDate, per gestire righe che non contengono una data-ora
    TODO : Cambiare il parametro $SearchString da stringa singola ad array di stringhe
    TODO : Gestire il parametro $SearchString con -Include ed -Exclude, così da poter omettere le righe inutili
#>

function Get-AllFolderLogs {

    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True,
            HelpMessage = "Digitare il percorso completo della cartella",
            ValueFromPipeline = $true)]
        [ValidateScript( { Test-Path $_ } )]
        [string]$Path,
        [Parameter(
            HelpMessage = "Digitare data ora di inizio (dd-MM-yyyy hh:mm:ss)")]
        [String]$StartDate = (Get-Date -Format 'dd-MM-yyyy 00:00:00').ToString(),
        [Parameter(
            HelpMessage = "Digitare data ora di fine (dd-MM-yyyy hh:mm:ss)")]        
        [String]$StopDate = (Get-Date -Format 'dd-MM-yyyy 23:59:59').ToString(),
        [string]$SearchString = "*",
        [string[]]$Extension = "log",
        [switch]$Silent
    )

    # Ignora errori
    if ($Silent) {
        $ErrorActionPreference = "SilentlyContinue"
    }

    # Salva i log in una variabile
    $Logs = Get-ChildItem -Path $Path -Recurse | Where-Object { $_.Name -like "*.$Extension" }
    if ( $null -eq $Logs ) {
        Write-Error "Non ci sono file con estensione .$Extension nella cartella indicata!"
    }
    else {
        $Logs | ForEach-Object { Write-Verbose "Ho trovato il log: $_ " }
    }

    # Crea array per salvare i risultati
    $LogResults = [System.Collections.ArrayList]@()

    ForEach ( $Log in $Logs ) {

        # Nome del log
        $LogName = $Log.Name
        Write-Verbose "Mi sto leggendo tutto il log $LogName..."

        # Contenuto del log, splittato per riga
        $logContent = Get-Content $($Log).FullName | Select-Object -skip 1 # Rimuove la prima riga
        $logContent -split "`n" | Where-Object { $_.trim() } | Out-null

        # Ciclo su ogni riga
        $logContent | ForEach-Object {

            # Data (come stringa) e contenuto di ogni riga
            $RowDate = ($_ -split '\s', 3)[0] + ' ' + ($_ -split '\s', 3)[1]

            if ( ($RowDate -eq '') -or ($RowDate -eq ' ') ) {
                continue
            }
            else {

                $RowDate = $RowDate.Substring(0, 19) + '.' + $RowDate.Substring(20, 3) # Per il confronto di seguito
                $RowContent = ($_ -split '\s', 3)[2]

                # Confronto di date
                if (([DateTime]::Parse("$Rowdate") -gt [DateTime]::Parse("$StartDate")) -and ([DateTime]::PArse("$Rowdate") -lt [DateTime]::Parse("$StopDate"))) {

                    # Crea l'oggetto riga
                    $LogRow = [PSCustomObject]@{
                        DateTime = [DateTime]::Parse("$RowDate")
                        LogName  = $LogName
                        Content  = $RowContent
                    }

                    if ($LogRow.Content -like $SearchString) {

                        # Aggiungi l'oggetto all'arraylist LogResults
                        $LogResults.Add($LogRow) | Out-Null
                    }
                }
            }
        }
    }

    # Stampa i risultati
    $LogResults = $LogResults | Sort-Object -Property DateTime | Format-Table -AutoSize
    $LogResults

}