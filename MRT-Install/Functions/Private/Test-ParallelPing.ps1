# Parallel ping
# Only on PowerShell >= 6.0

while(1) { 
    foreach ( $ip in @("192.168.62.106","192.168.62.107") ) { 
        Test-Connection $ip -Count 1 | Select-Object Address,Latency,Status
    } 
}