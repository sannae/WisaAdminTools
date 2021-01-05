<#
.SYNOPSIS
  Restituisce i ticket hotline di un determinato cliente o di un determinato tecnico.
.DESCRIPTION
  Lo script si connette al database T_INTERVENTI per effettuare una SELECT sui ticket hotline.
  L'utente può opzionalmente filtrare per CLIENTE o TECNICO o entrambi, utilizzando gli appositi parametri.
  Un filtro non utilizzato restituisce di default tutti i risultati di quella categoria.
  Ad esempio, non specificando il CLIENTE, ma specificando il TECNICO, vengono restituite tutte le chiamate del tecnico in questione.
  Viceversa, non specificando il TECNICO ma specificando il CLIENTE vengono restituite tutte le chiamate del cliente in questione.
  È anche disponibile una SELECT più ristretta, attivabile col parametro MINIMALDISPLAY.
  La funzione restituisce un oggetto array i cui campi possono poi essere filtrati con Where-Object o Select-Object.
  La visualizzazione di default è Format-List ed è ordinata per data-ora decrescente.
.PARAMETER CLIENTECERCATO
  Stringa contenente il cliente di cui si vuole estrarre i ticket salvati nel database.
  Viene fatta una ricerca sul database dei clienti e ne viene chiesta interattivamente la corrispondenza all'utente prima di procedere.
  Se lasciato vuoto, vengono restituiti tutti i clienti.
.PARAMETER TECNICO
  Stringa contenente il tecnico di cui si vuole estrarre i ticket salvati nel database.
  Solo i valori specificati nell'attributo VALIDATESET sono utilizzabili.
  Se lasciato vuoto, vengono restituiti tutti i tecnici.  
.PARAMETER TESTMODE
  Attiva la modalità test, ovvero quella che utilizza una stringa di connessione che punta a un database diverso.
  Il valore di default è falso, ovvero la modalità test è disattivata e lo script si connette direttamente al database hotline di produzione.
.PARAMETER MINIMALDISPLAY
  Switch che utilizza una SELECT più compatta per estrarre i risultati.
.EXAMPLE
  PS> Get-HotlineTicket -ClienteCercato TORINO -Tecnico SANNA
  Restituisce tutti i ticket fatti dal tecnico Sanna sul cliente che ha "Torino" nella descrizione.
.EXAMPLE
  PS> Get-HotlineTicket -Tecnico SANNA | Select-Object -First 5
  Restituisce gli ultimi 5 ticket fatti dal tecnico Sanna.
.EXAMPLE
  PS> Get-HotlineTicket | Where-Object { $_.Ticket -eq '97656' }
  Restituisce i dettagli del ticket 97656
.NOTES
  1.0 (testato)
#>

function Get-HotlineTicket {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0)]
        [AllowEmptyString()]
        [string]$ClienteCercato = $null,
        [ValidateSet("AIROLDI", "BIANCO", "CALVI", "CARBONE", "CONSONNI",
            "DANZA", "GIOFFRE", "JAKAC", "LESCIO", "METTA", "MORONE", "RAIMONDI", "ROSSINI", "SABATINO",
            "SANNA", "SIMONETTA", "TAGLIAFIERRO", "TESO", "ZERBINI")]
        [string]$Tecnico,
        [switch]$TestMode = $false,
        [switch]$MinimalDisplay = $false
    )

    # Variabile Customer
    if ( ($null -eq $ClienteCercato) -or ($ClienteCercato -eq '') ) {
        $Customer = "" 
    } 
    else {
        $Customer = Get-MSAccessCustomer $ClienteCercato
        $Customer = $Customer -replace "'", "''"
    }
    # Variabile Tecnico
    if ( $Tecnico -eq $null ) {
        $Tecnico = ""
    }

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
        WHERE Cliente LIKE '%$Customer%'
        AND Tecnico_hot LIKE '%$Tecnico%'
        ORDER BY Data DESC"
    }
    else {
        $Query = "SELECT N_Chiamata as Ticket,
        Ora AS DataOra, 
        Cliente AS Cliente,
        Tecnico_hot AS Tecnico, 
        Descr_TH as Descrizione, 
        Note_hotline as Note,
        Durata_TH as Durata,
        Esito_TH as Esito, 
        Tipo_Intervento as Tipo
        FROM T_INTERVENTI
        WHERE Cliente LIKE '%$Customer%'
        AND Tecnico_hot LIKE '%$Tecnico%'
        ORDER BY Data DESC"
    }
    Invoke-MpwDatabaseQuery -ConnectionString $ConnString -Query $Query

}