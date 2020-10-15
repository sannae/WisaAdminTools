Set-Location 'C:\MPW\Timbrature'

if ( !(Test-Path pres.txt) ) { # pres.txt non esiste
    Rename-Item presenze.txt pres.tmp
    Get-Content pres.tmp | Add-Content pres.txt , pres_storico.txt , pres2.txt
    Remove-Item pres.tmp
} else { # pres.txt esiste già
    Start-Process 'C:\Microntel\Web\Micronweb\contegweb2\tr1.exe' -ArgumentList '-auto' # Sintassi ancora non funzionante! provare ad usare cmd.exe
}