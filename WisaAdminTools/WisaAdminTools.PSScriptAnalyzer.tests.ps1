<#
.SYNOPSIS
    Pester tests with PSScriptAnalyzer
.DESCRIPTION

.NOTES
    # Look at this : https://github.com/pester/Pester/issues/1702
#>


Describe "<ModuleName> Module Tests" {

    # Module setup
    Context 'Module Setup' {

        BeforeAll {

            $here = Split-Path -Parent $PSScriptRoot       # Build root folder
            $moduleName = Split-Path -Path $here -Leaf     # Module name
            $modulePath = Join-Path $here $moduleName       # Module root folder
            $modulefile = "$modulepath\$modulename.psm1"
            Set-StrictMode -Version Latest
    
        }

        It "has the root module <ModuleName>.psm1" {
            "$ModulePath\$ModuleName.psm1" | Should -Exist
        }

        It "Should pass all ScriptAnalyzer rules" {
            $PSSAResults = Invoke-ScriptAnalyzer -Path $ModuleFile -IncludeDefaultRules -Verbose
            $PSSAerrors = $PSSAResults.Where( { $_.Severity -eq 'Error' })
            $PSSAerrors | Should -BeNullOrEmpty
        }

    } 
    
    $here = Split-Path -Parent $PSScriptRoot       # Build root folder
    $moduleName = Split-Path -Path $here -Leaf     # Module name
    $modulePath = Join-Path $here $moduleName       # Module root folder
    Set-StrictMode -Version Latest

    # Dynamically define functions
    $functions = Get-ChildItem "$modulePath\Functions\Public", "$modulePath\Functions\Private" -Include "*.ps1" -Exclude "*.Tests.ps1" -Recurse

    # Testing functions
    Context "<function.BaseName> - Function" -ForEach $functions {

        BeforeAll { 

            # $_ is the current item coming from the -ForEach
            $function = $_ 
        }
        
        It "should exist" {
            $function.FullName | Should -Exist
        }

        It "should have help block" {
            $function.FullName | Should -FileContentMatch "<#"
            $function.FullName | Should -FileContentMatch "#>"
        }

        It "should have a SYNOPSIS section in the help block" {
            $function.FullName | Should -FileContentMatch '.SYNOPSIS'
        }

        It "is valid PowerShell code" {
            $psFile = Get-Content -Path $function.FullName -ErrorAction Stop
            $errors = $null
            $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
            $errors.Count | Should -Be 0
        }

        It "Should pass all ScriptAnalyzer rules" {
            $PSSAResults = Invoke-ScriptAnalyzer -Path $function.FullName -IncludeDefaultRules -Verbose
            $PSSAerrors = $PSSAResults.Where( { $_.Severity -eq 'Error' })
            $PSSAerrors | Should -BeNullOrEmpty
        }

    }
}
