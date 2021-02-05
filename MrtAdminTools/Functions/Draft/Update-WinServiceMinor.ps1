# Aggiornamento servizio di Windows
# \\TODO:
function Update-WinServiceMinor {

    [CmdletBinding()]
    param (
        
    )
    
    begin {

        # Root folder
        $RootFolder = Get-AppSuiteRootFolder

    }
    
    process {

        # Service Name
        $ServiceName = $($Applications.WinServices | Where-Object { $_.WinServiceFullName -eq $WinServiceFullName }).WinServiceName

        # Chiudere le altre connessioni

        # Arresto il servizio, se avviato
        # \\TODO: Togliere il ForEach-Object! Piuttosto, passare a questa funzione più valori tramite pipeline
        $Serv = Get-Service *$ServiceName* -ErrorAction SilentlyContinue 
        $Serv.Stop() | Out-Null # Ci provo gentilmente
        Start-Sleep -Seconds 3
        if ($Serv.Status -ne 'Stopped') {

            Write-Warning "Non sono riuscito ad arrestare con calma $($_.Name), quindi lo uccido :P"
            # Nome del servizio
            $ServName = $Serv.Name
            # Eseguibile del servizio
            $ServExecutable = Get-WmiObject win32_service | Where-Object { $_.Name -eq $Name } | Select-Object -ExpandProperty PathName
            # Stoppa il processo del servizio
            Get-Process | Where-Object { $_.Path -eq $Executable } | Stop-process -Force
            # Pulizia
            Remove-Variable $Name, $Executable

        }

    }
    
    end {
        
    }
}

# 