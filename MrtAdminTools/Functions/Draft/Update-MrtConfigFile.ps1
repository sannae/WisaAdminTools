# Imposta il valore NEWVALUE sul parametro PARAMETER nel file config CONFIGFILE

# Da finire di testare !

function Update-MrtConfigFile {

    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True,
            Position=0,
            HelpMessage = "Digitare il percorso completo del file config",
            ValueFromPipeline = $true)]
        [ValidateScript ( { Test-Path $_} )]
        [string]$ConfigFile,
        [Parameter(
            Mandatory = $True,
            Position=1,
            HelpMessage = "Digitare il nome esatto del parametro",
            ValueFromPipeline = $true)]
        [string]$Parameter,
        [string]$NewValue
    )

    # Apri config file come XML
    $doc = (Get-Content $ConfigFile) -as [Xml]
    $obj = $doc.configuration.appSettings.add | Where-Object {$_.Key -eq $Parameter}
    
    # Imposta nuovo valore
    $obj.value = $NewValue

    # Salva documento
    $doc.Save($ConfigFile)

}

<#

Da tenere buono per aggiornamento stringhe di connessione "on the spot":

Function updateConfig($config) 
{ 
    $doc = (Get-Content $config) -as [Xml]
    $root = $doc.get_DocumentElement();
    $activeConnection = $root.connectionStrings.SelectNodes("add");
    $activeConnection.SetAttribute("connectionString", $myConnectionString);
    $doc.Save($config)
} 

#>