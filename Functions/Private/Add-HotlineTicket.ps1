<#
.SYNOPSIS
  Aggiunge un ticket sul database T_INTERVENTI.
.DESCRIPTION
  Lo script si connette al database T_INTERVENTI per aggiungere un ticket hotline.
  Vengono chiesti all'utente diversi parametri non fissi, come durata, descrizione breve-lunga e una descrizione approssimativa del cliente.
  Quest'ultima viene usata per trovare la Ragione Sociale vera e propria nel database CLIENTIA.
  Il confronto è fatto interattivamente dall'utente tramite la funzione Get-MSAccessCustomer.
.PARAMETER CLIENTECERCATO
  Stringa contenente parte del nome del cliente, con cui fare un confronto sul campo RagSoc del database CLIENTIA.
.PARAMETER RIFERIMENTOCLIENTE
  Stringa contenente il contatto di riferimento per il ticket.
.PARAMETER DURATATICKET
  Numero intero di minuti della durata del ticket.
.PARAMETER DESCRIZIONECORTA
  Descrizione corta dell'intervento.
  Viene controllato il fatto che rimanga entro le 255 cifre alfanumeriche.
.PARAMETER DESCRIZIONELUNGA
  Descrizione lunga dell'intervento.
  La lunghezza è arbitraria.
.PARAMETER TESTMODE
  Attiva la modalità test, ovvero quella che utilizza una stringa di connessione che punta a un database diverso.
  Il valore di default è falso, ovvero la modalità test è disattivata e il ticket viene aggiunto direttamente al database hotline di produzione.
.EXAMPLE
  PS> Add-HotlineTicket -ClienteCercato MyCustomer -RiferimentoCliente "Mr.Rossi" -DurataTicket 15 -DescrizioneCorta "Fatto questo" -DescrizioneLunga "Fatto quello"
.EXAMPLE
  PS> Add-HotlineTicket -ClienteCercato MyOtherCustomer -RiferimentoCliente "L.Bianchi" -DurataTicket 10 -DescrizioneCorta "Blabla" -TestMode 
.NOTES
  1.0 (testato)
  NOTE: Lo script inserisce di default Ricevente=MANCUSO, Tecnico_hot=SANNA, Tipo=Software e Esito=Positivo
  TODO: Test di corretto inserimento del ticket
#>
function Add-HotlineTicket {

  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$ClienteCercato,
    [Parameter(Mandatory = $true, Position = 1)]
    [string]$RiferimentoCliente,
    [Parameter(Mandatory = $true, Position = 2)]
    [int]$DurataTicket,
    [Parameter(Mandatory = $true, Position = 3)]
    [ValidateScript ( { $_.Length -le 255 } )]
    [string]$DescrizioneCorta,
    [Parameter(Mandatory = $true, Position = 4)]
    [AllowEmptyString()]
    [string]$DescrizioneLunga,
    [switch]$TestMode = $false
  )

  # Stringa di connessione al database hotline
  if ( $TestMode ) {
    $ConnString = "User ID=mrt;Password=M!cr0ntel;Initial Catalog=ASSISTENZA_BACKUP;Data Source=(local)\SQLEXPRESS"
  }
  else {
    $ConnString = Get-SqlAssistenzaConnString
  }
  
  # Variabili
  $DataOraExtended = $(Get-Date -Uformat "%F %T.000").ToString()
  $DataOraShort = $(Get-Date -Uformat "%d/%m/%Y %T").ToString()
  $Customer = Get-MSAccessCustomer $ClienteCercato

  # Correggi variabili per far gestire gli apostrofi da SQL
  $Customer = $Customer -replace "'","''"
  $RiferimentoCLiente = $RiferimentoCliente -replace "'","''"
  $DescrizioneCorta = $DescrizioneCorta -replace "'","''"
  $DescrizioneLunga = $DescrizioneLunga -replace "'","''"

  # Componi la query
  $Query = "INSERT INTO T_INTERVENTI (Data, Ora, Cliente, Ricevente, Referente, Tecnico_hot, Descr_TH, Esito_TH, Durata_TH, Tipo_intervento, Note_hotline)
        VALUES ('$DataOraExtended', '$DataOraShort', '$Customer', 'MANCUSO', '$RiferimentoCliente', 'SANNA', '$DescrizioneCorta', 'Positivo', '$DurataTicket', 'Software', '$DescrizioneLunga')"

  # Esegui query
  Write-Verbose "Sto eseguendo la query richiesta per il cliente $Customer sul database Hotline..."
  Write-Verbose "Riassunto - Cliente: $Customer"
  Write-Verbose "Riassunto - Durata: $DurataTicket"
  Write-Verbose "Riassunto - Descrizione corta: $DescrizioneCorta"
  Invoke-MpwDatabaseQuery -ConnectionString $ConnString -Query $Query

}