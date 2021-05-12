# :hammer: WisaAdminTools :wrench:
![GitHub Actions](https://github.com/sannae/WisaAdminTools/actions/workflows/CI-test.yml/badge.svg)

A PowerShell module with some useful CLI tools meant for administrators and operators of an N-tier software application suite based on the WISA web stack (Windows - IIS - SQL Server - ASP.NET).

The main components are:
* The module root folder is `\WisaAdminTools`
* Dependencies are handled by `PSDepend`
* Build tasks are handled by `InvokeBuild`
* Unit tests are handled by `Pester`

The build-test-publish pipeline is handled by [GitHub Actions](https://docs.github.com/en/actions/guides/building-and-testing-powershell) and is fully described in the [reference YAML file](https://github.com/sannae/WisaAdminTools/blob/master/.github/workflows/CI-test.yml)
