function Initialize-MrtSuite {

    # Trova cartella MPW
    $RootFolder = Get-MPWRootFolder
    
    # Crea cartella \_LICENZA
    New-Item -Path "$RootFolder\_LICENZA" -ItemType Directory

    # Apri GeneraABL e seleziona da solo SW o SWLight
    Start-process "$RootFolder/GeneraABL/GeneraAbl.exe"
    if ($(get-wmiobject win32_computersystem).model -match "virtual,*") {
        $keys = "{TAB}{TAB}{ENTER}"
    }
    else {
        $keys = "{TAB}{ENTER}"
    }
    $wshshell = New-Object -ComObject WScript.Shell
    Start-Sleep -Seconds 2
    $wshshell.sendkeys($keys)

    # Apri MicronStart e attendi che venga chiuso
    Start-sleep -Seconds 5
    Start-process $Root/MicronStart/mStart.exe -Wait

    # Verifica connessione al database
    if ( !( Test-SqlConnection $( Get-MrtConnectionStrings  ) ) ) {
            Write-Error "Database SQL non raggiungibile! Verificare di aver aggiornato le stringhe di connessione."
            break
        }

    # # # ------------------------- Dividere Qui in un'altra funzione ?

        # Esegui query di allineamento MrtCore
        # Ancora non funziona...
    $SqlQueriesFolder = "$RootFolder\DBUpgrade750Scripts\SQLServer"
    ForEach ( $query in $(Get-ChildItem "$SqlQueriesFolder\20*") ) {
        Invoke-MpwDatabaseQuery -Query "$( Get-Content $query )"
    }

        # Setta flag GDPR
        $SQLGDPR = 
        "-- Set GDPR flags to default
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEDIP'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEEST'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEVIS'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEUSR'
    UPDATE T05COMFLAGS SET T05VALORE='ANONYMOUS' WHERE T05TIPO='GDPRANONYMTEXT' "
        Invoke-MpwDatabaseQuery -Query $SQLGDPR

        # Setta flag CrossBrowser
        $SQLXBrowser =
        "UPDATE T103COMPARAMS SET T103VALUE='1' WHERE T103PARAM = 'XBrowserHW'"
        Invoke-MpwDatabaseQuery -Query $SQLXBrowser

        # Crea azienda interna UTIL e DIPRIF, associandolo all'utente admin
        $SQLUtilities = 
        "-- Create utilities internal company
    INSERT INTO T71COMAZIENDEINTERNE VALUES (N'UTIL',N'_UTILITIES',N'INSTALLATORE',N'20000101000000',N'',N'')
    -- Create reference employee
    INSERT INTO T26COMDIPENDENTI VALUES (N'00000001',N'_DIP.RIF', N'_DIP.RIF', N'', N'', N'', N'', N'0', N'', N'INSTALLATORE', N'20000101000000', N'', N'', N'', N'', N'20000101', N'', N'0', N'', N'UTIL', N'M', N'', N'1', N'20000101000000', N'99991231235959', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'')
    -- Assign ref.empl. to admin user
    UPDATE T21COMUTENTI SET T21DEFDIPRIFEST='00000001',T21DEFAZINTEST='UTIL',T21DEFDIPRIFVIS='00000001',T21DEFAZINTVIS='UTIL' WHERE T21UTENTE='admin'
    "
        Invoke-MpwDatabaseQuery -Query $SQLUtilities

        # Imposta le autorizzazioni utente e le autorizzazioni report per l'utente ADMIN
        # ...

    }