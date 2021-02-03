<#
.SYNOPSIS
    Aggiorna la minor release di un'applicazione web, di cui fornire il file MSI aggiornato.
.DESCRIPTION
    Lo script ricava il nome originale dell'applicazione in IIS corrispondente a quella inserita come parametro.
    A quel punto, stoppa l'application pool di appartenenza per poter continuare.
    La cartella originale corrispondente all'applicazione viene copiata come backup.
    Il file zip indicato come parametro viene spacchettato e installato al percorso /inetpub/wwwroot.
    Il contenuto della cartella installata viene poi sovrascritto alla cartella dell'applicazione.
    È possibile specificare dei file da escludere in questa sovrascrittura.
    Nel caso in cui l'aggiornamento non sia andato a buon fine, viene effettuato automaticamente un rollback con la cartella di backup.
.PARAMETER APPFULLNAME
    Stringa contenente il nome completo dell'applicazione web da aggiornare.
    Ne viene verificata l'esistenza nel range del file JSON Applications.WebApplications.
.PARAMETER ZIPPATH
    Stringa contenente il percorso dove si trovano i file zip da utilizzare per l'aggiornamento.
    Ne viene verificata l'esistenza.
.PARAMETER EXCLUDEFILES
    Array contenente i nomi dei file da escludere nell'aggiornamento.
    Il valore di default è web.config e file di licenza come specificato da file JSON.
.EXAMPLE
    PS> Update-WebApplicationMinor -AppFullName MYWEBAPP -ZipPath C:\temp
    Effettua l'aggiornamento della web app MYWEBAPP con i file contenuti in C:\temp
.EXAMPLE
    PS> Update-WebApplicationMinor -AppFullName MYWEBAPP -ZipPath C:\temp -Exclude 'web.config'
    Come sopra, ma escludendo dall'aggiornamento il file web.config.
.NOTES
    0.9 (testato, aggiungere test su Pester)
    TODO: Sostituire lo Start-Process URL al fondo con una funzione Test-WebApplication che restituisca errori HTTP
    TODO: sostituire Start-Process "msiexec" con nuova funzione Invoke-MsiExec
    TODO: Come posso gestire meglio gli errori di sovrascrittura dei file ttf (font)?
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
        [Parameter(HelpMessage = "Digitare eventuali file da escludere nell'aggiornamento: ")]
        [string[]] $ExcludeFiles = @('Web.config', $Applications.LicenseFile)
    )

    # Root folder
    $RootFolder = Get-AppSuiteRootFolder

    # Seleziona l'application name
    $AppName = $($Applications.WebApplications | Where-Object { $_.WebApplicationFullName -eq $AppFullName }).WebApplicationName

    # Trovo application pool dell'applicazione e lo arresto
    Stop-WebApplicationPool -AppFullName $AppFullName

    # Ricavo la versione precedente
    $OldVersion = [version]$(Get-Item "$RootFolder\$AppFullName\bin\$AppName.dll").versioninfo.fileversion
    
    # Creo la cartella WebApplication_OldVersion
    $OldFolder = "$AppFullName" + "_" + "$OldVersion"
    if ( !(Test-Path "$RootFolder\$OldFolder")) {
        New-Item -Path "$RootFolder\$OldFolder" -ItemType Directory | Out-Null
    }
    else {
        Write-Warning "La cartella $RootFolder\$OldFolder esiste già!"
    }
    Copy-Item -Path "$RootFolder\$AppFullName\*" -Destination "$RootFolder\$OldFolder" -Recurse -Force
    Write-Verbose "I file della vecchia applicazione sono stati copiati in '$RootFolder\$OldFolder'"

    # Estraggo installer dallo zip
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

    # Test installazione MSI
    if ( !(Test-Path "C:\inetpub\wwwroot\webupgrade") ) {
        Write-Error "Qualcosa è andato storto nell'installazione di $MsiFile!"
        break
    }
    else {
        Write-verbose "$MsiFile installato con successo sotto \inetpub\wwwroot !"
    }

    # Sovrascrivo ricorsivamente i file appena unzippati (escludi web.config e licenza) 
    $SourceDir = "C:\inetpub\wwwroot\webupgrade\"
    $DestDir = "$RootFolder\$AppFullName"
    Write-Verbose "Sto copiando i file da \inetpub\wwwroot a $RootFolder\$appFullName, escludendo i file $ExcludeFiles..."
    Get-ChildItem $SourceDir -Recurse -Exclude $ExcludeFiles | Copy-Item -Destination {Join-Path $DestDir $_.FullName.Substring($SourceDir.length)} -Recurse -Force -ErrorAction SilentlyContinue

    # Cancella inetpub\wwwroot\webupgrade e altri cadaveri penzolanti
    Remove-Item -LiteralPath "$ZipPath\$ZipFolder" -Force -Recurse
    Remove-Item -LiteralPath "C:\inetpub\wwwroot\webupgrade" -Force -Recurse

    # Riavvio app pool
    Start-WebApplicationPool -AppFullName $AppFullName

    # Se qualcosa è andato storto, rollback alla versione precedente
    # $TestCondition = $(Invoke-WebRequest -Uri "http://localhost/$AppName" -UseBasicParsing).StatusCode -ne 200
    $DllVersion = [version]$( Get-Item "$RootFolder\$AppFullName\bin\$AppName.dll").VersionInfo.FileVersion
    $ZipVersion = $(Get-InstallFileInfo -Path $ZipFile).FileVersion
    $Testcondition = ($DllVersion.Major -eq $ZipVersion.Major) -and ($DllVersion.Minor -eq $ZipVersion.Minor) -and ($DllVersion.Build -eq $ZipVersion.Build)

    if ( !$TestCondition ) {

        # Rollback !
        Write-Warning "Aggiornamento non riuscito. Rollback a versione precedente in corso..."

        # Stoppa app pool
        Stop-WebApplicationPool -AppFullName $AppFullName
 
        # Cancella il contenuto della cartella AppFullName
        Remove-item -Path "$RootFolder\$AppFullName\*" -Recurse -Force -ErrorAction SilentlyContinue

        # Copia il contenuto della cartella OldFolder dentro ad AppFullName
        Copy-Item -Path "$RootFolder\$OldFolder\*" -Destination "$RootFolder\$AppFullName" -Recurse -Force -ErrorAction SilentlyContinue

        # Cancella OldFolder
        Remove-Item -Path "$RootFolder\$OldFolder" -Recurse -Force

        # Avvia app pool
        Start-WebApplicationPool -AppFullName $AppFullName

    }
    else {
        Write-Host "Ho finito di aggiornare l'applicazione $AppFullName dalla versione $OldVersion alla versione $DllVersion" -ForegroundColor Green
    }

}