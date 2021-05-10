# WisaAdminTools

## Get the module

### Install the module
The module _is not_ published on the [Powershell Gallery](https://www.powershellgallery.com/). To have it available in every PowerShell session, copy the whole folder `WisaAdminTools/WisaAdminTools` in your default module paths.

The list of default module paths is displayed by the following command: 
```powershell
$ModulePaths = $env:PSModulePath -split ';' | Where-Object { Test-Path $_ }
``` 
Copy the whole folder and its content using:
```powershell
foreach ($path in $ModulePaths) { Copy-Item -Path "\Path\to\module" -Destination $path -Recurse }
```
Another way is by adding the path to folder `WisaAdminTools` in the profile file saved in the environment variable `$profile`.
In case the file doesn't exist, you may run:
```powershell
New-Item $profile
Add-content -Value 'Import-Module -Value \PATH\TO\WisaAdminTools -Path $profile'
```
In order to make each new PowerShell session import the module from the specified path.

Maybe an [internal PSRepository](https://powershellexplained.com/2017-05-30-Powershell-your-first-PSScript-repository/), optionally integrated with a  [CI/CD pipeline](http://ramblingcookiemonster.github.io/PSDeploy-Inception/), will be implemented.

### Import the module in your PowerShell session
If already copied in the modules default path:
```powershell
Import-Module WisaAdminTools
```
Otherwise,
```powershell
Import-Module \path\to\module\WisaAdminTools\WisaAdminTools.psm1
```
The command `Import-module` will export in your session (via _dot-source_) all the public and private functions in the module.


## Use the module
The module's structure follows the guidelines written by [Rambling Cookie Monster](http://ramblingcookiemonster.github.io/Building-A-PowerShell-Module/).

To get a list of the _cmdlet_ included in the module:
```powershell
Get-command -Module WisaAdminTools
```
To have information and help about a specific function (all functions have integrated help): 
```powershell
Get-Help FUNCTIONNAME
```

### Requirements
The main requirement is the file `WisaAdminTools.json` to be added in the root folder of the module. The option `-Path` must be consistent in the module file (`.psm1`):
```powershell
$global:Applications = Get-Content -Raw -Path "$PSScriptRoot\$ModuleName.json" | ConvertFrom-Json
```
The content of the file is then available in the shell to all the functions as a global variable `$Applications`. 

Since [Windows Powershell 5.1](https://github.com/PowerShell/PowerShell/issues/7436) does not support `jsonc` (where ".jsonc" is [JSON with Comments](https://code.visualstudio.com/docs/languages/json#_json-with-comments), the file must have a `json` extension. Switching to `yaml` is being explored.

Nevertheless, a template of the content is available in the file `ApplicationDetails.template.jsonc`, where the comments can help fill the original json file.

