<#

Script da lanciare all'inizio dell'anno nuovo per archiviare i file dell'anno precedente!

Questo script cerca i file il cui nome inizia con $PreviousYear (anno precedente rispetto all'attuale)
dentro alla cartella $CustomersRootFolder - la ricorsione della ricerca si ferma al primo livello (cioè
solo alla prima sottocartella per ogni cartella).
Tutti i file vengono inseriti dentro ad un archivio 7zip chiamato $PreviousYear.7z ed eliminati.

# !!! DA FINIRE DI TESTARE !!!

#>

Clear-Host

# Cartella dei clienti
$PreviousYear = $(Get-Date).Year - 1
$CustomersRootFolder = "C:\_temp"

# Controlla che 7zip esista e imposta alias per semplicità
if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {
    throw "$env:ProgramFiles\7-Zip\7z.exe needed"
} 
set-alias SevenZip "$env:ProgramFiles\7-Zip\7z.exe" 

# Contenuto della cartella clienti
$Customers = Get-ChildItem -Path $CustomersRootFolder

# Ciclo su ogni cliente
Foreach ( $Customer in $Customers ) {

    # Files dell'anno precedente
    $Files = Get-ChildItem "$Customer\$PreviousYear*" 

    # Archivia in un file 7zip
    SevenZip a -t7z "$Customer\$PreviousYear.7z" $Files | Out-Null
    
    # Pulizia
    Remove-Item $Files -Recurse

}