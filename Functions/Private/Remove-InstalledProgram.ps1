<#
.SYNOPSIS
    
.DESCRIPTION
    
.PARAMETER CONNECTIONSTRING
    
.EXAMPLE
    
.NOTES
    
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


