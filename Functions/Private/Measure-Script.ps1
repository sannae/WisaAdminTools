function Measure-Script {

    [CmdletBinding()]
    param(
      [Parameter(Mandatory = $true, Position=0)]
      [ValidateSet("Start","Stop")]
        [string] $Status
    )

    if ( $Status -eq "Start") {
        $Clock = [Diagnostics.Stopwatch]::StartNew()
    } else {
        $Clock.Stop()
        $Clock
    }

}