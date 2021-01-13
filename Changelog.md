# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]



## [0.0.1] - 2021-01-13
### Added
- Added Changelog! :sparkles: (Finally)
- Section `WinApplications` in JSON source file, with `ReferenceConfigApp` attribute for connection string
- Added `ApplicationDetails.json` in `.gitignore` 
- Added JSON specifications in `README.md`
### Changed
- Refactoring on `Get-WebAppCurrentVersion` to read from JSON source file (still to be tested!) :x:
- Refactoring on `Get-AppSuiteRootFolder` to read from JSON source file (still to be tested!) :x:
- Refactoring on `Get-WebApplicationPool` to read from JSON source file (tested) :heavy_check_mark:
- Refactoring: renamed `WebApplications` properties `WebApplicationName`,`WebApplicationFullName`
### Removed