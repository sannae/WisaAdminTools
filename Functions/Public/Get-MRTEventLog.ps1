<#
GOAL: Raccogli il contenuto di più log dalla cartella di MicronService, filtrando secondo una certa data-ora

Il formato data-ora è dd-MM-yyyy hh:mm:ss:fff e vale per tutti i file Micronservice\*.log

#>

Clear-Host

# TODO : Parameters: possibilità di scegliere quali log aggiungere

<#
Param(
    [Parameter(Mandatory=$false)] [switch]$AllDebug,
    [Parameter(Mandatory=$false)] [switch]$BtLibErr,
    [Parameter(Mandatory=$false)] [switch]$CfgDebug,
    [Parameter(Mandatory=$false)] [string]$Debug,
    [Parameter(Mandatory=$false)] [switch]$GNetMap,
    [Parameter(Mandatory=$false)] [switch]$ServiceLog,
    [Parameter(Mandatory=$false)] [switch]$TCPDebug,
    [Parameter(Mandatory=$false)] [switch]$All
)
#>

# General paths and files

$RootPath = "C:\MPW\MicronService"
New-Item -Path "$RootPath\temp.log" | Out-null
$TempOutFile = "$RootPath\temp.log"
$OutFile = "$RootPath\MRTEventLog.log"

#using max and min value for the example so all correct dates will comply

$lowerLimit = Get-Date -Date '16-05-2018 00:00:00' # <-- replace with your own date
$upperLimit = Get-Date -Date '17-05-2018 00:00:00'  # <-- replace with your own date

# Logs array
# Questa sezione dovrà essere dismessa in favore dei parametri sopra

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
            #date is malformed (maybe the line is empty or there is a typo), skip it
            }
    }

}

# Sort results and remove temporary log

Get-Content $TempOutFile | Sort-Object | Add-Content -Path $OutFile
Remove-Item $TempOutFile