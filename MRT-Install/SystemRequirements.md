
## Minimum System Requirements
The following requirements involve the standard components of the Micronpass Application Suite only: additional requirements may be needed in case of additional software modules.

### Recommended hardware requirements
* Web Server: 2 vCPU, 8GB RAM, 60GB HD system-data partition
* Web & DB Server combined: 4 vCPU, 8GB RAM, 100GB HD dedicated data partition

### Supported OSs
* OS Server 32-64 bit: Windows Server 2012 R2 or higher
* OS Client 32-64 bit: Windows 7 / Windows 8.1 / Windows 10

### Software requirements
* Microsoft .NET Framework 4.5.2 or higher
* Internet Information Services (IIS) 7.0 or higher
    * Enable ASP.NET features on IIS
    * Add all features related to IIS6 compatibility
    * Enable .NET Extensibility, ISAPI Extensions and ISAPI Filters modules

### Database server (SQL Server)
* SQL Server Express/Standard Edition 2012 SP2 or higher
    * Enable mixed authentication on the instance (SQL Server and Windows Authentication)
* SQL Server Management Studio 14 or higher

### Database server (Oracle)
* Oracle Database v12
    * Install Oracle Client 32-bit with OleDB
    * Do not install Oracle Data Provider for .NET

### Remote connections
* Connectivity via RDP with local admin user

### Firewall inbound/outbound settings
* TCP/UDP Port 3001
* TCP Port 23 (Telnet)
* TCP Port 22 (SSH/SFTP)
* TCP Port 80/443 (HTTP/HTTPS)
* TCP Port 1433 (default SQL Server) [in case of separated DB server]
* TCP Port 1521 (default Oracle) [in case of separated DB server]
 

