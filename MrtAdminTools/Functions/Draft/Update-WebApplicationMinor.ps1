<#
.SYNOPSIS
    Aggiorna un'applicazione web all'ultima versione (entro la stessa minor).
.DESCRIPTION
    Lo script richiede il .zip dell'applicazione alla versione minor/patch più recente.
    Ad esempio, questo script può aggiornare una 1.0.0 a una 1.0.1, ma NON a una 1.1.0.
    I file della versione 'vecchia' vengono salvati in una cartella Applicazione_OLDVERSION
    Attenzione : vengono esclusi dalla sovrascrittura i file web.config e LIC
.PARAMETER APPFULLNAME
    Nome completo dell'applicazione.
    Digitare correttamente, in quanto verrà usato per cercare la cartella omonima sotto MPW.
.PARAMETER ZIPPATH
    Percorso in cui si trova il file zip contenente i file aggiornati.
    Il percorso inserito viene validato dalla funzione stessa.
.EXAMPLE
    PS> Update-WebApplication MYWEBAPP C:\temp
.EXAMPLE
    PS> Update-WebApplication -AppFullName MYWEBAPP -ZipPath C:\temp
.NOTES
    0.0 (finire di testare, aggiungere test su Pester)
    TODO: Sostituire lo Start-Process URL al fondo con una funzione Test-WebApplication che restituisca errori HTTP
    TODO: sostituire Start-Process "msiexec" con nuova funzione Invoke-MsiExec
    TODO: test del Copy-Item, in particolare negli errore che restituisce sui file .tff (fonts)
#>

