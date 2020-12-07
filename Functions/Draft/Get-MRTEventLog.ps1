<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER PARAMETER
    
.EXAMPLE

.EXAMPLE

.NOTES

#>

function Get-MRTServiceEventLog {

    # General paths and files
    $RootFolder = Get-MPWRootFolder
    $RootPath = "$RootFolder\MicronService"
    New-Item -Path "$RootPath\temp.log" | Out-null
    $TempOutFile = "$RootPath\temp.log"
    $OutFile = "$RootPath\MRTEventLog.log"

    # using max and min value for the example so all correct dates will comply
    $lowerLimit = Get-Date -Date '30-10-2020 14:14:00'
    $upperLimit = Get-Date -Date '30-10-2020 15:20:00'

    # Logs array
    # Questa sezione dovrà essere dismessa in favore dei parametri
    $Logs = @()

    $DebugLogs = @()
    ForEach ( $DebugLog in ( Get-ChildItem "$RootPath\Debug_*.log").Name ) {
        $DebugLogs = $DebugLogs + $DebugLog
    }

    $MaintenanceLogs = @(
        "BtLibErr.log",
        "CfgDebug.log",
        "GNetMap.log",
        "Servicelog.log",
        "TCPDebug.log"
    )

    $Logs = $Logs + $MaintenanceLogs + $DebugLogs

    # Read log file and skip first line

    ForEach ( $Log in $logs ) {

        $logContent = Get-Content "$RootPath\$Log" | Select-Object -skip 1 # Rimuove la prima riga di servicelog.log
        $logContent -split "`n" | Where-Object {$_.trim()} | Out-null

        # Loop through the content
        $logContent | ForEach-Object {

            # Get date and content from each line
            $dateAsText = ($_ -split '\s',3)[0] + ' ' + ($_ -split '\s',3)[1]
            $Content = ($_ -split '\s',3)[2]

            # Parse date to compare it
            $date = [DateTime]::ParseExact($dateAsText.trim(),"dd-MM-yyyy HH:mm:ss:fff",[Globalization.CultureInfo]::InvariantCulture)
            
            try {
                if (($date -gt $lowerlimit) -and ($date -lt $upperLimit)) {
                    Add-Content -Path $TempOutFile -Value "$dateAsText $Log --- $Content"
                }
            }
            catch [InvalidOperationException] {
                # date is malformed (maybe the line is empty or there is a typo), skip it
                }
        }

    }

    # Sort results and remove temporary log

    Get-Content $TempOutFile | Sort-Object | Add-Content -Path $OutFile
    Remove-Item $TempOutFile

}