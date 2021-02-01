# https://octopus.com/blog/testing-powershell-code-with-pester
Describe "Crystal Reports are installed" {

    Context "Crystal Reports 32bit" {
        It 'Should have Crystal Reports 32bit installed' {
        $TestProgram = Get-InstalledProgram -Name "Crystal" | Where-Object {$_.DisplayName -like "*Crystal*32*" }
        $TestProgram | Should Not BeNullorEmpty
        }
    }

    Context "Crystal Reports 64bit" {
        It 'Should have Crystal Reports 64bit installed' {
        $TestProgram = Get-InstalledProgram -Name "Crystal" | Where-Object {$_.DisplayName -like "*Crystal*64*" }
        $TestProgram | Should Not BeNullorEmpty
        }
    }

}
