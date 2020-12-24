<#
.SYNOPSIS
  Lo script si collega automaticamente al server Bitech per permettere di scegliere un certo cliente sulla base di una lista di comparazioni.
.DESCRIPTION
    Lo script utilizza la CLI di WinSCP per connettersi al server FTP.
    Dopodiché, confronta una stringa fornita dall'utente come parametro con tutte le diciture delle commesse clienti.
    Viene restituita una GridView su cui l'utente deve scegliere interattivamente quale sia il cliente che corrisponde a quello inputato a parametro.
    La funzione restituisce una stringa contenente la dicitura esatta del cliente cercato.
.PARAMETER ALLEGEDCUSTOMER
  Nome del cliente cercato, anche approssimativo. 
  È un parametro obbligatorio nella forma di stringa. La ricerca e la comparazione viene fatta in maniera case-insensitive.
.EXAMPLE
  PS> Get-FtpCustomer -AllegedCustomer ASL
  Permette di scegliere il nome della commessa tra tutte quelle contenenti la stringa ASL
.EXAMPLE
    PS> $Cliente = Get-FtpCustomer -AllegedCustomer SPA
    Salva il cliente selezionato da GridView nella variabile $Cliente.
.NOTES
  1.0 (Testato)
  Richiede WinSCP installato e presente in C:\Program Files(x86)\WinSCP\WinSCP.exe
#>

function Get-FtpCustomer {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0,
        HelpMessage = "Inserire il nome del cliente da cercare")]
        [string]$AllegedCustomer
    )

    # Percorso remoto
    $AllegedRemotePath = '""/MC_Commesse/CO ' + '"*"' + $AllegedCustomer + '"*"'

    # Connection credentials
    $OpenConnectionString = Open-FtpConnection 

    # Inizializza l'array dei risultati
    $Results = @()

    # Seleziona risultati da FTP
    Write-Verbose "Connessione in corso al server FTP..."
    & "C:\Program Files (x86)\WinSCP\WinSCP.com" `
        /ini=nul `
        /command `
        $OpenConnectionString `
        "ls $AllegedRemotePath" `
        "close" `
        "exit" `
    | Select-String -pattern "CO " -AllMatches
    | ForEach-Object {
        $Commessa = $_.ToString().Split(' ') | Select-Object -Last 1
        $Results += $Commessa
        Write-Verbose "Ho aggiunto il cliente $Commessa tra i risultati"
    }

    # Proponi all'utente tutti i risultati trovati
    Write-Host "Selezionare dalla GridView il cliente"
    $SelectedCustomer = $Results | Out-GridView -PassThru

    # Restituisci il cliente selezionato
    Write-Verbose "È stato selezionato il cliente $SelectedCustomer"
    $SelectedCustomer

}