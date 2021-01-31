#* FileName: Log-Connections.ps1
#* Web: http://www.KennethGHartman.com

 


#*******************************************
#* Get-NetworkStatistics Function          *
#*******************************************

function Get-NetworkStatistics {
	[OutputType('System.Management.Automation.PSObject')]
	[CmdletBinding(DefaultParameterSetName = 'name')]

	param(
		[Parameter(Position = 0, ValueFromPipeline = $true, ParameterSetName = 'port')]
		[System.Int32]$Port = '*',
		
		[Parameter(Position = 0, ValueFromPipeline = $true, ParameterSetName = 'name')]
		[System.String]$ProcessName = '*',
		
		[Parameter(Position = 0, ValueFromPipeline = $true, ParameterSetName = 'address')]
		[System.String]$Address = '*',		
		
		[Parameter()]
		[ValidateSet('*', 'tcp', 'udp')]
		[System.String]$Protocol = '*',

		[Parameter()]
		[ValidateSet('*', 'Closed', 'CloseWait', 'Closing', 'DeleteTcb', 'Established', 'FinWait1', `
				'FinWait2', 'LastAck', 'Listen', 'SynReceived', 'SynSent', 'TimeWait', 'Unknown')]
		[System.String]$State = '*'
		
	)
    
	begin {
		
		$properties = 'Protocol', 'LocalAddress', 'LocalPort'
		$properties += 'RemoteAddress', 'RemotePort', 'State', 'ProcessName', 'PID'
	}
	
	process {

		# Select netstat
		netstat -ano | Select-String -Pattern '\s+(TCP|UDP)' | ForEach-Object {

			# Per ogni item, splitta gli spazi
			$item = $_.line.split(' ', [System.StringSplitOptions]::RemoveEmptyEntries)

			# Ad eccezione degli indirizzi vuoti ::
			if ($item[1] -notmatch '^\[::') {      
				
				# Indirizzo locale e porta locale
				if (($la = $item[1] -as [ipaddress]).AddressFamily -eq 'InterNetworkV6') {
					$localAddress = $la.IPAddressToString
					$localPort = $item[1].split('\]:')[-1]
				}
				else {
					$localAddress = $item[1].split(':')[0]
					$localPort = $item[1].split(':')[-1]
				} 

				# Indirizzo remoto e porta remota
				if (($ra = $item[2] -as [ipaddress]).AddressFamily -eq 'InterNetworkV6') {
					$remoteAddress = $ra.IPAddressToString
					$remotePort = $item[2].split('\]:')[-1]
				}
				else {
					$remoteAddress = $item[2].split(':')[0]
					$remotePort = $item[2].split(':')[-1]
				} 
				
				# ProcessID
				$procId = $item[-1]

				# ProcessName
				$ProcName = (Get-Process -Id $item[-1] -ErrorAction SilentlyContinue).Name

				# Protocol
				$proto = $item[0]

				# State of TCP connection
				$status = if ($item[0] -eq 'tcp') { $item[3] } else { $null }				
				
				# PSCustomObject
				$pso = New-Object -TypeName PSObject -Property @{
					PID           = $procId
					ProcessName   = $ProcName
					Protocol      = $proto
					LocalAddress  = $localAddress
					LocalPort     = $localPort
					RemoteAddress = $remoteAddress
					RemotePort    = $remotePort
					State         = $status
				} | Select-Object -Property $properties								

				# Check port, check State rispetto al parametro
				if ($PSCmdlet.ParameterSetName -eq 'port') {
					if ($pso.RemotePort -like $Port -or $pso.LocalPort -like $Port) {
						if ($pso.Protocol -like $Protocol -and $pso.State -like $State) {
							$pso
						}
					}
				}

				# Check local address, check protocol, check state
				if ($PSCmdlet.ParameterSetName -eq 'address') {
					if ($pso.RemoteAddress -like $Address -or $pso.LocalAddress -like $Address) {
						if ($pso.Protocol -like $Protocol -and $pso.State -like $State) {
							$pso
						}
					}
				}
				
				# Check Process Name
				if ($PSCmdlet.ParameterSetName -eq 'name') {		
					if ($pso.ProcessName -like $ProcessName) {
						if ($pso.Protocol -like $Protocol -and $pso.State -like $State) {
							$pso
						}
					}
				}
			}
		}
	}
}



function Log-Connections {

	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $True, Position = 0)]
		[string]$FilePath,
   
		[Parameter(Mandatory = $False, Position = 1)]
		[string]$ProcName = '*',
	
		[switch]$PassThru
	) 

	#Add Header to the CSV File
	[string]$Previous = "TimeStamp,Protocol,LocalAddress,LocalPort,RemoteAddress,"
	$Previous += "RemotePort,State,ProcessName,PID"
	Add-Content $FilePath $Previous

	#Initiate an infinite loop that calls the Get-NetworkStatistics Function repeatedly
	#and formats the output as appropriate
	while ($true) {

		# Connessioni per ProcessName
		$Observation = Get-NetworkStatistics $ProcName

		# Connessioni in formato stringa, chiama attuale
		[string]$Current = $Observation | Out-String

		# Se precedente diverso da attuale
		if ($Previous -ne $Current) {

			# Timestamp
			[string]$TimeStamp = Get-Date -Format o
			
			# Update previous-current
			$Previous = $Current

			# Loop sockets
			ForEach ($Socket in $Observation) {

				# Create string with timestamp and records
				$Record = $TimeStamp + "," + $Socket.Protocol + "," + $Socket.LocalAddress + "," `
					+ $Socket.LocalPort + "," + $Socket.RemoteAddress + "," + $Socket.RemotePort + "," `
					+ $Socket.State + "," + $Socket.ProcessName + "," + $Socket.PID
				
				# Add record to log 
				Add-Content $FilePath $Record

				# Pass object to console
				if ($PassThru) {
					$pso2 = New-Object -TypeName PSObject -Property @{
						PID           = $Socket.PID
						ProcessName   = $Socket.ProcessName
						Protocol      = $Socket.Protocol
						LocalAddress  = $Socket.LocalAddress
						LocalPort     = $Socket.LocalPort
						RemoteAddress = $Socket.RemoteAddress
						RemotePort    = $Socket.RemotePort
						State         = $Socket.State
						TimeStamp     = $TimeStamp
					} | Select-Object -Property $properties	
			
					Write-Output $pso2
				}
			}
		}
	}
}

<#
.SYNOPSIS
	Creates a log of current TCP/IP connections and optionally passes them through to the pipeline.

.DESCRIPTION
	Logs active TCP connections and includes the process ID (PID) and Name for each connection.
	If the port is not yet established, the port number is shown as an asterisk (*).	
	
.PARAMETER FilePath
	The path and file name of the log file. Mandatory.

.PARAMETER ProcName
	Log only connections with the name of the process provided. The default value is '*'.
	
.SWITCH PassThru
	Return a process object to the screen or the pipeline. 

.EXAMPLE
	Log-Connections mylog.csv

.EXAMPLE
	Log-Connections mylog.csv svchost

.EXAMPLE
	Log-Connections mylog.csv svchost -PassThru

.EXAMPLE
	Log-Connections -Filepath mylog.csv -ProcName svchost 

.EXAMPLE
	Log-Connections mylog.csv svchost -PassThru | Format-Table
	
.EXAMPLE
	Log-Connections mylog.csv svchost -PassThru | Out-GridView

.OUTPUTS
	System.Management.Automation.PSObject

.NOTES
#>	