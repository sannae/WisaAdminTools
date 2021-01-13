function Export-WinattIDStamping {
    [CmdletBinding()]
    param (
        [string]$DataOraInizio,
        [string]$DataOraFine
    )
    
    $WinattIdQuery = ""

    Invoke-DatabaseQuery -Query $WinattIdQuery 


}