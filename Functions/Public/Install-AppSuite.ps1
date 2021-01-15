<#
.SYNOPSIS
    Installa l'Application Suite su una partizione specifica.
.DESCRIPTION
    Lo script verifica l'esistenza del percorso indicato con il parametro SETUPPATH e che questo contenga il file ZIP.
    Inoltre, verifica che il percorso indicato con il parametro INSTALLPATH esista nel filesystem.
    Viene spacchettato lo ZIP nella cartella SETUPPATH e viene lanciato con i parametri di Setup (installazione silenziosa, log di errori).
    Ovviamente l'installazione prevede i componenti "base" del file Setup, non essendoci interattività per customizzarli.
    Se l'installazione non va a buon fine, viene restituito l'ExitCode.
    Al termine viene comunque richiamata la funzione Test-InstalledProgram per verificare la corretta installazione.
.PARAMETER SETUPPATH
    Stringa con il percorso contenente il file ZIP contenente il file Setup.
    Il nome del file setup è parametrabile nel file JSON alla sezione AppSuiteFileName.
    Ne viene verificata l'esistenza, e viene verificata l'esistenza di un file con nome "AppSuiteFileName*zip" al suo interno.
.PARAMETER INSTALLPATH
    Stringa con il percorso contenente la cartella su cui si vuole installare l'application suite.
    Nella cartella specificata viene creata automaticamente la cartella root dell'applicazione.
    Il nome di quest'ultima è specificato nel file JSON alla sezione RootFolderName.
.EXAMPLE
    PS> Install-AppSuite -SetupPath "C:\INSTALL" -InstallPath "C:\"
    Lancia il file exe presente nello zip in C:\INSTALL nel percorso C:\
.NOTES
    0.9 (da testare dopo refactoring)
    TODO: Controllare che non ci sia già un'installazione in corso...
    TODO: Gestire il fatto che .exe esista già, se no Expand-Archive va in errore
    TODO: Spostare test finale su Pester
    TODO: Eventualmente, sostituire Start-Process con una funzione ad-hoc tipo Invoke-SetupExe.
        Eventualmente utilizzare Invoke-CimMethod, v. https://docs.microsoft.com/it-it/powershell/scripting/samples/working-with-software-installations?view=powershell-7.1#installing-applications
#>


function Install-AppSuite {

    [CmdletBinding()] 
    param(
        [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Percorso del file ZIP:")]
        [ValidateScript ( { Test-Path $_ } -and { Test-Path $($Applications.AppSuiteFileName + "*.zip") } )]
        [string] $SetupPath,
        [Parameter(Mandatory = $false, Position = 1, HelpMessage = "Percorso di installazione (default a C:)")]
        [ValidateScript ( { Test-Path $_ } )]
        [string] $InstallPath = "C:\"
    )

    # Nome del file ZIP
    $SetupZip = $( get-item "*$($Applications.AppSuiteFileName)*.zip" ).FullName

    # Estrai da ZIP
    Write-Verbose "Sto estraendo lo ZIP $SetupZIP nel percorso $SetupPath..."
    Expand-Archive -Path $SetupZip -DestinationPath $SetupPath
    $SetupFile = $( get-item "*$($Applications.AppSuiteFileName)*.exe" ).FullName

    # Installa EXE
    $RootFolderName = $Applications.RootFolderName
    $SetupExeArguments = @(
        '/s' # Hide initialization dialog
        "/v""/qn /L*e $SetupPath\setup.log INSTALLDIR=$InstallPath\$RootFolderName""" # Msiexec parameters (log and destination folder)
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
    Test-InstalledProgram -Name $Applications.AppSuiteName -Verbose

}