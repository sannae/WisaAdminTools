# Semplicemente testa una connessione verso SQL Server di cui viene fornita la stringa di connessione
# Ritorna TRUE se la connessione ha esito positivo, altrimenti FALSE.

# Preso da https://stackoverflow.com/questions/29229109/test-database-connectivity

# TODO: Inserire l'autenticazione di Windows, forse la seconda risposta dello stesso thread di Stack Overflow riportato sopra può aiutare...

function Test-SQLConnection
{    
    [OutputType([bool])]
    Param
    (
        [Parameter(Mandatory=$true,
                    ValueFromPipelineByPropertyName=$true,
                    Position=0)]
        $ConnectionString
    )
    try
    {
        $sqlConnection = New-Object System.Data.SqlClient.SqlConnection $ConnectionString;
        $sqlConnection.Open();
        $sqlConnection.Close();

        return $true;
    }
    catch
    {
        return $false;
    }
}