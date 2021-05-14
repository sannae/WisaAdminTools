<#
.SYNOPSIS
    Log gatherer: it returns an array list containing DateTime, LogName and the content of the log row for a specific application.
.DESCRIPTION
    The script reads row-by-row each log file within the folder of a specific application.
    The application may be a Windows service or a web application: its path must be specified in the $Path variable.
    The script recursively searches all the files .log in the application root folder, then it parses the date and the content.
    The date and content of each row are then used to build a PSCustomObject.
    The date is filtered with the parameters $StartDate and $StopDate.
    Optionally, you may filter only rows containing a specific string stated in variable $SearchString.
    The scripts returns on host an ArrayList object, sorted by ascending DateTime.  
.PARAMETER PATH
    Log folder path: all the *.log files are searched.
    The existence of the path is checked.
.PARAMETER STARTDATE
    Starting date in format 'dd-MM-yyyy hh:mm:ss'.
    Default value is today at 00:00:00.
.PARAMETER STOPDATE
    Stopping date in format 'dd-MM-yyyy hh:mm:ss'.
    Default value is today at 23:59:59.
.PARAMETER SEARCHSTRING
    String to be searched in the log files as a filter.
    Default value is "*", i.e. no filter is applied.
.PARAMETER EXTENSION
    String array specifying the file extensions to be searched.
    Default value is "log", i.e. only *.log files are searched for.
.PARAMETER SILENT
    Switch to overwrite the variable $ErrorActionPreference from Continue to SilentlyContinue.
    Warning: this switch only shuts errors on hosts, just to accelerate the process.
.EXAMPLE
    PS> Get-AllFolderLogs -Path MYAPPFOLDER
    It returns all today's logs from the application residing in MYAPPFOLDER.  
.EXAMPLE
    PS> Get-AllFolderLogs -Path MYAPPFOLDER -StartDate '01-01-2020 00:00:00' -StopDate '02-01-2020 00:00:00'
    It returns all the logs during 01-01-2020 from the application residing in MYAPPFOLDER.  
.EXAMPLE
    PS> Get-AllFolderLogs -PAth MYAPPFOLDER -SearchString "Disconnessione"
    Restituisce tutti i log dell'applicativo MYAPPFOLDER contenenti la stringa "Disconnessione" 
.NOTES
    TODO : Error handling on IF containing parseDate, to handle rows not including a date-time
    TODO : Edit parameter $SearchString from [string] to [string[]]
    TODO : Handle -Include and -Exclude in $SearchString, to exclude useless results
#>

function Get-AllFolderLogs {

    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $True,
            HelpMessage = "Insert folder full path",
            ValueFromPipeline = $true)]
        [ValidateScript( { Test-Path $_ } )]
        [string]$Path,
        [Parameter(
            HelpMessage = "Insert starting date-time (dd-MM-yyyy hh:mm:ss)")]
        [String]$StartDate = (Get-Date -Format 'dd-MM-yyyy 00:00:00').ToString(),
        [Parameter(
            HelpMessage = "Insert ending date-time (dd-MM-yyyy hh:mm:ss)")]        
        [String]$StopDate = (Get-Date -Format 'dd-MM-yyyy 23:59:59').ToString(),
        [string]$SearchString = "*",
        [string[]]$Extension = "log",
        [switch]$Silent
    )

    # Ignore errors
    if ($Silent) {
        $ErrorActionPreference = "SilentlyContinue"
    }

    # Save logs in a variable
    $Logs = Get-ChildItem -Path $Path -Recurse | Where-Object { $_.Name -like "*.$Extension" }
    if ( $null -eq $Logs ) {
        Write-Error "No file with extension .$Extension were found in the specified path!"
    }
    else {
        $Logs | ForEach-Object { Write-Verbose "I found the log: $_ " }
    }

    # Creates array to save the results
    $LogResults = [System.Collections.ArrayList]@()

    ForEach ( $Log in $Logs ) {

        # Log name
        $LogName = $Log.Name
        Write-Verbose "I'm reading the whole log $LogName..."

        # Log content, each row
        $logContent = Get-Content $($Log).FullName | Select-Object -skip 1 # Rimuove la prima riga
        $logContent -split "`n" | Where-Object { $_.trim() } | Out-null

        # Loops on each row
        $logContent | ForEach-Object {

            # DateTime (as string) and content of each row
            $RowDate = ($_ -split '\s', 3)[0] + ' ' + ($_ -split '\s', 3)[1]

            if ( ($RowDate -eq '') -or ($RowDate -eq ' ') ) {
                continue
            }
            else {

                $RowDate = $RowDate.Substring(0, 19) + '.' + $RowDate.Substring(20, 3) # Helpful for the next comparison
                $RowContent = ($_ -split '\s', 3)[2]

                # DateTime comparison
                if (([DateTime]::Parse("$Rowdate") -gt [DateTime]::Parse("$StartDate")) -and ([DateTime]::PArse("$Rowdate") -lt [DateTime]::Parse("$StopDate"))) {

                    # Creates the row PS object
                    $LogRow = [PSCustomObject]@{
                        DateTime = [DateTime]::Parse("$RowDate")
                        LogName  = $LogName
                        Content  = $RowContent
                    }

                    if ($LogRow.Content -like $SearchString) {

                        # Add the object to the LogResults arraylist
                        $LogResults.Add($LogRow) | Out-Null
                    }
                }
            }
        }
    }

    # Returns the results
    $LogResults = $LogResults | Sort-Object -Property DateTime | Format-Table -AutoSize
    $LogResults

}