# https://octopus.com/blog/testing-powershell-code-with-pester
Describe "Application Suite is installed" {

    Context "Program exists" {
        It 'Should have Application Suite installed' {
            $AppSuiteName = $Applications.AppSuiteName
            $TestProgram = Get-InstalledProgram -Name $AppSuiteName
            $TestProgram.DisplayName | Should Not BeNullorEmpty
        }
    }

}
