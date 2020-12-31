<#
.SYNOPSIS
    Installa la Micronpass Application Suite su una partizione specifica.
.DESCRIPTION
    Lo script verifica l'esistenza del percorso indicato con il parametro SETUPPATH e che questo contenga il file ZIP.
    Inoltre, verifica che l'unità disco indicata con il parametro INSTALLPARTITION sia effettivamente una root di partizione del disco di filesystem.
    Viene spacchettato lo ZIP nella cartella SETUPPATH e viene lanciato con i parametri di Setup (installazione silenziosa, log di errori).
    La cartella MPW viene creata automaticamente sotto il percorso INSTALLPARTITION.
    Ovviamente l'installazione prevede i componenti "base" del file Setup, non essendoci interattività per customizzarli.
    Se l'installazione non va a buon fine, viene restituito l'ExitCode.
    Al termine viene comunque richiamata la funzione Test-InstalledProgram.
.PARAMETER SETUPPATH
    Stringa con il percorso contenente il file $mrtxxxx.zip. 
    Ne viene verificata l'esistenza, e viene verificata l'esistenza di un file con nome "mrt*zip" al suo interno.
.PARAMETER INSTALLPARTITION
    Stringa con il percorso contenente la partizione di destinazione dell'installazione. Il valore di default è "C:\"".
    Viene verificato che appartenga alle cartelle root di filesystem: indicare il nome completo (ovvero "C:\" e non "C:")
    In altre parole, è possibile installare direttamente su root di partizione (C:\, D:\, ecc.) ma NON in una sua sottocartella.
    Questo controllo in realtà non è stringente (lo script può installare anche su sottocartelle), ma è pensato per facilitare il lavoro alla funzione Get-MpwRootFolder.
    Una ricerca per sottocartelle, infatti, richiederebbe una scansione dell'intero filesystem e impiegherebbe un sacco di tempo.
.EXAMPLE
    PS> Install-MrtSuite -SetupPath "C:\MPW_INSTALL" -InstallPartition "C:\"
    Lancia il file exe presente nello zip in C:\MPW_INSTALL nel percorso C:\
.NOTES
    1.0 (testato)
    TODO: Non si può proprio aggirare il vincolo di installare su root di partizione?
    TODO: Eventualmente, sostituire Start-Process con una funzione ad-hoc tipo Invoke-SetupExe.
#>


function Install-MrtSuite {

    [CmdletBinding()] 
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Percorso del file ZIP:")]
        [ValidateScript ( { Test-Path $_ } -and { Test-Path $('$mrt' + "*.zip") } )]
        [string] $SetupPath,
        [Parameter(Mandatory = $false, Position = 1, HelpMessage = "Partizione di installazione (C:\, D:\, ecc.), non è necessario specificare MPW:")]
        [ValidateScript ( { $(Get-PSDrive -PSProvider 'FileSystem' | Where-Object Used).Root -contains $_ } )]
        [string] $InstallPartition = "C:\"
    )

    # Nome del file ZIP
    $SetupZip = $(Get-Item $("$SetupPath\" + '$mrt' + "*.zip")).FullName

    # Estrai da ZIP
    Write-Verbose "Sto estraendo lo ZIP $SetupZIP nel percorso $SetupPath..."
    Expand-Archive -Path $SetupZip -DestinationPath $SetupPath
    $SetupFile = $(Get-Item ("$SetupPath\*mrt*.exe")).FullName

    # Installa EXE
    $SetupExeArguments = @(
        '/s' # Hide initialization dialog
        "/v""/qn /L*e $SetupPath\setup.log INSTALLDIR=$InstallPartition\MPW""" # Msiexec parameters (log and destination folder)
    )
    Write-Verbose "Sto installando $SetupFile, puoi trovare un file log al percorso $SetupPath..."
    $SetupExeProcess = Start-Process $SetupFile -PassThru -Wait -ArgumentList $SetupExeArguments -Verbose

    if ( $SetupExeProcess.ExitCode -ne 0 ) {
        Write-Error "Errore nell'installazione di $SetupFile, il processo è terminato con ExitCode $($SetupExeProcess.ExitCode). Verificare il file $SetupPath\Setup.log"+
        break
    }
    else {
        Write-Verbose "Applicativo installato con successo!"
    }

    # Controlla che sia stato installato
    Test-InstalledProgram -Name "Micronpass" -Verbose

}