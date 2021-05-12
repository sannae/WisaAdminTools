# PSScriptAnalyzer test
# TODO : Cambiare $here in modo che possa essere avviato da \Tests
# Look at this : https://github.com/pester/Pester/issues/1702
BeforeAll {
    $here = Split-Path -Parent $PSScriptRoot       # Build root folder
    $moduleName = Split-Path -Path $here -Leaf     # Module name
    $modulePath = Join-Path $here $moduleName       # Module root folder
    $modulefile = "$modulepath\$modulename.psm1"

    Set-StrictMode -Version Latest
}

Describe "<ModuleName> Module Tests" {
    Context 'Module Setup' {
      
        It "has the root module <ModuleName>.psm1" {
        "$ModulePath\$ModuleName.psm1" | Should -Exist
      }

      It "Should pass all ScriptAnalyzer rules" {
          $PSSAResults = Invoke-ScriptAnalyzer -Path $ModuleFile -IncludeDefaultRules -Verbose
          $PSSAerrors = $PSSAResults.Where({$_.Severity -eq 'Error'})
          Should $PSSAerrors -BeNullOrEmpty
      }

    } # Context 'Module Setup'
}

break

# Describe "<moduleName> Module Analysis with PSScriptAnalyzer" {
#     Context 'Standard Rules' {
#             foreach ($rule in $(Get-ScriptAnalyzerRule)) {
#                 It "Should pass rule $rule" {
#                 # Perform analysis on default rules
#                 Should $(Invoke-ScriptAnalyzer -Path $modulefile -IncludeRule $rule) -BeNullOrEmpty
#                 }
#             }
#     }
# }


# Dynamically defining the functions to analyze
$functions = Get-ChildItem "$modulePath\Public", "$modulePath\Private" -Include "*.ps1" -Exclude "*.Tests.ps1" -Recurse

# Running the analysis for each function
foreach ($functionPath in $functions) {
    $functionName = $functionPath.BaseName

    Describe "'$functionName' Function Analysis with PSScriptAnalyzer" {
        Context 'Standard Rules' {
            # Perform analysis against each rule
            forEach ($rule in $(Get-ScriptAnalyzerRule)) {
                Invoke-ScriptAnalyzer -Path $functionPath -IncludeRule $rule -Outvariable issues
                $errors = $issues.Where( { $_.Severity -eq 'Error' })
                $errors | Should -BeNullOrEmpty
            }
        }
    }
}