function Export-WinattIDStamping {
    [CmdletBinding()]
    param (
        [string]$DataOraInizio,
        [string]$DataOraFine
    )
    
    $WinattIdQuery = ""

    Invoke-MpwDatabaseQuery -Query $WinattIdQuery 


}