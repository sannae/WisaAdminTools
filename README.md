# :hammer: MrtAdminTools :wrench:
PowerShell module with helpful tools to assist administrators of the MRT Application Suite!

## Get the module

### Install the module
The module is _not_ available in [Powershell Gallery](https://www.powershellgallery.com/). 
To have it available in every PS session, copy the whole `MrtAdminTools` folder in your default module paths.
The list of existing default module paths is available with:
```powershell
$env:PSModulePath -split ';' | Where-Object { Test-Path $_ }
``` 

### Import the module in the current Powershell session
If already copied in the default module path:
```powershell
Import-Module MrtAdminTools
```
Otherwise,
```powershell
Import-Module \path\to\module\MrtAdminTools\MrtAdminTools.psm1
```
The `Import-module` command will dot-source all the _public_ and _private_ functions.

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
* `Get-MpwCurrentVersion`: returns the current version of Micronpass Web application
* `Get-MpwRootFolder`: finds the path of the `MPW` folder in the filesystem
* `Get-MrtConnectionStrings`: returns the connection string to the SQL Server MRT database
* `Get-MrtEventLogs` :star: : it collects and displays all the logs of a specific application folder
* `Install-IISFeatures` :star: : installs all the required IIS roles and features
* `Invoke-MPWDatabaseQuery`: runs a selected query provided as input on the MRT database
* `Update-MrtWebApp` :star: : updates a web application to the latest patch, provided the zip file

A bunch of private functions (`Functions\Public`) are available as well:
* `Get-FtpCommesseVR`: downloads via FTPES all the VR (released versions) of a specific customer's orders
* `Get-FtpLastPackages`: download via FTPES the latest release ZIP package of a specified application
* `Open-FtpConnection`: it opens a FTPES connection to the Dev server