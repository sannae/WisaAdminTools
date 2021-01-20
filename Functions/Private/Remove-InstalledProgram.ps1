<#
.SYNOPSIS
    Disinstalla un programma installato basandosi sulla descrizione.
.DESCRIPTION
    Lo script richiede in input una stringa contenente la descrizione del programma (es. una parola chiave che lo identifichi).
    La descrizione viene usata per una comparazione con il campo Name dell'oggetto CIM_Product.
    Se l'oggetto in questione viene trovato, ne viene eseguito il metodo CIM Uninstall.
.PARAMETER DESCRIPTION
    Stringa contenente la descrizione del programma che si vuole disinstallare.
    Viene comparata con il campo Name dell'oggetto di classe CIM Product.
    Accetta valori da pipeline.
.EXAMPLE
    PS> Remove-InstalledProgram -Description Chrome
    Disinstalla il programma la cui descrizione contiene la stringa "Chrome"
.EXAMPLE
    PS> Get-InstalledProgram -Description SQL | Remove-InstalledProgram
    Disinstalla tutti i programmi trovati dalla funzione Get-InstalledProgram con descrizione SQL
.NOTES
    1.0 (testato)
    TODO : Come si mettono i parametri MSI a Invoke-CimMethod? tipo /NORESTART !!
    TODO : Gestire AcceptPipelineInput... Get-InstalledProgram restituisce un oggetto di cui si può considerare il campo DisplayName
#>


function Remove-InstalledProgram {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Description
    )
    
    # CimInstance (Get-WMIObject is obsolete)
    $Programs = Get-CimInstance -Class CIM_Product | Where-Object { $_.Name -match "$Description" }
    if ( $null -eq $Programs ) {
        Write-Error "Non ho trovato alcuna applicazione con la descrizione $Description! Riprovare con una dicitura diversa"
    }
    else {
        Write-Verbose "Ho trovato l'applicazione $($Programs.Name), procedo con la disinstallazione"
    }

    # Process
    Foreach ( $app in $Programs ) {

        # Uninstall
        $UninstallProcess = $app | Invoke-CimMethod -MethodName Uninstall

        # Check
        if ( $UninstallProcess.ReturnValue -ne '0' ) {
            Write-Error "Qualcosa è andato storto disinstallando il programma $($app.Name), verificare ed eventualmente disinstallare manualmente"
            break
        }
        else {
            Write-Host "Il programma $($app.Name) è stato disinstallato con successo!" -ForegroundColor Green
        }
    }
}


