# MrtAdminTools
PowerShell module to assist administrators of the MRT Application Suite

## Get the module

### Install the module
The module is *not* available on Powershell Gallery.
```powershell
Install-Module MrtAdminTools
```

### Import the module in the current Powershell session
If already installed on the system:
```powershell
Import-Module MRTAdminTools
```
The `Import-module` command will dot-source all the _public_ functions.

## Use the module
You can list the included commands using:
```powershell
Get-command -Module MrtAdminTools
```
To get help from any function:
```powershell
Get-Help FUNCTIONNAME
```

### Available & tested functions:
The tested functions are available in the `Functions\Public` subfolder:
* `Get-MpwApplicationPool`: returns the application pool of a specific web application
* `Get-MPWCurrentVersion`: returns the current version of Micronpass Web application
* `Get-MPWRootFolder`: finds the path of the `MPW` folder in the filesystem
* `Get-MrtConnectionStrings`: returns the connection string to the SQL Server MRT database
* `Install-IISFeatures`: installs all the required IIS roles and features
* `Invoke-MPWDatabaseQuery`: runs a selected query provided as input on the MRT database
* `Update-MrtWebApp`: updates a web application to the latest patch, provided the zip file