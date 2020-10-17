# netstat looking for a specific process

$InputProcess = 'chrome' # Insert here process name

# Well-known ports

$GNet = '3001' ; $http = '80' ; $https = '443' ; $SqlServer = '1433' ; $SSH = '22' ; $telnet = '23' ;

# Netstat

$nets = netstat -ano | Select-String -Pattern 'TCP';

$n = 0

# Define Connections list

$Connections = New-Object System.Collections.ArrayList
$Connections = [System.Collections.ArrayList]::new()

# Define the Connection array

$Connection = @(
       [pscustomobject]@{
            ConnectionProtocol='';
            ConnectionLocal='';
            ConnectionRemote='';
            ConnectionStatus='';
            ConnectionProcID='';
            ConnectionType='';
            ProcessName='';
            ProcessDescription='';
            ProcessPath='';
            ProcessVersion='';
        }
   )

foreach ( $net in $nets ) {

    # Split the row

    $nar = $($net -replace ' +',' ').Split(' ');

    $Connection[$n].ConnectionProtocol = $nar[1]
    $Connection[$n].ConnectionLocal = $nar[2]
    $Connection[$n].ConnectionRemote = $nar[3]
    $Connection[$n].ConnectionStatus = $nar[4]
    $Connection[$n].ConnectionProcID = $nar[5]

    # Get the process details

    $Process = Get-Process -id $Connection[$n].ConnectionProcID

    $Connection[$n].ProcessName = $Process.ProcessName;
    $Connection[$n].ProcessPath = $Process.Path;
    $Connection[$n].ProcessDescription = $Process.Description
    $Connection[$n].ProcessVersion = $Process.FileVersion

    # Type of connection

        if ( ($nar[2] -match $Gnet) -or ($nar[3] -match $Gnet) ) {
            $Connection[$n].ConnectionType = 'CONNESSIONE A TERMINALE BASE'
        } elseif ( ($nar[2] -match $http) -or ($nar[3] -match $http) ) {
            $Connection[$n].ConnectionType = 'HTTP'
        } elseif ( ($nar[2] -match $https) -or ($nar[3] -match $https) ) {
            $Connection[$n].ConnectionType = 'HTTPS'
        } elseif ( ($nar[2] -match $SqlServer) -or ($nar[3] -match $SqlServer) ) {
            $Connection[$n].ConnectionType = 'SQL SERVER'
        } elseif ( ($nar[2] -match $SSH) -or ($nar[3] -match $SSH) ) {
            $Connection[$n].ConnectionType = 'SSH/SFTP'
        } elseif ( ($nar[2] -match $telnet) -or ($nar[3] -match $telnet) ) {
            $Connection[$n].ConnectionType = 'TELNET'
        } else {
            $Connection[$n].ConnectionType = 'N/A'
        }

    # Test
    Write-Host $Connection

    # Add item to the list
     if ( $Connection[$n].ProcessName -match $InputProcess ) {
        $Connections.Add($Connection)
    }

}

$Connections | Format-Table # | Out-file -FilePath netstat.txt