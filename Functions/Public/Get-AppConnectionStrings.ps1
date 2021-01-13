<#
.SYNOPSIS
    Ricava i parametri di connessione al database (*SOLO SQL*)
.DESCRIPTION
    Legge i parametri di connessione al database da una stringa di connessione. 
    Il file usato come fonte è ReferenceConfigApp\Config.exe.config.
    Dove ReferenceConfigApp è l'applicazione WinApplication (listata nel file JSON) che abbia attributo ReferenceConfigApp a True.
    Dipende dalla funzione Get-AppSuiteRootFolder per trovare suddetto file.
    Ritorna una stringa di connessione 'semplice' contenente solo DBDataSource, DBInitialCatalog, DBUsername e DBPassword.
.EXAMPLE
    PS> Get-AppConnectionStrings
.EXAMPLE
    PS> $DBConnectionString = Get-AppConnectionStrings
.NOTES
    TODO: Criptare la password, qui appare in plain text
#>

function Get-AppConnectionStrings {

    [CmdletBinding()] 
    param ()

    # Trova cartella MPW
    $Root = Get-AppSuiteRootFolder

    # Reference config file
    $ReferenceConfigAppFullName = $($Applications.WinApplications | Where-Object {$_.ReferenceConfigFile -eq $true }).WinApplicationFullName
    $ReferenceConfigAppName = $($Applications.WinApplications | Where-Object {$_.ReferenceConfigFile -eq $true }).WinApplicationName

    # Converti file config in XML
    $ConfigFile = "$Root\$ReferenceConfigAppFullName\$ReferenceConfigAppName.exe.config"
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
