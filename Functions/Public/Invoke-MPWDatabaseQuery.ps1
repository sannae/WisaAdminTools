<#
.SYNOPSIS
    Esegue una query SQL specifica su un database di cui va fornita la stringa di connessione.
.DESCRIPTION
    Lo script utilizza l'oggetto SqlClient.SqlConnection per aprire una connessione su un'istanza SQL Server.
    Questo formato è usato per esempio nei file config della MRT app suite, ad eccezione dei web.config.
    Nel caso di SELECT, i dati vengono scritti in output come array.
    Nel caso di UPDATE/DELETE, i dati non vengono scritti in output.
.PARAMETER CONNECTIONSTRING
    Stringa di connessione al database; deve essere nel formato "User ID =;Password=;Initial Catalog=;Data Source="
    Se non fornita dall'utente sottoforma di parametro, viene data per scontata la stringa di connessione ricavata dalla funzione Get-MrtConnectionString (v. help relativo).
.PARAMETER QUERY
    Query da eseguire, in formato stringa (es. "SELECT * FROM TABLE").
    Eventualmente si può acquisire da un file esterno usando $Query = $(Get-Content FILE.sql)
.EXAMPLE
    PS> Invoke-MPWDatabaseQuery -ConnectionString $ConnectionString -Query "SELECT * FROM TABLE"
.EXAMPLE
    PS> Invoke-MPWDatabaseQuery -ConnectionString $ConnectionString -Query $(Get-Content File.sql)
.NOTES
    0.0.9
    TODO: 

#>
function Invoke-MPWDatabaseQuery
{

    [CmdletBinding()]    
    param (
        [Parameter(
            HelpMessage="Digita la stringa di connessione rispettando il pattern 'User ID =;Password=;Initial Catalog=;Data Source='",
            ValueFromPipeline=$true)]
                [string]$ConnectionString,
        [Parameter(Mandatory=$True)][string]$Query
    )

    # Crea connessione
    $SqlConnection = New-Object -TypeName Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $ConnectionString

    # Carica query
    $SqlCommand = $SqlConnection.CreateCommand()
    $SqlCommand.CommandText = $Query

    # Esegui query
    $adapter = New-Object -TypeName Data.SqlClient.SqlDataAdapter $SqlCommand
    $dataset = New-Object -TypeName System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null
    $dataset.Tables[0]
}