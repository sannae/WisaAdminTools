<#
.SYNOPSIS
    Testa una connessione verso SQL Server di cui viene fornita la stringa di connessione.
.DESCRIPTION
    Lo script semplicemente crea un oggetto SqlConnection.
    Usando l'oggetto, apre e chiude la connessione. 
    Se la connessione riesce ad essere chiusa ed aperta, viene restituito TRUE, altrimenti FALSE. 
.PARAMETER CONNECTIONSTRING
    Stringa contenente la stringa di connessione.
.EXAMPLE
    PS> Test-SqlConnection -ConnectionString $ConnString
    Testa la connessione al database indicato nella stringa di connessione, sull'istanza indicata nella stessa, con le credenziali indicate.
.NOTES
    1.0 (testato)
    NOTE : Preso da https://stackoverflow.com/questions/29229109/test-database-connectivity
    TODO : Testare l'autenticazione di Windows, forse la seconda risposta dello stesso thread di Stack Overflow riportato sopra può aiutare...
#>


function Test-SqlConnection {    
    [Cmdletbinding()]
    [OutputType([bool])]
    Param
    (
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        $ConnectionString
    )
    try {
        Write-Verbose "Trying to open connection..."
        $sqlConnection = New-Object System.Data.SqlClient.SqlConnection $ConnectionString;
        $sqlConnection.Open();
        $sqlConnection.Close();

        return $true;
        Write-Verbose "Connection established"
    }
    catch {
        return $false;
        Write-Verbose "Connection could not be established!"
    }
}