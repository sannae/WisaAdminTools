<# Inserimento automatico chiamate hotline #>

# Cliente
$Cliente = 'FERRERO'

# Dati di istanza
$ConnectionString = "Persist Security Info=False;User ID=sa;Password=Micro!Mpw147;Initial Catalog=ASSISTENZA_BACKUP_20200607;Data Source=(local)\SQLEXPRESS"

# Verifica ridondanze
$DuplicateQuery = "SELECT DISTINCT COUNT(Cliente) AS TotalDuplicates FROM T_Interventi WHERE Cliente LIKE '%$Cliente%'"
$DuplicatesCheck = Invoke-Sqlcmd -ConnectionString $ConnectionString -Query $DuplicateQuery

if ( $DuplicatesCheck.TotalDuplicates -eq '0' ) {
    Write-Host "ERRORE: non ho trovato alcun cliente con la descrizione $Cliente !!! "
}
elseif ( $DuplicatesCheck.TotalDuplicates -gt '1' ) {
    Write-Host 'Ho trovato i seguenti clienti con la descrizione fornita:'
    $Duplicates = Invoke-Sqlcmd -ConnectionString $ConnectionString -Query "SELECT DISTINCT Cliente AS Clienti FROM T_Interventi WHERE Cliente LIKE '%$Cliente%' "
    $Duplicates
}
else {
    # TO DO: Esiste un solo cliente
}
