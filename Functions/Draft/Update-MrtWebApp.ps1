<#
.SYNOPSIS
    Aggiorna Micronpass all'ultima versione (entro la stessa minor).
.DESCRIPTION
    Lo script richiede il .zip di Micronpass Web alla versione minor/patch più recente.
    Ad esempio, questo script può aggiornare una 7.5.4 a una 7.5.600, ma NON a una 7.6.0.
    I file della versione 'vecchia' vengono salvati in una cartella Applicazione_OLDVERSION
    Attenzione : vengono esclusi dalla sovrascrittura i file web.config e LIC
.PARAMETER APPFULLNAME
    Nome completo dell'applicazione (es. Micronpass, Micronsin, MicronpassMVC) 
    Digitare correttamente, in quanto verrà usato per cercare la cartella omonima sotto MPW.
.PARAMETER ZIPPATH
    Percorso in cui si trova il file zip contenente i file aggiornati.
.EXAMPLE
    PS> Update-MrtWebApp "Micronpass" "C:\temp"
.EXAMPLE
    PS> Update-MrtWebApp -AppFullName Micronpass -ZipPath "C:\temp"
.NOTES
    0.0
    TODO: testare con applicazioni diverse da Micronpass Web
#>

function Update-MrtWebApp {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, 
        HelpMessage="Digitare il nome completo dell'applicazione web: ")] 
            [string] $AppFullName,
        [Parameter(Mandatory = $true, Position = 1, 
        HelpMessage="Digitare il percorso completo con i file aggiornati: ")]
            [string] $ZipPath
    )

    # Controllo che lo zip sia presente
    if ( !(Test-Path "$ZipPath\*.zip") ) {
        Write-Error "File ZIP non trovato al percorso $ZipPath ! Impossibile proseguire con l'aggiornamento."
        break
    } else {
        Write-Verbose "Trovato file $(Get-Item "$ZipPath\*.zip")"
    }

    # Seleziona l'application name
    if ( $AppFullName -eq "Micronpass" ) {
        $AppName = "mpassw"
    } elseif ( $AppFullName -eq "Micronsin" ) {
        $AppName = "msinw"
    } elseif ( $AppFullName -eq "MicronpassMVC") {
        $AppName = "micronpassmvc"
    } else {
        Write-Error "Applicazione $AppFullName non trovata! Inserire un nome valido."
        break
    }

    # Trovo application pool dell'applicazione
    $AppPool = Get-MpwApplicationPool -AppName $AppName
    Write-Verbose "L'application pool $AppPool verrà stoppato"

    # Stoppo suddetto app pool
    if ( $AppPool.State -eq "Started" ) {
        $AppPool.Stop() | Out-null
    }

    # Tolgo il simbolo '$' dal nome dei file da installare, se no fa casino
    $ZipFile = Get-item "$ZipPath\*.zip"
    if ( $ZipFile.Name.Substring(0,1) -eq '$') {
        Rename-Item $ZipFile -NewName $ZipFile.Name.Substring(1)
    }
    $InstallFile = $(Get-item "$ZipPath\*.zip")

    # Copio cartella Micronpass in Micronpass_OLDVER ricavando vecchia versione
    $RootFolder = Get-MPWRootFolder
    $OldVersionString = $(Get-Item "$RootFolder\$AppFullName\bin\$AppName.dll").versioninfo.fileversion.substring(0,7)
    $OldVersion = [version]$OldVersionString
    $OldFolder = "$AppFullName_$OldVersionString"
    if ( !(Test-Path "$RootFolder\$OldFolder")) {
        New-Item -Path "$RootFolder\$OldFolder" -ItemType Directory | Out-Null
    } else {
        Write-Error "La cartella $RootFolder\$OldFolder esiste già!"
        break
    }
    Copy-Item -Path "$RootFolder\$AppFullName\*" -Destination "$RootFolder\$OldFolder"
    Write-Verbose "I file della vecchia applicazione sono stati copiati in '$RootFolder\$OldFolder'"

    # Estraggo installer dallo zip e ricavo nuova versione
    $FolderName = ( Get-Item "$ZipPath\*.zip" ).BaseName
    Expand-Archive -Path $( Get-Item "$ZipPath\*.zip" ) -DestinationPath "$ZipPath\$FolderName"
    Write-Verbose "I file della nuova applicazione sono stati estratti in '$ZipPath\$FolderName'"

    #Installo cartella virtuale aggiornata sotto \inetpub\wwwroot\webupgrade
    $MsiFile = (Get-item "$ZipPath\$Foldername\*.msi" ).FullName
    $MsiArguments = @(
        "/a"
        "$MsiFile"
        "/qb"
        "targetvdir=webupgrade"
    ) 
    Start-Process -PassThru -Wait "msiexec.exe" -ArgumentList $MSIArguments -Verb RunAs | Out-null
    if ( !(Test-Path "C:\inetpub\wwwroot\webupgrade") ) {
        Write-Error "Qualcosa è andato storto nell'installazione di $InstallFile!"
        break
    } else {
        Write-verbose "$InstallFile installato con successo sotto \inetpub\wwwroot !"
    }

    # Sovrascrivo ricorsivamente i file appena unzippati in MPW\Micronpass (escludi web.config e licenza)
    Copy-Item -Path  "C:\inetpub\wwwroot\webupgrade\*" -Destination "$RootFolder\$AppFullName\" -Exclude @('Web.config','MRT.lic') -Recurse -force
    # TODO : Test

    # TODO : Cancella inetpub\wwwroot\webupgrade

    # Comparazione di versioni
    $NewVersionString = $( Get-Item "$RootFolder\$AppFullName\bin\$AppName.dll").versioninfo.fileversion.substring(0,7)
    $NewVersion = [version]$NewVersionString
    Write-Host "Applicazione aggiornata da $OldVersion a $NewVersion"

    # Riavvio app pool
    $AppPool.Start() | Out-null
    Start-Sleep -Seconds 5

    # Apri l'applicazione da browser
    Start-Process "http://localhost/$AppName"

}