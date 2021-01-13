# Aggiorna applicazioni WinForm, tipo MicronConfig o MicronStart

function Update-MrtWinApp {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, 
            HelpMessage = "Digitare il nome completo dell'applicazione: ")] 
        [string] $AppFullName,
        [Parameter(Mandatory = $true, Position = 1, 
            HelpMessage = "Digitare il percorso completo con i file aggiornati: ")]
        [string] $ZipPath
    )

    # Root folder
    $RootFolder = Get-AppSuiteRootFolder

    # Trova l'applicazione specificata e chiudila se aperta
    Get-Process | Where-Object { $_.Path -match "$RootFolder\$AppFullName" } | Stop-Process

    # Tolgo il simbolo '$' dal nome dei file da installare, se no fa casino
    $ZipFile = Get-item "$ZipPath\*.zip"
    ForEach ( $file in $ZipFile ) {
        if ( $file.Name.Substring(0, 1) -eq '$') {
            Rename-Item $File -NewName $File.Name.Substring(1)
        }
    }
    $InstallFile = $(Get-item "$ZipPath\$AppFullName*.zip")

    # Copia vecchia cartella
    $OldVersionString = $(Get-Item "$RootFolder\$AppFullName\*.exe" -Exclude "JSONEdit.exe").versioninfo.fileversion.substring(0, 7)
    $OldVersion = [version]$OldVersionString
    $OldFolder = "$AppFullName" + "_" + "$OldVersionString"
    if ( !(Test-Path "$RootFolder\$OldFolder")) {
        New-Item -Path "$RootFolder\$OldFolder" -ItemType Directory | Out-Null
    }
    else {
        Write-Error "La cartella $RootFolder\$OldFolder esiste già!"
        break
    }
    Copy-Item -Path "$RootFolder\$AppFullName\*" -Destination "$RootFolder\$OldFolder" -Force
    Write-Verbose "I file della vecchia applicazione sono stati copiati in '$RootFolder\$OldFolder'"

    # Estraggo ZIP in una cartella locale

    # Copio ricorsivamente i file estratti nella cartella sotto MPW (escludi .exe.config e MRT.LIC se presenti)

    # Cancello cadaveri pendenti

    # ...

}