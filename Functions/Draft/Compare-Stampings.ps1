<# Come faccio a essere sicuro che le timbrature scritte su DB siano anche state scritte su file di testo? #>

# Invoke-MpwDatabaseQuery "SELECT ... FROM T37ACCTRANSITI" | Add-Content TimbratureDaDb.txt -Append
$TimbratureDaDb
$TimbratureDaTxt

# Compare
$Comparison = Compare-Object -ReferenceObject $TimbratureDaDb -DifferenceObject $TimbratureDaTxt

# Restituisci solo le timbrature che sono su DB ma NON su txt
$( $Comparison | Where-Object { $_.SideIndicator -eq '<=' } ).InputObject