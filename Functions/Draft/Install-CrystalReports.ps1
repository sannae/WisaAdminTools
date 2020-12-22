function Install-CrystalReports {
    [CmdletBinding()]
    param (
        # MSI path
        [Parameter(Mandatory = $true, Position = 0, 
            HelpMessage = "Digitare il percorso completo dei file MSI: ")]
        [ValidateScript ( { 
                ( Test-Path $_ ) -and ( Test-Path "$_\Crruntime_32bit*.msi" ) -and ( Test-Path "$_\Crruntime_64bit*.msi"  )
            } )]
        [string] $MsiPath
    )
    
    (Get-Item "$MsiPath\CRRuntime_*.msi").Name | ForEach-Object {

        $MsiArgs = @(
            "/qn"
            "/i"
            "$_"
            "/norestart"
        )

        $InstallProcess = Start-Process -PassThru -Wait "MsiExec.exe" -ArgumentList $MsiArgs
        Write-Host $InstallProcess.ExitCode

    }

}