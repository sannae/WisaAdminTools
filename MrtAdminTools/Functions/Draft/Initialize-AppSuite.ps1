# Crea database : MPW\MicronStart\Data\SQLSERVER_NEWDB.sql
# Crea tabelle : MPW\MicronStart\Data\SQLSERVER_CREATE_DB.sql
# Crea parametri default : MPW\MicronStart\Data\SCRIPT_FILL_DATA.sql

function Initialize-AppSuite {

    # Trova cartella MPW
    $RootFolder = Get-AppSuiteRootFolder
    
    # Crea cartella \_LICENZA
    if (!(Test-Path "$RootFolder\_LICENZA")) {
        New-Item -Path "$RootFolder\_LICENZA" -ItemType Directory 
    }

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
    Start-sleep -Seconds 2
    Start-process $RootFolder/MicronStart/mStart.exe -Wait

    break

    # Verifica connessione al database
    if ( !( Test-SqlConnection $( Get-AppConnectionStrings ) ) ) {
            Write-Error "Database SQL non raggiungibile! Verificare di aver aggiornato le stringhe di connessione."
            break
        }

    # Esegui query di allineamento MrtCore
    # Ancora non funziona...
    $SqlQueriesFolder = "$RootFolder\DBUpgrade750Scripts\SQLServer"
    ForEach ( $query in $(Get-ChildItem "$SqlQueriesFolder\20*") ) {
        Invoke-DatabaseQuery -Query "$( Get-Content $query )"
    }

        # Setta flag GDPR
        $SQLGDPR = 
        "-- Set GDPR flags to default
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEDIP'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEEST'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEVIS'
    UPDATE T05COMFLAGS SET T05VALORE='1' WHERE T05TIPO='GDPRMODEUSR'
    UPDATE T05COMFLAGS SET T05VALORE='ANONYMOUS' WHERE T05TIPO='GDPRANONYMTEXT' "
        Invoke-DatabaseQuery -Query $SQLGDPR

        # Setta flag CrossBrowser
        $SQLXBrowser =
        "UPDATE T103COMPARAMS SET T103VALUE='1' WHERE T103PARAM = 'XBrowserHW'"
        Invoke-DatabaseQuery -Query $SQLXBrowser

        # Crea azienda interna UTIL e DIPRIF, associandolo all'utente admin
        $SQLUtilities = 
        "-- Create utilities internal company
    INSERT INTO T71COMAZIENDEINTERNE VALUES (N'UTIL',N'_UTILITIES',N'INSTALLATORE',N'20000101000000',N'',N'')
    -- Create reference employee
    INSERT INTO T26COMDIPENDENTI VALUES (N'00000001',N'_DIP.RIF', N'_DIP.RIF', N'', N'', N'', N'', N'0', N'', N'INSTALLATORE', N'20000101000000', N'', N'', N'', N'', N'20000101', N'', N'0', N'', N'UTIL', N'M', N'', N'1', N'20000101000000', N'99991231235959', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'')
    -- Assign ref.empl. to admin user
    UPDATE T21COMUTENTI SET T21DEFDIPRIFEST='00000001',T21DEFAZINTEST='UTIL',T21DEFDIPRIFVIS='00000001',T21DEFAZINTVIS='UTIL' WHERE T21UTENTE='admin'
    "
        Invoke-DatabaseQuery -Query $SQLUtilities

        # Imposta le autorizzazioni utente e le autorizzazioni report per l'utente ADMIN
        # ...

    }