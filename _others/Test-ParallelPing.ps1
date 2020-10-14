# Parallel ping
# Only on PowerShell >= 6.0

while(1) { 
    foreach ( $ip in @("10.204.254.190","10.204.254.189") ) { 
        Test-Connection $ip -Count 1 | Select-Object Address,Latency,Status
    } 
}