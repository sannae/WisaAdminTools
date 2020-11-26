# MRTAdminTools
PowerShell module to assist administrators of the MRT Application Suite

## Get the module

### Install the module
The module is *not* available on Powershell Gallery.
```powershell
Install-Module MRTAdminTools
```

### Import the module in the current Powershell session
If already installed on the system:
```powershell
Import-Module MRTAdminTools
```
## Use the module
You can list the included commands using:
```powershell
Get-command -Module MrtAdminTools
```
Available & tested functions:
* `Get-MPWConnectionStrings`: returns the connection string to the SQL Server MRT database
* `Get-MPWCurrentVersion`: returns the current version of Micronpass Web application
* `Get-MPWRootFolder`: finds the path of the MPW folder in the filesystem
* `Install-IISFeatures`: installs all the required IIS roles and features
* `Invoke-MPWDatabaseQuery`: runs a selected query provided as input on the MRT database