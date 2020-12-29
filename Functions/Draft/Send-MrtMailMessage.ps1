# Send-MrtMailMessage

# Invia una notifica mail a Microntel se succede qualcosa

# Da finire di testare

function Send-MrtMailMessage {

    [CmdletBinding()]
    param()
    
    # Dati del Database: query che NON dovrebbe restituire risultati
    $Query = "SELECT * FROM T05COMFLAGS WHERE T05VALORE='3'"
    $Results = Invoke-MpwDatabaseQuery -Query $Query | Format-List | Out-String

    # Se ESISTONO risultati
    if ( $Results -ne '' ) {

        # Crea credenziali
        $SmtpUsername = "edoardo.sanna@microntel.com"
        $SmtpPassword = ConvertTo-SecureString -String "EdS44MEs" -AsPlainText -Force
        $SmtpCredentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SmtpUsername, $SmtpPassword

        # Invia messaggio
        Send-MailMessage `
            -From "edoardo.sanna@microntel.com" `
            -To "edoardo.sanna@microntel.com" `
            -Subject "Sono stati trovati i seguenti risultati: " `
            -Body $Results `
            -SmtpServer "giove.mailmox.it" `
            -Credential $SmtpCredentials

    }

}