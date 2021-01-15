<#
.SYNOPSIS
    Installa SAP Crystal Reports runtime engine a 32 e 64 bit.
.DESCRIPTION
    Lo script prende come input il percorso in cui devono trovarsi i file MSI dei Crystal Reports.
    Viene verificata l'esistenza del percorso e la presenza di entrambi i file MSI (32 e 64 bit).
    Ciascuno dei due file viene installato semplicemente lanciando l'utility di sistema MSIEXEC in maniera 'quiet'.
    Se l'installazione non ha successo, viene restituito l'ExitCode del processo.
.EXAMPLE
    PS> Install-IISFeatures -MsiPath C:\.temp
.NOTES
    0.9 (testato post-refactoring)
    TODO: Non si potrebbe mettere una specie di Write-Progress ? 
    TODO: Controllare che non ci sia già un'installazione in corso...
    TODO: Implementare una funzione Invoke-MsiExec ? Oppure sostituire direttamente con Invoke-CimMethod 
        A questo proposito, v. https://docs.microsoft.com/it-it/powershell/scripting/samples/working-with-software-installations?view=powershell-7.1#installing-applications
#>

function Install-CrystalReports {
    [CmdletBinding()]
    param (
        # MSI path
        [Parameter(Mandatory = $true, Position = 0, 
            HelpMessage = "Digitare il percorso completo dei file MSI: ")]
        [ValidateScript ( { 
                ( Test-Path $_ ) -and ( Test-Path "$_\Crruntime_32bit*.msi" ) -and ( Test-Path "$_\Crruntime_64bit*.msi"  )
            } )]
        [string] $MsiPath
    )
    
    # Cerca file CRRuntime
    (Get-Item "$MsiPath\CRRuntime_*.msi") | ForEach-Object {

        # Nome del file
        $FileFullName = $_.FullName

        # Argomenti Msiexec
        $MsiArgs = @(
            "/qn"
            "/i"
            "$FileFullName"
            "/norestart"
        )

        # Msiexec
        Write-Verbose "Sto installando il file $($_.Name)..."
        $InstallProcess = Start-Process -PassThru -Wait "MsiExec.exe" -ArgumentList $MsiArgs
        
        # ExitCode
        if ( $InstallProcess.ExitCode -ne 0 ) {
            Write-Error "Qualcosa è andato storto nell'installazione del file $($_.Name), il processo è uscito con Exit Code $($InstallProcess.ExitCode). Controlla su 'https://docs.microsoft.com/en-us/windows/win32/msi/error-codes'"
        }
        else {
            Write-Verbose "$($_.Name) è stato installato con successo!"
        }
    }

}