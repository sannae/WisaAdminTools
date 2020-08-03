
# Writes a log
function Write-Log {
    param ([string]$logstring)
    $LogPath = "$InstallLocation\LOGS\_main_install.log"
    $datetime = Get-Date -format "[dd-MM-yyyy HH:mm:ss]"
    # Writes date-time and string
    Add-content $LogPath -value "$datetime $logstring"
    # Print to console the
    Write-Host $logstring
}

