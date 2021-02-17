<#
.SYNOPSIS
    Esegue una query SQL specifica su un database di cui va fornita la stringa di connessione.
.DESCRIPTION
    Lo script utilizza l'oggetto SqlClient.SqlConnection per aprire una connessione su un'istanza SQL Server.
    Utilizzando il framework .NET, non dipende da alcun tool esterno e quindi è portabile su qualsiasi OS con .NET > 4.0.
    La connessione è aperta usando la stringa di connessione come parametro di input in uno specifico formato.
    Questo formato è usato per esempio nei file config della App Suite, ad eccezione dei web.config.
    Nel caso di SELECT, i dati vengono scritti in output come array.
    È possibile richiamare i valori di una particolare colonna dell'array usando $_.NOMECOLONNA.
    Nel caso di UPDATE/DELETE, i dati non vengono scritti in output.
.PARAMETER CONNECTIONSTRING
    Stringa di connessione al database; deve essere nel formato "User ID =;Password=;Initial Catalog=;Data Source="
    Se non fornita dall'utente sottoforma di parametro, viene data per scontata la stringa di connessione ricavata dalla funzione Get-AppConnectionStrings (v. help relativo).
.PARAMETER QUERY
    Query da eseguire, in formato stringa (es. "SELECT * FROM TABLE").
    Eventualmente si può acquisire da un file esterno usando $Query = $(Get-Content FILE.sql)
.EXAMPLE
    PS> Invoke-DatabaseQuery -ConnectionString $ConnectionString -Query "SELECT * FROM TABLE"
    Esegue la query indicata connettendosi con la stringa di connessione specificata.
.EXAMPLE
    PS> $Table = Invoke-DatabaseQuery -Query $(Get-Content File.sql)
    Esegue la query contenuta in File.sql connettendosi all'istanza ricavata dalla funzione Get-AppConnectionStrings.
    I risultati vengono salvati nella variabile $Table.
.NOTES
    1.0 (testato in locale)
    https://www.sqlshack.com/connecting-powershell-to-sql-server/
    TODO: Gestire l'autenticazione di Windows!
    TODO: Gestire gli errori!
#>
function Invoke-DatabaseQuery
{

    [CmdletBinding()]    
    param (
        [Parameter(
            HelpMessage="Digita la stringa di connessione rispettando il pattern 'User ID =;Password=;Initial Catalog=;Data Source='",
            ValueFromPipeline=$true)]
                [string]$ConnectionString = (Get-AppConnectionStrings),
        [Parameter(Mandatory=$True)][string]$Query
    )

    # Crea ed apri connessione
    $SqlConnection = New-Object -TypeName Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $ConnectionString
    $SqlConnection.Open()

    # Crea comando
    $SqlCommand = $SqlConnection.CreateCommand()
    $SqlCommand.CommandText = $Query

    # Crea Data Adapter (“represents a set of data commands and a database connection that are used to fill the DataSet”)
    $adapter = New-Object -TypeName Data.SqlClient.SqlDataAdapter $SqlCommand

    # Crea Data Set (“an in-memory cache of data”)
    $dataset = New-Object -TypeName System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null
    $dataset.Tables[0]

    # Chiudi connessione
    $SqlConnection.Close()
}