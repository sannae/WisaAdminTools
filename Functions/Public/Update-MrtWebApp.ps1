<#
.SYNOPSIS
    Aggiorna un'applicazione web all'ultima versione (entro la stessa minor).
.DESCRIPTION
    Lo script richiede il .zip dell'applicazione alla versione minor/patch più recente.
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
    TODO: Sostituire lo Start-Process URL al fondo con una funzione Test-MrtWebApp che restituisca errori HTTP
    TODO: sostituire Start-Process "msiexec" con nuova funzione Invoke-MsiExec
    TODO: test del Copy-Item, in particolare negli errore che restituisce sui file .tff (fonts)
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

    # Start clock
    $Clock = [Diagnostics.Stopwatch]::StartNew()

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
    Write-Verbose "L'application pool $($AppPool.Name) verrà stoppato"

    # Stoppo suddetto app pool
    if ( $AppPool.State -eq "Started" ) {
        $AppPool.Stop() | Out-null
    }

    # Tolgo il simbolo '$' dal nome dei file da installare, se no fa casino
    $ZipFile = Get-item "$ZipPath\*.zip"
    ForEach ( $file in $ZipFile ) {
        if ( $file.Name.Substring(0,1) -eq '$') {
            Rename-Item $File -NewName $File.Name.Substring(1)
        }
    }
    $InstallFile = $(Get-item "$ZipPath\$AppFullName*.zip")

    # Copio cartella Micronpass in Micronpass_OLDVER ricavando vecchia versione
    $RootFolder = Get-MPWRootFolder
    $OldVersionString = $(Get-Item "$RootFolder\$AppFullName\bin\$AppName.dll").versioninfo.fileversion.substring(0,7)
    $OldVersion = [version]$OldVersionString
    $OldFolder = "$AppFullName"+"_"+"$OldVersionString"
    if ( !(Test-Path "$RootFolder\$OldFolder")) {
        New-Item -Path "$RootFolder\$OldFolder" -ItemType Directory | Out-Null
    } else {
        Write-Error "La cartella $RootFolder\$OldFolder esiste già!"
        break
    }
    Copy-Item -Path "$RootFolder\$AppFullName\*" -Destination "$RootFolder\$OldFolder" -Force
    Write-Verbose "I file della vecchia applicazione sono stati copiati in '$RootFolder\$OldFolder'"

    # Estraggo installer dallo zip e ricavo nuova versione
    $FolderName = ( Get-Item "$ZipPath\*.zip" ).BaseName
    Expand-Archive -Path $( Get-Item "$ZipPath\*.zip" ) -DestinationPath "$ZipPath\$FolderName"
    Write-Verbose "I file della nuova applicazione sono stati estratti in '$ZipPath\$FolderName'"

    # Installo cartella virtuale aggiornata sotto \inetpub\wwwroot\webupgrade
    $MsiFile = (Get-item "$ZipPath\$Foldername\*.msi" ).FullName
    $MsiArguments = @(
        "/a"
        "$MsiFile"
        "/qb"
        "/norestart"
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
    Write-Verbose "File copiati da \inetpub\wwwroot a $RootFolder\$AppFullName"

    # Comparazione di versioni
    $NewVersionString = $( Get-Item "$RootFolder\$AppFullName\bin\$AppName.dll").versioninfo.fileversion.substring(0,7)
    $NewVersion = [version]$NewVersionString
    Write-Host "L'applicazione $AppFullName è stata aggiornata da $OldVersion a $NewVersion"

    # Cancella inetpub\wwwroot\webupgrade e altri cadaveri penzolanti
    Remove-Item -LiteralPath "$ZipPath\$FolderName" -Force -Recurse
    Remove-Item -LiteralPath "$InstallFile"
    Remove-Item -LiteralPath "C:\inetpub\wwwroot\webupgrade" -Force -Recurse

    # Riavvio app pool
    $AppPool.Start() | Out-null
    Start-Sleep -Seconds 5

    # Stop clock
    $Clock.Stop | Out-null
    Write-verbose "Tempo totale: $($Clock.Elapsed.Seconds) secondi"

    # Apri l'applicazione da browser
    Start-Process "http://localhost/$AppName"

}