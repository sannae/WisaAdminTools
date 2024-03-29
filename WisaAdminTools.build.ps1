<#
.SYNOPSIS
    Build script (https://github.com/nightroman/Invoke-Build)
.DESCRIPTION
    This script contains the tasks for building the 'SampleModule' PowerShell module.
.NOTES
    Default task : Clean and build
    Enter-Build : installs and invokes PSDepend, defines script variables
    Analyze : Analyze the project with PSScriptAnalyzer
    Test : Test the project with Pester tests
    GenerateNewModuleVersion : Generate a new module version if creating a release build
    GenerateListOfFunctionsToExport : Generate list of functions to be exported by module
.NOTES
    Environment variables used by Invoke-Build are:
        $BuildRoot: build root folder
#>

#requires -modules InvokeBuild

Param (
    [Parameter(ValueFromPipelineByPropertyName = $true)]
    [ValidateSet('Debug', 'Release')]
    [String]
    $Configuration = 'Debug',
    [Parameter(ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [String]
    $SourceLocation
)

# Synopsis: Default task
task . Clean, Build

# Install build dependencies
Enter-Build {

    Write-Verbose "Entering the enter-build task..."

    # Installing PSDepend for dependency management
    Write-Verbose "Installing and importing PSDepend..."
    if (-not (Get-Module -Name PSDepend -ListAvailable)) {
        Install-Module PSDepend -Scope CurrentUser -Force
    }
    Import-Module PSDepend

    # Installing dependencies
    Write-Verbose "Invoking PSDepend to install the dependencies listed in .depend.ps1..."
    Invoke-PSDepend -Force

    # Setting build script variables
    $script:moduleName = 'WisaAdminTools' #$(Split-Path $PSCommandPath -Leaf).Split('.')[0]
    $script:moduleSourcePath = Join-Path -Path $BuildRoot -ChildPath $moduleName
    Write-Verbose "Module source path is $script:moduleSourcePath"
    $script:moduleManifestPath = Join-Path -Path $moduleSourcePath -ChildPath "$moduleName.psd1"
    $script:nuspecPath = Join-Path -Path $moduleSourcePath -ChildPath "$moduleName.nuspec"
    $script:buildOutputPath = Join-Path -Path $BuildRoot -ChildPath 'build'

    # Setting base module version and using it if building locally
    $script:newModuleVersion = New-Object -TypeName 'System.Version' -ArgumentList (0, 0, 1)

    # Setting the list of functions ot be exported by module
    $script:functionsToExport = (Test-ModuleManifest $moduleManifestPath).ExportedFunctions
}

# Synopsis: Analyze the project with PSScriptAnalyzer
task Analyze {

    Write-Verbose "Entering the Analyze invokebuild task..."

    # Get-ChildItem parameters
    Write-Verbose "Looking for PSScriptAnalyzer Pester tests..."
    $Params = @{
        Path    = $moduleSourcePath
        Recurse = $true
        Include = "*.PSScriptAnalyzer.tests.*"
    }
    $TestFiles = Get-ChildItem @Params

    # Pester parameters
    $Params = @{
        Path     = $TestFiles
        PassThru = $true
    }

    # Generate test results
    $Timestamp = Get-date -UFormat "%Y%m%d-%H%M%S"
    $PSVersion = $PSVersionTable.PSVersion.Major
    $AnalysisResultFile = "AnalysisResults_PS$PSVersion`_$TimeStamp.xml"
        if (-not (Test-Path -Path $buildOutputPath -ErrorAction SilentlyContinue)) {
            New-Item -Path $buildOutputPath -ItemType Directory
        }

    # Invoke all tests and save results in CliXML file
    Write-Verbose "Running Pester tests..."
    $AnalysisResults = Invoke-Pester @Params -Verbose
    # Publishing test results in Junit XML format (readable by Github Actions)
    $AnalysisResults | Export-JUnitReport -Path "$buildOutputPath\$AnalysisResultFile"
    # Block if errors >0
    if ($AnalysisResults.FailedCount -gt 0) {
        $AnalysisResults | Format-List
        throw "One or more PSScriptAnalyzer rules have been violated. Build cannot continue!"
    }
}

# Synopsis: Test the project with Pester tests
task Test {

    Write-Verbose "Entering the Test invokebuild task..."

    # Get-ChildItem parameters
    Write-Verbose "Looking for Pester tests..."
    $Params = @{
        Path    = "$buildRoot\Tests"
        Recurse = $true
        Include = "*.Tests.*"
    }

    $TestFiles = Get-ChildItem @Params
    Write-Host "Files are: $TestFiles"

    # Pester parameters
    $Params = @{
        Path     = $TestFiles
        PassThru = $true
    }

    # Generate test results
    $Timestamp = Get-date -UFormat "%Y%m%d-%H%M%S"
    $PSVersion = $PSVersionTable.PSVersion.Major
    $TestResultFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"
        if (-not (Test-Path -Path $buildOutputPath -ErrorAction SilentlyContinue)) {
            New-Item -Path $buildOutputPath -ItemType Directory
        }

    # Invoke all tests and save results in CliXML file
    Write-Verbose "Running Pester tests..."
    $TestResults = Invoke-Pester @Params -Verbose
    # Publishing test results
    $TestResults | Export-JUnitReport -Path "$buildOutputPath\$TestResultFile"
    # Block if errors >0
    if ($TestResults.FailedCount -gt 0) {
        $TestResults | Format-List
        throw "One or more Pester tests have been violated. Build cannot continue!"
    }
}


# Synopsis: Verify the code coverage by tests
task CodeCoverage {

    # Inferior limit of code coverage tolerance
    $acceptableCodeCoveragePercent = 1

    Write-Verbose "Retrieving all files from root folder..."
    $path = $buildRoot
    $files = Get-ChildItem $path -Recurse -Include '*.ps1', '*.psm1' -Exclude '*.Tests.ps1', '*.PSScriptAnalyzer.tests.ps1'

    $Params = @{
        Path         = $path
        CodeCoverage = $files
        PassThru     = $true
        Show         = 'Summary'
    }

    # Generate test results
    $Timestamp = Get-date -UFormat "%Y%m%d-%H%M%S"
    $PSVersion = $PSVersionTable.PSVersion.Major
    $CodeCoverageResultFile = "CodeCoverageResults_PS$PSVersion`_$TimeStamp.xml"
        if (-not (Test-Path -Path $buildOutputPath -ErrorAction SilentlyContinue)) {
            New-Item -Path $buildOutputPath -ItemType Directory
        }

    # Run tests
    $CodeCoverageResults = Invoke-Pester @Params -Verbose

    # Publishing test results
    $CodeCoverageResults | Export-JUnitReport -Path "$buildOutputPath\$CodeCoverageResultFile"
    # ...

    # Compute actual results
    $codeCoverage = $CodeCoverageResults.CodeCoverage   
    If ( $CodeCoverage ) {

        $commandsFound = $codeCoverage.CommandsAnalyzedCount

        # To prevent any "Attempted to divide by zero" exceptions
        If ( $commandsFound -ne 0 ) {
            $commandsExercised = $codeCoverage.CommandsExecutedCount
            [System.Double]$actualCodeCoveragePercent = [Math]::Round(($commandsExercised / $commandsFound) * 100, 2)
        }
        Else {
            [System.Double]$actualCodeCoveragePercent = 0
        }
    }

    # Fail the task if the code coverage results are not acceptable
    if ($actualCodeCoveragePercent -lt $acceptableCodeCoveragePercent) {
        throw "The overall code coverage by Pester tests is $actualCodeCoveragePercent% which is less than quality gate of $acceptableCodeCoveragePercent%. Pester ModuleVersion is: $((Get-Module -Name Pester -ListAvailable).ModuleVersion)."
    }
}


# Synopsis: Generate a new module version if creating a release build
task GenerateNewModuleVersion -If ($Configuration -eq 'Release') {
    # Using the current NuGet package version from the feed as a version base when building via Azure DevOps pipeline

    # Define package repository name
    $repositoryName = $moduleName + '-repository'

    # Register a target PSRepository
    try {
        Register-PSRepository -Name $repositoryName -SourceLocation $SourceLocation -InstallationPolicy Trusted
    }
    catch {
        throw "Cannot register '$repositoryName' repository with source location '$SourceLocation'!"
    }

    # Define variable for existing package
    $existingPackage = $null

    try {
        # Look for the module package in the repository
        $existingPackage = Find-Module -Name $moduleName -Repository $repositoryName
    }
    # In no existing module package was found, the base module version defined in the script will be used
    catch {
        Write-Warning "No existing package for '$moduleName' module was found in '$repositoryName' repository!"
    }

    # If existing module package was found, try to install the module
    if ($existingPackage) {
        # Get the largest module version
        # $currentModuleVersion = (Get-Module -Name $moduleName -ListAvailable | Measure-Object -Property 'Version' -Maximum).Maximum
        $currentModuleVersion = New-Object -TypeName 'System.Version' -ArgumentList ($existingPackage.Version)

        # Set module version base numbers
        [int]$Major = $currentModuleVersion.Major
        [int]$Minor = $currentModuleVersion.Minor
        [int]$Build = $currentModuleVersion.Build

        try {
            # Install the existing module from the repository
            Install-Module -Name $moduleName -Repository $repositoryName -RequiredVersion $existingPackage.Version
        }
        catch {
            throw "Cannot import module '$moduleName'!"
        }

        # Get the count of exported module functions
        $existingFunctionsCount = (Get-Command -Module $moduleName | Where-Object -Property Version -EQ $existingPackage.Version | Measure-Object).Count
        # Check if new public functions were added in the current build
        [int]$sourceFunctionsCount = (Get-ChildItem -Path "$moduleSourcePath\Public\*.ps1" -Exclude "*.Tests.*" | Measure-Object).Count
        [int]$newFunctionsCount = [System.Math]::Abs($sourceFunctionsCount - $existingFunctionsCount)

        # Increase the minor number if any new public functions have been added
        if ($newFunctionsCount -gt 0) {
            [int]$Minor = $Minor + 1
            [int]$Build = 0
        }
        # If not, just increase the build number
        else {
            [int]$Build = $Build + 1
        }

        # Update the module version object
        $Script:newModuleVersion = New-Object -TypeName 'System.Version' -ArgumentList ($Major, $Minor, $Build)
    }
}

# Synopsis: Generate list of functions to be exported by module
task GenerateListOfFunctionsToExport {
    # Set exported functions by finding functions exported by *.psm1 file via Export-ModuleMember
    $params = @{
        Force    = $true
        Passthru = $true
        Name     = (Resolve-Path (Get-ChildItem -Path $moduleSourcePath -Filter '*.psm1')).Path
    }
    $PowerShell = [Powershell]::Create()
    [void]$PowerShell.AddScript(
        {
            Param ($Force, $Passthru, $Name)
            $module = Import-Module -Name $Name -PassThru:$Passthru -Force:$Force
            $module | Where-Object { $_.Path -notin $module.Scripts }
        }
    ).AddParameters($Params)
    $module = $PowerShell.Invoke()
    $Script:functionsToExport = $module.ExportedFunctions.Keys
}

# Synopsis: Update the module manifest with module version and functions to export
task UpdateModuleManifest GenerateNewModuleVersion, GenerateListOfFunctionsToExport, {
    # Update-ModuleManifest parameters
    $Params = @{
        Path              = $moduleManifestPath
        ModuleVersion     = $newModuleVersion
        FunctionsToExport = $functionsToExport
    }

    # Update the manifest file
    Update-ModuleManifest @Params
}

# Synopsis: Update the NuGet package specification with module version
task UpdatePackageSpecification GenerateNewModuleVersion, {
    # Load the specification into XML object
    $xml = New-Object -TypeName 'XML'
    $xml.Load($nuspecPath)

    # Update package version
    $metadata = Select-XML -Xml $xml -XPath '//package/metadata'
    $metadata.Node.Version = $newModuleVersion

    # Save XML object back to the specification file
    $xml.Save($nuspecPath)
}

# Synopsis: Build the project
task Build UpdateModuleManifest, UpdatePackageSpecification, {
    # Warning on local builds
    if ($Configuration -eq 'Debug') {
        Write-Warning "Creating a debug build. Use it for test purpose only!"
    }

    # Create versioned output folder
    $moduleOutputPath = Join-Path -Path $buildOutputPath -ChildPath $moduleName -AdditionalChildPath $newModuleVersion
    if (-not (Test-Path $moduleOutputPath)) {
        New-Item -Path $moduleOutputPath -ItemType Directory
    }

    # Copy-Item parameters
    $Params = @{
        Path        = "$moduleSourcePath\*"
        Destination = $moduleOutputPath
        Exclude     = "*.Tests.*", "*.PSSATests.*"
        Recurse     = $true
        Force       = $true
    }

    # Copy module files to the target build folder
    Copy-Item @Params
}

# Synopsis: Clean up the target build directory
task Clean {
    if (Test-Path $buildOutputPath) {
        Remove-Item -Path $buildOutputPath -Recurse -Force
    }
}
