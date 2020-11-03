# Verifica che l'utente attuale di SQL sia sysadmin sull'istanza
# Fai una select sulla T70COMOPWEB, filtrando solo i record del servizio che si vuole restartare
# Crea una tabella temporanea TEMP_COMOPWEB_ServiceNNN (NNN è il numero del servizio)
# Salva i risultati della select nella tabella temporanea e cancellali dalla T70
# Estrai da archivio zip i file aggiornati di MicronService
# Stoppa il btService corrispondente
    ## In QUESTA parte non c'è garanzia che gli utenti non scrivano qualcos'altro nella T70 !
# Incolla i file sovrascrivendo quelli preesistenti (non sovrascrivere .exe.config né .lic)
# Se 7.5.xxx, lancia gli script per compatibilità con MRTCore
# Copia i record della tabella temporanea di nuovo dentro alla T70
# Riavvia il btService corrispondente
