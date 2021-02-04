# Link:
# https://docs.microsoft.com/en-us/windows/client-management/troubleshoot-tcpip-port-exhaust

# Analisi solo su connessioni TCP
# netstat non si allontana molto dai risultati di Get-NetTcpConnection,
# basti eseguire (netstat -qno -p TCP).Count versus (Get-NetTcpConnection).Count e si vede che la differenza è minima.

<#
	Closed	 	- The TCP connection is closed. 
	CloseWait 	- The local endpoint of the TCP connection is waiting for a connection termination request from the local user. 
	Closing 	- The local endpoint of the TCP connection is waiting for an acknowledgement of the connection termination request sent previously. 
	DeleteTcb 	- The transmission control buffer (TCB) for the TCP connection is being deleted. 
	Established 	- The TCP handshake is complete. The connection has been established and data can be sent. 
	FinWait1 	- The local endpoint of the TCP connection is waiting for a connection termination request from the remote endpoint or for an acknowledgement of the connection termination request sent previously. 
	FinWait2 	- The local endpoint of the TCP connection is waiting for a connection termination request from the remote endpoint. 
	LastAck 	- The local endpoint of the TCP connection is waiting for the final acknowledgement of the connection termination request sent previously. 
	Listen	 	- The local endpoint of the TCP connection is listening for a connection request from any remote endpoint. 
	SynReceived 	- The local endpoint of the TCP connection has sent and received a connection request and is waiting for an acknowledgment. 
	SynSent 	- The local endpoint of the TCP connection has sent the remote endpoint a segment header with the synchronize (SYN) control bit set and is waiting for a matching connection request. 
	TimeWait	- The local endpoint of the TCP connection is waiting for enough time to pass to ensure that the remote endpoint received the acknowledgement of its connection termination request. 
	Unknown		- The TCP connection state is unknown.
	
	Values are based on the TcpState Enumeration:
	http://msdn.microsoft.com/en-us/library/system.net.networkinformation.tcpstate%28VS.85%29.aspx

#>

function Get-NetstatProcess {
	
	[CmdletBinding()]
	param (
		[string]$PathContains = "*"
	)
	
	# Netstat con dettaglio dei processi

	Get-NetTCPConnection  | 
	Select-Object -property LocalAddress, LocalPort, RemoteAddress, RemotePort, State,
	@{Name = "PID"; Expression = { $_.OwningProcess } }, 
	@{Name = "ProcessName"; Expression = { $(Get-Process -id $_.OwningProcess).Name } },
	@{Name = "ProcessProduct"; Expression = { $(Get-Process -id $_.OwningProcess).Product } },
	@{Name = "ProcessPath"; Expression = { $(Get-Process -id $_.OwningProcess).Path } } | 
	Where-Object { ( $_.ProcessPath -like "*$PathContains*" ) } | 
	Format-Table -Autosize | Tee-Object -Variable Connections

	# Raggruppamento ( \\Da rivedere )
	$Connections | 
	Group-Object -Property PID,State |
    Select-Object -Property Count,@{Name="State";Expression={($_.Name.Split(',')[1])}}, 
        @{Name="ProcessID";Expression={($_.Name.Split(',')[0])}}, 
        @{Name="ProcessName";Expression={(Get-Process -PID ($_.Name.Split(',')[0].Trim(' '))).Name}} |
    Sort-Object Count -Descending | 
    Format-Table -Autosize

}


