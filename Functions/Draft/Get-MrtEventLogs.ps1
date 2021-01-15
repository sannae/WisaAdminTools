<#
.SYNOPSIS
    Restituisce una lista di array contenenti DataOra, LogName e contenuto della riga del log per un'applicazione specificata.
.DESCRIPTION
    Lo script legge riga per riga tutti i file di log all'interno della cartella di una specifica applicazione.
    L'applicazione può essere un servizio di Windows o un'app web e viene indicata nella variabile $ApplicationName.
    Lo script cerca ricorsivamente tutti i file .log contenuti nella cartella dell'applicazione, ne effettua il parsing della data e del contenuto.
    Data e contenuto di ogni riga sono poi usati per costruire un PSCustomObject.
    La data è filtrata con i parametri $StartDate e $StopDate.
    Eventualmente è possibile fare in modo che vengano filtrate solo le righe contenenti una cerca stringa, indicata nella variabile $SearchString.
    L'oggetto ritornato è un ArrayList che viene outputato su host ordinato per DateTime crescente.
.PARAMETER APPLICATIONNAME
    È il nome dell'applicazione, win o web, di cui estrarre i log. È un parametro obbligatorio.
    Il nome va specificato in maniera esatta, perché viene usato per cercare la cartella omonima da cui estrarre i log.
    Ecco perché è possibile scegliere il valore di questo parametro da un ValidateSet.
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
.EXAMPLE
    PS> Get-MrtServiceEventLog -ApplicationName Micronpass
    Restituisce tutti i log dell'applicativo Micronpass della giornata odierna
.EXAMPLE
    PS> Get-MrtServiceEventLog -ApplicationName MicronService -StartDate '01-01-2020 00:00:00' -StopDate '02-01-2020 00:00:00'
    Restituisce tutti i log dell'applicativo MicronService nella giornata del 01-01-2020
.EXAMPLE
    PS> Get-MrtServiceEventLog -ApplicationName NoService -SearchString "Disconnessione"
    Restituisce tutti i log dell'applicativo NoService contenenti la stringa "Disconnessione" 
.NOTES
    0.9 (refactoring)
    TODO: Cambiare il parametro $SearchString da stringa singola ad array di stringhe
    TODO: Gestire il parametro $SearchString con -Include ed -Exclude, così da poter omettere le righe inutili
#>

function Get-MrtEventLogs {

    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True,
            HelpMessage = "Digitare il nome completo dell'applicazione",
            ValueFromPipeline = $true)]
        [ValidateSet(
            "MicronService", 
            "NoService",
            "Micronpass",
            "MicronConfig")]
        [string]$ApplicationName,
        [Parameter(
            HelpMessage = "Digitare data ora di inizio (dd-MM-yyyy hh:mm:ss)")]
        [String]$StartDate = (Get-Date -Format 'dd-MM-yyyy 00:00:00').ToString(),
        [Parameter(
            HelpMessage = "Digitare data ora di fine (dd-MM-yyyy hh:mm:ss)")]        
        [String]$StopDate = (Get-Date -Format 'dd-MM-yyyy 23:59:59').ToString(),
        [string]$SearchString = "*"
    )

    # Cartella root MPW
    $RootFolder = Get-AppSuiteRootFolder
    $Path = "$RootFolder\$ApplicationName"

    # Salva i log in una variabile
    $Logs = Get-ChildItem -Path $Path -Recurse | Where-Object { $_.Name -like "*.log" }
    Write-Verbose "Ho trovato i seguenti log: $Logs"

    # Crea array per salvare i risultati
    $LogResults = [System.Collections.ArrayList]@()

    ForEach ( $Log in $Logs ) {

        # Nome del log
        $LogName = $Log.Name
        Write-Verbose "Mi sto leggendo tutto il log $LogName..."

        # Contenuto del log, splittato per riga
        $logContent = Get-Content $Log | Select-Object -skip 1 # Rimuove la prima riga di servicelog.log
        $logContent -split "`n" | Where-Object { $_.trim() } | Out-null

        # Ciclo su ogni riga
        $logContent | ForEach-Object {

            # Data (come stringa) e contenuto di ogni riga
            $RowDate = ($_ -split '\s', 3)[0] + ' ' + ($_ -split '\s', 3)[1]

            if ( ($RowDate -eq '') -or ($RowDate -eq ' ') ) {

                continue
            
            }
            else {

                $RowDate = $RowDate.Substring(0, 19) + '.' + $RowDate.Substring(21, 2) # Per il confronto di seguito
                $RowContent = ($_ -split '\s', 3)[2]

                # Confronto di date
                if (([DateTime]::Parse("$Rowdate") -gt [DateTime]::Parse("$StartDate")) -and ([DateTime]::PArse("$Rowdate") -lt [DateTime]::Parse("$StopDate"))) {

                    # Crea l'oggetto riga
                    $LogRow = [PSCustomObject]@{
                        DateTime = [DateTime]::Parse("$RowDate")
                        LogName  = $LogName
                        Content  = $RowContent
                    }

                    if ($LogRow.Content -match $SearchString) {

                        # Aggiungi l'oggetto all'arraylist LogResults
                        $LogResults.Add($LogRow) | Out-Null
                    }
                }
            }
        }
    }

    # Stampa i risultati
    $LogResults = $LogResults | Sort-Object -Property DateTime
    $LogResults

}