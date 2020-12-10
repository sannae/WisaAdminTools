<#
.SYNOPSIS
    Apre una connessione FTP basandosi su uno script di WinSCP.
.DESCRIPTION
    Lo script è stato scritto separatamente rispetto agli script di download FTP per far sì che si possa facilmente isolare.
    Restituisce semplicemente il comando Open con le rispettive credenziali Protocollo://user@server con relativo certificato.
    Uno script equivalente può essere creato da WinSCP > Sessione > Genera URL/Script > Script Powershell.
    Il risultato viene richiamato da tutte le altre funzioni che richiedono di connettersi ad un server FTP.
.EXAMPLE
    Open-FtpConnection
.EXAMPLE
    $FTPOpenConnectionString = Open-FtpConnection
.NOTES
    1.0 (tested)
#>

Function Open-FtpConnection {

    # Eventualmente inserire qui dentro le credenziali
    $OpenConnectionString = "open ftpes://sanna:edo89%2B0304@79.11.21.211/ -certificate=`"`"3f:3f:9f:7a:49:0e:4d:80:12:69:af:70:cb:5c:72:a4:e7:3a:eb:f1`"`""
    $OpenConnectionString

}