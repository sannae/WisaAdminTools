<#
.SYNOPSIS
    Permette di selezionare un cliente dal database Access CLIENTIA.
.DESCRIPTION
    Lo script prende come input una stringa contenente una descrizione arbitraria della ragione sociale di un Cliente.
    Usando la stringa di connessione al database Access CLIENTIA, effettua una ricerca per Ragione Sociale (campo RAGSOC) all'interno della tabella.
    A quel punto, apre una GridView contenente i risultati della SELECT.
    Con il parametro -PassThru, l'utente può interattivamente selezionare il cliente da restituire.
    Lo script restituisce in output una stringa con la ragione sociale del cliente selezionato.
.PARAMETER CUSTOMER
    Stringa contenente una descrizione anche parziale della ragione sociale da cercare.
    Il confronto è fatto con operatore -like sul campo RagSoc.
.EXAMPLE
    PS> Get-MSAccessCustomer
    Apre una GridView contenente i risultati della Select fatta sul database CLIENTIA.
.EXAMPLE
    PS> $Customer = Get-MSAccessCustomer
    Salva la ragione sociale del cliente selezionato nella variabile Customer.
.NOTES
    1.0 (tested)
#>

function Get-MSAccessCustomer{

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $Customer
    )

    # Percorso del database clienti
    $DatabasePath = Get-MSAccessDatabase

    # Query
    $Query = "SELECT * FROM ClientiA where ragsoc like `"%$Customer%`"";

    # Crea connessione ed esegui comando
    Write-Verbose "Sto aprendo una connessione al database Clienti che risiede in $DatabasePath..."
    $conn = New-Object System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=$DatabasePath;Persist Security Info=False")
    $cmd=$conn.CreateCommand()
    $cmd.CommandText = $Query
    $conn.open()
    $rdr = $cmd.ExecuteReader()
    $dt = New-Object System.Data.Datatable
    $dt.Load($rdr)

    # Parte interattiva
    Write-Verbose "Selezionare il cliente dalla griglia a video"
    $SelectedCustomer = $dt | Sort-Object -Property RagSoc | Out-GridView -PassThru
 
    # Check esistenza
    if ($null -eq $SelectedCustomer) {
        Write-Error "Cliente $Customer non trovato! Riprovare con un'altra dicitura"
        break
    }

    # Output
    Write-Verbose "È stato selezionato il cliente $($SelectedCustomer.RagSoc)"
    $SelectedCustomer.RagSoc

}