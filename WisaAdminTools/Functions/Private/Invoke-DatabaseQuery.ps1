<#
.SYNOPSIS
    It runs a specific SQL query on a database whose connection string is provided.
.DESCRIPTION
    The scripts uses the SqlClient.SqlConnection object to open a connection towards a SQL Server instance.
    Using the .NET Framework, no external tool is used as dependency and is thus portable on any OS with .NET > 4.0.
    The connection is opened using the connection string as input parameter in a specific format.
    This format is similar to the one used in the config files of the App Suite (web.config excluded).
    In case of SELECT, data is written in output as an array.
    In case of UPDATE, the amount of updated rows is written in output as a number.
    The user may get the values of a specific column in the dataset using $_.COLUMNNAME.
.PARAMETER CONNECTIONSTRING
    Connection string to the database; it must follow the format "User ID=;Password=;Initial Catalog=;Data Source="
    The default value is provided by the public function Get-AppConnectionString.
.PARAMETER QUERY
    Query to be run, provided as a string (e.g. "SELECT * FROM TABLE").
    Optionally, it can be read by an external file using $Query = $(Get-Content FILE.sql)
.EXAMPLE
    PS> Invoke-DatabaseQuery -ConnectionString $ConnectionString -Query "SELECT * FROM TABLE"
    It runs the specified query by connecting to the input connection string.
.EXAMPLE
    PS> $Table = Invoke-DatabaseQuery -Query $(Get-Content File.sql)
    It runs the query in file File.sql by connecting to be database acquired by function Get-AppConnectionStrings.
    The results are saved into the $Table variable.
.NOTES
    https://www.sqlshack.com/connecting-powershell-to-sql-server/
    TODO: Add Windows Authentication
#>
function Invoke-DatabaseQuery {

	[CmdletBinding()]
	param(
		[string]$ConnectionString = Get-AppConnectionStrings,
		[string]$Query
	)

    # Crea ed apri connessione
    $SqlConnection = New-Object -TypeName Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $ConnectionString
    $SqlConnection.Open()

    # Crea comando
    $SqlCommand = $SqlConnection.CreateCommand()
    $SqlCommand.CommandText = "$Query"

    if ( $Query -like "SELECT*" ) {

        Write-Verbose "A SELECT query was found: results will be displayed on host"

        # Crea Data Adapter (“represents a set of data commands and a database connection that are used to fill the DataSet”)
        $adapter = New-Object -TypeName Data.SqlClient.SqlDataAdapter $SqlCommand

        # Crea Data Set (“an in-memory cache of data”)
        $dataset = New-Object -TypeName System.Data.DataSet
        $adapter.Fill($dataset) | Out-Null
        $dataset.Tables[0] | Format-table -AutoSize

    } elseif ( ($Query -like "UPDATE*") -or ($Query -like "DELETE*") ) {

        Write-Verbose "An UPDATE/DELETE query was found: the amount of updated rows will be displayed on host"

        # Returns the amount of affected rows
        $RowsAffected = $SqlCommand.ExecuteNonQuery()
        Return "Affected rows: $RowsAffected"

    } else {

        # Not a correct query
        Write-Error "Query not in the right format!"

    }

    # Chiudi connessione
    $SqlConnection.Close()

}