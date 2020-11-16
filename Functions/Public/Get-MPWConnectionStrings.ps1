<#
.SYNOPSIS
    Ricava i parametri di connessione al database (*SOLO SQL*)
.DESCRIPTION
    Legge i parametri di connessione al database da una stringa di connessione. 
    Il file usato come fonte è MicronConfig\Config.exe.config.
    Dipende dalla funzione Get-MPWRootFolder per trovare suddetto file.
    Ritorna una stringa di connessione 'semplice' contenente solo DBDataSource, DBInitialCatalog, DBUsername e DBPassword.
.EXAMPLE
    PS> Get-MPWConnectionStrings
.EXAMPLE
    PS> $DBConnectionString = Get-MPWConnectionStrings
.NOTES
    TODO:
    - Criptare la password, qui appare in plain text
#>

function Get-MPWConnectionStrings {

    [CmdletBinding()] 
    param ()

    # Trova cartella MPW
    $Root = Get-MPWRootFolder
    if ( $null -eq $Root ) {
        Write-Error "Cartella MPW non trovata nel file system!"
        break
    }

    # Converti file config in XML
    $ConfigFile = "$Root\MicronConfig\config.exe.config"
    if ( !(Test-Path -Path $ConfigFile) ) {
        Write-Error "File di configurazione $ConfigFile non trovato!"
        break
    }
    $ConfigXml = [xml] (Get-Content $ConfigFile)

    # Leggi il valore della chiave DBengine
    $DBEngine = $ConfigXml.SelectSingleNode('//add[@key="dbEngine"]').Value
    $MyDBEngine = "$("//add[@key='")$($DBEngine)$("Str']")"

    # Leggi il valore della stringa di connessione
    $ConnectionString = $ConfigXml.SelectSingleNode($MyDBEngine).Value

    # Ottieni i singoli parametri di connessione
    $DBDataSource = [regex]::Match($ConnectionString, 'Data Source=([^;]+)').Groups[1].Value
    $DBInitialCatalog = [regex]::Match($ConnectionString, 'Initial Catalog=([^;]+)').Groups[1].Value
    $DBUserId = [regex]::Match($ConnectionString, 'User ID=([^;]+)').Groups[1].Value
    $DBPassword = [regex]::Match($ConnectionString, 'Password=([^;]+)').Groups[1].Value
    
    # Ritorna hash table con parametri di connessione
    $NewConnectionString = "User ID=$DBUserId;Password=$DBPassword;Initial Catalog=$DBInitialCatalog;Data Source=$DBDataSource"

    # Output
    $NewConnectionString
}
