# :hammer: WisaAdminTools :wrench:
![GitHub Actions](https://github.com/sannae/WisaAdminTools/actions/workflows/CI-test.yml/badge.svg)

A PowerShell module with some useful CLI tools meant for administrators and operators of an N-tier software application suite based on the WISA web stack (Windows - IIS - SQL Server - ASP.NET).

The main components are:
* The module root folder is `\WisaAdminTools`
* Dependencies are handled by `PSDepend`
* Build tasks are handled by `InvokeBuild`
* Unit tests are handled by `Pester`

The build-test-publish pipeline is handled by [GitHub Actions](https://docs.github.com/en/actions/guides/building-and-testing-powershell) and is fully described in the [reference YAML file](https://github.com/sannae/WisaAdminTools/blob/master/.github/workflows/CI-test.yml)

### Sample pipeline:

The pipeline is triggered at each `push` event on the repo's main branch.

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