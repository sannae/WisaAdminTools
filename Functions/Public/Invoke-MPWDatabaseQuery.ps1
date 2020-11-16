<#
.SYNOPSIS
    Esegue una query SQL specifica su un database di cui va fornita la stringa di connessione.
.DESCRIPTION
    Lo script utilizza l'oggetto SqlClient.SqlConnection per aprire una connessione su un'istanza SQL Server.
    Il parametro ConnectionString deve essere nel formato "User ID =;Password=;Initial Catalog=;Data Source="
    Nel caso di SELECT, i dati vengono scritti in output come array.
    Nel caso di UPDATE/DELETE, i dati non vengono scritti in output.
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
        [Parameter (Position=0,Mandatory=$True)][string]$ConnectionString,
        [Parameter (Position=1,Mandatory=$True)][string]$Query
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