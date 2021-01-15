# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## 2021-01-14
### Added
- Added `Remove-InstalledProgram` to uninstall programs based on description
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
