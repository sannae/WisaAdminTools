# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## 2021-01-19
### Added
- Added `Get-InstallFileInfo` and tested on Windows Powershell 5.1 and Powershell 7
### Changed
- Added property `WinServiceRestartPriority` in `ApplicationDetails.json`... basically, the priority in restarting the Windows Services
### Removed
- Removed all the support functions (hotline, FTP, etc.) to a separated PS module - synced the other project on VS Code!
---

## 2021-01-18
### Added
- Added `Set-WebApplicationPool` and tested on Windows Powershell 5.1!
---

## 2021-01-14
### Added
- Added `Remove-InstalledProgram` to uninstall programs based on description
- Prepared a testing environment on Win10 VM with Powershell 5.1, next one Powershell 7!
### Changed
- Tested all `Functions\Public` features (except `Update-WebApp`) on Windows Powershell 5.1
---

## 2021-01-14
### Changed
- Improved `Get-AppSuiteRootFolder` with two-level searching functions: partition-level and recursive
- Refactored and renamed `Install-AppSuite`
---

## 2021-01-13
Productive day!
### Added
- Added Changelog! :sparkles: (Finally)
- Section `WinApplications` in JSON source file, with `ReferenceConfigApp` attribute for connection string
- Added `ApplicationDetails.json` in `.gitignore` 
- Added JSON specifications in `README.md`
### Changed
- Refactoring on `Get-WebAppCurrentVersion` to read from JSON source file (still to be tested!)
- Refactoring on `Get-AppSuiteRootFolder` to read from JSON source file (still to be tested!)
- Refactoring on `Get-WebApplicationPool` to read from JSON source file (tested) 
- Refactoring: renamed `WebApplications` properties `WebApplicationName`,`WebApplicationFullName`
