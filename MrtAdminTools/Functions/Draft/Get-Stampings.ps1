<#
.Synopsis
    Import stampings (equivalent to timbra_import.bat) - Not a function
.DESCRIPTION
    The script renames the presenze.txt into pres.tmp and type its content into pres.txt, pres_storico.txt and pres2.txt.
    Then it starts the process tr1.exe.
.EXAMPLE
    PS> ./Get-Stampings.ps1
.NOTES
    TODO: tr1.exe part not yet ready
#>


Set-Location 'C:\MPW\Timbrature'

if ( !(Test-Path pres.txt) ) { # pres.txt non esiste
    Rename-Item presenze.txt pres.tmp
    Get-Content pres.tmp | Add-Content pres.txt , pres_storico.txt , pres2.txt
    Remove-Item pres.tmp
} else { # pres.txt esiste già
    Start-Process 'C:\Microntel\Web\Micronweb\contegweb2\tr1.exe' -ArgumentList '-auto' # Sintassi ancora non funzionante! provare ad usare cmd.exe
}