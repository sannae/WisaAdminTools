# :hammer: WisaAdminTools :wrench:
A PowerShell module with some useful CLI tools meant for administrators and operators of an N-tier software application suite based on the WISA web stack, i.e. made of the following layers:

1) Web layer : [ASP.NET 4](https://docs.microsoft.com/en-us/biztalk/core/how-to-enable-asp-net-4-0-for-published-web-services) hosted on IIS
2) Application layer : .NET Framework 4
3) Database layer : SQL Server
4) OS layer : Windows Server or Windows Client

Main components:
* The module root folder is `\WisaAdminTools`
* Dependencies are handled by `PSDepend`
* Build tasks are handled by `InvokeBuild`
* Unit tests are handled by `Pester`
* The whole test-build-release pipeline is summarized in `azure-pipelines.yaml`

### Sample pipeline:

Let's say you want to add a new public functions to your module.

1) Stage test

   1) Task: install InvokeBuild using
        ```powershell
        # Installing and importing InvokeBuild
        if (-not (Get-Module -Name InvokeBuild -ListAvailable)) {
            Install-Module InvokeBuild -Scope CurrentUser
        }
        Import-Module InvokeBuild
        ```
   2) Task: analyze the code. First of all, the `Enter-Build` part of the script will install and invoke `PSDepend`, thus taking care of all the dependencies (namely, `Pester` and `PSScriptAnalyzer`):
        ```powershell
        # Installing PSDepend for dependency management
        if (-not (Get-Module -Name PSDepend -ListAvailable)) {
            Install-Module PSDepend -Scope CurrentUser
        }
        Import-Module PSDepend
        # Installing dependencies
        Invoke-PSDepend -Force
        ```
    Then, the `Analyze` task will find and invoke all the tests whose name include `*PSScriptAnalyzer.tests.ps1`. 

(To be continued)