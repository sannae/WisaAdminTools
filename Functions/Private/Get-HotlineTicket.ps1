# Restituisce tutti i ticket di un cliente, in ordine decrescente di data

# Per il dettaglio di un ticket in particolare,
# $Results = Get-HotlineTicket -ClienteCercato CLIENTE
# $Results | Where-Object { $_.Ticket -eq 'NUMEROTICKET' } | Format-List

# TODO: Aggiungere ricerca per tecnico

function Get-HotlineTicket {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$ClienteCercato,
        [switch]$TestMode = $false,
        [switch]$MinimalDisplay = $false
    )
    
    # Variabili
    $Customer = Get-MSAccessCustomer $ClienteCercato
    $Customer = $Customer -replace "'", "''"

    # Stringa di connessione al database hotline
    if ( $TestMode ) {
        $ConnString = "User ID=mrt;Password=M!cr0ntel;Initial Catalog=ASSISTENZA_BACKUP;Data Source=(local)\SQLEXPRESS"
    }
    else {
        $ConnString = Get-SqlAssistenzaConnString
    }

    # Output
    if ( $MinimalDisplay ) {
        $Query = "SELECT N_Chiamata as Ticket, 
        Ora AS DataOra, 
        Tecnico_hot AS Tecnico, 
        Descr_TH AS Descrizione 
        FROM T_INTERVENTI
        WHERE Cliente = '$Customer'
        ORDER BY Data DESC"
    }
    else {
        $Query = "SELECT N_Chiamata as Ticket,
        Ora AS DataOra, 
        Tecnico_hot AS Tecnico, 
        Descr_TH as Descrizione, 
        Note_hotline as Note,
        Durata_TH as Durata,
        Esito_TH as Esito, 
        Tipo_Intervento as Tipo
        FROM T_INTERVENTI
        WHERE Cliente = '$Customer'
        ORDER BY Data DESC"
    }
    Invoke-MpwDatabaseQuery -ConnectionString $ConnString -Query $Query

}