<#
.SYNOPSIS
    Aggiorna la minor release di un'applicazione Windows, di cui fornire il file MSI aggiornato.
.DESCRIPTION
    Lo script ricava il nome originale dell'applicazione corrispondente a quella inserita come parametro.
    A quel punto, cerca di chiudere gentilmente l'applicazione se aperta, altrimenti ne stoppa direttamente il processo.
    La cartella originale corrispondente all'applicazione viene copiata come backup.
    Il file zip indicato come parametro viene spacchettato e il contenuto della cartella viene poi sovrascritto alla cartella dell'applicazione.
    È possibile specificare dei file da escludere in questa sovrascrittura.
    Nel caso in cui l'aggiornamento non sia andato a buon fine, viene effettuato automaticamente un rollback con la cartella di backup.
.PARAMETER APPFULLNAME
    Stringa contenente il nome completo dell'applicazione Windows da aggiornare.
    Ne viene verificata l'esistenza nel range del file JSON Applications.WinApplications.
.PARAMETER ZIPPATH
    Stringa contenente il percorso dove si trovano i file zip da utilizzare per l'aggiornamento.
    Ne viene verificata l'esistenza.
.PARAMETER EXCLUDEFILES
    Array contenente i nomi dei file da escludere nell'aggiornamento.
    Il valore di default è il file di licenza come specificato da file JSON.
.EXAMPLE
    PS> Update-WinApplicationMinor -AppFullName MYWINAPP -ZipPath C:\temp
    Effettua l'aggiornamento dell'applicazione Windows MYWINAPP con i file contenuti in C:\temp
.EXAMPLE
    PS> Update-WebApplicationMinor -AppFullName MYWINAPP -ZipPath C:\temp -Exclude 'app.config'
    Come sopra, ma escludendo dall'aggiornamento il file app.config.
.NOTES
    0.9 (testato, aggiungere test su Pester)
    TODO: Da testare anche con altre applicazioni
#>
function Update-WinApplicationMinor {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0,
            HelpMessage = "Digitare il nome completo dell'applicazione Windows: ")]
        [ValidateScript( { $_ -in $Applications.WinApplications.WinApplicationFullName } )]
        [string]$AppFullName,
        [Parameter(Mandatory = $true, Position = 1, 
            HelpMessage = "Digitare il percorso completo con i file aggiornati: ")]
        [ValidateScript ( { Test-Path $_ } )]
        [string]$ZipPath,
        [Parameter(HelpMessage = "Digitare eventuali file da escludere nell'aggiornamento: ")]
        [string[]]$ExcludeFiles = @($Applications.LicenseFile)
    )
    
    # Root folder
    $RootFolder = Get-AppSuiteRootFolder

    # Application Name
    $AppName = $($Applications.WinApplications | Where-Object { $_.WinApplicationFullName -eq $AppFullName }).WinApplicationName

    # Arresto il processo, se aperto
    $Process = Get-Process $AppName -ErrorAction SilentlyContinue
    if ($null -ne $Process) { 
        Write-Verbose "Provo a chiudere il processo $Process..."
        $Process.CloseMainWindow() | Out-Null
        Start-Sleep -Seconds 2
        if (!$process.HasExited) {
            $process | Stop-Process -Force
            Write-Warning "Non sono riuscito a chiudere con calma $Process, quindi l'ho killato :P"
        }
    }
    Remove-Variable Process

    # Ricavo la versione precedente
    $OldVersion = [version]$(Get-Item -Path "$RootFolder\$AppFullName\$AppName.exe").versioninfo.fileversion

    # Faccio un backup della versione precedente
    $OldFolder = "$AppFullName" + "_" + "$OldVersion"
    if ( !(Test-Path "$RootFolder\$OldFolder")) {
        New-Item -Path "$RootFolder\$OldFolder" -ItemType Directory | Out-Null
    }
    else {
        Write-Warning "La cartella $RootFolder\$OldFolder esiste già!"
    }
    Copy-Item -Path "$RootFolder\$AppFullName\*" -Destination "$RootFolder\$OldFolder" -Recurse -Force
    Write-Verbose "Ho copiato il contenuto di $RootFolder\$AppFullName dentro a $RootFolder\$OldFolder"

    # Estraggo dallo zip
    $ZipFile = Get-Item "$ZipPath\*$AppFullName*.zip"
    $ZipFolder = $ZipFile.BaseName
    if ( !(Test-Path "$ZipPath\$ZipFolder")) {
        New-Item -Path "$ZipPath\$ZipFolder" -ItemType Directory | Out-Null
    }
    else {
        Write-Warning "La cartella $ZipPath\$ZipFolder esiste già!"
    }
    Expand-Archive -Path $(Get-Item "$ZipPath\*$AppFullName*.zip") -DestinationPath "$ZipPath\$ZipFolder" -Force
    Write-Verbose "Ho estratto il contenuto di $ZipFile dentro a $ZipPath\$ZipFolder"

    # Prepara ExcludeFiles
    $ExcludeFiles += "$AppName.exe.config"

    # Sovrascrivo ricorsivamente i file estratti, escludendo quelli specificati in ExcludeFiles
    $SourceDir = "$ZipPath\$ZipFolder"
    $DestDir = "$RootFolder\$AppFullName"
    Get-ChildItem $SourceDir -Recurse -Exclude $ExcludeFiles | Copy-Item -Destination { Join-Path $DestDir $_.FullName.Substring($SourceDir.length) } -Recurse -Force -ErrorAction Continue
    Write-Verbose "Ho copiato i file di $SourceDir dentro a $DestDir, escludendo $ExcludeFiles"

    # Pulizia
    Remove-Item -LiteralPath "$ZipPath\$ZipFolder" -Force -Recurse

    # Test
    $ExeVersion = [version]$(Get-item -Path "$RootFolder\$AppFullName\$AppName.exe").VersionInfo.FileVersion
    $ZipVersion = $(Get-InstallFileInfo -Path $ZipFile).FileVersion
    $Testcondition = ($ExeVersion.Major -eq $ZipVersion.Major) -and ($ExeVersion.Minor -eq $ZipVersion.Minor) -and ($ExeVersion.Build -eq $ZipVersion.Build)

    if ( !$TestCondition ) {

        # Rollback !
        Write-Warning "Aggiornamento non riuscito. Rollback a versione precedente in corso..."

        # Cancello tutto dalla cartella di produzione AppFullName/
        Remove-item -Path "$RootFolder\$AppFullName\*" -Recurse -Force

        # Copia il contenuto della cartella OldFolder/ dentro ad AppFullName/
        Copy-Item -Path "$RootFolder\$OldFolder\*" -Destination "$RootFolder\$AppFullName" -Recurse -Force

        # Cancella cartella OldFolder/
        Remove-item -Path "$RootFolder\$OldFolder" -Recurse -Force

    }
    else {
        Write-Host "Ho aggiornato con successo l'applicazione $AppFullName dalla versione $OldVersion alla versione $ExeVersion" -ForegroundColor Green
    }

}