function Update-WebApplicationMinor {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0,
            HelpMessage = "Digitare il nome completo dell'applicazione web: ")]
        [ValidateScript( { $_ -in $Applications.WebApplications.WebApplicationFullName } )]
        [string] $AppFullName,
        [Parameter(Mandatory = $true, Position = 1, 
            HelpMessage = "Digitare il percorso completo con i file aggiornati: ")]
        [ValidateScript ( { Test-Path $_ } )]
        [string] $ZipPath,
        [string[]] $ExcludeFiles = @('Web.config', $Applications.LicenseFile)
    )

    # Root folder
    $RootFolder = Get-AppSuiteRootFolder

    # Seleziona l'application name
    $AppName = $($Applications.WebApplications | Where-Object { $_.WebApplicationFullName -eq $AppFullName }).WebApplicationName

    # Trovo application pool dell'applicazione e lo arresto
    Stop-WebApplicationPool -AppFullName $AppFullName

    # Creo la cartella Webapplication_OLDVER
    $OldVersion = [version]$(Get-Item "$RootFolder\$AppFullName\bin\$AppName.dll").versioninfo.fileversion
    
    $OldFolder = "$AppFullName" + "_" + "$OldVersion"
    if ( !(Test-Path "$RootFolder\$OldFolder")) {
        New-Item -Path "$RootFolder\$OldFolder" -ItemType Directory | Out-Null
    }
    else {
        Write-Warning "La cartella $RootFolder\$OldFolder esiste già!"
    }
    Copy-Item -Path "$RootFolder\$AppFullName\*" -Destination "$RootFolder\$OldFolder" -Force
    Write-Verbose "I file della vecchia applicazione sono stati copiati in '$RootFolder\$OldFolder'"

    # Estraggo installer dallo zip e ricavo nuova versione
    $ZipFile = Get-Item "$ZipPath\*$AppFullName*.zip"
    $ZipFolder = $ZipFile.BaseName
    if ( !(Test-Path "$ZipPath\$ZipFolder")) {
        New-Item -Path "$ZipPath\$ZipFolder" -ItemType Directory | Out-Null
    }
    else {
        Write-Warning "La cartella $ZipPath\$ZipFolder esiste già!"
    }
    Expand-Archive -Path $(Get-Item "$ZipPath\*$AppFullName*.zip") -DestinationPath "$ZipPath\$ZipFolder" -Force
    Write-Verbose "I file della nuova applicazione sono stati estratti in '$ZipPath\$ZipFolder'"

    # Installo cartella virtuale aggiornata sotto \inetpub\wwwroot\webupgrade
    $MsiName = $($Applications.WebApplications | Where-Object { $_.WebApplicationFullName -eq $AppFullName }).WebApplicationMsiName
    $MsiFile = $(Get-item "$ZipPath\$ZipFolder\$MsiName.msi" ).FullName
    $MsiArguments = @(
        "/a"
        "$MsiFile"
        "/qn"
        "/norestart"
        "targetvdir=webupgrade"
    ) 
    Write-Verbose "Sto installando il contenuto di $MsiFile..."
    Start-Process -PassThru -Wait "msiexec.exe" -ArgumentList $MSIArguments -Verb RunAs | Out-null

    # Test (da spostare su Pester)
    if ( !(Test-Path "C:\inetpub\wwwroot\webupgrade") ) {
        Write-Error "Qualcosa è andato storto nell'installazione di $ZipFile!"
        break
    }
    else {
        Write-verbose "$ZipFile installato con successo sotto \inetpub\wwwroot !"
    }

    # Sovrascrivo ricorsivamente i file appena unzippati in MPW\Micronpass (escludi web.config e licenza)
    Write-Verbose "Sto copiando i file da \inetpub\wwwroot a $RootFolder\$appFullName, escludendo i file $ExcludeFiles..."
    # \\TODO: Aggiungere nuovamente -Exclude e testarlo
    Copy-Item -Path "C:\inetpub\wwwroot\webupgrade\*" -Destination "$RootFolder\$AppFullName" -Recurse -Force

    # Cancella inetpub\wwwroot\webupgrade e altri cadaveri penzolanti
    Remove-Item -LiteralPath "$ZipPath\$ZipFolder" -Force -Recurse
    Remove-Item -LiteralPath "C:\inetpub\wwwroot\webupgrade" -Force -Recurse

    # Riavvio app pool
    Write-Verbose "Avvio dell'application pool in corso..."
    Start-WebApplicationPool -AppFullName $AppFullName
    Start-Sleep -Seconds 2

    # Se qualcosa è andato storto, rollback alla versione precedente
    # $TestCondition = $(Invoke-WebRequest -Uri "http://localhost/$AppName" -UseBasicParsing).StatusCode -ne 200
    $DllVersion = [version]$( Get-Item "$RootFolder\$AppFullName\bin\$AppName.dll").VersionInfo.FileVersion
    $ZipVersion = $(Get-InstallFileInfo -Path $ZipFile).FileVersion
    $Testcondition = ($DllVersion.Major -eq $ZipVersion.Major) -and ($DllVersion.Minor -eq $ZipVersion.Minor) -and ($DllVersion.Build -eq $ZipVersion.Build)

    ###
    break

    # DA FINIRE
    if ( !$TestCondition ) {

        # Rollback !
        Write-Error "Aggiornamento non riuscito. Rollback a versione precedente in corso..."

        # Stoppa app pool
        Stop-WebApplicationPool -AppFullName $AppFullName

        # Cancella cartella Applicazione/
        Remove-item -LiteralPath "$RootFolder\$AppFullName" -Recurse -Force # Non riesco a cancellare i file TFF !

        # Rinomina cartella Applicazione_OLD/ in Applicazione/
        if ( Test-Path "$RootFolder\$AppFullName") {
            Copy-Item -Path "$RootFolder\$OldFolder\*" -Destination "$RootFolder\$AppFullName" -Recurse -Force # Non riesco a sovrascrivere i file TFF !
        }
        else {
            Rename-item -Path "$RootFolder\$OldFolder" -NewName "$RootFolder\$AppFullName" -Force
        }

        # Avvia app pool
        Start-WebApplicationPool -AppFullName $AppFullName
    }
    else {
        Write-Host "L'applicazione $AppFullName è stata aggiornata con successo da $OldVersion a $DllVersion" -ForegroundColor Green
    }

}