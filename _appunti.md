# DA ORDINARE/FINIRE: 

*Al fine di gestire meglio le richieste di assistenza, ricordo di scrivere sempre per eventuali necessit� mettendo il collega Vincenzo Mancuso (vincenzo.mancuso@microntel.com) in copia, in quanto il tecnico di riferimento potrebbe essere non disponibile o fuori ufficio al momento della segnalazione.

*Indentazione automatica PSPAD:
	(*) Ricordarsi di chiudere i "too long, truncated..." o l'indentazione non sar� efficace
	- Navigation bar > HTML > TiDy > XML reformat

* Passaggio da Micronpass WIN a Micronpass WEB

* Badge alignment (da usare con MicronNoServiceOffline attivo)
Check Badge alignment		% Controllare lo stato delle credenziali su database e a bordo dell'Atlas e confrontarle
ATLAS credentials reset		% Azzera le credenziali a bordo dell'Atlas
Start/Stop			% Forza l'allineamento delle credenziali dal database all'Atlas (si pu� fare anche senza aver resettato)

* Compattazione e ripristino database su Access
--> Per risolvere il problema per cui gli applicativi non riescono a 'trovare' il database e dicono che il file potrebbe essere danneggiato

* Velocità:
	max. 9.6 kbps su Locbus
	100 Mbps Eth.

* Gestore Certificati di Windows

	Esegui > certmgr.msc

* Cancellare files pi� vecchi di NNNN giorni
	
	forfiles /p "C:\...\..." /s /m *.* /D -NNNN /C "cmd /c echo @FILE"	% come test: printa tutti i file nel percorso indicato che soddisfano la condizione
	forfiles /p "C:\...\..." /s /m *.* /D -NNNN /C "cmd /c del @PATH"	% per cancellare tutti i file del percorso indicato che soddisfano la condizione

	Syntax
		FORFILES [/p Path] [/m SrchMask] [/s] [/c Command] [/d [+ | -] {date | dd}]   

	Key
	   /p Path      The Path to search  (default=current folder)
	   /m SrchMask  Select files matching the specified search mask
                default = *.*
	   /s           Recurse into sub-folders
	   /C command   The command to execute for each file.
                Wrap the command string in double quotes.
                Default = "cmd /c echo @file"
                The Command variables listed below can also be used in the
                command string.
	   /D date      Select files with a last modified date greater than or 
                equal to (+), or less than or equal to (-),
                the specified date, using the region specific date format
                typically "MM/DD/yyyy" or "DD/MM/yyyy"
	   /D + dd      Select files with a last modified date greater than or
                equal to the current date plus "dd" days. (in the future)
	   /D - dd      Select files with a last modified date less than or
                equal to the current date minus "dd" days. (in the past)
		A valid "dd" number of days can be any number in
                the range of 0 to 32768.   (89 years)
                "+" is taken as default sign if not specified.

	   Command Variables:
	      @file    The name of the file.
	      @fname   The file name without extension.                
	      @ext     Only the extension of the file.                  
	      @path    Full path of the file.
	      @relpath Relative path of the file.          
	      @isdir   Returns "TRUE" if a file type is a directory,
	               and "FALSE" for files.
	      @fsize   Size of the file in bytes.
	      @fdate   Last modified date of the file.
	      @ftime   Last modified time of the file.


* Laboratorio
Caratteristiche dei terminali dalla produzione:
	
	\\172.16.1.21\file_server\SEDE\Produzione\MATRICOLE MXP-KX SIEMENS-MICRONTEL

* Documentazione progettazione:

	\\172.16.1.21\file_server\SEDE\Progettazione\COMMESSE\CO MIC\CO MIC HW

* Connessione Oracle (sintassi)

	sqlplus user/pass@local_SID

* Verifica per lentezza tra applicativo e servizio

	Verificare la parte ethernet tra il server e la centralina utilizzata per i test
	Verificare che l�indirizzo IP indicato nel micronconfig corrisponda a quello corrente del server
	Verificare che non ci siano impedimenti dal server verso la centralina sulla porta 3001 (test telnet)
	Verificare se in assegnazione \ deassegnazione badge titolare ci siano gli stessi tempi

* Cambiare utente che esegue un servizio da riga di comando (ovviamente come Amministratore)

	sc config <nome_servizio> obj="<nome_utente@nome_dominio>" password="<password_utente">
		Es. sc config micronworker23 obj="Admin.service@microncloud.local" password="M!cron00"

* KARM -> Errore Multipolling su ServiceLog
16-03-2018 15:09:01:936 *** Start Program v7.4.14.21415
16-03-2018 15:09:03:761 AccHelper.StartAllTermsComm: Multipolling forzato ad off
16-03-2018 15:09:03:761 AccHelper.StartAllTermsComm: E' necessario abilitare il multipolling per l'utilizzo dei nuovi terminali KARM, se sono presenti terminali GNET che non supportano multipolling � necessario segregarli in un nuovo servizio.
	(*) Quando c'� un M35 (che pu� funzionare anche senza multipolling) nello stesso servizio di un ARM (che ha multipolling obbligatorio)

* APPUNTI PRODUZIONE (MICRONPROD WEB e MICROSIN.EXE)
Micronsin.exe � l'applicativo di raccolta dati produzione.
Funziona in modalit� Windows form, quindi come il btNoService.
	Per abilitare i comandi:
		- Cliccare su Login
			username:	pppp... (fino a completamento)
			password:	pppp... (fino a completamento)
	Per mettere in modalit� setup l'impianto:
		- Abilitare i comandi
		- Cliccare su "Setup" e confermare
		- Ricliccare su "Setup" per uscire dalla modalit� setup
	Se tutti i terminali sono offline (cio� hanno il "punto esclamativo" sull'icona)
		a) � un problema di rete: cercare gli indirizzi IP sul GNConfig e provare un ping
		b) c'� un'istanza parallela di Microsin.exe che sta girando: per questo applicativo non c'� un controllo in avvio


* Comunicazione seriale con coupler 125kHz a bordo della Evolis Primacy
	- Aprire PuTTY o TeraTerm
	- Parametri di connessione > COMxxx, 9600,8,1,N,N
	- Parametri terminale > local echo = enabled 		% Per vedere sia i comandi in invio sia i comandi in risposta
	- A connessione aperta, basta inserire un comando per vederlo printato a schermo (effetto del local echo) e subito dopo la risposta del coupler; il ciclo del comando si ha quando appare #
		Comando H: formatta il badge
		Comando S: suona beep
		Comando Z: Scrive il badge (sintassi: Zxxxxxxxxxx*) (x = cifre, 10 sono obbligatorie)

* Troubleshooting terminale GPRS

	Step:
	1) Riavvia btService
	2) Per MCT35x:
		Stacca alimentazione e riattacca
	   Per MCT700:
		NB: Il terminale GPRS MCT700 continua a scrivere il file Debug anche quando scollegato
			Quindi: non fidarsi della data-ora di aggiornamento del file Debug_... sotto MicronService
		a. entra in Menu > Spegni
		b. Attesa spegnimento completo (si devono spegnere anche le luci delle antenne RFID)
		c. Stacca alimentazione
		d. aspetta 2 minuti
		e. Riattacca alimentazione
		f. check icona di connessione a display
	3) Telnet da rete Microntel
		telnet <IP pubblico>:<porta terminale>
			IP pubblico va letto nei parametri a bordo del terminale (anche da display)

	Se nessuno di questi funziona:
	- è un problema di campo
	- è un problema di modem
		- Su MCT700, un modulo GSM funzionante ha i link SIM1 e GSM accesi FISSI (*non* SIM2)

* VirtualBox

Espandere il volume del VDI su VM:
	- Macchina virtuale su vBox > [click destro] > Open in Explorer (copia il full path fino a .vdi)
	- Macchina virtuale su vBox > Propriet� > Archiviazione > Rimuovi collegamento da VDI
	- cmd > C:\Program Files\Oracle\VirtualBox\vBoxManager.exe modifymedium "[fullpath copiato precedentemente]" --resize [new_size_in_MB]
	- Espandere la partizione virtuale nella Gestione Disco della VM guest



# INFO Logistica
============================================================================================================================================

## MICRONTEL

(*Password PC Enzo: ForzaRagazzi72!)

	PC
		Utente amministratore:
		username: 	edoardo.sanna@microntel.com
		password:	5anna3d0ard0

		Secondo utente amministratore:
		username:	temp
		password:	temp

		Account Google:
		username:	edoardo.sanna.mct@gmail.com
		password:	M!cr0ntel

		Account Huawei:
		numero:		+393371546662
		password:	M!cr0ntel

		Account Microsoft:
		username:	edoardo.sanna@microntel.com
		password:	M!cr0ntel082020
		pin:		030489

		Computer name:SANNA-10

			Windows 10 Pro
			8VMW9-NK8DM-FKTPT-TGVXC-MP2KF

			Office 2013
			YC7DK-G2NP3-2QQC3-J6H88-GVGXT

	WiFi aziendale:
		SSID/password:		MICRONTEL-Company/(autenticazione di dominio MICRONTEL)		% Per PC in dominio Microntel, non richiede autenticazione perch� la ricava dall'autenticazione di dominio - solo per utenti in AD
		SSID/password:		MICRONTEL-Guest/M!cr0ntelW!f!					% Per PC e dispositivi mobili fuori dominio Microntel, richiede autenticazione; � su una VLAN diversa, quindi non ha accesso alle cartelle dei server
		SSID/password:		MICRONTEL-Test/(autenticazione di dominio MICRONTEL)		% Per PC fuori dominio, rientra nella stessa VLAN dei server ma richiede comunque un'autenticazione di dominio

	VPN AZIENDALE:
		Client:		FortiClient
		Host:		85.38.156.146
		username:	edoardo.sanna
		password:	<password PC>

	MAIL AZIENDALE:
			Server:		giove.mailmox.it
		MICRONTEL:
			account:	edoardo.sanna@microntel.com
			password:	EdS44MEs
			URl web mail:	mail.microntel.com
		ADP:	
			account:	adp.service@microntel.com
			password:	ahph6iem0E

	MAPEC
		URL:		https://teamportal.mapec.it/www/
			Credenziali TeamSystem(R):
			username:	edoardo.sanna@microntel.com
			password:	M!cr0ntel092020


	INFOPOINT:
		URL:		http://156.54.149.115/Mct.Infopoint/
		username:	edoardo.sanna
		password:	5Anna3d0ard0!072020

			Infopoint > Cartellino > [sel. data] > Giustifica > 
				Permesso:
					Richiesta per = WPER-PERMESSO
					N. di ore giornaliere (HHMM) > inserire la quantit� di ore e minuti
					Dalle ... alle ... > Inserire il dettaglio della richiesta
					"Invio richiesta" per confermare l'invio
				Ferie:
					Richiesta per = WFER-FERIE
					(idem a sopra)

	ONEDRIVE
		nome account:	edoardo.sanna@microntel.com
		password:	5anna3d0ard0
						
	CELLULARE AZIENDALE:
		Numero:			+39 337 154 66 62
		Account Vodafone:	edoardo.sanna@microntel.com

	CLOUD SELF DATA CENTER:
		username:		edoardo.sanna@microncloud.local
		password		M!cr0ntel072020
		
		Accesso alla console di gestione 
		URL: https://selfdcvcloud.nuvolaitaliana.it/cloud/org/org-micspa
		Username: DC_93413541309
		password: Micro!Mpw13_2016!01
			
## BITECH:

	Server FTP	
		Hostname:	79.11.21.211
		username:	sanna
		password:	edo89+0304

	Documentazione tecnica:
		Server BiTech > /MRT/MRT_FascicoloTecnico/MRT_Fascicolo_work/

	Firmware:
		Server BiTech > /MRT/MRT_Firmware_bins

	Sito licenze
		URL:		https://79.11.21.211/licence/
		username:	sanna
		password:	edo89+0304

	WiFi:
		SSID/password:	Bitech_Guest/BitechGuest

## ISEO/MICROHARD

	Server FTP:
		Hostname:	ftp.iseo.com
		username:	public_user 
		password:	ftpiseo2012

## BIELLE:

	Assistenza:		Daniela, 0117725111
	credenziali Bielle: 	edoardo, es030489
	Codice persona:		40

## ADP

	ServicePortal:
		https://serviceportal.adp.com/eservice_ita
		username:	edoardo.sanna@microntel.com
		password:	M!cr0ntel062020

		- Per aprire un nuovo ticket:
			Barra di navigazione in alto: Crea Nuova SR
			Inserire i dati obbligatori:
			- Categoria Prodotto = Time and Attendance
			- Nome del Prodotto = Terminali
			- Priorit� = da 1 a 4 
			- Segnalato da = Employer
			- Categoria = Time
			- Sottocategoria = [libero]
			- Oggetto = <CLIENTE> - SUPPORTO: <RICHIESTA>
			- Descrizione = [libero]
			L'apertura/chiusura di un ticket genera automaticamente una notifica email verso adp.service@microntel.com
		- Per vedere i ticket aperti:
			Richiesta di Servizio > Le mie SR per prodotto > Prodotto = Terminali
			Cliccare sul campo #SR per aprire i dettagli del ticket
				� possibile inserire i commenti sul ticket da entrambi i lati (v. sezione Commenti)
				L'inserimento di un commento sul ticket genera automaticamente una notifica email vero adp.service@microntel.com
				� possibile allegare fino a 100MB/file al ticket
			� possibile filtrare secondo determinati campi, eventualmente esportare in file XLS e contare i ticket
			
	Filezilla:
		FileZilla > fts.sfg.adp.com:11422
		Protocollo: SFTP, Autenticazione: Key File
		username: itacmicronteltime
		Key file: itacmicronteltime.ppk
		- Inserire file (non cartelle) in TO_ASSOCIATE
		- Prelevare file da FROM_ASSOCIATE

## SKYPE

	username:	edoardo.sanna@microntel.com
	password:	5anna3d0ard0

## VIAGGI

	SNCF (TGV)
		username:	edoardo.sanna@microntel.com
		password:	edoardosannamicrontel

	AUTO
		PYNG
			unm:	micronteles
			pwd:	micronteles2017



#  SISTEMISTICA GENERALE
============================================================================================================================================

## BASI DI RETI E SISTEMI


SUBNET MASK

Subnet Mask ("maschera di sottorete") � la mappatura utilizzata per definire il range di appartenenza di un host all'interno di una sottorete (subnet) IP; serve a ridurre il traffico di rete e facilitare la ricerca e il raggiungimento di un determinato host con relativo indirizzo IP.
Lo schema di indirizzamento classico � chiamato CIDR ("Classless Inter-Domain Routing") e permette di indicare sinteticamente una subnet. 
Il CIDR � espresso nella forma A.B.C.D/X, dove
	A.B.C.D		� il primo IP della subnet, anche detto l'indirizzo di rete della subnet
	X 		� la subnet mask, ovvero il numero di bit (contati partendo dal pi� significativo a sinitra) che compongono la parte di indirizzo di rete
A.B.C.D rappresenta quattro numeri da 0 a 255 espressi in termini di byte.

	Es. 	0.0.0.0			00000000 00000000 00000000 00000000
		172.16.0.132		10101100 00010000 00000000 10000100
		192.168.0.250		11000000 10101000 00000000 11111010
		255.255.255.255		11111111 11111111 11111111 11111111

I rimanenti Y=32-X bit consentono di calcolare il numero di host della sottorete, pari a 2^Y-2 (dove il -2 sta per i due indirizzi suddetti, non assegnabili).
In ogni sottorete ci sono quindi una serie di IP disponibili calcolabili dai bit rimanenti, ad eccezione di:
	- Il primo indirizzo IP della rete, che definisce l'indirizzo della rete della subnet (usato per esempio nelle tabelle di routing)
	- L'ultimo indirizzo IP della rete, usato come indirizzo di Broadcast (ovvero comprende indistintamente ogni altro indirizzo all'interno di quella rete)

	Es. 192.168.0.250/24
		192.168.0.250 � il primo IP della subnet
		X = 24
		Y = 32-24 = 8
		Quantit� di host nella sottorete = 2^8-2 = 254

	Es. 192.168.0.250/8
		192.168.0.250 � il primo IP della subnet
		X = 8
		Y = 32-8 = 24
		Quantit� di host nella sottorete = 2^24-2 = 16777214

..................................
	
	CIDR	BITS	NETMASK		NUMERO DI HOST DISPONIBILE	NOTE
	/8	24	255.0.0.0	16777214 = 2^24-2		Allocazione pi� grande possibile
	/9	23	255.128.0.0	8388608 = 2^23	
	/10	22	255.192.0.0	4194304 = 2^22	
	/11	21	255.224.0.0	2097152 = 2^21	
	/12	20	255.240.0.0	1048576 = 2^20	
	/13	19	255.248.0.0	524288 = 2^19	
	/14	18	255.252.0.0	262144 = 2^18	
	/15	17	255.254.0.0	131072 = 2^17	
	/16	16	255.255.0.0	65536 = 2^16	
	/17	15	255.255.128.0	32768 = 2^15			ISP / grandi aziende
	/18	14	255.255.192.0	16384 = 2^14			ISP / grandi aziende
	/19	13	255.255.224.0	8192 = 2^13			ISP / grandi aziende
	/20	12	255.255.240.0	4096 = 2^12			Piccoli ISP / grandi aziende
	/21	11	255.255.248.0	2048 = 2^11			Piccoli ISP / grandi aziende
	/22	10	255.255.252.0	1024 = 2^10	
	/23	9	255.255.254.0	512 = 2^9	
	/24	8	255.255.255.0	256 = 2^8			LAN ampia
	/25	7	255.255.255.128	128 = 2^7			LAN ampia
	/26	6	255.255.255.192	64 = 2^6			Piccola LAN
	/27	5	255.255.255.224	32 = 2^5			Piccola LAN
	/28	4	255.255.255.240	16 = 2^4			Piccola LAN
	/29	3	255.255.255.248	8 = 2^3				La pi� piccola rete multi-host
	/30	2	255.255.255.252	4 = 2^2				"Glue network" (collegamenti punto-punto)
	/31	1	255.255.255.254	2 = 2^1				Usato raramente, collegamenti punto-punto (RFC 3021)
	/32	0	255.255.255.255	1 = 2^0				route verso un singolo host



	Es. ..................................


* APPUNTI SUL WINDOWS UPDATER:

	Def. "Security Only" quality update
	A single update containing all new security fixes for that month
	This will be published only to Windows Server Update Services (WSUS), where it can be consumed by other tools like ConfigMgr, and the Windows Update Catalog, where it can be downloaded for use with other tools or processes. You won�t see this package offered to PCs that are directly connected to Windows Update.
	This will be published to WSUS using the �Security Updates� classification, with the severity set to the highest level of any of the security fixes included in the update.
	This (like all updates) will have a unique KB number.
	This security only update will be released on Update Tuesday (commonly referred to as �Patch Tuesday�), the second Tuesday of the month.  (This is also referred to as a �B week� update.)

	Def. "Security monthly quality rollup"
	A single update containing all new security fixes for that month (the same ones included in the security only update released at the same time), as well as fixes from all previous monthly rollups.  This can also be called the �monthly rollup.�
	This will be published to Windows Update (where all consumer PCs will install it), WSUS, and the Windows Update Catalog.  The initial monthly rollup released in October will only have new security updates from October, as well as the non-security updates from September.
	This will be published to WSUS using the �Security Updates� classification.  Since this monthly rollup will contain the same new security fixes as the security only update, it will have the same severity as the security only update for that month.
	With WSUS, you can enable support for �express installation files� to ensure that client PCs only download the pieces of a particular monthly rollup that they haven�t already installed, to minimize the network impact.
	This (like all updates) will have a unique KB number.
	This monthly rollup will be released on Update Tuesday (also known as �Patch Tuesday), the second Tuesday of the month.  (This is also referred to as a �B week� update.)


* Netstat

Questo � un comando diagnostico molto utile ed estremamente complesso, che permette di visualizzare una grande quantit� di informazioni relative alla rete. La trattazione di tutte le sue capacit� comporterebbe un approfondimento dei concetti relativi alle reti che va al di l� delle possibilit� di un corso introduttivo. 
Qui ne tratteremo solo un caso specifico, quello che permette di visualizzare tutte le connessioni attive sulla macchina (un po' come potrebbe fare il quadro di un centralino che mostra tutti i collegamenti in corso). Per questo � anche uno dei primi comandi che un eventuale intruso che si sia introdotto nella vostra macchina cercher� di sostituire con una sua versione ``taroccata'' perch� pu� mostrare eventuali collegamenti ``indesiderati''. 
Anche per capire questi risultati � comunque necessario di un minimo di conoscenza dei protocolli e dei servizi: � facile trovare persone che allarmano perch� hanno ``un collegamento strano sulla porta 25'', e in realt� stanno semplicemente inviando la posta che hanno appena finito di scrivere. 
Il comando usato con le opzioni di default mostra le informazioni riguardo a tutti i socket aperti; anche i collegamenti interni al sistema (usati da vari programmi per scambiarsi i dati con l'interfaccia dei socket) che di norma non han nulla a che fare con la rete. Per questo motivo � d'uopo specificare le opzioni -t per richiedere di visualizzare solo i socket TCP o -u per vedere quelli UDP, che sono quelli che riguardano le connessioni con la rete esterna. 
Un possibile esempio del risultato di netstat � il seguente: 
[piccardi@gont piccardi]$ netstat -at
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 *:printer               *:*                     LISTEN
tcp        0      0 *:5865                  *:*                     LISTEN
tcp        0      0 *:webcache              *:*                     LISTEN
tcp        0      0 *:tproxy                *:*                     LISTEN
tcp        0      0 gont.earthsea.ea:domain *:*                     LISTEN
tcp        0      0 localhost:domain        *:*                     LISTEN
tcp        0      0 *:ssh                   *:*                     LISTEN
tcp        0      0 *:ipp                   *:*                     LISTEN
tcp        0      0 *:nntp                  *:*                     LISTEN
tcp        0      0 *:smtp                  *:*                     LISTEN
tcp        0      0 ppp-42-241-98-62.:32798 serverone.firenze:imaps ESTABLISHED
Il comando riporta una tabella con le indicazioni relative a ciascuna connessione. Il campo Proto riporta il protocollo della connessione. I campi Local Address e Foreign Address indicano gli indirizzi locale e remoto della stessa (che pu� essere stampato in forma numerica anzich� usando lo switch -n), nella forma: 
indirizzo:porta
dove un asterisco indica un indirizzo o una porta qualunque. Il campo State indica lo stato della connessione. Una spiegazione dettagliata del significato dei vari campi va di nuovo al di l� delle possibilit� di un corso introduttivo (specie per il campo State), per gli interessati mi limito a segnalare il capitolo Socket TCP elementari http://gapil.firenze.linux.itGaPiL, in cui questi concetti vengono spiegati in dettaglio. 
Delle varie righe quelle che meritano attenzione sono quelle relative agli stati LISTEN ed ESTABLISHED. Lo stato LISTEN indica la presenza di un programma in ascolto sulla vostra macchina in attesa di connessione, nel caso ce ne sono vari corrispondenti a servizi come la posta, le news, il dns, la stampa via rete, gli indirizzi sono di norma non specificati in quanto la connessione pu� essere effettuata su uno qualunque degli indirizzi locali, da un qualunque indirizzo esterno. Lo stato ESTABLISHED indica le connessioni stabilite ed attive, e riporta nei campi degli indirizzi i due capi della connessione. Altri stati che possono essere riportati sono FIN_WAIT, TIME_WAIT, e si riferiscono a connessioni che si stanno chiudendo. 


	Netstat fornisce informazioni complete sulle connessioni del nostro sistema come le statistiche dell�interfacce, tabella di routing, maschera di connessione, elenco delle connessioni in ascolto o attive, etc.
		netstat -a				Tutte le connessioni UDP e TCP attive
		netstat -a | findstr [stringa]		Cerca stringa nel risultato del netstat -a
		netstat -s				Statistiche per IP, IPv6, ICMP, ICMPv6, TC, TCPv6, UDP, UDPv6 (usare l'opzione -p per selezionare un sottoinsieme)
		netstat -

	(*) Netstat filtrando per porte (tipo LIKE)

		netstat -an | find "<inserire stringa>"

* Processo explorer bloccato
Riavvio da riga di comando:

	tasklist /v | sort 		% lista dei processi in ordine alfabetico, con indicazione dell'utenza (verificare PID del processo explorer bloccato)
	tasklist /PID <ID> /F		% forza la chiusura del processo identificato dal PID <ID> (spariscono la Start bar e le icone del desktop, � normale)
	explorer.exe			% riavvia il processo explorer

* Ping lento

	A fronte di una risposta a ping particolarmente traballante o addirittura assente, si potrebbe verificare che nella stessa rete del terminale esista un dispositivo configurato in Broadcast, che invia pacchetti a tutti i dispositivi della stessa rete.
	La scheda di rete del terminale (es.MCT) non riesce ad eliminare queste richieste in tempo per rispondere al ping da server, rispondendo quindi con timeout.

* Per sapere la relazione MAC-IP di tutti i dispositivi connessi al pc, digitare su CMD (purch� ci si trovi in una LAN tale che il MAC address sia visibile):
	arp -a


## EVENT VIEWER

(*) LOG DELL'EVENT VIEWER TROPPO GRANDI
Come impostazione di default, i log dell'Event Viewer vengono sovrascritti del loro contenuto secondo una logica di dimensione massima.
� possibile che si riscontri un disco C: troppo grande, e che nel disco C: la cartella 'fuori controllo' sia Windows\System32\Winetv\Logs: in tal caso si tratta proprio dei log dell'Event Viewer!
I log dell'Event Viewer vengono archiviati come Archive-<NomeLog>-<Data>-<Ora>.etvx

	Per disabilitare l'archiviazione automatica:
	- Pannello di Controllo > Strumenti di Amministrazione > Event Viewer (Visualizzatore eventi)
	- Registri di Windows > [Nome Log] > click destro > Propriet�
	- Maximum log size (KB) = [valore di default 20480; superato il valore impostato, valgono le regole seguenti]
	- When maximum event log size is reached:
		- Overwrite events as needed (oldest events first)	% Impostazione di default
		- Archive the log when full, do not overwrite events	% Salva il file di log sotto C:\Windows\System32\Winetv\Logs
		- Do not overwrite events (clear logs manually)		% Non sovrascrivere gli eventi, v.pulsante sotto "Clear Log"


## ASSISTENZA HOTLINE

Per accedere al server o al pc client, si possono usare gli strumenti di connessione remota. Si pu� accedere direttamente al server (se vengono fornite le credenziali), oppure al pc client e da l� utilizzare il servizio di "connessione da desktop remoto".

� Infrastruttura di default su pc

	\\SRVDC1\file_server\SEDE\Infrastrutture\Sistema Informativo\STARTUP_PC

	- Per Hotline: STARTUP_PC > assistenza
	- Per TeamViewer: STARTUP_PC > TeamViewer. Copiare il Setup su pc e avviare. Ad installazione avvenuta, aprire TeamViewer > Extra > Attiva licenza e copiare il codice che si trova in "Attivazione licenza".doc


� Strumenti di connessione remota

	- TeamViewer: strumento di connessione da desktop remoto; si pu� far scaricare al cliente, nel caso in cui non avesse alcuno strumento, da microntel.com > Servizio Clienti > Assistenza tecnica > Supporto Remoto. Il file � TeamViewerQS_it.exe (Team Viewer Microntel Quick Support). Aspettando la connessione, viene fornito al cliente ID e Password da comunicare al tecnico, che provveder� ad inserirli nel suo TeamViewer per accedere. L'opzione "Trasferimento Files" sulla barra in alto permette di caricare files con una dinamica di trascinamento da locale a remoto simile a FileZilla.
	
		(*) In ufficio non si supportano pi� di tre connessioni remote di TeamViewer contemporaneamente! Se sono tutte occupate, pensare di utilizzare qualcos'altro.

	- Ammyy: Applicazione per controllo remoto scaricabile gratuitamente dall'omonimo sito web.


� Hotline

Database SQL
	istanza:	172.16.1.24/SQLEXPRESS
	username:	assistenza
	password:	assistenza

- Copiare il file fisico del software Hotline in un percorso locale (tipo C:\Assistenza\)
	\\172.16.1.24\assistenza\MASCHERA_ASSISTENZA\Microntel_Hotline.mdb

- Ad ogni apertura di Access, ricordarsi di ATTIVARE i contenuti, come da indicato nel popup in alto sotto la barra dei menu

	Per OGNI intervento va salvata una chiamata. Precisare:
	- Cliente: campo a completamento automatico (nel caso in cui non si trovasse il cliente, andare su Visualizza > Visualizza Foglio Dati > Cerca (con impostazione "parte del campo")
	- Referente: la persona con cui si � parlato. Va bene anche solo il nome.
	- Ricevente: persona che ha preso la chiamata
	- Tecnico: persona che ha fatto l'intervento (scegliere da lista)
	- Tipo: hardware o software
	- Esito
	- Durata
	- Descrizione intervento hotline: elencare tutto quello che si � fatto nell'intervento


## DESKTOP REMOTO


(*) CORREZIONE CRITTOGRAFIA ORACLE PER CREDSSP
L'errore � il seguente:
	Errore di autenticazione. La funzione richiesta non � supportata. Computer remoto: XXXXXXXXXX. La causa potrebbe essere la Correzione crittografia Oracle per CredSSP. Per altre informazioni https://go.microsoft.com/fwlink/?linkid=866660

	Soluzione:
	- Esegui (Win+R) > gpedit.msc (Editor Criteri di gruppo locali)
	- Modelli amministrativi > Sistema > Delega di credenziali > Correzione crittografia Oracle
	- Selezionare "Attivata" e Livello di protezione=Vulnerabile
	- Confermare con OK e ritentare la connessione in RDP

(*) Non funziona alcuna connessione di Desktop Remoto (e non � un problema di VPN)
	- Pannello di Controllo > Windows Defender Firewall > Consenti app o funzionalit� attraverso Windows Defender Firewall
	- Controllare che ci siano tutte le spunte su "Desktop Remoto" (altrimenti, cliccare su Modifica Impostazioni)



# CORSO BASE
============================================================================================================================================

1. Predisposizione sistema operativo
	- Caratteristiche sistema operativo
	- Caratteristiche hardware del server
	- Apertura porte di comunicazione in base all'interfacciamento degli apparati hardware
	- Caratteristiche database di appoggio

2. Installazione suite Micronpass Web
	- Procedura di installazione suite Micronpass Web
	- Creazione database
	- Collegamento applicativo al database
	- Attivazione licenza

3. Attivazione impianto software
	- Configurazione applicativi installati
	- Configurazione apparati di controllo e rilevazione dati accessi / presenze / mensa
	- Gestione export timbrature presenze / mensa file transfer
	- Gestione export timbrature presenze / mensa per mezzo di un Bridge
	- Gestione modulo Micronimport per caricamento massivo anagrafica Dip/Est/Vis

4. Gestione impianto hardware
	- Predisposizione impianto hardware base
	- Caratteristiche terminali MXP250 e MCT
	- Caratteristiche lettori badge (KK, Kleis)
	- Caratteristiche attuatori KX50
	- Specifiche principali collegamenti tra lettori MXP250 e lettori badge

5. Avviamento impianto
	- Procedura di configurazione apparati accessi e presenze e prima attivazione (GNConfig - Micronconfig)
		- Terminali presenze ETH - FTP - GPRS
		- Centraline MXP e relativi device collegati (lettori e attuatori)
	- Gestione Micronpass Web e moduli principali
	- Gestione Micronsin Web, funzionalit� principali
	- Schedulazione sincronizzazione anagrafica (Micronimport)
	- Gestione modulo Micronmail (automatizzazione report, e.g. Presenti in Azienda Immediato)
	- Gestione modulo Micronmail (notifiche funzionamento impianto hw/sw)
	- Gestione modulo Micronreception e attivazione hardware lettori badge USB (RFID)
	- Gestione Panel PC dedicati alla gestione con Mensa Advanced o Mensa Base con MCT

6. Analisi funzionamento impianto
	- Principali file di log di controllo
	- Principali test di verifica funzionamento hardware o software
	- Principali interventi di ripristino hardware / software

7. Argomenti aggiuntivi
	- Varchi Offline, meccatronica
	- Panel PC per funzionalit� speciali (Punto evacuazione, self check-in, gestione trasportatori, ecc.)
	- Modulo MicronplateVega: Riconoscimento targhe
	- Integrazione video su Micronsin Web (videocamere Axis, Truevision)


# REQUISITI SOFTWARE
============================================================================================================================================

## PREREQUISITI

� REQUISITI MACCHINA

Recommended hardware requirements	
	Web Server only: 1 socket with 4 virtual processors, 8GB RAM, 100GB HD system-data partition 
	Web & DB Server combined: 4 vCPU, 8GB RAM, 100GB HD dedicated data partition 
Supported OSs	
	OS Server 32-64 bit: Windows Server 2012 R2 or higher 
	OS Client 32-64 bit: Windows 7 / Windows 8.1 / Windows 10 
Software requirements	
	Microsoft .NET Framework 4.5.2 or higher 
	Internet Information Services (IIS) 7.0 or higher 
        	Enable ASP.NET features on IIS 
                Add all features related to IIS6 compatibility 
                Enable .NET Extensibility, ISAPI Extensions and ISAPI Filters modules 
Database server	
	SQL Server Express/Standard Edition 2012 SP2 or higher 
                Enable mixed authentication (SQL Server and Windows Authentication) 
	SQL Server Management Studio 2012 or higher 
Remote connections	
	Connectivity via RDP with local admin user
Firewall inbound/outbound settings	
	TCP Port 3001 (communication with hardware devices) 
	TCP Port 22 (SSH/SFTP) 
	TCP Port 23 (Telnet) 
	TCP Port 80/443 (HTTP/HTTPS) 
	TCP Port 1433 (SQL Server) [only in case of separated DB server] 

NB: i requisiti elencati sopra riguardano le componenti standard della Application Suite: ulteriori requisiti potrebbero emergere in caso di presenza di moduli software aggiuntivi.

	Altri requisiti:
	- Il server deve ovviamente poter essere nella LAN dedicata ai terminali
	- Laddove possibile, disabilitare il Windows Firewall se non configurato adeguatamente dal cliente
	- Similarmente, disabilitare il Windows Defender se ostacola l'installazione
	- Utilizzare un'utenza superuser o preferibilmente amministrativa
	- Per disabilitare il controllo utente, Pannello di Controllo > Account utente > Modifica le impostazioni di controllo dell'account utente > Disabilita controllo utente
	
	Altro:
	- Per mettersi su pi� reti: imposta indirizzo IP statico, poi scheda di rete > impostazioni avanzate > aggiungere Subnet, IP e GW della nuova rete a cui ci si vuole collegare


� ATTIVAZIONE IIS
Internet Information Services

l'IIS � una funzionalit� del Sistema Operativo. Di solito � disattivato per default; per attivarlo, a seconda della versione di Windows, di solito si procede andando su Pannello di Controllo > Programmi e Funzionalit� > Attiva/Disattiva funzionalit� di Windows.
- Fare attenzione che, sotto la voce Internet Information Service, le seguenti voci siano spuntate:
	+ Servizi Web	
		> Funzionalit� HTTP comuni 	
			> Contenuto statico
			> Documento predefinito
			> Errori HTTP
			> Esplorazione directory
		> Funzionalit� per lo sviluppo di applicazioni
			> ASP
			> ASP.NET
			> CGI
			> Estendibilit� .NET
			> Estensioni ISAPI
			> Filtri ISAPI
			> Server-Side Include
		> Strumenti di Gestione Web
			> Compatibilit� di gestione con IIS6
			> Console di gestione IIS
			> Servizio di gestione IIS
			> Strumenti e script di gestione IIS

	(*) In Windows Server 2008/2012, queste funzionalit� si attivano mettendo la spunta a "Web Services" nei "Roles" dal Server Manager. Ricordarsi nelle "Features" di installazione dell'IIS di mettere la spunta a 'Telnet Client'

	(*) Errore "Specify an alternate source path": 
		PRIMA installare il Framework 3.5 (o 4.5, a seconda della versione a cui si riferisce l'errore), poi riprovare ad installare le funzionalit� IIS

� MICROSOFT .NET FRAMEWORK 4.0

- Meglio averlo a disposizione su chiavetta!
- E' comunque scaricabile da sito Microsoft > Centro Download > Microsoft .NET Framework 4 (programma di installazione autonomo)

	(*) In Windows Server 2012, � possibile installare il framework spuntando tutto sull'installazione dell'IIS. In Server Manager, clicca su "Add roles and features": nei "Roles" � possibile inserire le spunte per l'IIS, mentre nei "Features" si pu� aggiungere il Framework.

	(*) Problema di installazione delle funzionalit� del Microsoft .NET Framework 3.5 su Windows Server 2012 R2
	https://blog.dbi-services.com/winows-server-2012-r2-failed-to-install-net-framework-35/
	
		Nella procedura di installazione del .NET Framework 3.5 (un prerequisito per poi installare SQL Server 2012), nel Server Manager alla voce "Aggiungi Ruoli e Funzionalit�" � possibile spuntare la voce "Funzionalit� .NET Framework 3.5" e proseguire nell'installazione per attivare le funzionalit�.
		Il problema � che quando si procede con l'installazione, anche precisando un diverso percorso di origine, l'errore di installazione delle funzionalit� si ripropone, rendendo impossibile il completamento ("The source file could not be found...")
		Se si apre una PowerShell per verificare le Windows Features disponibili sul server (comando "Get-WindowsFeature"), in corrispondenza del .NET Framework 3.5 si ha lo stato "Removed".
		� possibile installare 'manualmente' il framework semplicemente utilizzando lo Standalone Offline Installer tool.
		Link forum (potrebbe dover essere necessario loggarsi): https://forums.mydigitallife.net/threads/net-framework-3-5-standalone-installer-for-windows-8-1-x86-x64.47748/
		Link download: https://1drv.ms/u/s!AhOEoZ7nJmxFgUhRDSSmY2ExUh1i
			Istruzioni:
			- Eseguire come amministratore
			- Cliccare NEXT per iniziare il processo
			- Attendere che la procedura di estrazione sia completata
			- Attendere che l'installazione sia completata


## INSTALLAZIONE 

� LICENZA

Un cliente non nuovo avr� un file licenza nelle cartelle dei suoi applicativi che andr� sovrascritto dalla licenza corrispondente alla nuova versione installata. Per fare questo, seguire i seguenti step:

	- Aprire un browser e cercare "79.11.21.211/licence"
	- Nel menu a sinistra, scegliere Nuova licenza MRT(v>5.0)
	- Inserire "Versione database" della licenza richiesta
	- Cliccando su "Datamax" > [...] � possibile inserire una data di scadenza
	- Spuntare i pacchetti abilitati

		(*) Per licenze ADP, ricordarsi di spuntare sempre "ADPBridge"

	- Spuntare i moduli opzionali
	- Inserire il numero dipendenti
	- Scegliere il Rivenditore nel menu a tendina
	- Scrivere la Rag.Sociale del cliente

		(*) Licenza non valida: controllare che la ragione sociale non contenga caratteri speciali

	- Scegliere tipo chiave (HW = dismesso, SW = per server fisici, SWLight = per server virtuali)
	- Nome chiave: <blank>
	- Cod.Abil. : inserire il codice a quattro cifre creato da X:\MPW\GeneraABL\GeneraABL.exe (selezionare il tipo di chiave e cliccare su "Genera")
	- Appena appare l'avviso di file licenza generato, cliccare su "Download" e salvare il pacchetto .zip. Dovr� essere utilizzato nella fase di aggiornamento licenza del MicronStart (v. sotto)

� INSTALLER

	- Estrarre i file dal pacchetto MRTxxx.zip (dove xxx � la versione del software) e i file di CRRedist (dove yyyy � l'anno) - Crystal Reports - corrispondenti ai bit del Sistema (32 o 64) nella stessa cartella. L'installazione dei Crystal Reports partir� automaticamente durante l'installazione dell'MRT, altrimenti pu� essere fatta manualmente in un secondo momento.
	- Esegui MRTxxxx.exe 
	- Cliccare "Next", poi "Accetto le condizioni...", inserire Nome e Societ� e usare come percorso di installazione X:\MPW\ (dove X � la partizione dove si vuole installare il programma, di solito quella con pi� spazio).
	- Nel tipo di Setup, tra "Complete", "Custom" e "Small" scegliere "Custom". 

	(*) "Small" � intesa per un'applicazione di sola acquisizione dati; pi� avanti, nel MicronStart, andr� scelto 'Attivazione Software per Acquisizione Dati (Piccoli Impianti)'

		- Cliccare "Next" e infine "Install". Durante l'installazione, l'installazione automatica dei Crystal Reports potrebbe non essere eseguita: in tal caso dare OK al messaggio di avviso in merito, e alla fine dell'installazione dell'MRT sar� possibile far partire l'eseguibile dei CRRedist.

	(*) Il computer potrebbe richiedere il riavvio alla fine dell'installazione.


� CRYSTAL REPORTS

Per l'installazione dei Crystal Reports, spacchettare il .zip e far partire l'installazione scegliendo "Reinstall".

	(*) Il seguente errore potrebbe apparire: "Error 1606. Could not access network location \ASP.NETClientFiles\. Per risolvere, su Start cercare 'cmd' ed eseguire come Amministratore. A quel punto, entrare da console nella cartella dove si trova il setup dei Crystal Reports .msi ed eseguirlo da l�.



## ATTIVAZIONE (MICRONSTART)

L'attivazione permette di creare un database su SQL e legarlo all'applicativo web; aggiornare la versione del database alla versione del software; aggiornare tutti i file di configurazione dell'applicativo, inserendovi le informazioni relative ai database; aggiornare il file di licenza (questo step pu� essere fatto anche in un secondo momento); generare i parametri di configurazione per la prima installazione.

- Eseguire MicronStart come Amministratore

(*) � importante! Altrimenti molte delle modifiche richieste - come l'aggiornamento della versione di database, o delle licenze - potrebbero non avere alcun risultato.

- "Lingua": sar� la lingua degli applicativi, a eccezione di quelli la cui lingua pu� essere impostata tramite MicronConfig.

- "Attivazione Software Standard": per qualsiasi impianto grosso, o un impianto piccolo con almeno un terminale di controllo accessi

- "Creazione/Upgrade DB": per creare o aggiornare il database. La versione del database deve coincidere con quella dell'applicativo web. Alla fine del passaggio, andando su SQL server manager, viene creato il database MRT con le tabelle standard [al posto di (local) ci pu� essere <nomemacchina> o <IP>]. Di solito il nome dell'istanza va lasciato come da default.
	Tipo: SQL
	Server: (local)/sqlexpress 
	username: sa
	password: Micro!Mpw13
	Nome: MRT
	Crea
	Test Connessione
	(Eventuale backup del database)
	Aggiorna

- "Stringhe connessione": per dire a tutti gli applicativi di usare QUEL database. Premendo 'verifica', appaiono i file config di tutti gli applicativi: i file con la spunta hanno gi� il database aggiornato
	(ripetere dati della tab precedente)
	Verifica
	Aggiorna file

- "Aggiornamenti": andare su C:\MPW\generaABL\generaABL.exe. Il programma genera il codice cliente (cliccare su "generate software code") da inviare a licence@microntel.com. Nella mail scrivere gli applicativi per cui si necessita la licenza, la corrispondente versione e il codice cliente. Una volta ottenuto il .zip contenente il file .lic, copiare ed estrarre in C:\MPW\generaABL.
	Aggiorna file licenze > (cercare il file .lic ottenuto da mail)

(*) Se all'accesso non prende il file licenza nell'applicativo, pur avendolo aggiornato, riavviare l'IIS
(*) Un controllo rapido sul fatto che la licenza sia stata aggiornata consiste nell'aprire il file .lic all'interno della cartella del corrispettivo applicativo (per es. Micronpass, o Micronsin, ecc.) con un Notepad, e vedere che la versione ("Param01") sia aggiornata alla versione richiesta in fase di generazione della nuova licenza. 

- "Parametri": inserisce i parametri di Default per il funzionamento di MicronPassWeb; tra le altre cose, crea anche il primissimo utente: username admin, password admin
	Genera parametri per applicativi installati

(*) IMPORTANTE: il pulsante alla voce Parametri va usato solo alla prima volta che si installa! Altrimenti si rischia di sostituire i parametri con quelli di default



## CREAZIONE E CONFIGURAZIONE DELL'APPLICATION POOL

Il server su cui � installato il software permette l'accesso a Micronpass Web tramite web. Per questioni di diagnostica, nel caso in cui si dovesse interrompere l'applicativo o riavviarlo, � bene non agire anche sui siti del cliente - a loro volta sul server - e quindi � meglio creare un "Pool di applicazioni" indipendente in cui inserire Micronpass Web e Micronsin Web. Inoltre � necessario settare alcuni parametri, come per esempio l'uso del framework, perci� in assenza dell'Application Pool, nessuno dei due applicativi pu� funzionare.

� CREA APP POOL

- Andare su Pannello di Controllo > Strumenti di Amministrazione > Internet Information Services
- Sul menu a sinistra, clicca su Pool di Applicazioni > Aggiungi pool di applicazioni
- Inserire i seguenti dati. 	Nome: ACCESS CONTROL; 
				Versione .NET Framework: .NET Framework v.4.0 (...)
				Modalit� pipeline gestita: Classica
				Spunta su "Avvia pool di applicazioni immediatamente"
- Una volta che l'Application Pool � stato creato, click destro e seleziona Impostazioni Avanzate. A questo punto, setta "Attiva applicazioni a 32 bit" su "True"

� INSERISCI GLI APPLICATIVI NELL'APP POOL

- Nel menu a sinistra, espandere Siti > Default Web Site > mpassw e cliccare su Impostazioni di Base
- Cliccare su "Seleziona" e dal menu a tendina scegliere ACCESS CONTROL come Application Pool
- Fare la stessa cosa per il sito msinw
- Nel menu a sinistra, cliccare sul nome del server e a destra su "Riciclo" per riavviare l'IIS (in alternativa, in assenza di restrizioni, si pu� fare da command line tramite il comando 'iisreset')

(*) Un possibile errore che appare in visualizzazione dei siti su browser pu� dipendere dalle restrizioni ISAPI e CGI. Le restrizioni ISAPI e CGI sono gestori di richieste che consentono l'esecuzione di contenuto dinamico in un server. Queste restrizioni sono file CGI (con estensione exe) o estensioni ISAPI (con estensione dll). � possibile aggiungere restrizioni ISAPI o CGI personalizzate se il sistema di configurazione IIS lo consente. In caso di visualizzazione di tale errore, tornare alla root del menu a sinistra e cercare "Restrizioni ISAPI & CGI": nell'elenco dei framework disponibili, controllare che entrambe le versioni 32bit e 64bit del framework 4.0 abbiano la voce "Consenti".



## ACCESSO

� CREDENZIALI

Apri browser, digita <IP>/mpassw (dove <IP> pu� essere localhost se locale, o indirizzo IP, o nomemacchina: mettere l'indirizzo IP in alcuni casi accelera le cose) per accedere a MicronpassWeb. Allo stesso modo, <IP>/msinw per accedere a MicronSinWeb.

	Accesso "amministratore": � l'amministratore di sistema, ha le autorizzazioni che gli sono state date (non modificabile)
		username admin, password admin
	Accesso "installatore": � il tecnico Microntel, ha tutte le autorizzazioni (non modificabile)
		username micronunlock, password <hhddmmyyy>

Pi� avanti sar� possibile creare nuovi utenti e copiare modelli di autorizzazioni precompilati (per evitarsi di passare le ore a mettere spunte).


� SICUREZZA

- A seconda delle richieste dei clienti, � possibile limitare la possibilit� degli utenti del server alla scrittura/lettura per quanto riguarda la cartella MPW. In assenza di avvisi, si pu� mantenere "Full Control" per tutti gli utenti che hanno accesso al server (andare su MPW > click destro > Properties > Security > Edit > Add > "everyone"); nel caso in cui si dovessero avere delle restrizioni, � possibile personalizzare il tipo di controllo per ogni utente.

- Nei browser di molti clienti, per questioni di policy aziendale, � facile che le impostazioni di sicurezza di internet blocchino il sito. A seconda del browser utilizzato, conviene aggiungere il sito (nella fattispecie, anche solo l'IP della macchina, o il suo nome, o localhost) ai SITI ATTENDIBILI e ai PREFERITI (su Firefox, alle ECCEZIONI)
Eventualmente, togliere la spunta a Opzioni Internet > Sicurezza > Siti > Modalit� protetta




# CONFIGURAZIONE IMPIANTO

Prefazione: Questo e i prossimi capitoli sono dedicati alla configurazione dell'impiantino che c'� nel kit di dimostrazione: per cominciare configureremo il terminale di presenze MCT, che contiene una centralina a s�. La documentazione relativa a installazione e configurazione del kit si pu� trovare in "IT_Manuale_..._KIT.SMALL.doc"

Kit di dimostrazione:
	1 terminale presenze MCT363
	3 testine accessi: Karpos KK601 (solo lettore Unique/Q5), KK701 (lettore pi� tastierino), KK801 (lettore, tastierino e display)
	Ethernet Switch per collegare valigetta (due prese) alla rete Ethernet e al pc

		*** La famiglia 125kHZ Unique � Read-Only, mentre la famiglia 125kHz Q5 � Read-Write


## GNCONFIG

GnConfig � il programma software necessario per la configurazione dei terminali Karpos, del relativo firmware e dell�impianto in cui questi vengono ubicati. L�obiettivo di Gn Config � configurare l�ambiente di comunicazione (GNet) che permette lo scambio di dati fra i terminali e l�Host sul quale operano i vari programmi di acquisizione, come Winatt, MicronService, ArtServ. Il sistema Microntel � da considerarsi come una rete. I terminali, oltre a colloquiare ed interagire con il PC, sono in grado di comunicare fra loro usando delle funzioni pre-assegnate dal firmware (applicativo) in modalit� inter-tasking. Essendo tutti i terminali muniti della stessa CPU (sulla quale viene stabilita la funzione del terminale: accessi, presenze o produzione), � necessario stabilire a priori l��obiettivo� del terminale tramite il relativo firmware.

� INSERIMENTO TERMINALI

- Nota che, prima ancora di entrare nel Menu, l'MCT mostra il firmware che ha: BTAX433B
- Accedere al menu del MCT tramite sequenza F1-F2-F1-F2-F1-ROSSO. Il menu contiene: 
	(F1) Power Setup: impostazioni per il consumo nel caso in cui mancasse l'alimentazione
	(F2) Serial Flash: eventuale memoria aggiuntiva
	(F3) Keyb/Touch: impostazioni per lo schermo
	(F4) Display: regola contrasto dello schermo
	(F5) Eth On/Off: attiva o disattiva la scheda di rete
	(F6) Misc: serve per esempio ad attivare il watchdog (reboot del dispositivo)
	(F7): INFO
		IP: 	192.168.0.251
		Subnet:	255.255.255.0
		Gateway:192.168.0.230
		Porta:	3001
		MAC:	00:15:42:00:B1:08

(*) Attenzione!!! L'indirizzo IP, MAC, Porta e Subnet devono essere compatibili col pc con cui ci si sta collegando. Tramite un cmd > ipconfig si pu� leggere questi dati. Per esempio in questo caso i dati erano IP 172.16.3.31, Subnet 255.255.0.0, Gateway 172.16.1.254. In tal caso, nel menu a sinistra 'Opzioni', selezionare solo NINIT e IP e assegnare un indirizzo IP simile eccetto l'ultimo numero (prima verificare con un ping che non sia occupato, cio� che non risponda al ping), poi la stessa subnet mask e poi lo stesso gateway. Fare doppio clic sul nodo. Abbiamo cos� riassegnato dei nuovi dati di rete al terminale: a questo punto si pu� fare un ping al terminale e verificare che si sia collegati.

(*) Un altro modo di cambiare i dati di rete del terminale � di usare il tastierino sul terminale stesso. Ripetere la sequenza F1-F2-F1-F2-F1-ROSSO ed F7 per accedere al Menu Info. Premendo il tasto VERDE, ci si muove campo per campo, di cui � possibile modificare il contenuto. 

(*) Attenzione!!! L'indirizzo IP deve essere all'interno della stessa classe del server. Se si assegna un indirizzo IP corretto ma non si riesce a configurare, pu� essere che la classe di indirizzi sia completa. Chiedere in tal caso un nuovo indirizzo utilizzabile.

- Aprire GnConfig
- Inserire nuovo nodo e chiamarlo 00199. I nodi sono le centraline: o un MXP250 o la centralina nel terminale presenze (come in questo caso).
- Menu a sinistra: connessioni TCPIP
		applicativo - scegliere il firmware corrispondente all'MCT. 

(*) Potrebbe mancare all'elenco il firmware: in tal caso scaricarlo da server BiTech (v.sotto). Su server remoto, ADP > Versioni Firmware e scegliere la versione. Il file � un .zip: chiudere gnconfig ed estrarne il contenuto nella cartella gnconfig/gnproto/. Tra i file nel pacchetto, il .dsc contiene la descrizione del firmware, il tipo di scheda e il modello compatibile.

(*) FileZilla > File > Gestore Siti > 	Host: 79.11.21.211
					Porta: (vuoto)
					Protocollo: FTP
					Tipo di accesso: account
					Utente: sanna
					Password: edo89+0304
					Account: sanna

(*) Se lo schermo dell'MCT � bloccato e non funziona neanche la sequenza F1-F2-ecc, significa che � impallato; staccare l'alimentazione e riattaccarla 

(*) Sequenza alternativa al F1-F2-ecc (se il touch � attivo): angolo sx alto, angolo dx alto, angolo sx basso, angolo dx basso, angolo sx alto, angolo dx alto


- Nella parte a destra in alto, aggiungere N indirizzi logici quante sono le funzioni sottostanti		
- Lasciare i parametri di default: "Attivo" su S�, "Setup" su No, "Netw Baud" (velocit� di trasmissione) su 019200
- Inserire indirizzo Ethernet IP del terminale MCT
- Lasciare il valore di default della "Porta" (003001), il "Ping Retry" su 1
- Inserire MAC Address, la Subnet Mask e il Gateway del terminale MCT

- Lasciare "Polling" su No, "Network Managing" su No e "Programma Utente" su vuoto.
- Per aggiornare le informazioni inserite, clicca "Genera tabelle host" (terzo pulsante nel menu ad estrema sinistra): crea e carica il file Config.gn contenente la configurazione completa del sistema. Il processo va a buon fine se appare la scritta in alto 'Generazione tabelle dell'host completata'
	
(*) Da utilizzare tutte le volte che si effettua una variazione (ad esempio, cambiamento del tipo di modem, porta di comunicazione, indirizzo di rete, etc.).


� INVIO DELLA CONFIGURAZIONE

PREQUEL: ASSEGNAZIONE INDIRIZZO IP AL TERMINALE
Il pc da cui si invia la configurazione va collegato direttamente al terminale tramite cavo di rete. Disabilitare tutte le restanti schede di rete, wireless comprese.
Modo 1) Tramite tastierino da terminale, v.punti precedenti (valido solo per terminali con display)
Modo 2) Inserimento su gnconfig dei parametri di rete; spunta solo su "NINIT" e "IP"; doppio click sul nodo da configurare
Modo 3) Usare ethcfg.exe (v.sotto)

(*) USO DI ETHCFG
Etchfg.exe è un tool di configurazione da riga di comando con la seguente sintassi. 
Dopo aver alimentato la scheda ed averla connessa in rete, ad es. con un cavo cross, il tool ethcfg serve a configurarne i parametri di funzionamento.
Digitare ethcfg dalla folder di provenienza per ottenere l'help:

	Sintassi: ethcfg G MAC
	Sintassi: ethcfg C MAC [IP Address] [Protocol] [SubNet Mask] [Port] [Gateway] [Host IP] [Host Port]
	Sintassi: ethcfg A MAC [Branch] [Node]
	Sintassi: ethcfg R MAC

	Legenda:	G legge (get)
			C configura parametri ethernet
			A configura parametri GNet
			R Resetta (rimette valori di default) parametri ethernet
			MAC: ultime tre cifre del MAC Address (esempio 00:04:88)
			Protocol può essere T per TCPIP (default) o U per UDP

	ESEMPIO #1 CONFIGURAZIONE
	Da Command Prompt: cambio percorso fino alla corrispondente cartella gnconfig. 
	Per riconfigurare i parametri ethernet del dispositivo con MAC 00154200BB57, assegnando i seguenti dati
		ethcfg C 00:BB:57 10.77.200.31 T 255.255.255.224 3001 10.77.200.1
	Per riassegnare ramo e nodo
		ethcfg A 00:BB:57 4 99

	ESEMPIO #2 GET
	Da Command Prompt: cambio percorso fino alla corrispondente cartella gnconfig. 
	Per una completa mappatura dell'impianto, con profili GNet ed Ethernet;
		ethcfg G ff:ff:ff
	Fornisce, nell'ordine: ramo, MAC, IP, Subnet, Port, GateWay, Protocollo, GNet Address, Application (FW), Status

- Una volta completata l'inserimento dell'impianto GNet tramite GnConfig, occorre configurare
l'hardware collegato. Alla fine dei passaggi precedenti, verificare l'effettivo collegamento del terminale alla rete Ethernet tramite un Ping
- Menu a sinistra delle Opzioni:
	SEL.TUTTO	Imposta automaticamente i flag di tutte le caselle essenziali per la configurazione del terminale e relativi parametri
	CANCELLA	Deseleziona tutti i flag
	NINIT		Imposta al terminale o al gate l'identificativo
	NRSET		Reset del terminale
	COD		Cancella il firmware
	USR		Cancella i dati e quindi le transazioni
	SYS		Cancella i file di sistema gnet
	IP		Spedisce al terminale informazioni riguardanti l'indirizzo Ethernet, Gateway e Subnet Mask. Da usare SOLO per terminali tipo Karpos MXP250. Per utilizzare questa funzione bisogna impostare il Mac Address nella sezione parametri.
	NDWNL		Scarica l'applicativo (firmware)
	PNETW		Imposta i parametri della comunicazione

- Per inviare la configurazione al terminale, clicca su "Seleziona tutto", togliere la spunta a "IP" 
- Fare doppio clic sul nodo NODE__#00199

(*) Attenzione! Se il terminale � in Menu, non pinga e quindi la configurazione non pu� essere inviata. Premere pulsante rosso per tornare ai precedenti menu

- Nella barra delle informazioni appaiono i vari step di configurazione. Una barra di stato mostra l'avanzamento. Nel frattempo, il terminale si 'riavvia'. Se la procedura va a buon fine, appare la scritta "Configurazione del terminale Node__#00199 completata"
	
(*) Se qualcosa va storto, cliccare sul pulsante "Mostra Report" nel menu all'estrema sinistra


##MICRONCONFIG

� CONFIGURAZIONE TECNOLOGIA TERMINALE

- Aprire MicronConfig e accedere con username micronunlock e password <hhddmmyyyy>
- A sinistra, espandere tutto l'albero. Appare in sequenza MRT, <SEDE>, <SERVIZIO>, <IMPIANTO>. Con un click destro su <Impianto>, scegliere 'Aggiungi Varco'.
- Varco: la descrizione deve essere nel formato AA_BBBB_CCC (dove AA sta per AC[accessi] o PR[presenze], BBBB � una descrizione del tipo di varco [es.uffici] e CCC � la tecnologia [es.MCT350]). Ogni varco deve avere solo UN terminale di presenze. Lasciare tutti gli altri parametri come da default, rimuovere gli zeri di troppo da 'codice varco' finch� non rimane 0001. Con un click destro su <Varco>, scegliere 'Aggiungi Terminale'.
- Terminale: la descrizione sar� uguale al varco, in questo caso, perch� c'� solo un terminale per questo varco. Anche in questo caso rimuovere gli zeri di troppo dal 'codice terminale'. I prossimi parametri sono:
	Tipo di terminale: Terminale Standard(...), Terminale base con KK, Terminale KK -> scegliere Terminale Standard
- Bisogna ora dire al terminale quale tecnologia di badge deve leggere. Andare su "Configurazione Testine" e in "Device di lettura" scegliere Device1:MIFARE (T1) (che significa tecnologia di prossimit�) e Device2:BadgeOnBoard (che significa strisciare il badge: in questo caso non la utilizzeremo).
- Cliccare su "Testina 1": si apre la maschera della Testina 1. Lasciare la spunta su "Presenze", mettere la spunta a "Salva su Database" e su "Entra" ed "Esce" per abilitare sia l'entrata che l'uscita su questo terminale. Salvare.
- Tornando sul Terminale, andare su "Abilitazioni": la spunta su Controlla Abilitazione fa s� che il terminale RISPONDA O NO a un badge. Se non ci fosse la spunta, ogni badge riceverebbe indiscriminatamente l'assenso dal terminale; se c'� la spunta, il terminale riceve le abilitazioni da Micronpass Web e discrimina il badge a seconda che possa ricevere l'assenso oppure no. Salvare.

(*) Il fatto di configurare la tecnologia della testina dovrebbe bastare per fare in modo che il terminale 'reagisca' al riconoscimento di un badge con tecnologia compatibile. Provare a passare un badge con chip Mifare: se 'Controlla Abilitazioni' � spuntato, il riconoscimento del badge dipender� da quale tipo di abilitazione � stata data al badge (per ora nessuna, quindi il terminale risponde negativamente), altrimenti il terminale risponder� comunque positivamente.

� PARAMETRI IMPORTANTI DEL SERVIZIO

- Dalla menu in alto, Parametri > MicronService 0001
- Alla voce "File di esportazione movimenti di timbratura presenze", scegliere il percorso completo del file presenze.txt che ricever� il log delle timbrature (v.sotto come leggerlo). Si consiglia di creare una cartella C:\MPW\Timbrature\ in cui salvarlo (siccome non � obbligatorio, d'ora in poi ci riferiremo a tale cartella come (Timbrature)).
- Alla voce "Tipo di esportazione movimenti di timbratura presenze", scegliere "WinattID" (v.sotto)
- Pi� in basso, alla voce "Numero file di esportazione presenze" mettere almeno 2 (si chiameranno 'presenze.txt' e 'presenze2.txt')
- Salvare.

� SALVARE E INVIARE LE MODIFICHE

Ogni cambiamento che non � ancora stato inviato ai terminali rende arancioni/rosse le voci nella visualizzazione ad albero a sinistra. Questo significa che i comandi sono stati salvati su MicronConfig, ma non ancora trasmessi e quindi non effettivi.

- Nella visualizzazione ad albero a sinistra, fare click destro sul servizio, mettere in "Inizio Manutenzione" e poi in "Fine Manutenzione". Il servizio "Service" passer� da rosso ad arancione. Tutte le voci sottostanti sono ancora arancioni, perch� i comandi sono stati modificati ma non ancora inviati.
- Scendendo nell'albero, fare click destro sul varco e cliccare su "Invia comandi di ripristino ai terminali". Confermare sulla maschera di avvertimento che si applicher� cos� un azzeramento delle memorie. Il display del terminale mostrer� "Memory Clear!"
- Per accelerare la procedura, fare di nuovo "Inizio Manutenzione" e "Fine Manutenzione" sul Servizio.

(*) NON si pu� inviare le modifiche se il servizio non � attivo! Attivare il btService da services.msc o aprire NoService e verificare che il terminale sia connesso. In caso contrario, anche solo "Inizio Manutenzione" dar� un errore di connessione.

� AGGIUNGI TESTINE DI LETTURA A UNA CENTRALINA

Le tre testine di lettura collegate alla centralina del terminale presenze MCT sono valide solo per acquisizione di accessi. Le configureremo tutte e tre, assegnandole a tre diversi varchi, e poi daremo a un badge delle abilitazioni particolari su ciascuna di esse.

HARDWARE
Le tre testine del kit di dimostrazione sono gi� collegate via lockbus alla centralina del terminale presenze MCT.

GNCONFIG
Le testine non hanno indirizzo IP, perci� saranno riferite al nodo preesistente, di cui abbiamo gi� caricato le informazioni di rete su GnConfig.
 Dal punto di vista della rete, rappresentano ancora il nodo 99 del ramo 001 e quindi saranno identificate dal nodo gnet #00199.

MICRONCONFIG
- Dallo stesso impianto, click destro e Aggiungi Varco. Nominarlo ad es. AC_LOGISTICA_KK. Salvare.
- Su quel varco, click destro e Aggiungi Terminale. Nominarlo in maniera uguale. Rimuovere gli zeri di troppo dal codice terminale (devono essere solo quattro cifre). Selezionare "Terminale KK". In basso, scegliere "Numero KK" pari a 1,2 o 3. Salvare.
	(*)Il "Numero KK" determiner� quale delle tre testine stiamo configurando. 1=KK701, 2=KK801, 3=KK601

- Configurazione Testine > Device1:Mifare, Device2:disabilitata
	(*) Ricordarsi di assegnare la tecnologia corretta. Se non si trattasse di Mifare, l'altra tecnologia di lettura di prossimit� � TAG.
- Testina1: Solo Accessi. Salvare.
- Click destro su Servizio: Inizio-Fine Manutenzione
- Click destro su Varco 0002: Invia Comandi di ripristino ai terminali 
	(*) Il nuovo varco � apparso nel menu a tendina del NoService
	(*) Mentre il terminale MCT ha il display blank, la testina mantiene un colore rosso durante tutta la fase di invio dei comandi di ripristino

- Click destro su Servizio: Inizio-Fine Manutenzione
- Dopo qualche minuto, la testina di lettura corrispondente al Numero KK inserito sar� ONLINE. Verificare che sulla testina non sia pi� attiva la luce rossa.

MICRONPASS WEB, MICRONSIN WEB
La nuova testina configurata � vista come un nuovo varco. E' possibile abilitare un badge per il terminale MCT ma non per la testina, o viceversa, oppure per entrambi.

Procedere con la configurazione delle altre testine come altri varchi. In questo caso, si sono messi nomi casuali ai varchi e alle testine, precisando se presenze o accessi, il luogo dove � localizzato il varco, il nome del terminale di lettura e la tecnologia di lettura. L'albero completo su MicronConfig appare come segue:

	MRT
	  0001 SEDE
	    0001 SERVIZIO
	      0001 IMPIANTO
		0001 PR_UFFICIO_MCT350(MIFARE)
		  0001 PR_UFFICIO_MCT350(MIFARE)
		0002 AC_LOGISTICA_KK701(TASTIERINO_MIFARE)
		  0002 AC_LOGISTICA_KK701(TASTIERINO_MIFARE)
		0003 AC_INFERMIERIA_KK801(DISPLAY+TASTIERINO_MIFARE)
		  0003 AC_INFERMIERIA_KK801(DISPLAY+TASTIERINO_MIFARE)
		0004 AC_CED_KK601(SOLO LETTORE_UNIQUE)
		  0004 AC_CED_KK601(SOLO LETTORE_UNIQUE)


� AGGIUNGI ATTUATORI A UNA CENTRALINA

Per dire alla centralina che gestir� degli attuatori (es. KX50):
- Micronconfig > Centralina > Ingressi/Allarmi > MultiI/O
- Premere "+" per aggiungere il 1�
- Premere "Su" e poi premere "+" per aggiungere il 2�, e cos� via fino al numero desiderato di attuatori

Per dire a ciascuna testina a quale attuatore dovr� collegarsi:
- Micronconfig > Testina > Configurazione Testine > Testina 1
- Spunta su "Entra" o "Esce" a seconda della funzione
- Premere su "Out" > Digital Out > Assegnare l'attuatore corrispondente e dare SALVA
- Mettere spunta su "Impulsivo" e dare un tempo di impulso (di solito, qualche secondo) e dare SALVA a tutto


## NOSERVICE

Il tool NoService � il tool di diagnostica corrispondente a ogni BtService (MicronService). Serve a comunicare la configurazione e i parametri dal server al singolo dispositivo. Tramite NoService (accessibile in MPW\NoService\btNoService.exe) � possibile avere un riscontro grafico del traffico di comandi che passano dal server a MicronConfig e da MicronConfig alla rete GNet, cio� ai terminali stessi. In alto si trovano i comandi in ingresso da parte del server ("Comandi in ingresso (TCP/IP)"), mentre in basso i messaggi in uscita da MicronConfig ai terminali ("Messaggi in uscita (GNet)").

(*) L'apertura di NoService durante il processo di configurazione delle testine su MicronConfig permette di vedere in real-time l'effettuarsi della procedura. 
(*)Il servizio di diagnostica pu� essere usato solo quando il servizio MicronService NON � attivo. Pertanto, aprire i Servizi (services.msc) e arrestare btService. In questo modo si potr� aprire NoService (lo dice il nome stesso!)

- I primi messaggi in uscita ("Collegato" e "Invio PC On(0)") mostrano che il servizio ha riconosciuto il dispositivo.
- In corrispondenza del comando "Inizio Manutenzione" su MicronConfig, appariranno nei Comandi in Ingresso i seguenti comandi. "Connesso on Config port", "Comando Config Inizio Manutenzione", "Disconnesso on Config Port"; allo stesso modo, cliccando su "Fine Manutenzione" su MicronConfig, apparir� "Connesso on Config port", "Comando Config Fine Manutenzione", "Disconnesso on Config Port".
- Quando si clicca su "Invia comandi di ripristino ai terminali", su NoService apparir� nei Comandi in Ingresso "Connesso", "Comando Azzeramento Memorie", "Disconnesso"; nei Messaggi in Uscita, "Azzeramento Memorie". Un nuovo comando di Inizio-Fine Manutenzione far� apparire tra i Messaggi in Uscita i seguenti: in sequenza 
	"Risposta a crypto key", 
	"Crypto key", 
	"Richiesta Setup accessi", 
	"Risposta a richiesta setup accessi", 
	"Invio Configurazione terminale", 
	"Invio configurazione out", 
	"Invio Configurazione In", 
	"Invio tabella festivit�", 
	"Invio tabella fasce orarie", 
	"Invio tabella abilitazioni", 
	"Invio tabella passback", 
	"Invio tabella calendari", 
	"Invio tabella causali", 
	"Invio tabella schedulazioni", 
	"N.Messaggi dati", 
	"Monitor Testine", 
	"Risposta a Monitor testine".

(*) Se non muove il culo, dare un altro Invio-Fine Manutenzione per velocizzare.

Il Terminale ha ricevuto tutte le informazioni. Passare un badge Mifare sul lato 'Entra' per verificare: il terminale, a prescindere dalla sua reazione, dovrebbe riconoscere il badge in ogni caso.

(*) E' ovvio che il terminale riconoscer� solo il badge dotato della tecnologia di lettura compatibile con quella configurata in "Configurazione testine". Usare un badge con tecnologia Unique su un lettore Mifare non provocher� la minima reazione da parte del terminale, perch� non sono tecnologie compatibili.
Se "Controllo Abilitazioni" su MicronConfig era stato spuntato, apparir� su display "Badge non trovato" perch� non esiste in memoria alcuna abilitazione; viceversa, se non era stato spuntato, il terminale mostrer� "Entrata OK!!!".

(*) Si noti la barra blu etichettata come 'Timbrature' in alto. Questa tiene conto di quante timbrature sono state effettuate dall'ultimo azzeramento di memorie

Conviene spuntare "Controllo Abilitazioni", cos� si potranno modificare sull'applicativo Web e vederne l'immediato riscontro in base alla reazione del terminale. V.Sotto per vedere come abilitare un badge al transito.


� VERIFICARE LA TIMBRATURA

Per verificare che le timbrature siano state registrate, vedere il contenuto di C:\MPW\(Timbrature)\presenze.txt. Il formato in cui avviene la registrazione � chiamato WinattID ed � costituito, in questo caso, da 28 cifre. Ad es:

	001 (varco) 009B3781B3 (codice badge) 0 (verso) 0000 (causale) 2605151028 (Data e ora)

Esistono altri modi per verificare se il terminale funziona, nel caso in cui la timbratura per errore NON venisse scritta:
	+ C:\MPW\NoService\Debug_0001.txt: log delle comunicazioni tra servizio e terminale
	+ C:\MPW\MicronUtility: programma client, non web, solo per impianti presenze. Accedere con micronunlock, <hhddmmyyyy>
	+ su browser, usare MicronSin Web (v.capitolo)




# MICRONPASS WEB
============================================================================================================================================

Dopo aver installato il software e configurato il terminale MCT, possiamo procedere con il caricamento delle anagrafiche e delle abilitazioni. Dopo aver inserito dei nominativi e dei badge, assegneremo gli uni agli altri e diremo al software quali badge possono accedere e quali no. Il passo successivo sar� di collegare alla centralina del MCT altre testine, corrispondenti ad altri varchi.
Aprire quindi il browser e nella barra degli indirizzi digitare <indirizzomacchina>/mpassw. Si aprir� la home page e il menu principale a sinistra.

(*) E' possibile associare a un badge diversi tipi di nominativi: dipendente, visitatore e esterno.

(*) Per ulteriori informazioni, fare riferimento al Manuale Utente di Micronpass Web.


� CREA UN BADGE

- Dalla Home Page, premere su Badge e Chiavi > Gestione Badge > Aggiungi Badge
- I dati da inserire sono i seguenti:
	+ Codice identificativo: viene assegnato automaticamente se lasciato uguale a 0, altrimenti personalizzabile. NON � il codice associato alla tecnologia del badge, ma un codice identificativo del badge all'interno dell'applicativo web. Per facilit�, si pu� scrivere il codice numerico scritto sul badge stesso.
	+ Codici: sono i codici di tecnologia del badge. Questo codice si pu� ottenere in vari modi:
		+ Passare il badge sul terminale perch� venga registrata la timbratura. Aprire C:\MPW\(Timbrature)\presenze.txt : su di essa si pu� leggere il codice del badge.
		+ Acquisirlo e assegnarlo a un nominativo direttamente tramite MicronBadge o il lettore USB ACR122U.
		
	(*) Nel nostro caso, il codice del badge va inserito in TAG RF FULL.


� CREA DIPENDENTE E ASSEGNA BADGE

- Nella Home Page, premere su Dipendenti > Dipendenti > Aggiungi Dipendente
- Inserire i seguenti dati fondamentali:
	Azienda Interna
	Codice: viene assegnato automaticamente se lasciato uguale a 0, altrimenti personalizzabile.
	Nome, Cognome, Data di Nascita
	Gruppo e profilo: v.sotto - Per il momento lasciare "Personale"
- Cliccare OK e salvare le impostazioni
Notare come, nella pagina che segue, sia presente una striscia rossa con su scritto "Manca badge, abilitazione". Provvederemo ora ad assegnare al nominativo un badge e ad assegnare un'abilitazione.
	
(*) Un nominativo privo di badge e abilitazione � fondamentalmente inutile.

- Posizionare il cursore sopra "Comandi": appare un Menu a tendina. Selezionare "Badge" e poi "Assegna badge".
- Dalla pagina Assegna Badge � possibile scegliere un badge dal menu a tendina. Come da paragrafo precedente, � presente solo un badge. 
- Ricordarsi la spunta su "Attiva badge" (altrimenti l'assegnazione � fatta, ma inutile perch� il badge non funziona). Questo perch� un nominativo pu� avere pi� badge assegnati, ma solo uno di essi pu� essere attivo.
- Tornare indietro, puntare di nuovo su "Comandi" e selezionare "Abilitazioni". Notare come l'abilitazione sia segnata come "Disattivata", la validit� come "Non definita" e il Profilo � mancante.
- Un'abilitazione pu� essere 
	Normale: � un profilo di default, che pu� essere Personale o di Gruppo
	Eccezionale: � un profilo di abilitazione aggiuntivo rispetto a quello normale, per casi speciali

	
(*) Per esempio: il mio profilo Normale � 07:00-20:00 da Domenica a Gioved�, ma per un'esigenza particolare devo poter accedere ogni Sabato dalle 09:00 alle 17:00 ogni sabato per un mese. In questo caso � utile creare un profilo Eccezionale per ogni sabato di quel mese, che si aggiunger� al profilo Normale. Alla fine del periodo speciale, il profilo Eccezionale si disattiver� automaticamente.

- Cliccare su "Abilitazione Normale" e definire un periodo di validit�. 


� WIZARD SOSTITUZIONE BADGE

I badge sostitutivi sono i badge 'jolly' per quelle testazze che si sono dimenticate il badge a casa: solitamente sono adibiti a dipendenti ed esterni. 
- Wizard Sostituzione Badge > Cerca cognome (inserire cognome) > Sostituzione > Scegliere il badge da assegnare alla persona
Per deassegnare: cerca cognome (inserire cognome) > Restituzione


VISITATORI
-----------------------------------------------

� CREA VISITATORE

- Visitatori > Aggiungi Visitatore
I dati obbligatori sono: nome, cognome, societ� e dipendente di riferimento; il software si ricorda, cercandolo da Elenco, dei visitatori che gi� sono passati, e ne mantiene le informazioni.
I dati aggiuntivi sono: visitatore 'giornaliero', assegnazione badge (che permette, col lettore USB, di assegnare automaticamente un badge da visitatore)

(*) Se il modello di visitatore, anche se configurato e salvato nei modelli di visitatori, non � visibile nel menu a tendina dalla voce "abilitazione" durante la creazione di un visitatore, � perch� il modello non � completamente configurato: fare attenzione che il modello sia completo in termini di periodo di validit�, fasce orarie e varchi/gruppi di varchi.

Creazione Campi Programmabili: MicronConfig > Tabelle > Campi Programmabili


LOGS
-----------------------------------------------

A disposizione in \MPW\Micronpass\logs

	(*) Per errore "Il provider 'Microsoft.Jet.OLEDB.4.0' non � registrato nel computer locale", andare sulle Impostazioni Avanzate dell'Application Pool ed abilitare le applicazioni a 32-bit


GESTIONE EMERGENZE
-----------------------------------------------
In caso di "errore fatale scrittura log", fare attenzione che su MicronConfig > Parametri > MicronPass:
	- Campi aggiuntivi gestiti in anagrafica dipendenti: Reparto
	- Campi aggiuntivi gestiti in anagrafica esterni: Reparto


CONFIGURAZIONE VARCHI
------------------------------------------------

(*) FASCE DI SBLOCCO
Serve a mettere temporaneamente in Emergenza il varco selezionato, cos� che non sia necessaria la timbratura per entrare

- Inserire la descrizione del varco nel Filtro oppure sceglierlo dalla lista ottenuta con Elenco
- Cliccare sul Modifica
- Su "Fascia di sblocco", selezionare la fascia oraria - tra quelle preconfigurate - secondo la quale si vuole che il varco sia sbloccato
- (ugualmente, su "Fascia di blocco", selezionare la fascia orarie - tra quelle preconfigurate - secondo la quale si vuole che il varco sia bloccato)
- Dare conferma su OK: il servizio manda il comando "Invio configurazione terminale"
- Le testine rimangono con luce verde fissa, la timbratura � impedita: l'out � messo in stato attivo costante (cio� la porta � sempre aperta)

	NOTE SULLE FASCE DI SBLOCCO E BLOCCO
	La funzione di fascia di sblocco  � attiva solo per una determinata tipologia di centraline che hanno i seguenti  firmware:
		- 2.3E,  2.3P , 2.3S,  2.3V, 2.3X, tutte le versioni 2.4, tutti i terminali di nuova produzione di tipo ARM
	Mentre la funzione di fascia di blocco  non � stata implementata a livello firmware ma solo prevista come funzionalit� software.
	In alternativa si potrebbero utilizzare i comandi schedulati del micronpass, per definire orario di inizio e  fine attivazione di un certo out di un dispositivo (MXP o KX), sul quale andrebbe fatto un  ponticello  su un determinato ingresso, attraverso il quale si andrebbe ad attivare la funzione di  antiintrusione per tutti i lettori  appartenenti a  quella determinata centralina, per i quali si desidera bloccare la funzionalit� del lettore mantenendo la porta chiusa.
	In breve:  effettuare un intervento hardware per il ponticello, configurazione gestione antiintrusione dei varchi coinvolti, configurazione comandi schedulati. 
	Il limite di questa funzione � l�impossibilit� di limitare il blocco, solo per certi varchi appartenenti alla stessa centralina, tra quelli potenzialmente bloccabili.
	Altra opzione � quella di implementare a livello firmware la funzionalit� richiesta con la medesima modalit� di gestione per le fasce di sblocco.

Configurazione ARM:
- Ricordati di abilitare l'emergenza varchi sulla serratura corrispondente! Basta che sotto il varco ci sia almeno il KX che si occupa di fare l'out e che abbia la serratura associata



ESERCIZI di USO DI MICRONPASSWEB
------------------------------------------------
- Crea un Dipendente, assegnagli un badge e abilitalo solo per il lettore MCT
- Crea un gruppo di varchi con tutte le testine e il lettore, poi un altro gruppo con varchi a scelta
- Verifica che le testine di lettura hanno tecnologie diverse, quindi crea un badge Unique che viene letto solo da una testina ma non dalle altre
- Crea un Visitatore, legalo a un Dipendente di Riferimento, assegnagli un badge e abilitalo solo per una testina. Poi deassegna il visitatore.
- Crea un Modello di Visitatori, poi crea un nuovo visitatore, assegnagli un badge e dagli le abilitazioni del modello creato
- Crea un'Azienda Esterna, poi crea un Collaboratore Esterno e assegnagli un badge e un gruppo di varchi
- Usa il Wizard Sostituzione Badge per assegnare un badge sostitutivo a un dipendente gi� esistente, e poi fattelo restituire


RIPRISTINO DATI STORICI
------------------------------------------------
La funzionalit� consiste nel creare un database MRTBAK che funga da backup per tutti i record cancellati dal MicronClear.
Il database MRTBAK, contrariamente al MRT, NON viene ripulito dal servizio MicronClear, quindi cresce a dismisura.

Attivare la funzionalit�:
	- In fase di creazione del database: MicronStart > CreaDB/Upgrade > Attiva database di backup =1 	% Creazione di MRT e MRTBAK
	- MicronConfig > Parametri > MicronClear > Abilitazione backup =1					% Abilitazione del database MRTBAK
	- MicronConfig > Parametri > MicronClear > Percorso di esportazione file di testo di backup = [path]	% File di testo log backup

Funzione Ripristino Dati Storici:
	Prima di ripristinare: Ferma i servizi e fai un backup sia di MRT sia di MRTBAK
	Per ripristinare dati:
		- Micronpass Web > Ripristino Dati Storici > Ripristino
			- Tabella:
				Transiti 		% T37ACCTRANSITI
				Storico badge 		% T59COMSTORICOBV
				Storico allarmi 	% T66ACCSTORICOALLARMI
				Intrusione indesiderati % T78ACCINTRINDES
				Log attivit� utenti 	% T105COMUSERSLOG
			- Periodo		% Inserire periodo di cui ripristinare i dati
			- Giorni di validit�	% Permette di specificare per quanti giorni i dati ripristinati possono rimanere in MRT, a prescindere dalla parametrazione del MicronClear; alla scadenza, i dati verranno cancellati di nuovo dal MicronClear
	Per cancellare immediatamente i dati ripristinati:
		- Micronpass Web > Ripristino Dati Storici > Azzeramento	


UTENTI E AUTENTICAZIONE
------------------------------------------------

(*) PASSWORD E LEGGE 196/03 
(valida dalla 4.5.0)
La legge 196/03 richiede la compliance con una serie di vincoli legati alla privacy e alla sicurezza delle password salvate su database.
Per attivare la funzionalit�:
	T05COMFLAGS > COMF/196COMP/1	% Conviene che gli utenti abbiano gi� settata una password che risponde alle restrizioni di cui sotto, *prima* di attivare la flag
Caratteristiche della funzionalit�:
	- Tentativi di accesso: 3 tentativi di accesso al massimo, dopo i quali l'account utente verr� bloccato e potr� essere sbloccato solo da un altro utente con l'autorizzazione alla Gestione Utenti
	- Scadenza della password: in corrispondenza della creazione di una password, � possibile definire la scadenza dopo la quale � richiesto il rinnovo; con questa flag attiva, non � possibile superare la durata di una password oltre i 90 giorni
	- Rinnovo password: con questa flag attiva, in fase di creazione della password per la prima volta si avr� il cambio password al primo accesso obbligatorio e non disabilitabile
	- Regole password: nella creazione o nel rinnovo di ogni password, la password dovr� (valgono tutti i vincoli contemporaneamente):
		Essere lunga almeno 8 caratteri
		Contenere almeno 1 carattere alfabetico maiuscolo (A-Z)
		Contenere almeno 1 carattere alfabetico minuscolo (a-z)
		Contenere almeno 1 carattere numerico (0-9)
		Contenere almeno 1 carattere non alfanumerico (!#@...)
		Non deve contenere il nome utente (e il nome utente non pu� contenere la password)
		Non deve coincidere con le ultime tre password salvate per quell'utente	
	- Nuovi utenti: non � possibile creare utenti con un codice gi� utilizzato in passato

(*) AUTENTICAZIONE DI WINDOWS
Prerequisiti:
Autenticazione di Windows installata tra le funzionalit� IIS

	- MPW\Micronpass > Propriet� > Sicurezza > inserire gli utenti desiderati
	- C:\inetpub\wwwroot > Propriet� > Sicurezza > inserire gli utenti desiderati
	- Micronpass Web > Utenti > Gestione Utenti > inserire ogni singolo utente, con lo stesso username inserito in Windows Authentication (deve essere un utente dipendente)
		(*) La password inserita durante la creazione dell'utente, pur essendo un campo obbligatorio su Micronpass Web, verr� ignorata dal processo di autenticazione; � comunque un buon backup nel caso di recupero dell'utente
	- Modificare il file MPW\Micronpass\web.config nella seguente maniera (vanno modificate le sezioni AUTENTICAZIONE e AUTORIZZAZIONE)

	    <!--  AUTENTICAZIONE 
	          Questa sezione imposta i criteri di autenticazione dell'applicazione. Le modalit� supportate sono "Windows", 
	          "Forms", "Passport" e "None"

	          "None" Non viene eseguita alcuna autenticazione. 
	          "Windows" L'autenticazione viene eseguita da IIS (di base, classificata o integrata Windows) in base alle 
	           impostazioni relative all'applicazione. L'accesso anonimo deve essere disattivato in IIS. 
	          "Forms" Agli utenti viene fornito un form personalizzato (pagina Web) in cui immettere le proprie credenziali, per 
	           consentirne l'autenticazione nell'applicazione. Un token di credenziali di ogni utente viene memorizzato in un cookie.
	          "Passport" L'autenticazione viene eseguita tramite un servizio di autenticazione centralizzato
	           Microsoft che offre una singola procedura di accesso e servizi di profilo di base per i siti membri.
	    -->

   	<!--  AUTORIZZAZIONE 
	          Questa sezione imposta i criteri di autorizzazione dell'applicazione. � possibile consentire o negare l'accesso
	          alle risorse dell'applicazione in base all'utente o al ruolo. Il carattere jolly "*" indica "tutti", mentre "?" indica gli utenti anonimi 
	          (non autenticati).
      			<allow     users="[elenco di utenti separati da virgole]"
                	           roles="[elenco di ruoli separati da virgole]"/>
                  	<deny      users="[elenco di utenti separati da virgole]"
                             	   roles="[elenco di ruoli separati da virgole]"/>
	    -->

		- Sostituire le seguenti righe
	
			<authentication mode="Forms">
				<forms name=".mpassw" loginUrl="default.htm" protection="All" timeout="250" path="/" slidingExpiration="true" />
			</authentication>
	
		con le seguenti righe:
	
			<authentication mode="Windows" />
			<identity impersonate="false" />	
	
				(*) Per Micronsin Web, per versioni <7.50, mettere TRUE, altrimenti appare il seguente errore:
				mUser.LoadUserAbil: ritorno query vuoto SELECT * FROM (T21COMUTENTI U LEFT JOIN T26COMDIPENDENTI D ON (U.T21DIPENDENTE=D.T26CODICE) AND (U.T21CODAZIENDAINTERNA=D.T26CODAZIENDA)) LEFT JOIN T71COMAZIENDEINTERNE A ON (D.T26CODAZIENDA=A.T71CODICE) WHERE T21UTENTE='accessi'
	
		- Sostituire le seguenti righe
			<allow users="*" />
		con le seguenti righe	
			<deny users="?" />

	- IIS > Autenticazione > Autenticazione Windows = enabled
		* Disabilitare tutti gli altri tipi di autenticazione!
	- Micronconfig (utente installatore) > Parametri > Micronpass: Nome utente per utente installatore = (inserire un'utenza esistente)
	- Micronpass Web dev'essere nei siti Intranet di Internet Explorer
		Chrome eredita le impostazioni di Internet Explorer
		Edge eredita le impostazioni di Internet Explorer
		Firefox potrebbe ereditare le impostazioni di Internet Explorer se precisato durante l'installazione
	- Per provare: aprendo Micronpass Web, non deve apparire la maschera di login
		* Se appare l'errore UTENTE NON CONFIGURATO, significa che il login con autenticazione di Windows funziona, ma l'utente corrente con cui si � loggati su Windows non esiste tra gli utenti di Micronpass Web


(*) ERRORE 401 IN AUTENTICAZIONE GETWSLOGIN
11-02-2020 09:07:43:154 cls_user.GetWSLogin: System.Net.WebException: The request failed with HTTP status 401: Unauthorized.
11-02-2020 09:07:43:230 cls_user.GetWSUserKey: System.Net.WebException: The request failed with HTTP status 401: Unauthorized.

	- Disabilitare il parametro "Abilitazione webservice" in MicronConfig > Parametri > Micronpass


REPORTS
------------------------------------------------

(*) NON SI VEDONO I REPORT "SENZA PERSONALIZZAZIONE"
Ogni report mostra solo quelli personalizzati

	Micronconfig > Parametri > Micronpass > Flag utilizzo report non personalizzati = [s�\no]

(*) CARICAMENTO REPORT NON RIUSCITO
25-10-2017 15:25:54:721 ctr_viewreport.doReport: CrystalDecisions.Shared.CrystalReportsException: Caricamento report non riuscito. ---> System.Runtime.InteropServices.COMException: � stato raggiunto il limite massimo per i processi di elaborazione dei report configurato dall'amministratore di sistema.

	In realt� non riguarda esclusivamente i report in Excel ma tutti i formati. Pu� essere risolto cambiando la seguente chiave di registro:
	HKEY_LOCAL_MACHINE\SOFTWARE\SAP BusinessObjects\Crystal Reports for .NET Framework 4.0\Report Application Server\InprocServer = <default a 300, alzare a 10000>
	Attenzione perch� in caso di report con moltissimi record, potrebbe essere notevolmente oneroso per i processori del server.

(*) ERRORE NON PREVISTO DEL DRIVER DEL DATABASE ESTERNO 
25-10-2017 15:30:09:988 mod_excel.XLCreator: System.Data.OleDb.OleDbException (0x80004005): Unexpected error from external database driver (1).
25-10-2017 15:30:09:990 ctr_elreports.PrepareReport: System.Threading.ThreadAbortException: Thread was being aborted.

	Dovuto a una patch di sicurezza emessa da Microsoft il 11-10-2017.
	- Se NON si avesse l'autorizzazione a modificare chiavi di registro sul server, allora:
		- Rimuovere l'aggiornamento KB4041676 (nome per Windows 10)
	- Se invece si avesse l'autorizzazione a modificare chiavi di registro sul server, allora:
		- Rimuovere temporaneamente la patch di sicurezza
		- Copiare il file C:\Windows\SysWOW64\msexcl40.dll in una nuova cartella (p.e. C:\msexcl\msexcl40.dll)
		- Variare la chiave di registro HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Jet\4.0\Engines\Excel\Win32 per farla puntare alla nuova locazione (C:\msexcl\msexcl40.dll, di default punta a C:\Windows\SysWOW64\msexcl40.dll.
		- Riapplicare la patch di sicurezza


COMPLIANCE AL GDPR ("General Data Protection Regulation")
----------------------------------------------------------
Dalla versione 7.4.46 Micronpass pu� essere compliant al GDPR su scelta del cliente finale (della serie, la possibilit� c'�, bisogna solo attivarla)

REQUISITI:
>=$mrt7412
alternativamente >=Micronpass7446, Micronconfig>=7414

CONFIGURAZIONE:
Def. Anonimizzazione: variazione dei dati in modo che non possano pi� essere effettivamente ricondotti alla persona fisica (es. sostituire il Nome e Cognome con una stringa fissa)
	NB: L'anonimizzazione NON comprende il codice matricola
Def. Cancellazione anagrafica: rimozione dei dati personali dell'anagrafica, pi� tutti quelli ad essa collegati (es. profilo di accesso, parametrazione dell'utente collegato, ecc.)
Def. Cancellazione dati storici: rimozione dei dati storici dell'anagrafica (es. transiti, storico assegnazione badge, attivit� registrate come utente dipendente, ecc.)

- MicronConfig > Tabelle > Parametri Generali (Flags) > GDPR > Modalit� GDPR Dipendenti =
	0-Cancellazione anagrafica					% "Normale" cancellazione delle sole anagrafiche, NON compliant alla normativa
	1-Cancellazione anagrafica e dati storici			% Cancellazione dell'anagrafica e di tutti i dati storici
	2-Cancellazione anagrafica e anonimizzazione dati storici	% Cancellazione dell'anagrafica e anonimizzazione dei dati storici (v.parametri successivi)
	(*) Attenzione: impostare 0-Cancellazione anagrafica (che cancella i dati anagrafici) rende poi impossibile eliminarne i dati storici, qualora si volesse cambiare idea in un secondo momento
- MicronConfig > Tabelle > Parametri Generali (Flags) > GDPR > Modalit� GDPR Esterni =
	[idem a sopra per esterni]
- MicronConfig > Tabelle > Parametri Generali (Flags) > GDPR > Modalit� GDPR Visitatori =
	[idem a sopra per visitatori]
- MicronConfig > Tabelle > Parametri Generali (Flags) > GDPR > GDPR testo anonimizzazione	% Stringa da utilizzare per rendere i dati anonimi

UTILIZZO:
- Micronpass Web > Eliminazione dati selettiva > [sel.matricola/utente di cui eliminare i dati]		% Funzionalit� soggetta ad autorizzazione
	(*) La stessa maschera � raggiungibile da ogni maschera di elenco matricole/utenti in cui si clicchi su Cancella (in quel caso i campi liberi sono precompilati)
	(*) RICORDARSI di impostare il parametro di sostituzione del dipendente di riferimento!
		- Creare un utente 'diprif' senza autorizzazioni
		- Creare un dipendente "Diprif(NON-CANCELLARE)" nell'azienda Utilit�
		- Utenti > Gestione utenti > diprif > modifica
		- Dip.Rif. > Dipendente di riferimento di default per funzione esterni > [inserire il dipendente Diprif di cui sopra]
		- Dip.Rif. > Dipendente di riferimento di default per funzione visitatori > [inserire il dipendente Diprif di cui sopra]
		- Micronconfig > Parametri > Micronpass > Utente da utilizzare per dip. di riferimento di default = [inserire l'utente diprif]
			(*) Se si cerca di eliminare un utente inserito in questo parametro, verr� fuori un ERRORE FATALE
	
NB: Se si vuole comunque mantenere i dati storici, si consiglia di non eliminare mai le anagrafiche e lasciare che la pulizia venga effettuata dal MicronClear

GDPR CLEANER:

Se un'anagrafica viene cancellata dal Micronpass Web prima dell'applicazione delle funzionalit� GDPR, � ovvio che tutti i suoi record storici (transiti, assegnazione badge, ecc.) rimangono nel database.
Potrebbe occuparsene il MicronClear, che per� non � in grado di lavorare come le cancellazioni usate dalle funzionalit� GDPR del Micronpass Web.
Per questo nasce il GDPR Cleaner, che si pu� usare per le seguenti modalit�, in accordo coi parametri generali messi sul MicronConfig:
	1) Cancellare i dati delle matricole gi� cancellate dall�anagrafica MRT, ma che sono ancora presenti nelle tabelle storiche
	2) Cancellare i dati di un elenco di matricole, fornite attraverso un file CSV (ad es. per fare pulizia rispetto ad una serie di matricole non pi� usate in HR, ma non ancora cancellate da MPW)

	Utilizzo:
	- Selezione modalit� cancellazione > Pulizia matricole cancellate ancora presenti nelle timbrature 	% Se si vuole cancellare dalle tabelle storiche le matricole cancellate
	- Selezione modalit� cancellazione > Pulizia matricole da file CSV					% Se si vuole cancellare le matricole da un file CSV
		- [Browse file CSV]
	- Info dati sulla cancellazione			% Mostra in maniera puntuale le singole matricole e le corrispondenti informazioni che saranno cancellate
		- [� possibile spuntare le singole matricole]
		- [� possibile filtrare per Azienda Interna cliccando sull'header della colonna corrispondente]
		- [� possibile filtrare per Tipo Matricola cliccando sull'header della colonna corrispondente]
	- Verifica dati			% Effettua una verifica sul database per incrociare i dati prima della pulizia
	- Start				% Fa partire il processo di pulizia, mostrando una barra di progressione, il contatore delle matricole cancellate con successo e il contatore degli errori
	- Visualizza log		% Permette di analizzare i risultati della procedura: si vedono le matricole cancellate e in un file CSV di output si vede l'elenco degli errori
		app.log					% Tutte le attivit� del programma
		err.log					% Errori incontrati dal programma durante la cancellazione
		DeleteError_YYYYMMDD_HHmmSS.CSV		% Elenco degli errori in formato CSV (nel formato CodTipoMatricola;DescrTipoMatricola;Azienda;Nome;Cognome;CodiceErrore;DescrErrore)

	(*) Se selezionata una modalit� differente da "Cancellazione anagrafica e dati storici", eseguendo nuovamente la funzione di verifica dei dati dopo l�esecuzione, sar� riproposta la stessa lista di matricole.
	Non si tratta di un errore del programma, procedendo senza la cancellazione dei dati storici, non verranno rimossi i codici di matricola dalla tabella dello storico delle timbrature per cui la query di ricerca restituir� sempre il medesimo elenco.


MICRONPASS MVC
------------------------------------------------
Modulo disponibile da $mrt758, prima versione rilasciata: 7.5.0
Nuova directory virtuale /MicronpassMVC
Prende il nome dal Framework ASP.NET MVC, dove "MVC" sta per Model-View-Controller, un pattern architetturale molto diffuso nello sviluppo dei sistemi software, in grado di separare la logica di presentazione dei dati dalla logica di business.
Il framework prende il nome dalla sua struttura:
	- Model: il modello dei dati, le entit� e le relazioni tra esse
	- View: la vista, il codice HTML che crea l'interfaccia utente
	- Controller: il codice di controllo che contiene la logica applicativa del programma
Il framework MVC si basa su HTML5, quindi NON � compatibile con Internet Explorer.

Demo:
https://79.11.21.211:8183/MicronpassMvc/
http://79.11.21.211:8081/MicronpassMvc/
	username:	admin
	password:	admin
		username:	demo
		password:	demo

Elenco dei widget sviluppati:
	� WidgetWatch: orologio
	� WidgetVisitorsOfDayCount: mnumero di visitatori del giorno
	� WidgetVisitorBookingsCalendar: vista calendario delle prenotazioni visite
	� WidgetTimeslot: grafico distribuzione oraria delle visite
	� WidgetPresenceByType: Grafico distribuzione presenti per titpo matricola
	� WidgetNextVisitsOfDay: elenco prossime prenotazioni visite del giorno
	� WidgetLastTransits: elenco ultimi transiti
	� WidgetAssignedBadgeCount: numero di badge assegnati
	� WidgedYoutubePlayer: visualizzazione di video youtube




ERRORI MPW
------------------------------------------------

(*) ERROR READING PARAMETERS
Errore "Error reading parameters" OPPURE pagina login di Micronpass senza figure (in tentativo di login, dice 'Errore connessione database')

In Micronpass/logs/Mpwerr, appaiono le seguenti righe:
	
	22-10-2015 15:00:39:724 OpenConnection: Riprova connessione al db System.InvalidOperationException: The 'Microsoft.Jet.OLEDB.4.0' provider is not registered on the local machine.
	22-10-2015 15:00:39:927 OpenConnection: Riprova connessione al db System.InvalidOperationException: The 'Microsoft.Jet.OLEDB.4.0' provider is not registered on the local machine.
	22-10-2015 15:00:40:130 OpenConnection: Riprova connessione al db System.InvalidOperationException: The 'Microsoft.Jet.OLEDB.4.0' provider is not registered on the local machine.
	22-10-2015 15:00:40:333 OpenConnection: Riprova connessione al db System.InvalidOperationException: The 'Microsoft.Jet.OLEDB.4.0' provider is not registered on the local machine.
	22-10-2015 15:00:40:536 OpenConnection: Riprova connessione al db System.InvalidOperationException: The 'Microsoft.Jet.OLEDB.4.0' provider is not registered on the local machine.
	22-10-2015 15:00:40:739 OpenConnection: Errore apertura connessione al db System.InvalidOperationException: The 'Microsoft.Jet.OLEDB.4.0' provider is not registered on the local machine.

Questo errore dipende dal sistema operativo. In questo caso, IIS > Application pool > Access Control > Impostazioni Avanzate, mettere 'True' su 'Enable 32-bit app'. Riavviare application pool e riprovare ad aprire applicativo.


(*) ERRORE COULD NOT LOAD TYPE HHTPMODULE
Errore "Could not load type System.ServiceModel.Activation.HttpModule"

	Description: An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.
	Exception Details: System.TypeLoadException: Could not load type 'System.ServiceModel.Activation.HttpModule' from assembly 'System.ServiceModel.Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'

	Questo errore nasce dal fatto che spesso si installa l'IIS (e quindi ASP.NET) prima di installare il Framework 4.0, che serve appunto ad usare alcune funzionalit� dell'IIS. Per ripetere l'installazione delle ASP.NET manualmente, aprire cmd e usare il seguente comando:
	C:\Windows\Microsoft.NET\Framework\v4.0.xxxxx\aspnet_regiis -i

	Spiegazione di Microsoft Support:
	.NET Framework 4 prevede l'installazione affiancata con versioni precedenti di .NET Framework in un singolo computer. Se IIS era abilitato precedentemente nel computer, il processo di installazione per .NET Framework registra automaticamente la ASP.NET 4 con IIS. Tuttavia, se si installa .NET Framework 4 prima di abilitare IIS, � necessario eseguire lo strumento di ASP.NET per la registrazione di IIS per registrare .NET Framework con IIS e creare i pool di applicazioni che utilizzano .NET Framework 4. 

		(**) REGISTRAZIONE MANUALE ASP.NET
		Errore ...
		aspnet_regiis -ea	Rimuove gli script client per tutte le versioni di ASP.NET dalla sottodirectory aspnet_client di ogni directory di sito IIS. 

(*) ERRORE BC30560 EXTENSIONATTRIBUTE
Seguente errore su pagina web, sia aprendo da browser sia sfogliando da IIS:
Compiler Error Message: BC30560: 'ExtensionAttribute' is ambiguous in the namespace 'System.Runtime.CompilerServices'
Source File: InternalXmlHelper.vb

	� un errore di compilazione di Framework, verificare che l'app pool stia girando con la versione giusta
	- Pannello di Controllo > Strumenti di Amministrazione > IIS
	- IIS > Default Site Web > mpassw > [click destro] > Impostazioni Avanzate > Gestisci applicazione > Application Pool: [application pool accessi]
	- IIS > Default Site Web > msinw > [click destro] > Impostazioni Avanzate > Gestisci applicazione > Application Pool: [application pool accessi]
	- IIS > Pool di applicazioni > [application pool accessi] > [click destro] > Impostazioni di base
	- Verificare le "Versione .NET" e "Modalit� pipeline" per controllo compatibilit�
	- Dopo eventuali modifiche, riciclare [application pool accessi]


(*) APPLICATION POOL STOPPATO
Sull'IIS, 'Default Web Site' appare stoppato. Cercando di farlo partire, dice che � occupato da un altro processo oppure d� errore 404-Not Found.

	Selezionando Default Web Site > Bindings > Modifica Porta 80 (per es. in 81)

	Nell'aprire Micronpass Web, si dovr� poi scrivere localhost:81/mpassw (invece che localhost/mpassw)


(*) ATTIVARE IL LOG DI INTERNET EXPLORER
By default, Internet Explorer 7 (IE7) does not enable Application Compatibility Logging and hence there are no IE related events in event viewer. This is completely normal. 
Important This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see How to back up and restore the registry.
Follow these steps if you wish to enable IE logging in event viewer:  
	a.     Click �Start� and click �Run.�
	b.     Type �regedit.exe� and hit �Enter.�
	c.     Locate the following registry key:
		HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\Feature_Enable_Compat_Logging
	d.     Change the �iexplore.exe� value to �(DWORD) 1.� 
	e.     Exit registry editor.  
	Restart your computer. 


(*) OPERATION NOT YET IMPLEMENTED
Il report in PDF (solo in PDF) non si apre, rimane finestra bianca; il file .tmp viene scaricato ma non tradotto in pdf.
L'errore visualizzato in mpwerr � qualcosa tipo:
	Error in File C:\Users\sampleUser\AppData\Local\Temp\rptManger{DDEB2C17-C5FD-49C1-B7BF-57F30AB6636C}.rpt: Operation not yet implemented

	- Disinstallare Microsoft Windows Update KB3102429
	- Riavviare PC

(*) ERRORE 404: PAGE NOT FOUND oppure ERRORE 400: PAGE CANNOT BE DISPLAYED
� possibile che non stia risolvendo qualcosa nel percorso <nomemacchina>:<porta>/<directoryvirtuale>. Conviene fare una verifica sui Bindings del sito.

	NOTA: COSA SONO I BINDINGS
	I Bindings sono le 'coordinate' (IP, Porta, hostname) che identificano UNIVOCAMENTE un sito web all'interno di un web server. I Bindings servono a dirigere il traffico inviato al server verso il sito giusto: una volta che il DNS ha diretto il traffico verso il nostro server, intervengono i Bindings per ridirezionare quel traffico verso il sito appropriato.
	Quando una richiesta arriva al server, la prima cosa che cerca � la Porta: le due Porte pi� comuni sono 80 (HTTP) e 443 (HTTPS).
	Il secondo punto che una richiesta considera � l'Indirizzo IP; questo pu� essere gestito in varie maniere: se si hanno molti indirizzi IP da usare, allora � buon costume utilizzare un unico indirizzo IP per ogni sito; in ogni caso, � possibile usare lo stesso indirizzo IP per pi� siti se si sta pagando per ogni IP.
	Che succede se si condivide la stessa Porta e lo stesso indirizzo IP? Bisogna differenziare per Nome Host (hostname oppure hostheader): questo nome deve coincidere esattamente con quello usato nella richiesta. Se si sta cercando di raggiungere il sito www.google.com, allora bisogna avere www.google.com come Hostname. Se si sta cercando di raggiungere google.com, allora bisogna avere google.com come Hostname. I siti ovviamente possono avere pi� Hostname per compensare i vari alias o siti a cui si accede con nomi diversi.
	In parole povere, i Bindings legano o connettono la combinazione IP:Porta:Hostname al corrispondente contenuto nella cartella di C:\inetpub\wwwroot.

Verifica:
	- IIS > Siti > Default Web Site > mpassw > [click destro] Gestisci applicazione > sfoglia: quale indirizzo viene mostrato nella barra degli indirizzi (<nomemacchina>:<porta>/<directoryvirtuale>, coincide tutto con le impostazioni su IIS) ?
	- IIS > Siti > Default Web Site > [click destro] Modifica binding 
		TIPO: visualizza il protocollo per ogni binding del sito
		NOME HOST: visualizza il nome host, se disponibile, per ogni binding del sito
			(*) Attenzione quando si forza l'hostname
		PORTA: visualizza il numero di porta per ogni binding del sito
		INDIRIZZO IP: visualizza l'indirizzo IP per ogni binding del sito
			(*) Se non � specificato un indirizzo IP, nel campo indirizzo IP viene visualizzato un asterisco, che indica che il binding � per tutti gli indirizzi IP
		INFORMAZIONI DI BINDING: visualizza le informazioni di binding per i binding del sito che usano protocolli diversi da HTTP, HTTPS, FTP
		
	Configurazione di default per Default Web Site contenente mpassw & msinw: 
			Tipo: http
			Nome host: 
			Porta: 80
			Indirizzo IP: *
			Informazioni di binding:


(*) ERRORE NEL WEB.CONFIG
[ArgumentException: Parola chiave 'inital catalog' non supportata]
	
	Si tratta di un bug delle versioni di Micronpass Web che vanno dalla MRT740 alla MRT745.
	In pratica, il parametro "Abilita funzionalit� MRTCore" viene utilizzato lo stesso anche se impostato a False.
	Non c'� soluzione se non aggiornare il Micronpass Web ad una versione pi� recente.

(*) ERRORE IN MICRONPASS WEB
Server Error in '/mpassw' Application.
Input string was not in a correct format.
Description: An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code. 
Exception Details: System.FormatException: Input string was not in a correct format.
Source Error: 
An unhandled exception was generated during the execution of the current web request. Information regarding the origin and location of the exception can be identified using the exception stack trace below.
Stack Trace:
[FormatException: Input string was not in a correct format.]
   Microsoft.VisualBasic.CompilerServices.Conversions.ParseDouble(String Value, NumberFormatInfo NumberFormat) +385
   Microsoft.VisualBasic.CompilerServices.Conversions.ToBoolean(String Value) +219
[InvalidCastException: Conversion from string "" to type 'Boolean' is not valid.]
   Microsoft.VisualBasic.CompilerServices.Conversions.ToBoolean(String Value) +452
   mPassW.UpStart.ConfigureMrtCore(IAppBuilder app) +153
   mPassW.UpStart.Configuration(IAppBuilder app) +444
[TargetInvocationException: Exception has been thrown by the target of an invocation.]
   System.RuntimeMethodHandle.InvokeMethod(Object target, Object[] arguments, Signature sig, Boolean constructor) +0
   System.Reflection.RuntimeMethodInfo.UnsafeInvokeInternal(Object obj, Object[] parameters, Object[] arguments) +76
   System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture) +211
   System.Reflection.MethodBase.Invoke(Object obj, Object[] parameters) +35
   Owin.Loader.<>c__DisplayClass1.<LoadImplementation>b__0(IAppBuilder builder) +341
   Microsoft.Owin.Host.SystemWeb.OwinAppContext.Initialize(Action`1 startup) +1043
   Microsoft.Owin.Host.SystemWeb.OwinHttpModule.InitializeBlueprint() +119
   System.Threading.LazyInitializer.EnsureInitializedCore(T& target, Boolean& initialized, Object& syncLock, Func`1 valueFactory) +241
   Microsoft.Owin.Host.SystemWeb.OwinHttpModule.Init(HttpApplication context) +129
   System.Web.HttpApplication.RegisterEventSubscriptionsWithIIS(IntPtr appContext, HttpContext context, MethodInfo[] handlers) +571
   System.Web.HttpApplication.InitSpecial(HttpApplicationState state, MethodInfo[] handlers, IntPtr appContext, HttpContext context) +322
   System.Web.HttpApplicationFactory.GetSpecialApplicationInstance(IntPtr appContext, HttpContext context) +402
   System.Web.Hosting.PipelineRuntime.InitializeApplication(IntPtr appContext) +452
[HttpException (0x80004005): Exception has been thrown by the target of an invocation.]
   System.Web.HttpRuntime.FirstRequestInit(HttpContext context) +646
   System.Web.HttpRuntime.EnsureFirstRequestInit(HttpContext context) +159
   System.Web.HttpRuntime.ProcessRequestNotificationPrivate(IIS7WorkerRequest wr, HttpContext context) +778

	Nota: Micronsin Web invece funziona benissimo
	Verifiche:
		- IIS > Restrizioni ISAPI e CGI > Framework 4.0 > Consenti
		- C:\Windows\Microsoft.NET\Framework\v.4.X.XXX\aspnet_regiis.exe -i
		- Application Pool > Impostazioni avanzate > Attiva applicazioni a 32 bit = 'True'
		- Micronconfig > Parametri > Micronpass Web > "Abilita funzionalit� MRTCore" = 'True'	

(*) ERRORE HTTP 500.19 - INTERNAL SERVER ERROR 0x80070005
Impossibile accedere alla pagina richiesta perch� i dati di configurazione per la pagina non sono validi.

	Informazioni dettagliate sull'errore:
	Modulo: IIS Web Core
	Notifica: BeginRequest
	Gestore: Non ancora determinato
	Codice errore: 0x80070005
	Errore di configurazione: Impossibile leggere il file di configurazione a causa di autorizzazioni insufficienti
	File di configurazione: \\?\C:\MPW\Micronsin\web.config
	URL Richiesto: http://localhost:80/msinw/frm_home.aspx
	Percorso fisico: C:\MPW\MicronSin\frm_home.aspx
	Metodo di accesso: Non ancora determinato
	Utente accesso: Non ancora determinato

	Origine di configurazione: 	-1:
					0:

		Soluzione: Cartella MPW\Micronpass (o Micronsin) > Propriet� > Sicurezza > Aggiungere utenti "IUSR" e "IIS_USRS" con Controllo Completo; poi riciclare l'Application Pool

(*) ERRORE HTTP 500 - INTERNAL SERVER ERROR 
Http error 500, internal server error, code 0x00000000 for ASP

	Detailed Error Information:
	Module     ManagedPipelineHandler
	Notification       ExecuteRequestHandler
	Handler    PageHandlerFactory-Integrated-4.0
	Error Code     0x00000000
	Requested URL      ...
	Physical Path      ...
	Logon Method       Anonymous
	Logon User     Anonymous

		Possibili soluzioni:
		In realt� il log non mostra il fattore chiave che ha portato a questo errore 500, ma mostra solo un normale errore 500 di pipeline. Bisognerebbe abilitare la tracciatura delle richieste fallite, per avere visibiit� dell'errore chiave e del messaggio annesso.
		Questo link fornisce il metodo per abilitare la tracciatura delle richieste fallite per catturare l'errore dettagliato:
			https://www.iis.net/learn/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis
		Ora, siccome l'errore succede nell'IIS, probabilmente � associato alle permission. Questi passaggi potrebbero risolvere il problema anche senza avere l'errore dettagliato:
		1) Dai autorizzazione all'utente IUSR sulla cartella TEMP e su tutte le cartelle dell'applicazione web
		2) Imposta l'identity dell'Application Pool in modo che sia NETWORK SERVICE o LOCAL SYSTEM. Se vuoi usare APPLICATIONPOOLIDENTITY If you just want use applicationpoolidentity, you could try to grant permission for "apppool/<myapppoolname>".
		3)Enable allow 32-bit application in application pool advanced setting.
		4) Check whether you APP POOL have set the correct .net 4.0 CLR with integrated pool.
		5)Check whether all the features under control panel->programs-> Turn windows features on and off->Internet information service especially the feature under world wide web services/security


# MICRONSIN WEB
============================================================================================================================================

Applicativo web di diagnostica e monitoraggio dell'impianto. Dal MicronSin � possibile vedere lo stato di ogni singolo terminale e varco, e comunicare comandi come in NoService.

MONITOR VARCHI
---------------------------------------
Colore terminali: 
VERDE	Tutto ok, nessun allarme, nessun terminale scollegato
BLU	Presenza di allarmi attivi, ma nessun allarme nuovo e nessun terminale scollegato
ROSSO	Presenza di allarmi nuovi e/o terminali scollegati
	(*) � possibile disattivare l'allarme manualmente su Micronsin Web
GIALLO	Varco/terminale disallineato


ALLINEAMENTO E DISALLINEAMENTO
---------------------------------------
Un terminale pu� essere disallineato perch�:
	1) Il terminale � rimasto scollegato per pi� di 24 ore: sul log Debug si vede chiaramente una C 001 e, a distanza di oltre X ore, una C 002
	2) In chiusura, il btService non riesce a scrivere il file .QUE nella cartella GNconfig (potrebbe essere una questione di autorizzazioni di scrittura nella cartella) - in chiusura, il MicronService crea i file .QUE nella corrispondente cartella GNConfig e deve ritrovarli tutti quando riparte
	3) il btService � stato chiuso in maniera 'non controllata' (tipo � stato killato il processo dal Task Manager)
	4) In fase di chiusura, il btService non raggiunge una centralina e alla fine decide di chiudersi lo stesso


Se i terminali si disallineano spesso, si pu� lavorare sui seguenti aspetti:
	- Ridurre la dimensione dei log del servizio per 'alleggerire' la comunicazione coi terminali (nel file "btservice.exe.config")
		<!-- Lunghezza max dei logs (in kb) -->
		<add key="MaxLogLen" value="10240"></add>	<--- Ridurre a 5 MB oppure 3 MB
	- Micronconfig > Parametri > Micronservice > Attesa svuotamento coda in minuti = [inserire un numero di secondi maggiore di 24 ore (1440s, a default)]
	- Micronconfig > Parametri > Micronservice (seguono parametri ottimali):
		Intervallo di richiesta mappa in ms = 30000
		Intervallo di registrazione di eventi GNet in ms = 60000
		Intervallo di attesa stop polling in ms = 60000
		Intervallo di registrazione dati monitor su database ms = 60000
		(*) In pratica, si aumenta il periodo con cui il servizio cerca di comunicare al terminale il messaggio del proprio arresto prima che si chiuda lo stesso
	- In 'extrema ratio', attivare il log DLL di basso livello: creare il file GNTRACE.FLG (ricordarsi poi di disattivarlo! altrimenti il file di log diventa enorme)




Per forzare l'allineamento, si pu� utilizzare il file comando SQL chiamato allineamento.sql, costituito dal seguente comando
	UPDATE [MRT].dbo.T06COMMONITORTERMINALI SET T06Allineato = '1'
Questo file pu� essere aggiunto al file batch di backup del database (v. sopra) con la riga seguente
	sqlcmd -S (local)\SQLEXPRESS  -U sa -P Micro!Mpw13 -i C:\B...\allineamento.sql



CARTINE
---------------------------------------
- Copiare il file .wmf nella cartella MicronSin\images
- Andare su MicronConfig > Tabelle > Gruppi di cartine ed aggiungerne uno in corrispondenza della Sede gi� presente
- Andare su MicronConfig > Tabelle > Cartine e aggiungere la cartina, mettendo nel percorso solo images/[nomefile].wmf e lasciando Larghezza:0,Altezza:0
- La modifica � immediatamente visibile su MicronSin Web

(*) Se pur avendo configurato tutto la cartina non si apre neanche con browser pi� avanzati (tipo Firefox o Chrome) MALGRADO la mappa default funzioni, vai a controllare sul Web.config di MicronSin Web che nel seguente parametro non siano attivi tutti e due i formati, ma solo uno lo sia (mentre l'altro dev'essere commentato), come riportato sotto:

    <httpProtocol>
      <customHeaders>
        <!-- add name="X-Content-Type-Options" value="nosniff" /> -->
        <add name="X-Frame-Options" value="SAMEORIGIN" />
      </customHeaders>

Istruzioni d'uso:
	+	Zoom in
	- 	Zoom out
	S	Aggiungi varco (da lista)
	R	Rimuovi varco
	^	Vista originale
	C	Aggiungi videocamera (da lista)
	?	Info su varco

	


COMANDI DI VARCO
---------------------------------------
(*) Possibilit� di aprire varchi da MSW

	- MicronConfig > Varco > Comando di varco > [descrizione]
	- Terminale di riferimento > MXP di riferimento
	- Out: scheda I/O di riferimento, stesso out di apertura porta (e.g. dig.0/1), con stesso tempo di esecuzione
	- MSW > Seleziona varco > Comandi varchi > Esecuzione comandi di varco > Comando [descrizione] > Conferma


(*) COMANDI DI VARCO NON FUNZIONANTI
Il varco NON deve essere compreso dentro ad un Gruppo di Varchi, altrimenti i comandi interni (qualsiasi essi siano) rischiano di andare in conflitto con i comandi di varco

(*) PROBLEMA CON INTERNET EXPLORER
Per versioni Msinw < 7.3.2, si � riscontrato che Internet Explorer tende a visualizzare l'applicativo in 'emulazione' predefinita a Internet Explorer 5, e questo sputtana tutto il layout e buona parte delle funzioni nell'uso dell'applicativo. Per risolvere questo, dalla versione 7.3.2 � stato forzata la visualizzazione in emulazione a Edge.



# MICRONSELFSERVICE
============================================================================================================================================

Installazione:
- Installare MicronSelfService tra i moduli opzionali della MPW Application Suite (verr� messo sotto \MPW\MicronSelfService)

Configurazione
- MicronConfig > Parametri > MicronSelfService > Entrance for guests with no badge = [inserire varco per ingresso automatico]
- MicronConfig > Parametri > MicronSelfService > Time in sec before canceling data = 10s
- MicronConfig > Parametri > MicronSelfService > Privacy information doc filename = [browse .RTF privacy filename, default is MPW\MicronSelfService\Modello_informativa_accessi.rtf]
- MicronConfig > Parametri > MicronSelfService > Password = [inserire password di chiusura dell'applicazione]
- MicronConfig > Parametri > MicronSelfService > Logo filename = [browse .GIF logo filename, default is MPW\MicronSelfService\Logo_Diageo.gif]
- MicronConfig > Parametri > MicronSelfService > Branch = 0001

Utilizzo:
Inserimento nuovo visitatore:
	- Inserire dati personali visitatore (Cognome, nome, societ�) (la societ� viene inserita con un valore di default, modificabile)
	- Inserire dati personali dipendente di riferimento (Cognome, nome)
		Se il dipendente inserito NON viene trovato nel database, appare un messaggio di errore
		Se non si completa l'inserimento dei dati entro un tempo X (parametro su MicronConfig), i campi si svuotano per un nuovo inserimento
	- Cliccare su Prosegui: viene mostrata la maschera informativa per la privacy
	- A inserimento completato, la maschera ripropone la home page per un nuovo inserimento
	- Il visitatore � ora disponibile nell'anagrafica di Micronpass Web, con tutti i dati gi� inseriti, pronto per ricevere un'abilitazione e un badge
		In caso di Gestione Visitatori Senza Badge, viene anche creato un ingresso automatico su varco specifico (parametro su MicronConfig)
Chiusura dell'applicativo
	- L'applicativo funziona a schermo intero e non pu� essere chiuso se non usando [Alt]+[F4]
	- A quel punto, il programma chiede la password (parametro su MicronConfig) per la chiusura



# MICRONSERVICE E NOSERVICE
============================================================================================================================================

INSTALLARE UN NUOVO SERVIZIO
---------------------------------

(*) Per installare manualmente il servizio, da riga di comando (eseguita da amministratore!)

	cd ..\MPW\MicronServiceXX
	C:\Windows\Microsoft.NET\Framework\v4.0.....\installutil /i btservice.exe

Per disinstallare manualmente il servizio, da riga di comando (eseguita da amministratore!)

	cd ..\MPW\MicronServiceXX
	C:\Windows\Microsoft.NET\Framework\v4.0.....\installutil /u btservice.exe

Un'altra maniera pu� essere sc ('Service Control'):

	Creazione servizio:
	sc create MicronScheduler binPath= "C:\MPW\MicronScheduler\MicronScheduler.exe" displayName= "MicronScheduler"
	sc description MicronScheduler "Gestione schedulazione MicronService"

	Cancellazione servizio:
	sc delete MicronScheduler


SPACCHETTARE .MSI
---------------------------------

Da riga di comando, digitare

	msiexec /a <nomepackage>.msi /qb TARGETDIR="<path di destinazione>"

(*) TARGETDIR dev'essere DIVERSO dal percorso d'origine!
	es. msiexec /a SetupMail.msi /qb TARGETDIR="C:\temp"

Opzioni di msiexec:
	/i	Installa o configura un prodotto
	/a	Opzione di installazione amministrativa
	/x	Rimuove un prodotto

Per ottenere un file di log dell'installer MSI:

	msiexec /i <nomepackage>.msi /l*v <output_path>.txt /quiet

		/i 	normal installation
		/a 	administrative installation
		/quiet	quiet mode (no user interaction)
		/L	enable logging
			*	log all information
			v	Verbose output


EXPORT
---------------------------------

WinAttID-WinAttIDX
	Campo:			Lunghezza:	Note:
	Codice del varco	3nn		Ultimi tre caratteri codice varco
	ID/IDX Badge		10nn/an		Identificativo badge (ID 10nn) oppure codice di traccia (IDx 10an)
	Flag Entra/Esce		1nn		(�0�=Entra, �1�=Esce), dalla versione 5.1.6 � possibile parametrare il carattere utilizzato per identificare i movimenti di entrata e di uscita
	Causale			4nn		Codice causale (0000=Nessuna causale)
	Data/ora		10nn		Formato GGMMAAHHMM
	CRLF			--		CRLF




CONTEGGIO DELLE ABILITAZIONI
----------------------------
MicronService>=7.5.21

Effettua un'estrazione delle abilitazioni relative ad una specifica centralina.
- Attivare la funzionalit� inserendo il parametro a database:
	COMF/NOME_FILE_CONTEGGIO_ABIL/<nome file con percorso completo>
- Riavviare tutti i MicronService, che trovano la flag e gestiscono il medesimo file
- Il file prodotto nel percorso introdotto nel parametro � un CSV con struttura:
	Codice			% Codice del terminale
	Descrizione		% Descrizione del terminale
	IP			% indirizzo IP del terminale (se c'�)
	Codice Servizio		% Codice del MicronService di riferimento
	Descrizione Servizio	% Descrizione del MicronService di riferimento
	Numero abilitazioni	% Conteggio totale delle abilitazioni normali, eccezionali e flash
	Data ora aggiornamento	% Data e ora di aggiornamento della riga

ERRORI IN AVVIAMENTO DEL SERVIZIO O NELLO SCARICO TIMBRATURE
---------------------------------

(*) UNKNOWN GNET ERROR
Questo errore viene dato in avviamento del MicronService oppure del NoService. � possibile che sia dovuto al fatto che il GNTRACE � stato lasciato attivo, e che abbia raggiunto dimensioni spropositate: disattivare il GNTrace e cancellare il GNTraceLog.

	BtLibErr.log
	27-07-2017 11.05.52.189 TcpNet, BTTcpClient, ConnectClient, System.Net.Sockets.SocketException: Impossibile stabilire la connessione. Rifiuto persistente del computer di destinazione 10.55.2.16:32768
	27-07-2017 11.05.52.236 GNWin32, GNWin32, GNStart, System.AccessViolationException: Tentativo di lettura o scrittura della memoria protetta. Spesso questa condizione indica che altre parti della memoria sono danneggiate.

	GNetError.log
	27-07-2017 11.05.52.267 ******** ***** 00000 unknown GNet error 


(*) ARRESTO DEI SERVIZI NON CORRETTO
� possibile che i btService non siano stati arrestati in maniera corretta (ad es. la macchina potrebbe essere virtuale e potrebbe essere stata riavviata da console).
Ce ne si accorge perch� nel log del servizio appare il record "*** Start Program v.X.X.X." e non appare il corrispettivo "Stop program".
Se i btService non vengono arrestati in maniera corretta, i file ".que" nelle rispettive cartelle GNConfig non vengono creati. Questi file certificano l'allineamento tra le centraline e il server. 

	NB: Se i file ".que" non vengono generati, al riavvio della macchina e quindi alla ripartenza dei btService ripartiranno in automatico i riallineamenti massivi delle centraline, portando a rifiutare l'accesso a quella parte di badge di cui non era stata inviata abilitazione durante il 'fermo' dei servizi


(*) IL SERVIZIO NON SCRIVE LE TIMBRATURE NELLA T37 E NEL FILE DI TESTO
Nonostante si veda la transazione di timbratura in chiaro su NoService, non appaiono timbrature nella T37.
Gli errori che si vedono sono i seguenti:

	BtLibErr.log
		31-01-2018 11:21:04:832 TcpNet, BTTcpClient, ConnectClient, System.Net.Sockets.SocketException (0x80004005): No connection could be made because the target machine actively refused it 82.193.34.116:32768
		31-01-2018 11:47:40:335 DBU, DBU, SQLExec, SQL Originale :INSERT INTO T141ACCQYBUFFER (T141CODTERMINALE, T141DATAORA, T141CODVARCO, T141TIPOMATRICOLA, T141CODAZIENDA, T141MATRICOLA, T141BADGE, T141IDX, T141ENTRAESCE, T141CAUSALE, T141NOME, T141COGNOME, T141SOCIETA, T141DESCRCAUSALE, T141CODTIPOSERVIZIO, T141DESCRTIPOSERVIZIO, T141DESCRVARCO, T141CODSEDELOGICA, T141DESCRSEDELOGICA) VALUES ('0001', '20180131114734', '00000001', '0', '?', '?', '0000000646', '00000000000000000646', '2', '', '?', '?', '', '', '', '', 'OFFCINA ', '', '') PARSE SQL:INSERT INTO T141ACCQYBUFFER (T141CODTERMINALE, T141DATAORA, T141CODVARCO, T141TIPOMATRICOLA, T141CODAZIENDA, T141MATRICOLA, T141BADGE, T141IDX, T141ENTRAESCE, T141CAUSALE, T141NOME, T141COGNOME, T141SOCIETA, T141DESCRCAUSALE, T141CODTIPOSERVIZIO, T141DESCRTIPOSERVIZIO, T141DESCRVARCO, T141CODSEDELOGICA, T141DESCRSEDELOGICA) VALUES (........) EXC:Field 'T141ACCQYBUFFER.T141SOCIETA' cannot be a zero-length string.

	ServiceLog.log
		31-01-2018 11:47:40:335 AccElabTimbrature.ManageQYBuffer: errore esecuzione sql INSERT INTO T141ACCQYBUFFER (T141CODTERMINALE, T141DATAORA, T141CODVARCO, T141TIPOMATRICOLA, T141CODAZIENDA, T141MATRICOLA, T141BADGE, T141IDX, T141ENTRAESCE, T141CAUSALE, T141NOME, T141COGNOME, T141SOCIETA, T141DESCRCAUSALE, T141CODTIPOSERVIZIO, T141DESCRTIPOSERVIZIO, T141DESCRVARCO, T141CODSEDELOGICA, T141DESCRSEDELOGICA) VALUES ('0001', '20180131114734', '00000001', '0', '?', '?', '0000000646', '00000000000000000646', '2', '', '?', '?', '', '', '', '', 'OFFCINA ', '', '')
		31-01-2018 11:47:40:351 AccElabTimbrature.DoRollBack: System.InvalidOperationException: This OleDbTransaction has completed; it is no longer usable.

	Soluzione:
	
	La tabella T141ACCQYBUFFER salva le timbrature temporaneamente perch� possano essere pi� facilmente accessibili su richiesta di una query (es. Timbrature recenti) senza la necessit� di collegarsi al database.
	La quantit� di timbrature salvate � definita nel parametro del Micronconfig riportato sotto. 
	Questa funzionalit� non � supportata per i database Access, soprattutto nelle versioni pi� recenti: conviene disabilitarla.

		- Micronconfig > Parametri > MicronserviceXXX > Numero timbrature in buffer QY (0=Disabilita) = 0	% Disabilitare l'utilizzo della tabella buffer QY

(*) ANOMALIA T116DESCRANOMALIA="ESPORTAZIONE PRESENZE"
Nonostante si veda la transazione di timbratura in chiaro su NoService, le timbrature finiscono tutte nella T116ACCBUFFER con T116descranomalia="Esportazione presenze"

ServiceLog.log
26-07-2018 12:04:26:031 AccExports.WriteRecordToFile: Impossibile memorizzare in Z:\presenze.ERR il record 0070000070770100002607181153

BtLibErr.log
26-07-2018 12:04:20:669 BTSemaphore, BTSemaphore, WriteSemaphore, Impossibile creare il semaforo: Z:\EXPORT.SEM System.IO.DirectoryNotFoundException: Could not find a part of the path 'Z:\EXPORT.SEM'.

	- Il servizio non raggiunge il percorso di rete impostato oppure non ha le autorizzazioni per scriverci dentro.
	- Se non si � sicuri di come va chiamata la mappatura, 
		MicronConfig > Parametri > MicronService > Percorso di scarico ... = [cliccare sui tre puntini e andare a puntare l'indirizzo manualmente, eventualmente passando dalla rete]
		(*) Se non � possibile arrivare all'indirizzo in maniera manuale, il servizio non raggiunger� mai quella cartella
		(*) Nell'esempio, il percorso \\ITSAMCT01\c$\MPW\Timbrature � stato mappato in rete ed � visibile nelle risorse del computer col nome di "MPWTIMBRATURE (\\itsamct01) Z:"
			In questo caso, il nome dell'unit� non � Z: (sebbene, in Esplora Risorse, scrivendo Z: si approdi proprio a quel percorso), ma \\ITSAMCT01\MPWtimbrature\ !



# MICRONCONFIG (DETTAGLI)
============================================================================================================================================

GENERALE
-----------------------------------------------
(*) Versioni <= 6.00
Credenziali di accesso per vecchie versioni di MicronConfig:

	username:	unlock
	password:	<yyyymmgghh>

(*) Funzione FILE > CERCA
Sono disponibili le funzioni di ricerca generale nel men� principale e le funzioni di ricerca contestuale nei men� di sedi, servizi e impianti.
La funzione di ricerca permette di cercare un semplice testo nei campi codice e descrizione nelle tabelle: servizio, impianto, varco e terminale. I risultato della ricerca viene presentato in uno specifico TreeView del pannello di ricerca in modo da facilitare l�individuazione dell�elemento cercato. Al termine della ricerca, l�elemento selezionato viene proposto come elemento attivo nel TreeView principale.


TABELLE
-----------------------------------------------
- Tecnologia testine: qui sono presenti tutte le tecnologie disponibili e utilizzabili in un terminale (corrisponde alla tabella T54)

IMPORT/EXPORT
-----------------------------------------------
Export: alternativa al backup del database, dove non possibile; esporta il contenuto del MicronConfig dentro a un file XML. � possibile selezionare le singole tabelle del MRT da esportare. In casi di collaudo, si possono omettere le tabelle pi� grandi di dimensioni: 	T37 (Transiti), T66 (LogAllarmi), T105 (LogUtenti), T59 (StoricoVisEBadge)

SERVIZIO:

	MANUTENZIONE A CALDO

	La manutenzione pu� essere gestita per tutti i servizi dal men� presente nella maschera principale oppure singolarmente per servizio dal proprio men� contestuale (tasto destro sull�icona servizio).
	Quando si entra in manutenzione il config invia un�apposito comando al servizio che scollega temporaneamente la rete GNet. Durante questa fase � possibile modificare l�impianto sia a livello di GNConfig che da MRTConfig.
	I servizi in manutenzione possono essere stoppati ma non possono essere riavviati.
	E� anche possibile sostituire la LibGn32.dll .
	Durante la manutenzione il servizio continua a ricevere ed elaborare tutti i messaggi di PassWeb ma mantiene tutti i messaggi gnet in coda.
	L�invio dei messaggi di configurazione dal config ai servizi viene eseguito sulla nuova porta di configurazione.
	Ovvero la porta esisteva gi� ma non era utilizzata. La segnalazione viene anche registrata su database e letta a tempo dal servizio. 
	I servizi in manutenzione sono evidenziati dall�icona con una X sopra.
	La fine manutenzione informa i servizi sempre tramite TCP e database. I servizi ricaricano tutta la struttura dell�impianto mantenendo tutte le informazioni esistenti e ricollegano la rete GNet.
	Ad ogni modifica apportata ad un elemento dell�impianto vengono segnalati in colore diverso i terminali che necessitano di comandi di aggiornamento della configurazione. La segnalazione viene ereditata dagli elementi soprastanti fino ad arrivare allo stesso sevizio.
	Passando su questi terminali nella treeview viene visualizzato un tooltip  che mostra l�elenco dei comandi di ripristino da inviare. 
	Tramite il men� Manutenzione o da quello contestuale � possibile inviare i comandi di ripristino ai terminali che lo necessitano. Questa opzione � consentita solo dopo aver concluso la manutenzione in corso.
	Qualora fossero fatte delle modifiche all�impianto mentre il servizio non � in manutenzione il nodo relativo al servizio cambio il colore di sfondo in rosso ed un tooltip avvisa che si rende necessario entrare in manutenzione.
	Modifiche a terminali non abilitati non richiedono l�invio di comandi di ripristino; i terminali disabilitati sono ora mostrati con colore grigio di sfondo.

IMPIANTO VIDEOCAMERE:



VARCO:

	(*) Problema: devo cambiare codice sia a dei terminali sia ai corrispondenti varchi, ma questi ultimi sono gi� nei profili di accesso
	Soluzione: per sostituire il codice, bisogna per forza cancellare varco/terminale e reinserirlo con il nuovo codice:
		- I terminali si possono cancellare solo dopo che sono stati 'Disabilitati' (MicronConfig) e 'Disattivati' (GNConfig)
		- I varchi si possono cancellare solo se non sono in alcun profilo d'accesso. Per sostituire il codice con quello nuovo si pu� agire direttamente su SQL:
			T35ACCPROFILIORARI (contiene tutti i sottoprofili, personali/gruppo): sostituire il campo T35VARCO
			T40ACCGRUPPIVARCHI (contiene i gruppi di varchi): 

	(*) Funzione SPOSTA IN
	Nei men� contestuali di impianti e varchi sono presenti le nuove funzioni di spostamento con ricerca della destinazione. Nel pannello di spostamento viene proposto l�elemento selezionato, mentre l�elemento destinazione dovr� essere selezionato attraverso la funzione di ricerca.
	E� utile per i grossi impianti quando risulta difficoltoso utilizzare la funzione di spostamento con drag&drop del mouse.


TERMINALE:

	PARAMETRI BASE

		- "Configurazione Network": � automaticamente inserita a seconda della configurazione di rete che � stata data nel Gnconfig. Quando un terminale viene inserito per la prima volta, il pulsante (...) permette di trovare il percorso verso il file config.gn contenente tali informazioni.
			(*) Questi dati sono comunque modificabili mettendo la spunta a "Configurazione manuale"
		- "Tipo funzionamento": lasciare default; le altre opzioni sono dedicate a impianti specializzati, dotati di firmware sviluppati apposta.
		- "Configurazione alternativa": lasciare nessuna;
		- "Lingua" e "Formato data": si tratta della lingua e del formato data che appariranno sul display del terminale;

	CONFIGURAZIONE TESTINE
	
		- "Device di lettura": in questo pannello � necessario specificare la tecnologia di lettura disponibile su un determinato terminale. Le tecnologie a disposizione nel menu a tendina sono quelle configurate di default, che � possibile vedere nella barra di controllo in alto in Tabelle > Tecnologie Testine (v.dopo). Si pu� assegnare fino a 8 tecnologie per terminale di lettura. Un terminale pu� essere equipaggiato con 1 o 2 testine di lettura, specialmente MAGNETIC, RF APROMIX, RF VMN 272, REMOTE CONTROL e NEDAP. A seconda di quante testine si voglia configurare, premere sul corrispettivo pulsante 'Testina 1' (v.sotto) o 'Testina 2'.
		- "Testina 1": Si possono ora configurare i seguenti parametri
			+ "Tipo di timbratura": si seleziona qui la funzione del terminale, ovvero se Solo Accessi, Presenze, Mensa o Distributore.
			+ "Salva su database": la spunta deve esserci, altrimenti le transazioni non possono essere salvate sul database.
			+ Flag da attivare: "Entra", "Esce", "badge non abilitato" ed "Errore di lettura" sono delle possibili funzioni del terminale in corrispondenza di cui pu� essere abilitato un output. Premere sul pulsante "Out" per configurarlo.

		(*) Tempo di cambio stato (es. 2 s): dato un transito abilitato, tempo di attivazione dell'output
		Tempo di transito (es. 20 s): dato un transito abilitato, tempo necessario ad effettuare il passaggio
		[tempo di cambio stato e di transito partono insieme al momento dell'autorizzazione al transito]
		Tempo di filtro (es. 10 s): se NON avviene il transito - ma la porta viene comunque aperta -, tempo dall'attivazione dell'output (es. allarme)

	STAMPA TICKET

	Le funzioni di stampa ticket danno la possibilit� di stampare un ticket a fronte di una timbratura eseguita su terminale base - se abilitate le White list, lo scontrino viene emesso solo se la timbratura � accettata.
	La stampante va connessa su canale seriale 1 (parametri di comunicazione: 9600,N,8,1)
		(*) Il canale seriale 1 non � dotato di segnali di handshake, quindi il terminale non pu� verificare eventuali anomalie di funzionamento della stampante, e.g. il paper-out

	Configurazione:
	- MicronConfig > Terminale base > Ticket > Abilita stampa ticket = 1		% Per abilitare la funzione
	- MicronConfig > Terminale base > Ticket > Tipo Stampante = 0			% Tipo stampante default (=0)
	- MicronConfig > Terminale base > Ticket > Tipo ticket = [selez.]		% Layout del ticket
		Tipo ticket = 0						% Layout base
			Riga 1: intestazione di 20 caratteri
			Riga 2: numero tessera (IDX)
			Riga 3: data ora di timbratura
			Riga 4: verso di timbratura
			Riga 5: eventuale codice causale
		Tipo ticket = 1						% Layout base senza verso di timbratura
			Riga 1: intestazione di 20 caratteri
			Riga 2: numero tessera (IDX)
			Riga 3: data ora di timbratura
			Riga 4: eventuale codice causale
		Tipo ticket = 2 					% Layout anagrafico (solo con White List abilitate)
			Riga 1: intestazione di 20 caratteri
			Riga 2: numero tessera (ID)
			Riga 3: data ora di timbratura
			Riga 4: eventuale codice causale
	
			(*) Con TipoTicket = 2, se la QY51 � abilitata sul terminale, viene automaticamente utilizzato il seguente layout:
				Riga 1: Intestazione
				Riga 2: numero tessera (ID)
				Riga 3: Data Ora
				Riga 4: Cognome
				Riga 5: Nome
				Riga 6: Matricola + Codice Azienda (se dipendente; blank se visitatore)
				Riga 7: Descrizione della causale
				Riga 8: +2 linee blank per separazione

		Tipo ticket = 3						% Layout compatto
			Riga 1:	Data Ora
			Riga 2: numero tessera (ID)

			(*) Con TipoTicket = 3, se la QY51 � abilitata sul terminale, viene automaticamente utilizzato il seguente layout:
				Riga 1: Data Ora
				Riga 2: Cognome Nome
				Riga 3: Matricola + Codice Azienda + numero tessera (ID)

	- MicronConfig > Terminale base > Ticket > Modo stampa ticket = [selez.]	% Quando devo stampare il ticket
		a) qualsiasi timbratura;
		b) solo timbrature con causale;
		c) solo timbrature aventi causale che iniziano (a sinistra) con un carattere compreso in un certo range di caratteri (specificato in Carattere Minimo e Massimo). I caratteri minimo e massimo possono coincidere, permettendo cos� la stampa quando si ha una causale che inizi con un solo determinato carattere.
	- Carattere minimo range causale per stampante		% Inizio range causale per il Modo Stampa Ticket tipo c
	- Carattere massimo range causale per stampante		% Fine range causale per il Modo Stampa Ticket tipo c	
	- Intestazione da stampare sul ticket = [insert]	% Stringa da 20 caratteri riportata in testa al ticket

	Eventuali personalizzazioni applicabili (sviluppo firmware):
	- Modo stampa ticket (es. vincolo sul numero di ticket stampati al giorno, emissione solo in un verso, ecc.)
	- Eventuali informazioni aggiuntive nel Tipo Ticket (es. matricola, cod.azienda, descrizione societ�, ecc.)


	(*) CENTRALINA FUORI RETE CHE NON CONSENTE PIU' L'ACCESSO
	Pu� capitare che una centralina non collegata alla rete (anche di proposito) faccia s� che le testine ad essa collegate non consentano pi� l'accesso, neanche ai badge abilitati - in tal caso, il lettore non d� neanche segni di rifiuto.
	In tal caso, � possibile che la centralina, non essendo collegata alla rete, sia andata in "memory full", non accettando pi� alcuna timbratura.
	Se il terminale � destinato a non essere mai collegato alla rete, � bene  programmarlo affinch� non generi timbrature. 
	- MicronConfig > [Terminale base] > Abilitazioni > selezionare "Non trasmette a PC"
	- MicronConfig > [Terminale KK] > Configurazione Testine > Testina 1 > deselezionare "Salva su database", tipo timbratura="presenze"

	(*) ERRORE IN AGGIUNGI TERMINALE
	Pu� capitare che, aggiornando il framework, il MicronConfig dia un errore in "Aggiungi Terminale" (bada bene che la creazione dei varchi funziona benissimo), addirittura magari riesce a creare solo i terminali FTP.
		La soluzione � la seguente:
	
		Nel file C:\Windows\Microsoft.NET\Framework\v4.0.30319\machine.config

		<system.data>
		    <DbProviderFactories>
		        <add name="IBM DB2 for i5/OS .NET Provider" 
		invariant="IBM.Data.DB2.iSeries" description=".NET Framework Data Provider for i5/OS" type="IBM.Data.DB2.iSeries.iDB2Factory, IBM.Data.DB2.iSeries, Version=12.0.0.0, Culture=neutral, PublicKeyToken=9cdb2ebfb1f93a26"/>
		        <add name="Microsoft SQL Server Compact Data Provider" 
		invariant="System.Data.SqlServerCe.3.5" description=".NET Framework Data Provider for Microsoft SQL Server Compact" 
		type="System.Data.SqlServerCe.SqlCeProviderFactory, System.Data.SqlServerCe, Version=3.5.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"/>
		    </DbProviderFactories>
		    <DbProviderFactories/> 		<---- CANCELLARE QUESTA RIGA!



CONFIGURAZIONE LOCALE TERMINALI GPRS
TERMINALI ARM:
	Tramite cavo ethernet (in laboratorio):
	Su Karpos Web Configurator:
		Options > General > ControllerCode = [Impostare controller code]
		Options > General > PlantCode = [Impostare Plant Code]
		Options > Connection > ServerIPAddress = [impostare IP pubblico]
		Options > Connection > TCPConnMode = 2
		Options > Connection > TCPPort = [impostare porta, es. 6001]
	Per definire l'APN:
		Su Putty (inserire i seguenti comandi):
			minicom -D /dev/ttyUSB2			% Apertura programma Minicom 2.7 per dialogare col modulo
			at+cgdcont=1,"IP","<codice_apn>"	% Impostazione codice APN (es. ibox.tim.it)
			at+cgdcont?				% Per verificare quanto inserito
			[Ctrl+A] + [C]				% Per pulire lo schermo
			[Ctrl+A] + [Q]				% Per uscire da minicom
		Tramite uso dei parametri su Web Configurator:
			
	Configurazione impianto:



VARCO
-----------------------------------------------
� FASCE DI DISATTIVAZIONE

� possibile definire fino a 8 fasce di disabilitazione degli ingressi digitali su terminale base e su Multi/IO. Le fasce sono composte da ora di inizio, ora di fine e giorni di intervento, nonch� dalla bitmap degli ingressi da filtrare.

(*) Va configurato l'ingresso su cui � stato attivato lo sblocco del varco

- Aprire MicronConfig > [selezionare il terminale base cui fa riferimento il KX di sblocco] > Ingressi/Allarmi > Multi I/O > [seleziona la scheda I/O del KX in questione]
- Si apre la finestra con la lista delle fasce di disattivazione > Doppio click su una delle fasce
- Si apre la maschera di modifica della fascia. Inserire i seguenti parametri:
	Descrizione: inserire la descrizione della fascia
	Orari: Inserire l'inizio e la fine della fascia
	Giorni: Selezionari i giorni, LUN-DOM e FEST
	Ingressi: Nell'elenco appare la lista degli ingressi che entrano nel KX; selezionare quello preposto allo sblocco
- Salvare e configurare quante pi� fasce si pu� fino alla completa soddisfazione!
	
Es. "Fascia di disattivazione 1", 08:00:00-13:00:00, In_0

Nell�esempio � stata definita una fascia tramite la quale si disattiva il funzionamento dell�ingresso_0 (che deve essere stato precedentemente  configurato) dalle ore 8:00 alle ore 13:00, dal luned� al venerd�: durante questo periodo, qualsiasi variazione dell�Ingresso_0 sar� filtrata dal firmware. Eventuali altri ingressi digitali configurati continueranno a funzionare normalmente.


TABELLA TESTINE
-----------------------------------------------

Configurazione dei tipi testina �T54TipoTestina� Terminale Base

0	Interfaccia badge per device con codifica magnetica di tipo ISO2
1	Interfaccia badge per device con codifica magnetica di tipo ISO2
2	Interfaccia radiocomando (solo per �T22Testina2�)
3	Interfaccia badge per device con codifica magnetica di tipo ISO2
4	Interfaccia NEDAP su canale seriale 1 (solo per �T22Testina2�) direzione ENTRA
5	Interfaccia NEDAP su canale seriale 2 (solo per �T22Testina2�) direzione ESCE
6	Interfaccia lettura Tag VMN272 con codifica Unique (solo per �T22Testina1�)
7	Interfaccia badge per device con codifica magnetica di tipo ISO2
8	Interfaccia badge per device con codifica magnetica di tipo ISO2
9	Interfaccia badge per device con codifica magnetica di tipo ISO2
10	Interfaccia badge on board per tessere Tag / Banda magnetica (codifica Wiegand-40)
11	Interfaccia Biometrico DSU302 su seriale 1 ENTRA e seriale 2 ESCE (dalla v1.7b)
NB. Tolta dalla versione v2.0a
12	Interfaccia Tag VMN272 (antenna 1 per �T22Testina1�; antenna 2 per �T22Testina2�)
v2.1a Nota: Se T2 non configurata ogni lettura viene indirizzata su T1 per gestione display
13	Interfaccia lettore Tag Mifare M344b, primo e secondo lettore per T22Testina1, verso entra ed esce.
14	Interfaccia lettore Tag Mifare M344b, primo lettore per T22Testina1, secondo lettore per T22Testina2
15	(da ver.2.3A) ISO 14443-B con M344b, primo e secondo lettore per T22Testina1, verso entra ed esce. 
16	(da ver.2.3A) ISO 14443-B con M344b, primo lettore per T22Testina1, secondo lettore per T22Testina2
17	(da ver.2.3A) ISO 15693 con M344b, primo e secondo lettore per T22Testina1, verso entra ed esce. 
18	(da ver.2.3A) ISO 15693 con M344b, primo lettore per T22Testina1, secondo lettore per T22Testina2
19	(da ver.2.3L) Gestione targhe MicronPlate


Configurazione dei tipi testina �T54TipoTestina� Terminale KK

0	Interfaccia badge per device con codifica magnetica di tipo ISO2
1	Interfaccia badge per device con codifica magnetica di tipo ISO2
2	NA
3	Interfaccia badge per device con codifica magnetica di tipo ISO2
4	NA
5	NA
6	Interfaccia lettura Tag con codifica Unique
7	Interfaccia badge per device con codifica magnetica di tipo ISO2
8	Interfaccia badge per device con codifica magnetica di tipo ISO2
9	Interfaccia badge per device con codifica magnetica di tipo ISO2
10	Interfaccia badge per device con codifica magnetica di tipo ISO2
11	NA
12	NA
13	Mifare ISO 14443-A su KK M378/M386 con M344b (da ver.2.2A)
Solo per versione 2.2B(Punta della Salute)
Lettore M344b per tessere HID iClass
15	ISO 14443-B su KK M378/M386 con M344b (da ver.2.2A)
17	ISO 15693 su KK M378/M386 con M344b (da ver.2.2A)


TABELLA CAMPI PROGRAMMABILI
-----------------------------------------------
Un "Campo programmabile" � un campo aggiuntivo per le categorie anagrafiche Dipendenti, Esterni o Visitatori.
Un nuovo campo viene scritto nella tabella T108COMDATIAGGIUNTIVI ed � automaticamente visibile nella pagina di dettaglio della matricola alla sezione "Dati aggiuntivi".

Per inserire un nuovo campo programmabile:
	- Micronconfig > Tabelle > Campi Programmabili > Tipo Matricola: [selezionare Dipendenti, Esterni o Visitatori]
	- Micronconfig > Tabelle > Campi Programmabili > Aggiungi

Un nuovo campo programmabile � identificato da:
	- ID Campo:		identificativo del campo nella tabella (non modificabile)
	- Tipo matricola:	riassume la scelta precedente del tipo matricola
	- Descrizione:		campo di testo personalizzabile, sar� visibile nella maschera Micronpass Web
	- Tipo campo:		Tipo di valore inserito [opzioni]
		S - Testo [Lunghezza]
		N - Numerico [Lunghezza]
		D - Data
		O - Data e ora
		R - Scelta singola radio button
		L - Scelta singola dropdownlist
		V - Vero/falso
		C - Scelta multipla
		Q - Scelta singola da query esterna
			
			Configurazione
			
				La "query esterna" � pensata per estrarre i dati da una tabella del database MRT, ed eventualmente creare tabelle ad hoc per eventuali applicazioni all'interno del DB.
				La query restituisce solo due campi: VALORE (il valore del campo programmabile) e DESCRIZIONE (ci� che viene visualizzato su Micronpass Web); entrambi i campi possono utilizzare la concatenazione di stringhe
				Le query quindi vanno inserite sul modello 
					SELECT <CAMPOVALORE> AS VALORE, <CAMPODESCR> AS DESCRIZIONE FROM <TABELLA>		
				Non � necessario inserire ORDER BY perch� su Micronpass Web i valori vengono sempre ordinati per descrizione, su un menu a tendina con filtro a disposizione

					es. SELECT T26CODICE+T26CODAZIENDAINTERNA AS VALORE, T26COGNOME+''+T26NOME AS DESCRIZIONE FROM T26COMDIPENDENTI

			Utilizzo				
	
				Nella pagina dell'anagrafica appare un nuovo menu a tendina dove � possibile selezionare i valori corrispondenti all'estrazione della query.
				Si pu� utilizzare anche un filtro: senza checkbox, la query ritorna i dati che corrispondono per parte iniziale; con checkbox, la ricerca viene effettuata anche nel contenuto.
				Non si differenziano maiuscole e minuscole.				

	- Obbligatorio s�/no:	Se il valore � obbligatorio, non si pu� evitare di valorizzarlo durante la creazione di una nuova anagrafica





# MICRONMAIL
============================================================================================================================================

INTRODUZIONE
-----------------------------------------------

FUNZIONAMENTO
-----------------------------------------------

EVENTI

	E001	% Invio dello stato impianto allo scadere del timeout. Lo stato impianto viene generato solo quando ci sono dei terminali in allarme (offline,testine).
	E002	Scollegamento terminale (off-line)
	E003	Ricollegamento terminale (on-line dopo off-line)
	E004	Scollegamento testina
	E005	Ricollegamento testina
	E006	Invio stato allarmi attivi allo scadere del timeout. L�evento viene generato solo per gli allarmi attivi
	E007	Attivazione di un allarme
	E008	Disattivazione di un allarme
	E009	Tacitazione di un allarme (solo se allarme attivo)	% Corrisponde alla tacitazione da MicronsinWeb
	E010	Invio stato servizi micron Service allo scadere del timeout. L�evento viene generato solo per i servizi non attivi
	E011	Attivazione servizio micronService
	E012	Disattivazione servizio micronService
	E013	Attivazione del programma micron Mail
	E014	Disattivazione del programma micron Mail
	E015	Stato servizi macchina. Invia stato dei servizi microntel installati sul pc
	E016	Attivazione di un servizio macchina
	E017	Disattivazione di un servizio macchina

	(*) Il timeout (espresso in secondi) indica dopo quanto tempo di permanenza dell�evento viene attivata la segnalazione via mail
	(*) Se i terminali vanno offline e non si riceve alcuna mail (ma gli eventi sono presenti nel file Events), � possibile che sia perch� i tempi di timeout degli eventi E002 e E003 sono troppo lunghi rispetto a quanto sono rimasti scollegati i terminali stessi

REPORT

	Abilitato	% S�/no per accendere o spegnere l'invio
	ID		% Numero progressivo con cui Micronmail chiamer� questo report
	Descrizione	% Descrizione che Micronmail utilizzer� nell'invio della mail
	Codice report	% Codice report personalizzato su Micronpass Web
	Excel		% Spunta per ricevere il report in formato Excel, se formato XLS nativo disponibile su quel report
	Allarme		% Cliccare su [...] per spuntare l'allarme configurato su Micronconfig
	Schedulazione	% Schedulazione del report: mai, una volta al giorno, dalle/alle ogni X minuti, schedulazione settimanale/mensile
	Stampa		% Spunta per inviare comando di stampa
	Stampante	% Nome condiviso della stampante (NON indirizzo IP)
				** � esattamente il nome stampante che appare quando si manda in stampa, per esempio, un Blocco Note
				** Se lasciato vuoto il campo 'nome stampante', viene utilizzata la stampante predefinita di Windows

PARAMETRI

Nome Smtp Server			Nome del server smtp utilizzato per inviare le mail
Utente Smtp				Utente smtp, da specificare solo quando il server richiede l�autenticazione
Password Smtp				Utente smtp, da specificare solo quando il server richiede l�autenticazione
Indirizzo mittente			Indirizzo mittente utilizzato per inviare la mail (default: micronmail@microntel.com)
Numero porta servizio Smtp		Numero porta servizio smtp (default = 25)
Indirizzo locale IP per messaggi UDP	Indirizzo locale ip per messaggi udp, serve per ricevere gli udp di servizi
Tempo aggiornamento DB in secondi	Tempo aggiornamento da database in secondi. Il programma ricarica tutti i dati per eseguire i controlli.
Tempo invio mail in secondi 		Tempo invio mail in secondi. Le mail vengono compattate in una unica mail e allo scadere del timeout viene inviata.
Tempo mantenimento mail non inviate	Tempo mantenimento mail non inviate in secondi. Dopo questo timeout le mail non inviate vengono cancellate.
Tempo controllo servizi in secondi	Tempo controllo servizi in secondi. Tempo per testare il collegamento dei servizi attraverso la comunicazione TCP/IP e leggere lo stato dei servizi di macchina
Mail in formato HTML			Mail in formato html. Flag 0-1
Network account: nome			Nome utente da utilizzare per accedere al pc ed al sito mPassWeb. Da utilizzare se MRT � impostato con autenticazione Windows integrata.
Network account: password		Password del network account
Network account: dominio		Dominio di appartenenza del network account
micronPassWeb account : nome		Nome utente MRT
micronPassWeb account:  password	Password utente MRT, da utilizzare solo per autenticazione form.
SSL Smtp Connection (0/1)		Integrazione della crittografia SSL sul collegamento smtp del client di posta


LOGS
-----------------------------------------------
Si trovano in C:\MPW\MicronMail e contengono:

	micMail.log	Log di registrazione di tutti gli errori dell'applicativo
	btLibErr.log	Log errori della libreria; oltre a contenere errori imprevisti contiene sicuramente tutti gli errori di collegamento TCP-IP verso i servizi
	events.log	Contiene l�elenco degli eventi generati dal programma indistintamente dagli utenti (mostra ora di generazione, ora di attivazione e descrizione)
	mails.log	Contiene l�elenco delle mail inviate correttamente e non


� EVENT.LOG



ERRORI
-----------------------------------------------

(*) NON VIENE MANDATA LA MAIL
Sebbene il MicronMail stia correttamente girando e arrivi anche il messaggio di conferma dell'invio della mail, non si vede niente nella posta in arrivo.
Il problema � chiaramente da cercarsi a un livello superiore a quello software, visto che il MicronMail non riscontra problemi di sorta.
NB: Se ci fossero problemi di collegamento al server SMTP, il MicronMail lo scriverebbe nei log.

	- Provare un telnet sul server SMTP alla porta 25 (es. telnet smtp.diasorin-eur.it 25)
	- Una volta entrati in telnet, usare i seguenti comandi


Riassunto comandi telnet SMTP:
***I comandi sono Case-sensitive!
	Basic SMTP commands (SMTP protocol):
		HELO o EHLO <nome-o-IP-server>			% Il client manda questo comando al server SMTP per identificarsi e iniziare la conversazione
			e.g. 	Client: helo diasorin-eur.it
		MAIL FROM:<indirizzo-email>		% Il client specifica l'indirizzo email del mittente; il server SMTP riconosce che una nuova transazione sta iniziando e resetta tutte le sue tabelle e buffer (se l'indirizzo email � accettato, il server risponde 250 OK)
			e.g. 	Client: MAIL FROM:<john@mail.com>
				Server: 250 OK
		RCPT TO:<indirizzo-email>		% Il client specifica l'indirizzo email del destinatario; il server SMTP invia una mail all'indirizzo indicato; se avvenuto con successo, il server risponde con 250 OK
			e.g.	Client: RCPT TO:<peggy@mail.com>
				Server: 250 OK
		DATA 					% Questo comando fa iniziare il trasferimento di dati (corpo, testo, allegati); dopo che il server ha risposto con codice 354, si pu� iniziare a inserire i dati da inviare; per chiudere il messaggio, premere [Invio]+[.]+[Invio].
			e.g. 	Client: DATA
				Server: 354 Send message content; end with <CRLF>.<CRLF>
				Client: Date: Thu, 21 May 2008 05:33:29 -0700
				Client: From: SamLogic <mail@samlogic.com>
				Client: Subject: The Next Meeting
				Client: To: john@mail.com
				Client:
				Client: Hi John,
				Client: The next meeting will be on Friday.
				Client: /Anna.
				Client: .
				Server: 250 OK
		NOOP					% Fa solo in modo che il destinatario mandi indietro una risposta OK. Lo scopo � quello di controllare che il server sia ancora connesso e in grado di comunicare col client.
		QUIT					% Chiusura della connessione; se avvenuta con successo, il server risponde col codice 221 e chiude la connessione

			Esempio di utilizzo dei comandi di base:
				S: 220 smtp.server.com Simple Mail Transfer Service Ready				
				C: HELO client.example.com								% Inizio della conversazione
				S: 250 Hello client.example.com								% Risposta del server
				C: MAIL FROM:<mail@samlogic.com>							% Mittente
				S: 250 OK										% Mittente accettato
				C: RCPT TO:<john@mail.com>								% Destinatario
				S: 250 OK										% Destinatario accettato
				C: DATA											% Inizio del corpo del messaggio
				S: 354 Send message content; end with <CRLF>.<CRLF>					% Pronto a ricevere il corpo del messaggio
				C: <The message data (body text, subject, e-mail header, attachments etc) is sent>	% Corpo del messaggio
				C: .											% Fine del corpo del messaggio
				S: 250 OK, message accepted for delivery: queued as 12345				% Ricezione della fine del corpo del messaggio
				C: QUIT											% Chiusura connessione
				S: 221 Bye										% Conferma chiusura connessione

	Extended SMTP commands (ESMTP protocol):
		EHLO <nome-o-ip-server>			% Extended Hello: fa la stessa cosa di HELO ma dice al server che il client potrebbe voler usare l'ESMTP (anche se poi non lo si usa)
		...

Test su server SMTP Microntel, con autenticazione:

	Base-64 encoding of "edoardo.sanna@microntel.com":	ZWRvYXJkby5zYW5uYUBtaWNyb250ZWwuY29t
	Base-64 encoding of "EdS44MEs"				RWRTNDRNRXM=
	
	telnet mail.microntel.com 25 [ENTER]
		220 mx.onconsulting.it ESMTP Postfix
	EHLO mail.microntel.com [ENTER]
		250-mx.onconsulting.it
		250-PIPIELINING
		250-SIZE 25728640
		250-ETRN
		250-STARTTLS
		250-AUTH PLAIN LOGIN
		250-ENHANCEDSTATUSCODES
		250-8BITMIME
		250 DSN
	AUTH LOGIN
		334 VXNlcm5hbWU6
	ZWRvYXJkby5zYW5uYUBtaWNyb250ZWwuY29t [ENTER]		% Base64-encoded username
		334 UGFzc3dvcmQ6
	RWRTNDRNRXM= [ENTER]					% Base64-encoded password
		2.7.0 Authentication successful
	MAIL FROM:edoardo.sanna@microntel.com [ENTER]
		250 2.1.0 Ok
	RCPT TO:edoardo.sanna@microntel.com [ENTER]
		250 2.1.5 Ok
	DATA [ENTER]
		354 End data with <CR><LF>.<CR><LF>
	Subject: TestSubject [ENTER]
	TestContent
	[ENTER]
	.
	[ENTER]
		250 2.0.0 Ok: queued as 4D227100470
	QUIT [ENTER]
		221 2.0.0 Bye


(*) THE FILE EXISTS
Se nel file log event.log si dovesse riscontrare quanto indicato:

	09-11-2015 09:56:07:739 Reports.SaveReport, The file exists.
	09-11-2015 09:56:07:744 Reports.LoadRpt, The file exists.

Questo messaggio indica che il micronmail, ha tentato di elaborare il report (schedulato o su allarme), ma la cartella (%TEMP%) nel quale tenta di generare il file � piena ovvero ha oltre i 65000 files (limite di Windows).

Provare a seguire la procedura:
- cmd > %TEMP% per verificare il percorso della cartella temp nel quale viene elaborato il file
- Andando a quel percorso, � possibile vederne il contenuto
- Cancellare manualmente, o sempre da prompt scrivere "Del *.tmp"

(*) OPERATION NOT YET IMPLEMENTED

C:\Windows\Temp > Propriet� > Sicurezza > "Full control" per Everyone






# MICRONUTILITY
============================================================================================================================================

MicronUtility � un tool client, non un applicativo web. Viene utilizzato per impianti di presenze o mensa, o comunque per impianti con accessi di piccole dimensioni.
	- Visualizzazione di una struttura ad albero con dati dettaglio delle varie entit� comprese nell�impianto
	- Monitoraggio di varchi e terminali (solamente stato di collegato ed allineato)
	- Invio di comandi di manutenzione ai varchi/terminali
	- Gestione tabella fasce orarie
	- Gestione fasce di varco
	- Gestione tabella e setup causali di presenza
	- Gestione tabella e setup causali di mensa
	- Gestione setup comandi schedulati
	- Gestione autorizzazioni utenti (limitatamente alle funzionalit� di MicronConfig e Micron Utility)

Si pu� accedere tramite le solite credenziali di installatore (micronunlock,<hhddmmyyyy>). La prima pagina � un "Riepilogo Generale" contenente Framework, lingua, formato data, versione database e versione del servizio GNET. A sinistra appare una treeview dell'impianto simile a quella vista in MicronConfig. Selezionando ogni voce della treeview, si apre una pagina con le informazioni di base.


� INSERIRE UNA CAUSALE NEL TERMINALE

Entrare in Tabelle > Causali di presenza. La maschera corrispondente permette di associare delle causali ai tasti sul terminale presenze. Cliccando su "Modifica" � possibile aggiungere, per ogni nuova causale, un codice e una descrizione con al massimo 60 caratteri. Di solito anche la descrizione viene espressa in termini di pochi caratteri, perch� sar� quella visualizzata sul display del terminale in corrispondenza della pressione dei tasti. 
� possibile aggiungere causali solo se il servizio � online. 

(*) Il risultato � lo stesso di aggiungere o cambiare le causali da Micronpass Web.

Alcuni esempi (codice,descrizione):

	VIS1	VISTIMBR	Verifica timbrature giornaliere/mensili su terminale dove si effettua la timbratura (legge nella memoria del terminale)
	QY01	QUERYTIMBRGIORN	Mostra su display le timbrature giornaliere del codice di badge passato su terminale (legge su database)
	QY02	QUERYTIMBRMENS	Come sopra, ma mostra le timbrature mensili (legge su database)
	QY03	QUERYTIMBRLAST	Richiesta delle ultime timbrature effettuate, a prescindere dal giorno/mese corrente.
	QY51	QUERYANAGR	Mostra a display nome e cognome del proprietario del badge passato
	0001	VISITAMEDICA	Salva visita medica
	SERV	SERVIZIO	Salva uscita per servizio

(*) Le prime tre sono causali gi� scritte nel firmware, quindi non verranno scritte in presenze.txt (risulter� sempre 0000). Le altre due s�.

Nella parte destra della maschera, � possibile assegnare un tasto funzione (FX) a una particolare causale. L'invio del comando � immediato ed � possibile vederlo in NoService come "Invio Tabella Causali".
Salvare e verificarne il funzionamento su display. Per confermare una causale, premere prima il tasto funzione, poi passare il badge. Per tornare alla schermata principale, premere ROSSO. La causale � ora visibile nel codice timbratura di presenze.txt(nella fattispecie, premendo il tasto corrispondente all'uscita di servizio, apparir� "SERV" tra il codice badge e la data-ora di timbratura).


	PARENTESI SULLE QUERY INFORMATIVE:

	Nel tracciato record ricevuto dal servizio, oltre ai consueti dati di timbratura (data ora, badge, verso di transito), vengono inseriti anche dei codici che consentono di recuperare informazioni dal database MRT da visualizzare sul display del terminale (elenco timbrature, contenuto di campi programmabili, cognome e nome assegnatario del badge). In particolare il campo causale contiene il tipo di query da effettuare.
	La risposta inviata dal servizio prevede l�invio dell�esito della timbratura (accettato, rifiutato per inesistente�), la maschera comandi out utilizzata, e di un�eventuale extrainfo (solo se l�esito della timbratura � accettata).

	QY01: Richiesta timbrature del giorno corrente
		Con la query in oggetto � possibile ottenere un elenco delle timrbature effettuate dal badge utilizzato per la query nella giornata odierna.
		Vengono inviate al terminale le sole timbrature accettate effettuate nella giornata odierna su terminali di presenza.
		Il servizio invia un massimo di 11 righe di testo, da 20 caratteri ciascuna. 
		Su ogni riga � indicata la direzione di transito oltre all�ora di timbratura (senza secondi) di due timbrature, le trimbrature vengono proposte ordinate per ora crescente.
		In caso di nessuna timbratura riscontrata o di errore imprevisto, viene inviata una stringa vuota. E� previsto che la stringa informativa contenga sempre un numero pari di righe da 20 caratteri (se sono dispari, viene aggiunta una riga vuota).
	
	QY02: Richiesta timbrature del mese corrente
		Come per la query precedente vengono proposte le timbrature di presenza accettate per il badge utilizzato per la query.
		La formattazione � identica a quanto previsto per la query QY01; vengono, ovviamente, proposte le timbrature di tutto il mese, ordinate per data ora decrescente (le prime righe propongono le timbrature pi� recenti), quindi per ogni timbratura viene indicato il verso di transito, il numero del giorno del mese (01-31)  e l�ora di timbratura (senza i secondi).
		Ovviamente � probabile (specie verso la fine del mese) che il numero di timbrature sia troppo elevato per essere visualizzato a display (vengono proposte massimo 11 righe con due timbrature ciascuna, quindi al massimo vengono visualizzate le ultime 22 timbrature di presenza del mese).

	QY03: Richiesta ultime timbrature
		La query in oggetto consente di ottenere l�elenco delle ultime timbrature effettuate, senza limite temporale. Vengono presentate un massimo di 11 timbrature ciascuna proposta su una riga di 20 caratteri.
		La formattazione risulta essere differente rispetto alle due precedenti query in quanto � necessario indicare sia il giorno che il mese di timbratura (oltre, ovviamente, all�ora).
		Non � previsto un �arrotondamento� del numero delle righe che sar� sempre al massimo di 11.
		Da notare che, per migliorare la leggibilit�, nei primi dieci caratteri della riga viene proposta la flag di entrata/uscita e la data, nei secondi dieci caratteri viene indicata l�ora (come di consueto senza i secondi).

	QY41-QY50: Richiesta dati campi programmabili
		Con la presente query vengono richiesti i dati dei campi �programmabili� associati alla matricola assegnataria del badge utilizzato per la query.
		La query QY41 ritorna i dati del campo programmabile 1, la query QY42 ritorna i dati del campo programmabile 2 e cos� via�
		
	QY51: Richiesta dati assegnatario
		Con la query in oggetto vengono richiesti i dati dell�assegnatario del badge utilizzato per la query.
		Vengono inviate 4 righe da 20 caratteri ciascuna comprendenti:
		-	Cognome
		-	Nome
		-	Matricola
		-	Cod. Azienda Interna/Esterna (oppure societ� per i visitatori)



# AGGIORNAMENTO MICRONPASS APPLICATION SUITE
============================================================================================================================================

BACKUP
-----------------------------------------------

- Controllare di avere in chiavetta: Framework 4.0, Crystal Reports 32-64bit, pacchetto $MRTxxx.zip

(*) Se si tratta di trasferire tramite TeamViewer, la priorit� � questa: 1) $mrtxxx.zip (il pacchetto di installazione), 2) Framework4 (da installare prima ancora del software), 3) CRRuntime

- Creare C:\MPW\Backup\ (oppure C:\MPW\Install\Backup_<ddmmyyy>\) e Copiarci dentro le cartelle gnconfig\ (tutte, cio� tutte quelle legate ai servizi del cliente), micronpass\, micronimport\ (se c'� stata la sincronizzazione nella precedente installazione- se non c'� stata, il file config contiene tutti i valori di default), e degli altri vari servizi compresi. Ricordarsi il file .lic!

(*) Se c'� spazio, copiare tutta la cartella MPW
(*) Verifiche a colpo d''occhio: Su quale disco � installato MPW? Quante cartelle gnconfig ci sono nella cartella MPW? Qual � il percorso della cartella delle timbrature? 

- Verificare i requisiti di installazione (Framework 4.0, Pacchetto installazione, Crystal Reports). Quella dei Crystal Reports deve essere l'ultima versione disponibile, quindi anche se CRR c'� gi�, reinstallare manualmente
- Nell'IIS, bloccare l'Application Pool contenente mpassw e msinw e poi interrompere tutti i servizi (btservice, DBIServ, mClearSrv...) da services.msc

(*) Verifiche a colpo d'occhio: quanti btservice sono attivi? Come si chiamano (con numeri romani, con numeri arabi, partono da 0 o da 1, ecc.) ? 

- Fare un backup del Database: su SQL Server Management, click destro su MRT, attivit� > backup > aggiungere path in X:\backup_db\MRT

(*) Attenzione!!! � importante che PRIMA si fermino i servizi e DOPO si faccia il backup del database, altrimenti potrebbero venire scaricate altre timbrature, che verranno perse e non saranno recuperabili al momento del ripristino del database alla fine dell'aggiornamento.


INSTALLAZIONE
-----------------------------------------------

- Rimuovere dall'Installazione Applicazioni il "Micronpass Application Suite"
- Installare Framework 4
- Procedere regolarmente con l'installazione di MPW, compresa l'attivazione con il MicronStart

(*) In MicronStart, in caso di errore nell'upgrade del Database, leggere i file
		dbupgrade.exe.config: per i dati sul Database, come nome, username, password, versione
		dbupgrade.log: per sapere che errore c'� ed eventualmente agire manualmente sul database

- Aggiornare la licenza -> v. processo di Aggiornamento licenza

- Se ci sono pi� servizi:

	+ MicronConfig > Parametri > Configura Nuovo Programma: crea le cartelle corrispondenti ai nuovi servizi da aggiungere, nominandole come erano prima della disinstallazione della vecchia versione

	+ Cancellare TUTTI i log di MicronServiceXX/, copiare il contenuto di MicronService/ in MicronServiceII/ e cos� via per tutte le cartelle dei servizi. Dopo aver copiato, modificare il numero di servizio nel file tservice.exe.config da 0001 a 0002 e cos� via per tutti i servizi.

(*) NON sostituire le cartelle MicronService e NoService con quelle vecchie! Contengono gli eseguibili della nuova versione, non potrebbero mai partire!

	+ Effettuare la stessa procedura di aggiornamento dei config per tutti i NoService

	+ Abilitare il Multipolling: in MicronConfig > Parametri > MicronService, mettere la spunta su "Multipolling". Copiare gnconfig/multi/ negli altri gnconfigXX/ per garantire il funzionamento del Multipolling

- Per altri applicativi:

	MICRONIMPORT: Riconfigurare servDBI.config come l'originale
	MICRONIMPORT: Effettuare stessa procedura per MicronImport e MicronImportNoService

VERIFICHE FINALI
-----------------------------------------------------

- Verificare che tutti i NoService partano: da MicronConfig > Parametri > aprire tutti i servizi. Basta anche solo aprire i servizi e salvare. 

(*) Questo serve a fare in modo che alcuni valori che nel database, inizializzati come NULL, acquisiscano un valore finito. 

- MICRONBADGE: Aggiornare MicronBadge (se presente), solo sul pc a cui � collegato il lettore NFC del badge (basta copiare C:\MPW\MicronBadge dal server al client su cui � installato l'arruolatore, qualsiasi esso sia)



# DBUPGRADE
============================================================================================================================================

(*) ERRORE T113ACCMENU
(Solitamente tra la 6.80 e la 6.90)

	06-11-2017 10:26:43:262 SetScreen MSSQL (LOCAL)\SQLEXPRESS ver: 6.80 required: 7.40
	06-11-2017 10:26:46:777 doUpgradeSQL: SQL 6.90
	06-11-2017 10:26:48:230 RunCommand: Could not drop constraint. See previous errors.
	06-11-2017 10:26:48:230 RunCommand: ALTER TABLE [dbo].[T113ACCMENU] DROP CONSTRAINT [PK_T113ACCMENU_1]
	06-11-2017 10:26:48:308 doUpgradeSQL: System.Data.OleDb.OleDbException (0x80040E14): Could not drop constraint. See previous errors.

	Andare su SQL server Manager > Databases > MRT > Tabelle > T113ACCMENU > Chiavi e rinominare l'unica chiave presente, aggiungendo al nome un "_1"

(*) T43COMREPORTS
(Solitamente tra la 6.20 e la 6.50)

	RunCommand: L'apporto modifiche non � riuscito perch� si � cercato di duplicare i valori nell'indice, nella chiave primaria o nella relazione. Modificare i dati nel campo o nei campi che contengono dati duplicati, rimuovere l'indice o ridefinire l'indice per consentire l'inserimento di voci duplicate, quindi ritentare l'operazione.
	14-03-2017 12:04:30:624 RunCommand: INSERT INTO T43COMREPORTS (T43FileName, T43Descrizione, T43SQL, T43Order, T43Graphics, T43Web, T43ExportTxt, T43PostElab, T43CheckOrg) VALUES ('rlabadge.rpt', 'Badge Assegnati', 'SELECT T25Codice, T25Descrizione, T25Matricola, T25TipoMatricola, T25FlagSost, T26Codice, T26Nome, T26Cognome, T26BadgeAttivo, T26CodAzienda AS Azie, T26Gruppo, T25ID1, T25TipoTessera FROM T25ComBadge B LEFT JOIN T26ComDipendenti D ON D.T26Codice=B.T25Matricola AND D.T26CodAzienda=B.T25CodAziendaIE WHERE T25TipoMatricola=''0'' UNION ALL SELECT T25Codice, T25Descrizione, T25Matricola, T25TipoMatricola, T25FlagSost, T29Codice, T29Nome, T29Cognome, T29BadgeAttivo, T29Azienda AS AzIE, '''' AS T26Gruppo, T25ID1, T25TipoTessera FROM T25ComBadge BE LEFT JOIN T29ComEsterni E ON E.T29Codice=BE.T25Matricola AND E.T29Azienda=BE.T25CodAziendaIE WHERE T25TipoMatricola=''1'' UNION ALL SELECT T25Codice, T25Descrizione, T25Matricola, T25TipoMatricola, T25FlagSost, T31Codice, T31Nome, T31Cognome, T31BadgeAttivo, '		''' AS AzIE, '''' AS T26Gruppo, T25ID1, T25TipoTessera FROM T25ComBadge BV LEFT JOIN T31ComVisitatori V ON V.T31Codice=BV.T25Matricola WHERE T25TipoMatricola=''2''', '51', '0', '1', '0', '0', '10')
	14-03-2017 12:04:30:686 LoadTableFromXML: System.Data.OleDb.OleDbException (0x80004005): L'apporto modifiche non � riuscito perch� si � cercato di duplicare i valori nell'indice, nella chiave primaria o nella relazione. Modificare i dati nel campo o nei campi che contengono dati duplicati, rimuovere l'indice o ridefinire l'indice per consentire l'inserimento di voci duplicate, quindi ritentare l'operazione.
	14-03-2017 12:04:30:702 doUpgradeAccess: System.Exception: Errore caricamento dati

	Aggiornando Access dalla 620, pu� capitare che compaia l'errore sopra riportato: bisogna eliminare l'indice che Access crea deliberatamente andando su:
	_tabella T43COMREPORTS
	_dx visualizza struttura
	_icona fulmine (INDICI)
	_eliminare ..ORDER..
	(_se l'errore persiste, reinserire l'indice ORDER, con tipo 'Numerico' e valore vuoto)
	_salvare

(*) FILE SHARING LOCK COUNT EXCEEDED (INCREASE MAXLOCKSPERFILE)
(Solitamente dalla 6.20 alla 6.60)

	000000013 00000000000000002332
	16-07-2015 11:59:25:962 SetScreen ACCESS C:\MPW\DBATT\DBATT.MDB ver: 6.20 required: 6.60
	16-07-2015 11:59:29:752 doUpgradeAccess: Access 6.30
	16-07-2015 11:59:34:027 RunCommand: System.Data.OleDb.OleDbException: File sharing lock count exceeded. Increase MaxLocksPerFile registry entry.
	16-07-2015 11:59:34:027 RunCommand: UPDATE T37ACCTRANSITI SET T37ACCTRANSITI.T37CODSEDELOGICA='', T37ACCTRANSITI.T37DESCRSEDELOGICA='', T37ACCTRANSITI.T37CODTIPOVARCO='', T37ACCTRANSITI.T37DESCRTIPOVARCO='', T37ACCTRANSITI.T37CODMANSIONE='', T37ACCTRANSITI.T37DESCRMANSIONE='', T37ACCTRANSITI.T37CODCDC='', T37ACCTRANSITI.T37DESCRCDC='', T37ACCTRANSITI.T37DOCRICEVUTI='', T37ACCTRANSITI.T37CODTIPOSERVIZIO='', T37ACCTRANSITI.T37DESCRTIPOSERVIZIO='', T37ACCTRANSITI.T37CODTIPOVISITA='', T37ACCTRANSITI.T37DESCRTIPOVISITA='', T37ACCTRANSITI.T37DOCFORZATURA='', T37ACCTRANSITI.T37IDX='', T37ACCTRANSITI.T37TIPOTESSERA=''
	16-07-2015 11:59:34:042 doUpgradeAccess: System.Data.OleDb.OleDbException: File sharing lock count exceeded. Increase MaxLocksPerFile registry entry.
	16-07-2015 11:59:35:368 SetScreen ACCESS C:\MPW\DBATT\DBATT.MDB ver: 6.20 required: 6.60
	16-07-2015 12:02:38:094 SetScreen ACCESS C:\MPW\DBATT\DBATT.MDB ver: 6.20 required: 6.60
	16-07-2015 12:02:42:821 doUpgradeAccess: Access 6.30
	16-07-2015 12:02:47:095 RunCommand: System.Data.OleDb.OleDbException: File sharing lock count exceeded. Increase MaxLocksPerFile registry entry.
	16-07-2015 12:02:47:095 RunCommand: UPDATE T37ACCTRANSITI SET T37ACCTRANSITI.T37CODSEDELOGICA='', T37ACCTRANSITI.T37DESCRSEDELOGICA='', T37ACCTRANSITI.T37CODTIPOVARCO='', T37ACCTRANSITI.T37DESCRTIPOVARCO='', T37ACCTRANSITI.T37CODMANSIONE='', T37ACCTRANSITI.T37DESCRMANSIONE='', T37ACCTRANSITI.T37CODCDC='', T37ACCTRANSITI.T37DESCRCDC='', T37ACCTRANSITI.T37DOCRICEVUTI='', T37ACCTRANSITI.T37CODTIPOSERVIZIO='', T37ACCTRANSITI.T37DESCRTIPOSERVIZIO='', T37ACCTRANSITI.T37CODTIPOVISITA='', T37ACCTRANSITI.T37DESCRTIPOVISITA='', T37ACCTRANSITI.T37DOCFORZATURA='', T37ACCTRANSITI.T37IDX='', T37ACCTRANSITI.T37TIPOTESSERA=''
	16-07-2015 12:02:47:095 doUpgradeAccess: System.Data.OleDb.OleDbException: File sharing lock count exceeded. Increase MaxLocksPerFile registry entry.
	16-07-2015 12:02:48:468 SetScreen ACCESS C:\MPW\DBATT\DBATT.MDB ver: 6.20 required: 6.60

	Quando, aggiornando DB Access, compare il seguente errore (nel mio caso aggiornando MicronUtility da 620 a 660) bisogna aumentare il valore DECIMALE della chiave di registro come indicato nel dispatcher Microsoft.
	Res.: https://support.microsoft.com/en-us/kb/815281/it
	Res.: https://support.microsoft.com/it-it/help/815281/-file-sharing-lock-count-exceeded-error-message-during-large-transaction-processing



(*) INDEX OR STATISTICS WITH NAME 'IX_T108COMDATIAGGIUNTIVI' ALREADY EXISTS

	22-05-2018 16:20:29:574 RunCommand: CREATE NONCLUSTERED INDEX IX_T108COMDATIAGGIUNTIVI ON T108COMDATIAGGIUNTIVI (T108TIPOMATRICOLA, T108FIELDID) INCLUDE (T108MATRICOLA, T108AZIE, T108VALORE)
	22-05-2018 16:20:29:574 doUpgradeSQL: System.Data.OleDb.OleDbException (0x80040E14): The operation failed because an index or statistics with name 'IX_T108COMDATIAGGIUNTIVI' already exists on table 'T108COMDATIAGGIUNTIVI'.
	22-05-2018 16:20:30:403 SetScreen MSSQL (LOCAL) ver: 6.80 required: 7.30

	Semplicemente, sull'Object Explorer:
	- MRT > Tables > T108COMDATIAGGIUNTIVI > Indexes > IX_T108COMDATIAGGIUNTIVI <--- eliminare questo indice


(*) CANNOT OPEN DATABASE "MRTBAK" REQUESTED BY THE LOGIN
(Solitamente dopo un aggiornamento di versione)

	31-05-2018 16:15:57:653 *** SQL Server 10.50.2500.0 SP1 Standard Edition (64-bit)
	31-05-2018 16:15:57:731 OpenDBConnBackup: System.Data.OleDb.OleDbException (0x80004005): Cannot open database "MRTBAK" requested by the login. The login failed.

	Soluzione:
	T05COMFLAG:COMF/DBBACKUP/0 (o equivalente in MicronConfig > Tabelle > Parametri Generali > Abilita database di backup = 0)

(*) NOCHECK ADD CONSTRAINT ... PRIMARY KEY CLUSTERED
(Solitamente dalla 6.80 alla 7.00)

	27-06-2018 15:43:07:731 RunCommand: ALTER TABLE [dbo].[T06COMMONITORTERMINALI] WITH NOCHECK ADD CONSTRAINT [PK_T06COMMONITORTERMINALI] PRIMARY KEY CLUSTERED ( [T06TERMINALE]) ON [PRIMARY]
	27-06-2018 15:43:07:731 doUpgradeSQL: System.Data.OleDb.OleDbException (0x80040E2F): The statement has been terminated.

	Soluzione:
	Il problema � dovuto al fatto che prima della 7.00 era possibile duplicare i codici terminali nel database purch� appartenenti ad impianti diversi.
	Il vincolo di codici terminali univoci � stato posto successivamente nelle tabelle T06COMMONITORTERMINALI, T22ACCTERMINALI e T75ACCALTCONFIG
	Si pu� utilizzare una query per individuare quali record sono doppi nella colonna T06TERMINALE, T22CODICE oppure T75CODICE (v. Query utili)
		Es.	USE MRT
			SELECT t06terminale, count(*) 
			from t06commonitorterminali 
			group by t06terminale 
			having count(*)>1
			order by count(*) desc
	Se il problema � nella T06COMMONITORTERMINALI, � sufficiente cancellare tutto il contenuto della tabella
	Se il problema � nella T22ACCTERMINALI, si dovranno ricodificare tutti i codici terminali doppi

(*) L'ISTRUZIONE � STATA INTERROTTA
In qualsiasi momento del DBUpgrade, ma solitamente fin dall'inizio

	20-07-2018 11:21:06:191 RunCommand: L'istruzione � stata interrotta.
	20-07-2018 11:21:06:191 RunCommand: ALTER TABLE [dbo].[T37ACCTRANSITI] WITH NOCHECK ADD T37LAT [decimal](9, 6) NOT NULL DEFAULT 0.0 WITH VALUES,T37LONG [decimal](9, 6) NOT NULL DEFAULT 0.0 WITH VALUES,T37TIMEZONE [nvarchar](20) NOT NULL DEFAULT '' WITH VALUES

	- Errore generico, tipico di quando SQL Server non riesce a lavorare: � rimasto spazio sul disco dove � installato?

(*) CREATE UNIQUE NONCLUSTERED INDEX IX_T123ACCFASTPRENVISITATORI ON T123ACCFASTPRENVISITATORI
In questo caso, dalla 7.40 alla 7.50

	14-03-2019 11:36:00:513 RunCommand: CREATE INDEX failed because the following SET options have incorrect settings: 'ARITHABORT'. Verify that SET options are correct for use with indexed views and/or indexes on computed columns and/or filtered indexes and/or query notifications and/or XML data type methods and/or spatial index operations.
	14-03-2019 11:36:00:513 RunCommand: CREATE UNIQUE NONCLUSTERED INDEX IX_T123ACCFASTPRENVISITATORI ON T123ACCFASTPRENVISITATORI(T123INVITATIONCODE) WHERE T123INVITATIONCODE IS NOT NULL
	14-03-2019 11:36:00:529 doUpgradeSQL: System.Data.OleDb.OleDbException (0x80040E14): CREATE INDEX failed because the following SET options have incorrect settings: 'ARITHABORT'. Verify that SET options are correct for use with indexed views and/or indexes on computed columns and/or filtered indexes and/or query notifications and/or XML data type methods and/or spatial index operations.
	14-03-2019 11:36:01:935 SetScreen MSSQL DCSQLPROD01\SQLASLAT ver: 7.40 required: 7.50

		MRT > Properties > Options > Compatibility: SQL Server 2000 ---> SQL Server 2008
		(Non c'� bisogno di riavviare SQL Server)


# FIRMWARE
============================================================================================================================================

AGGIORNAMENTO

	Prima:
	- MicronConfig: A quale terminale bisogna cambiare il firmware? A quale servizio appartiene? Che nodo GNET ha?
	- Servizi: stoppa il servizio corrispondente; apri il NoService corrispondente
	- MicronConfig: Metti il servizio in Inizio Manutenzione

	Durante (GnConfig):
	- Seleziona nodo del terminale
	- Scegli nuovo firmware
	- Reinserisci gli indirizzi logici
	- "Seleziona tutto"
	- Doppio click sul nodo
	- Attendere che passino tutte le istruzioni (specialmente "master" e "slave")

	Dopo:
	- MicronConfig: ricaricare il file di configurazione nelle centraline coinvolte (� cambiato il firmware!)
	- MicronConfig: servizio in Fine Manutenzione
	- Verifica sull'app web (o ovunque debba funzionare) che funzioni la modifica





# MIGRAZIONE
============================================================================================================================================

MIGRAZIONE SERVER SU NUOVA MACCHINA VIRTUALE
Esempio: migrazione server da tecnologia VMWare a Hyper-V
Requisiti: va garantito dai responsabili della migrazione che non vi saranno variazioni ad IP, MAC Address e servername
Vanno comunque stoppate tutte le attivita� sul server appena prima dell�inizio della migrazione.

	Step di stop&start controllato del sistema:
	
	STOP: 
	Fermare IIS
	Fermare tutti i servizi di comunicazione Microntel (BTSERVICExx) 
	Fermare tutti i servizi database (DBISERVICE, MCLEARSRV, ecc.)
	Fermare eventuali schedulazioni di Windows (es. export timbrature)

	START:
	Start di tutti i servizi di comunicazione (BTSERVICExx)
	Start di tutti i servizi database (DBISERVICE, MCLEARSRV, ecc.)
	Start IIS
	Start eventuali schedulazioni di Windows (es. export timbrature)

	� possibile che sia necessario rinnovare la licenza del Sistema se nella macchina ospitante dovesse cambiare ID dell�hard disk oppure il codice di licenza del sistema operativo windows.


MIGRAZIONE APPLICATIVI
Esempio: dismissione di un server fisico/virtuale e migrazione di tutta la suite software su un nuovo server fisico/virtuale
Requisiti: ovviamente il nuovo server deve poter raggiungere l'impianto e deve poter fungere da web server

� VERIFICHE PRELIMINARI

	Su macchina vecchia:
	- Qual � la versione del software e qual � il tipo di chiave? -> sito licenze
	- Quali applicativi sono installati? -> contenuto della cartella MPW o su MicronConfig
	- Quali servizi sono online? -> da services.msc
	- I terminali sono tutti su ethernet? -> verificare da gnconfig se hanno indirizzo IP
	- Che versione c'� di SQL Express?
	Su macchina nuova:
	- Qual � il Sistema operativo, i bit, spazio libero su disco? -> Propriet� del Computer
	- Framework 4.0 � installato? -> C:\Windows\Framework .NET\ vedere versioni presenti

� MIGRAZIONE

	Da qui in poi, "old" per le operazioni da fare sulla macchina vecchia, "new" per quella nuova:
	
	- Old: Fermare tutti i servizi!
	- Old: Copiare cartella MPW (segnarsi il percorso) da macchina vecchia a macchina nuova (tipo su desktop, rinominandola con un _). 
	
	(*) La copia di questa cartella fa solo da backup. 
	(*) Potrebbe volerci un bel po' per il trasferimento. In tal caso, fai una copia locale della cartella, comprimi la copia e poi trasferiscila alla macchina nuova

	- Old: SQL Server Manager > Database > MRT (o nome del DB) click destro > Attivit� > Backup. Backup su "disco". Scegliere un percorso e dare estensione .bak. Copiare su macchina nuova.

	SQL: creare un'istanza e un account d'accesso
	- New: Installare SQL Express (versione pi� recente)
	- New: SQL Server Manager > Database > MRT (o nome del DB) click destro > Ripristina > Database. Nome database: MRT, Dispositivo: mettere percorso origine del .bak precedentemente salvato

	(*) Nel trasferimento file via TeamViewer, controlla che il .bak sia stato trasferito interamente!
	(*) Nel caso l'avessi fatto prima, il MicronStart (e in particolare l'upgrade del DB) va RIFATTO dopo aver ripristinato il database da una macchina all'altra

	- New: SQL Server Manager > Sicurezza > Account di accesso - click destro > Nuovo account di accesso. Dare Nome: sa, "Autenticazione di SQL", password: Micro!Mpw13, Togli spunta ad "Applica criteri", Database predefinito: MRT. Menu a sinistra > Mapping utenti > spunta su MRT; sotto: spunte su db_owner, db_datareader, db_datawriter.

	Micronpass Web:
	- New: Installa MPW 7. Fare attenzione che sia sullo stesso disco su cui era nella macchina vecchia, e che sia ricreata (se c'era) la cartella delle timbrature (cio� che il percorso di export timbrature sia lo stesso).
	- New: copia la cartella MPW\gnconfig dal vecchio MPW al nuovo MPW, sovrascrivendola
	- New: MicronStart, fare il test di connessione (con l'utente appena creato) e l'upgrade del DB
	- New: MicronConfig: per tutti i servizi, fare click e premere su "Default" per ristabilire l'indirizzo IP
	- New: creare la nuova licenza
	- New: abilita Multipolling sui parametri
	- New: MPW\MicronService > MultiService > Installa fin quando non sono coperti tutti i servizi che c'erano prima

� VERIFICHE FINALI

	- Mpassw: gestione utenti (ripristinare utenti), gestione badge (autorizzazioni), report transiti (vedere se funzionano)




# MICRONDIFF
============================================================================================================================================

MicronDiff � un piccolo programma che prende in pasto il pacchetto di installazione mPassInst.msi della versione A, lo stesso pacchetto della versione B e ne computa la differenza, creando uno .zip che contiene solo i file da cambiare e sostituire per aggiornare la versione. Mi raccomando che i file .msi siano dello stesso tipo, cio� pacchetti di installazione dello stesso programma (cio�, non comparare pacchetto di installazione dell'intera application suite con pacchetto di installazione del solo Micronpass Web).

(*) MicronDiff NON sostituisce un aggiornamento in stile classico, ma sostituisce solo POCHI FILE, per lo pi� legati a uno o pochi applicativi. Es: un aggiornamento di Mpassw per installare una personalizzazione, o l'aggiunta di un piccolo dettaglio (tipo due spunte) a una personalizzazione gi� esistente.
(*) MicronDiff si pu� usare per l'aggiornamento del solo Micronpass Web, in quanto restituisce i file da sovrascrivere per il cambio di versione nella cartella MPW\Micronpass

Dove trovare i .msi SOLO dei Micronpass nel server BiTech:

- Versioni < 7.0: /MRT/MRT_FX2_PC_EXE/MicronPass
- Versioni > 7.0: /MRT/MRT_FX4_PC_EXE/Micronpass

In entrambi i casi, utilizzare l'ULTIMA versione disponibile del MicronDiff (nella fattispecie, MicronDiff2.0.0)

Crea cartella "diffOLD" e inserire dentro mPassInst.msi versione old
Crea cartella "diffNEW" e inserire dentro mPassInst.msi versione new


Parametri
-----------------------------------------------------
File old: percorso del file pi� vecchio	(es. C:\...\diffOLD\mPassInst.msi)	
File new: percorso del file pi� recente (es. C:\...\diffNEW\mPassInst.msi
Zip dest file: nome del file .zip contenente le differenze (es. C:\...\diff.zip)
Web Application: se si tratta di un'applicazione web (es. S�)
Dest dir name: nome della cartella dentro cui mettere le differenze, a sua volta dentro il file zip (es. Micronpass)
Create DIFF ZIP: pulsante per far iniziare la creazione del .zip di differenze 

Passaggi
-----------------------------------------------------
Estrazione file msi
Copia da directory virtuale diffvirtdir
Controllo file ...
Comparazione completata!




# MICRONRECEPTION E LETTORI USB (ACR122U)
============================================================================================================================================

INTRODUZIONE
-----------------------------------------------
Prerequisito fondamentale � il MicronReception nel MRT.LIC.
La funzionalit� descritta consente di utilizzare lettori di badge USB per svolgere funzioni rapide di ricerca, assegnazione, caricamento di badge tipiche attivit� svolte in reception direttamente da Micronpass WEB.
L'uso dei lettori USB nelle funzioni di lettura badge del Micronpass Web discende dal non pi� usato MicronReception:
- "Gestione badge", in fase di inserimento di un nuovo badge
- "Assegnazione badge", "Wizard sostituzione badge" e tutte le maschere in cui � previsto il controllo di ricerca del badge
- "Ricerca per badge"
In ciascuna di queste maschere, una volta conclusa l'installazione del lettore, apparir� il link "Leggi da lettore USB".
Cliccandovi, apparir� la scritta rossa "Attesa lettura" durante la quale si dovr� appoggiare il badge sul lettore.
Al termine della lettura, il codice badge letto (ID) verr� sovrascritto al campo filtro.

N.B.:
L' "Arruolamento" (effettuato dalle Postazioni di Arruolamento) consiste nell'assegnare una nuova tecnologia a un nominativo che possiede gi� una tecnologia. Per esempio, nel caso in cui si fosse interessati ad avere dei badge Mifare, l'arruolamento consiste nel prendere dei badge che gi� possiedono una tecnologia a banda magnetica - non utilizzata - e caricarvi sopra le informazioni relative alla lettura di prossimit�. In questo modo, un badge dotato di un codice riceve un nuovo codice relativo a un'altra tecnologia, che sar� poi inseribile in Micronpass Web per l'aggiunta di un nuovo badge.


LETTORI USB (ACR122U, PCR300,ecc.) - vecchia gestione
-----------------------------------------------

CONFIGURAZIONE LETTORI USB

	� INSTALLAZIONE DRIVER

		Dopo aver collegato il lettore ad una porta USB � necessario installare i drivers inclusi.

		79.11.21.211/Fascicoli/Lettori_Periferiche/Lettore_PartnerData_ACR122U_last driver	

		(*) A partire da Windows 7, Microsoft ha introdotto i driver anche per le tessere smartcard. Per quanto concerne i nostri applicativi, quando si utilizza un lettore standard PC/SC (quindi con tessere MiFare), ad ogni lettura Windows 7 cerca di installare il driver relativo alla smart card e, puntualmente da un avviso di non riuscita dell�operazione. Questo avviso, per quanto noioso, non provoca malfunzionamenti all�applicativo. Nella cartella di configurazione client � stato previsto un batch (Win7off.bat), da eseguire come amministratore, che imposta Windows 7 per non eseguire un rilevamento automatico delle smartcard quando vengono appoggiate sul lettore USB. Dopo aver eseguito il batch � necessario il riavvio. Questo batch non deve essere eseguito in presenza di altri applicativi che utilizzino le smart card (p.e. login di Windows con utilizzo delle smartcard). Il batch deve essere eseguito solamente su Windows 7.

	� CONFIGURAZIONE CLIENT SU INTERNET EXPLORER

		- Eseguire il file FX20Security2_Intranet.bat (� possibile che sia necessario riavviare il PC)
		- Su Internet Exlorer, aggiungere MPW alla Intranet

		oppure:

		- Eseguire il file FX20Security2_sitiattendibili (� possibile che sia necessario riavviare il PC)
		- Su Internet Explorer, aggiungere MPW ai Trusted Sites

		- Attivare comunque la Visualizzazione Compatibilit�

	� CONFIGURAZIONE LATO UTENTE MPASSW

		- Utenti > Gestione Utenti > [sel.Utente che user� il lettore]: � possibile specificare quale modello di lettore viene usato, in modo da non dover svolgere alcuna attività di configurazione per gli utenti che non siano di reception. Il parametro "Modello lettore USB" pu� assumere i valori:
			* Nessuno: nessun lettore USB
			* Lettore standard PC/SC: lettori di tessere MiFare, e.g. ACR122U di ACS
			* Promag PCR-340: lettore seriale di tessere 125Khz
			* Promag PCR-300A: lettore USB di tessere 125Khz
			* Posh MX5: lettore USB di tessere 125Khz

		(*) Se il menu a tendina di scelta del lettore di badge � vuoto, significa che il cliente non ha MicronReception nella licenza!!

		- Adesso MicronReception � attiva per quel cliente (si vede il simbolo del badge in alto a sinistra, vicino al nome della licenza): a quel punto � disponibile la funzione 'lettura badge' nella pagina Badge & Chiavi, cos� come la funzione di Arruolamento Badge


	PARENTESI: 125kHz - TRW USBN Q5 S

		Configurazione server:
		- MicronConfig > Parametri > Micronpass > Tecnologia tessera per lettori USB = 1
		- MicronConfig > Parametri > Micronpass > Algoritmo di conversione per lettura USB locale di badge = nessuna conversione
		- MicronConfig > Parametri > Micronpass > Algoritmo di conversione per scrittura USB locale di badge a 125 kHZ = nessuna conversione
		- MicronConfig > Parametri > Micronpass > Abilita accesso all'hardware da tutti i browser = S�
		- MicronConfig > Parametri > Micronpass > Elenco tipi testina da utilizzare per dati traccia in scrittura e lettura tessere 125 kHz = 1
		- MicronConfig > Tabelle > Tecnologie testine > Definire:
			256-UsbReader,SEDE,20,0,0,0,0,1,20,TagFull

		Configurazione client:
		- Installare i driver del lettore
		- Impostare porta COM256
		- Copiare sul client la cartella TrayClient, scompattare e lanciare il file MRTXB.CLIENT.WPF.EXE
		- Nelle impostazioni, inserire il link intranet del Micronpass Web

		Configurazione applciazione web:
		- Gestione utenti > [utente] > Modifica > Lettore USB = TRW USBN Q5 S
		- Da Gestione Badge > Scrivi Badge oppure da Anagrafica > Comandi > Scrivi Badge


	PARENTESI: POSH MX5

		Configurazione client:
		- Installare MX5 Utility --> Anche se va in errore, include comunque l'installazione dei driver
		- Gestione dispositivi > Associare la porta COM256 al lettore

VERIFICHE FUNZIONAMENTO LETTURA

	� GACUTIL
	
		Richiamando la funzione di lettura badge da lettore usb il server trasmette localmente il file webcard.dll necessario per il colloquio tra il driver del lettore usb e l'interfaccia web. Per vedere se il file webcard.dll � stato inviato dal server Micronpass Web e ricevuto dal client, si pu� utilizzare uno strumento di diagnostica chiamato gacutil. Si trova nella cartella C:\MPW\GACUtil. Eseguendo gacutil.exe su prompt � possibile avere una panoramica dell'uso dell'applicazione. Come si pu� vedere dalla sintassi dei comandi, � possibile verificare quanti file si trovano nella Download Cache digitando su prompt:

			gacutil /ldl

		Se il risultato dopo "Numero di elementi" � pari a 0, pur avendo effettuato una lettura da lettore USB da Micronpass web, significa che il file non � stato scaricato sul pc locale.


	� ATTESA LETTURA

		Se il comando precedente restituisce un valore >=0, allora la webcard.dll � stata trasmessa correttamente, ma pu� capitare che su Micronpass Web rimanga "Attesa lettura". Ricordarsi di disattivare il Firewall!


	� DIAGNOSTICA F12

		Prima di cliccare su "leggi da lettore usb" premere all'interno del browser il tasto F12. La funzione F12 apre la diagnostica della pagina web in corso - selezionare RETE - e premere "play" da quel momento per ogni funzione verranno visualizzate le chiamate dal client verso il server, cliccando su "leggi da lettore USB" dovrebbe visualizzare la funzione di richiamo del file WEBCard.dll e l'eventuale errore. Tipicamente problemi di restrizione sul browser. 


	� LOG MPASSW

		� possibile che l'errore dipenda dal software o dal servizio stesso, per esempio che un comando inviato non sia stato ricevuto, o che il salvataggio di una modifica non sia stato effettuato. In tal caso � bene consultare il log di Micronpass Web, tipicamente al percorso C:\MPW\MicronPass\log\mpwError.txt.


	� LOG IIS

		In alcuni casi, qualora per l'utente non fossero disponibili i privilegi per verificare il corretto funzionamento del sito web tramite F12, � possibile dare un'occhiata al log dell'application pool. 
		Di solito il percorso � C:\inetpub\logs\LogFiles\W3SVC1.
		Il file log appare con la seguente intestazione:

			#Software: Microsoft Internet Information Services 7.5
			#Version: 1.0
			#Date: 2015-06-15 06:41:09
			#Fields: date time s-ip cs-method cs-uri-stem cs-uri-query s-port cs-username c-ip cs(User-Agent) sc-status sc-substatus sc-win32-status time-taken

		Di seguito riportiamo alcuni dei campi pi� utili per leggere il log dell'IIS:

			date		Data		Data dell'attivit�
			time		Ora		Ora, in UTC, dell'attivit�
			c-ip		IP-Client	Indirizzo IP del client che ha inviato la richiesta
			cs-method	Metodo		The requested action, for example, a GET method
			cs-uri-stem	URI Stem	The target of the action, for example, Default.htm.
			(...)
			sc-status	HTTP status	Lo status code dell'HTTP
			sc-substatus	HTTP sub-status	Il sub-status code dell'HTTP
			sc-win32status	Win32 status	Codice di errore di sistema di Windows 
			time-taken 	Tempo 		Tempo necessario a inviare la risposta, in millisecondi

		Per verificare che il file webcard.dll sia effettivamente stato richiesto dal pc locale, inviato dal server e ricevuto dal pc locale, � necessario leggere la corrispettiva lettera nel log dell'IIS. Leggere alla data e ora corrispondente a quella in cui l'attivit� � stata inviata (cio� � stata richiesta la lettura del badge da lettore USB): in tal caso, il campo cs-method dovrebbe corrispondere a "GET", il campo cs-uri-stem a "webcard.dll" (o "webcard2.dll") e i campi di status pari a "200 0 0" (200 significa che � andato a buon fine). Verificare che tutto vada bene.


	� BATCH PER FORZATURA INTRANET
	
		Se non dovesse ancora funzionare provare ad eseguire FX20Security2_Intranet.bat (permette il funzionamento del lettore USB all'interno dell'interfaccia WEB, che sfrutta componenti Dotnet, garantita tra i siti attendibili (Intranet Area)). � di fatto uguale al file batch FX20Security2.bat, dove per� - al di l� di rinominare il file - � stato sostituito "trusted_zone" con "LocalIntranet_zone". Eseguire il .bat come amministratore e poi riavviare il pc.
		Nel dubbio, nel caso in cui si avessero restrizioni a salvare il server tra i siti attendibili, � possibile utilizzare questa chiave di registro

			Windows Registry Editor Version 5.00

			[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\<indirizzoIP>]
			"*"=dword:00000002

		Copiare in un file di testo, salvare come .bat ed eseguire come amministratore, poi riavviare.


	� SOVRAPPOSIZIONE DLL
	
		Caso Alcatel: � possibile che il server non riesca a mandare il file WebCard.dll perch� la comunicazione � gi� usata per un altro file. Cercare su IIS > MpassW > Mapping Gestori > ISAPI-dll, che alla voce "Percorso" deve dire "*.dll". Questo significa che tutti i file dll vengono inviati e ricevuti tramite lo stesso canale. 
		Verificare che non esistano, in elenco, altre voci di tipo dll. Nel caso in cui ci fossero altri file, cliccare su "Restrizioni" e mettere "Nessuna"

	� AGGIORNAMENTI DI WINDOWS 10
	
		Spesso, negli aggiornamenti scaricati automaticamente da Windows 10, appare un fix della patch di sicurezza che rimuove le chiavi di registro create dal batch FX20security.
		Si pu� verificare esplorando il registro e cercando le seguenti chiavi:
			HKLM\SOFTWARE\MICROSOFT\.NETFramework -> EnableIEHosting
			HKLM\SOFTWARE\WOW6432NODE\MICROSOFT\.NETFRAMEWORK -> EnableIEHosting
		Se le chiavi non ci sono, eseguire nuovamente da Amministratore il file bat: a quel punto dovrebbe bastare riavviare Internet Explorer perch� le funzioni del lettore USB tornino attive; altrimenti, rendere effettiva la variazione riavviando il PC

	� VIOLAZIONE CONDIVISIONE

		Dopo l' "attesa lettura", non appena si appoggia il badge sul lettore appare l'errore "Violazione condivisione".
		Questo nasce dal fatto che potrebbe stare girando un programma con accesso esclusivo alla Smart Card, oppure le policy del sistema operativo potrebbero semplicemente essere settate in maniera tale da garantire tale accesso esclusivo a Windows stesso (il problema era stato risolto 'forzando' tali policy con il file Win7.bat per Windows 7, ma � facile che le stesse policy siano state mantenute per Windows 8, 8.1 e 10).
		Per approfondire la parte legata alle policy e vedere come risolverle, leggere qui:
			http://chris-evans-dev.blogspot.it/2011/03/smartcard-pcsc-scardconnect-sharing.html


TRAYCLIENT
-----------------------------------------------
Documentazione di riferimento: MT_MRT_TrayClient.doc

PREREQUISITI:

	MRT >= 7.4.0, compreso nel pacchetto di installazione
	IIS > Protocollo WEBSOCKET abilitato
	SO > Windows Vista SP2
	Framework 4.5.2
	MicronConfig > Parametri > Micronpass Web > Abilita accesso all'hardware da tutti i browser
	Driver ACR 122 U 'Unified' (scaricabili dal sito ACS)
	Qualunque browser

INSTALLAZIONE:

	- Da C:\MPW\TrayClient, copiare il pacchetto $TrayClientXXX.zip e incollarlo sul client
	- Scompattare il pacchetto sul client in qualsiasi cartella
	- Inserire l'eseguibile MRTXB.Client.Wpf.exe nell'esecuzione automatica
		in Windows Vista/7:	C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
		in Windows 8:		C:\Users\<nomeprofilo>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
		in Windows 10:		C:\Users\<nomeprofilo>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
			o anche: Esegui > "shell:startup" (utente locale) oppure "shell:common startup" (tutti gli utenti)

PARAMETRAZIONE AL PRIMO AVVIO:

	- Eseguire MRTXB.Client.Wpf.exe (o fare doppio click sull'icona della Microntel nel Tray di Windows) per lanciare il Microntel Card Reader
	- TrayClient > Impostazioni: inserire l'indirizzo completo del micronpass (es. http://localhost/mpassw)
	- TrayClient > Impostazioni: Definire un intervallo di riconnessione (default a 5000s, si pu� lasciare quello)
	- TrayClient > Salva: l'icona del TrayClient diventa rossa (connesso)

USO DEL TRAYCLIENT:

	- TrayClient > Info: fornisce informazioni di troubleshooting sullo stato della connessione e il log delle attivit�
	- TrayClient > [Click destro sull'icona] > Stato: stato della connessione
	- TrayClient > [Click destro sull'icona] > Connetti/Disconnetti: cambia stato della connessione
	- TrayClient > [Click destro sull'icona] > Esci: chiusura dell'applicativo
	
USO SU MICRONPASS WEB:

	- Stesse funzionalit� della vecchia Micronreception, ma con un asterisco

	(*) Se l'applicativo non � connesso, appare messaggio di errore "Trayclient non connesso"


� PARAMETRAZIONE UTILE
Per qualsiasi cosa, verificare i seguenti parametri:

- MicronConfig > Micronpass > Abilita accesso all'hardware da tutti i browser = S�/no		% Attiva la gestione MicronTrayClient o lascia la vecchia gestione MicronReception
- MicronConfig > Micronpass > Algoritmo di conversione per scrittore USB locale di badge a 125 kHz = 	% v. documentazione Micronpass Web 7.0.18
					Nessuna conversione		% Legge esattamente la traccia RFID del badge
					Inversione ordine dei byte	% 990011AABBCC diventa CCBBAA110099


ERRORI:

	(*) ERRORE 0x90000001 ID diverso della tessera
	Appare solitamente usando le funzioni di scrittura da Micronpass Web (es. arruolamento badge offline).
	- MicronConfig > Parametri > Micronpass > Algoritmo di conversione per lettore USB locale di badge = [cambiare da "Nessuna conversione" a "Inversione ordine dei byte"]
		***Attenzione ad eventuali Mifare gi� registrati col lettore USB! Se cambia l'algoritmo di conversione, andranno ri-registrati.

	(*) ERRORE 0x9000000E Numero massimo di blocchi per carta superato
	� un controllo preliminare effettuato dal Micronpass Web: verifica che il layout che si sta cercando di scrivere corrisponda all'effettiva quantit� di blocchi di memoria disponibili sulla carta (l'errore appare se, per esempio, a database � configurata una capacit� tessere offline a 4K ma la tessera soggetta a scrittura ha solo 1K)
	Controllare su database T25COMBADGE > T25SMARTCARDTYPECODE
		= NULL 		% significa che i parametri considerati sono quelli della T05 (Parametri Generali del MicronConfig)
		<> NULL		% i parametri corrispondono ai valori del corrispondente codice T80CODE nella tabella T80ACCSMARTCARDPARAMETERS (si trova anche su MicronConfig > Tabelle > Tecnologie Smart Card)

	(*) ERRORE 0x90000004 Troppi lettori rilevati
	Il client da cui si sta cercando di scrivere la tessera ha gi� un dispositivo smartcard encoder attivo. 
	L'errore pu� essere leggermente fuorviante perch� tutte le funzioni di lettura vanno a buon fine, ma non quelle di scrittura, che restituiscono questo errore.
	- Disattivare il secondo scrittore smartcard a bordo della postazione e riprovare; non c'� bisogno di riavviare il TrayClient


# IIS
============================================================================================================================================

FUNZIONALITA' DA ATTIVARE
-----------------------------------------------

SERVER MANAGER > DASHBOARD > LOCAL SERVER > ROLES AND SERVICES
Server Roles:
	Web Server (IIS)
		Common HTTP Features:
			Default document (default)
			Directory Browsing (default)
			HTTP Errors (default)
			Static Content (default)
		Health and Diagnostics
			HTTP Logging (default)
		Performance
			Static Content Compression (default)
		Security
			Request Filtering (default)
		Application Development
			.NET Extensibility 3.5
			.NET Extensibility 4.6
			Application Initialization
			ASP
			ASP.NET 3.5
			ASP.NET 4.6
			CGI
			ISAPI Extensions
			ISAPI Filters
			Server Side Includes
			WebSocket Protocol
		Management Tools
			IIS Management Console
			IIS 6 Management Compatibility
				IIS 6 Metabase Compatibility
				IIS 6 Management Console
				IIS 6 Scripting Tools
				IIS 6 WMI Compatibility
			IIS Management Scripts and Tools
			Management Service

Server Features:
	.NET Framework 3.5 Features
		.NET Framework 3.5 (includes .NET 2.0 and 3.0)
	.NET Framework 4.6 Features
		.NET Framework 4.6 (default)
		ASP.NET 4.6
		WCF Services
			TCP Port Sharing (default)
	Telnet Client


AUTENTICAZIONE
-----------------------------------------------
Per "capacit� di protezione" si intende la possibilit� di proteggere un'applicazione e i relativi dati. Utilizzare la pagina di funzionalit� 'Autenticazione' per configurare i metodi di autenticazione utilizzati dai client per accedere al contenuto. 
- "Autenticazione anonima": consente a qualsiasi utente di accedere a qualsiasi contenuto pubblico, senza fornire un nome utente e una password. Per impostazione predefinita, � attivata in IIS 7.  Utilizzarla quando si desidera consentire a tutti i client che accedono al sito di visualizzarne il contenuto. 
- "Rappresentazione ASP.NET": consente di eseguire applicazioni ASP.NET in un contesto diverso da quello dell'account ASPNET predefinito. Se abilitata, l'applicazione potr� essere eseguita come utente autenticato da IIS o come account arbitrario impostato. 


PROPRIETA' APP POOL
-----------------------------------------------

� IDLE TIMEOUT
Pannello di Controllo > Strumenti di Amministrazione > Pool di applicazioni > Impostazioni avanzate > Timeout di Inattivit�


RICICLARE APP POOL DA CMD
-----------------------------------------------
AppCmd � lo strumento di amministrazione generico di IIS per la riga di comandi
La sintassi � Appcmd (comando)(tipo-oggetto) <identificatore> </parametro1:valore1...>

Dal percorso cd %windir%\system32\inetsrv, lanciare 
	C:\Windows\System32\inetsrv\appcmd recycle apppool /apppool.name:<NomeAppPool> 

Identicamente, si pu� usare
	C:\Windows\System32\inetsrv\appcmd start apppool /apppool.name:<NomeAppPool> 
	C:\Windows\System32\inetsrv\appcmd stop apppool /apppool.name:<NomeAppPool> 	

ATTIVARE PROTOCOLLO HTTPS/SSL
-----------------------------------------------


DIAGNOSTICA
-----------------------------------------------
(*) RECUPERARE CONFIGURAZIONE IIS
Recover IIS When ApplicationHost.config is Ruined
(https://www.codeproject.com/Tips/630880/Recover-IIS-When-ApplicationHost-config-is-Ruined)
Sometimes we have to manually modify applicationHost.config. It is risky because bad editing can ruin the file and cause IIS to be broken. IIS cannot recover even after we have fixed the errors in all applicationHost.config files appeared on the machine and have restarted the machine. 

	Soluzione:
	- Aprire CMD e lanciare i seguenti comandi
		cd C:\Windows\System32\inetsrv
		appcmd backup
		appcmd restore backup <backup name>
	Note: You need to open the backup file and check if it contains errors before you choose it to recover IIS. You could find these backup files in C:\inetpub\history. The sub folder names are the same as the backup names.

(*) HTTP ERROR 500.19, ERROR CODE 0x8007007e
"The requested page cannot be accessed because the related configuration data for the page is invalid"
L'errore significa che il modulo non pu� essere trovato: il DynamicCompressionModule � l'origine dell'errore.

	Ragione:
	Questo errore significa che WSUS (Windows Server Update Services) � installato sul server.
	Questo servizio attiva la compressione a 64-bit che causa il failure delle applicazioni a 32-bit.

	Soluzione:
	Bisogna disattivare la compressione WSUS lanciando il seguente comando:
		%windir%\system32\inetsrv\appcmd.exe set config -section:system.webServer/httpCompression /-[name='xpress']
	Nel caso servisse riattivarla, lancia invece:
		%windir%\system32\inetsrv\appcmd.exe set config -section:system.webServer/httpCompression /+[name='xpress',doStaticCompression='false',dll='%windir%\system32\inetsrv\suscomp.dll']




# MICRONIMPORT
============================================================================================================================================

L�applicativo MicronImport nasce dall�esigenza di importare i dati relativi alle matricole (dipendenti e collaboratori esterni, e loro raggruppamenti) e dei badge nel database complesso MRT, sia per una installazione iniziale che in tempo reale, consentendo cos� al cliente finale l�inserimento di nuove matricole senza dover essere costretti ad inserire manualmente i dati pi� volte, evitando cos� potenziali dati di digitazione. 
L�applicativo, come gi� il micronService, si presenta nella doppia versione:
- Stand-alone (NoService): La versione NoService � utile per le importazioni di dati �di massa� iniziali da svolgere durante l�installazione ma consente anche di verificare la validit� del file di import in formato testo prima di avviare la versione basata su servizio di sistema. Serve per importazioni �una tantum� in fase di installazione, quindi importazioni di massa senza inviare comandi ai servizi (infatti sar� pi� conveniente al termine dell�importazione effettuare un azzeramento memorie dei terminali invece di inviare tutti i comandi che intasano inutilmente la rete) e importazioni di prova che consentono (previo BACKUP del database) di valutare la correttezza di tutte le parametrazioni effettuate.
- Servizio di sistema (Service): Non ha un'interfaccia video, pu� essere avviato o arrestato da services.msc
Entrambe le versioni possono, a mezzo parametro nel file config, inviare comandi al micronService per l�aggiornamento in tempo reale dei dati di abilitazione ai terminali.


PREREQUISITI
-----------------------------------------------

File anagrafiche:
Chiedere al cliente (HR) un file delle anagrafiche (possibilmente excel) contenente tutti i campi che si voglia inserire nella scheda dipendente. Mpassw consente di salvare "Dati base" e "Dati aggiuntivi":

- Dati base: Azienda interna, Codice [cio� matricola, che deve essere univoca], Nome, Cognome, Data di nascita, Sesso, Codice Fiscale, Telefono, Cellulare, email, Badge. Quelli fondamentali sono, nell'ordine: tipo matricola (valore fisso = 1 per i dipendenti), 
- Dati aggiuntivi: tutto quello che si vuole, saranno poi messi nei "campi programmabili"
 
Consideriamo adesso un file di anagrafiche fornito dal cliente in formato excel, che contenga pi� campi di quelli normalmente inseriti nella scheda anagrafica di MicronPass Web. 
- Cambiare il file in maniera che tutti i dati siano presenti nell'ordine richiesto
- Salvare (e NON copiare e cambiare l'estensione) con il nome di IMPORT.csv nella cartella X:\MPW\MicronImportNoService
- NON aprire il file csv a meno di non usare Textpad. Notare che l'estensione csv ha inserito ";" come separatore tra colonne.

Micronpass Web:
- Cancellare eventuali dipendenti/esterni/visitatori fittizi messi in fase di installazione o di formazione, altrimenti i dati potrebbero sovrascriversi, per esempio quelli dei badge (che rimangono assegnati alle anagrafiche fittizie)


(*) EXPORT da MICRONWEB:

	USE MW
	Select dipen.matricola,cognome,nome,azienda,dipen_badge.badge,dat_lic from dipen inner join dipen_badge on dipen.matricola=dipen_badge.matricola
	Where fine is null



CONFIGURAZIONE
-----------------------------------------------

� MICRONCONFIG

- Aprire MicronConfig e accedere
- Barra in alto > Tabelle > Campi programmabili
- Tipo di dipendenti: scegliere se Dipendenti, Esterni o Visitatori.
- Aggiungi > Descrizione: [descrizione campo cos� come apparir� in Mpassw] > Tipo campo: [tipo di input] > Lunghezza: [numero di caratteri/cifre max per inserire l'input] > Obbligatorio: s�/no
	(*) "Obbligatorio" significa che l'utente che aggiunge il dipendente DEVE inserire questo campo aggiuntivo, altrimenti l'anagrafica non viene salvata
- Segnarsi l'ordine e il contenuto dei campi programmabili, che andranno poi inseriti anche nel config del MicronImportNoService (v.subito sotto)


� MICRONIMPORTNOSERVICE

- Aprire NoServDBI.config.exe
- Di seguito sono riportati i campi pi� importanti:
	
	<!-- Stringa di connessione al database SQL Server -->
		<add key="SqlStr" value="Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Password=Micro!Mpw13;Initial Catalog=MRT;Data Source=(local)\sqlexpress;...></add>

	<!-- Dice se inviare i comandi ai servizi, valido per Servizio e NonServizio -->
		<add key="SendToServices" value="False"></add>
	
	<!-- Nome del file da importare compreso di percorso -->
		<add key="ImportFile" value="C:\MPW\MicronImportNoService\IMPORT.csv"></add>

	<!-- Nome del file da importare compreso di percorso -->
		<add key="ImportFile" value="C:\MPW\MicronImportNoService\IMPORT.csv"></add>

	<!-- Formati previsti per i campi data e ora (anche DATA DI NASCITA!) -->
	<!-- Usare yyyy oppure yy per l'anno, MM per il mese, dd per il giorno -->	
	<!-- Usare HH per le ore, mm per i minuti, ss per i secondi -->	
	<!-- Se ci sono separatori (-/. ecc...) nel file mettere GLI STESSI qui -->
	<!-- ATTENZIONE: LETTERE MAIUSCOLE e minuscole SONO controllate! -->
		<add key="DatePicture" value="ddMMyyyy"></add>	
		<add key="TimePicture" value="HHmmss"></add>

	<!-- Abilitazione modalit� CSV (True/False)) -->
		<add key="CSVMode" value="True" />

	<!-- Dice se saltare la prima riga del file CSV (magari contiene i nomi dei campi) (True/False)) -->
		<add key="CSVSkipFirstRow" value="True" />
    	
	<!-- Dice il separatore tra i campi CSV -->	
		<add key="CSVSeparator" value=";" />

	<!-- Definizioni dei campi da importare -->
	<!-- Mettere (pos,lunghezza) oppure "" per disabilitare campo -->	
	<!-- In modalit� CSV, invece, indica il numero del campo -->
		<ImportFields>    
			...
			<add key="01_TipoMatricola" value="1"></add>
			...
  		</ImportFields>

	(*) Inserire qui il valore della colonna sul foglio excel relativa al dato segnato dalla key.
	(*) Se nel campo "foto" si inserisce la colonna riferita alla Matricola, il software aggiunge l'estensione [.jpg] automaticamente

	<!-- Definizioni dei campi programmabili da importare -->
	<!-- Key: Mettere tipo matricola (0,1,2) + _ + numero del campo programmabile -->
	<!-- Value: Mettere (pos,lunghezza) oppure "" per disabilitare campo -->
	<!--       o per la modalit� CSV mettere la posizione numerica del campo -->
		<ProgFields>
    			<add key="0_1" value="12"></add> 	<!-- Luogo nascita -->
		</ProgFields>

	(*) Inserire qui, come da sintassi, il numero del campo programmabile (visibile su MicronConfig) e il valore relativo sulla colonna del foglio excel

	(*) AGGIORNAMENTO IDX
	Qualora si dovesse aggiungere un IDX ad un ID badge gi� presente e gi� assegnato e attivo, � sufficiente dare in pasto al MicronImport un file contenente ID-IDX; il MicronImport NON deassegner� il badge dal suo proprietario, ma far� solo l'update dell'IDX (vale anche in inserimento da zero)
	

IMPORT
-----------------------------------------------
- Fare un backup del database: da SQL Server Manager, click destro sul database > attivit� > Backup
- Interrompere i servizi BtService e DBIService
- Avviare MicronImportNoService
- Cliccare su "Controlla Struttura" per verificare che la struttura dell'importazione sia corretta

	(*) Con il "Controlla struttura" � possibile vedere tutto il contenuto del file di anagrafica. Fare attenzione a non lasciare delle righe vuote o delle righe prive di campi, in quanto potrebbero dare problemi in fase di importazione.

	(*) IMPORTAZIONE DI PROVA SQL: 
	restituisce un log SQL con su l'elenco delle modifiche che verrebbero fatte una volta eseguito l'import, e quindi anche eventuali errori
	
	(*) IMPORTAZIONE DI PROVA: 
	per la modalit� FULLSYNC CSV (v. sotto), si pu� verificare le modifiche che verrebbero apportate al database in caso di esecuzione dell'importazione vera e propria; la nuova funzione, al termine dell'elaborazione, presenta a video una piccola finestra che elenca i movimenti di cancellazione ed inserimento delle matricole con Cognome, Nome e codici relativi.

- Quando si � sicuri della struttura, effettuare un'importazione cliccando su "Importazione Manuale". NON arrestare la macchina n� il processo di importazione, altrimenti son cazzi per il database e si rischia di perdere tutto. 
- Riavviare DBIService nei servizi di sistema
- Verificare su Micronpass Web che l'importazione abbia avuto successo

� INTERFACCIA DI MICRONIMPORTNOSERVICE

- Ubicazione fisica del DB e del file da importare
- Parametri di importazione, il cui default viene preso dal file config
- Status bar
- "Importazione manuale" per lanciare l'importazione vera e propria
- "Controlla Struttura": fa comparire a video la finestra che consente di controllare di precisione della struttura definita in file config.
- Il tasto "Importazione di Prova" consente di lanciare un�importazione SENZA in realt� scrivere nulla sul DB, infatti per il caso dell�importazione di prova la procedura si limita a scrivere un enorme file di log che contiene tutti i comandi SQL che sarebbero eseguiti se fosse una reale importazione.
- Sulla destra il tasto "Attiva esecuzione automatica", consente di avviare lo schedulatore che si pone in attesa del giorno/ora definito in file config (e visualizzato nella griglia a sinistra) per lanciare l�importazione (cliccando su questo bottone, in pratica, si ottiene il medesimo funzionamento della versione servizio).


DETTAGLI
-----------------------------------------------

(*) STORICO:
Da utilizzare sia per MicronImport sia per MicronImportNoService!

	<!-- Dice se deve tenere uno storico dei file importati quanti e dove mettere 0 per disabilitare-->
    	<add key="KeepFiles" value="0"></add>	<!-- Quantit� di file di storico da salvare -->
    	<add key="KeepPath" value="C:\MPW\MicronImportNoService\storico"></add>	<!-- Percorso completo del file di storico; il nome corrisponde alla data/ora -->


(*) PARSING:
Da usare con Storico attivo! Il parsing � utile per importare solo le differenze rispetto all'ultima importazione, come da storico. In tal caso � possibile abilitare il fatto che sia il servizio stesso a stabilire il tipo di movimento, senza andarlo a specificare sul record singolo. 

	<!-- Parsing differenze: 1=si 0=no-->
	<add key="Parsing" value="0"></add>


(*) SEMAFORO:
� il file la cui presenza impedisce l'import (per evitare che si scriva il file mentre lo si sta importando); in caso di schedulazione, quest'ultima viene saltata e si passa alla successiva;

	<!-- nome file semaforo host per blocco import-->
	<add key="HostFileSem" value=""></add>	<!-- Specificare percorso e nome -->

Note da documentazione MicronService:

	Per rendere ulteriormente pi� robusta la fase di esportazione dei dati di presenza, � stata implementata la gestione dei semafori, ovvero di files di segnalazione dell�attivit� di lettura/scrittura del file delle presenze.
	In pratica, l�applicativo PRIMA di scrivere i record relativi alle transazioni di presenza nel file testo, scrive un proprio file di semaforo �EXPORT.SEM� nella stessa directory del file delle presenze.
	Dopo aver scritto tale file, verifica la presenza del file �IMPORT.SEM�, se tale file NON esiste, si procede alla scrittura del record di presenza e quindi si elimina il proprio file semaforo, rendendo di fatto �disponibile� la directory.
	Se invece il file IMPORT.SEM esiste, si attende (fino ad un massimo di 2 secondi) che esso scompaia, se il file IMPORT.SEM non scomparisse, per evitare perdite di dati, l�applicativo scrive sul file EXPORT.ERR la transazione.
	Ovviamente il file IMPORT.SEM, dovrebbe essere creato (sempre nella stessa directory dove si trova il file delle presenze) dall�applicativo che legge il file delle presenze, secondo questa �scaletta�:
	1.	Creare IMPORT.SEM
	2.	Verificare la presenza di EXPORT.SEM, se esiste attendere che sparisca, altrimenti proseguire col punto 3.
	3.	Copiare il file delle presenze per il proprio utilizzo ed eventualmente eliminare quello originale.
	4.	Cancellare SEMPRE il file IMPORT.SEM
	La procedura indicata sarebbe da implementare nell�applicativo che legge i dati, non �, chiaramente, obbligatoria.


(*) SCHEDULAZIONE FISSA (BLOCCO SCHEDULAZIONE)
Blocco per definire giorni, ore e minuti dell'importazione

	<!-- Ore/giorni di schedulazione (validi per Servizio e NonServizio se standalone=false) -->
	<!-- Mettere n,HHMM per schedulare una importazione, dove -->
	<!-- n = Giorno delle settimana (0=Dom..6=Sab, 7=Feriali (lun-ven), 8=Feriali+sab, 9=Tutti) -->
	<!-- HHMM = Ore minuti dell'importazione, esempio: Domenica a mezzogiorno=0,1200, tutti i feriali alle 3: 7,0300 -->
	<!-- Per non usare la schedulazione mettere semplicemente "" -->
	<ImportSchedule>
		<add key="Sched0" value=""></add>
		<add key="Sched1" value=""></add>
		<add key="Sched2" value=""></add>
		<add key="Sched3" value=""></add>
		<add key="Sched4" value=""></add>
		<add key="Sched5" value=""></add>
		<add key="Sched6" value=""></add>
		<add key="Sched7" value=""></add>
		<add key="Sched8" value=""></add>
		<add key="Sched9" value=""></add>
	</ImportSchedule>


(*) SCHEDULAZIONE OGNI N MINUTI
Parametro per definire la schedulazione ogni n minuti

    <!-- Dice se usare la schedulazione fissa ogni n minuti (se diverso <> 0 usa questa schedulazione e non il blocco di schedulazione -->
    <add key="FixedSchedule" value="15"></add>

(*) FULL SYNC
Da utilizzare con il parsing=1 (v.sopra), fa automaticamente il calcolo delle differenze (invece che segnare il Tipo Movimento); in pratica MicronImport inserisce il Tipo Movimento nel campo 1 del file di importazione, quindi i campi da importare dovranno partire da 2
Per chiarezza: NON c'� bisogno di aggiungere un campo vuoto all'inizio del tracciato

	<!-- Dice se abilitare la modalit� tipo "Alcatel" di sincronizzazione con un file di testo -->
	<!-- In pratica si propone un file senza il campo tipo movimento ed il tipo movimento -->	
	<!-- Lo calcola il simpatico MicronImport, da notare che gli spiazzamenti con questa -->
    	<!-- modalit� debbono tenere conto del fatto che viene aggiunto un campo in testa, -->
    	<!-- quindi occorre definire il tracciato con il primo campo che � il 2 -->
    	<!-- Il meccanismo supporta SOLO importazioni con CSV -->
    	<add key="FullSync" value="False" />

(*) FILE INTEGRITY CHECK
Fa il controllo di integrit� del file

    <!-- Dice se eseguire il controllo di integrit� del file e come eseguirlo -->
    <!-- 0 = Non lo esegue -->
    <!-- 1 = Controlla che la ultima riga sia *** END OF FILE *** -->
    <!-- 2 = Controlla che la ultima riga sia *** END OF FILE *** e che la penultima contenga il numero totale di records -->
    <add key="FileIntegrityCheck" value="0" />	
	</appSettings>

(*) GRUPPO DI DIPENDENTI DI DEFAULT PER NUOVI INSERIMENTI
Codice e descrizione del gruppo di dipendenti in cui mettere i nuovi inserimenti, se il gruppo non � specificato

	<!-- codice gruppo per i nuovi inserimenti ( se gruppo non gi� specificato)-->
	<add key="NewGroupCode" value=""></add>
	<add key="NewGroupDescr" value=""></add>

(*) NON CANCELLARE LE ABILITAZIONI ESISTENTI
In caso di matricola gi� esistente e abilitata: chiave per la sovrascrittura della flag di tipo abilitazione e chiave per la sovrascrittura dei dati di abilitazione

	<!-- Questa chiave specifica se si deve evitare di sovrascrivere la flag -->
	<!-- di tipo abilitazione se esiste gi� il record matricola in anagrafica -->
	<!-- True=EVITA di sovrascrivere la flag, False=SOVRASCRIVE la flag -->
	<add key="DontUpdateFlagAbil" value="True"></add>
    
	<!-- Questa chiave specifica se si deve evitare di sovrascrivere i dati -->
	<!-- di abilitazione (data inizio, fine, ora inizio, fine) se esiste gi� -->
	<!-- il record matricola in anagrafica -->
	<!-- True=EVITA di sovrascrivere i dati, False=SOVRASCRIVE i dati -->
	<add key="DontUpdateAbilRecord" value="True"></add>


(*) ABILITAZIONE ECCEZIONALE
Configurazione per aggiungere un gruppo di varchi particolare (0000002) in abilitazione eccezionale a tutte le matricole di un certo tipo (nell'esempio sotto, gli esterni)

    <!-- Questa chiave specifica se si deve evitare di sovrascrivere la flag -->
    <!-- di tipo abilitazione se esiste gi� il record matricola in anagrafica -->
    <!-- True=EVITA di sovrascrivere la flag, False=SOVRASCRIVE la flag -->
    <add key="DontUpdateFlagAbil" value="True"></add>				<!--NON sovrascrivere la flag abilitazione, se no prende quella del parametro DefaultFlagAbil -->
    
    <!-- Questa chiave specifica se si deve evitare di sovrascrivere i dati -->
    <!-- di abilitazione (data inizio, fine, ora inizio, fine) se esiste gi� -->
    <!-- il record matricola in anagrafica -->
    <!-- True=EVITA di sovrascrivere i dati, False=SOVRASCRIVE i dati -->
    <add key="DontUpdateAbilRecord" value="False"></add>			<!--DEVI sovrascrivere i dati di abilitazione-->
    
    <!-- Dice se deve inserire i gruppivarchi (mensa e default) solo in insert (come versioni precedenti)=True -->
    <!-- Oppure se deve farlo anche in update=False -->
    <add key="GruppiVarchiSoloInsert" value="False"></add>		<!--Mettere gruppi varchi anche in Update-->

    <!-- Codice gruppo varchi di default -->
    <!-- Sono differenziati per tipo matricola e per abilitazione normale eccezionale -->
    <!-- Quello delle versioni precedenti corrispondente � GruppoVarchiDefaultNormDip (primo) -->
    <add key="GruppoVarchiDefaultNormDip" value=""></add>
    <add key="GruppoVarchiDefaultEccDip" value=""></add>
    <add key="GruppoVarchiDefaultNormEst" value=""></add>
    <add key="GruppoVarchiDefaultEccEst" value="00000002"></add>	<!--Gruppo di varchi da mettere nell'Abil.Ecc. degli Esterni-->
    
    <!-- Questa chiave specifica se si deve evitare di sovrascrivere i dati -->
    <!-- di abilitazione ECCEZIONALE (data inizio, fine, ora inizio, fine) se esiste gi� -->
    <!-- il record matricola in anagrafica -->
    <!-- True=EVITA di sovrascrivere i dati, False=SOVRASCRIVE i dati -->
    <add key="EccDontUpdateAbilRecord" value="False"></add>		<!--DEVE sovrascrivere i dati di abil.ecc. delle matricole gi� esistenti-->
   
  <!-- Definizioni dei campi da importare -->
  <!-- Mettere (pos,lunghezza) oppure "" per disabilitare campo -->
  <!-- In modalit� CSV, invece, indica il numero del campo -->
  <ImportFields>    
    ...
    <add key="55_EccDataIni" value="8"></add>		<!--Specifica data inizio ecc.-->
    <add key="56_EccDataFine" value="9"></add>		<!--Specifica data fine ecc.-->
    <add key="57_EccOraIni" value="10"></add>		<!--Specifica ora inizio ecc.-->
    <add key="58_EccOraFine" value="11"></add>		<!--Specifica ora fine ecc.-->
    ...
  </ImportFields>

  <!-- Elenco gruppi varchi di default da abilitare nei profili eccezionali personali degli esterni in base azienda esterna-->
  <!-- key=Codice azienda esterna (*=tutte le eziende); value=Codice gruppo di varchi di default,codice fascia-->
  <GrpVarchiAzEstEcc>
	<add key="*" value="00000002,001"></add>		<!--Gruppo varchi-->
  </GrpVarchiAzEstEcc>

ERRORI
-----------------------------------------------

(*) UTENTE NON TROVATO O ASSOCIATO A GRUPPO DI UTENTI
06-07-2018 16:18:23:233 Globali.ProgramSetup: Inizio programma
06-07-2018 16:18:23:295 DBIImporter.GetDefDipRif: Utente non trovato o associato a gruppo di utenti GDPR

Si riferisce al parametro seguente:
    <!-- Codice utente da cui recuperare diprif di default per cancellazione dipendenti -->
    <add key="UtenteDefDipRif" value="admin"></add>

	- T21GRUPPO dev'essere vuoto e non NULL
	(Errore di DBUpgrade 7.5.6 ----> Arriver� p�ccccc)


# SSMS
============================================================================================================================================

PROPRIETA' FONDAMENTALI DI SQL SERVER
-----------------------------------------------

SQL Server Express
	2012, 2014, 2016	Size limit per database: 10GB



(*) Avviare un'istanza di SQL da riga di comando (cmd Administrator)
	cmd > net start mssql$<nomeistanza> /<parametri>
		es. mssql$sqlexpress /m

(*) Quale versione di SQL Server sto usando?
	SSMS > New query > select @@version

(*) Come si chiama la mia istanza SQL (nomeserver\nomeistanza)?
	SSMS > New query > select @@servername		% Nome server + nome istanza
	SSMS New query > select @@servicename	% Nome istanza (=nome servizio)

SQL SERVER EXPRESS MANAGEMENT STUDIO
-----------------------------------------------
INTRO

Una componente findamentale di SQL Server � SQL Server Management Studio (SSMS), un�interfaccia utente da utilizzare per sviluppare ed effettuare la manutenzione dei nostri database. Si tratta di uno strumento intuitivo e facile da utilizzare che permette di lavorare in modo veloce e produttivo.
SQL Server consiste in un processo di Windows separato, pertanto se aprite il Task Manager e date un occhiata ai processi attivi troverete, tra gli altri, sqlservr.exe. Tale processo viene eseguito come servizio, monitorato da Windows stesso, e ad esso vengono riservate le opportune quantit� di memoria e capacit� di elaborazione del processore. Chiaramente in base al carico sul server SQL Server modifica le sue richieste in funzione delle risorse disponibili.
Siccome SQL Server viene eseguito come un servizio esso non ha interfacce collegate per l�interazione con gli utenti e per tale motivo � necessario uno strumento separato che permetta di comunicare comandi e funzioni da un utente al servizio di SQL Server, il quale poi eseguir� le richieste sul sottostante database. Tale strumento, come avrete intuito, � proprio SSMS e per tale motivo andiamo ad analizzarlo pi� in dettaglio.

DATABASE DI SISTEMA

- master: � il cuore di SQL Server e nel caso in cui si danneggiasse probabilmente SQL Server non funzionerebbe pi� correttamente. Esso contiene diverse informazioni fondamentali: tutti i login ed i ruoli relativi agli utenti; tutte le impostazioni di sistema (come ad esempio il linguaggio di default); i nomi e le informazioni relative a tutti i database all�interno del server; la posizione dei database; le modalit� di utilizzo della cache; i linguaggi di disponibili; i messaggi d�errore di sistema; ecc.
- tempdb: � un database temporaneo la cui durata corrisponde alla durata di una sessione di SQL Server. Esso viene creato all�avvio di SQL Server e viene eliminato quando esso viene terminato. Un utilizzo molto comune di tale database � quello di memorizzare in esso i dati derivanti da un�interrogazione particolare per riutilizzarli in un secondo momento (tramite le tabelle temporanee).
- model: Solitamente quando si crea un nuovo database si desidera che esso abbia un insieme di impostazioni predefinite e tali informazioni possono essere inserite e gestite tramite il database model, che rappresenta una sorta di modello per gli altri database.
- msdb: Il database msdb � un altro elemento fondamentale di SQL Server e fornisce le informazioni necessarie all�esecuzione automatica di attivit� (job) definite tramite il SQL Server Agent. Quest�ultimo � un servizio di Windows che esegue tutti i job schedulati. Altri processi molto importanti che utilizzano in database msdb sono quelli di backup e restore.

(...to be continued...)




COME SI CHIAMA E DOV'� IL DB MRT
-----------------------------------------------

Per avere informazioni sul database, basta aprire DBUpgrade/DbUpgrade.exe (file config). Esempio di stringa:

	<!-- Stringa di connessione al database SQL Server -->
	<add key="SqlStr" value="Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Password=Micro!Mpw13;Initial Catalog=MRT;Data Source=(local)\sqlexpress;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=GRAFICA;Use Encryption for Data=False;Tag with column collation when possible=False"></add>
    
Dove � possibile leggere il nome del database (MRT), dell'istanza (local\sqlexpress), username (sa) e password (Micro!Mpw13).


LESSICO
-----------------------------------------------

RECOVERY MODEL

Una delle prime cose da impostare per creare il backup corretto � settare il giusto Recovery Model per ciascun database. In breve, il Recovery Model dice al SQL Server quali dati mantenere nel Transaction Log File e per quanto tempo. A seconda del Recovery Model scelto, questo determiner� anche quali backup puoi eseguire e quali tipi di ripristino di database possono essere usati.
I tre tipi di Recovery Model che si possono scegliere sono i seguenti: Full ("Con registrazione completa"), Simple ("Con registrazione minima") e Bulk-Logged ("Con registrazione minima delle operazioni bulk"). Per cambiare Recovery Model:
	- Da SQL Management Studio, connettersi all'istanza
	- Dal treeview a sinistra, (server)\istanza > Database > Click destro sul database di pertinenza > Propriet�
	- Opzioni > Modello di Recupero
Il Recovery Model "Full" dice al SQL Server di mantenere tutti i dati del Transaction Log finch� non avviene un backup del log stesso oppure il log viene troncato. Tutte le transazioni che vengono inviate al SQL Server vengono prima inserite nel Transaction Log, e poi scritte sul file di dati appropriato. Questo permette al SQL Server di recuperare ciascun punto del processo in caso di errore o nel caso in cui una transazione fosse cancellata per qualche ragione. 
Il Recovery Model "Full" � il modello di ripristino pi� completo e permette di recuperare tutti i dati in qualunque momento fintantoch� i file di backup sono utilizzabili. Con questo modello, tutte le operazioni vengono completamente registrate. In pi�, se il database � posto in "Full" Recovery Model, � necessario settare dei backup del Transaction Log, altrimenti quest'ultimo tender� a crescere all'infinito.
Il Recovery Model "Simple" d� un semplice backup che pu� essere utilizzato per sostituire l'intero database in caso di failure o nel caso si debba ripristinare il database in un altro server. Con questo modello si ha la possibilit� di fare backup completi (copia intera) o differenziali (ogni modifica dall'ultimo backup completo), ma si � esposti ai failure dall'ultimo backup completo.
Essendo il tipo di ripristino pi� basilare, scrive ogni transazione sul Transaction Log, ma una volta che la transazione � completa e il dato � stato scritto nel file di dati, lo spazio nel Transaction Log viene svuotato ed � riutilizzabile, pertanto non ne � pi� possibile il recupero.

ATTACH/DETACH

	Detach:
	Quando fai il "Detach" di un database, stai mettendo il database offline e rimuovendolo dall'istanza SQL da cui lo stai scollegando. I dati di database e i file di log rimangono intatti e sono messi in uno stato coerente, cosicch� si possa ricollegare il database pi� tardi a una diversa istanza SQL. "Attach" connette i dati e i file di log da un database che � stato adeguatamente scollegato (o che � stato copiato da uno shut down di istanza SQL Server) su un'istanza SQL Server e rimette il database online.
	Come si fa il Detach?
		- Click destro sul database > Tasks > Detach 
		- Si apre la finestra di dialogo Detach, cliccare su "Detach"

	Attach:
	Se si hanno dei file di dati e log di un database che non � stato appropriatamente scollegato, il ricollegamento potrebbe non funzionare. Quando si fa uno scollegamento, il database � portato in offline e i file di log e dati vengono messi in uno stato consistente (� lo stesso processo che succede quando un servizio viene adeguatamente arrestato).
	Come si fa l'Attach:
		- Click destro sulla cartella Database dell'istanza > Attach
		- Selezionare il file di dati primario (.MDF) del database che si vuole collegare
		- Verificare che tutti i file appartenenti a quel database vengano inclusi, con i rispettivi percorsi di provenienza
		- Cliccare su OK per confermare l'Attach

(*) Warning: Attach/Detach NON sostituisce Backup/Restore, in quanto nel post-Detach il database e i file corrispondenti vengono messi in uno stato 'scollegato' che li mette a rischio di facile cancellazione

(*) Attach/Detach � una buona procedura nei seguenti casi:
	- Migrazioni (sebbene sia preferibile il Backup/Restore)
	- per rimuovere un database che non � pi� utilizzato, ma potrebbe essere ricollegato in seguito se necessario
	- non si ha memoria sufficiente per fare il Backup/Restore dei file di dati e log su un altro ambiente (soprattutto nel caso in cui non si necessitasse del file di log)

(*) Rischi:
	- Si sta portando offline il database, quindi NON sar� pi� accessibile da alcun applicativo
	- Se il database � scollegato, la cancellazione dei file di dati e di log � possibile (mentre, quando il DB � online, SQL Server previene la cancellazione fisica dei .MDF e .LDF)
	- Non fare l'Attach di un database che prima non si sia accuratamente verificato: potrebbe contenere procedure, triggers, comandi che potrebbero compromettere il sistema


BACKUP
-----------------------------------------------

� EXPRESSMAINT

- Eseguire il nuovo backup e rimuovere i vecchi backup:

	Per effettuare un backup veloce del database tramite command line interface, possiamo usare una utility chiamata ExpressMaint. Il programma � flessibile e fornisce una serie di opzioni per realizzare quanto desiderato: � possibile specificare il server a cui connettersi, il database da salvare, il percorso di destinazione del backup, e anche il periodo di conservazione dei backup (in modo che vengano automaticamente cancellati quelli pi� vecchi del periodo indicato). Un esempio: 
	
		C:\...\expressmaint.exe -S (local)\SQLEXPRESS -U sa -P Micro!Mpw13 -D MRT -T DB -R c:\mpw\dbbackup -RU WEEKS -RV 1 -B c:\mpw\dbbackup -BU WEEKS -BV 1 -DS
	
		C:\...\expressmaint.exe	Applicazione (percorso completo del .exe)
			-S	Percorso istanza (nomeserver\nomeistanza, es."(local)\sqlexpress")
			-U	Username
			-P	Password	
			-D	Nome Database (es. "MRT")
			-T	Tipo di backup (DB=completo, LOG=Transition Log Backup)
			-R	Percorso per i Report
			-RU	Unit� di tempo per i Report (es."WEEKS 1" significa che verranno rimossi i file pi� vecchi di una settimana)
			-RV	Valore di tempo per i Report (es."WEEKS 1" significa che verranno rimossi i file pi� vecchi di una settimana)
			-B	Percorso per il Backup
			-BU	Unit� di tempo per il backup (es."WEEKS 1" significa che verranno rimossi i file pi� vecchi di una settimana)
			-BV	Valore di tempo per il backup (es."WEEKS 1" significa che verranno rimossi i file pi� vecchi di una settimana)
			-DS	Appende il timestamp (data/ora) al filename dei backup e report (logisticamente utile per tener traccia dei backup)

		(*) Le versioni di ExpressMaint che funzionano sono gi� nel pacchetto standard di installazione. Mi raccomando!
			ExpressMaint 1.8.0.0	per SQL 2005
			ExpressMaint 2.0.0.1	per SQL 2008, SQL 2014
			ExpressMaint 1.9.0.0	per SQL 2012

- Schedulare il backup tramite Windows Task Scheduler (Attivit� pianificate)
	
	Il file di testo con questa istruzione pu� essere salvato come .bat e fatto eseguire all'orario desiderato, con la frequenza desiderata, tramite le Operazioni Pianificate. Attraverso Pannello di Controllo > Strumenti di Amministrazione > Operazioni Pianificate, selezionare "Crea attivit�" e inserire i dati richiesti, ovvero Nome, Descrizione, Attivazione (definire quando e con quale frequenza l'attivit� va eseguita) e Attivit� (scegliere il percorso del file .bat da eseguire).
	
		(*) Pu� capitare che il file .bat parta correttamente se eseguito come Amministratore direttamente dalla cartella, ma non riesca a partire dal Task Scheduler di Windows; in tal caso, modificare il file e inserire il percorso completo del file ExpressMaint
		(*) Se il file .bat non parte nemmeno se eseguito 'manualmente' come Amministratore, significa che il programma ExpressMaint non � adeguato alla versione di SQL a disposizione del cliente

� SQL BACKUP MASTER

Freeware disponibile al link 
	https://www.sqlbackupmaster.com/download
Il file di setup installa il tool client e il servizio relativo ("SQL Backup Master")

Per creare un nuovo job (sezione "Backup and Restore"):
	- Create New Database backup
	- Source > Choose SQL Server > 
	- Source > Connect to SQL Server > Server name = [nome istanza]
	- Source > Connect to SQL Server > SQL Authentication = [credenziali istanza]
	- Source > Connect to SQL Server > Test SQL Connection
	- Source > [spuntare il database di cui fare il backup]
	- Destinations > Add > Local or Network Folder 
	- Destinations > Folder Destination Settings > Browse > [selezionare la cartella di destinazione]
	- Destinations > Folder Destination Settings > Cleanup > Delete backups older than [inserire giorni] days 
	- Job Configuration > Schedule > [inserire le impostazioni di schedulazione]
	- Job Configuration > Runs as > [inserire utenza]
	- Job Configuration > Notifications > [inserire le impostazioni per eventuali notifiche email]
	- Job Configuration > Name > [inserire nome del job]
	- Job Configuration > Description > [inserire descrizione del job]
	- Save


TABELLE
-----------------------------------------------

T05COMFLAGS	
per assegnare nome del campo e numero del campo corrispondente ai 'campi programmabili' su MicronConfig

T31COMVISITATORI
dati dei visitatori salvati su Mpassw

T35ACCPROFILIORARI
contiene tutti i sottoprofili, personali o collettivi
	T35codice: 		codice matricola o codice gruppo o codice azienda esterna, ecc. Insomma la chiave
	T35Tipocodice:		0=Personale, 1=, 2=, 3=, 4=, 5=, 6=, 7=, 8=Gruppo di Dipendenti, 9=Azienda Esterna
	T35flagnormale:		0=, 1=
	T35Sottoprofilo:	num. del sottoprofilo dell'anagrafica T35codice (i.e. voce nell'elenco del profilo d'accesso)
	T35FlagGruppo:		0=Abilitazione personale, 1=Abilitazione di gruppo
	T35Varco:		Se T35flaggruppo=0, codice varco
	T35Gruppo:		Se T35flaggruppo=1, codice gruppo di varchi
	T35fascia:		Eventuale fascia oraria associata
	T35Comando:		se non ci sono comandi configurati, =0000; altrimenti, =FF<codicecomando>
	

T37 ACCTRANSITI	
riporta tutte le timbrature in memoria

T40ACCGRUPPIVARCHI
contiene tutti i gruppi di varchi e i rispettivi varchi

T70COMOPWEB	
backup di memoria; quando si d� un'abilitazione su Micronpass Web, questo lo scrive sulla tabella; a quel punto BtService confronta se il nominativo � nella tabella, e se i dati coincidono lo pu� cancellare dalla tabella. In seguito all'assegnazione di un badge o di un'abilitazione, � possibile verificare sulla tabella l'esito positivo o negativo.
� prerequisito di progetto che quando un servizio � configurato diventa oggetto di notifiche sulla T70, quindi anche se un servizio � disabilitato/spento, lo si vedr� comunque tra i destinatari della T70.
I mittenti  delle notifiche (ad esempio Micronpass, Micronimport, WebService, ecc)  non possono entrare nel merito dei dettagli dei profili di accesso, pertanto inviano le notifiche sempre a tutti i MicronService; nella T70 non ci sono solo attivit� che riguardano i profili di accesso.
Ogni servizio quindi recepisce la notifica elaborandola se agganciata ad un nodo di propria competenza, oppure eliminandola se non di pertinenza.

	*** ATTENZIONE! Un avvio/arresto *molto lento e nella maggior parte dei casi fallimentare* di btService potrebbe significare una T70COMOPWEB troppo vasta da elaborare, o con dei record non coerenti. Eventualmente svuotare la tabella di tutti i record inutili.
		Se la T70 scrive record riferiti a servizi ormai spenti o dismessi, considerare di:
			a. passare la vita a cancellare i record nella T70 che si riferiscono a quei servizi
			b. cancellare definitivamente i servizi in questione
	*** Nel caso in cui si dovesse riavviare i btService e si volesse evitare lo scarico compulsivo di tonnellate di abilitazioni (tale da bloccare l'uso dell'impianto), per sicurezza svuotare la tabella T70COMOPWEB con una TRUNCATE TABLE e riavviare i servizi in sicurezza


T108COMDATIAGGIUNTIVI
per assegnare i campi aggiuntivi all'ID visitatore/trasportatore; contiene i Campi Programmabili
 
T116ACCBUFFER 
Scrive tutte le timbrature nel caso in cui non fosse riuscito a scriverle nel file txt. Rimettendo il 'CODANOMALIA' da 1 a 0, lui reimporter� le timbrature sul txt.

	(*) Lentezza nell'elaborazione dei transiti dalla T116 alla T37 e conseguente riempimento della T116
	
		L'elaborazione dei transiti dalla T116 alla T37 � immediata e non esiste un parametro per renderlo pi� veloce o meno.
		Se ci sono tanti record in coda sussiste qualche problema sul server. 
		- Verificare le performance della macchina: 
			spazio su HD? 
			Dimensione file Log Sql?
		- L�indirizzo IP indicato sul BtService all�interno del micronconfig corrisponde a quello del server? (premere "Default" sul Micronconfig)
		- � sia attivo il Gntrace.flg nelle cartelle Gnconfig?
		- Verifica che, nel caso ci fossero pi� servizi, siano tutti attivi
		- Verifica che non ci siano file export delle timbrature di presenze che non essendo elaborati da nessuno hanno raggiunto dimensioni considerevoli e quindi difficilmente aggiornabili dal sistema in realtime
		- Verifica che non ci siano terminali scollegati che potrebbero appesantire la comunicazione con il server
		- [per MicronADPBridge] Verifica anche il parametro del MicronAdpBridge  �Frequenza di esecuzione comandi micronpass�  (frequenza elaborazione dei record della T126ACCFTPPOLLING \ T125ACCFTPSELECTING record inseriti  da Estar \ Micronpass)
		- Verifica parametro Micronservice: "Timeout controllo timbrature da elaborare" in millisecondi di cui riporto estratto documentazione tecnica
 
			1.1	Timeout elaborazione timbrature
 			Dalla versione corrente � stato aggiunto un nuovo parametro, creato alla prima esecuzione di MicronService, che consente di andare ad elaborare le timbrature ricevute nella tabella T116 a tempo oltre che via messaggio di �wakeup�.
			In pratica la nuova funzionalit� consente di elaborare le timbrature ricevute da terminali/panel pc ed inserite nel buffer (T116ACCBUFFER) anche senza che venga ricevuto dal servizio un messaggio di wakeup via TCP/IP. Questa funzionalit� � utile in scenari dove Micronservice si trova dietro un firewall e quindi non pu� essere contattato dagli applicativi che inseriscono le timbrature nella tabella T116.
			Il parametro, denominato �Timeout controllo timbrature da elaborare in millisecondi (0=disabilitato)� viene creato di default con valore 0 (quindi non entra in funzione), andando a specificare un valore in millisecondi differente viene effettuata la lettura della tabella ogni n (dove n=valore del parametro) millisecondi.
			Si noti che il valore minimo specificabile � 30000 (30 secondi), se si specifica un valore inferiore MicronService effettua comunque la elaborazione ogni 30 secondi. Il valore massimo � invece di 300000 (corrispondente a 5 minuti).
 
T166COMSTORICOALLARMI
Scrive tutti gli allarmi ricevuti, compresi gli ingressi su cui sono arrivati, gli stati (0/1) dell'allarme e il varco a cui sono collegati



COMANDI UTILI
-----------------------------------------------

	SELECT
	Trovare voci:

		USE <nomedatabase> 
		SELECT * FROM <nometabella> WHERE <nomecampo> LIKE '%<quellochecerchi>%';

	DELETE
	Cancellare voci:

		USE <nomedatabase>
		DELETE FROM <nometabella> WHERE <nomecampo> LIKE '%<quellochecerchi>%';

	TRUNCATE TABLE
	Cancella l'intero contenuto di una tabella.
	L'istruzione TRUNCATE TABLE rappresenta un metodo rapido ed efficace per eliminare tutte le righe di una tabella. TRUNCATE TABLE � simile all'istruzione DELETE senza la clausola WHERE, tuttavia � pi� rapida e utilizza un numero minore di risorse di sistema e del log delle transazioni.

		USE <nomedatabase>
		TRUNCATE TABLE <nometabella>

	UPDATE
	Cambiare un valore o pi� valori:

		USE <nomedatabase>
		UPDATE <nometabella> SET <nomecampo> = '<valore>' WHERE <nomecolonna> LIKE '%<quellochecerchi>%';

	REPLACE
	Rimpiazzare un pezzo di stringa, o una stringa intera

		USE <nomedatabase>
		UPDATE <nometabella>
	  	SET <nomecolonna> = REPLACE(<nomecolonna>,'<stringa originale>','<stringa sostitutiva>')
	  	WHERE <nomecolonna> = '<stringa originale>'							/*Campo singolo con <stringa originale> da sostituire*/
	      (	WHERE <nomecolonna> LIKE '%<stringa originale>%' )						/*Pi� campi con <stringa originale> da sostituire*/


	PER KILLARE TUTTE LE CONNESSIONI 
	Ad es. per effettuare un backup o un restore

		/* Kill connections and set to single user mode */		
		USE mrt
		GO
		ALTER DATABASE mrt
		SET SINGLE_USER
		WITH ROLLBACK IMMEDIATE
		GO
 
		/* 
		Do your operations, e.g. restore files or filegroups 
		*/
 
		/* Set the database back in to multiple user mode */
		USE mrt
		GO
		ALTER DATABASE mrt 
		SET MULTI_USER
		GO


QUERY UTILI SU MRT/MW
-----------------------------------------------

� INFORMATION_SCHEMA

(*) Cercare una tabella nel database filtrando per descrizione ("oh non mi ricordo come si chiama 'sta tabella")

	USE Mrt						/* Database */
	SELECT * FROM information_schema.tables		/* Tabelle presenti nello schema di database */
	WHERE Table_name LIKE '%%'			/* Filtro sul nome tabella */

		Esempio: tabelle che contengono informazioni sugli allarmi usando 'allarmi' come filtro:

			USE mrt SELECT * FROM information_schema.tables WHERE Table_name LIKE '%allarmi%'
			>
			> TABLE_CATALOG;TABLE_SCHEMA;TABLE_NAME;TABLE_TYPE
			> MRT; dbo; T47ACCSTATOALLARMI; BASE TABLE
			> MRT; dbo; T48ACCGESTIONEALLARMI; BASE TABLE
			> MRT; dbo; T66ACCSTORICOALLARMI; BASE TABLE

(*) Cercare tutte le colonne che contengono una certa stringa, indicando a quali tabelle appartengono

	USE MRT									/* Database */
	SELECT 
		Columns.name AS ColumnName,					/* Nome colonna */
		Tables.name AS TableName					/* Nome tabella di appartenenza */
	FROM
		sys.columns Columns						/* Colonne presenti nello schema di database */
	JOIN
		sys.tables Tables ON Columns.object_id = Tables.object_id	/* Corrispondenza colonna-tabella */
	WHERE
		Columns.name LIKE '%%'						/* Filtro sul nome colonna */

		Esempio: colonne (e relative tabelle) che contengono la stringa 'varco':

			USE mrt SELECT c.name NomeColonna, t.name NomeTabella FROM sys.columns c JOIN sys.tables t ON c.object_id=t.object_id WHERE c.name LIKE '%varco%'
			> 
			> NomeColonna; NomeTabella
			> T12VARCO; T12ACCPUNTIRACCOLTA
			> T21VARCONOBADGEVIS; T21COMUTENTI
			> T22VARCO; T22ACCTERMINALI
			> T23TIPOVARCO; T23ACCVARCHI
			> T23VARCO0001; T23ACCVARCHI
			> ...;...

� DATA

(*) Incrocio di dati tra tabelle dello stesso database, usando un campo come chiave e un altro come filtro

	USE MW						/*Database*/
	SELECT * FROM dipen_badge INNER JOIN dipen 	/*Tabelle*/
	ON dipen_badge.matricola=dipen.matricola 	/*Chiave*/
	WHERE dipen.campo=�valore�			/*Filtro*/

(*) Join tra due database con collations diverse
Non c'� bisogno di specificare USE DB all'inizio della SELECT perch� i singoli database sono specificati nella query

	SELECT * FROM [Database1].[dbo].[Table1] AS T1						/* Tabella del Database1 */
	JOIN [Database2].[dbo].[Table2] AS T2							/* Tabella del Database2 */
	ON T1.FIELD1 COLLATE Latin1_General_CI_AS = T2.FIELD2 COLLATE Latin1_General_CI_AS 	/* Chiavi, ciascuna con la propria Collation */
	WHERE condizione									/* Filtro */

(*) Incrocio di dati tra X=3 tabelle dello stesso database, usando due campi come chiavi

	Use [DATABASE_NAME]
	Select [A.FIELD_A, B.FIELD_B, C.FIELD_C]
	From TABLEA as A
		inner join
	TABLEB as B
		on A.[COMMON_FIELD_AB] = B.[COMMON_FIELD_AB]
		inner join
	TABLEC as C
		on B.[COMMON_FIELD_BC] = C.[COMMON_FIELD_BC]

(*) Update di un campo di una tabella ricavato da un campo di un'altra tabella 
(l'esempio sotto aggiorna il codice fiscale nella T26COMDIPENDENTI prendendolo dal primo campo programmabile, usando la matricola)

	USE [MRT_OSP-ROVIGO] 
	UPDATE
	    T26COMDIPENDENTI					/* Tabella da aggiornare*/
	SET
	    T26COMDIPENDENTI.T26CodFiscale = DATI.T108Valore	/* Campo da aggiornare (codice fiscale) */
	FROM
	    T26COMDIPENDENTI DIP				/* Tabella destinazione */
	INNER JOIN
	    T108COMDATIAGGIUNTIVI DATI				/* Tabella sorgente */
	ON 
	    DIP.T26Codice = DATI.T108Matricola			/* Chiave (Matricola) */
	WHERE
		T108AZIE='00001' AND				/* Azienda interna */
		T108TIPOMATRICOLA='0' AND			/* Tipo matricola */
		T108FIELDID='1'					/* Numero campo progammabile */

(*) Elenco completo dei badge, assegnati&attivi e non

	USE MRT
	/* badge assegnati */
	SELECT 
		B.T25CODICE AS BADGEID,
		B.T25DESCRIZIONE AS NOTE,
		B.T25MATRICOLA AS MATRICOLA,
		D.T26COGNOME AS COGNOME,
		D.T26NOME AS NOME,
		B.T25CODAZIENDAIE AS AZIENDACODICE,
		A.T71DESCRAZIENDA AS AZIENDADESCRIZIONE,
		B.T25ID1 AS RFID
	FROM T25COMBADGE AS B
	JOIN T26COMDIPENDENTI AS D
		ON B.T25MATRICOLA=D.T26CODICE AND B.T25CODAZIENDAIE=D.T26CODAZIENDA
	JOIN T71COMAZIENDEINTERNE AS A
		ON B.T25CODAZIENDAIE=A.T71CODICE
	UNION
	/* Badge non assegnati */
	SELECT 
		T25CODICE AS BADGEID,
		T25DESCRIZIONE AS NOTE,
		T25MATRICOLA AS MATRICOLA,
		'' AS COGNOME,		/* Campo vuoto per coerenza */
		'' AS NOME,		/* Campo vuoto per coerenza */
		'' AS AZIENDACODICE,	/* Campo vuoto per coerenza */
		'' AS AZIENDADESCRIZIONE, /* Campo vuoto per coerenza */
		T25ID1 AS RFID
	FROM T25COMBADGE
	WHERE T25MATRICOLA = '' OR T25MATRICOLA IS NULL

(*) Query di abilitazioni a Varchi Singoli e Gruppi di varchi per tutte le matricole degli esterni (se una matricola ha pi� gruppi di varchi o gruppi di varchi e varchi insieme, il record matricola viene sdoppiato)

	USE MRT	
	SELECT T29CODICE AS Matricola, 			/*Matricola*/
	T29NOME AS Nome, 				/*Nome*/
	T29COGNOME AS Cognome, 				/*Cognome*/
	T29AZIENDA AS AziendaID, 			/*Codice Azienda*/
	T30RAGIONESOCIALE AS AziendaDescr, 		/*Descrizione Azienda*/
	CASE T35FLAGGRUPPO WHEN '0' THEN 'VARCO SINGOLO' WHEN '1' THEN 'GRUPPO DI VARCHI' END AS TipoAbil, 		/*Tipo Abilitazione (Varco, Gruppo di varchi)*/
	CASE T35FLAGGRUPPO WHEN '0' THEN T35VARCO WHEN '1' THEN T35GRUPPO END AS CodiceVarcoGruppo, 			/*Codice varco o gruppo varchi*/
	CASE T35FLAGGRUPPO WHEN '0' THEN T23DESCRIZIONE WHEN '1' THEN T27DESCRIZIONE END AS DescrizioneVarcoGruppo 	/*Descrizione varco o gruppo di varchi*/
	FROM T2	9COMESTERNI E 
	INNER JOIN T30COMAZIENDEESTERNE A ON E.T29AZIENDA = A.T30CODICE 						/*Aziende Esterne*/
	INNER JOIN (SELECT * FROM T35ACCPROFILIORARI WHERE T35TIPOCODICE='9') P ON E.T29AZIENDA = P.T35CODICE 		/*Tipo abilitazione '9' (Azienda Esterna)*/
	LEFT JOIN T23ACCVARCHI V ON P.T35VARCO=V.T23CODICE 		/*Join varchi*/
	LEFT JOIN T27ACCTGRUPPIVARCHI G ON P.T35GRUPPO=G.T27CODICE  	/*Join gruppi di varchi*/
	WHERE (T29ABILAZIENDA = '1') 					/*Abilitazione di gruppo*/

(*) Query di abilitazioni a Varchi Singoli e Gruppi di varchi per tutte le matricole dei dipendenti (se una matricola ha pi� gruppi di varchi o gruppi di varchi e varchi insieme, il record matricola viene sdoppiato)

	USE MRT
	SELECT T26CODICE AS Matricola, 			/*Matricola*/
	T26NOME AS Nome, 				/*Nome*/
	T26COGNOME AS Cognome, 				/*Cognome*/
	T26CODAZIENDA AS AziendaID, 			/*Codice Azienda*/
	T26BADGEATTIVO AS BadgeAttivo, 			/*Badge Attivo*/
	T71DESCRAZIENDA AS AziendaDescr, 		/*Descrizione Azienda*/
	CASE T35FLAGGRUPPO 
		WHEN '0' THEN 'VARCO SINGOLO' 
		WHEN '1' THEN 'GRUPPO DI VARCHI' 
		END AS TipoAbil, 			/*Varco Singolo o Gruppo di Varchi*/ 
	CASE T35FLAGGRUPPO 
		WHEN '0' THEN T35VARCO 
		WHEN '1' THEN T35GRUPPO 
		END AS CodiceVarcoGruppo,  		/*Codice Varco o Gruppo*/
	CASE T35FLAGGRUPPO 
		WHEN '0' THEN T23DESCRIZIONE 
		WHEN '1' THEN T27DESCRIZIONE 
		END AS DescrizioneVarcoGruppo 		/*Descrizione Varco o Gruppo*/
	FROM T26COMDIPENDENTI D 
	INNER JOIN T71COMAZIENDEINTERNE A ON D.T26CODAZIENDA = A.T71CODICE 						/* Join Aziende*/
	INNER JOIN (SELECT * FROM T35ACCPROFILIORARI WHERE T35TIPOCODICE='8') P ON D.T26GRUPPO = P.T35CODICE 		/*Tipo Codice Abilitazione nella T35 = '8' (Gruppo di Dipendenti)*/
	LEFT JOIN T23ACCVARCHI V ON P.T35VARCO=V.T23CODICE 								/*Join varchi*/
	LEFT JOIN T27ACCTGRUPPIVARCHI G ON P.T35GRUPPO=G.T27CODICE  							/*Join Gruppi Varchi*/
	WHERE (T26ABILGRUPPO = '1') 

(*) Query di abilitazioni ECCEZIONALI a Varchi Singoli e Gruppi di Varchi per tutte le matricole dei dipendenti; specifica anche il gruppo di dipendenti

	SELECT T26CODICE AS Matricola,			/* Matricola */
	T26NOME AS Nome,				/* Nome */
	T26COGNOME AS Cognome,				/* Cognome */
	T26BADGEATTIVO AS BadgeAttivo,			/* Badge attivo */
	T26GRUPPO AS CodiceGruppoDip,			/* Codice Gruppo di Dipendenti */
	T28DESCRIZIONE AS DescrizioneGruppoDip,		/* Descrizione Gruppo di Dipendenti */
	CASE T35FLAGGRUPPO 
		WHEN '0' THEN 'VARCO SINGOLO' 		
		WHEN '1' THEN 'GRUPPO DI VARCHI' 
		END AS TipoAbil,			/* Tipo abilitazione (varco o gruppo di varchi) */
	CASE T35FLAGGRUPPO 
		WHEN '0' THEN T35VARCO 
		WHEN '1' THEN T35GRUPPO 
		END AS CodiceVarcoGruppo,		/* Codice Varco o Gruppo di Varchi */
	CASE T35FLAGGRUPPO 
		WHEN '0' THEN T23DESCRIZIONE 
		WHEN '1' THEN T27DESCRIZIONE 
		END AS DescrizioneVarcoGruppo		/* Descrizione Varco o Gruppo di Varchi */
	FROM T26COMDIPENDENTI D 
	INNER JOIN (SELECT * FROM T35ACCPROFILIORARI WHERE T35TIPOCODICE='0' AND T35FLAGNORMALE='1') 	/* Solo dipendenti e solo abilitazioni eccezionali */
		P ON D.T26CODICE=P.T35CODICE AND D.T26CODAZIENDA=P.T35CODAZIENDAIE
	LEFT JOIN T23ACCVARCHI V ON P.T35VARCO=V.T23CODICE
	LEFT JOIN T27ACCTGRUPPIVARCHI G ON P.T35GRUPPO=G.T27CODICE
	LEFT JOIN T28COMGRUPPIDIP GRD ON D.T26GRUPPO=GRD.T28CODICE

(*) Struttura impianto nella forma: servizio, impianto, varco, terminale (ID e descrizioni)

	USE MRT
	SELECT dbo.T03COMSERVICES.T03CODICE AS ServizioID, 			/*Codice Servizio*/
	dbo.T03COMSERVICES.T03DESCRIZIONE AS ServizioDescrizione, 		/*Descrizione Servizio*/
	dbo.T02COMIMPIANTI.T02CODICE AS ImpiantoID, 				/*Codice Impianto*/
	dbo.T02COMIMPIANTI.T02DESCRIZIONE AS ImpiantoDescrizione, 		/*Descrizione Impianto*/
	dbo.T23ACCVARCHI.T23CODICE AS VarcoID, 					/*Codice varco*/
	dbo.T23ACCVARCHI.T23DESCRIZIONE AS VarcoDescrizione, 			/*Descrizione varco*/
	dbo.T22ACCTERMINALI.T22CODICE AS TerminaleID, 				/*Codice terminale*/
	dbo.T22ACCTERMINALI.T22DESCRIZIONE AS TerminaleDescrizione		/*Descrizione terminale*/
	FROM dbo.T03COMSERVICES 						
	INNER JOIN dbo.T02COMIMPIANTI ON dbo.T03COMSERVICES.T03CODICE = dbo.T02COMIMPIANTI.T02SERVICE 	/*Join tra servizio e impianto*/
	INNER JOIN dbo.T23ACCVARCHI ON dbo.T02COMIMPIANTI.T02CODICE = dbo.T23ACCVARCHI.T23IMPIANTO 	/*Join tra impianto e varco*/
	INNER JOIN dbo.T22ACCTERMINALI ON dbo.T23ACCVARCHI.T23CODICE = dbo.T22ACCTERMINALI.T22VARCO	/*Join tra varco e terminale*/

(*) Trova valori duplicati in una tabella SQL

	SELECT field1,field2,field3, COUNT(*)		/*Filter only the specified fields*/
	FROM table_name					/*Source table*/
  	GROUP BY field1,field2,field3			/*Grouping the specified fields*/
  	HAVING COUNT(*) > 1				/*Count greater than 1*/

	Es.	USE MRT					/*Database sorgente*/
		SELECT t06terminale, count(*) 		/*Selezione e conteggio sul campo indicato*/
		from t06commonitorterminali 		/*Tabella di origine*/
		group by t06terminale 			/*Raggruppamento per campo*/
		having count(*)>1			/*Vincolo sul conteggio*/
		order by count(*) desc			/*Ordinamento decrescente dei risultati*/

(*) Query abilitazioni dei Dipendenti con dati aggiuntivi: Data Creazione Anagrafica, Data Creazione Abilitazione Varco, Data Creazione Abilitazione Gruppo di Varchi

	SELECT
	T26CODICE as Codice_ADP,					/*Matricola*/
	T26COGNOME as Cognome,						/*Cognome*/
	T26NOME as Nome,						/*Nome*/
	T26UTENTEMODIFICA as Utente_Ultima_Modifica_Anagrafica,		/*Utente che ha effettuato l'ultima modifica sull'anagrafica*/
	T26DATAORAMODIFICA AS Data_Modica_Anagrafica,			/*Data e ora dell'ultima modifica sull'anagrafica*/
	T26QUALIFICA As Qualifica,					/*Qualifica*/
	T26LOCALITA as Localita,					/*Localit�*/
	T26CODAZIENDA as Codice_Azienda,				/*Codice Azienda Interna*/
	T26CODFISCALE as Codice_Fiscale,				/*Codice Fiscale*/
	T26CODICE as Codice_badge,					/*Matricola = Badge*/
	T35VARCO as Codice_Varco,					/*Codice varco*/
	T35GRUPPO as Codice_Gruppo,					/*Codice Gruppo di varchi*/
	T35UTENTEMODIFICA as Utente_Modifica_Varco_Gruppo,		/*Utente che effettuato l'ultima modifica sul profilo d'accesso*/
	T35DATAORAMODIFICA as Data_Modifica_Varco_Gruppo		/*Data e ora dell'ultima modifica sul profilo d'accesso*/
	from T26COMDIPENDENTI Anagrafica 
	inner join (select * from T35ACCPROFILIORARI where t35tipocodice='0') profilo 
	on t26codice = t35codice and T26CODAZIENDA = T35CODAZIENDAIE
         order by 1

(*) Query per sapere le abilitazioni dei dipendenti, con relativa data creazione anagrafica, data creazione abilitazione varco e data creazione abilitazione gruppi di varchi

         select 
         T26CODICE as Codice_ADP,
         T26COGNOME as Cognome,
         T26NOME as Nome,
         T26UTENTEMODIFICA as Utente_Ultima_Modifica_Anagrafica,
         T26DATAORAMODIFICA AS Data_Modica_Anagrafica,
         T26QUALIFICA As Qualifica,
         T26LOCALITA as Localita,
         T26CODAZIENDA as Codice_Azienda,
         T26CODFISCALE as Codice_Fiscale,
         T26CODICE as Codice_badge,
         T35VARCO as Codice_Varco,
         T35GRUPPO as Codice_Gruppo,
         T35UTENTEMODIFICA as Utente_Modifica_Varco_Gruppo,
         T35DATAORAMODIFICA as Data_Modifica_Varco_Gruppo
         from T26COMDIPENDENTI Anagrafica inner join 
		 (select * from T35ACCPROFILIORARI where t35tipocodice='0') profilo on t26codice = t35codice and T26CODAZIENDA = T35CODAZIENDAIE
         order by 1

(*) Query per sapere le propriet� (righe, spazio totale occupato, spazio totale libero, ecc.) di tutte le tabelle di un database

	USE MRT
	SELECT 
	    t.NAME AS TableName,
	    s.Name AS SchemaName,
	    p.rows AS RowCounts,
	    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
	    CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TotalSpaceMB,
	    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
	    CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS UsedSpaceMB, 
	    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB,
	    CAST(ROUND(((SUM(a.total_pages) - SUM(a.used_pages)) * 8) / 1024.00, 2) AS NUMERIC(36, 2)) AS UnusedSpaceMB
	FROM 
	    sys.tables t
	INNER JOIN      
	    sys.indexes i ON t.OBJECT_ID = i.object_id
	INNER JOIN 
	    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
	INNER JOIN 
	    sys.allocation_units a ON p.partition_id = a.container_id
	LEFT OUTER JOIN 
	    sys.schemas s ON t.schema_id = s.schema_id
	WHERE 
	    t.NAME NOT LIKE 'dt%' 
	    AND t.is_ms_shipped = 0
	    AND i.OBJECT_ID > 255 
	GROUP BY 
	    t.Name, s.Name, p.Rows
	ORDER BY 
	    t.Name


UTENZE
-----------------------------------------------
Ruoli server necessari nella gestione del database MRT:
	- sysadmin (include tutto) 				-> Superconsigliato! (tipo Installatore)
	- db_owner (include tutti i seguenti, pi� altri)	-> Consigliato
		- db_datareader
			GRANT SELECT ON DATABASE::<name>
		- db_datawriter 
			GRANT INSERT ON DATABASE::<name>
			GRANT UPDATE ON DATABASE::<name>
			GRANT DELETE ON DATABASE::<name>
		- db_ddladmin
			ALTER ANY ASSEMBLY
			ALTER ANY ASYMMETRIC KEY
			ALTER ANY CERTIFICATE
			ALTER ANY CONTRACT
			ALTER ANY DATABASE DDL TRIGGER
			ALTER ANY DATABASE EVENT NOTIFICATION
			ALTER ANY DATASPACE
			ALTER ANY FULLTEXT CATALOG
			ALTER ANY MESSAGE TYPE
			ALTER ANY REMOTE SERVICE BINDING
			ALTER ANY ROUTE
			ALTER ANY SCHEMA
			ALTER ANY SERVICE
			ALTER ANY SYMMETRIC KEY
			CHECKPOINT
			CREATE AGGREGATE
			CREATE DEFAULT
			CREATE FUNCTION
			CREATE PROCEDURE
			CREATE QUEUE
			CREATE RULE
			CREATE SYNONYM
			CREATE TABLE
			CREATE TYPE
			CREATE VIEW
			CREATE XML SCHEMA COLLECTION
			REFERENCES
		- db_executesp

	(*) Probabilmente non sar� possibile con i ruoli proposti, procedere in autonomia con attivit� di backup e restore del db MRT, ma essendo su un server dedicato, serviranno i riferimenti delle persone DBA da contattare in caso di necessit�


Note:
- Quando crei il DB su Micronstart, l'utente preconfigurato con cui ti stai connettendo al DB server potrebbe non essere abilitato alla creazione; in tal caso, su SQL Management Studio, connettiti al DB Server con Autenticazione di Windows, vai su Utenti > [nomeutente] > propriet� > Ruoli del Server e associa DBCREATOR
- Se vuoi sapere le credenziali SQL su un server su cui MicronWeb/Infopoint � gi� installato, vai su C:\microntel\Web\MicronWeb\Web.config per le stringhe di connessione


(*) CANNOT OPEN USER DEFAULT DATABASE
Cannot open user default database. Login failed. Login failed for user ... (Microsoft SQL Server, Error: 4064)

	Si riceve questo errore quando un Login Windows o un Login SQL Server non riesce a connettersi a un database default assegnato all'utente; in questo caso, andando su Sicurezza > Logins > ... > Propriet�, non c'� alcun database assegnato come Default Database.
	Per risolvere, in fase di connessione al SQL Server:
		- Inserire i dati di login 
		- Opzioni avanzate > Propriet� di connessione > Connetti al database = "tempdb"
	Il TempDB � un database temporaneao, che viene ricreato ogni volta che il servizio SQL Server viene riavviato.
	Una volta entrato, si pu� cambiare nelle propriet� dell'utente il database di default.

PROBLEMONI
-----------------------------------------------
LOG TROPPO GRANDE
(*) Possibile causa: lo Scheduled Task di backup non ha funzionato, quindi il log non � stato sovrascritto; in pi�, essendo il database in Full Recovery Mode, il log riscrive completamente tutto

	A) PASSAGGIO DA FULL RECOVERY A SIMPLE RECOVERY
		1) Stop servizi legati a MRT
		2) Database MRT > Tasks > Detach
			Il database sparisce dall'elenco dell'istanza
			(*) Se non si riuscisse a fare il backup del database proprio a causa del fatto che il Transaction Log � pieno, allora cambiare il Recovery Mode a 'Simple' prima di fare il backup
		3) Rinominare il file .ldf nella cartella default (il percorso si vede nelle Propriet� del database, percorso default: C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA)
		4) Database MRT > Tasks > Attach > [selezionare file .mdf dal percorso corrispondente]
			Se il file .ldf viene cercato e aggiunto automaticamente alla lista, selezionarlo e cliccare su "Remove" in basso (altrimenti lo cercher� all'infinito)
		5) Database MRT > Properties > Options > Recovery Model = Simple
		6) Restart servizi legati al database
		(*) Se qualcuno di questi step d� errore, � possibile che sia perch� il disco � talmente pieno che SQL non riesce a loggare pi� niente, neanche le operazioni di attach e detach; a quel punto, l'unico modo � rimuovere/spostare il gigantico file di log
	
		(*) Errore UNABLE TO OPEN THE PHYSICAL FILE
		Unable to open the physical file [...]. Operating system error 2: �2(The system cannot find the file specified.)�. (Microsoft SQL Server, Error: 5120)
			- Dalla maschera di Attach, una volta selezionato il file .mdf dal percorso, rimuovere dalla lista il corrispondente file .ldf: in questa maniera lo ricreer� da zero


	B) VERIFICA: perch� il backup non funziona? Possibili problemi di diritti di utenza
		a. Pannello di Controllo > Strumenti di Amministrazione > Utilit� di pianificazione
		b. Selezionare il task creato per essere schedulato
		c. Propriet� > Generale > Opzioni di sicurezza > "Durante l'esecuzione dell'attivit�, utilizza l'account seguente: ..."
		d. Verifica i diritti di lettura/scrittura sulla cartella ospitante l'eseguibile (presumibilmente C:\MPW\DBBackup\ExpressMaint.exe) 
			* Verifica la compatibilit� di ExpressMaint (v. paragrafo dedicato)

PENDING RECOVERY / IN RECOVERY
Pending recovery: controlla che il database non stia cercando di tornare online ma il file di log non sia corrotto/rinominato
In recovery: attendere che il database torni online da solo
***************

ERRORI
-----------------------------------------------

(*) ERROR 3154 - RESTORE FAILED FOR SERVER '...'. (MICROSOFT.SQLSERVER.SMOEXTENDED) 
An exception occurred while executing a Transact-SQL statement or batch (Microsoft.SqlServer.ConnectionInfo)
The backup set holds a backup of a database other than the existing 'MRT' database. RESTORE DATABASE is terminating abnormally (Microsoft SQL Server, Error: 3154)

	Solution: don't create an empty database and restore the .bak file on to it; use 'Restore Database' option accessible by right clicking the "Databases" branch of the SQL Server Management Studio and provide the database name while providing the source to restore.


(*) LA SEZIONE 'DBPROVIDERFACTORIES' PUO' APPARIRE UNA VOLTA SOLA IN OGNI FILE DI CONFIGURAZIONE (SYSTEM.CONFIGURATION)
'DbProviderFactories' section can only appear once per config file error
Errore che appare, p.e., in Modifica di una tabella del database MRT o MW

	Solution: 
	Nel file "C:\Windows\Microsoft.NET\Framework\v4.0.30319\machine.config"

		<system.data>
		    <DbProviderFactories>
		        <add name="IBM DB2 for i5/OS .NET Provider" 
		invariant="IBM.Data.DB2.iSeries" description=".NET Framework Data Provider for i5/OS" type="IBM.Data.DB2.iSeries.iDB2Factory, IBM.Data.DB2.iSeries, Version=12.0.0.0, Culture=neutral, PublicKeyToken=9cdb2ebfb1f93a26"/>
		        <add name="Microsoft SQL Server Compact Data Provider" 
		invariant="System.Data.SqlServerCe.3.5" description=".NET Framework Data Provider for Microsoft SQL Server Compact" 
		type="System.Data.SqlServerCe.SqlCeProviderFactory, System.Data.SqlServerCe, Version=3.5.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"/>
		    </DbProviderFactories>
		    <DbProviderFactories/> 		<---- CANCELLARE QUESTA RIGA!

(*) Accertarsi che SQL Express vada installato sullo stesso server in cui si installa Micronpass Web! Pu� essere che il cliente abbia un server a parte, dedicato al database.

	- Cerca su Google "Microsoft SQL 2012 Express", in modo da aprire la pagina dei download di Microsoft.com
	- Scegliere YYY\xZZ\SQLEXPRWT_xZZ_YYY.exe (dove YYY � la lingua, nel nostro caso ITA, e ZZ sono i bit del sistema) e scaricare il file. Dovrebbe essere quello che pesa circa 700 MB.
	- Aperto il "Centro Installazione SQL Server", selezionare "Nuova installazione autonoma di SQL Server o aggiunta di funzionalit� a un'installazione esistente"
	- Continuare a cliccare Avanti per fare in modo che vengano scaricati i file di installazione e di aggiornamento
	- Allo step 'Selezione delle features', selezionare quali parti del SQL Manager si vuole installare; per la maggior parte dei casi, selezionare tutto.
	- Allo step 'Configurazione dell'istanza', lasciare i parametri di default
	- Allo step 'Configurazione Server', controllare che "Motore di Database di SQL Server" sia Automatico e che "SQL Server Browser" sia Disabilitato.

(*) La disabilitazione del SQL Server Browser potrebbe creare problemi in fase di accesso all'applicativo web. In tal caso, per avviarlo manualmente, andare su services.msc, cercare SQL Server Browser > click destro > Propriet� > Tipo di avvio: Automatico > tornare all'elenco di services.msc su SQL Server Browser > click destro > Avvia. Alla fine, andare su SQL Configuration Tools > SQL Server > click destro > Riavvia.

	- Allo step 'Configurazione del motore di database', scegliere Modalit� di Autenticazione "Mista" e inserire come password di amministratore Micro!Mpw13. In caso di errori, cliccare su "Add current user"

	PS: Attivare il protocollo TCP/IP per l'istanza di database

		Autorizzazioni necessarie: Per eseguire queste procedure, � necessario essere un membro del gruppo di sicurezza sysadmin per SQL Server nel server.
		1. Accedere al server a livello dati sul quale � definita l'istanza del database. 
		2. Fare clic sul pulsante Start, scegliere Tutti i programmi, Microsoft SQL Server 2005 o Microsoft SQL Server 2008, Strumenti di configurazione, quindi fare clic su Gestione configurazione SQL Server. 
		3. Nel riquadro della struttura ad albero fare clic su Servizi di SQL Server 2005 o Servizi di SQL Server 2008. 
		4. Nel riquadro dei risultati verificare che, nella colonna Stato, appaia In esecuzione accanto al nome di ogni servizio. Se � presente Arrestato, fare clic con il pulsante destro del mouse sul nome del servizio, quindi scegliere Avvia. 
		5. Nel riquadro della struttura ad albero fare clic su Configurazione di rete SQL Server 2005 o  Configurazione di rete SQL Server 2008 per espanderlo, quindi scegliere Protocolli per MSSQLServer/NomeIstanza. Se durante l'installazione � stata specificata l'istanza predefinita, il nome dell'istanza sar� MSSQLSERVER. 
		6. Nel riquadro dei risultati verificare che, nella colonna Stato, appaia Attivato accanto al nome del protocollo TCP/IP. Se appare Disattivato, fare clic con il pulsante destro del mouse su TCP/IP, quindi scegliere Attiva. 
		7. Nel riquadro della struttura ad albero fare clic su Configurazione SQL Native Client per espanderlo, quindi fare clic su Protocolli client. 
		8. Nel riquadro dei risultati verificare che, nella colonna Stato, appaia Attivato accanto al nome del protocollo TCP/IP. Se appare Disattivato, fare clic con il pulsante destro del mouse su TCP/IP, quindi scegliere Attiva. 
		9. Nel riquadro della struttura ad albero fare clic su Servizi di SQL Server 2005 o Servizi di SQL Server 2008. 
		10. Nel riquadro dei risultati fare clic con il pulsante destro del mouse su SQL Server (MSSQLServer/NomeIstanza), quindi scegliere Riavvia. 



(*) SQL SERVER INESISTENTE O ACCESSO NEGATO
Il mio server non raggiunge il SQL Server

	Verifica:
	- SQL Server Configuration Manager > Configurazione di rete SQL Server > Protocolli per <NOME_ISTANZA>
	- Abilita protocollo TCP/IP
	- Click destro su TCP/IP > Indirizzi IP > Abilita tutti gli indirizzi
	- Salva le modifiche
	- Riavvia il servizio NOME_ISTANZA

(*) LOG NOT AVAILABLE
The log for database 'MRT' is not available. Check the event log for related error messages. Resolve any errors and restart the database (Microsoft SQL Server, Error: 9001)

	- Riavvia
	- Segui gli step di troubleshooting presenti in http://www.sqlservice.se/dont-panic-the-log-for-database-name_here-is-not-available/

(*) THE TRANSACTION LOG FOR DATABASE ... IS FULL
EXC:System.Data.OleDb.OleDbException: Il log delle transazioni per il database 'mrt' � pieno. Per sapere perch� non � possibile riutilizzare lo spazio nel log, vedere la colonna log_reuse_wait_desc in sys.databases
https://sqlity.net/en/1805/eight-reasons-transaction-log-files-keep-growing/

Ogni volta che in SQL Server si invia un comando di modifica, l'operazione viene salvata nel Transaction Log prima di essere effettivamente applicata.
Questo permette di salvare eventuali operazioni in sospeso in caso di crash. 
Una volta che la transazione � applicata e i dati sono stati salvati su disco, per�, SQL Server non ha pi� bisogno di occupare memoria con il Transaction Log: ecco perch� riutilizza parti dei file log che non sono pi� necessarie.
Questo errore deriva dall'impossibilit� di fare questo riutilizzo.
Una possibile ragione �: se la Recovery Mode = FULL, SQL Server non riutilizza parti del file log fino a quando non � interamente backuppato.

Ragioni di Log Reuse Wait:

	Log Records:
	Prima che ogni transazione venga applicata, SQL Server aspetta una conferma dall'hard drive che il record nel log sia stato scritto correttamente.
	
	Log Reuse:
	I file di log sono organizzati da SQL Server come un ring buffer fatto di diversi contenitori chiamati Virtual Log Files.
	Un Virtual Log File non pi� necessario da SQL Server viene etichettato come pronto per il riutilizzo ("log truncation").

	Log Reuse Wait:
	Lo stato di Log Reuse Wait viene imposto da SQL Server a un Virtual Log File perch� pensa che sar� necessario per future operazione.
	Se succede per lungo tempo, SQL Server potrebbe trovarsi senza Virtual Log Files e dovrebbe aggiungerne di nuovi, cos� il file fisico LDF dovrebbe aumentare in dimensioni.
	Se l'autogrowth � abilitata e c'� spazio su disco, questo avviene automaticamente.
	Se l'autogrowth non � abilitata o non c'� spazio, il database diventa read-only e ogni tentativo di scrittura fallisce.
	SQL Server salva la descrizione di questo evento nella colonna [sys.databases].log_reuse_wait_desc.
	
		SELECT  D.name,
	        D.log_reuse_wait_desc
		FROM    sys.databases AS D;
		
		Possibili output:

		NOTHING
		CHECKPOINT
		LOG_BACKUP
		ACTIVE_BACKUP_OR_RESTORE
		ACTIVE_TRANSACTION
		DATABASE_MIRRORING
		REPLICATION
		DATABASE_SNAPSHOT_CREATION
		LOG_SCAN
		OTHER_TRANSIENT

	TL;DR: rifai il log usando la modalit� Simple Recovery

(*) (SECDOCLIENTHANDSHAKE()).]SSL SECURITY ERROR
[DBNETLIB][ConnectionOpen (SECDoClientHandshake()).]SSL Security error

	Check https://ashwaniashwin.wordpress.com/2018/06/18/dbnetlibconnectionopen-secdoclienthandshake-ssl-security-error/
	
	Test issue:
	- Open Notepad
	- Save the file as �Connectivity Test.udl� and file type as �All Files�
	- Open the saved file
	- Select Microsoft OLE DB Provider for SQL Server as the provider
	- Provide server connection and authentication details
	- Test the connection or open list of databases
	- The connection fails with same error message

	Reason: This fails because the secured connection between the Dynamics CRM Server 2016 and the SQL Server needs TLS 1.0 to be enabled for the OLE DB Provider for SQL Server. And the SQL Server may not have TLS 1.0 enabled for secure channel communication

	Abilita il protocollo TLS 1.0 da Regedit!

(*) (SECCREATECREDENTIALS()).]SSL SECURITY ERROR
Errore apertura connessione a DB: System.Data.OleDb.OleDbException (0x80004005): [DBNETLIB][ConnectionOpen (SECCreateCredentials()).]SSL Security error.

I server di origine e di destinazione della connessione non sono allineati sulle versioni TLS da usare.
Per esempio: magari il Data source ha solo TLS 1.0 abilitato, mentre il server applicativo usa SO Windows che ha solo TLS 1.1-1.2 abilitati e non consente l'uso della versione 1.0.
Altro esempio: Microsoft OLE DB Provider for SQL Server 
Microsoft OLE DB Provider for SQL Server is not supported with TLS 1.2. 
TLS 1.0 is not enabled on Windows 2016 Server.
Nota: il driver attualmente installato sulla macchina applicativa (i.e. Microsoft OLE DB Provider per SQL) potrebbe non supportare TLS 1.2.
	V. https://support.microsoft.com/en-us/kb/3135244 per una tabella di compatibilit�

Soluzioni:

1) Riabilitare il protocollo TLS 1.0
	� sufficiente cambiare le seguenti chiavi di registro:
		[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server] "Enabled"=dword:00000001
		[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server] "DisabledByDefault"=dword:00000000
		[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client] "Enabled"=dword:00000001
		[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client] "DisabledByDefault"=dword:00000000
	Se poi le policy interne richiedono che TLS 1.1 sia disabilitato, � possibile cambiare anche le seguenti chiavi di registro:
		[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server] "Enabled"=dword:00000000
		[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server] "DisabledByDefault"=dword:00000001
		[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client] "Enabled"=dword:00000000
		[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client] "DisabledByDefault"=dword:00000001

oppure,
2) Usare il nuovo driver OLE DB (MSOLEDBSQL), nella fattispecie:
- Arrestare tutti i servizi e fare uno snaspshot della VM
- Scaricare il nuovo driver da https://www.microsoft.com/en-us/download/details.aspx?id=56730 e installarlo sul server applicativo
- Cambiare *manualmente* (MicronStart non lo gestisce) le stringhe di connessione dei file .config di tutti gli applicativi, sostituendo Provider=sqloledb con Provider=MSOLEDBSQL





LOG IN AS SINGLE-USER MODE
-----------------------------------------------
La seguente procedura serve ad ottenere il controllo dell'istanza SQLExpress anche se non si hanno le credenziali dell'utenza sa.
Riassumendo, utilizzi il SQL Server Configuration Manager per mettere l'istanza in Single-User mode.
Questo eleva la tua utenza a sysadmin quando ti connetti.

	1. Loggarsi nella workstation come Amministratore (o Ogni utente con privilegi di amministratore)
	2. Aprire "SQL Server Configuration Manager"
	3. Cliccare su "Servizi di SQL Server" nel menu a sinistra
	4. Arrestare il servizio "SQL Server (<nomeistanza>)" e "SQL Server Agent (<nomeistanza>)" per l'istanza cui ci si riferisce
	5. Click destro su "SQL Server (<nomeistanza>)" > Propriet� > Avanzate
	6. Parametri di avvio > [aggiungere "-m;" all'inizio della stringa]
		es. "-dC:\Program Files\Microsoft SQL Server\(eccetera fino alla fine della stringa)" diventa "-m;-dC\Program Files\(eccetera)"
	7. Riavviare "SQL Server (<nomeistanza>)"
	8. Aprire SSMS da Amministratore e loggarsi con "Windows Authentication": siccome abbiamo impostato che SQL Server giri in modalit� Single-User, e si � loggati alla workstation con privilegi di Amministratore, automaticamente si ottiene un accesso "sysadmin" al database
		(*) Da qui in poi � possibile crearsi una nuova utenza senza problemi, cos� come � possibile crearsi un nuovo database
	9. Espandere il nodo "Sicurezza" nel menu a sinistra
	10. Doppio click sul login "sa"
	11. Cambiare la password inserendo una password complessa se la spunta su "Enforce password policy" � attiva, altrimenti semplicemente inserire una qualsiasi password
	12. Assicurarsi che l'account "sa" sia abilitato cliccando sull'opzione 'Status' nel menu a sinistra, alla voce "Login"
	13. Cliccare OK per confermare
	14. Nella finestra principale di SSSMS, verificare che l'Autenticazione di SQL Server sia utilizzata cliccando sul nodo pi� in alto nel menu a sinistra (di solito ".\SQL Express (SQL Server)"), click destro e Propriet�
	15. Click su "Sicurezza" nel menu a sinistra e verificare che "Autenticazione di SQL Server e Windows" sia selezionata sotto "Autenticazione Server"
	16. Cliccare OK per confermare
	17. Disconnettersi da SSMS
	18. Ricordarsi di rimuovere il parametro di avvio "-m;" dalle propriet� dell'istanza di SQL, riavviando il servizio una volta concluso

APPROFONDIMENTO: PARAMETRI DI AVVIO DI SQL SERVER
https://community.embarcadero.com/article/articles-database/1056-top-4-startup-parameters-dbas-must-know

	Working on a server is always something DBAs cherish. With every environment that they monitor, they want to know how applications can be optimally run on a specific server. In this constant pursuit of performance tuning, they always find unique ways of optimizing SQL Server startup. This article is around finding these parameters that most DBAs use in their daily life.
	Whenever SQL Server starts, it needs three startup parameters:
	� Master database data file location (-d parameter)
	� Errorlog file location (-e parameter)
	� Master database transaction log file location (-l parameter)
	The right place to change startup parameter is via the SQL Server Configuration Manager. The interface to change the startup parameters has been changed in SQL Server 2012, so we are showing both these interfaces next.
	Below is the Configuration Manager UI from SQL Server 2005 to SQL Server 2008 R2. We need to go to properties of SQL Server Service, go to �Advanced� tab and then click on dropdown at �Startup Parameters�. In this UI new parameters are separated by a semicolon. For example, if we want to add trace flag 1222 then we need to add �;-T1222� at the end.
	As you can see the above interface is error prone and not very intuitive. This was the very reason why Startup parameters has been moved as a separate tab from SQL Server 2012.
	This UI makes it easy to add/remove startup parameters. If there is a need to add a startup parameter temporarily, then that can be added while starting SQL Services via the command line. In the below examples, we would use this trick.
	
	Parametro "-m":
	This is the parameter which is used to start SQL Server in single user mode. This option is generally used to restore master database. Here is an attempt to start SQL Server via �/m� parameter from command line:

	Parametro "-f":
	This parameter is used to start SQL Server in �minimal configuration� mode. This parameter is used in situations when a DBA changed the configuration options causing SQL Server service startup failure. This startup parameter could be the only way to correct the mistakes in the SQL Server configuration.

	Parametro "-t":
	This is one of the very common parameter should be known to almost every DBA. This is a parameter which is used to enable trace flags in SQL Server. There are various documented and undocumented trace flags which are used to change the behavior of SQL Server Engine
	
	


# DB MS ACCESS
============================================================================================================================================

QUERY UTILI SU ACCESS

(*) Esempio sintassi per Select:

	SELECT TOP 500 `T37ID`
		,`T37DATAORA`
		...
		...
		,`T37EXTRADATA05`
	FROM `T37ACCTRANSITI`
	WHERE `T37DATAORA` >= '20180419000000'
	ORDER BY `T37ID` DESC

(*) Cancellare la T37 (utile per il DBUpgrade):

	DELETE [DISTINCTROW] table.*
	FROM table
	[join]
	WHERE criteria
	
	es. DELETE * FROM `T116ACCBUFFER` WHERE `T116DATAORA` >= '150101000000' 	% Per cancellare DA DATA
	es. DELETE * FROM `T37ACCTRANSITI` WHERE `T37DATAORA` <= '20150101000000'	% Per cancellare FINO A DATA

(*) Update di una tabella

	UPDATE T116ACCBUFFER
	SET T116FLAGANOMALIA='0'
	WHERE T116FLAGANOMALIA='1';



# MICRONWEB / INFOPOINT
======================================================================

INTRO
-----------------------------------------------
� Accesso MicronWeb demo da Cloud Microntel: 
	77.238.22.220/micronweb		user:wbbsuser, pwd:[nopwd]
	77.238.22.220/infopoint		user:admin, pwd:[nopwd]

Funzioni MicronWeb: anagrafica e storicizzazione, tabelle, elaborazioni, anomalie, cartellino, stampe e statistiche, impostazioni
Moduli opzionali: Infopoint Web (timbratura virtuale, missioni, straordinari, commesse, pianificazione turni, trasferta e nota spese, rimborsi spese, assenziario, pianificazioni assenze), buoni pasto, mensa prenotazione pasti, consumo pasti, centri di costo, export manodopera, scadenziario email, libro unico sezione presenze, export paghe standard

MicronWeb � il software per la rilevazione presenze e gestione dati del personale. Si pu� utilizzare per pi� aziende, private e pubbliche, allo stesso tempo. I dati ottenuti (ore lavorate, ore di assenza, turni, sostituzioni, timbrature, correzione anomalie, straordinari, ferie, permessi, ecc...) sono stampabili in versione definitiva su report e statistiche. Come Micronpass Web, lavora in ambiente web ed � quindi scollegato dall'esigenza di un disco fisico: inoltre, sfrutta la stessa base dati di Micronpass Win, suo predecessore.

INSTALLAZIONE
-----------------------------------------------
- Pacchetti di installazione disponibili al percorso: \\SRVDC1\ftp\MWEB\MWEB_PC_EXE\OFFICIAL_VERSION
- Scaricare Autosuite_XXX ed eseguire Install_Micronsuite.exe, definendo il path di installazione (percorso default C:\Microntel)
- Si aprir� Micron Suite X.X.X da cui attivare il prodotto
- MicronSuite > Database Crea/Upgrade > [Inserire i parametri di connessione al DB] > Crea

� Creazione e upgrade del database MW
- MicronSuite > Database Crea/Upgrade > Test connessione > Upgrade: per aprire il micronDBUpd
- MicronSuite > Database Crea/Upgrade > micronDBUpd > Aggiorna: per aggiornare MW
- MicronSuite > Database Crea/Upgrade > micronDBUpd > Completa: per completare i parametri mancanti

FUNZIONI
-----------------------------------------------

+ ANAGRAFICHE: anagrafica personale, anagrafica aziende (per gestione multiaziendale), totalizzatori anagrafici, impostazioni turni
+ TABELLE "A": orari di lavoro, causali, compensazione periodica, ricalcolo straordinari, calendario festivit�, gruppo causali, prospetti statistici, voci aggregate, corrispondenza Assenze/Straordinari, turni settimanali, turni festivi, turnazioni continue
+ TABELLE "B": gruppi anagrafici, centri di costo, impianti terminali, ragione sociale, tipo timbrature
+ ELABORAZIONI: conteggio giornaliero, annullamento conteggio
+ ANOMALIE: visualizzazione e stampa anomalie, giustificazione e risoluzione anomalie
+ CARTELLINO: cartellino mensile, inserimento giustificativi, inserimento assenze non timbrate, stampa prospetto mensile, stampa foglio presenze
+ STAMPE (ASCII/word/excel/pdf): timbrature, statistiche, anagrafiche
+ IMPOSTAZIONI: definizione stampe, impostazioni ragione sociale, gestione utenti

MODULI OPZIONALI:
+ Export Paghe
+ Infopoint Web: � il modulo per la distribuzione delle informazioni dall'Ufficio Personale agli Utenti. Tramite utilizzo di password personale, gli utenti possono visualizzare sul loro computer le informazioni a loro disposizione definite dall'Ufficio del Personale, come per esempio: dati anagrafici personali, cartellino, totali, giustificazioni, autorizzazioni.


STAMPA PRESENTI IN AZIENDA
-----------------------------------------------
* Stampa timbrature > Stampa presenti/assenti
(attenzione a come sono configurate le Autorizzazioni e le Viste sotto Impostazioni > Gestione Utenti !)


UTENTI
-----------------------------------------------
- Accedi al database MW su SQL
- Vai alla tabella Users
- Gli utenti con voce "Superuser = S" hanno tutte le funzioni di utente amministratore: la password � in chiaro nella seconda colonna



# DBUPGRADE
======================================================================

(*) PROBLEMA MAXLOCKSPERFILE
� possibile che il DBUpgrade, soprattutto se effettuato su un database Access, restituisca il seguente tipo di errore su log:

	01-07-2016 14:36:35:489 RunCommand: Superato il numero di blocchi per la condivisione di file. Aumentare la voce di registro MaxLocksPerFile.
	01-07-2016 14:36:35:489 RunCommand: ALTER TABLE T37ACCTRANSITI ALTER COLUMN T37CODCDC TEXT (20) NULL
	01-07-2016 14:36:35:489 doUpgradeAccess: System.Data.OleDb.OleDbException (0x80004005): Superato il numero di blocchi per la condivisione di file. Aumentare la voce di registro MaxLocksPerFile.
	01-07-2016 14:36:36:786 SetScreen ACCESS C:\MPW\DBATT.MDB ver: 6.60 required: 7.20

Questo � dovuto al fatto che il database � troppo grande. Quindi:
- Se possibile, ridurre il contenuto del database: � possibile che la tabella T37ACCTRANSITI sia troppo grande (pu� capitare per installazioni Micronutility, per le quali per� non � necessario mantenere in memoria tutti i transiti)
- Se ancora non funziona, attenersi alla procedura seguente:

	In Windows, there is certain limit for sharing files concurrently. If this threshold limit is exceeded, the fail sharing operation cannot be performed and you�ve have to give another try. There is a registry element which monitors and takes care of maximum file sharing limit and its called MaxLocksPerFile entry. So when the file sharing limit is reached, you will receive following error:
	"File sharing lock count exceeded. Increase MaxLocksPerFile registry entry."
	We got this error while sharing business files via Microsoft Access. There is big possibility that you came around this issue with Access specifically, because chances of exceeding file sharing capability remains with this application. Sometimes a reboot of system may help you to overcome this issue while in some cases you need to follow the mandatory steps to increase MaxLocksPerFile registry value as per the suggestion of error message.
	Here is how to increase MaxLocksPerFile registry value:
	(These steps will involve registry manipulation. Making mistakes while manipulating registry could affect your system adversely. So be careful while editing registry entries and create a System Restore point first.)
	1. Press Windows Key + R combination, type put regedit in Run dialog box and hit Enter to open the Registry Editor.
	2. Navigate here:
		HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\x.0\Access Connectivity Engine\Engines\ACE (if you�re 32-bit Windows edition)
		HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\x.0\Access Connectivity Engine\Engines\ACE (if you�re 64-bit Windows edition)
	Substitute the placeholder x.0 with 15.0 for Outlook 2013, 14.0 for Outlook 2010, 12.0 for Outlook 2007, and 11.0 for Outlook 2003.
	3. In the right pane of this registry location, look for the MaxLocksPerFile named registry DWORD (REG_DWORD) whose default value is root cause of this problem. The default value is 9500 in decimal base, so double click on the same DWORD to get this:
	4. In the Edit DWORD Value box shown above, increase the Value data from default value as per your need, for example, set it to 15000. Make sure that selected base is Decimal. Click OK. Close Registry Editor and restart Windows/File Explorer to make changes effective. Now try sharing files concurrently, and you won�t have any issues.


(*) ERRORE INDICI SU 6.50
Errore in upgrade della tabella T43

	30-10-2017 12:09:53:419 RunCommand: L'apporto modifiche non � riuscito perch� si � cercato di duplicare i valori nell'indice, nella chiave primaria o nella relazione. Modificare i dati nel campo o nei campi che contengono dati duplicati, rimuovere l'indice o ridefinire l'indice per consentire l'inserimento di voci duplicate, quindi ritentare l'operazione.
	30-10-2017 12:09:53:420 RunCommand: INSERT INTO T43COMREPORTS (T43FileName, T43Descrizione, T43SQL, T43Order, T43Graphics, T43Web, T43ExportTxt, T43PostElab, T43CheckOrg) VALUES ('rlabadge.rpt', 'Badge Assegnati', 'SELECT T25Codice, T25Descrizione, T25Matricola, T25TipoMatricola, T25FlagSost, T26Codice, T26Nome, T26Cognome, T26BadgeAttivo, T26CodAzienda AS Azie, T26Gruppo, T25ID1, T25TipoTessera FROM T25ComBadge B LEFT JOIN T26ComDipendenti D ON D.T26Codice=B.T25Matricola AND D.T26CodAzienda=B.T25CodAziendaIE WHERE T25TipoMatricola=''0'' UNION ALL SELECT T25Codice, T25Descrizione, T25Matricola, T25TipoMatricola, T25FlagSost, T29Codice, T29Nome, T29Cognome, T29BadgeAttivo, T29Azienda AS AzIE, '''' AS T26Gruppo, T25ID1, T25TipoTessera FROM T25ComBadge BE LEFT JOIN T29ComEsterni E ON E.T29Codice=BE.T25Matricola AND E.T29Azienda=BE.T25CodAziendaIE WHERE T25TipoMatricola=''1'' UNION ALL SELECT T25Codice, T25Descrizione, T25Matricola, T25TipoMatricola, T25FlagSost, T31Codice, T31Nome, T31Cognome, T31BadgeAttivo, '	''' AS AzIE, '''' AS T26Gruppo, T25ID1, T25TipoTessera FROM T25ComBadge BV LEFT JOIN T31ComVisitatori V ON V.T31Codice=BV.T25Matricola WHERE T25TipoMatricola=''2''', '51', '0', '1', '0', '0', '10')
	30-10-2017 12:09:53:442 LoadTableFromXML: System.Data.OleDb.OleDbException (0x80004005): L'apporto modifiche non � riuscito perch� si � cercato di duplicare i valori nell'indice, nella chiave primaria o nella relazione. Modificare i dati nel campo o nei campi che contengono dati duplicati, rimuovere l'indice o ridefinire l'indice per consentire l'inserimento di voci duplicate, quindi ritentare l'operazione.
	30-10-2017 12:09:53:446 doUpgradeAccess: System.Exception: Errore caricamento dati
	30-10-2017 12:09:54:006 SetScreen ACCESS C:\MPW\DB\DBATT.MDB ver: 6.40 required: 7.40

	Soluzione: elimina l'indice T43Order dalla tabella T43



# GNCONFIG (DETTAGLI)
======================================================================

Invio tabelle host: crea il file config.gn contenente tutti gli indirizzi di rete, gateway e subnet di tutti i rami/nodi dell'impianto
Sel. tutto + doppio click: invia il file config.gn al singolo terminale su cui si sta cliccando

VERSIONI FIRMWARE
-----------------------------------------------
Nomenclatura firmware GNet:

	BTAstvvr

	BT	% Prefisso
	A	% Accessi (in realt� fa anche presenze) 
	s	% Tipo di scheda
			D =	M243 depopolata
			N = 	M243
			G =	M243 + GPRS
			X = 	M306
			F = 	Scheda con protocollo FTP
			O =	M137
	t	% Tipo di tastiera
			1 =	No display
			2 =	LCD 4x20, tastiera 6 tasti
			3 =	LCD 4x20, tastiera 29 tasti
			4 =	Grafico 240x128, tastiera 29 tasti (M306)
				Grafico 240x128, tastiera 29 tasti e touch (M380)
	vv	% Versione firmware
			10 o maggiore
	r	% Release
			"_" oppure "<lettera>"
		(*) La release rappresentata in genere da un lettera alfabetica ha lo scopo di apportare al firmware migliorie, eliminazioni di bachi o personalizzazioni al cliente mantenendo la piena compatibilit� con la versione di riferimento.

Alcuni modelli:

	MX200, 300:	BTAD2-, BTAG2-, BTAG3-, BTAN2-, BTAN3-
	MX301:		BTAD3-
	MCTFTP:		BTAF4-
	MX400:		BTAN4-
	MXP250:		BTAX1-
	MCT:		BTAX4-

Es.
BTAN2xxx	Modello MX200 senza display, controllo accessi
BTAN3xxx	Modello MX301 con display 4x20, presenze
BTAN4xxx	Modello MX400 con display


ERRORI
-----------------------------------------------
105 BAD PACKET DESTINATION: non sta comunicando, cio� l'IP � sbagliato, o il terminale non � collegato.
	
	(*) Possibili soluzioni: innanzitutto tentare un ping. Se non pinga, il terminale � proprio scollegato e quindi pu� essere un problema hardware. Se pinga, verificare coi tecnici del cliente che tutti i dati di rete siano corretti. Eventualmente provare con la riassegnazione indirizzo IP (da EthCfg [utility di configurazione ethernet di Microntel], GnConfig o fisicamente da terminale, a seconda della comodit�) o di altri parametri di rete.
	(*) Se il terminale dovesse comunque pingare ed essere visibile tramite ARP, un ulteriore problema potrebbe essere dovuto ad eventuali conflitti tra classi di rete sul dispositivo che sta configurando: disabilitare TUTTE le schede di rete non utilizzate nella configurazione.

113 BAD CONFIG FILE: qualcuno dei parametri di connessione (MAC address, indirizzo IP, Subnet...) non � corretto; verificare i parametri

	(*) Potrebbe essere che, se il server non � nella stessa sottorete del dispositivo, non riesce a raggiungere il MAC address e quindi non � possibile neanche l'assegnazione dell'IP: questo avviene soprattutto nel caso in cui il server appartiene a una classe IP diversa dal terminale, e le regole della rete non permettono che raggiunga quel MAC address. Soluzione: collegarsi fisicamente al terminale e dare la configurazione tramite GNConfig locale, una volta che il terminale ha un indirizzo IP raggiungibile pu� essere configurato da server

FILE .QUE

	(*) Se l'MXP pinga, riceve la configurazione in maniera corretta, ma non riceve i comandi da NoService: cancellare tutti i .que dalla cartella GnConfig relativa


118 BAD GNODE LOGICAL ADDRESS
00118 bad GNode Logical Address

	(*)

TELNET
-----------------------------------------------
DEF. Telnet � un protocollo di rete basato su TCP e instaurato da parte dei client che si connettono sulla pota 23 del server; solitamente � utilizzato per fornire all'utente sessioni di login remoto di tipo riga di comando tra host su Internet.
"Telnet" � per antonomasia anche il nome del programma che un utente pu� usare per avviare una sessione Telnet (lato client) ad un host remoto.
Telnet viene usato per servizi di networking come i server SMTP o HTTP.
NB: Telnet non � un protocollo sicuro e il suo uso sulle reti pubbliche comporta seri rischi di sicurezza

Per abilitare il telnet, � necessario seguire questi step:
	- Pannello di controllo > Programmi e funzionalit� > Attivazione e disattivazione delle funzionalit� di Windows
	- Spuntare "Telnet client" o "Telnet server", a seconda della funzionalit� richiesta

Utilizzo porta telnet
	Nel Command Prompt, provare il seguente comando per testare la connessione con la porta 3001:
		telnet <IPaddress> 3001

(*) � possibile che i terminali rispondano al ping, ma il servizio non riesca a collegarsi; in tal caso potrebbe essere utile fare una verifica telnet

Se la connessione ha successo, dovrebbe partire una maschera nera con cursore pulsante. Altrimenti, un errore di connessione viene dato in risposta.
	(*) NB! Telnet funziona solo su protocollo TCPIP; se i terminali sono stati configurati per funzionare in UDP o UDPGnet, il telnet non risponder� mai

Riconfigurare la connessione Telnet alla porta 3001:
	In caso di errore alla connessione telnet, � possibile che si debba riconfigurare la porta utilizzata. Provare il seguente comando per riconfigurare la connessione telnet:
		telnet <IPaddress> 9999
		- password: zesc
		- Premere 0
		- Premere Invio a tutti i comandi finch� non riappare il menu
		- Premere 9 per salvare e uscire
		- Ritentare la connessione alla porta 3001

Cambiare indirizzo IP di un terminale M300
	telnet <IPaddress> 9999
	- password: zesc
	- Premere Invio per entrare in Setup Mode
	- Da menu, premere 0
	- Per proseguire nei campi, basta premere Invio; se si vuole modificarli, aspettare prima di entrare nel campo corrispondente e inserire il valore richiesto prima di premere Invio
	- Al fondo, premere 9 per salvare e uscire

Uscire da una connessione telnet:
	- Premere l'escape character ("CtrlDX"+"]") per entrare nella telnet console
	- Scrivere "quit"




# GNDEBUG
======================================================================

ELENCO FILE:
File 10		Buffer timbrature su MicronService
File 17		Gestione KK
	rec.0-7		Ultima timbratura letta da KK specificato dal numero di record
File 20		Buffer timbrature su Winatt
File 31		Gestione data entry
	rec.3		Ultima timbratura letta da TBase
File 142	Parametri di rete


ATTIVAZIONE WATCHDOG
-----------------------------------------------
Il "watchdog" � un sistema di temporizzazione hardware che permette alla CPU di rilevare un loop infinito di programma oppure una situazione di deadlock.
Rilevando questi problemi, � possibile prendere provvedimenti per correggere la situazione per esempio resettando il sistema.

Dalla versione firmware 3.0A � disponibile la programmazione del watchdog.
Di default il watchdog � disabilitato (valore FF) e per abilitarlo � necessario utilizzare l'utility GNDebug oppure il display.

NB: chiaramente GNDebug si pu� usare se corrispondente btService � fermo

- Da GNDebug:
	- Selezionare il Nodo dal menu a tendina Node
	- Cliccare sul pulsante I2C nella barra in alto: si apre la maschera I2CBus
	- Per conoscere lo stato del watchdog:
		- Compilare il campo Buffer con i valori 7F 00 01 
		- Cliccare su EEP
		- Confermare con la spunta verde in basso
	- Per abilitare il watchdog: 
		- compilare il campo Buffer con i valori 7F 00 01 00 
		- Cliccare su EEP 
		- Cliccare sulla spunta verde in basso
	- Per disabilitare il watchdog: 
		- compilare il campo Buffer con i valori 7F 00 01 01
		- Cliccare su EEP
		- Cliccare sulla spunta verde in basso
- Da tastiera (su MCT):
	- Sequenza F1-F2-F1-F2-F1-ROSSO per accedere al menu
	- Miscellaneous > Watchdog





RISCARICA X TIMBRATURE DA TERMINALE
-----------------------------------------------
Far riscaricare dal terminale un numero X di timbrature 'in pancia'
- Aprire GnDebug
- Selezionare il nodo
- Premere sul pulsante "Read File" (in basso, simbolo con due fogli)
- Inserire number =10 (MicronService) o =20 (WinAtt)
- Seguire la seguente procedura:
	es. AC 01 AC 01 01 (X=50)
		- Il primo AC 01 = puntatore di carico (C)
		- Il secondo AC 01 = puntatore di scarico (S)
		- Ribaltare (S):		01 AC
		- Convertire (S) in DEC:	0428
		- Sottrarre X a (S):		0378
		- Riconvertire (S) in HEX:	017A
		- Ribaltare (S):		7A 01
		- Sovrascrivere all'(S) esistente e dare INVIO
- Uscire da GnDebug

RISCARICA TUTTE LE TIMBRATURE
-----------------------------------------------
- Aprire GnDebug
- Selezionare il nodo
- Premere sul pulsante "Read File" (in basso, simbolo con due fogli)
- Inserire number =10 (MicronService) o =20 (WinAtt)
- Seguire la seguente procedura:
	es. 

* Se il Noservice risponde con "Funzione non prevista", � perch� sta scaricando dati VUOTI (capita nel caso in cui, per esempio, ci siano poche timbrature); in tal caso, basta far ripartire dall'inizio del buffer (puntatore di scarico = 00 00)

VERSIONE PIC KLEIS
-----------------------------------------------
- GNDebug > [Seleziona nodo] > Read File > Number = 15 > Read File > Number = 17



AGGIORNARE PARAMETRI DI RETE
-----------------------------------------------
(*) Questo procedimento � utile per cambiare parametri di rete quando, per esempio, il terminale risponde al ping
- GNDebug > [Seleziona nodo] > Read File > Number = 142 (Parametri di rete)
- I parametri di rete sono scritti nella prima stringa in formato HEX, cambiarli di conseguenza
- Premere INVIO e poi RESET





# REPORTS
======================================================================

� possibile che il report non si apra in formato PDF o DOC. Il problema potrebbe essere legato all'installazione dei Crystal Reports in fase di installazione della Micronpass Application Suite. Di solito, l'installazione di $mrtxxx.zip prende in automatico i file setup dei Crystal Reports: nel caso in cui non funzionasse,
- Reinstallare CRRedist-32 o CRRedist-64 (nel dubbio, entrambi)
- Riavviare l'IIS

Per eventuali ulteriori problemi, consultare il log (MPW\Micronpass\logs\)

COMPATIBILITA'
----------------------------------------
I Crystal Reports 2008 non sono compatibili con il sistema operativo Windows Server 2012R2; per farli funzionare su 2012R2 � necessario trovare una versione pi� recente, che per� necessita per forza l'aggiornamento di Micronpass a una versione compatibile
Spiegazione: Crystal Reports 2008 (quello che usiamo nelle versioni 6.8.x) non � compatibile con i sistemi operativi pi� recenti. Con vari �trucchetti� siamo riusciti a campare qualche anno in pi� (i workaround sono 2: cambiamento dei font sui reports, settaggio a 32bit dell�application pool). Sono workaround che per� non sempre funzionano. In realt� bisognerebbe installare una versione �nuova� (7.2.x, per esempio) che utilizza una versione certificata di Crystal Reports.


ESPORTAZIONE IN EXCEL
----------------------------------------
� capitato che, in fase di apertura-salvataggio di file in formato Excel, apparisse il problema:

	Impossibile accedere al file "http://<server>/mpassw/frm_home.aspx?... ... ... ...". I motivi possibili sono:
	* Il nome o il percorso del file non esiste
	* Il file � utilizzato da un altro programma
	* Il nome della cartella di lavoro che si sta tentando di salvare corrisponde a quello di una cartella di lavoro attualmente aperta


Questo appariva SOLO su alcuni client del cliente, malgrado da server funzionasse l'esportazione in Excel.
Provare i seguenti step:
	- "Enable 32-bit Applications" sulle impostazioni avanzate dell'Application Pool
	- Inserire MPW nei siti attendibili o nell'Intranet
	- Andare su web.config e rimuovere/commentare la seguente riga:
		    <add name="X-Frame-Options" value="SAMEORIGIN"/>
 
(*) Statistica presenti (Present and Absent people stats): richiede necessariamente il filtro 'Data e ora transito', e l'inizio e la fine del periodo devono risiedere all'interno della stessa giornata (NON 24 ore)

(*) "Funzione non autorizzata" in Personalizzazione dei Report. Controllare che:
	- Utente > Autorizzazioni > "Reports" sia spuntato
	- Utente > Autorizzazioni > Gestione Utenti > "Autorizzazioni reports" sia spuntato
	- Utente > Autorizzazioni Reports > il report che si vuole personalizzare sia spuntato sia per la visibilit� sia per la modifica


AGGIUNGERE FILTRI NEI CRITERI DI ESTRAZIONE
----------------------------------------

Prerequisito: ovviamente il campo che stiamo aggiungendo deve poter essere ricavabile da query su dei campi gi� esistenti nelle tabelle di MRT.

Esempio per aggiungere il campo "Comando di Varco" al report Transiti:

T49 (La tabella con le propriet� di ogni report)
	T49FILENAME		Transiti.rpt		% Nome del report
	T49CAMPO		T37OUTVARCO		% Valore da ricavare
	T49DESCRIZIONE		Comando di varco	% Descrizione da visualizzare nel menu a tendina
	T49CANORDER		0			% Pu� essere ordinato?
	T49UTENTEMODIFICA	dbupgrade		% Utente di modifica, si pu� copiare questo
	T49DATAORAMODIFICA	20170217100238		% Data ora modifica, si pu� copiare questo

T50 (La tabella con le propriet� di ogni filtro usato dai report)
	T50CAMPO		T37OUTVARCO		% Nome del campo
	T50SQL						%
	T50NUMERICO		1			% Valore numerico
	T50NUMERICODB		1			% Valore numerico
	T50MAXLUNGHEZZA		3			% Lunghezza massima del valore
	T50UTENTEMODIFICA	dbupgrade		% Utente modifica
	T50DATAORAMODIFICA	20170217100239		% Utente modifica
	T50ISGRUPPOFIELD	

	(*) Il filtro per comando di varco � disponibile dalla versione 7.4.2 di Micronpass Web

ERRORI
----------------------------------------
(*) PROBLEMA DI TIMEOUT IN GENERAZIONE DEI REPORT
Un report la cui generazione supera il valore in Execution Timeout di default del Framework (150s) d� errore di timeout, anche se la quantit� di record da elaborare non � alta.
Questo pu� essere dovuto a limitazioni sulla RAM consumabile da parte di SQL Server (ad es., SQL Express 2012 pu� utilizzare al massimo 1GB di RAM).
Una correzione pu� essere la seguente, forzando il valore di timeout nel Web.config dell'applicazione, per� � solo un palliativo: appena possibile riavviare comunque l�SQL Server.

            Sostituire:
            <httpRuntime maxRequestLength="4096" targetFramework="4.5.2"/>

            Con:
            <httpRuntime maxRequestLength="4096" targetFramework="4.5.2" executionTimeout="600" />             <!--Dove il valore di executionTimeout (in secondi) � arbitrario-->

Link di riferimento:
https://docs.microsoft.com/en-us/dotnet/api/system.web.configuration.httpruntimesection.executiontimeout?view=netframework-4.5.2




# STAMPA BADGE (EVOLIS PRIMACY + EASYGO)
======================================================================

## Procedura di attivazione di una stampante badge

### Materiale hardware:

	- Stampante badge Evolis, con cavo seriale-USB di comunicazione e cavo di alimentazione
	
		https://it.evolis.com/stampante-card/stampante-carte-primacy#
		Modelli di stampante: Primacy, Zenius
		- � una stampante 'termografica'
			Essenzialmente, stampa a inchiostro le zone indicate, poi le copre a caldo con della polvere termoplastica che fondendosi crea una copertura polimerizzata
		- Risoluzione standard 300x300 dpi, personalizzabile fino a 300x600 dpi (colori) o 300x1200 dpi (monocromia)
		- Velocit� di stampa solo fronte: 190-225 carte/ora (solo colori) 800-1000 carte/ora (monocromia)
		- Velocit� di stampa fronte-retro: 140 carte/ora (colori)
		- Capacit� di carico: 100 carte (spessore standard 0.76mm)
		- Capacit� di scarico: 100 carte (spessore standard 0.76mm)
		- Compatibilit� carte: ISO CR80-ISO 7810 (53.98mm x 85.60mm)
	
		La stampante Evolis ha un design molto semplice, con le seguenti componenti:
		a. Corpo principale, contenente nastro di stampa e moduli di codifica (magnetizzatore, coupler MIFARE) a seconda del modello
		b. Cavo di alimentazione
		c. Cavo seriale-USB
		d. Cassetto frontale superiore: punto di ricarica dei badge
		e. Cassetto frontale inferiore: punto di erogazione dei badge correttamente codificati
		f. Cassetto posteriore (se montato, opzionale): punto di erogazione dei badge NON correttamente codificati
	
	- N nastri Ribbon Evolis HighTrust 
		Color YMCKO: capacit� 300 prints/roll
		Monochrome Black: capacit� 2000 prints/roll
	- Case CardPresso contenente chiavetta USB di installazione/licenza e manuale utente
		Tutorial web: https://it.evolis.com/software/software-progettazione-carte-cardpresso#tab-0-2
	- DVD di installazione Primacy Zenius premium suite (contiene dirvers, software e documentazione)
	- Cleaning kit con istruzioni

	Assistenza Evolis: 
		assistenza@ermes-online.it, +39 051.757040
		Igor Osio (igor.osio@ermes-online.it)
		Luca Cesaro (luca.cesaro@ermes-online.it)


### Predisposizione software su server:

	- Installare MicronCardFive ultima versione (>= 4.0.0)
		MicronCardFive è il servizio che si occupa di fare un polling sulla tabella T25COMBADGE ogni N secondi (parametro "IntervalTime" in MicronCardFiveService.exe.config).
		Ogni volta che trova un record con una data-ora in un formato specifico (parametro "FormatoDataNote" nel file MicronCardFiveService.exe.config) nell'attributo T25DESCRIZIONE (valore scritto da CardPresso): 
			1. aggiorna il campo T25ID1 del record con la traccia letta dalla stampante
			2. manda un wakeup al btService con l'abilitazione del badge
		Impostare parametro FormatoDataNote = 's' (solo per CardPresso)
	se trova un record con questa data-ora in T25DESCRIZIONE scrive il campo T25ID1 e manda un wake-up al btService di riferimento
	- Creare la vista logica su SSMS:
		La vista deve mostrare tutti i dati da stampare, più i dati aggiornati in fase di stampa (T25ID1, T25DESCRIZIONE)
		Qualora ci fosse una sola vista per tutte le anagrafiche, chiamarla BADGE
		Se invece si dovesse creare viste diverse per layout diversi a seconda del tipo matricola:
			per i dipendenti, chiamarla D_BADGE
			per gli esterni, chiamarla E_BADGE
			per i visitatori, chiamarla V_BADGE
			e cos� via..


### Procedura su postazione client:

Il client di stampa è la postazione su cui si installerà CardPresso, ovvero il software di gestione della stampa.
Prerequisiti di sistema client di stampa:
	- Sistema operativo >= Windows 10
	- Connettività al server app e al server database
	- Utente almeno power-user o amministratore locale per:
		poter installare i driver
		poter accedere ai componenti HW della stampante


	Predisporre la stampante:
	- Alimentare la stampante senza collegare il cavo USB al client
		All'alimentazione, il pulsante di start della stampante si illumina e la stampante emette alcuni versi
	- Aprire il coperchio premendo sulla superficie e inserire il nastro (entra solo in una maniera, con i ganci verso il pannello frontale)


	Predisposizione software su client:
	- Disattivare Firewall
	- Installare driver stampante
		I driver si trovano nel CD Evolis Premium Suite (E:\DRIVER\Windows\*)
			copiarli in locale al percorso C:\MPW\DRIVER_STAMPANTE per poterli utilizzare nel caso in cui si perdesse il CD
		I driver della stampante includono i driver del magnetizzatore
		Il wizard di setup avverte che il cavo USB *NON* deve essere collegato durante l'installazione
		Inoltre, viene creato un collegamento ad Evolis Print Center in esecuzione automatica per tutti gli utenti
	- Al termine dell'installazione dei driver, eseguire il nuovo software di gestione Evolis Print Center
	- Collegare il cavo seriale-USB della stampante:
		l'Evolis Print Center dice "Problema alimentazione carte" (icona gialla nel tray di Windows): sta già parlando con la stampante
	- Installare driver del coupler RFID
		*** Il coupler è considerato un componente *esterno* alla stampante: i driver vanno installati perché il sistema operativo lo vede come un lettore RFID da gestire separatamente
		*** V. sotto come testare la visibilit� del coupler dall'OS
		125 kHz:
			ACG125
			Ermes125 (obsoleto)
		13.56 MHz:
			Omnikey HID Global
		Spacchettare in C:\MPW\DRIVER_COUPLER e installare la versione corrispondente ai bit dell'OS
	- Creare una cartella C:\MPW\LAYOUT dove lasciare i layout grafici .card
	- Installare software di stampa badge CardPresso Ermes
		Inserire chiavetta USB > eseguire cardPresso[Ermes]x.x.xx.exe
			Lingua = Italiano
			Percorso = [lasciare default]
			[installazione con tutte le spunte di default]
			*** La chiavetta funziona come licenza! Senza la chiavetta inserita il software non parte.
			*** Inoltre, funge da licenza hardware - è legata alla macchina su cui è stata attivata, non si può spostare trasparentemente su un nuovo client
	- Test di visibilità del coupler:
	*** Ovviamente la stampante deve essere accesa
		- CardPresso > Home Page > Inizia usando CardPresso Ermes... > Crea personalmente un badge... > Tipi di card comuni > MIFARE_Classic
		- Barra di navigazione > Anteprima codifica (simbolo contactless) > Codifica script > Codificatori contactless = OMNIKEY CardMan ecc.
	- Crea DSN per ODBC:
		- Strumenti di Amministrazione > Origini dati ODBC (64-bit)	% La creazione di un Data Source Name (DSN) a livello di sistema serve all'applicazione per potersi connettere al database usando il driver ODBC
			> DSN di sistema > Aggiungi > 
				Driver = SQL Server
				Nome = BADGE
				Descrizione = [inserisci descrizione]
				Server = [copiare server da stringa di connessione, attributo 'Data Source']
				Autenticazione SQL Server (inserire credenziali)
				Usa il seguente database predefinito = MRT		% oCIO!
		- Test connettività verso il database: crea un file test.udl, compilalo con i parametri di connessione (data source, login, database name) e clicca su Verifica Connettività
	- [Opzionale] Creare un percorso di rete utilizzando l'apposito .bat che punti al percorso \MPW\Micronpass\photos
	
		Esempio di batch:
			net use F: /d /y
			net use F: \\172.17.94.148\photos Photos! /user:srv-microntel\gepa


	Configurazione stampante:
	- Pannello di controllo > Dispositivi e stampanti > Evolis Primacy > [click destro] > Imposta come predefinita
	- Pannello di controllo > Dispositivi e stampanti > Evolis Primacy > [click destro] > Preferenze stampa
			Orientamento = ORIZZONTALE
			Codifica mediante applicazione = IMPOSTAZIONE PREDEFINITA	% In realt� ha effetto solo per la magnetizzazione
	- Pannello di controllo > Dispositivi e stampanti > Evolis Primacy > [click destro] > Proprietà stampante
			Avanzate > Invia direttamente alla stampante = TRUE
	- Evolis Print Center > Proprietà > Stampa > Orientamento carta = ORIZZONTALE		% In realtà lo eredita dalle propriet� della stampante impostate su Pannello di Controllo
	- Evolis Print Center > Proprietà > Amministrazione > Standby non consentito = TRUE	% Per disabilitare lo standby della stampante
		> Applica le impostazioni
	- Evolis Print Center > Proprietà > Codifica > Magnetica > Identificazione automatica = TRUE	% in realtà lo legge dalle proprietà della stampante cambiate allo step precedente
		*** Se non permette la modifica di quest'ultimo parametro, è perché nella stampante non è inluso il magnetizzatore!


� Configurazione CardPresso:
*** Richiede stringa di connessione al database MRT con dati in chiaro
- File > Stampa > Operazioni avanzate di Stampa > Aggiorna stato stampa = TRUE >
	> Aggiornamenti automatici stato stampa > Colonna = DATASTAMPA, valore = $PRINTDATE > Salva	% Passaggio importante! Questo parametro impone che, per ogni stampa, venga scritta la data-ora di stampa nel campo DATASTAMPA (corrispondente a T25DESCRIZIONE)
- File > Stampa > Stampa > Database > Seleziona record nella lista > Salva
- File > Stampa > Stampa > Operazioni di stampa > 
	Stampa del fronte = TRUE
	Operazioni contactless = TRUE
	Codifica Magnetica = TRUE 	(SE � presente e configurato il modulo magnetizzatore nella stampante)
	> Salva
- Se hai già i layout (file .card):
	- Aprire uno dei layout (per es: "FRONTE.card")
		- Database > Connetti > 
			- Procedura guidata connessione db > Open Database Connectivity (ODBC) 			% Selezione del database a cui connettersi	
				Database = BADGE
				Nome utente = [inserisci SQL login username]
				Password = [inserisci SQL login password]
				[Ricorda Credenziali]
			- Procedura guidata connessione db > Operazione: SELEZIONA VISTA > DBO.BADGE (al fondo delle viste INFORMATION_SCHEMA.VIEW_xxxx)	% Selezione della vista logica
			- Procedura guidata connessione db > Seleziona tutte le colonne = TRUE
					*** Se non permette di selezionare una delle colonne visibili, � a causa del tipo di dati non supportato. Provare, per esempio, a convertire nvarchar in varchar (si fa cos�: CAST(field AS VARCHAR(200)))
			- Procedura guidata connessione db > Guide Colonne = BADGE	% IMPORTANTE: CardPresso *non* funziona con chiavi composite, scegliere una colonna sola come Chiave Primaria
			- Procedura guidata connessione db > Filtro = [skip]
			- Procedura guidata connessione db > Ordine contenuto colonne = CODAZIENDAINTERNA[1], COGNOME[2]
		(Potrebbe essere richiesta una disconnessione e una riconnessione del database per poter visualizzare i dati)
	- Per configurare il coupler:
		Barra di navigazione > Anteprima codifica (simbolo contactless) > Procedure guidate > Leggi l'UID della scheda Contactless e aggiorna la colonna del documento
		- Desidero il numero di serie della mia carta = HEXADECIMAL
		- Desidero il mio numero di serie = REVERSED ORDER
		- Desidero copiare il numero di serie della mia carta su = [scegli colonna contenente T25ID1]
		Si crea quindi lo script di codifica (ovviamente il codificatore selezionato deve essere OMNIKEY CardMan 5x21..)
	- Per configurare il magnetizzatore:
		- Retro > Track2 > Sorgente > Concatenato > Prefisso = [FATTO DA FABIETTO]
		- Retro > Track2 > Sorgente > Colonna = MAGNETICO
			*** Attenzione alla quantità di cifre
	- Per collegare alla vista logica i campi variabili del layout:
		- Propriet� generali del layout:
			- Clicca sullo sfondo del layout > [menu sulla destra] > Database
				Mostra il contenuto di tutti i campi
					Campo Foto > [...] > Didascalia colonna = FOTO
					Campo Foto > [...] > Tipo dati = Punta a immagine indicizzata > [...] > 
						> Cartella Immagini = [cartella Photos (eventualmente, tramite percorso di rete appositamente creato, v. sopra)
						> Formato immagine = IMMAGINE A DIMENSIONE LIBERA
						> Image Name = VISIBLE
						> Default image name = UNIQUE IDENTIFIER
					Campo Foto > Modifiche consentite = S�
					Campo Foto > Acquisisci = DALL'EDITOR FOTO
				[Riaggiornare il database alla fine di questa configurazione]				
		- Campi di testo:
			- Seleziona campo > [menu sulla destra] > Sorgente
				Sorgente = Dal Database
				Tabella = DBO.BADGE	% Nome della vista sorgente
				Colonna = NOME		% Esempio per un campo di testo contenente il valore della colonna NOME
				Auto aggiustamento caratteri = 
					MAI		% Mantiene i caratteri nel size originale (vengono mostrati solo i caratteri del testo che rientrano nell'area, gli altri vengono tagliati)
					SEMPRE		% Adatta sempre il size dei caratteri all'area
					ESPANDI E ADATTA
					RIDUCI E ADATTA	% Da usare se il testo � troppo lungo e va comunque mostrato su un'unica riga
			- Seleziona camPo > [menu sulla destra] > Font
				Famiglia caratteri = [scegli font]
				Dimensione del carattere = [scegli size automatico o fisso]
				Colore = [scegli colore RGB]
				A capo automatico = TRUE/FALSE		% Per impostare di andare a capo automatico
		- Campi immagine:					
			- Seleziona campo > [menu sulla destra] > Sorgente
				Sorgente = Dal Database
				Tabella = DBO.BADGE	% Nome della vista sorgente
				Colonna = @FOTO		% Esempio per un campo contenente il valore della foto
				Salva con documento = S�
				Riconoscimento del viso = No
				Apri l'editor delle immagini = No


## Utilizzo stampante:

Si dà per scontato che il record che si vuole stampare sia già inserito nel database MRT
- Inserisci il/i badge con banda magnetica rivolta verso il BASSO e verso DESTRA, guardando frontalmente la stampante
- Apri CardPresso
- Cerca il record da stampare:
	CardPresso > Anteprima database (in alto, simbolo db) > Filtro database:
		Campo = COGNOME					% Il cognome è un esempio, si pu� usare una qualsiasi delle colonne della vista logica
		Operatore = è uguale(=) [oppure LIKE]
		Valore = [inserire cognome]
		Applica
- File > Stampa > Stampa > [sel. dalla lista] > Stampa (oh mi raccomando caricare i badge!)
	Se la stampante � spenta, appare un pop-up che dice "Stampante in modalit� sospensione"
		A quel punto, per�, attenzione al coupler selezionato in CardPresso! Soprattutto se la postazione ha altri lettori RFID
		Nel momento in cui la stampante si riprende, infatti, potrebbe pre-selezionare un codificatore diverso dall'OmniKey
- La stampante, nell'ordine:
	a. legge la traccia RFID del badge inserito, scrivendone il campo nella colonna T25ID1 e scrivendo la data-ora di stampa in T25DESCRIZIONE
		Il servizio MicronCardFive cercher� i badge con T25DESCRIZIONE popolato con data-ora e invier� il dato al MicronService
	b. magnetizza la banda magnetica, se selezionata in fase di stampa
	c. stampa la grafica del badge
[Test]: verifica che sia stato scritto T25DESCRIZIONE
[Test]: verifica che sia stato scritto T25ID0 e T25ID1 
[Test]: verifica che funzioni banda magnetica e tag RFID
- NB: Per espellere la carta
	Evolis Print Center > doppio click sulla stampante > Manutenzione > Dialogo con il codificatore > Espellere carta
- NB: Per leggere la banda magnetica da un badge:
	Inserisci il badge con banda magnetica rivolta verso il basso e verso destra
	Evolis Print Center > doppio click sulla stampante > Manutenzione > Dialogo con il codificatore > check Banda 2 > Lettura banda

Manutenzione stampante:
- Cleaning kit (procedura di pulizia da fare ogni 1000 stampe circa)

Note formazione:
- Micronpass Web: gestionale delle anagrafiche
- CardPresso: gestionale di stampa
Entrambi i software puntano allo stesso database, anche se CardPresso vede esclusivamente una tabella 'filtrata' e strutturata appositamente per semplificare la stampa.


### --OLD from here--]
----------------------------------------
EVOLIS PRIMACY: INTRO
- Lucetta stampante: indica lo stato di alimentazione delle carte
	acceso continuo		% carte finite
	acceso lampeggiante	% in fase di fine
	spento			% tuttapposto
- Evolis Print Center: servizio di monitoraggio dello stato della stampante; visibile nel tray di Windows, indica lo stato della stampante e apre le impostazioni
	- Stato stampante (colore dell'icona):
		- Grigio	% Stampante non in linea (tipo, spenta)
		- Giallo	% Carta assente ("Problema alimentazione carte")
		- Arancione	% Nastro assente
		- Rosso		% Errori vari: appaiono i popup (dettagli nell'Evolis Center)
		- Verde		% Pronta per la stampa
- Inserire il nastro (entra solo in un verso), ruotando i due rulli finch� la parte bianca non � al centro

PREPARAZIONE

PC CLIENT: INSTALLAZIONE DRIVER STAMPANTE E CONFIGURAZIONE INIZIALE
	- Collega alimentazione stampante, ma NON collegare USB
	- Autorun dei driver stampante
	- Dispositivi e stampanti > Evolis Primacy > Propriet� stampante > Avanzate: spunta su "Invia direttamente alla stampante" > Applica; 
	- Dispositivi e stampanti > Evolis Primacy > Propriet� stampante > Generale > Preferenze > Orientamento: <inserire l'orientamento corretto a seconda del layout>
	- All'installazione completata dei driver della stampante, � possibile accedere a un agent chiamato "EVOLIS PRINTER CENTER" dalle icone in basso a destra nella barra di avvio: permette di vedere configurazione della stampante, stato, orientamento, pagine, ecc...

		(*) Note sulla pulizia: - Spegnere stampante e aspettare che si raffreddi 
					- Da Evolis Printer Center, seguire le istruzioni di "Avvia Pulizia". Per fare in modo che la carta adesiva (nel kit pulizia) funzioni, riaccendere la stampante.
					- Passa il 'cotton fioc' sulla testina di stampa

PC CLIENT: INSTALLAZIONE DRIVER DEL COUPLER MIFARE
	- I driver si possono comunque scaricare dal sito HID OMNIKEY 5x2x (4 MB circa)

PC CLIENT: INSTALLAZIONE DRIVER ACR122U

DATABASE: CREAZIONE VISTE LOGICHE SU MRT
	- DB MRT > Views > New View > Add T25COMBADGE e T26COMDIPENDENTI
	- T25COMBADGE: mettere spunta su Codice, Descrizione, UtenteModifica, ID1
	- T26COMDIPENDENTI: mettere spunta su Nome, Cognome, BadgeAttivo, Matricola, Foto, Qualifica, CodAzienda
	- Fare un collegamento tra T25Codice e T26BadgeAttivo. Chiamare gli Alias come Nome, Cognome, Badge, Matricola, Qualifica, Foto, Azienda, Note, Mifare. Esegui Query e salva la vista logica come "Dipendenti" (perch� riguarda i dipendenti).

PC CLIENT: EASYGO
(Collegamento dell'eseguibile EasyGo sul desktop!)
	- Settare subito nuovo percorso di default: simbolo Folder e simbolo Home
	- Aggiustare la risoluzione, se necessario (se si � cambiato monitor rispetto all'ultima volta, premere su 'Preview' e poi di nuovo 'Design' per avere una vista con parametri e anteprima)
	- Progetto > Famiglia Stampante: Evolis; Progetto > Stampante: Evolis Primacy
	- Progetto > Cartella Foto > Formula > Pulisci + Percorso foto (Standard: C:\EasyGo\Foto)
	- Progetto > Percorso Immagine (sfondo) > Formula > Pulisci + File
	- Progetto > Stringa di connessione > Formula > Database > Provider: Microsoft OLE per SQL Server
	- Progetto > Stringa di connessione > Formula > Database > Connessione: <ServerName>, <Username>, <Password>, <SelectDB>, Test Connessione, dare OK
	- Progetto > SQL > Formula > Pulisci + "SELECT * FROM DIPENDENTI"
	- Database: drag-n-drop dei campi del database sull'area di disegno

		(*) Per CAMBIARE IL N� DI CIFRE VISUALIZZATE: Campo testo ID Badge > Formula > Pulisci > Elemento > N�badge > Avanti > Trasformazione > TRIM() > <parametri> > Aggiungi Risultati al campo

ASSOCIAZIONE DEL CODICE MIFARE:
	- Nuovo campo Smartcard (pu� essere messo in qualunque punto del disegno, tanto non apparir� nella stampa)
	- Evolis Primacy > Pulsante "Evolis Interface" > Printer, 1� campo: Evolis primacy, 3� campo: Mifare. Clicca su "Move Card to" per fare in modo che la stampante sposti il badge dallo sportello frontale a sotto il coupler mifare
	- Propriet� > Lettore > Nome lettore: AUTO (prende automaticamente il nome del lettore)
	- Propriet� > Lettore > Tipo Chip: mifare
	- Propriet� > Modulo Fisico > Mifare
	- Propriet� > Chip > Tipologia: mifare
	- Propriet� > Chip > Chip: Mifare 1K
	- Propriet� > Applicazione > Operazione: OPEN (accende l'antenna)
	- Propriet� > Applicazione > Operazione: READ (prova a leggere) > TRUE (ha letto il codice mifare nella tessera)
	- Propriet� > Applicazione > Operazione: CLOSE (chiudi) > FALSE

	- Pagina (in modalit� estesa del menu) > Processo > Queries > ... > Aggiungi > Stringhe di connessione: <come sopra>; SQL > Formula > Pulisci + Inserisci la seguente query 

		"UPDATE DIPENDENTI SET MIFARE='{JOB.UID_LSB}', NOTE='{TIMESTAMP}', UTENTE='CARDFIVE' WHERE MATRICOLA='{record.MATRICOLA}' "

	Questo permette che nella vista logica DIPENDENTI (e di riflesso nella tabella T25COMBADGE) vengano aggiunti i badge letti da stampante: il servizio MicronCardFive (v.sotto) riconoscer� tali badge perch� hanno un codice mifare di sole 10 cifre (invece che 20), hanno 'CARDFIVE' nel campo UtenteModifica e hanno la data/ora di stampa nel campo Note. 
	(*) Il servizio MicronCardFive ha anche un log in MPW\MicronCardFive, dove dice data-ora-ID-IDX scritti nel database
	Una query del tutto equivalente �

		"UPDATE T25COMBADGE SET T25CODICE='{JOB.UID_LSB}', T25DESCRIZIONE='{TIMESTAMP}', T25UTENTEMODIFICA='CARDFIVE' WHERE T25MATRICOLA='{record.MATRICOLA}' "

	- Stampando, il codice mifare corrispondente viene scritto nel database. I campi suddetti verranno completati e letti dal servizio MicronCardFive (v.sotto)

SERVIZIO MICRONCARDFIVE
MicronCardFive (cos� chiamato perch�, prima dell'avvento di EasyGo, si riferiva al software badge CardFive) � un servizio che periodicamente svolge funzioni di completamento del database nei record corrispondenti ai badge salvati da stampante. MicronCardFive di fatto, per tutti quei badge che hanno T25UTENTEMODIFICA='CARDFIVE' e T25DESCRIZIONE='<dataorastampa>':
1- Aggiunge 10 zeri in testa al codice mifare nella tabella T25COMBADGE al campo T25ID1
2- Cancella il campo T25DESCRIZIONE (che conteneva la data/ora)
3- A seconda della matricola, invia le abilitazioni al MicronService. In questo modo, un badge uscito dalla stampante � automaticamente salvato tra i profili d'accesso, cio� funziona gi�.

ASSOCIAZIONE MANUALE DI BADGE CON MICRONBADGE


NOTE PER FORMAZIONE AL CLIENTE:
- Si intende per "postazione stampa badge" il pc su cui si installa EasyGo e la stampante badge collegata
- Verifiche iniziali: chiavetta EasyGo attaccata alla postazione di stampa badge?; pc in rete con il server?
- Aprire EasyGo: seleziona Maschera (es.DIPENDENTI, ESTERNI e VISITATORI) e click su "Carica Progetto"
- Record singolo: seleziona colonna, poi 'Filtro'; inserire il filtro e dare OK per trovare il record; dare 'Stampa' e 'Record corrente' (o 'Record selezionato', che nel caso di record singolo � la stessa cosa)
- Record multipli: Seleziona pi� record dalla tabella anagrafica; dare 'Stampa' e 'Record Selezionato'.

	(*) In caso di record multipli selezionati, la stampante stamper� in ordine crescente di 

RIPRISTINO DELLA MACCHINA IN CASO DI GUASTO:
- La macchina nuova DEVE essere aggiornata
- Copia su nuova macchina la cartella C:\EasyGo
- Da CD, reinstallare i driver della stampante



# CARDPRESSO
======================================================================

NOTE GENERALI:
- Chiavetta fa da installazione e licenza, non funziona senza
- Cardpresso.exe
- Al termine dell'installazione, Dispositivi e Stampanti > Evolis Primacy > Propriet� stampante > Avanzate > Invia direttamente alla stampante
		- Preferenze stampa > [orientamento carta? di solito orizz]
- Cardpresso > File > Print settaggi > imposta Evolis Primacy come stampante
- Cardpresso > Nuovo
	- Nuova immagine
	- Campo di testo > doppio click per inserire testo manualmente

Codificatori
-------------------------------
Un "codificatore" � uno strumento di scrittura/lettura su carta, a seconda del protocollo usato dalla carta stessa per comunicare. Lo standard di comunicazione tra lettore e carta - che prescinde dal protocollo della carta - � attualmente il PC/SC, del quale bisogna installare i driver per essere sicuri di poter comunicare con la carta.
I lettori che supportano lo standard PC/SC vengono identificati come "Lettori Smart Card" nella Gestione Dispositivi. Altri lettori, che per esempio si interfacciano con la porta seriale COMx, dipendono dal conoscere o meno il protocollo di comunicazione.
La maggior parte dei codificatori PC/SC sul mercato � disponibile su CardPresso, ma il loro utilizzo varia a seconda della carta che va supportata (Mifare Classic e Desfire, 44/42, 125 kHz)

	Tipi di coupler integrati con la stampante:
	ACR122U (Mifare) - 'Saponetta bianca' NFC
	OMNIKEY 5121 (Mifare) - 'Saponetta sporca' 
	ERMES 125 (125kHz) - 
	TWN4 (125kHz) - Ha un cavo solo, stampante e coupler confluiscono nella stessa uscita USB (che fa anche da alimentazione)
	
	(*) Errore inizializzazione encoder
	Verificare che la stampante sia online e non in standby!
	Sintomo: Errore "Inizializzazione Encoder" durante la stampa
		Barra di navigazione > Anteprima Codifica > la voce "Codificatori Contactless" deve contenere il nome del dispositivo encoder, lo stesso che apparirebbe in Gestione Dispositivi sotto "Lettori smartcard"
			es. OMNIKEY CardMan 5x21-CL
		Se non appare significa che il programma non riesce a vedere il dispositivo. Provare a:
			- cliccare su Aggiorna vicino a "Codificatori contactless"
			- Chiudere e riaprire la maschera Cardpresso

***Atensi�n!!! Installare due lettori con lo stesso driver (es. ACR122U da tavolo pi� lettore OMNIKEY 5121 integrato nella stampante) potrebbe creare problemi di comunicazione, per esempio la stampante che si aspetta in lettura il badge sul lettore da tavolo. La configurazione richiederebbe che si scegliesse il lettore da utilizzare, quindi meglio mantenere la stessa struttura per tutte le postazioni (ACR122U da tavolo + OMNIKEY 5121 nella stampante).


Leggere l'UID di una carta Mifare
-------------------------------
- File > Nuovo 
- Nota le schede: "Codifica modello", "Codifica script", "Procedure guidate"
- In "Codifica modello", sel. "Contactless" > sel. modello card (es. "Mifare", oppure "Generic" per 125kHz)
- Barra opzioni orizzontale in alto: Anteprima fronte, Anteprima retro, ---, Anteprima codifica
- Sel. "Read Contactless CardUID..." > scegli come vedere il numero di serie (hex,int e asc/desc) > click "Finish"
- Viene creato uno script con una serie di comandi: selezionare dal menu a tendina il codificatore contactless che si vuole utilizzare per la lettura (es. "ACR122U")
- Per eseguire lo script, premere sul pulsante Play in basso a destra
- Nella finestra di 'uscita' si ha l'output dello script, per controllare se lo script funziona (anche senza stampante)
- Questo script salva dentro la variabile UID il tag letto: da qui � possibile agganciare a tale variabile qualsiasi funzione (le applicazioni possibili sono sotto la scheda "Procedura guidata"), per esempio scriverlo in un campo di un database

Es. di script per il salvataggio della variabile nella vista logica del DB MRT

	CurrentRecord['MIFARE'] = "0000000000" + tag.uid.read().reversed().toHex();
	currentRecord.save

(*) "CurrentRecord" � il campo corrente di database

(*) Visualizzazione "Fisarmonica" > Script > Sel. evento (es. "Prima della stampa") > Inserisci script che verr� eseguito a seconda dell'opzione

(*) � possibile modificare lo script per qualsiasi tipo di personalizzazione delle "Procedure guidate" preesistenti

(*) Per eseguire un programma esterno (pu� essere utile nel caso in cui si volesse eseguire un'applicazione per la lettura dei 125 kHz), 

	exec("<percorso completo file>","<portaCOM>","R");

(*) WARNING: ricordarsi che, in codifica della carta, bisogna mandare direttamente alla stampante, aggirando lo spool di stampa



# SOSTITUZIONE TERMINALE
======================================================================
(Alcatel)

Un terminale (es. MCT353) � rotto e va sostituito, preservando la configurazione GNET e su MicronConfig. Il nuovo terminale, quindi deve prendere lo stesso indirizzo IP del vecchio.

- Collegare il pc locale o il server (a seconda di dove sia installato GnConfig, da cui poi si mander� la configurazione) al terminale tramite cavo ethernet
- Assegnare al pc locale un indirizzo IP statico, della stessa classe dell'indirizzo IP nuovo da assegnare al terminale (NON � necessario collegarvisi prima con l'indirizzo vecchio, perch� il GNConfig si aggancia innanzitutto al MAC Address)
- Su GNConfig, assegnare il nuovo MAC Address al nodo GNET > NINIT + IP > Doppio Click sul nodo
- Verificare da terminale (es. F1-F2-F1-F2-F1-RED + F7) che l'indirizzo IP assegnato al terminale sia quello nuovo
- Reinviare la configurazione facendo Sel.Tutto > Doppio Click sul nodo e attendere che la configurazione sia inviata completamente
- A questo punto, scollegare l'hw vecchio e attaccare l'hw nuovo: per il sistema, equivarrebbe ad aver rimosso e reinserito il cavo di rete





# MICRONTRANSLATE
======================================================================

Per accedere all'applicativo di traduzione, usare l'indirizzo BiTech:

	79.11.21.211/microntranslate

Accedere con le credenziali di Daniele:

	carnevale
	micron2013.


AGGIUNGERE CHIAVI
-------------------------------
- Avanzate > Sostituzione Chiavi > cercare la chiave (cio�, la funzione sugli applicativi) in ITALIANO
- Appare la tabella delle traduzioni nelle diverse lingue. Modificare il campo voluto e cliccare su Sostituisci.
- Alla fine della traduzione, andare su Avanzate > Creazione File Risorse. Questo crea un pacchetto contenente le modifiche applicate, da salvare poi nella cartella di MicronWeb o dell'applicativo che si vuole modificare.

SCARICARE MDB VOCI TRADOTTE
-------------------------------
- Traduzioni > Traduzioni Off-line
- Modulo MRT - lingua > Cercare il modulo corrispondente alla lingua, vengono visualizzate le voci mancanti rispetto a tutte quelle presenti
- Mettera la spunta su "DOWNLOAD COMPLETO" (altrimenti scarica solo le voci mancanti)
- Click su DOWNLOAD MDB
- Scegliere lingua di supporto (di solito ENG)



# GNET
======================================================================

## LOG DI DEBUG TERMINALI

### BINARIO-DECIMALE

	0000 0000	Byte (nibble high + nibble low)
	[bit3 bit2 bit1 bit0]

	Nibble:
	0000 = 0
	0001 = 1	= bit0
	0010 = 2	= bit1
	0011 = 3	= bit0,bit1
	0100 = 4	= bit2
	0101 = 5	= bit0,bit2
	0110 = 6	= bit1,bit2
	0111 = 7	= bit0,bit1,bit2
	1000 = 8	= bit3
	1001 = 9	= bit0,bit3
	1010 = 10	= bit1,bit3
	1011 = 11	= bit0,bit1,bit3
	1100 = 12	= bit2,bit3
	1101 = 13	= bit0,bit2,bit3
	1110 = 14	= bit1,bit2,bit3
	1111 = 2^3 + 2^2 + 2^1 + 2^0 = 15

	Come si legge il formato BIN:
	es. 27
		Nibble high = 2 = 0010 = bit1
		Nibble low = 7 = 0111 = bit0, bit1, bit2

### COMANDI DI AZZERAMENTO MEMORIE
	"Risposta a crypto key", 
	"Crypto key", 
	"Richiesta Setup accessi", 
	"Risposta a richiesta setup accessi", 
	"Invio Configurazione terminale", 
	"Invio configurazione out", 
	"Invio Configurazione In", 
	"Invio tabella festivit�", 
	"Invio tabella fasce orarie", 
	"Invio tabella abilitazioni", 
	"Invio tabella passback", 
	"Invio tabella calendari", 
	"Invio tabella causali", 
	"Invio tabella schedulazioni", 
	"N.Messaggi dati", 
	"Monitor Testine", 
	"Risposta a Monitor testine".


### CRITTOGRAFIA GNET
	
	OPCODES COMANDI BASE
	I comandi dei terminali base sono intesi per tutti i terminali base, siano essi presenze, accessi o produzione
	Documentazione di riferimento: MT_MRT_GNet_base_vXXX (XXX � la versione, che si pu� leggere al paragrafo "Compatibilit� firmware con tracciati GNet/MicronService" del documento "MT_MRT_Versioni_fw_TBase.doc")

		001 PCON (Pacchetto di controllo) - La centralina ha recepito il fatto che il servizio si sia riavviato
		002 PCOFF (Pacchetto di controllo)
		003 Reboot terminale (Pacchetto di controllo)
		004 Data/Ora (Pacchetto di controllo)
		005 Richiesta versione FW (Pacchetto di controllo)
		006 Richiesta pacchetti persi (Pacchetto di controllo)
		007 Errore firmware (Pacchetto di controllo)
			40E6ETXGNET
			40E34VISUAL 	Soluzione: premi RESET sull'MXP per circa 20 secondi, anche a servizio aperto
			40E37VISUAL	Soluzione: premi RESET sull'MXP per circa 20 secondi, anche a servizio aperto	
			4171F4MAIN	
		008 Fuori servizio istantaneo (Pacchetto di controllo)
		009 Azzeramento memorie terminale (Pacchetto di controllo)
		010 Richiesta setup crypto (Pacchetto di controllo)
		011 Reboot terminale con download (Pacchetto di controllo)
		012 Controllo pacchetti ricevuti con "gnsndinf"
	
	� OPCODES PER GLI ACCESSI 
	Comandi richiesti per i terminali di controllo accessi, nella fattispecie Terminali base con gestione KK
	Documentazione di riferimento: MT_MRT_GNet_acc_vXXX (XXX � la versione, che si pu� leggere al paragrafo "COMPATIBILIT� FIRMWARE CON TRACCIATI GNET/MICRONSERVICE" del documento "MT_MRT_Versioni_fw_TBaseTkk.doc")

		030 Richiesta Setup (Pacchetto setup)
		031 Setup terminali accessi (Pacchetto setup)
		032 Configurazione Out (Pacchetto setup)
		033 Setup allarmi (Pacchetto setup)
		034 Invio Tabella causali (Tabelle causali)
		035 Invio tabella comandi schedulati (Tabella comandi schedulati)
		036 Invio tabella template biometrico (Tabella template biometrico)
		060 Invio Tabella festivit� (Tabella gestione abilitazioni)
		061 Invio Tabella abilitazioni (Tabella gestione abilitazioni)
			(*) Se vengono inviati molti 061, il varco sta in stato di aggiornamento massivo e non apre ai badge autorizzati, quindi occhio a riavviare i btService senza aver fermato il Micronpass Web
		063 Invio Tabella Fasce orarie (Tabella gestione abilitazioni)
		064 Query abilitazione (Query abilitazione)
		065 Invio Tabella calendari (Tabella gestione abilitazioni)
		066 Query tag attivo (Query abilitazione)
		070 Invio tabella presenti (Tabelle gestione antipassback)
		071 Sostituzione badge tabella passback (Tabelle gestione antipassback)
		072 Gestione transito (Query antipassback)
		073 Reload presenti (Query antipassback)
		080 Comando Out (Gestione comandi I/O)
		081 Reset allarme (Gestione comandi I/O)
		082 Invio Tabella abilitazioni (Gestione abilitazioni)
		090 Richiesta timbratura da host (Timbratura da host)
		120 Timbratura
			11-03-2016 		Data
			11:20:39:078 		Ora
			OK       		Stato
			POL(rx) 		
			BTAX133I 		Versione firmware
			00199 			Ramo Nodo
			BT__TXPC 		Funzione
			f 120 			Opcode
			s 004 			Bit0...3 = Indirizzo KK (Bit0 = terminale base)
			b 057 			Controllo ripetizione
			c 120 			Check Opcode
			~
			16 03 11 		Data
			11 20 34 		Ora
			30 30 30 30 30 30 30 30 30 30 30 30 39 42 33 37 38 31 42 33  IDx Badge (ASCII)
			1			Direzione (bit0 = entra; bit1 = esce)
			2			Tipo tessera 
			00 			Flag responso (0h = Accettato; bit0 = Verso errato; bit1 = Fuori orario; bit2 = inesistente; bit4 = Passback presente; bit5 = Passback uscito; bit6 = Passback pieno)
			01 			Tipo timbratura (bit0 = accesso; bit1 = presenza; bit2 = mensa; bit3 = distributore; bit4 = eccezionale; bit5 = sorteggiatore; bit6 = flash)
			00 			Out di varco (bit1 = comando eseguito; bit0 = comando 1 di varco ... bit7 = comando 8 di varco)
			00 			Status (0 = default; <>0 = da segnalare)
			20 20 20 20		Codice causale 
			20 20 20 20 20 20 20 20 20 20 	Codice targa
		121 Transito passback (Transazioni ad host)
		122 Segnalazione allarme (Transazioni ad host)
			11-03-2016 		Data
			11:20:30:078 		Ora
			OK       		Stato
			POL(rx) 		
			BTAX133I 		Versione firmware
			00199 			Ramo Nodo
			BT__TXPC 		Funzione
			f 122 			Opcode
			s 001 			Blocco (bit1..3 = Indirizzo Multi I/O; bit0 = I/O Base)
			b 055 			Controllo ripetizione
			c 122 			Check opcode
			16 03 11 		Data	
			11 20 24 		Ora
			07 			Numero allarme (n� dell'ingresso)
			01 			Stato (0 = allarme cessato; 1 = allarme attivato; 2 = manomissione)
		124 Monitor testine
			11-03-2016 		Data
			09:01:26:952 		Ora
			OK       		Stato
			POL(rx) 		
			BTAX133I		Versione firmware 
			00199 			Ramo Nodo
			BT__TXPC 		Funzione
			f 124 			Opcode
			s 000 			Blocco
			b 047 			Controllo ripetizione
			c 124 			Check opcode
			16 03 11 		Data
			08 51 07 		Ora
			00 			Testina base (0 = online; 1 = offline)
			00 			Testina KK n.1 (0 = online; 1 = offline)
			00 			Testina KK n.2 (0 = online; 1 = offline)
			00 			Testina KK n.3 (0 = online; 1 = offline)
			00 			Testina KK n.4 (0 = online; 1 = offline)
			00 			Testina KK n.5 (0 = online; 1 = offline)
			00 			Testina KK n.6 (0 = online; 1 = offline)
			00 			Testina KK n.7 (0 = online; 1 = offline)
			00 			Testina KK n.8 (0 = online; 1 = offline)

### ERRORI

	E(00104) = Errore di comunicazione GNet, aumentare il Ping Retry su GNConfig e ripuntare le nuove Tabelle Host, eventualmente attivare il MicronLeak
	E(00108) = Errore di timeout, niente di grave, rimanderà il record più avanti
	E(00109) = Errore firmware


## MICRONLEAK

GESTIONE BASE
Il processo pi� semplice con cui monitorare la comunicazione GNet si basa sull'utilizzo del log GNTrace.

	- Arrestare il servizio btServiceXX
	- GNConfigXX > [creare file vuoto gntrace.flg]
	- Riavviare il servizio btServiceXX
	- Nella cartella GNConfigXX appare il file GNTrace.log
		Il log GNTrace scrive in chiaro ci� che sta facendo la libgn32.dll: da qui � possibile capire quali siano le cause del problema di comunicazione

	Esempio di sintomi per cui serve aumentare il Ping Retry per un nodo in particolare:
		03/05/17  11:36:38,660 01> GNPing> Lookup destination...10.111.0.43
		03/05/17  11:36:38,660 01> GNPing> ICMP Ping Retry timeout 1 of 2
		03/05/17  11:36:39,316 01> GNPing> Ping timeout !!
		03/05/17  11:36:39,316 01> GNPing> ICMP Ping Retry timeout 2 of 2
		03/05/17  11:36:39,316 01> GNPing> Ping timeout !!

	NB:
	Una volta capito e risolto il problema, conviene disattivare la flag gntrace.flg prima che il GNTrace.log esploda come dimensioni



# TELEPASS: NEDAP
======================================================================

NEDAP (NEDerlandsche APparatenfabriek) 
----------------------------------------------------------------------
The company focuses on developing and supplying solutions in the fields of security (identification of persons, animals and goods) and electronic control units through NFC.

- Compact tag (2.45 GHz)
Dimensioni di una carta di credito, identificazione fino a 7 metri, leggibilit� dual-side.
Si comporta a tutti gli effetti come un badge, ma � leggibile solo dalle antenne Nedap perch� lavora alla frequenza di 2.45 GHz. Siccome di default lavorano con tecnologia full tag, il codice stampato a fronte coincide con il tag da inserire nel campo 'full tag' su Micronpass.

WINDOW BUTTON
The Window Button is a long range single ID vehicle tag used for vehicle identification and access applications. This tag is designed to complement the interior of a passenger vehicle. 
The Window Button is identified up to 10 meters [33 feet] by the "TRANSIT Ultimate" and "TRANSIT Standard" reader as soon as it enters the reading zone. 
The "TRANSIT Entry" identifies the Window Button at distances up to 4 meters [12 feet].




ANTENNA NEDAP UPASS
----------------------------------------------------------------------
Dispositivi di lettura: 
	Strisce adesive UHF (codice tag passivo UHF)
	Tesserina Combi card UHF (codice tag passivo UHF)

� CONFIGURAZIONE HARDWARE

- L'MXP250 deve avere a bordo gli schedini locbus moduli M309 per gestire la seriale 232 e 1 modulo per gestire il lettore uPass
- Seguire lo schema di collegamento MXP250-UPASS, la distanza massima tra i lettori e la centralina non deve superare i 15 m
- Settaggio dipswitch sull'uPass:
	Jumper SW1: pin 1 a Off
	Jumper SW3: pin 3 a Off


� CONFIGURAZIONE GNET

MicronConfig > [Struttura]:
Creare un varco per ciascun carraio

MicronConfig > Tabelle > Tecnologia Testine: 
4 � NEDAP Entra (T2), SEDE,40,0,0,0,0,1,20,TagFull
5 � NEDAP Esce (T2), SEDE,40,0,0,0,0,1,20,TagFull

MicronConfig > Varco NEDAP ingresso > Terminale base > Configurazione Testine:
- Device 1: 4-NEDAP ENTRA (T2)
- Testina 2 > Solo accessi > Entra > Out

MicronConfig > Varco NEDAP uscita > Terminale base > Configurazione testine:
- Device 1: 5-NEDAP ESCE (T2)
- Testina 2 > Solo accessi > Esce > Out

Inviare configurazione con il NoService e successivamente eseguire un test di lettura passando davanti al lettore uPass la striscia UHF.

$ CONFIGURAZIONE KARM
Prerequisiti firmware: karpos >= 1.2.5 (non disponibile su kDisplay puro)

Configurazione RS232: 9600,8,N,1

MicronConfig > Tabelle > Tecnologie Testine:
26-RS232 Nedap1 ARM Entry,SEDE,20,0,0000,0,0,1,20,Tagfull(*)	% Canale default: ttys2
27-RS232 Nedap2 ARM Exit,SEDE,20,0,0000,0,0,1,20,Tagfull(*)	% Canale default: ttys3
28-RS232 Nedap3 ARM Exit,SEDE,20,0,0000,0,0,1,20,Tagfull(*)	% Canale default: ttys1
	
	(*)TagFull o Radiocomando, a seconda di che cosa si vuole scaricare: il parametro NEDAPTECHRADIO serve solo per i Combi Booster, v.documentazione karpos

MicronConfig > Tabelle > [Terminale base] > Parametri extra:
	USER, EXTREADER*, NEDAPFILTER=[valore in secondi]	% Forza il tempo di filtro sui transiti NEDAP

	(*) EXTREADER* significa:
		EXTREADER1 se riferito a testina 26-RS232 NEDAP1 ARM ENTRY
		EXTREADER2 se riferito a testina 27-RS232 NEDAP2 ARM EXIT
		EXTREADER3 se riferito a testina 28-RS232 NEDAP3 ARM EXIT


� MICRONPASS WEB

- [Cat.anagrafica] > [Anagrafica] > Nuovo badge da assegnare
- Nuovo badge > Codice identificativo badge > [inserire numero desiderato]
- Nuovo badge > [tecnologia scelta] > [inserire il numero stampato sulla striscia UHF]
- Abilitare il dipendente proprietario del badge al varco Nedap


	(*) PERSONALIZZAZIONE PER SCARICARE TIMBRATURA DEL BADGE TITOLARE

	Conditio sine qua non: il giusto firmware! v. per esempio, in documentazione firmware, la versione 2.4E/3:
	
		Implementazione 1) Transazioni Nedap con tecnologia Radiocomando
		Per far fronte ad una urgenza di "Italiana Assicurazioni", in questa versione � reso possibile definire la tecnologia "Banda Magnetica" e "Radiocomando" per il tipo testina 4 e 5, NEDAP.
		In questo modo � possibile assegnare badge aventi inTag Full il codice della tessera e Radiocomando il codice del NEDAP, al fine di identificare gli utenti con la sola transazione del veicolo.

	- MicronConfig > Tabelle > Tecnologia Testine > 4-NEDAP ENTRA > Tecnologia Tessera: Radiocomando
	- MicronConfig > Tabelle > Tecnologia Testine > 5-NEDAP ESCE > Tecnologia Tessera: Radiocomando
	- MicronConfig > Varco > Terminale > Configurazione testine > Device 3 > 2-Radiocomando(T2)
	- Micronpass Web > badge dipendente > Campo Radiocomando > inserire il codice Compact Tag

	In questo modo, quando viene passato il Compact Tag sotto le antenne Nedap, il servizio scarica l'ID (o IDX, a seconda dello scarico) del badge titolare


WINDOWS BUTTON
----------------------------------------------------------------------
Ovviamente sul terminale MXP deve essere presente lo schedino per gestire la seriale 232 (M309).
Sull'antenna Transit, per abilitare il colloquio con l'MXP, bisogna settare i DIP Switch nel seguente modo: ON, ON, OFF, ON, ON, OFF, ON, ON
Configurazione di un Window Button:
- MicronConfig > Tabelle > Tecnologie testine: 4-NEDAP ENTRA, Sede, 40,0,0,0,0,1,20,TagFull
- MicronConfig > Tabelle > Tecnologie Testine: 5-NEDAP ESCE, Sede, 40,0,0,0,0,1,20, TagFull
In caso di un solo lettore transit, per una singola timbratura di ingresso:
- MicronConfig > Terminale Standard > Configurazione testine > Device 1 = 4-NEDAP ENTRA (T2)
- MicronConfig > Terminale Standard > Configurazione testine > Testina 2 > Tipo timbratura: Solo accessi
- MicronConfig > Terminale Standard > Configurazione testine > Testina 2 > Entra (definire OUT)
- Micronpass Web > [Creare anagrafica fittizia e badge fittizio, scrivere il codice del Window Button nel campo TAG RF FULL]





# MENSA
======================================================================
Documentazione: MO_MRT_MENSA.docx

Il terminale per la gestione della mensa � un PANEL PC TOUCH SCREEN che consente di eseguire la selezione del pasto, la registrazione e l'emissione dello scontrino relativo ad una consumazione.
Di fatto, il Panel PC opera come un terminale del sistema MRT: legge le tabelle anagrafiche dal database e in cambio invia le transazioni eseguite.
Le operazioni che sono svolte dall�utente sono le seguenti:
- Riconoscimento attraverso la lettura del badge. Il badge � sottoposto ai controlli di autorizzazione allo stesso modo degli altri terminali di accesso del sistema. In caso di mancato riconoscimento non sar� possibile accedere alla schermata principale.
- Selezione della consumazione e conferma finale.
A questo punto il programma produce uno scontrino non fiscale e una registrazione nel sistema MRT.
Quando il collegamento con il server MRT � attivo (normalmente � cos�, si tratta di una connessione di rete LAN) un processo automatico aggiorna periodicamente le tabelle di ingresso del sistema: anagrafiche persone, badge, whitelist, causali e invia le transazioni effettuate al sistema. 



CONTATORI TERMINALE DI MENSA
Entrambi i contatori (parziale/totale) si azzerano al raggiungimento del valore 100000
- Micronconfig > Terminale base > Par. base > Cancellazione APB alle 00:00	% Azzeramento dei totali a mezzanotte
- Micronconfif > GPParam > GPParam37 = 16	% Visualizzazione dei totali a display


CONFIGURAZIONE
----------------------------------------------------------------------

� PANEL PC
Il Panel PC arriva completo di cavo di alimentazione e cd di Windows, con tanto di codice attivazione.
I panel pc sono a tutti gli effetti dei computer con sistema operativo Windows, devono quindi essere applicate le stesse regole di manutenzione applicate alle workstation aziendali.
� buona prassi quindi provvedere ad applicare le patch di aggiornamento rilasciate da Microsoft.
Preparazione del Panel PC (in ufficio):
	- Mettere in rete il panel pc
	- Start > Ricerca: "Attiva Windows"
	- Seguire le istruzioni e inserire il Product Key per attivare il sistema operativo
	- Pannello di Controllo > Windows Updater > Controlla Aggiornamenti
	- Disattiva Firewall e Windows Defender
	- Opzioni risparmio energetico > Prestazioni elevate


� MICRONCONFIG

GnConfig:
	- Configurare un nodo nuovo (dare un codice nodo GNET riconoscibile), senza parametri di rete, ma solo creando le tabelle di host

MicronConfig:
	- Configurare su MicronConfig un terminale base e un terminale KK, selezionando in "Configurazione testine" la voce Mensa


� MENSA.EXE

(*) Attivazione del Check White List

	Su file mensa.exe.config
	<!-- Abilitazione controllo whitelist (0,1,2) -->
	<add key="EnableWhiteListCheck" value="2" />
		0=solo controllo congruenza traccia con parametri T54, 
		1=solo controllo esistenza badge T25, 
		2=controllo white list.



� CAUSALI SU MICRONPASS WEB

Definizione dei pasti:
	- Causali e consumazioni > Gestione mensa > [selezionare varco mensa] > Aggiungi pasto
	- Inserire un codice pasto (e.g. "0015") e una descrizione (e.g. "Formaggio")
	- Spuntare "Extra" per indicare se il pasto sar� classificato come extra o no
	- Selezionare se la causale � di costo "principale" o "alternativo"

Definizione dei costi:
	- Gestione Mensa > Tabella Causali di Costo > Aggiungi causale di costo 
	- Inserire un codice (e.g. "0014"), una descrizione e un costo


� PRIMO USO DI MENSA.EXE

Associazione azienda/causali:
	- Gestione causali (pwd: OK) > [seleziona azienda interna] > spunta su "Abil." > Causali > spunta sui pasti da associare
	- Conferma e ripeti per ogni azienda interna

� USI SUCCESSIVI DI MENSA.EXE




	
* Esiste una sincronizzazione del database MRT e degli eventi del panel pc ogni dieci minuti; � possibile forzarla tramite pulsante "SyncroDB" nella homepage (pwd: OK)
* Per chiudere mensa.exe: pulsante Esci > Chiudi (pwd: CIAO)
* Per spegnere PC: pulsante Esci > Spegni (pwd: CIAO)


(*) ERRORE CARATTERE NON UTILIZZABILE IN UN NOME

	app.log
	14-03-2018 09:43:21:846 *** START PROGRAM *** Platform:x64
	14-03-2018 09:43:23:271 Il carattere '.', valore esadecimale 0x00, non pu� essere utilizzato in un nome. Riga 68088, posizione 10. Module Mensa.exe global.StartApplication at offset 733 in file  line 0 column 0
	14-03-2018 09:43:23:386 Form Load
	14-03-2018 09:43:45:516 Form Closed

- Verificare i file .xml: � possibile che pi� d'un file sia corrotto
- Chiudere l'applicativo (la password di chiusura � scritta in chiaro nel file MENSA\mensa.exe.config)
- Copiare tutti i file .xml in un .zip (tipo "old_xml")
- Rimuovere tutti i file da cartella MENSA
- Rilanciare l'applicativo: a connessione riuscita, mensa.exe si scarica ci� che serve dal database e lo salva localmente ricreando i nuovi file XML



# MICRONPASS WIN E WINATT
======================================================================

FUNZIONAMENTO DI BASE
--------------------------------------------

PARAMETRI > IMPIANTI TERMINALI (configurazione impianto)
Si vede l'impianto (di solito uno). Con un doppio click, si vedono le propriet�:
	- File di Selecting: mostra il percorso del file select.M51
	- File di Input: mostra il percorso di import dei transiti
	- File di backup
	- File anomalie: file degli errori nel caso in cui ci fossero dei badge non riconosciuti nei transiti
	- Formato tracciato per il transito
	> TERMINALI
		Mostra l'elenco dei terminali appartenenti all'impianto
	> TERMINALI > TERMINALE XXXXX
		Notare il Codice (es. 012) che identifica univocamente il terminale nell'impianto e l'indirizzo logico (es. Presenze#00199) che lo identifica nella WinAtt


PARAMETRI > VARCHI CONTROLLO ACCESSI (Gestione abilitazione)
	Mostra i gruppi di varchi
	> TERMINALI
		Per avere la lista dei terminali che appartengono a un gruppo di varchi
	> FASCE ORARIE
		Per avere la lista delle fasce orarie associate al gruppo di varchi


PARAMETRI > FASCE ORARIE (fasce orarie)
Mostra le fasce orarie salvate a sistema. Per ogni nuova fascia oraria, ci possono essere al massimo 4 sottofasce.


PARAMETRI > AMMINISTRAZIONE UTENTI (Gestione utenti/organigramma)
Fare attenzione che il varco / gruppo di varchi sia associato all'utente tramite il comando VARCHI ASSOCIATI


ANAGRAFICA > DIPENDENTI (Gestione dipendenti)
Cod.Azienda: doppio click per poter scegliere il codice azienda tra quelli esistenti
Matricola: doppio click per poter scegliere la matricola tra quelli esistenti nell'azienda interna selezionata
	> ALTRE INFORMAZIONI:
		Assegnazione badge: per gestire l'assegnazione con il badge, e settarne il periodo di validit�
		Accessi: per l'associazione dei varchi/gruppi di varchi all'anagrafica


GENERARE LA SELECT
-----------------------------------------
1) Strumenti > GENERA LISTA PERSONALE ABILITATO
	- Si pu� filtrare la singola matricola cui apportare le modifiche

	KTACCESS01	Flag di inserimento
	KTACCESS02	Inserimento badge
	KTACCESS03	Pulire abilitazioni del singolo dipendente
	KTACCESS04	Fasce orarie
	KTACCESS06	Pulire abilitazioni di tutti

	- Flag "Non sovrascrivere(...)": appende la nuova Select al fondo di quella esistente
	- Dare Ok per generare il file di Select

2) WinAtt (per l'invio delle abilitazioni)

	- Azioni > Invio Select
	- I pacchetti inviati devono essere uguali a quelli ricevuti!
	- Alla fine dell'invio, conferma sempre per la rinomina del file di Select

3) TR1.EXE (per l'import transiti)

	- Import Transiti: scarica file coi transiti prendendolo dai terminali


MIGRAZIONE DA MICRONPASS WIN A MICRONPASS WEB
-----------------------------------------

1) Verificare il Link ODBC:
	- C:\MicronPass\mpass.ini
	- Alla voce [database], leggere name = <nome del link ODBC>

2) Cercare il database
	- Pannello di Amministrazione > Origini dati (32 bit) ODBC
	- C:\windows\syswow63\odbcad32.exe
	- "DNS Utente" o "DNS di sistema"
	- Selezionare "<nome>"(32bit)
	- Alla voce Database c'� il percorso del file database

3) Aprire il database
	- Aprire il database con MS Access

4) Creare una vista logica
	- Tabella DIPEN: selezionare "Matricola","Azienda","Nome","Cognome"
	- Tabella DIPEN_BADGE: selezionare "Matricola","Azienda","Inizio"
	- Crea > Struttura Query > Aggiungi DIPEN, DIPEN_BADGE, DIPEN_VARCHI > Aggiungi
	- Linkare Matricola di DIPEN con Matricola di DIPEN_BADGE e Matricola di DIPEN_VARCHI
	- LInkare Azienda di DIPEN con Azienda di DIPEN_BADGE e Azienda di DIPEN_VARCHI
	- Struttura vista logica: Campo: Matricola	Cognome		Nome	Badge		Fine		Varco*		
				Tabella: Dipen		Dipen		Dipen	Dipen_badge	Dipen_badge	Dipen_varchi*	 
				Criteri: -		-		-	-		is null		-
		*=Facoltativo a seconda del fatto che si voglia esportare le abilitazioni oppure no
	- Esportare i risultati della vista logica in un file di testo da editare con TextPad

5) Ovviamente, a meno di non stare esportando anche le abilitazioni, tutte le abilitazioni di gruppo devono essere pronte prima della riconfigurazione dei terminali!

	(*) WARNING: se non si potesse aprire il database con Access
	- Micronpass Win > Stampe > Anagrafiche > Stampa dipendenti > Definisci...
	- Definizione: <descrizione> > Salva
	- Azienda / Cognome e nome / badge > Salva
	- Spunta + spunta
	- Stampare adesso ? NO


ALCUNE ASSISTENZE
-----------------------------------------

(*) BADGE ABILITATI CONTINUANO A NON APRIRE (PROBLEMA DI MEMORIA ABILITAZIONI)
Pu� capitare, soprattutto se il terminale di controllo accessi ha  una centralina molto vecchia (e.g. M137) con la tabella abilitazioni piena (disponibilit� massimo 400 badge) mentre la lista da elaborare � di 414 badge.
Suggerimenti:
	1. Fare un report dei badge assegnati da Micronpass Win � possibile evidenziare quali matricole disabilitare per liberare spazio in memoria
	2. Effettuare la cancellazione delle matricole direttamente da anagrafiche dipendenti
	3. Spedire un KTACCESS06 (cancellazione di tutte le abilitazioni) per tutte le centraline controllate dal Micronpass
	4. Elaborare e rispedire il select "Generazione lista personale abilitato"




# FUNZIONE PINCODE SU TIMBRATURA
======================================================================
"Pincode su timbratura" significa la possibilit� di inserire un PIN (visibile da applicativo) per confermare la timbratura con badge.

ATTIVAZIONE DELLA FUNZIONE (LEGATO ALLA MATRICOLA)
----------------------------------------------
- Firmware: 
	Dalla versione 3.3 circa
- Su MicronConfig:
	Lettore KK:
		Parametri Base > Tipo Funzionamento > PIN su Timbratura
		GPParam43 = 5 (Numero di caratteri del PIN) 	---> Modalit� pincode legato alla matricola
	Tabelle > Parametri Generali (Flags) > Gestione Pincode:
		Modalit� pincode: [a seconda dell'uso che se ne vuole fare, decide a che cosa verr� legato il Pincode in timbratura] 
			IDXBadge			attiva la sola modalit� vecchia (pincode fisso elaborato a seconda della traccia badge)
			Matricola			attiva la sola modalit� nuova (pincode generato da Micronpass WEB)
			Mista				entrambe le modalit� attive. I terminali con firmware �vecchio� (precedente alla 3.0) potranno utilizzare il pincode �fisso�, gli altri quello generato da Micronpass WEB
		Visibilit� Pincode: [da definire col cliente]
			Nessuna visualizzazione 	i pincode non verranno mai visualizzati (stringa fissa *****)
			Solo utente attuale		viene visualizzato in chiaro solamente il pincode del dipendente legato all�utente attualmente loggato (questo consente per le realt� dove tutti i dipendenti sono utenti Micronpass di vedere direttamente il proprio pincode).
			Solo dipendenti			vengono mostrati i pincode di tutti i dipendenti
			Solo esterni			vengono mostrati i pincode di tutti i collaboratori esterni
			Tutti				vengono mostrati tutti i pincode
		Modalit� notifica Pincode: [da definire col cliente: � imprescindibile la presenza di MicronMail]
			Nessuna notifica		non avverr� alcuna notifica
			Email				il cambio e l�azzeramento del pincode verranno notificati via email
			SMS				il cambio e l�azzeramento del pincode verranno notificati via SMS (opzione futura)
			Email e SMS			entrambe le notifiche.
		Lunghezza Pincode: [da definire col cliente]
			Il PIN viene generato utilizzando la dimensione specificata con questo parametro.

- Su MicronPass Web > Maschera dettaglio dipendente > Comandi > Genera pincode
	Appare la voce Pincode nei dettagli del dipendente

- Uso sul lettore: 
	- Passo il badge (ovviamente devo essere abilitato)
	- Inserisco pincode e premo OK

	(*) Qualsiasi out di varco legato a questa funzione (es. personalizzazioni di gestione antiintrusione come Prisma o Revimac) va eseguito PRIMA della timbratura - ad esempio, l'inserimento del tasto 1 attiva la funzione di "gestione antiintrusione" (interlocuzione tra le centraline) e disattiva i comandi interni del lettore.

	*** ATTENZIONE: per terminali ARM la lunghezza del pincode � fissa a 5 da firmware, *NON* va quindi a leggere il parametro generale COMF/PINLEN

PINCODE ELABORATO DAL TERMINALE (LEGATO A IDX)
-------------------------------------------------
Esiste una seconda modalit� di utilizzo del pincode su timbratura, inserita dalla versione firmware GNet 2.0c e attualmente in dismissione (*non* � presente su KARM).
In questo caso, il pincode viene generato autonomamente dal terminale e legato all'IDX. 

Prerequisiti per questa funzione:
- Firmware GNet > 2.0c
- Modo funzionamento = Pincode su timbratura
- GPParam43=0 (se >0, rappresenta il numero di caratteri del pincode e si sottintende che sia il pincode generato per anagrafica)

In pratica:
	1) L'utente passa il badge sul lettore
	2) Il lettore legge l'IDX e ne calcola il pincode corrispondente
	3) Il lettore si mette in attesa del pincode in input da parte dell'utente
	4) Se il pincode inserito corrisponde a quello calcolato internamente, viene autorizzato l'accesso
Questo tipo di pincode NON � modificabile ed � univocamente legato all'IDX del badge, ergo:
	a. se cambi badge, cambia il pincode
	b. se vuoi cambiare il pincode, devi cambiare badge

Per visualizzare il pincode in questione:
	- MicronConfig > Tabelle > Parametri Generali > Pincode management > Modalit� pincode = 0-IDX Badge (riavviare IIS)
	- Micronpass Web > Badge & Chiavi > Gestione badge > [cerca badge] > [hover su etichetta 'Tag RF Full' (se quello � l'IDX attivo) per visualizzare un popup con il pincode relativo a quell'IDX]

Ripeto che questo tipo di gestione � stato DISMESSO e NON � stato incluso nel porting su KARM... Per impianti con terminali esclusivamente GNet si pu� ancora usare.




EXPORT_PINCODE
----------------------------------------------
Questa funzionalit� NON � standard e va gestita con cautela. Avere un'unica lista con tutti i pincode � chiaramente una vulnerabilit� nella sicurezza dell'impianto - malgrado, comunque, per l'utilizzo del pincode sia necessario avere anche il badge.
Di per s� NON � possibile avere la lista dei pincode neanche tramite query SQL, perch� i pincode sono su un campo della T25COMBADGE scritti in maniera criptata.

Per l'estrazione di tutti i pincode generati, seguire queste istruzioni:

- Copiare sul server la cartella Export_Pincode, contenente l'eseguibile ListPin.exe e il file di configurazione ListPin.exe.config
- Aprire e modificare il file di configurazione aggiornando le stringhe di connessione
- Eseguire ListPin.exe: alla fine dell'estrazione, vengono segnalate le matricole modificate con successo
- Nei log appariranno il log app.txt e err.txt, contenenti rispettivamente l'elenco delle attivit� dell'applicazione e gli errori
- La lista dei pin � elencata con il seguente format (matricola; nome; cognome; badge; azienda interna; descr azienda interna; pin) nel file reflist.csv



# FUNZIONE DIGITAZIONE ID0 MAGNETICO DA TASTIERA
======================================================================
Per "Pincode e basta" si intende la funzione per cui viene generata una timbratura simile all'aver passato il badge, ma senza accompagnamento della tessera fisica. 
La funzione si chiama "Digitazione codice ID0 (magnetico) da tastiera".

CONFIGURAZIONE
----------------------------------------------
(*) Importante: DEVE essere configurata una tecnologia banda magnetica nel MicronConfig, e deve essere abilitata sul lettore KK su cui si vuole inserire questa funzione (se la tecnologia testina non � inserita n� abilitata, il corrispondente campo su MicronpassWeb non sar� visibile)

- MicronConfig > [testina KK] > Abilitazioni > spunta su "Digitazione codice ID0 (magnetico) da tastiera"
- MicronConfig > [testina KK] > Configurazione testine > attivare device "0-Badge on Board"
- Stop servizio btService corrispondente, aprire il NoService corrispondente, inviare comando di Azzeramento Memorie all'MXP relativo al KK su cui si sta attivando la funzione
- Su MicronpassWeb > Badge e Chiavi > Gestione badge > [entrare nella pagina di dettaglio del badge del dipendente per il quale si vuole attivare la funzione] > scrivere nel campo "Banda Magnetica" il codice nel seguente formato:
	- Inserire il codice
	- A sinistra del codice, riempire con delle F fino a copertura di 10 cifre (codice compreso)
	- Salvare: il sistema si preoccuper� di riempire di zeri la parte mancante del codice

	es. 	codice a 5 cifre = FFFFF<abcde>
		codice a 3 cifre = FFFFFFF<abc>

(*) Manco a dirlo, il dipendente deve essere nella white list di quel varco
(*) In corrispondenza di un biometrico, dovendo attivare l'ID0 (e quindi inserendo la Banda Magnetica tra i device), ricordarsi di aggiungere la tecnologia 10-BADGE ON BOARD invece di 0-BADGE ON BOARD, perch� confligge con il lettore biometrico




# AREE ANTIPASSBACK
======================================================================
PRINCIPI DI FUNZIONAMENTO



� CONFIGURAZIONE AREA ANTIPASSBACK
Prerequisiti: i varchi sotto APB devono avere il Controllo Abilitazione attivo!

Aggiungere un'Area Passback

	- Micronconfig > Impianto > Aggiungi Area Anti-Passback
	- Codice = [inserire codice APB]
	- Descrizione = [inserire descrizione APB]
	- Terminale con tabelle passback = [selezionare il terminale base che ospiter� le tabelle dei transiti APB]
	- Antiintrusione: 				% parametrazione per gestire i comandi out di antiintrusione automatici, disabilitando il controllo anti-passback
		APB - Nessun comando			% Disabilitazione generale dei comandi, ma APB attiva	
		APB - Comandi abilitati			% Abilitazione generale dei comandi, ma APB attiva
		APB Ingresso - Nessun comando		% Disabilitazione dei comandi, ma APB attiva solo in ingresso (uscita libera) 
		APB Ingresso - Comandi abilitati	% Abilitazione dei comandi, con APB attiva solo in ingresso (uscita libera)
		No APB - Comandi abilitati		% Abilitazione dei comandi, ma senza APB
	- Massimo presenti:
		
	- Parametri ARM:
		Clearpresents 		% Cancella i presenti a mezzanotte (0=Disabilitato; 1=Abilitato)
		TxHost			% Aggiorna i transiti sul server (0=Disabilitato; 1=Abilitato)
		(*) Tabella MySQL di riferimento: T019APB_PARAM


"CONVERSIONE" DI DUE MXP AD UN'AREA APB
Esempio fatto su PMI, in maniera tale da non incidere sul regime di utilizzo del sistema

Prerequisito:
- Per utilizzare l'ethcfg è necessario avere un PC nella stessa classe di rete
- su Server > MicronConfig > Servizio > Inizio manutenzione (equivalente: IIS > Application Pool > stop app pool MPW)

Procedura:
- su PC portatile > GNConfig > ethcfg su entrambi gli MXP 
	Per il primo terminale: 
		ethcfg C <MAC_address_1> <IP_address_1> U <Subnet_mask_1> 3001 <Gateway_1>
	Per il secondo terminale:
		ethcfg C <MAC_address_2> <IP_address_2> U <Subnet_mask_2> 3001 <Gateway_2>
	(*) Il cambio di protocollo da T a U potrebbe NON funzionare se inviato da server; te ne accorgi rimettendo la centralina in TCPIP, il servizio la riaggancia immediatamente; in tal caso significa che il protocollo UDP non pu� essere usato da server e bisognerebbe riconfigurare la centralina localmente, cio� con un cavo di rete e un GNConfig su portatile
- GNConfig > Nodo MXP 1 > Connessione: "UDP Gnet"
- GNConfig > Nodo MXP 2 > Connessione: "UDP Gnet"
- GNConfig > Genera Tabelle Host
- GNConfig > Seleziona Nodo MXP 1 > Invia INIT, NROUT, PNETW
- GNConfig > Seleziona Nodo MXP 2 > Invia INIT, NROUT, PNETW
- MicronConfig > Nuova area APB > definire terminale con la tabella APB (di solito � equivalente quale dei due)

Per chiudere:
- MicronConfig > Fine Manutenzione (oppure riavvia Application Pool del MPW) 
- Micronsin Web > check su entrambi gli MXP > Invia "Setup terminali accessi"
- Micronsin Web > check su entrambi gli MXP > Invia "Presenti Passback"


� ELUSIONE AREA ANTIPASSBACK
NB: L'elusione area APB ha effetto se il terminale ha attivo il Controllo Abilitazioni! Altrimenti bypassa il comando di varco presente in abilitazione della matricola.

Prerequisito:
- Configurare area APB su terminale/terminali considerati

Configurazione elusione (GNET):
- MicronConfig > Varco > Comando di Varco > Abilitato + Descrizione "APB_exclusion"
- MicronConfig > Varco > Comando di Varco > Selezionare terminale
- MicronConfig > Varco > Comando di Varco > Selezionare varco
- MicronConfig > Varco > Comando di Varco > GNET: selezionare un out qualsiasi sul terminale di riferimento
- MicronConfig > Varco > Comando di Varco > Tasto: 0
- MicronConfig > Terminale base > Comandi > Comando esclusione APB > [Selezionare l'out di varco "APB_exclusion"]
- MicronConfig > Terminale KK Entra > Comandi > Comando esclusione APB > [Selezionare l'out di varco "APB_exclusion"]
- MicronConfig > Terminale KK Esce > Comandi > Comando esclusione APB > [Selezionare l'out di varco "APB_exclusion"]
Configurazione elusione (ARM):
Come per GNET, ma...
- MicronConfig > Terminale base > Parametri > Stamping > APBExclusion = [sel.Out di varco "APB_exclusion"]

Configurazione abilitazione:
- Micronpass Web > [Cat. anagrafica] > [Anagrafica] > Abilitazioni > [Abilitare Out di Varco "APB_exclusion"]



# SCANNER 
======================================================================
(es. per future riattivazioni Lindt; si veda documentazione Micronpass Web 6.6.11)

- Attivazione della funzione di Scansione Documento di Identit� per i Visitatori

	- Micronconfig > Parametri > Micronpass > Scansione documenti identit� visitatori	% Abilita/disabilita la funzionalit� (default a 0)
	- Micronconfig > Parametri > Micronpass > Abilita modalit� debug scanner		% Abilita/disabilita la modalit� di debug in fase di scansione
		(*) La modalit� debug mostra in chiaro gli errori durante la scansione, qualsiasi essi siano
	- Micronconfig > Parametri > Micronpass > Coefficiente di qualit� scansione		% Valore numerico da 1 a 100 usato per l'algoritmo di compressione delle immagini salvate nella T31IMAGE
	- Micronconfig > Parametri > Micronpass > Espansione automatica scansione su pagina visitatori	% Abilita/Disabilita la tab contenente l'immagine nella pagina visitatori del Micronpass Web

- Installazione dello scanner FUJITSU FI-60F
	- Installare, tramite CD, tutta la predisposizione (driver TWAIN, interfaccia TWAIN standard, software di scansione "ScandAll PRO Lite"): � possibile che venga richiesto un riavvio
	- Eseguire ScandAll PRO Lite per una scansione di test e per parametrare correttamente lo scanner

- Configurazione della workstation client dove � installato lo scanner
(*) La funzionalit� � supportata solo per Internet Explorer

	- Inserire Micronpass Web tra i siti attendibili
	- Lanciare da Amministratore lo script Fx20Security.bat per elevare a "Full trust" le permission degli assembly scaricati dai siti web attendibili

- Uso della funzionalit�

	- Inserire il visitatore in Micronpass Web
	- Comandi > Nuova scansione			% per effettuare una nuova scansione veloce
	- Comandi > Nuova scansione con parametri	% per effettuare una scansione che passi dalla pagina di parametrazione dello scanner stesso
		(*) Parametri ottimali:
			Risoluzione 			75x75 dpi
			Modalit� immagine		Colore
			Opzioni > Grado di rotazione	90.0
			[cliccare su Scan per eseguire la scansione]
		(*) La parametrazione iniziale viene salvata anche per le scansioni successive, anche se lanciate da Micronpass Web
	- Comandi > Elimina scansione			% per cancellare la scansione attuale, se presente




# BIOMETRICO (es. KK900), MICRONBADGE, UNIFINGER
======================================================================

INTRO
-----------------------------------------------------------------
* SUPREMA SFM-3550: per i lettori biometrici, Microntel utilizza il sensore "Suprema": si tratta di un dispositivo 'biometrico' (cio� lettore di impronte digitali) connesso ai terminali Karpos. � un sensore capacitivo con un'area sensibile di 12.8x18mm, contiene una memoria flash da 4MB e quindi pu� memorizzare fino a 9000 templates, ciascuno da 384 bytes.
* Lettori Microntel con lettore biometrico:
	- MCT 353 B
	- MCT 900
	- KK 900
* � possibile collegare il dispositivo di lettura biometrica in due modi:
	- LOCBUS (vel.9600): per un massimo di sei testine biometriche per ogni MXP; arriva a 200 m di distanza, ma la comunicazione � lenta perch� ci sono tantissimi pacchetti da smaltire
	- SERIALE (vel.19200): essendo un collegamento diretto tra lettore biometrico e MXP, ha una velocit� di trasmissione molto maggiore; in compenso, la distanza massima di collegamento � di 12 m e si pu� collegare solo un lettore per MXP
* Esistono tre modi di utilizzo:
	- CONFRONTO ID TAG (utilizzabile sui lettori sia in seriale sia in Locbus)
	- FREE SCAN (utilizzabile sui KK solo in seriale!)
	- VERIFICA TESSERA CON IMPRONTA SU MIFARE 1K (utilizzabile sui lettori sia in seriale sia in Locbus)


CONFIGURAZIONE DEL SENSORE (UNIFINGER)
-----------------------------------------------------------------
Il dispositivo necessita della configurazione di alcuni parametri di funzionamento per essere correttamente integrato del firmware dei terminali Karpos. La configurazione dei parametri di funzionamento avviene mediate il programma UNIFINGERUI_V43.EXE (installato di default sotto C:\MPW\UniFinger): non richiede alcuna installazione, � sufficiente lanciarlo.

MAIN:
Da utilizzare per connettere e testare il sensore

	- Attaccare il sensore al PC tramite seriale; verificare la porta cui � collegato tramite Gestione Dispositivi
	- Cliccare su "COMM>>": appare la finestra di configurazione. 
		COM PORT	<porta COM di collegamento del sensore> (il comando SEARCH fa una ricerca automatica)
		BAUDRATE	19200
		PROTOCOL	Single
	- Per controllare una corretta scansione: 
		- mettere la spunta su "View"
		- cliccare su "Scan Image" 
		- appoggiare un dito sul sensore: la lettura d� un riscontro visivo dell'impronta letta.
	- Per testare l'arruolamento:
		- Cliccare su "Enroll"
		- appoggiare un dito sul sensore 
		- un messaggio in alto d� lo Score in alto
		- il template � stato salvato nella memoria del Suprema (la tabella dei record salvati � visibile in alto a destra)
	- Per testare l'identificazione:
		- Cliccare "Identify" 
		- Appoggiare un dito sul sensore 
		- Il record viene riconosciuto se in alto appare un messaggio con l'indice corrispondente alla posizione nella tabella dei template
	- Per cancellare tutti i template salvati:
		- cliccare su "Delete all"

SYSTEM:
Per configurare i parametri di funzionamento del lettore. Questi dipendono dalla modalit� d'utilizzo che si vorr� utilizzare in seguito.
Sono segnati tutti i parametri: quelli importanti (quindi da controllare) sono identificati con [�].

	*** FONDAMENTALE: La velocit� di lettura del sensore *deve* essere 19200!

	- Configurazione: confronto ID tag
		- Communication > Baudrate: 		19200		[�]
		- Communication > Aux Baudrate: 	115200
		- Communication > Network mode:		Single
		- Communication > Response Delay: 	20 msec		[�]
		- Communication > ASCII Packet:		Off
		- Communication > Encryption:		Off
		- Fingerprint > Security level:		Auto(1/10,000)
		- Fingerprint > Enroll Mode: 		1 Time		[�]
		- Fingerprint > Fast Mode:		Automatic
		- Fingerprint > Provisional Enroll:	Off
		- Fingerprint > Image Quality:		Moderate
		- Fingerprint > Rotation: 		30
		- Fingerprint > Enroll Displacement:	No Check
		- Fingerprint > Template size:		384		[�]
		- Fingerprint > Free Scan: 		Off		[�]
		- Fingerprint > Free Scan Delay: 	No delay	[�]
		- Fingerprint > Pass when empty:	Off
		- Fingerprint > Send Scan Success: 	OFF		[�]
		- Fingerprint > Template type:		Suprema
		- Sensor > Type:			STMicro
		- Sensor > Sensitivity: 		4		[�]
		- Sensor > Rotate image:		Off
		- Sensor > Lighting Condition: 		Indoor		[�]
		- Sensor > Image format:		Binary
		- Operation > Timeout: 			10 sec		[�]
		- Operation > Matching Timeout:		Infinite
		- Operation > Watchdog:			On
		- Operation > Auto Response: 		HOST		[�]

	- Configurazione: Free Scan (solo impronta)
		- Communication > Baudrate: 		19200		
		- Communication > Aux Baudrate: 	115200
		- Communication > Network mode:		Single
		- Communication > Response Delay: 	20 msec		
		- Communication > ASCII Packet:		Off
		- Communication > Encryption:		Off
		- Fingerprint > Security level:		Auto(1/10,000)
		- Fingerprint > Enroll Mode: 		1 Time		
		- Fingerprint > Fast Mode:		Automatic
		- Fingerprint > Provisional Enroll:	Off
		- Fingerprint > Image Quality:		Moderate
		- Fingerprint > Rotation: 		90
		- Fingerprint > Enroll Displacement:	No Check
		- Fingerprint > Template size:		384		[�]
		- Fingerprint > Free Scan: 		ON		[�]
		- Fingerprint > Free Scan Delay: 	2 sec		[�]
		- Fingerprint > Pass when empty:	Off
		- Fingerprint > Send Scan Success: 	OFF		
		- Fingerprint > Template type:		Suprema
		- Sensor > Type:			STMicro
		- Sensor > Sensitivity: 		4		
		- Sensor > Rotate image:		Off
		- Sensor > Lighting Condition: 		Indoor		
		- Sensor > Image format:		Binary
		- Operation > Timeout: 			10 sec		
		- Operation > Matching Timeout:		Infinite
		- Operation > Watchdog:			On
		- Operation > Auto Response: 		HOST			

	- Configurazione: Verifica tessera con impronta su Mifare 1K
		- Communication > Baudrate: 		19200		
		- Communication > Aux Baudrate: 	115200
		- Communication > Network mode:		Single
		- Communication > Response Delay: 	20 msec		
		- Communication > ASCII Packet:		Off
		- Communication > Encryption:		Off
		- Fingerprint > Security level:		Auto(1/10,000)
		- Fingerprint > Enroll Mode: 		1 Time		
		- Fingerprint > Fast Mode:		Automatic
		- Fingerprint > Provisional Enroll:	Off
		- Fingerprint > Image Quality:		Moderate
		- Fingerprint > Rotation: 		90
		- Fingerprint > Enroll Displacement:	No Check
		- Fingerprint > Template size:		288		[�]
		- Fingerprint > Free Scan: 		OFF		[�]
		- Fingerprint > Free Scan Delay: 	2 sec		
		- Fingerprint > Pass when empty:	Off
		- Fingerprint > Send Scan Success: 	OFF		
		- Fingerprint > Template type:		Suprema
		- Sensor > Type:			STMicro
		- Sensor > Sensitivity: 		6		
		- Sensor > Rotate image:		Off
		- Sensor > Lighting Condition: 		Indoor		
		- Sensor > Image format:		Binary
		- Operation > Timeout: 			10 sec		
		- Operation > Matching Timeout:		Infinite
		- Operation > Watchdog:			On
		- Operation > Auto Response: 		HOST			

Cliccare poi su WRITE (nel 'database' del Suprema) e SAVE (salva nella cache del software).


CONFIGURAZIONE SOFTWARE (MICRONCONFIG) per terminali GNET
-----------------------------------------------------------------

NOTE:
- T25COMBADGE nel campo ID5 c'è il valore di riferimento nella tabella T100ACCBIO (che � anche l'indice nella memoria del Suprema)
- T100ACCBIO contiene i template biometrici


CONFRONTO ID TAG (IMPRONTA SU DATABASE):
Il lettore legge il badge Il lettore legge l'impronta del dipendente e la invia all'MXP che la confronta col template salvato su DB
* Metodo più lento perché deve inviare i template (e sono pesanti!)
* L'utilizzo di una tessera (o di un ID0 digitato da tastiera, v.sotto) semplifica comunque l'indicizzazione rispetto al Free Scan
	
	- MicronConfig > Testina > Configurazione Testine > Device: Tecnologia 11-Biometrico		% Prima tecnologia di lettura  ---> Configurare su Testina 1 anche se la descrizione della tecnologia dice T2!!!
	- MicronConfig > Testina > Configurazione Testine > Device: Tecnologia 13-Mifare		% Seconda tecnologia di lettura
	- MicronConfig > Testina > GPParam35 = 1							% Associare un KK al dispositivo biometrico presente sulla porta seriale 2
	- MicronConfig > Testina > Check Profiles							% Controllo abilitazioni, se no non funziona
	- MicronConfig > Flags > IDBio = 15								% Associazione dell'impronta con la matricola
	- NoService: invia i template salvati nella T100ACCBIO nella memoria del Suprema
	- Se all'accensione del NoService c'� ERRORE FIRMWARE � perch� ci sono problemi di comunicazione


VERIFICA TESSERA CON IMPRONTA SU MIFARE 1K/4K:
Il lettore legge l'UID del badge e il/i template contenutovi (salvato tramite arruolamento), dopodich� chiede all'MXP le white list; se il badge � abilitato, allora il lettore chiede l'impronta al dipendente e a quel punto la confronta con il template: se l'impronta coincide col template, allora viene generato il transito
* Comunicazione più leggera
* Impianto più sicuro, perché l'UNICA copia dell'impronta è scritta nella tessera (crittata e con password, tra l'altro), per cui NON esistono copie su database

	- MicronConfig > Testina > Configurazione testine > Device: Tecnologia 11-Biometrico		% Prima tecnologia di lettura ---> Configurare su Testina 1 anche se la descrizione della tecnologia dice T2!!!
	- MicronConfig > Testina > Configurazione testine > Device: Tecnologia 13-Mifare		% Seconda tecnologia di lettura
	- MicronConfig > Testina > GPParam35 = 17							% Salvataggio template su tessera: il lettore cerca il template nella tessera
	- MicronConfig > Testina > Check Profiles							% Controllo abilitazioni, se no non funziona


FREE SCAN (IMPRONTA SU DATABASE):
Il sensore legge l'impronta e ne fa una verifica con i template in database scarica direttamente la timbratura
* Implica (come impronta con template su database) il salvataggio dell'impronta su database (famosa T100ACCBIO), il che appesantisce la comunicazione; ha inoltre una copia dei template nel database 'locale', cio� in memoria del Suprema
* In assenza di tessera, il Suprema cerca il template in mezzo a TUTTI quelli salvati
* Free Scan significa che il sensore � SEMPRE acceso (mentre con la lettura su tessera, il sensore si accende solo di fronte a un badge)

	- (Nota: non ci sono testine KK lato software, il free scan è disponibile solo con testina collegata in seriale su terminale base, quindi la configurazione si fa tutta sull'MXP)
	- MicronConfig > MXP > Configurazione Testine > Device: Tecnologia 11-Biometrico	% Tecnologia di lettura ---> Configurare su Testina 1 anche se la descrizione della tecnologia dice T2!!!
	- MicronConfig > MXP > GPParam35 = 0							% Nessuna associazione a testina KK
	- MicronConfig > Flags > IDBio = 15							% Associazione dell'impronta con la matricola


	(*) PARTICOLARITA': Timbratura con codice ID0 digitato su KK e verifica biometrica
	Si digita il codice sulla tastiera del KK: si accende la tastiera e il LED rosso; inizia il check controllo delle white list (se l'esito � negativo, l'operazione � negativa, il transito � rifiutato e si ha il blink rapido del LED rosso); la tastiera si accende, il terminale attende che si appoggi il dito; verifica biometrica
	
		- MicronConfig > Testina > Abilitazioni > Digitazione codice ID0 (magnetico) da tastiera
		- MicronConfig > Testina > Configurazione Testine > Device: 0-BADGE ON BOARD
		- MicronConfig > Testina > Parametri Base > Tipo Funzionamento: PINCODE SU TIMBRATURA
		(per il resto, seguire "Confronto ID tag")


MICRONBADGE
-----------------------------------------------------------------
Il MicronBadge nasce per acquisire una SECONDA tecnologia identificativa a fronte di una tecnologia gi� esistente (per esempio, aggiungere il Mifare a un impianto a Banda Magnetica).
GNConfigMBadge � il GNConfig specifico per l'arruolamento nella vecchia serie Karpos dei terminali, che possedeva allo stesso tempo l'arruolatore biometrico E lo scrittore di badge (banda magnetica)
Documentazione: MicronBadge 33.3

NOTE
- In presenza di biometrico, MicronBadge e UniFinger non possono essere contemporaneamente aperti, perch� solo uno dei due pu� occupare la porta seriale


PARAMETRAZIONE SU MICRONCONFIG > PARAMETRI > MICRONBADGE:
Parametri inseriti ad esempio per un impianto funzionante come "Verifica tessera su Impronta Mifare 1K" che ha anche il lettore USB
* La tecnologia Lettore USB � la numero 256, controllare che sia inserita nella tabella Tecnologie Testine
* La tecnologia 256 va specificata SIA per la tecnologia 'vecchia' dell'impianto SIA per la tecnologia che si sta introducendo
* Si trascurino i parametri relativi alla gestione del Micronbadge con terminali firmware BTBxxxx, non pi� manutenuta

	- Enabled techs for badge update: 11,256			% Qual � la nuova tecnologia che vuoi acquisire?
	- Enabled techs for badge recognition: 13,256	 		% Qual � la vecchia tecnologia dell'impianto? 
	- Enable Manual Search: ABILITATO				% La ricerca manuale legge da database: � vincolante che l'anagrafica (con almeno un ID valorizzato, ad es. ID0) sia precaricata
	- Number of fingerprints to be read on biometric reader: 2	% Numero di impronte da registrare per ogni anagrafica
	- Biometric reader serial config: 3,19200,8,1,N,N 		% Comunicazione tra lettore biometrico e micronbadge: Porta COM, Velocit�, DataBit, BitStop, Parity, HandShake
	- Biometric device type: SUPREMA				% Tipo di sensore utilizzato
	- Invia aggiornamenti a MicronService: ABILITATO 		% il MicronBadge invia automaticamente la nuova tecnologia acquisita al servizio
	- Create and Assign Badge: ABILITATO 				% � una specie di funzione di creazione PROGRESSIVA dei badge, crea un pulsante apposito sulla maschera del MicronBadge
	- Initial badge ID for automated generating: 0			% Se il precedente parametro � attivo, primo numero da usare per la creazione progressiva dei badge
	- Final badge ID for automated generating: 9999999999		% Se il precedente parametro � attivo, ultimo numero da usare per la creazione progressiva dei badge
	- SmartCard mode: TEMPLATE MEMORIZATION 			% corrisponde, lato MicronBadge, al GPParam35=17 della testina
	- Send commands to services via database only: ABILITATO	% scrive le modifiche solo su database, senza dirlo al servizio (che poi si aggiorner� da solo)
	- USB reader model: STANDARD PC/SC READER			% Lettore USB utilizzato per la lettura/scrittura
	- COM port for non-USB readers: 1				% porta COM da usare su lettori NON USB


UTILIZZO:
L'eseguibile si trova in C:\MPW\MicronBadge\micronBadge.exe; utilizzo descritto in accordo ai parametri sopra citati

	Free Scan:

	Confronto ID Tag:	

	Verifica tessera con impronta 1K/4K:

		Su MCT Biometrico:
		- Premere sulla tastiera la sequenza 0-1-2-3-4-5 per accedere al Menu di arruolamento
		- Cliccare "(F4) INIT CARD" e posizionare la tessera davanti all'antenna destra; non rimuovere la tessera finch� non appare il messaggio di conferma e il display mostra nuovamente il menu
		- Cliccare "(F1) SCAN FINGER 1" per attivare il sensore biometrico: seguire le istruzioni e posizionare il primo dito sul sensore; attendere il messaggio che indica la qualit� percentuale della scansione, a quel punto il template � stato memorizzato nella cache del dispositivo
		- Cliccare "(F2) SCAN FINGER 2" per attivare nuovamente il sensore biometrico: seguire le istruzioni per registrare anche il secondo dito
		- Cliccare "(F3) WRITE CARD" e posizionare la tessera davanti all'antenna destra: il dispositivo scriver� i due template dentro alla tessera (NON rimuovere la tessera durante il processo di scrittura: si potrebbe bruciare la tessera!)
		- Una volta ottenuto il messaggio di conferma, premere "(F5) EXIT" per tornare alle impostazioni di arruolamento
		- Cliccare sul tasto rosso per tornare alla Home Page		

		Su Micronbadge:	
		- cliccare su Ricerca Manuale (se abilitato dai parametri)
		- In "Selezione matricola", cliccare su [>>]
		- Selezionare la matricola di riferimento (che deve avere un badge attivo)
		- Nella maschera principale appaiono i dati dell'anagrafica, compreso il badge attivo
		- Nella schermata del Menu Biometrico, appaiono le seguenti voci:
			Acquisizione impronta #1 (mancante)
			Acquisizione impronta #2 (mancante)
			Scrittura tessera
		- Con Acquisizione impronta #1, cliccare su Esegui: il sensore fa due scansioni per dito, salvando il template con qualit� maggiore
		- Con Acquisizione impronta #2, cliccare su Esegui: il sensore fa due scansioni per dito, salvando il template con qualit� maggiore
		- Cliccare su Scrittura Tessera


LOGS:
	mbadge.log		% Log dell'applicativo MicronBadge
	btLibErr.log		% Log della comunicazione btLib
	suprema.log		% Log delle letture del sensore, con relative qualit�

ERRORI:

(*) ERRORE TECNOLOGIA NON DISPONIBILE ALL'APERTURA

	- Verifica che i codici tecnologia nei parametri seguenti siano effettivamente presenti. Sotto, un esempio di arruolamento impronta dove � presente solo il badge Mifare:
		- Enabled techs for badge update: 11				% Acquisire biometrico
		- Enabled techs for badge recognition: 13	 		% Tag Mifare gi� presente su database 


(*) ERRORE DI CONNESSIONE AL SQL SERVER
[DBNETLIB] [ConnectionOpen (Connect()).] SQL Server inesistente o accesso negato.

	- Aggiungi nel Firewall del server e del client la regola che permette le connessioni in entrata e in uscita sulla porta usata da SQL Server
		- Per sapere quale sia la porta utilizzata, andare su SQL Server Configuration Manager > Configurazione SQL Native Client 11.0 > TCP/IP > [click destro] > Propriet� > Porta predefinita
	- Fai partire almeno una volta il servizio SQL Server Browser dal SQL Server Configuration Manager per stabilire la prima connessione tra client e server
	- Il fatto che Micronpass Web si colleghi NON � indicativo della connessione al database, perch� MPW � pubblicato dall'IIS che risiede nel server stesso!

(*) ERRORE DI TRASMISSIONE COMANDI AI SERVIZI
Su btLibErr.log:
17-01-2018 12:17:48:675 TcpNet, BTTcpClient, rxData, System.IO.IOException: Impossibile leggere dati dalla connessione del trasporto: Impossibile stabilire la connessione. Risposta non corretta della parte connessa dopo l'intervallo di tempo oppure mancata risposta dall'host collegato. 

	- Micronconfig > Parametri > Micronbadge > Invio modifiche a servizio solo via DB = Abilitato
	% Questo parametro � utile negli impianti dove siano previste pi� sottoreti e da una di esse non sia possibile vedere l�IP del server che contiene i MicronService.
	% In particolare, in caso di tentativo di connessione verso un IP non valido nella propria sottorete, viene utilizzato da .NET un timeout di connessione non parametrabile molto elevato che rallenta in maniera eccessiva l�applicativo.
	% Con questa modifica, abilitando il nuovo parametro, la trasmissione delle modifiche ai servizi viene effettuata solamente attraverso il database in modo da evitare il rallentamento di cui sopra.
	

(*) ERRORE GESTATUS
	- L'arruolatore � collegato bene?
	- Hai verificato i parametri seriali sul Micronconfig? (Porta COM, Velocit�, DataBit, BitStop, Parity, HandShake)


MCT353BIO - MCT700: ARRUOLAMENTO ED UTILIZZO

� Procedura di arruolamento impronta digitale

� Utilizzo (cache del terminale)


CONFIGURAZIONE SOFTWARE (MICRONCONFIG) per terminali ARM
--------------------------------------------------------------
Queste funzionalit� *dismetteranno* il MicronBadge

PREREQUISITI:
TrayClient >= 1.6.0
Micronpass >= 7.4.52 o >= 7.5.23
>= Packages_1.2.10.tar.gz (k1.2.10, c1.2.3, d1.2.11)

CONFIGURAZIONE:
Generale: tecnologie coinvolte
	11-Biometric 		% Testina biometrica embedded nel dispositivo locbus
	29-RS232 BIOM 1	Entry	% Testina biometrica collegata in seriale (default ttys2)
	30-RS232 BIOM 2	Exit	% Testina biometrica collegata in seriale (default ttys3)
	31-RS232 BIOM 3	Exit	% Testina biometrica collegata in seriale (default ttys1)
	(*) Il verso di timbratura nella descrizione della tecnologia non � indicativo (verr� infatti usato quello dell'antenna dove viene letta la tessera), ma � stato predisposto per il futuro uso in modalit� FreeScan

Test hardware del sensore da terminale MCT900:
*** FONDAMENTALE: La velocit� di lettura del sensore *deve* essere 19200, altrimenti kSuprema non vedr� mai il sensore.
	/home/root/kSuprema {SUPREMA1|SUPREMA2|SUPREMA3}	% Tool simile all'Unifinger
		Viene mostrata la sintassi necessaria
		1 = SUP_SYSTEM_PARAM_WRITE	% Edita il valore dei parametri del Suprema
		2 = SUP_SYSTEM_PARAM_SAVE	% Salva i parametri cambiati
		3 = SUP_SYSTEM_PARAM_READ	% Legge i parametri attuali del Suprema
		(*) L'ordine per editare i parametri � 3,1,2
		(*) il kSuprema risponder� sempre ERROR se in contemporanea stanno girando il kDisplay o il Karpos, cio� gli applicativi che si occupano di comunicare con il canale seriale su cui sta funzionando il biometrico. Arrestare i servizi prima di utilizzare il tool kSuprema.

Configurazione hardware:
- Scrittura impronta su tessera:
	Generico
		MicronConfig > Tabelle > Parametri generali > Traccia identificazione ID biometrica = non specificato
		MicronConfig > Tabelle > Tecnologie testine: aggiungere le tecnologie 29, 30, 31
	Terminale di presenze
		MicronConfig > Terminale MCT700 > Parametri extra: CustomSmartcard = MICRONTEL		% Attenzione al Case-Sensitive!!!
		MicronConfig > Terminale MCT700 > Parametri > Biometric >  ReadingMode = Template on card
		MicronConfig > Terminale MCT700 > Parametri > Reader >  N1 = 13-MIFARE UID		% MiFare Classic con template biometrico salvato
		MicronConfig > Terminale MCT700 > Parametri > Reader > N2 = 29-RS232 BIOM1 ENTRY	% Sensore Suprema collegato su ttys2
	Dispositivo KK su locbus
		MicronConfig > Terminale base > Parametri extra: CustomSmartcard = MICRONTEL		% Attenzione al Case-Sensitive!!!
		MicronConfig > Kleis > Parametri > Biometric > ReadingMode = Template on card
		MicronConfig > Kleis > Parametri > Reader >  N1 = 13-MIFARE UID				% MiFare Classic con template biometrico salvato
		MicronConfig > Kleis > Parametri > Reader >  N2 = 11-Biometric				% Sensore Suprema embedded nel lettore
	Dispositivo KK con Suprema non-embedded in seriale
		MicronConfig > Terminale base > Parametri extra: CustomSmartcard = MICRONTEL		% Attenzione al Case-Sensitive!!!
		MicronConfig > Kleis > Parametri > Biometric > ReadingMode = Template on card
		MicronConfig > Kleis > Parametri > Reader >  N1 = 13-MIFARE UID				% MiFare Classic con template biometrico salvato
		MicronConfig > Kleis > Parametri > Reader >  N2 = 29-RS232 BIOM1 ENTRY
			% Sensore Suprema collegato su ttys2
- Micronpass Web:
	MicronConfig > Parametri > Micronpass = Modalit� acquisizione impronte digitali 
		Disabilitata
		Memorizzazione su database	% Al momento implementata solo su Micronpass Web, non implementata a livello hardware
		Scrittura su tessera MiFare	% Funzionante sia a livello di Micronpass Web sia a livello hardware

- Arruolatore:
	Gestione dispositivi > impostare porta seriale: COM254 (velocit� di default 19200)

UTILIZZO:
- Scrittura impronta su tessera:
	Micronpass Web > [anagrafica] > Comandi > Acquisizione impronte digitali
		Acquisizione impronta #1, prima & seconda scansione
			(*) ERROR 6C: timeout, l'utente ha 10 secondi per posizionare il dito
		Acquisizione impronta #2, prima & seconda scansione
		Scrittura impronta
		(*) Per la scrittura su tessera, al momento, non � prevista la cancellazione da tessera
- Uso su terminale:
	Avvicinare la tessera, il lettore si metter� in attesa
		Attesa per il MCT900: scritta "Verifica impronta" su display
		Attesa per il KK911: LED spenti, in attesa
	Esito:




# MICRONVIEWER (VISUALIZZAZIONE TRANSITI)
======================================================================
La funzione non � pi� un applicativo a parte ma � una funzione aggiuntiva di Micronpass Web, e quindi invece di MicronViewer si chiama "Visualizzazione transiti"

Prerequisiti:
Il file .LIC deve contenere MicronViewer

Attivazione:
- MicronConfig > Tabelle > Associazioni varchi MicronViewer: inserisci codice della postazione (4 numeri) e scegli varco dal menu a tendina
- MicronConfig > Parametri > Micronpass > Indirizzo IP locale per Visualizzazione transiti: <IP del server>

Configurazione:
(*) I parametri vanno settati PER OGNI postazione da cui si utilizza la Visualizzazione Transiti, perch� hanno effetto sul browser utilizzato
- Micronpass Web > Visualizzazione Transiti > [postazione di visualizzazione] > [simbolo attrezzi]
	Parametri:
		Elenco varchi da monitorare:		Spunta su varco
		N� transiti visibili a video:		Numero di transiti da visualizzare prima che appaia la barra di scorrimento verticale
		N� transiti totali:			Numero totale di transiti (settare questo parametro non troppo alto, per evitare un consumo eccessivo di memoria da parte del browser)
		Tempo fermo immagine in sec:		Tempo per cui il transito rimane nella parte alta dello schermo, prima che venga rimosso
		N� richieste al secondo:		Quantit� di richieste inviate dal browser al server, al secondo (settare questo parametro alto rende pi� real-time la funzione, ma consuma di pi�)
		Allarme sonoro sorteggiatore:		Crea un allarme quando il sorteggiatore si attiva
		Allarme sonoro sort. in fase di stop:	Crea un allarme nella 'Stop phase' (cio� quando si clicca su una riga qualsiasi della griglia dei transiti, bloccando l'applicazione)
		Esegui animazione:			Crea un'animazione per ogni transito (da non abilitare se ci sono molte richieste al secondo)

Uso:
L�area  (1) (Barra di navigazione) contiene i bottoni di comando (la casetta porta alla home page, il simbolo di on/off riporta all�elenco delle postazioni, il simbolo della matita con chiave inglese ai parametri della postazione, il lucchetto consente di fermare immediatamente lo scarico e di bloccare la visualizzazione sulla foto attuale).
L�area (2) (Dettaglio) contiene i dati di dettaglio della timbratura e ha un bordo (e la scritta inferiore) che identificano lo status della timbratura, i colori sono per il momento fissi: Rosso (transito rifiutato), Verde (transito accettato normale), Blu (transito accettato eccezionale), Azzurro (transito accettato flash).
In presenza di transito con sorteggiatore non vengono cambiati i colori ma l�accadimento viene evidenziato dalla parola �sorteggiatore� dopo lo stato del transito.
L�area (3) (Griglia transiti) contiene l�elenco degli ultimi n transiti (dove n � il parametro Numero transiti totali), la griglia cresce verso il basso e la selezione viene mantenuta sull�ultimo transito ricevuto. Il colore del testo denota lo stato del transito, in presenza di un transito con sorteggiatore il colore di fondo diviene rosa.
Cliccando su una riga della griglia viene bloccato lo scarico delle timbrature e vengono portati nell�area di dettaglio i dati relativi al transito. Da notare che viene visualizzato un bordo superiore ed inferiore. Lo stato di blocco viene anche evidenziato dal simbolo di lucchetto aperto nell�area 1. A questo punto per sbloccare lo scarico � sufficiente cliccare nuovamente sulla riga selezionato oppure sul simbolo di lucchetto sbloccato. Cliccando invece su un�altra riga si mantiene lo stato di blocco ma vengono ovviamente visualizzati nell�area 2 i dati relativi alla riga cliccata. Da ultimo, durante la fase di funzionamento regolare, cliccando sul lucchetto nell�area 1 viene bloccato lo scarico selezionando automaticamente l�ultima riga inserita.

Autorizzazioni utente:
(Ovviamente l'utente deve avere il varco selezionato nel suo Organigramma)
- Utente > Autorizzazioni: Visualizzazione transiti

(*) Per abilitare un segnale acustico in corrispondenza dei transiti:
- MicronConfig > Varco > Testina > Configurazione testine > Testina # > Setup sorteggiatore > Frequenza: 100 (abilita ingresso/uscita)
Non c'� bisogno di configurare un Out aggiuntivo per il sorteggiatore
Azzeramento Memorie all'MXP per confermare la configurazione
Su Micronpass Web, il transito crea un Bip-bip-bip da browser e il record corrispondente sulla griglia transiti diventa rosso: nel database la timbratura � etichettata con un T37SORTEGGIATO=1



# MICRONSYNCHRO
======================================================================
Nota: MicSync NON fa parte del pacchetto MPW Application Suite
Documentazione disponibile in FTP Bitech al percorso: /MC_Commesse/CO MIC/Sync

Qui sotto una parametrazione classica di esempio per sincronizzare presenze e accessi (dati DA accessi A presenze)

Prerequisiti:
- Database MRT, MW o terzo
- Gestore licenze > Licenze > Nuova licenza MicSync > [stessi parametri della licenza MRT]


INSTALLAZIONE
- Eseguire 1.1.1_MicronSynchro > Setup > setup.exe
- Percorso di installazione di default C:\"Program Files (x86)"\Microntel\MicronSynchro

CONNESSIONI AI DATABASE
- Impostazioni > Database > MRT > Icona Database verde: inserire nome Database e parametri di connessione; testare connessione e confermare
- Impostazioni > Database > MRT > SQL > 
- Impostazioni > Database > Micron > Icona Database rossa: inserire nome Database e parametri di connessione; testare connessione e confermare


Parametri:
- Schermata "Link": si vedono le linee di sincronizzazione tra i database Micron, MRT, PRTW, Client; il colore della linea stabilisce il database di partenza (es. linea rossa tra Micron e MRT significa sincronizzazione dalle presenze agli accessi)
- Schermata "Database": stabilisce le stringhe di connessione ai database sorgente e destinazione
- Schermata "Schedule": stabilisce Start Time, Stop Time e Frequency


� SINCRONIZZAZIONE CLASSICA DA ACCESSI A PRESENZE


(*) La sincronizzazione non sincronizza un'anagrafica o un badge
	- Verifica che la stessa anagrafica o lo stesso badge appaia nei risultati del 'Test query' nella configurazione delle query! Magari � applicato un filtro particolare



# MICRONPLATE VEGA
======================================================================
Il MicronPlate 'Vega' � un'evoluzione del vecchio MicronPlate, che si occupava del riconoscimento delle targhe e anche del loro scarico come eventi di timbratura; il nuovo MicronPlate Vega (disponibile sia come servizio macchina sia come Agent) riceve l'evento di lettura della targa dalla videocamera stessa, e la confronta con le white list precaricate.
"VEGA" identifica una famiglia di prodotti da TATTILE sviluppati per il riconoscimento automatico della
targa di autoveicoli.

CONTATTI:
Assistenza G.S.G. International - 0248469760


INSTALLAZIONE:
-----------------------------------------------------------------
- Pacchetto di installazione "micPlateSetup_vXXX.zip"; unzippare ed eseguire Setup.exe (la cartella di destinazione non deve essere necessariamente sotto MPW)
- L'applicativo contiene:
	- MicPlateSrvAgent: MicronPlate in formato servizio, non interattivo
	- MicPlateAgent: MicronPlate in formato programma interattivo, con visualizzazione delle foto e modifica targa del transito; � il NoService del precedente
	- MicPlateDisplay: applicativo di segnalazione dei transiti


CONFIGURAZIONE MICRONPLATEAGENT / MICRONPLATESERVICEAGENT:
-----------------------------------------------------------------
- Aprire il file di configurazione micPlateAgent.exe.config
- Aggiornare la stringa di connessione inserendo Data Source (IP del DB server), Initial Catalog (nome database), user ID (nome utente), pwd (password di connessione)
- Parametro di ripetibilità della targa, ovvero tempo entro cui una stessa targa viene scartata per ripetizione; per questioni di rapidità conviene tenerlo alto (default a 30 sec); deve comunque essere inferiore al parametro di ripetibilità a bordo della videocamera (Plate Reader > Plate Reader > Min Time Same Plate ms):

	<!-- Tempo ripetibilità targa su Varco sec.-->
	<add key="PlateTimeGate" value="30"/>

- IDX di controllo badge se la telecamera è in Free Run: stabilisce a quale IDX del badge deve corrispondere lo scarico della timbratura nell'occorrenza di un transito; se il campo non è popolato, la targa non verà associata all'anagrafica e il risultato della lettura sarà 'sconosciuto'; 0=Banda Magnetica, 1=Tag RF Full, ecc.

	<!-- idx di controllo badge in freemode -->
	<add key="IDX" value="1"/>

- Associazione terminale: la videocamera scarica il transito come associato a un varco specifico, di cui si inserisce il codice terminale in questo parametro; gli altri parametri sono il verso (Entrata/Uscita), il modo di funzionamento (Free Run/Trigger) e l'elenco separato da virgole degli indirizzi IP delle videocamere relative a quel varco; ogni stringa terminale è separata dalle altre tramite punto e virgola

    <!-- associazione terminale,verso(E/U),modo funz(F/T), elenco telecamere;-->
	<!--
    	<add key="Terminali" value="00000001,E,F,192.168.0.239,192.168.0.240;00000002,U,F,192.168.0.241"/>
    	-->
    <add key="Terminali" value="70000101,E,T,192.168.0.239"/>

- Percorso foto: percorso di rete dove salvare le foto; il formato con cui vengono salvate può essere definito nella configurazione della videocamera

	<!-- Percorso di rete dove memorizzare le foto, se vuoto non memorizza -->
	<add key="PathPhoto" value="C:\MPW\MicronPlateVega\Photo"/>

- Indirizzo UDP: � l'indirizzo del PC su cui lavora il servizio, nella fattispecie dove è installato l'applicativo

	<!-- indirizzo locale per invio messaggi udp -->
	<add key="UdpLocalIp" value="192.168.0.40"/>


CONFIGURAZIONE VIDEOCAMERA (FREE RUN ONLY):
-----------------------------------------------------------------
v. Manualetto delle istruzioni della videocamera

PREMESSA
La videocamera ha un indirizzo IP di default; nel caso in cui non si conoscesse, � possibile utilizzare il software di riconoscimento indirizzi "Device Discovery Tool", eseguendolo e cliccando su "Search All Devices"; pi� avanti sar� possibile cambiare l'indirizzo IP della videocamera in modo da inserirlo nella LAN del PC con MicronPlateVega

- Aprire il browser e inserire l'IP della videocamera nella barra degli indirizzi
- Credenziali di accesso:
	username	superuser
	password	superuser
- Plate Reader > General
	Basic Settings > Enable Engine: YES		% Attiva o no il motore di rilevazione
	Basic Settings > Acquisition Mode: FREE RUN	% L'unit� acquisisce sempre le immagini
- System > Network
	Network > NetBiosName: VEGADEMO			% Nome del dispositivo Vega
	Network > IP Address: <IP della videocamera>	% Indirizzo IP del dispositivo Vega
	Network > NetMask: <Subnet della LAN>		% Net Mask della rete
	Network > Gateway: <Gateway della LAN>		% Gateway della rete
	Network > DNS Server: 8.8.8.8			% DNS server
	Network > DCHP Enable: 0			% Abilitazione o meno del DHCP
	Time Server > Synchronize: YES (*) il PC deve essere attivo come Time Server, v.sotto	% Abilita o disabilita la sincronizzazione del Vega con un time server esterno
	Time Server > Protocol: SNTP				% Protocollo da utilizzare col Time Server
	Time Server > IP Address: <IP del Time Server>		% Indirizzo IP dell'unit� Time Server
	Time Server > GMT Offset Minutes: 60			% Minuti da sommare all'orario ricevuto dal server per compensare il fuso orario (rif. GMT)
	Time Server > Automatically adjust... : YES		% Gestisce automaticamente il passaggio ora solare/legale
- Plate Reader > Plate Reader
	Plate Locator > Sensitivity: AUTO		% Lasciare in automatico la sensibilit� (valori manuali da 2 a 8)
	Char Size Pixel > (i valori sono limitati da dei massimi e minimi, comunque lasciare i default)		% Parametri delle dimensioni dei caratteri da riconoscere
	Temporal Integration > Max Time Transit ms: <solo FREE RUN per una lettura veloce, 3000>	% Tempo massimo ammesso per un transito
	Temporal Integration > Min Time Same Plate ms: <per una lettura veloce, 5000>			% Tempo che deve intercorrere per creare un nuovo evento di transito relativo alla targa gi� riconosciuta nel transito precedente
	Temporal Integration > Enable Multi Out Same Plate: 1		% Abilitazione della lettura della stessa targa
		(*) Se si vuole che la telecamera non rilegga una targa gi� letta, settare "Multi Out Same Plate = 0"; in tal caso, "Min Time Same Plate ms" rappresenta il tempo minimo per il quale, se la telecamera riconosce la stessa targa gi� letta, non genera l'evento di transito
	Temporal Integration > Image selection mode: BEST LUMINANCE	% Seleziona l'immagine con miglior valore di luminosit� media della targa
- Plate Reader > Events Actions
	OCR READ + TCP MESSAGE 
		Enable: YES						% Attivazione/disattivazione dell'invio di messaggio TCP
		Message format: STANDARD				% Formato messaggio
		Message: %DATE%TIME%PLATE%PLATE_STRING%IMAGE_BW		% Dati da inserire nel messaggio inviato tramite TCP-IP
		Jpeg quality: 75					% Valore da 1 (max livello di compressione) a 100
		Server IP: <IP del Server di destinazione>		% Indirizzo IP del server
		Server Port: 32000					% Porta del server
		Reuse Connection: NO					% Apertura e chiusura della connessione a ogni invio di messaggio
	OCR NOT READ + TCP MESSAGE
		Enable: YES
		Message format: STANDARD
		Message: %DATE%TIME
		Jpeg quality: 75
		Server IP: <IP del server di destinazione>
		Server port: 32000
	OCR NO PLATE + TCP MESSAGE
		Enable: YES
		Message format: STANDARD
		Message: %DATE%TIME
		Jpeg quality: 75
		Server IP: <IP del server di destinazione>
		Server port: 32000
- Plate Reader > Camera OCR
� possibile avere un riscontro visivo del fatto che la targa venga letta; sulla schermata live il riquadro verde indica il campo di lettura, un riquadro rosso in corrispondenza della targa indica l'avvenuta lettura (� possibile vedere la traduzione in caratteri nel riquadro nero di informazioni, nell'angolo in alto a sinistra). 
	(*) IMPORTANTE: la pagina "Camera OCR" arresta il motore di ricezione degli eventi, quindi va usata solo per assicurarsi del corretto orientamento della telecamera e del fatto che la targa venga letta in maniera corretta
- Plate Reader > Text Results
Questa pagina d� un log real-time degli eventi registrati dalla videocamera, tutti quelli configurati in "Events"
- Plate Reader > Device Info
Questa pagina d� la lista delle informazioni relative all'unit� Vega, compreso lo stato attuale del dispositivo

ATTIVAZIONE TIME SERVER SUL PC LOCALE
- La porta 123 del server dev'essere aperta e raggiungibile
- Nei Servizi, arrestare il servizio 'Ora di Windows'
- Regedit > HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\TimeProviders\NtpServer
- Impostare "Enabled = 1"
- Regedit > HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\Config
- Impostare "AnnounceFlags = 5"
- Riavviare il servizio 'Ora di Windows' in Automatico


MICRONPASS WEB
-----------------------------------------------------------------
- MicronConfig > Parametri > MicronPass > Campi aggiuntivi gestiti in anagrafica dipendenti > [...]
- Aggiungere TARGA 1, TARGA 2 e TARGA 3 a seconda di quante targhe si vuole salvare per ciascuna anagrafica
- Riciclare l'App Pool e aprire Micronpass Web: nell'anagrafica � possibile salvare il codice targa (l'anagrafica dev'essere abilitata al transito sul terminale di riferimento della videocamera)


UTILIZZO DI MICRONPLATEVEGA
-----------------------------------------------------------------
- Fissare la telecamera: ricordarsi che la distanza minima di lettura � 5 m e che le condizioni di luce dell'ambiente della videocamera sono pi� importanti delle condizioni di luce dell'oggetto ripreso
- Per puntare la telecamera, � possibile utilizzare la finestra "Plate Reader > Camera OCR" da configurazione sul browser, usando il video live; la stessa videata pu� servire per vedere se la targa viene correttamente rilevata (se l'esito � positivo, la targa viene riquadrata di rosso e la targa letta appare nel riquadro nero)
- Chiudere la pagina Camera OCR e aprire "Plate Reader > Text Results" per avere un log real-time delle letture lato Vega
- Aprire MicPlateAgente.exe
- Far effettuare una lettura: se tutto � corretto, il transito appare nella pagina "Text Results" a browser, dopodich� viene passato al MicPlateAgent
- Verificare Data/ora dell'evento, ed eventualmente agire sui parametri Time Server da browser
- Verificare che il transito sia stato effettivamente assegnato all'anagrafica di riferimento, e che venga correttamente trasferito



# INTERBLOCCO 
==============================================

KARM
-----------------------------------------------
Prerequisiti FW >= k1.2.14 c1.2.5 
Prerequisiti SW >= MSV 7.3.20 7.4.22 7.5.11, MCFG 7.3.26 7.4.20 7.5.12

Gestione bussola classica:
(ovvero, apertura automatica della seconda porta su chiusura della precedente)

	Funzionamento:
	1) L'utente timbra sul primo lettore (KK1)
	2) Il secondo lettore (KK2) viene immediatamente bloccato con messaggio CLOSE
	3a) Se la timbratura viene rifiutata, entrambi i lettori tornano in condizioni di riposo
	3b) Se la timbratura viene accettata, viene sbloccata la porta abbinata al primo lettore (KK1)
	4) L'utente apre la porta ed entra
	5) Altri utenti possono accodarsi prima che la porta venga chiusa, timbrando sequenzialmente sul medesimo lettore (KK1)
	6) Quando la porta viene chiusa, anche il primo lettore (KK1) si blocca con messaggio CLOSE
	7) In questo momento viene sbloccata la seconda porta abbinata al secondo lettore (KK2)
	8) Il sistema rimane in attesa dell'apertura della seconda porta:
		8.1) Un timeout impostato sull'apertura della seconda porta (parametro DOOR2T0UT) esegue un reset (Parametri RESETDEVICE e RESETIN) ed eventualmente pu� attivare un allarme digitale, v.sotto
			La ricezione del segnale di reset riporta le testine in condizioni di riposo, forzando la chiusura del ciclo
		8.2) L'allarme digitale pu� essere configurato a piacimento (parametri DOOR2ALDEVICE e DOOR2ALOUT)
	9) La seconda porta viene aperta
	10) Quando la seconda porta viene chiusa, entrambe le testine (KK1 e KK2) vengono rilasciate e tornano in condizioni di riposo (FINE CICLO)

	Configurazione:
	(Interblocco fatto di KK1-KX1, KK2-KX2, KX_emergenza)
	MicronConfig > KK1 > Parametri > Interlocks > Device = [inserire KK2]					% Codice dispositivo che deve essere interbloccato
	MicronConfig > KK1 > Parametri > Interlocks > Door2Aldevice = [inserire KX_emergenza]			% Codice dispositivo per notifica allarme "seconda porta non aperta"
	MicronConfig > KK1 > Parametri > Interlocks > Door2Alout = [inserire out emergenza, es.1]		% Uscita digitale per notifica allarme "seconda porta non aperta"
	MicronConfig > KK1 > Parametri > Interlocks > Door2tout = [inserire timeout, es. 20sec] 		% Timeout(s) apertura della seconda porta
	MicronConfig > KK1 > Parametri > Interlocks > Mode = 1-Bussola standard, doppia porta automatica	% Modalit� interblocco (0=Disabilitato)
	MicronConfig > KK1 > Parametri > Interlocks > ResetDevice = [inserire KX_emergenza]			% Codice dispositivo reset ciclo (0=Disabilitato)
	MicronConfig > KK1 > Parametri > Interlocks > ResetIn = [inserire ingresso reset, es.2]			% Ingresso digitale reset ciclo
	MicronConfig > KK1 > Parametri > Stamping > WaitOpen = Abilitato					% Attendi apertura porta prima di trasmettere la timbratura
	*** La serratura abbinata al KK1 deve essere dotata di sensore porta
	MicronConfig > KK2 > Parametri > Interlocks > Device = [inserire KK1]					
	MicronConfig > KK2 > Parametri > Interlocks > Door2Aldevice = [inserire KX_emergenza]			
	MicronConfig > KK2 > Parametri > Interlocks > Door2Alout = [inserire out emergenza, es.1]		
	MicronConfig > KK2 > Parametri > Interlocks > Door2tout = [inserire timeout, es. 20sec] 		
	MicronConfig > KK2 > Parametri > Interlocks > Mode = 1-Bussola standard, doppia porta automatica	
	MicronConfig > KK2 > Parametri > Interlocks > ResetDevice = [inserire KX_emergenza]			
	MicronConfig > KK2 > Parametri > Interlocks > ResetIn = [inserire ingresso reset, es.2]			
	MicronConfig > KK2 > Parametri > Stamping > WaitOpen = Abilitato					
	*** La serratura abbinata al KK2 deve essere dotata di sensore porta

Gestione aree con porte interbloccate:
(ovvero, in un'area con pi� porte solo una alla volta pu� essere aperta)

	Funzionamento:
	(Situazione pi� semplice possibile: area singola accessibile da due porte, KK1 e KK2)
	- Se la porta relativa al primo lettore (KK1) � aperta, la seconda � bloccata
	- Se la porta relativa al secondo lettore (KK2) � aperta, la prima � bloccata

		-------|   KK1   |-------
		|			|
		|	AREA 1		|
		|			|
		-------|   KK2   |-------	

	Configurazione:
	- MicronConfig > KK1 > Parametri > Interlocks > Area1st = [codice prima area, es.1]		% Prima area da controllare
	- MicronConfig > KK1 > Parametri > Interlocks > Area2nd = [codice seconda area, es.0]		% Seconda area da controllare (se nessuna, mettere 0)
	- MicronConfig > KK1 > Parametri > Interlocks > Mode = 2-Aree controllate
	- MicronConfig > KK1 > Parametri > Stamping > WaitOpen = Abilitato
	*** La serratura abbinata al KK1 deve essere dotata di sensore porta
	- MicronConfig > KK2 > Parametri > Interlocks > Area1st = [codice prima area, es.1]		% Prima area da controllare
	- MicronConfig > KK2 > Parametri > Interlocks > Area2nd = [codice seconda area, es.0]		% Seconda area da controllare (se nessuna, mettere 0)
	- MicronConfig > KK2 > Parametri > Interlocks > Mode = 2-Aree controllate
	- MicronConfig > KK2 > Parametri > Stamping > WaitOpen = Abilitato
	*** La serratura abbinata al KK2 deve essere dotata di sensore porta

	Configurare pi� aree:

			-------|    1    |-------		
			|			|
			|	AREA 1		|
			|			|
	-----------------------|    2    |-------
	|		|			|
	|   AREA 4	3	AREA 2		|
	|		|			|	
	-----------------------|    4    |-------
	|		|			|
	|   AREA 5	5	AREA 3		|
	|		|			|	
	-----------------------------------------

			Varco 1: Area1st = 1, Area2nd = 0
			Varco 2: Area1st = 1, Area2nd = 2
			Varco 3: Area1st = 2, Area2nd = 4
			Varco 4: Area1st = 2, Area2nd = 3
			Varco 5: Area1st = 3, Area2nd = 5


# CRITTOGRAFIA
======================================================================

A.E.S. (Advanced Encryption Standard)
-----------------------------------------------------------------
� un algoritmo di cifratura a blocchi sviluppato nel 1998 e scelto come standard dalla National Institute of Standards and Technology (NIST).
Elementi:
	Chiave:
	S-Box (Substitution Box): matrici n x m che ricevono m bit di ingresso e li trasformano in n bit di uscita, secondo tabelle di trasformazione fisse o dinamiche
Propriet�:	
	Gestisce blocchi a dimensione fissa (128 bit) con chiavi a dimensione fissa (128, 192 o 256 bit)
	Opera usando matrici di 4x4 byte ("States")

1) "AddRoundKey": combina la chiave di sessione (ottenuta dal 'Key Scheduler', che espande una chiave primaria corta in un certo numero di chiavi di ciclo differenti) con lo State ottenuto dai passaggi precedenti
2) "SubBytes": ogni byte della matrice viene modificato tramite una S-Box a 8 bit con particolari propriet� algebriche
3) "ShiftRows": sposta le righe della matrice di un parametro dipendente dal numero di riga, in modo che l'ultima colonna formi la diagonale della matrice in uscita
4) "MixColumns": prende i quattro elementi di ogni colonna x_i e li inserisce in una trasformazione lineare invertibile, moltiplicandola per un polinomio fisso c(x_i); questo ottiene il nuovo State.




# COMMESSE SVILUPPI
======================================================================

CO: commessa

ARP: richiesta preliminare (raccolta necessit�)
AP: analisi preliminare
CN: Conferma d'ordine
VR: versione rilasciata
VL: validazione

MT: Manuale Tecnico
NT: Nota tecnica

Database: Commesse.mdb

SELECT TOP 500 `Data_ini` AS DataInizio
		,`Cod_comm` AS CodiceCommessa
		,`Cod_master` AS Suite
		,`Annullato` AS Annullato
		,`Cod_cliente` AS CodiceCliente
		,`Rag_soc` AS RagioneSocialeCliente
		,`gg_prev` AS GiorniPrevisti
		,`gg_rim` AS GiorniRimasti
		,`Data_prev` AS DataRilascioPrevista
		,`Data_ril` AS DataRilascio
		,`Data_cons` AS DataConsegna
		,`Tipo_progetto` AS TipoProgetto
		,`Breve_Descrizione` AS Descrizione
		,`Dettaglio` AS Descrizione2
		,`RifComm` AS RiferimentoCommerciale
		,`RifInstall` AS RiferimentoInstallatore
		,`RifProgr` AS RiferimentoSviluppatore
		,`Note` AS Descrizione3
	FROM `Commesse`
	ORDER BY `Data_prev` DESC


# BIELLE
======================================================================

Descrizione			Commessa (Sotto-commessa) 	Voce 		Attivit�

Assistenza generica		*SOFTWARE			COHOSW		HOTL
Permesso			*SOFTWARE			COFERI		FERI
Fiera				*SOFTWARE			FIERE		FIER
Riunione			<cliente>			CORIUN		RIUN
Malattia			*SOFTWARE			COMALA
Documentazione varia		*SOFTWARE			DOCUM
Preparazione materiale		<cliente>			ISSW1		PRMA
Preparazione materiale		*SOFTWARE			COPRMA	




# MICRONWEBSERVICE
======================================================================
Installazione del MicronWebService:
	- Installare MicronWebService: su un'installazione gi� esistente, basta aggiungere il modulo nel setup della MRT Application Suite
		- Ovviamente MWS deve essere tra i moduli che fanno parte di MRT.LIC
		- I parametri devono essere stati creati su MicronConfig (MicronWebService-001)
		- Le stringhe di connessione devono essere aggiornate (MicronStart)
	- MPW\MicronWebService > Web.config > impostare:
		<directoryBrowse enabled="true" />	% per poter esplorare le folder da browser
	- IIS > Aggiungere l'applicazione MRTWS all'Application Pool del controllo accessi
	- Su browser, inserire l'URL http://<indirizzo_server>/MRTWS > [Selezionare MRTUSERS per vedere la lista dei comandi]
Per abilitare la Basic Authentication: modificare C:\Windows\System32\inetsrv\config\applicationHost.config


Utenza di utilizzo del WebService:
NB: L'utenza di default che utilizza MicronWebService � admin, ma � necessario che su Micronpass Web questa utenza sia legata ad un dipendente; in caso contrario, 
	- Micronpass Web > Crea dipendente "WBSUSER"
	- Micronpass Web > Crea utente "wbsuser" con autorizzazioni e organigramma completi, da associare al dipendente WBSUSER

Test:
	- MPW\MicronWebServiceTest > TestWSWin.exe
	- Testare il login:
		- Functions > Login > Username: <utente associato ad un dipendente>
		- Functions > Login > Password: <password dell'utente suddetto>
		- Functions > Login > Authentication mode: Anonymous authentication
		- Functions > Login > Execute!
		- Esito: "Login result 0" (Login done successfully)
			(*) Dipendente di riferimento mancante: significa che all'utente con cui ci si sta loggando non � associato un dipendente
	- Testare i comandi di varco:
		- Categories > Commands
		- Functions > ExecTerminalCommand > Terminal: [inserire codice terminale, uno qualsiasi sotto il varco di cui si sta eseguendo il comando di varco, 8 cifre]
		- Functions > ExecTerminalCommand > Command: [inserire codice comando, 4 cifre]
		- Functions > ExecTerminalCommand > CommandType: GateCommand
		- Functions > ExecTerminalCommand > CommandMode: Impulse
		- Functions > ExecTerminalCommand > Duration: [inserire durata dell'impulso]
		- Functions > ExecTerminalCommand > Execute



NOTE MAPPATURA BIT IMPIANTO PER DESIGO

La variabile utilizzata da Desigo � un longint mappata a Bit con i seguenti significati: il significato dei singoli ingressi � legato alla configurazione dei varchi che possono avere funzionalit� differenti uno dall'altro.

	Bit	Mask Dec	Mask Hex	Descrizione
	0	1		1		Ingresso1 - 1=Allarme
	1	2		2		Ingresso2
	2	4		4		Ingresso3
	3	8		8		Ingresso4
	4	16		10		Ingresso5
	5	32		20		Ingresso6
	6	64		40		Ingresso7
	7	128		80		Ingresso8
	8	256		100		Ingresso9
	9	512		200		Ingresso10
	10	1024		400		Ingresso11
	11	2048		800		Ingresso12
	12	4096		1000		Ingresso13
	13	8192		2000		Ingresso14
	14	16384		4000		Ingresso15
	15	32768		8000		Ingresso16
	16	65536		10000		1=Offline,0=Online
	17	131072		20000		1=Emergenza
	18	262144		40000		1=NonAllineato
	19	524288		80000		1=GuastoTestine
	20	1048576		100000		-
	21	2097152		200000		-
	22	4194304		400000		-
	23	8388608		800000		-



# MRTAPP (TIMBRATURA VIRTUALE, BADGE VIRTUALE, RECEPTION)
======================================================================

PREREQUISITI RETE
Regole firewall server:
	Porta TCP 443 (comunicazione SSL su protocollo HTTPS) 
	Porta TCP 80 (comunicazione su protocollo HTTP) in ingresso
	

## TIMBRATURA VIRTUALE

Documentazione: MO_MRT_APP TVirt.docx

Questo nasce dalla personalizzazione per Estracom.
L�obiettivo del progetto � quello di implementare nel sistema MRT la funzionalit� di registrazione delle timbrature eseguite dai dipendenti/collaboratori che operano fuori sede. Le timbratura saranno effettuate con  device mobile muniti di una apposita app Microntel.
L�infrastruttura prevede l�implementazione di un nuovo web service disegnato per fornire i servizi necessari al  funzionamento delle app. Si chiama MicronAppWebService.

Il nome del servizio � MRTApp (es. http://localhost:8080/Api/MRTApp/AppReg) e VirtStamp

Il WebService � articolato in pi� servizi che saranno invocati in funzione del contesto:
- "AppReg" espone i metodi per eseguire la registrazione del device.
- "VirtStamp" espone i metodi per eseguire la funzione di timbratura virtuale e alcune funzioni accessorie.


APPREG

Lo scopo di questa procedura � quello di abbinare un numero di telefono (e quindi una matricola) ad un dispositivo. Soltanto dopo la procedura di registrazione � possibile utilizzare il dispositivo per eseguire le timbrature di presenza.

1. L�utente dovr� assicurarsi presso l�ufficio HR che il proprio numero di telefono sia stato registrato correttamente nelle anagrafiche del sistema MRT. L�ufficio HR dovr� inoltre fornire l�indirizzo del WS per la registrazione e il codice di matricola.
2. L�utente scarica la App Microntel dallo store Apple, Android o Microsoft.
3. L�utente avvia la app, inserisce l�indirizzo del WS e le informazioni della matricola.
4. La app inoltra la richiesta di registrazione al WS e si pone in attesa di un SMS contenente il PIN di abilitazione.
5. La app non appena riceve lo SMS di conferma inoltra la richiesta di verifica PIN al WS. Se i dati sono corretti, si conclude la procedura di registrazione, il dispositivo � pronto per eseguire la registrazione delle timbrature.

VIRTSTAMP

Funzione per la trasmissione di timbrature eseguite da un sistema esterno. 

Funzione principale: 
* Timbratura virtuale: E� la funzione per eseguire la registrazione della timbratura da device mobile. Non � previsto l�accumulo di timbrature in locale. Condizione necessaria per la registrazione di una timbratura � che il WS sia raggiungibile. Il risultato dell�esecuzione della funzione � la scrittura di una timbratura nella tabella T116AccBuffer.

Funzioni accessorie:
* la lettura della tabella delle causali di timbratura: Metodo per la lettura della tabella delle causali di timbratura. Questo metodo sar� invocato dalla app presumibilmente su comando dell�utente.
* il download del logo aziendale da visualizzare sulla schermata della app: 
* una funzione da utilizzare prima della registrazione della timbratura per leggere l�orologio del server: Metodo per la lettura dell�orario UTC del server. L�orario della timbratura della funzione VirtualStamping() sar� determinato non utilizzando l�orologio del device, ma sulla base dell�orologio del server. L�ora del device potrebbe essere facilmente manipolata dall�utente. Questo metodo sar� invocato dalla app prima di eseguire la registrazione della timbratura.

ALCUNI APPUNTI:

La timbratura virtuale, gi� sviluppata da Microntel e gi� collaudata, � disponibile su Google Play e iOS Store.
� strettamente legata alla presenza di un'installazione di MPW, senza il quale non pu� funzionare.
Ovviamente l'app NON pu� funzionare offline: prerequisito � che il webservice sia raggiungibile! Ci DEVE essere copertura internet.
1-Al primo lancio, bisogna impostare l'IP del Webservice con il quale funziona
2-La prima fase � di Autenticazione (o Registrazione): l'app chiede matricola e azienda dell'utente;
	Il webservice fa il check dell'anagrafica dell'utente, in particolare il controllo del campo "N. di telefono"
	Se il campo "N. di telefono" c'�, arriva l'SMS con il token
	Se il campo "N. di telefono" non c'�, l'SMS non viene neanche inviato (questo per prevenire eventuali 'intrusi' che conoscono il mio codice matricola)
3-Alla partenza della app, viene richiesto il codice PIN o la matricola, e viene effettuata la chiamata al webservice
	L'app scarica da MRT l'elenco delle causali e lo visualizza dalla maschera principale
	L'app sincronizza la data ora del server (e NON del telefono, che sarebbe facilmente manipolabile), correggendo anche il fuso orario
	L'app scarica l'eventuale logo dell'azienda
4-La timbratura, etichettata con causale e verso, viene inviata dal webservice e scritta nella T116/137 con le coordinate geografiche (solo versioni >7.3.0) (purch� la GPS location sia attiva nello smartphone)
L'IIS si basa quindi su un servizio di invio SMS (e.g. Skebby) cui iscriversi con una determinata autenticazione a ogni nuova installazione.

DEMO:

	URL:		http://79.11.21.211:8081/mrtapp75/api
	Matricola:	00000002 (Giuseppe Migliasso)
			00000003 (Edoardo Sanna)
			00000004 (Fabio Carbone)
			00000005 (Daniele Carnevale)
			00000006 (Luca Airoldi)
			00000007 (Massimilano Raimondi)
	Tipo:		Dipendente
	Azienda:	MIC

	URL Micronpass di riferimento: http://79.11.21.211:8183/mpassw


## BADGE VIRTUALE

Questa applicazione nasce dalla personalizzazione SIEMENS per ANGELINI
Documentazione: MO_MRT_APP BVirt.docx

NOTA: account su Play Store microntelapp@gmail.com, controllarlo ogni tanto per notifiche

HARDWARE NECESSARIO:
* MRT >= v.7.4.0 (il server DEVE essere raggiungibile dalla rete smartphone)
	* Nella fattispecie Micronconfig >= 7.4.13
* Licenza MicronWebService (solo perch� al momento, a livello di licenza, non c'� distinzione tra MicronWebService e MicronAppWebService)
* MXP450 pacchetto > 1.1.3
* Kleis Cortex (MH11G082.bin) contenente schedino Bluetooth
* Smartphone Android/iOS con Bluetooth >=4.0 attivo

MICRONCONFIG (STANDARD PER ARM):
v. sezione"ARM"

PREREQUISITI PER BLUETOOTH	

	SKEBBY
	Skebby � il servizio di invio SMS da Web che MicronAppWebService utilizza per la registrazione di una nuova utenza Mobile (la fase di prima autenticazione � fondamentale a livello di sicurezza: permette infatti di stabilire un legame univoco tra l'anagrafica del Micronpass Web e il dispositivo cellulare su cui � stata installata l'applicazione Badge Virtuale)
		- Andare all'URL www.skebby.it > Prezzi > SMS Classic > [acquistare pacchetto a seconda della dimensione, richiede registrazione e invio mail di conferma]
		- La conferma tramite mail dell'utenza Skebby fornisce un ID Skebby che andr� inserito tra i parametri del MicronAppWebService
		- Tenere traccia dell'utente e password utilizzante il pacchetto Skebby, saranno da inserire come parametri del MicronAppWebService
	
	IMPOSTAZIONI DI RETE
	� condizione vincolante che lo smartphone abbia il traffico dati o il wifi attivo e che possa comunicare col il server ospitante il webservice
		- Il server DEVE uscire su internet (altrimenti non c'� modo per l'AppWebService di comunicare con Skebby)
		- Bisogna gestire sull'infrastruttura (Firewall) del cliente un NAT in ingresso e uscita dall'IP pubblico porta 8080 verso l'indirizzo IP statico del server dove abbiamo installato MicronAppWebService
		- In alternativa, si pu� usare la rete Wifi aziendale per consentire all'applicazione di sfruttare la rete intranet
	In pratica:
	- Il dispositivo portatile deve raggiungere il server, tramite Intranet o Internet
	- Il server deve comunque poter uscire su Internet per poter effettuare la chiamata a www.skebby.it (dalla 7.5.0 � implementato il protocollo HTTPS:443, pi� sicuro di HTTP:80)

ATTIVARE PERSONALIZZAZIONE BLUETOOTH
L'app "Badge Virtuale", contrariamente all'app "Timbratura Virtuale", permette di effettuare una timbratura con l'uso delle funzioni bluetooth di uno smartphone.
Tutti i dispositivi Bluetooth fanno 'advertising', ovvero emettono un segnale broadcast a disposizione per tutti i dispositivi che facciano scanning (es. uno Smartphone con "BLE scanner").
I Kleis Cortex con tecnologia Bluetooth abilitata (e quindi contenenti degli schedini bluetooth) fanno advertising del proprio codice terminale, cos� com'� configurato su Micronconfig.
L'app BadgeVirtuale comunica tramite webservice, scaricandosi le descrizioni dei varchi corrispondenti ai codici terminali letti: ecco perch� da app � possibile vedere i nomi dei varchi.

	TEST TRAMITE WPFCLIENT
	Wpfclient.exe � un software client per testare il corretto funzionamento dell'app; in pratica "emula" una chiamata all'app WebService, inviando o richiedendo funzioni come DataOra, Timbratura, DownloadLogo e cos� via.
	In pratica � una versione 'Noservice' dell'app. Un test sul wpfclient permette di capire se la comunicazione col webservice sia attiva.
	- ClientWSApp > Wpfclient.exe.config > [alla voce WebApiBaseAddress, inserire l'URL della MRTAppWS cos� come si vede nell'IIS]
	- ClientWSApp > Wpfclient.exe.config > [impostare ]
	logo
	- Un lancio (ad. es. richiedere Logo, anche con errore "Errore Token") del client WpfClient genera i parametri relativi alla versione corrente nel Micronconfig

	MICRONCONFIG
	- Micronconfig > Tabelle > Tecnologie testine > 20-Bluetooth: SEDE, 20, 0, 0, 0, 0, 1, 20, ChipCard		% Inserimento della tecnologia Bluetooth
	- Micronconfig > Kleis1/2 > Parametri > Reader > Nx = 20-Bluetooth						% Attivazione della tecnologia Bluetooth
	- Micronconfig > Kleis1/2 > Parametri > GPParam01 = 7								% Potenza Bluetooth dei Kleis al massimo (SPOSTATO nei parametri Bluetooth)
	- Micronconfig > Parametri > micronAppWebService > Minuti di validit� del token QRCode = 1			% Un minuto di validit� per il QR Code generato dall'app
	- Micronconfig > Parametri > micronAppWebService > N. IDX badge Bluetooth = 4					% Utilizzo ID4 della T25COMBADGE, ovvero ChipCard (appare dopo il primo avvio del Wpfclient, v.sotto)
	- Micronconfig > Parametri > micronAppWebService > Terminale = 00000001						% Codice terminale fittizio (e.g.00000001)
	- Micronconfig > Parametri > micronAppWebService > Nome del file logo app = images/<nomefile>			% percorso locale del logo da scaricare nell'app
	- Micronconfig > Parametri > micronAppWebService > SMS Server = <URL skebby>					% In realt� � inserito di default nel file web.config, controllare (comunque � http://api.skebby.it/API/v1.0/REST/, in alternativa https)
	- Micronconfig > Parametri > micronAppWebService > Tipo SMS Server = 1						% Tipo di SMS Server (per ora fisso a =1)
	- Micronconfig > Parametri > micronAppWebService > ID SMS Server = <ID utenza Skebby>				% Codice utente Skebby
	- Micronconfig > Parametri > micronAppWebService > Utente SMS Server = <username utenza Skebby>			% Nome utente dell'utenza Skebby per l'invio SMS (username utenza Microntel: Microntel@Web0020)
	- Micronconfig > Parametri > micronAppWebService > Password SMS Server = <password utenza Skebby>		% Password dell'utenza Skebby per l'invio SMS (password utenza Microntel: CHRGRG003)
	- Micronconfig > Parametri > micronAppWebService > ID Trasmettitore per SMS = Microntel				% Nome fittizio di mittente SMS (e.g. Microntel) Attenzione: non usare punti!
	- Micronconfig > Parametri > micronAppWebService > SMS Sending Telephone number = <>				% Numero di telefono mittente (si pu� lasciare vuoto)

	TEST SU SMARTPHONE
	- Da server, MPW > MicronAppWebService > web.config > parametro "browse directories = true" > adesso si pu� fare browse di mrtappws da iis
	- Su Smartphone, aprire un browser e inserire l'URL della MRTAppWS: si dovrebbero vedere le diverse folder dell'applicazione

	REGISTRAZIONE ANAGRAFICA:
	- MicronpassWeb > Dipendenti > Modifica > inserire campo "Tel.Cellulare" (servir� all'invio SMS)
	- MicronpassWeb > Dipendenti > Abilitazione > [abilitare alle porte da utilizzare]
	- MicronpassWeb > Dipendenti > Badge > [cercare badge dell'anagrafica] > Chip Card > [inserire ID Badge]

	PRIMA AUTENTICAZIONE SU SMARTPHONE:
	- Installa app "BadgeVirtuale"
		- da Play Store, cercare "Badge Virtuale"
		- da Apple Store, cercare "Microntel"
		- da PC, tramite APKinstaller, si pu� installare manualmente il file .apk)
	- A installazione completata, eseguire app "BadgeVirtuale"
	- Inserire i dati di autenticazione:
		URL: http://<URL dell'APPWS>				% Sede del webservice (IP pubblico del server) (e.g. test microntel = 79.11.21.211:8080/MRTApp_Test/api)
		Codice matricola: <matricola completa>			% Matricola (deve corrispondere al n. di telefono inserito in anagrafico in Mpassw)
		Tipo matricola: Dipendente				% Tipo matricola, default a "Dipendente"
		Codice azienda <azienda completa>			% Codice azienda
	- Arriva un SMS con codice di verifica: l'app aperta pu� leggerne direttamente il contenuto, altrimenti inserire PIN e cliccare su Conferma

		(*) Diagnostica di comunicazione: 
			- Aprire un browser su smartphone e cercare http://<server> per vedere la pagina IIS; in secondo luogo cercare su browser http://<server>/mrtappws per vedere la versione esplorabile della directory virtuale
		(*) In questa fase, l'app preleva da webservice i dati anagrafici (nome, cognome, badge, ecc.) riferiti all'anagrafica

	SUCCESSIVE REGISTRAZIONI
	Bisogna ri-registrarsi sull'app tutte le volte che:
	- Si aggiorna il sistema operativo
	- Sono state fatte modifiche sostanziali nelle cartelle dell'MRTAppWS (es. � cambiato il file png del logo aziendale)
	- Sono state fatte modifiche ai parametri dell'app (Micronconfig > Parametri > MicronAppWebService)

UTILIZZO STANDARD:
- Prerequisiti:
	L'app Badge Virtuale va aperta e portata in primo piano: non � ancora prevista l'esecuzione in background
		Samsung: Foreground only per questioni di dispositivo
		Android: non � implementato iBeacon nella testina di lettura (*iBeacon = possibilit� di effettuare una scansione bluetooth anche ad applicazione chiusa)
			(al massimo si riceve una notifica dell'essere nelle vicinanze di un dispositivo bluetooth, ma occorrerebbe aprire l'app e farla funzionare)
		iPhone: non � implementato iBeacon nella testina di lettura
			(tra l'altro iPhone freezza l'applicazione dopo 10 secondi, se questa � in background)
		Ovviamente al momento l'avvio di una telefonata mette in secondo piano l'applicazione!
	Antenna Bluetooth accesa
		Tempi Android: 3 sec (tempi fisiologici di Android, dove il bluetooth fa cagare)
		Tempi iOS: 1.5 sec
			La maggior parte del tempo � portata via dalla connessione tra dispositivi
- Tramite comunicazione con Webservice, appare nella pagina principale:
	- il "Badge Virtuale" contenente il logo dell'azienda e i dati anagrafici della matricola associata (Azienda, Matricola, Nome, Cognome, ID Badge)
	- in prossimit� dei dispositivi di controllo accessi abilitati all'uso del Bluetooth, compaiono automaticamente le relative descrizioni del varco e l'intensit� del segnale recepito
- Selezionare il varco a cui si desidera accedere
- Cliccare su APRI
	- Preferenze:
		- Ordinare i terminali per potenza segnale: s�/no (default a No: in tal caso, lista per descrizione)
		- Segnale limite inferiore [da -100dB a 0dB]: esclude dallo scanning tutti i dispositivi il cui segnale sta al di sotto di questa intensit�
		- Selezione automatica del terminale: s�/no (default a No)
			- s� = seleziona automaticamente il lettore dalla lista varchi se il segnale va al di sopra del valore impostato (settare a -35dB)
				(*) Questo permette di avvicinare lo smartphone al lettore ed utilizzarlo per riconoscere la porta
				(*) Il valore -35dB � equivalente all'appiccicare fisicamente lo smartphone sul lettore
	- Nome, Cognome
	- Badge ID
	- Azienda Interna
	(*) Se l'app non riesce a collegarsi al webservice, riesce comunque a tenersi in locale gli ultimi dati ricevuti sulla lista dei varchi - ed � una lista che si aggiorna automaticamente, aggiungendo dispositivi di volta in volta al database locale
- In prossimit� dei dispositivi di controllo accessi
- Senza automatismi configurati, per aprire una porta, basta selezionare il varco e cliccare su "Apri": pu� volerci qualche secondo perch� l'effettiva apertura avvenga, dipende dallo smartphone


DIAGNOSTICA:
C:\MPW\MicronAPPWS\LOG

	app.log		
	Registra tutti gli eventi che avvengono sull'app
	
		(*) Possibili errori
		Errore non gestito Module BiTech.Core.dll SkebbySMSManager.SendSMS at offset 80 in file  line 0 column 0
		Errore invio SMS Pin. Module BiTech.Core.dll MRTAppRegContext.Registration at offset 1642 in file  line 0 column 0
		Errore token non valido. Module BiTech.Core.dll MRTVirtStampContext.GetUTCDateTime at offset 262 in file  line 0 column 0
		
		(*) Una registrazione andata in porto viene mostrata nel seguente modo su log, dall'inizio alla fine:
			02-10-2017 11:41:03:099 Registration Inizio registrazione app:2 Matricola:<matricola> IntEmployee <AziendaInterna>.
			02-10-2017 11:41:03:115 Registration App gi� registrata in precedenza, nuova registrazione.
			02-10-2017 11:41:03:115 Registration Lettura parametri SMS
			02-10-2017 11:41:03:115 Registration Invio SMS
			02-10-2017 11:41:03:693 Registration Inviato SMS Microntel PIN=[<pin>] al <NumeroCellulare_senza_simbolo_plus>
			02-10-2017 11:41:03:693 Registration Registrazione completata con successo.
			02-10-2017 11:42:06:084 PinValidation Inizio validazione PIN app:2 Matricola:<matricola> IntEmployee <AziendaInterna>.
			02-10-2017 11:42:06:099 PinValidation Validazione PIN completata con successo.	
			02-10-2017 11:42:06:193 GetRefInfo Lettura informazioni matricola.
			02-10-2017 11:42:06:209 GetRefInfo Lettura informazioni matricola eseguito con successo.
			02-10-2017 11:42:06:677 DownloadLogo Download logo.
			02-10-2017 11:42:06:677 DownloadLogo Download logo eseguito con successo.
			02-10-2017 11:42:06:849 GetGateTable Lettura informazioni varchi e terminali Bluetooth.
			02-10-2017 11:42:06:880 GetGateTable Lettura informazioni varchi e terminali Bluetooth matricola eseguita con successo.

	webapi.log	
	Espresso nella forma "Method + Request + Response"


## App RECEPTION

Installazione:
	Prerequisiti:
	- Sistema operativo iOS/Android

Prima configurazione dell'app:
	- Al primo avvio, in assenza di configurazione, viene mostrata la schermata Impostazioni
	- Settings > Settings password		% Password per accedere alla pagina Impostazioni
	- Settings > Service address		% Indirizzo completo dell'appwebservice
	- Settings > Username			% Nome utente con cui l'app si autentica al webservice
	- Settings > Password			% Password con cui l'app si autentica al webservice
	- Settings > VisitType			% Chiave del tipo visita
	- Settings > Standby delay [s]	% Timeout di inattività: scaduto il tempo, viene visualizzato il sito web specificato dopo
	- Settings > Info link 			% Sito web da visualizzare scaduto il timeout di inattività
	- Settings > Partner			% Microntel, Iseo, ADP, Siemens, custom
		* Nel caso di 'custom', � possibile:
			- Scegliere il logo dai file salvati su tablet
			- Impostare i colori di default (in HEX): background view, text buttons, background buttons
	- Settings > Privacy link		% Link per documento privacy
	- Settings > Languages 			% Possibilit� di impostare le lingue visibili
	- Settings > Required fields		% Possibilit� di scegliere quali sono i campi obbligatori nel form
	- Per rientrare nelle Impostazioni pi� avanti, usare i seguenti gesti (entro 5 secondi):
		Swipe destra
		Swipe sinistra
		Swipe verso l'alto
		Swipe verso il basso

Utilizzo dell'app:
L'app consente di registrare i visitatori; in caso di inattivit� prolungata, mostra una pagina web che funge da screensaver.
	- Form di inserimento dei dati (TUTTI i dati sono obbligatori):
		- Scelta della lingua (Inglese, Francese, Tedesco)
		- Nome, Cognome [libero]
		- Data di nascita (con controllo di validit�)
		- Luogo di nascita [libero]
		- Tipo di documento (Carta d'identit�, Patente, Passaporto, altro)
		- Numero del documento [libero]
		- Societ� [libero]
		- Dipendente di riferimento [libero]
		- Motivo della visita [libero]
	- Conferma della presa visione privacy e link verso il documento Normativa
	- Pulsante "Pulisci campi" per resettare il contenuto
	- Per evitare che l'app si chiuda o qualcuno inavvertitamente usi i gesti di manutenzione:
		- tablet > Impostazioni > Generali > Disabilitare "Gesti"
		- Centro di controllo > Disabilitare "Accesso delle app"
	- Eventuali errori:
		"Server non raggiungibile" (attivare il WiFi o controllare il WebService sul server)
		"Errore configurazione webservice" (credenziali di autenticazione)
		"Si � verificata un'anomalia imprevista" (utente non loggato, utente non autorizzato, eccezione non prevista, errore di versione db, licenza non valida)
	
Utilizzo con Micronpass Web:
[integrato con la gestione prenotazioni]



# FUNZIONI NFC 
======================================================================
Questa funzione nasce da una personalizzazione SIEMENS per SAMSUNG

SUNTO: In combinazione con un�app appositamente realizzata (iOS, Android), � stata resa possibile la timbratura da smartphone o da smartwatch; per il primo utilizzo, l�app richiede l�autenticazione a MicronpassWeb tramite MicronWebService per certificare l�utente (ad esempio, via WiFi aziendale) tramite utilizzo di cognome-nome-datanascita ed eventualmente alla lettura del badge Mifare associato su smartphone stesso; successivamente l�app � autonoma e pu� generare il �token� per le testine di lettura Kleis, associandolo direttamente alla matricola del dipendente e al suo profilo d�accesso: il token, salvato sia nello smartphone sia nel database di controllo accessi, � cifrato con chiave per non essere letto ed interpretato, inoltre � munito di timestamp per renderlo inutilizzabile dopo un certo periodo.

Documentazione di riferimento:
AP_Samsung-001.pdf

Come si attiva:
	- L'MXP che gestisce il KK deve avere un determinato firmware (3.3X/2 - Samsung-001)
	- Il KK stesso deve avere un determinato firmware (MH0RCB19 per Kleis con display; MH0RCA19 per Kleis con LED)
	- MicronConfig > Tecnologie Testine > 13-Mifare(T1): <Sede>,20,0,0,0,0,1,10,TagFull
		(*) Il dispositivo 13 in realt� non serve, ma bisogna inserirlo perch� il MicronService invii ai terminali i codici TagFull
	- MicronConfig > Tecnologie Testine > 15-ISO14443B(T1): <Sede>,10,0,0,0,0,1,10,ChipCard
		(*) Il dispositivo 15 abilita sia il NFC sia il Mifare Classic
	- Funziona sia con tessera, sia con Smartphone, sia con Smartwatch

Come si usa:
	- L'applicazione "Microntel" (NON timbratura virtuale) va scaricata da Store e installata
	- Al primo utilizzo, si chiede di registrarsi nel servizio: lo smartphone � abilitato se correttamente registrato sul Micronpass Web (il webservice si occupa di fare da tramite)
	- Loggandosi con specifiche credenziali, � possibile utilizzare lo smartphone come un badge



# LETTURA QRCODE
======================================================================

� CONFIGURAZIONE HARDWARE
A prescindere dal tipo di utilizzo, il lettore QR Code va configurato per leggere i codici Microntel usando una sequenza di codici di configurazione.
Documentazione di riferimento: manuale 'Magellan800.pdf'

1) Connettere lo scanner Magellan all'host. Sono disponibili due tipi di connessioni:
	a. Seriale RS-232 (da effettuare a scanner spento): lo scanner � fornito con cavo RS-232 e con alimentatore AC separato
		(se l'host non � dotato di porta seriale, servir� un adattatore seriale-USB con relativi driver)
	b. USB-COM: lo scanner � fornito con cavo USB
	*** In entrambi i casi, al momento della connessione il dispositivo deve apparire con la sua virtual COM port nella gestione Dispositivi
2) Lo scanner � fornito con configurazione di default (barcode "Standard Product Default Settings" per ripristinare la configurazione di fabbrica)
3) Una volta selezionata l'interfaccia, configurare lo scanner affinch� legga i QR code Microntel. La configurazione di base �:
	0) [opzionale] Good Read Beep Volume = Low
	1) Cell Phone Mode = Auto
	2) Cell Phone Mode Sensitivity = Medium Sensitivity
	3) Interface Selection = RS-232 Standard OR USB-COM
	4) Label ID Transmission = Disable
	5) Disable PDF 417
	6) Enable QR Code

Segnalazioni LED verde:
	- Flash verde acceso: scanner pronto dopo lo startup
	- Flash verde acceso: barcode/QRcode letto e decodificato correttamente
	- Verde opaco costante: scanner pronto
	- Flash verde costante: sleep mode
	- Flash verde a 1Hz: programmation mode
Segnalazioni acustiche (� possibile attivare/disattivare l'audio, modificare frequenza/durata/volume)
	- Beep singolo: power on
	- Beep singolo: lettura corretta
	- Errori:
		1 beep / flash LED: errore configurazione
		2 beep / flash LED: errore interfaccia
		6 beep / flash LED: system controller
		12 beep / flash LED: imager system
		13 beep / flash LED: software ID failure

� TIMBRATURA CON QR CODE
Questa funzione semplicemente integra due lettori di QR Code su apposite porte seriali montate su MXP450
SUNTO: Timbratura tramite codice QR creato da app mobile personalizzata; il codice QR viene generato dall�app stessa con scadenza automatica parametrabile, contiene informazioni riguardanti la data/ora di timbratura, rendendosi di fatto del tutto simile all�uso di un badge Mifare; il lettore QR �Magellan� va opportunamente inizializzato e configurato a riconoscere esclusivamente i codici QR creati dall�applicazione in questione; la timbratura effettiva viene poi eseguita tramite uso di smartphone

	Prerequisiti software:
		Packages >= 1.1.6
		Micronconfig >= 7.4.5

	Configurazione lettore QR code:

		V. Sequenza di configurazione lettore
		Al termine della sequenza di configurazione, il Magellan 'bippa' a fronte di qualsiasi QR code

	Configurazione software:

		- Micronconfig > Tabelle > Tecnologie Testine > aggiungere le seguenti tecnologie: 
			Lettore di entrata:	24-RS232 QRCODE1 EXIT: 20,0,0,0,0,1,20,Chip Card
			Lettore di uscita:	25-RS232 QRCODE2 EXIT: 20,0,0,0,0,1,20,Chip Card	
		- Opzionale: impostare la crittografia AES:
			- Micronconfig > Tabelle > Parametri generali > Advanced Security > Encryption password QRcode AES: 00112233445566778899AABBCCDDEEFF
			- Micronconfig > Terminale con dispositivi > Extra Parameters > Edit Extra > Nuovo
				Parameter:	QRcodeAES
				Value:		00112233445566778899AABBCCDDEEFF
		- Micronconfig > Terminale con dispositivi > Locbus > [creare un canale locbus su /dev/ttyS1]
		- Micronconfig > Kleis > Parameters > Reader > N1 = [tecnologia di lettura del lettore]
		- Micronconfig > Kleis > Parameters > Reader > 
			Lettore di entrata:	N2 = 24-RS232 QRCODE2 ENTRY
			Lettore di uscita:	N2 = 25-RS232 QRCODE2 EXIT
		- Micronconfig > Kleis > Parameters > Reader > Stamping > Direction = 
			Lettore di entrata:	Entry
			Lettore di uscita:	Exit
		- Azzeramento memorie, Setup terminali accessi, Reboot (per ricaricare i parametri generali)
	
	Controllare i parametri dell'app:

		- Micronconfig > Parametri > MicronAppWebSetrvice > Minuti di validit� del token QR code = [a piacere]
		- Micronconfig > Parametri > MicronAppWebService > Bluetooth IDX badge number = 4
		- Micronpass > [dettaglio badge] > Chip Card = [inserire ID badge]

	Prove su lettore:

		- Timbratura accettata: il Kleis di riferimento d� OK oppure LED VERDI (badge abilitato), il servizio scarica la timbratura
		- Timbrature rifiutata per inesistente: il Kleis di riferimento d� NEGATO oppure LED ROSSI (badge non abilitato), il servizio scarica la timbratura
		- Errore lettura: il Kleis di riferimento d� ERRORE LETTURA oppure LED ROSSI (token QR scaduto), il servizio NON scarica la timbratura

	Contenuto di un codice QR:

		I dati inseriti e cifrati nel QR code sono:
			- Timestamp inizio validit� del token AAMMGGhhmmss
			- Numero minuti per la scadenza del token (0=nessuna scadenza)
			- Codice IDX del badge da emulare
			- Flag di abilitazione QR code al controllo di varco (0=disattivo; 1=attivo)
			- Aux1: Causale (opzionale � valido per testine di tipo presenze)
			Carattere separatore dei campi �;� (punto e virgola)
				(*) Esempio:
				Record: 170823123000;1440;99000123450000000000;1;1234
				Chiave AES: 00112233445566778899AABBCCDDEEFF
				Vettore iniziale: 00112233445566778899AABBCCDDEEFF

� QR CODE COME INVITATION CODE (MRTVISITORS)
Questa funzione permette di leggere l'invitation code da un codice QR.
Per una descrizione di che cosa *sia* questo invitation code, vedi la documentazione della procedura MrtVisitors.

	Prerequisiti software:
		Micronpass >= 7.5.0

	Configurazione lettore QR code:

		V. Sequenza di configurazione lettore
		Al termine della sequenza di configurazione, il Magellan 'bippa' a fronte di qualsiasi QR code

	Configurazione server:

		- MicronConfig > Parametri > Micronpass > 141.Abilita l'accesso all'hardware da tutti i browser = TRUE

	Configurazione client:

		- Settare il lettore Magellan seriale per l'utilizzo della COM255
		- Attivare TrayClient >= 1.4.0

	Uso:

		- Micronpass Web > Visitatori > Visualizzazione prenotazioni > Leggi da lettore*
			(filtrando per Invitation Code, tutti gli altri filtri inseriti in Visualizzazione Prenotazioni vengono ignorati)




# BADGES
======================================================================

Famiglia MIFARE (13.56 MHz)
-----------------------------------------------------------------------
Mifare � stato sviluppato nel 1994 da un'azienda austriaca chiamata Micron; era stato appositamente progettato per i trasporti pubblici e il nome � stato scelto appositamente: "Micron Fare CollectioN" (raccolta tariffe Micron), ovvero Mi-Fare. Il chip era considerato molto veloce e in grado di fornire un alto livello di sicurezza richiesto dagli ambienti di controllo accessi e biglietteria dei trasporti pubblici.
La struttura della memoria non � sufficientemente flessibile per la complessit� dei meccanismi odierni, ma al tempo era considerata rivoluzionaria.

E� una tecnologia per transponder RFID a 13,56 MHz di tipo passivo, sviluppata da NXP Semiconductor.
Basata sullo standard ISO/IEC 14443 parte A, � la tecnologia per smart card contactless pi� diffusa al mondo. La distanza tipica di lettura/scrittura � di circa 7-10 cm, a seconda della potenza del segnale emesso dal Controller RFID e dalle dimensioni dell�antenna.
All�interno della famiglia MIFARE sono presenti diversi tipi di transponder:
- MIFARE Ultralight: questo tipo di transponder possiede 512 bits di memoria, senza funzionalit� crittografiche e di sicurezza. La memoria � divisa in 16 pagine da 4 byte ciascuna. Fornisce funzioni di sicurezza base come i bit OTP (One Time Programmable), e funzioni per rendere la memoria Read-only.
- MIFARE Classic: hanno una memoria divisa in settori e blocchi, in cui ogni settore � leggibile/scrivibile tramite password. Possono avere 1Kbyte o 4Kbyte di memoria. Ogni settore � protetto da due diffenti chiavi, A o B. Ogni chiave pu� essere programmata e ad esse possono essere assegnate diverse funzioni come lettura, scrittura, incremento/decremento di blocchi valore. Utilizzano un protocollo proprietario NXP (Crypto-1) per l�autenticazione.
- MIFARE Plus: evoluzione del MIFARE Classic, organizza i dati allo stesso modo, implementando maggiori funzioni di sicurezza e crittografia, utilizzando chiavi AES a 128 bit.
- MIFARE DesFire: basato sul core delle Smart MX, � pre-programmato utilizzando un S.O. general purpose che offre una semplice struttura di file e directory. Utilizza un protocollo compatibile con lo standard ISO/IEC 14443 parte 4 ed implementa funzionalit� di sicurezza evolute utilizzando una crittografia Triple-DES oppure AES, appoggiandosi su un acceleratore crittografico.
- SMART MX: basate su micro-processore e pre-programmate con un S.O. dedicato. Utilizzano un co-processore crittografico per ottimizzare le operazioni di calcolo (TDES, AES, RSA), effettuando le elaborazioni direttamente on board. Possono perci� eseguire operazioni complesse, sicure e veloci, analogamente alle smart card a contatto. Possono supportare sistemi operativi aperti oppure proprietari. Un esempio di S.O. implementabile su questo tipo di transponder � JCOP (Java Card).

* � possibile clonare un UID Mifare?

	Gli UID a 4 byte delle tessere Mifare sono stati esauriti diversi anni fa (NXP dichiarava la cosa nel 2010). Quindi � si possibile che ci possano essere UID duplicati. Per questo NXP aveva aumentato la lunghezza degli UID a 7 byte.
	Inoltre da diversi anni sono disponibili sul mercato tessere compatibili con UID programmabile per cui � proprio possibile duplicare UID.
	� anche possibile che la carta utilizzata dal cliente abbia un UID a 7 byte ed il lettore la legge comunque prendendo solo 4 byte.



Conversione da TAG RF FULL a TAG RF HALF
-----------------------------------------------------------------------
Esempio codice TAG in FULL
        0600A481E9

Trasformo ogni singola cifra in decimale
	00 06 00 00 10 04 08 01 14 09

Prendo le ultime 10 cifre ed ottengo la conversione in HALF:
	04 08 01 14 09  




# TASK SCHEDULER
======================================================================

Possibili errori del Task Scheduler:

0x8007051F	Task Start Failed: failed to start "..." task for user "..."
0x00041300	The task is ready to run at its next scheduled time
0x00041301	The task is currently running
0x00041302	The task will not run at the scheduled times because it has been disabled
0x00041303	The task has not yet run
0x00041304	There are no more runs scheduled for this task
0x00041305	One or more of the properties that are needed to run this task on a schedule have not been set

Errori pi� complessi:

0x800704DD	The operation being requested was not performed because the user has not logged on to the network.The specified service does not exist
SOLUZIONE: Run with highest privileges, run whether the user is logged or not

0x1		Incorrect function call
SOLUZIONE1: [Right click on task] > Properties > Actions > Edit > Program/Script: <nome file senza virgolette>, Start in: <nome cartella>
SOLUZIONE2: Controllare "Run with highest privileges", "Run whether user is logged or not", "Configure for" (settato per l'OS corrente), controllare che l'utente che lancia il programma abbia le autorizzazioni
	

(*) QUEUED STATUS
Problema: cliccando su 'Run' per lanciare un task manualmente, lo stato del task stesso diventa 'Queued' e non 'Running'
Soluzione: Apri il task, vai su Settings > "if the task is already running, then the following rule applies" > Queue a new instance

	Approfondimento:
	L'opzione "If the task is already running, then the following rule applies" sceglie come il Task Scheduler deve lanciare il task se un'altra istanza del task sta gi� girando:
	- Do not start a new instance: The Task Scheduler service will not run the new instance of the task and will not stop the instance that is already running.
	- Run a new instance in parallel: The Task Scheduler service will run the new instance of the task in parallel with the instance that is already running.
	- Queue a new instance: The Task Scheduler service will add the new instance of the task to the queue of tasks that the service will run, and the service will not stop the instance of the task that is already running.
	- Stop the existing instance: The Task Scheduler service will stop the instance of the task that is already running, and run the new instance of the task.


# MTFA: MICRON TEXT FILE ARCHIVER
======================================================================
Applicativo in .NET 4.0, � semplicemente un tool a linea di comando che permette di:
	a) spostare un file di testo (/SOURCE) in una certa cartella (/DESTDIR)
	b) rinominare il file aggiungendo il suffisso _AAAAMMGGHHmmSS (data ora di esecuzione)
	c) ove richiesto, eseguire un comando esterno (p.e. trasferire un file via ftp)

Installazione:
- Scompattare il file .zip in una cartella qualsiasi

Parametri:
	/SOURCE = nome del file sorgente
	/DESTDIR = directory di destinazione
	/LOGSIZE = dimensione massima del log (espresso in Kb, default a 4096)
	/KEEPDAYS = numero di giorni di archiviazione, oppure 
		/KEEPNUMBER = numero di file da tenere
	/COMMAND = comando esterno da eseguire sul file rinominato, solo il comando con percorso completo
		/COMMANDPARAMS = parametri per il comando esterno, se bisogna citare il file in questione si scriva [FILE]
		/ONCE = stabilisce se il comando va lanciato una volta per ciascun file o tutti i file in una volta sola
			= 0 	% Il comando viene eseguito una volta per ogni file (default)
			= 1	% Il comando viene lanciato singolarmente per tutti i file
	/OUTPUTFILENAMETEMPLATE = consente di specificare una data/ora nel formato preferito
		(i template utilizzano i formati data-ora classici di Windows)
			Esempi:
			dd		Giorno del mese da 01 a 31
			ddd		Giorno del mese da Mon a Fri
			dddd		Giorno del mese (nome completo)
			hh		Ore da 01 a 12
			H		Ore da 0 a 23
			HH		Ore da 00 a 23
			m		Minuti da 0 a 59
			mm		Minuti da 00 a 59
			M		Mese da 1 a 12
			MM		Mese da 01 a 12
			s		Secondi da 0 a 59
			ss		Secondi da 00 a 59
			y		Anno da 0 a 99
			yy		Anno da 00 a 99
			yyyy		Anno da 0000 a 9999
			
Funzionamento:
- Scrivere un file con il comando di esecuzione di MTFA con i parametri richiesti (v. esempi sotto)
- Preparare una cartella /DESTDIR/TEMP, dove verranno parcheggiati i file fino alla corretta esecuzione del comando richiesto
- Schedulare il file batch nel Task Scheduler e testare

Esempi:
	MTFA /SOURCE="C:\PROVA\presenze.txt" /DESTDIR="C:\ARCHIVIO" /KEEPNUMBER=10 /OUTPUTFILENAMETEMPLATE=Timb0001_[yyyyMMddHHmmss].txt
		(Viene spostato il file presenze.txt dalla cartella C:\Prova nella cartella C:\Archivio, vengono tenuti solo gli ultimi 10 files, il file viene rinominato come indicato)
	E:\MPW\_INSTALL\$MTFA13\MTFA.exe /SOURCE="\\161.242.230.17\timbrature$\presenze.txt" /DESTDIR="\\161.242.230.17\timbrature$" /KEEPDAYS=10000 /LOGSIZE=4096 /OUTPUTFILENAMETEMPLATE=Timb0001_[yyyyMMdd_HHmmss].txt
		(Rinomina del file presenze.txt nella stessa destinazione, tenendo un massimo di 10000 files, un log massimo di 4GB, il file viene rinominato come indicato)


***Attenzione!
Ovviamente occorre predisporre un template che abbia senso rispetto alla programmazione della esecuzione schedulata di MTFA. Eseguire MTFA ogni giorno specificando come template che contiene solo il mese provoca LA SOVRASCRITTURA del file archiviato. Non � previsto, per ora, un meccanismo di append nel file archiviato.



# KLEIS STAND-ALONE
======================================================================
Il cosiddetto 'Kleis Stand-alone' prende il nome di KLEIS PAD (o KleisPad) ed � composto da:
	- un Dispositivo di Controllo Accessi (DCA), ovvero il Kleis
	- un attuatore KX50
	- un alimentatore 12V DC per alimentare i due dispositivi
	- 3 tessere MASTER
	- N tessere USER
	- N tessere SERVICE
	* � possibile caricare fino ad un massimo di 150 utenti, oltre i quali le abilitazioni pi� vecchie vengono sovrascritte

Utilizzo:

	Inserimento nuovo user: Master --> User --> Master
	Cancellazione user: Master x 2 --> (Delete) --> User --> Master
	Open config (default opening time = 7s): Master x 3 --> (Time) --> (Edit coi tasti, OK) --> Master


# ISEO
============================================================================================================================================

INTRO
----------------------------------------------------





RISORSE E PREREQUISITI
----------------------------------------------------

PORTALE WEB REDMINE
Per documentazione, file bin e cf0

	http://redmine.iseozero1.com
		username:	zilio
		password:	zlivtr


PORTALE RISORSE COMMERCIALI
Per documentazione commerciale, manuali base e istruzioni per V364 e app Argo

	https://app.iseo.com
	

ISEO FTP
Per ultime release del V364

	ftp.iseo.com
		iseovar
		IseoVar2015


RILASCI
Note di rilascio nel documento "V364 Solution Release Notes_X.X.X.X_YYYMMDD.pdf"
Pacchetto "V364_X.X.X.X.tar.gz" contenente:
	* V364 Application
	* Hermes
	* V364 Client Programmer
	* V364 Platform
	* Software list: contiene l'elenco delle versioni firmware da utilizzare, i singoli file sono disponibili nel .tar.gz


SOFTWARE

	- MPW >= 7.40 con Micronreception, eventualmente usare il TrayIcon
	- Badge di prova da usare come programmazione
	- ACR122U per leggere/arruolare i badge
	- Putty

	- Software ISEO Hermes (documento: "Hermes_UserManual_UK_00.pdf")
	� il software da utilizzare con il RFID MODEM 541E00010 ("saponetta nera"), da qui in poi Modem
		- Pacchetto di setup disponibile su ftp ISEO
		- Procedura di installazione:
			- Spacchettare e installare il software da file di setup
			- Attaccare il modem a una porta USB 
				*** Hermes vede SOLO porte COM da 1 a 8 !!
			- Aprire Gestione Dispositivi e controllare il numero della porta COM a cui si � collegato il modem
			- Aprire C:\ProgramData\iseo\hermes\config.gn
			- alla voce "HOST;HOST____#00000;PORT;#;Y;NODE____#00099;S;2;019200", sostiture il numero prima di ";019200" con il numero della porta, diminuito di 1
			- Salvare e chiudere il file config.gn
		- Primo accesso al software Hermes
			- Definire l'environment:
				- Cliccare su SET ENVIRONMENT
				- Inserire "Name" dell'Atlas e "Controller URL" (<IndirizzoIP>:3001) - ovviamente l'Atlas deve essere in rete
				- Cliccare su "Save" per salvare l'Environment; � anche possibile creare ("New") o cancellare ("Delete") degli environment
				- Cliccare su "Select and exit"
			- Accedere all'Hermes:
				- Home Page > [inserire "username" e "password" del Vega]
				- Hermes cercher� di effettuare automaticamente una sincronizzazione con l'Atlas
			- Una volta effettuato il login, Hermes scarica in locale una copia del database MySQL del V364
			- Arrivati alla pagina CONNETTI-SCARICA LOGS-LOGOUT, � possibile scollegarsi dalla rete dell'Atlas e continuare Offline
		- Con il modem sempre collegato al portatile, appoggiare il modem su un lettore offline e cliccare su CONNETTI
			- Effettuata la connessione, verranno visualizzate le opzioni disponibili (v.manuale)
		
			*** Se, dopo aver cliccato su Connetti, Hermes continua a cercare di connettersi ma senza risultato, significa che non riesce a comunicare col Modem
				*** � stato eseguito Hermes con i privilegi di amministratore?
				*** la corrispondenza tra porta COM e configurazione su config.gn � corretta?
							
HARDWARE

	- Atlas RFID (le seguenti credenziali sono valide per il dispositivo Atlas demo RFID: IP 172.16.15.2, MAC 00:15:42:00:A7:77)
		utenza putty/ftp
			root
			rootroot
		utenza V364 1.0.4.4 Application 1.1.0.67
			microntel
			microntel
		Applicativi a bordo dell'Atlas:
			./Server
		Database a bordo dell'Atlas:
			mysql -u root		% Accedere all'istanza MySQL come utente root
			show databases;		% Mostra i database disponibili nell'istanza
			use offline;		% Utilizza il database "offline"
			show tables;		% Mostra l'elenco delle tabelle nel database
			select * from...	% Query di select dalla tabella

	- Kleis Cortex ad uso Encoder/Validatore
		firmware "MH10K265.BIC" (scheda VMN429 Cortex) oppure "MH0RC017.sca" (scheda VMN329)
		libgn32.dll >=5.0.59.0
		Per caricare il firmware dentro al Kleis Cortex:
			Mettere il Kleis in condizione di ricevere la configurazione: 
				- Testare il Kleis: alimentando il Kleis, questo d� LED ripetuti rossi: per il momento � solo in grado di riconoscere una tessera, ma non ha configurazione
				- Disalimentare il lettore
				- Attivare il Loader: chiudere i primi due pin in alto, nella serie di pin verticali a destra del connettore
				- Rialimentare il lettore: si accendono i LED rossi e verdi fissi, cio� il lettore � in hardware setup
			Downloadare il firmware
			(*) Tramite GNConfig: utilizzare la cartella predisposta "GNConfig_Cortex", ma va rinominata "GNConfig"
				- Sistemare il Kleis alimentato sopra il modem HERMES, non � necessario utilizzare il software corrispondente
				- Caricare MH10K263.BIC dentro GNConfig/gn, fare una copia e rinominarla MH11Gxxx.bic
				- GNConfig > Nuovo nodo > Node#00099
				- Connessione: Serial, Applicativo: MH11Gxxx, Porta: <n.porta>, Host Baud: 115200
				- Sel. NDWNL e doppio click sul NODE, il modem Hermes comincia a lampeggiare su TX
				- Spegnere il Kleis e rimuovere il ponticello verticale per togliere il lettore dallo stato di hardware setup
				- Rialimentando il Kleis, rimangono 2 LED blu accesi
			(*) Tramite IseoUpdater (v.paragrafo corrispondente pi� in basso)
		Per impostare la funzione di LETTORE/VALIDATORE:
			(nessun indirizzamento particolare)
		Per indirizzare fisicamente il Kleis:
			(*) v. documento "Stylos 2_IT_60000STY2LV00.1.pdf" alla sezione "Connessioni elettriche Lettore/Validatore"
		Per associare il lettore al suo attuatore:
			(*) v. documento "Stylos 2_IT_60000STY2LV00.1.pdf" alla sezione "Scambio delle chiavi cifrate con l'attuatore"

	- Kleis Cortex ad uso Gate Offline (SOLO scheda VMN429 Cortex) (*La scheda VMN329 non ha la possibilit� di essere usata come gate offline! Per quella, vige la logica Simply... Un gate offline NON si pu� fare con una VMN329. In compenso, pu� essere usato come lettore online collegato all'Atlas)
		firmware >= "MH10K263.BIC"
		libgn32.dll >=5.0.59.0
		Per caricare il firmware dentro al Kleis Cortex:
			Mettere il Kleis in condizione di ricevere la configurazione: 
				- Testare il Kleis: alimentando il Kleis, questo d� LED ripetuti rossi: per il momento � solo in grado di riconoscere una tessera, ma non ha configurazione
				- Disalimentare il lettore
				- Attivare il Loader: chiudere i primi due pin in alto, nella serie di pin verticali a destra del connettore
				- Rialimentare il lettore: si accendono i LED rossi e verdi fissi, cio� il lettore � in hardware setup
			Downloadare il firmware
			(*) Utilizzare la cartella predisposta "GNConfig_Cortex", ma va rinominata "GNConfig"
				- Sistemare il Kleis alimentato sopra il modem HERMES, non � necessario utilizzare il software corrispondente
				- Caricare MH10K263.BIC dentro GNConfig/gn, fare una copia e rinominarla MH11Gxxx.bic
				- GNConfig > Nuovo nodo > Node#00099
				- Connessione: Serial, Applicativo: MH11Gxxx, Porta: <n.porta>, Host Baud: 115200
				- Sel. NDWNL e doppio click sul NODE, il modem Hermes comincia a lampeggiare su TX
				- Spegnere il Kleis e rimuovere il ponticello verticale per togliere il lettore dallo stato di hardware setup
			(*) Tramite IseoUpdater (v.paragrafo corrispondente pi� in basso)
		Per impostare la funzione di VARCO OFFLINE/STAND-ALONE:
			(*) v.documento "Stylos 2_IT_60000STY2LV00.1.pdf" alla sezione "Impostazione come Varco Stand-alone"
			- Spegnere il Kleis; 
			- Chiudere, per mezzo di un jumper, i PIN verticali 2 e 3 dall'alto, a destra del connettore
			- Rialimentando il Kleis, rimane in attesa con i LED blu e rossi accesi
			- Non essendo ancora stato inizializzato, passando un badge apre, facendo 2 blink rossi e poi una serie di verdi
		Per indirizzare fisicamente il Kleis:
			(*) v. documento "Stylos 2_IT_60000STY2LV00.1.pdf" alla sezione "Connessioni elettriche Varco Stand-alone"
		

	- KX50 ad uso attuatore
		Downloadare tutti i file (richiede ISEOUPDATER!):
			- Installare IseoUpdater usando il file di setup pi� recente: � scaricabile da FTP Iseo
				Il percorso di installazione di default dovrebbe essere C:\Program Files(x86)\Iseo01Utility
			- Copiare il file MH0P1000.cf0 al percorso ...\Iseo01Utility\UpdateFiles\Configuration
			- Copiare il file MH0YW000.bin al percorso ...\Iseo01Utility\UpdateFiles\Table
			- Copiare il file MH0MZ018.sca al percorso ...\Iseo01Utility\UpdateFiles\Firmware
			- Collegare il KX50 al portatile usando il USB-TO-LOCBUS CONVERTER (modello ZY00153, NON un cavo qualsiasi! Se non vedr� il cavo giusto, IseoUpdater non si aprir� e restituir� l'errore "No FTDI device")
				Il cavo ha un alimentatore a parte: prima di alimentare l'attuatore, switcharlo su canale Locbus 1 (v.sotto)
					Alimentare l'attuatore e controllare il LED rosso sotto il connettore di alimentazione:
					- se blinka 1 volta, allora l'attuatore � su canale Locbus 1
					- se blinka 2 volte, allora l'attuatore � su canale Locbus 2
					Per cambiare canale, alimentare l'attuatore tenendo premuti i due pulsanti dal lato opposto al connettore di alimentazione per circa 1 secondo.
			- Aprire Iseo01Utility\IseoUpdater.exe
			- Select device > I+O Click (VM345): il software automaticamente riconosce la porta COM (deve essere inferiore a 9, per�)
			- Per aggiornare Table, 
				- cliccare su Operation > Table, 
				- Link Device per stabilire la connessione (la connessione � stabilita se sul lato inferiore appare la porta COM e il baudrate usato)
				- File to Send > Select File > [se non appaiono tutti i file della folder \Table, disabilitare "Cross check" e "Show last release"] > Seleziona il file .bin e conferma
				- Cliccare su Update device per eseguire il download
			- Per aggiornare Configuration,
				- cliccare su Operation > Configuration
				- Link Device per stabilire la connessione (la connessione � stabilita se sul lato inferiore appare la porta COM e il baudrate usato)
				- File to Send > Select File > [se non appaiono tutti i file della folder \Configuration, disabilitare "Cross check" e "Show last release"] > Seleziona il file .bin e conferma
				- Cliccare su Update device per eseguire il download

		*** Vecchia maniera (preferibilmente DISMESSA: questi appunti, tra l'altro, sono paurosamente incompleti)
			- Per aggiornare Firmware,
				- cliccare su Operation > Firmware
				- Link Device per stabilire la connessione (la connessione � stabilita se sul lato inferiore appare la porta COM e il baudrate usato)
				- File to Send > Select File > [se non appaiono tutti i file della folder \Firmware, disabilitare "Cross check" e "Show last release"] > Seleziona il file .bin e conferma
				- Cliccare su Update device per eseguire il download
			- Collegare convertitore seriale/USB e controllare nella gestione dispositivi la porta COM assegnata
			- Aggiornamento PIC:
				- Eseguire Mh0MM000.exe
				- Aggiornare porta COM
				- Cliccare su Start > browse file MH0MZ018.sca
				- Attendere la fine del caricamento
				- Far dissaldare i ponticelli (mette l'attuatore in Hardware Setup), poi ricollegare il dispositivo
			- Caricamento CF0 e BIN:
				- Eseguire MH0JE013.exe
				- CommPort > Properties: settare la COM appropriata, velocit� 9600
				- CommPort > Port Open: inizia a pollare il dispositivo
				- Comm > I/O Expander Classic > Read Version
				- Comm > I/O Expander Classic > Download Table > browse MH0IW004.bin
					(*) ################# ti confermo che il file MH0IW004.bin non ha la funzione di scambio dei contatti del rel� da NC a NO impostabile tramite ponticello a GND dell'I/O 2. Questa funzione � disponibile con l'utilizzo della tabella MH0YW000.bin
				- Aspettare che riprenda a pollare
				- Comm > I/O Expander Classic > Download Config > browse MH0P1000.cf0
				- Aspettare che riprenda a pollare
			- Variare la velocit�:
				- CommPort > Port Open: per chiudere la porta 
				- CommPort > : settare velocit� 38400
			- CommPort > Port Open: per riaprire la porta
			- Comm > I/O Expander Classic > Read Version: la versione deve apparire aggiornata
	
				(*) Nel caso in cui MH05E013.EXE dovesse dare problemi su MSWINSCK.OCX, seguire questa procedura:
					- Copiare mswinsck.ocx sotto C:
					- Creare file di testo con dentro scritto: 
						regsvr32.exe C:\mswinsck.ocx
					- Rinominare il file di testo con estensione ".cmd" ed eseguire da Amministratore
					- Seguire la stessa cosa per MSCOMM32.OCX


	� Indirizzamento fisico: v. documento "Stylos 2_IT_60000STY2LV00.1.pdf"
	
	Associazione di 1 attuatore con 1 lettore: 
		(*) La seguente funzione � chiamata "Scambio delle chiavi cifrate con l'attuatore"
		(*) � disponibile un video tutorial al sito app.iseo.com
		- Selezionare il canale Locbus
			- Accendere l'attuatore e verificare se il LED rosso lampeggia una volta (=canale Locbus 1, associato a lettore/validatore) oppure due volte (=canale Locbus 2, associato a varco Stand-alone)
			- Per modificare il canale Locbus di riferimento, accendere l'attuatore tenendo premuti i pulsanti orizzontali contemporaneamente per 1 secondo - questo mette l'attuatore su canale locbus 1, adatto allo scambio delle chiavi
		- Impostare i jumper per l'indirizzamento fisico dell'attuatore e del lettore
		- Accendere l'attuatore tenendo premuto il pulsante orizzontale pi� vicino al bordo per 3 secondi
		- Accendere il lettore tenendo premuto il pulsante rosso, attendere il segnale acustico e luminoso e lasciare immediatamente il pulsante: il lettore mostra quattro LED verdi
		- Se la chiave � stata scambiata con successo, il lettore mostra LED blu fissi
		- Se la chiave � stata scambiata male, il lettore mostra LED blu e rossi fissi: qualsiasi badge presentato viene rifiutato

	Scambio delle chiavi tra 1 attuatore KX50 e 2 lettori STYLOS 2:
	Materiale:
		- attuatore indirizzo 1 su canale locbus 2
		- Stylos Master indirizzo 1, jumper per funzionare come stand-alone gate
		- Stylos Slave indirizzo 2, jumper per funzionare come stand-alone gate
	Seguire comunque le istruzioni standard di scambio chiavi!
	Step:
		1) Premere pulsante su attuatore
		2) Dare corrente su attuatore e rilasciare il pulsante di scambio chiavi
		3) Questo mette l'attuatore in attesa della chiave
		4) Premere pulsante rosso su Stylos slave (2)
		5) Alimentare Stylos Slave e dopo qualche secondo rilasciare il pulsante
		6) Premere pulsante rosso su Stylos Master (1)
		7) Alimentare Stylos Master e dopo qualche secondo rilasciare il pulsante
	Video completo su app.iseo.com:
		- Argo > Video tutorial > Stylos and actuator exchange of coded keys (Quick start)
		- Argo > Video tutorial > Stylos exchange of coded keys Advanced



CONFIGURAZIONE DA ZERO DI UN IMPIANTO OFFLINE
----------------------------------------------------

STATO DI RILASCIO
- L'Atlas arriva con ultima versione di Linux embedded, ultima versione del V364
- La licenza viene spedita via mail, su richiesta a ISEO e fornendo numero seriale dell'impianto e il MAC Address: ogni licenza contiene MAC Address e versione relativa
- IP Default: 192.168.0.184
- Credenziali al primo login: nessuna
- Browser > [indirizzo IP] > nessuna pagina di login > Appare pagina "System informations"
	- Utilizzare il menu a panino in alto a destra
	- Selezionare "Imposta indirizzo di rete" per cambiare indirizzo IP, Subnet Mask e Default Gateway
	- Selezionare "Imposta come MASTER" > "Scegli file licenza" > [browse for "licence.txt"] > "Upload"
	- Selezionare "Imposta data ora" > "Sincronizza con il tuo sistema" (solo dopo impostazione Atlas come MASTER)
	- Opzioni di inizializzazione (solo dopo attivazione della licenza):  
		- "Start a new plant" per iniziare un nuovo impianto (v.sotto)
		- "Restore backup plant" nel caso in cui si volesse ripristinare un .tar.gz salvato precedentemente

	(*) IMPORTANTE: NON lasciare l'installazione a questo punto; si rischia che l'Atlas abbia una licenza attiva, ma nessun utente attivo; qualsiasi connessione successiva pu� dare errore di "SESSION_NOT_AUTHENTICATED". Bisogna ALMENO arrivare fino alla creazione del primo utente.
	Se dovesse capitare bisogna collegarsi su Putty all'Atlas e dare i seguenti comandi:
		rm license.txt			% Rimozione manuale della licenza
		mysql > drop database offline	% Drop del database "offline"
		./serverd stop			% Riavvio dell'applicativo server
		./serverd start


CREARE UN NUOVO IMPIANTO
Da stato di fabbrica, procedere con:
- Creazione impianto:
	- System Configuration > Start a New Plant
	- System Configuration > Inser Plant > [inserire "Name", "Location", "Contact"] > Save
- Definizione del primo utente System Administrator (colui che, dovendo creare l'impianto, avr� sempre accesso a tutte le funzioni del Menu del Vega)
	- System Administrator > [Inserire "First Name e "Last Name"]
	- System Administrator > [Inserire "Account name", "password", "password confirm", "language" e "date format"]


CONFIGURARE L'IMPIANTO
- Definizione delle tecnologie delle credenziali:
	- Selezionare la tecnologia da menu a tendina (qui sotto quelle pi� usate):
		- USER_1K (Classic 1K, 4K): 520 varchi, 6 abilitazioni, 26 transiti nel log, impianti medio/piccoli
		- USER_4K (Classic 4K): 2000 varchi, 6 abilitazioni, 26 transiti nel log, impianti medio/grandi
		- USER_1K_RELOCATABLE (Classic 4K): 520 varchi, 6 abilitazioni, 26 transiti nel log, impianti medio/piccoli
		- � anche possibile selezionare 'Customize' ed definire manualmente il tipo di tecnologie necessarie
- Network Setup > Main Controller (l'Atlas Master)
- Aggiungere un Attuatore:
	- Network Setup > Main Controller > Info Channel Type > Actuators
	- Actuators > [+]
	- Information of the I/O Click:
		- Name of the I/O Click:	inserire il nome dell'attuatore
		- Channel of the I/O Click:	sel. 00, 01, 02 a seconda di dove � collegato l'attuatore
		- Address of the I/O Click:	indirizzo fisico dell'attuatore
- Aggiungere un Encoder:
	- Network Setup > Main Controller > Info Channel Type > Readers
	- Readers > [+]
	- Reader Information:
		- Name of the reader:	inserire nome del lettore
		- Type of reader:	seleziona da menu a tendina (Stylos)
		- Channel of reader:	sel. 00, 01, 02 a seconda di dove � collegato il lettore sull'Atlas
		- Address of reader:	indirizzo fisico del lettore	
		- Use as Encoder:	s�/no
		- Use as Validator:	s�/no
		- Open an actuator:	[� possibile selezionare eventuali attuatori preconfigurati]
		(*) Associare un lettore online ad un attuatore crea un "Varco online" (visibile nell'elenco Menu > System Configuration > Doors setup]
- Aggiungere una Porta Offline:
	- Menu > System Configuration > Doors Setup > Offline doors
	- Offline Doors > [+]
	- Inserire informazioni del varco:
		- Door type:		sel. Libra, Aries, Stylos
		- Door name:		inserire nome della porta
		- Description:		inserire eventuale descrizione
		- Altri parametri:
	- Save > La porta appare nell'elenco delle Offline Doors
- Inizializzare una Porta Offline:
(*) Una porta NON inizializzata apre sempre, mostrando dei LED rossi e poi dei LED verdi
	a) Attraverso il Vega:
		- Menu > System Configuration > Doors setup > Offline doors
		- Offline doors list > [cliccare sulla porta da inizializzare; � anche possibile utilizzare il campo di ricerca]
		- Dal menu di dettaglio della porta offline > [...] > Initialize door
		- Mettere la tessera di programmazione davanti all'Encoder > confermare la maschera su Vega
		- Mettere la tessera di programmazione davanti al lettore da inizializzare: attendere che i LED verdi finiscano di blinkare
	b) Attraverso il modem Hermes:
		- Agganciare il modem Hermes su un dispositivo offline
		- Accedere al software Hermes (Esegui da Amministratore!) ed effettuare il login
		- Connect > appare la lista dei dispositivi > Selezionare il lettore > Initialize
		- A messaggio di conferma, l'inizializzazione � completa: il lettore sa il suo ID (come da database dell'Atlas) e la data/ora
	- NB: Il varco offline � costituito da un lettore collegato ad un attuatore con lo stesso indirizzo o con un indirizzo compatibile (v. scheda tecnica di collegamento); � necessario effettuare la procedura di "Scambio Chiavi" per associare un attuatore al suo lettore; l'informazione dell'attuatore NON � presente nel Vega


*************"Errore generico":


AGGIUNGERE UN ATLAS SLAVE
- Collegarsi alla pagina web dell'Atlas Master
- Andare sulla lista dei Controller > cliccare [+] per aggiungere un Atlas
- Inserire parametri necessari (tipo Nome, IP e Master di riferimento) e salvare
- Il nuovo Atlas apparir� nella lista dei Controller con un'icona rossa (ovvero, non inizializzato)
- Selezionare l'Atlas Slave dalla lista dei Controller
- Nella pagina di dettaglio dell'Atlas Slave, cliccare su [...] > Initialize Atlas per far importare il contenuto del Master di riferimento (compreso l'ID, ovvero la licenza)
- Salvare: l'icona dell'Atlas Slave � diventata verde

(*) Tutte le volte che si applica una modifica di tipo "fisico" (e.g. nuovo lettore, nuova porta offline) � necessario selezionare gli Atlas Slave > [...] > Update software
(*) Tutte le volte che si applica una modifica puramente software (e.g. nuovo utente, modifiche credenziali) le modifiche vengono automaticamente sincronizzate tra i Master e i loro Slave


DIAGNOSTICA ATLAS
----------------------------------------------------

- "serverd" è la versione 'Servizio' (daemon) del Vega, "Server" è la versione 'Noservice' del Vega (mostra su console tutto ci� che accade, dispositivi online/offline, lettura, ecc.)
	- Per passare da uno all'altro, basta inviare in sequenza i comandi:
		- ./serverd stop	% per fermare il daemon
		- ps				% per vedere se, nell'elenco dei processi, serverd si è effettivamente fermato
		- ./Server			% per far partire la versione 'noservice' (si interrompe con Ctrl+C)
		- ./serverd start	% Ricordarsi di far ripartire il daemon! Non ha avvio automatico al boot dell'OS

BACKUP DI UN ATLAS
Per effettuare un backup
	- browser > V364 > Menu > Utilit� > Scarica backup
	- Scaricare il file ".tar.gz"
	- Nota: il backup non permette di recuperare il file licenza; per farne una copia, � sufficiente collegarsi in FTP e farsi una copia locale del file "licenza.txt"
		sftp://<IP_address>
		username (SSH user)
		password (SSH password)
	- Nota: il backup mantiene le informazioni sulle utenze amministrative e sul contenuto del database MySQL interno (es. varchi, lettori, attuatori, parametri di rete, ecc.)

UPGRADE DEL V364
Attenzione: per upgrade da versioni precedenti a 1.0.4.4, effettuare un aggiornamento 'intermedio' attraverso questa stessa versione (se non anche a due step, passando dalla 1.0.4.10!).
	- Innanzitutto, effettuare un backup completo dell'Atlas e della licenza
		- Il backup del database � disponibile da voce relativa nel Menu principale di V364
		- Il backup della licenza � fattibile via SFTP, basta copiare in locale il file licenza.txt
		(a scopo precauzionale: in realt� entrambi vengono mantenuti durante l'aggiornamento)
	- Pulire la cache del browser
	[Opzionale: il reset alle condizioni di fabbrica era necessario per gli upgrade delle versioni pi� vecchie]
		- [Opz.] V364 > Menu > Utilit� > "Reset to factory" per riportare alle impostazioni di fabbrica
		- [Opz.] Attendere che appaia la pagina delle informazioni di sistema --> A questo punto, v. sezione Reset to Factory
	- V364 > Menu > Upgrade
Al termine dell'upgrade, potrebbe dare errore "No connection on Engine Service"; basta aspettare qualche minuto
Tutto il database e l'associazione al file di licenza vengono mantenuti.
Fare un clean cache alla fine del processo.

	� Upgrade manuale

	Pu� capitare che l'upgrade da pagina web non vada a buon fine. In tal caso, � possibile eseguire l'upgrade manualmente usando il pacchetto di installazione nuovo e uno script per lanciarlo:

	- Upload SFTP di OfflineInstPack.sh (versione corretta) e pacchetto di installazione
	- Comandi SSH:
		chmod 777 offlineInstPack.sh	% Modifica le autorizzazioni (+rwx) sullo script bash di installazione
		sh offlineInstPack.sh		% Esegue lo script di installazione (ATTENZIONE: il contenuto dello script dipende dalla versione di pacchetto che si sta usando!)
		(aspettare "installation completed", possibilmente senza errori di file non trovati)
	- Riprovare ad aprire V364 da pagina web: eventualmente pulire la cache del browser

	� Upgrade PHP

	Se dopo l'upgrade l'Atlas non risponde alla porta 80, potrebbe richiede un upgrade della versione di PHP.
	Questo succede soprattutto su Atlas vecchio modello (non Plus).
	Per risolvere:
	- Upload SFTP di atlasSTD_phpInst.sh e Vega_Solution-atlasSTD_php.tar.gz
	- Comandi SSH:
		chmod 777 atlasSTD_phpInst.sh
		sh Vega_Solution-atlasSTD_php.tar.gz
	- Clear Cache sul browser e ritenta la connessione http

RESET TO FACTORY
Reimpostare a condizioni di fabbrica: la reimpostazione alle condizioni di fabbrica riporta l'Atlas nelle condizioni in cui � stato fornito, ad eccezione di un paio di aspetti:
* Tutto il contenuto del database viene cancellato, nonch� il file di licenza
* NON viene reimpostato l'indirizzo IP, per permettere di poter ancora raggiungere il terminale via SSL
* Dalla riconnessione, considerare il terminale come da inizializzare del tutto (manca, quindi, l'impianto base e le impostazioni di utenti amministrativi)
	- V364 > Menu > Utilit� > "Reset to factory"
	- AL termine del caricamento, appare la pagina "System Information", come se partisse dallo Start-up di impianto: vedere sez. corrispondente
	

ID IMPIANTO:
L'ID impianto identifica univocamente l'installazione.
./serverd stop		% Per chiudere l'applicativo in modalit� servizio
ps 			% Per controllare che serverd si sia fermato
./Server		% Per aprire l'applicativo in modalit� programma
(verso la 10a-15a riga c'� scritto l'id impianto:
	se =1	� un impianto demo, per versioni vecchie del V364 potrebbe non avere il file di licenza
	se <>1	� un impianto cliente, deve esistere il file licenza


DEBUG CLIENT:

	Il DebugClient � essenzialmente un'interfaccia di back-end per l'Atlas.
	Tramite il DebugClient � possibile visualizzare la lista delle credenziali, del loro corrispondente stato e del dettaglio del relativo profilo d'accesso.

	Parametrazione:
		Modificare "IseoOFLACSDebugClient.exe.config":
		        <client>
		            <endpoint address="http://172.20.42.128:3001" binding="basicHttpBinding"	<--- Inserire qui indirizzo IP dell'Atlas
		                bindingConfiguration="IseoOFLACS" contract="WebService.OFLACS"
		                name="IseoOFLACS" />
		        </client>

	Utilizzo:
		Pagina CREDENTIALS
			- Il software si presenta automaticamente alla pagina CREDENTIALS, dove lista tutte le credenziali salvate a database
			- La lista delle credenziali � costituita di tre colonne:
				ID:		Progressivo identificativo della credenziale, � lo stesso che viene mostrato nella maschera di allineamento del MicronConfig
				VAR Id:		Equivalente del Tag RF Full, � la traccia letta dai dispositivi ISEO
				Status:		Active (=attivo), Invalidated (=non attivo), Deletable (=Cancellato)
				UpdateIDX:	Indice di revisione*****
			- Ciascuna delle credenziali nell'elenco a sinistra � a sua volta costituita da una serie di propriet�, visibili dopo aver selezionato la credenziale in questione e aver cliccato su READ
			- Le propriet� di una credenziale includono:
				Periodo di validit� (start/end)
				Funzioni aggiuntive (Emergenza, Always Open, Privacy, ecc.)
				Profili orari (giorno/ora/minuti) 	% fino 64 configurabili per credenziale
			- Sulla destra, viene mostrato l'elenco dei Gates abilitati sulla credenziale:
				Varco:		Descrizione del varco cos� come configurato sul Vega
				Stato:		0 (=escluso), 1 (=incluso)
		Pagina LOGS:
		Pagina GATE SETTINGS:
		Pagina SYSTEM:
		Pagina CARD FUNCTIONS:



MICRONSERVICEOFFLINE
----------------------------------------------------
Documentazione: MT_MRT_MicronServiceOffline.doc
Particolare attenzione al paragrafo TABELLA DI COMPATIBILITA' ATLAS

COS'�:


INSTALLAZIONE E CONFIGURAZIONE:

- � possibile installare MicronServiceOffline dal file setup $mrtXXX.exe, oppure manualmente con il comando installutil
- MicronConfig > 

DIAGNOSTICA MICRONSERVICEOFFLINE:

	ISEOBOXPROXY.log
	Esempi di alcune richieste inviate all'Atlas e relativa risposta:

		- Richiesta di deassegnazione all'Atlas:
		
			<CredentialInvalidate xmlns="urn:IseoOFLACS">	% Nome della chiamata (CredentialInvalidate)
				<credentialId>47</credentialId>		% ID della credenziale
				<copy>0</copy>				% Copy=0
				<mode>DeferredUpdate</mode>		% Modalit� di invalidazione
				<encoderId>0</encoderId>		% ID dell'encoder
				<keyId xsi:nil="true" />		% KeyID=null
			</CredentialInvalidate>

		Risposta alla richiesta di deassegnazione:
	
			<ns:CredentialInvalidateResponse xsi:type="ns:CredentialInvalidateResponse">
				<ns:out xsi:type="ns:ResultClass">
				<ns:ResCode>2</ns:ResCode>
				<ns:Description></ns:Description>
				</ns:out>
			</ns:CredentialInvalidateResponse>

	(*) URI NON VALIDO: IMPOSSIBILE ANALIZZARE IL NOME HOST
	Appare il suddetto errore in MicronServiceOffline/Log/app.log.

		Controllare che il parametro "ServiceCode" nel MicronNoServiceOffLine.exe.config oppure nel MicronServiceOffLine.exe.config corrisponde al codice del servizio offline su Micronconfig

	(*) KEY ALREADY IN USE
	Su MicronServiceOffline/Log/app.log si legge:
	18-06-2018 17:04:28:865 Begin processing CLIENT Sync command client:TOR1VIR0627W_001 cmdType:SyncCommand op:369-Assegna badge OFFLINE data:99000000019900000109       1000000
	18-06-2018 17:04:28:865 Action:Assegna badge OFFLINE
	18-06-2018 17:04:29:052 CredentialAdd() Error:-221 Key already in use 

		� un errore trasmesso direttamente dall'Atlas, potrebbe essere visibile anche su Micronpass Web durante l'arruolamento.
		Questo errore nasce da un disallineamento tra le credenziali a bordo dell'Atlas e quelle presenti nel database MRT.
		Pu� essere dovuto a varie cause, in primis un arruolamento di badge finito con un errore su MPW ma di fatto andato a buon fine sul server Atlas.
		� sufficiente riallineare i due database per poter procedere:
		- MicronConfig > [Click destro su Servizio Offline] > Funzioni di Manutenzione > Allineamento badge
		- Verifica allineamento badge	% restituir� delle celle rosse (corrispondenti a credenziali gi� presenti sull'Atlas, ma non presenti su MRT)
		- Avvia				% Per far avviare l'allineamento, ci metter� qualche secondo
		- Verifica allineamento badge	% Dopo l'allineamento, tutte le credenziali salvate dovranno avere la spunta sulla colonna "database" e sulla colonna "Atlas"

	(*) KEY NOT ACTIVE
	-223-CredentialUpdate() Error:-223 Key not active	

		� un errore trasmesso direttamente dall'Atlas, potrebbe essere visibile anche su Micronpass Web durante l'arruolamento.
		Provare il riallineamento come descritto sopra.
	

MICRONPASS WEB: FUNZIONI CSF
----------------------------------------------------

UTILIZZO CON MICRONPASS WEB
- Deve essere installato e attivo il Micronreception (anche in versione TrayIcon) con lettore PC/SC ACR122U
- Ovviamente il MicronServiceOffLine, versione Servizio o NoService, deve essere avviato
	(*) La creazione stessa di un MicronServiceOffline su MicronConfig genera tutte le funzionalit� e i pulsanti aggiuntivi su Micronpass Web per gestire i badge offline o le chiavi

	- Esempio di arruolamento badge:
	(L'arruolamento badge serve a imprimere dentro al badge il 'codice impianto' dell'Atlas che si sta usando)
		- Badge & Chiavi > Arruolamento badge offline > Leggi da Lettore USB
		- A lettura e arruolamento completati, viene mostrato un messaggio di conferma

	- Esempio di aggiornamento di abilitazioni:
		- Dipendenti > Dipendenti > [cerca dip. proprietario del badge] > Abilitazioni > aggiungi/togli varco
		- MicronNoServiceOFFLine > Appaiono le seguenti voci:
			"Processing Async command cmdType: Command op.323-Aggiornamento Abilitazione su VARCO data:xxxxxxxxxxxx"
			"Pending credential refresh executing..."
			"CredentialUpdate credential: 1 result: OK status:0"
			"Pending credential refresh finished"
		- Solo a quel punto l'abilitazione sull'Atlas � stata aggiornata, e viene inviata sull'Encoder/Validatore

	- Esempio di aggiornamento della validazione:
	(*) L'aggiornamento della validazione si pu� fare tramite validatore o da workstation MPW su ACR122U
		- Dipendenti > Dipendenti > [cerca dip. senza badge] > Comandi > Badge
		- Assegna un badge > Leggi da lettore USB
		- Selezionare la modalit� di validazione:
			- Nessuna validazione del badge richiesta (il badge sar� SEMPRE valido)
			- Valore specifico in ore... (inserire la quantit� X)
		- Confermare con OK, mettere il lettore sul lettore ACR122U: questo fa sia da Encoder che da Validatore
			(*) "Errore connessione": verificare che il MicronServiceOffline sia avviato
		- Dopo la quantit� di tempo X, il varco offline rifiuta il transito
		- Ripassare la tessera dal Validatore per aggiornare il tempo di validazione

			(*) La validazione si pu� aggiornare/modificare/creare SOLO in fase di assegnazione del badge su Micronpass Web
			(*) Per modificare l'unit� di misura, vedere parametro corrispondente su MicronConfig > Parametri > MicronOFFLine
			(*) In deassegnazione, tutti i transiti non scaricati vengono eliminati dalla tessera


COMANDO DI DEBUG PER IMPIANTI OFFLINE MIFARE:
Comando utile in fase di debug per gli impianti offline Mifare: consente di ottenere varie informazioni che possono essere inviate ad ISEO per attivit� di debug.
Il comando ("Debug*") � disponibile nella testata di elenco dei badge.

	Si attiva inserendo nella T05COMFLAGS la seguente flag:
		COMF/BADGEDEBUG/1

	Utilizzo:
	- Badge e Chiavi > Gestione badge > Debug > Genera file di debug
	- Leggi da lettore USB > [appoggiare tessera sul lettore PC/SC e dare OK]
	- Scaricare file "card_debug.txt" contenente le seguenti informazioni:
		- La versione del software di scrittura dei badge (SW)
		- La versione firmware dell'ACR122U
		- UID del badge
		- ATR del badge
		- Elenco di tutti i blocchi di memoria del badge

MODALITA' D'USO SPECIALI PER ARIES E LIBRA:
Funzioni speciali per placca maniglia e cilindro
Appaiono come comandi di varco nel momento dell'assegnazione di un varco offline in un profilo d'accesso

	EMERGENCY (stato ON/OFF)
	Ha priorit� su tutte le altre, attivando l�emergenza la porta si apre SEMPRE girando la maniglia o il pomello. 
	� sufficiente che il gate sia presente nella credenziale: le fasce orarie del profilo non vengono considerate.
		Come attivare: Avvicinare una card con l�attributo a ON, la porta fa un lampeggio verde con beep, si apre e rimane aperta.
		Come disattivare: Avvicinare una card con l�attributo a ON, la porta fa 5 lampeggi arancioni con relativo beep poi esce dallo stato di emergenza.

	ALWAYS OPEN (stato ON/OFF): 
	Imposta uno stato permanente nello stato ON la porta rimane sempre aperta.
	� sufficiente che il gate sia presente nella credenziale: le fasce orarie del profilo non vengono considerate.
		Come attivare: Avvicinare una card con l�attributo a ON, la porta fa 3 lampeggi arancioni con relativo beep poi si apre e rimane aperta.
		Come disattivare: Avvicinare una card con l�attributo a ON, la porta fa 5 lampeggi arancioni con relativo beep poi esce dallo stato di always open.

	OVERRIDE PRIVACY (one-shot): 
	Permette di entrare anche se il chiavistello interno � serrato, l�accesso � ONE-SHOT una volta chiusa la porta � necessario usare nuovamente la card per aprire.
	Questa modalit� tiene conto delle fasce orarie presenti nella credenziale.
		Come attivare: Questo attributo non imposta una modalit� permanente. Avvicinare una card con l�attributo a ON, la porta si apre anche se il chiavistello interno � serrato. Dopo la chiusura si deve utilizzare nuovamente la card per aprire.
		Come disattivare: Non esiste una funzione di disattivazione questa modalit� � one-shot.





APPENDICE: MODEM HERMES PER DIAGNOSTICA E MANUTENZIONE DEI VARCHI OFFLINE
----------------------------------------------------
- Il software Hermes, una volta effettuato l'accesso, permette di:

	- Connettersi a un dispositivo offline:
		- Login > Connect > [avvicinare il Modem al lettore finch� non blinka la luce TX]
		- Appaiono le opzioni di manutenzione (sotto) > Premere SKIP per saltare
			- Informazioni del device: nome, data/ora, batteria
			- due opzioni: "Synchronize clock" e "Collect new logs" > Procedere con OK per aggiornare le informazioni del dispositivo
		- Appaiono le opzioni Operations Menu:
			- Display Logs			% Apre un menu di ricerca dei transiti con vari filtri (es. DataOra, Gate ID, Credential ID, ecc.)
			- Maintenance			% Apre una serie di opzioni di manutenzione
				- Update firmware	% Aggiornamento del firmware sulla scheda
				- Synchronize clock	% Sincronizzazione dell'orologio rispetto all'orologio del modem Hermes
				- Send blacklist	% Aggiornare la blacklist
				- Update configuration	
				- Complete log collect	% Raccolta dei log del dispositivo
				- Reset to factory	% Riportare allo stato di fabbrica il dispositivo
				- Reinitialize device	% Reinizializzare il dispositivo
			- Diagnostic	
				- Hardware info		MAC Address, firmware, scheda, Data/ora, batteria
				- Counters		Quantit� di aperture effettuate dall'ultima diagnostica, letture di tessere, ecc.
			- Disconnect 		Esce dalla connessione con il lettore

	- Visualizzare i logs:
		- Login > Display Logs > [Apre un menu di ricerca dei transiti con vari filtri (es. DataOra, Gate ID, Credential ID, ecc.)]
		- Vengono mostrati tutti i log salvati in locale sul modem Hermes




APPENDICE: ISEOUPDATER
----------------------------------------------------

CONSIDERAZIONI GENERALI
	- � possibile trovare il pacchetto di installazione su server FTP sotto la cartella IseoUpdater
	- IseoUpdater viene installato sotto Programmi(x86)\Iseo01Utility e contiene le seguenti sottocartelle:
		\gn
		\UpdateFiles			% Contiene i file da usare per aggiornare i dispositivi ISEO
			\Configuration	
			\Firmware
			\Loader
			\Table
		\Config.gn
		\Descdev.csv
		\Descfirm.csv
		\Init.gn
		\IseoDevice.txt			% Elenco dei dispositivi visibili su IseoUpdater
		\IseoUpdater.pdf		% Manuale utente
		\Libgn32.dll			% Libreria di comunicazione
		\Mscomm32.ocx
		\Wsc32.dll
	- Le interfacce FTDI disponibili per far comunicare IseoUpdater con i dispositivi sono le seguenti (ricordarsi di installare i driver!):
		- Modem elettromagnetico VMN244F (baud rate 19200)
		- Modem elettromagnetico VMN379F (baud rate 115200), aka USB Modem "Sirio"
		- Convertitore seriale/locbus VMN263A
	- Al primo avvio, l'IseoUpdater cercher� di collegarsi al server FTP: � possibile modificare le credenziali cliccando sul pulsante FTP.
	
	
	AGGIORNAMENTO FIRMWARE SU UN LETTORE KLEIS/STYLOS VMN429
	Prerequisiti: 
		- Modem USB (VMN379F) "Sirio"
		- il file C:\Programmi(x86)\Iseo01Utility\IseoDevice.txt deve contenere il seguente record nell'elenco: STYLOS (VMN429) #1 - VMN379F, Firmware
		- versione firmware Kleis >= MH11G061.bic
	Procedura:
		- Copiare il firmware "nuovo" MH1xxxxx.bic sotto Iseo01Utility\UpdateFiles\firmware
		- Collegare il Modem USB "Sirio" e appoggiarvi sopra il lettore
		- Mettere il lettore (da spento) in modalit� Setup inserendo il jumper nella 1a e 2a posizione dei pin verticali, a destra del connettore verde di alimentazione
			- Una corretta impostazione in modalit� Setup mostra LED rossi e verdi fissi
		- Aprire IseoUpdater e selezionare STYLOS (VMN429) dalla lista dei dispositivi: notare che il software riconosce automaticamente la porta COM utilizzata
		- Cliccare su funzione "Update firmware", l'unica � visibile nel riquadro delle funzioni
		- Cliccare poi su Link Device: il modem USB inizia a brillare in corrispondenza di TX
		- Il software, acquisendo automaticamente il baudrate (115200), mostra le informazioni del dispositivo sulla destra (MAC address, versione hardware, bootloader, firmware, ecc.)
		- Cliccare su "File to send"; mettere a OFF le opzioni "Cross Check" e "Show last release", rendendo cos� visibili tutti i file contenuti nella cartella UpdateFiles\Firmware
		- Selezionare la versione firmware da downloadare e confermare con la spunta verde
		- Tornati nella maschera principale, cliccare su "Update device" e attendere il completamento della barra di caricamento
		- Il successo del completamento viene confermato dalla nuova versione firmware mostrata sulla colonna di destra
		- Spegnere il lettore e rimuovere il jumper per uscire dalla modalit� di Setup
		- Riaccendere il lettore: i LED blu e rossi fissi mostrano il lettore in attesa di inizializzazione
	
	AGGIORNAMENTO FILE TABELLE SU UN ATTUATORE
	IseoUpdater � uno strumento software pensato per aggiornare i prodotti elettronici ISEO. Funziona solo su sistema operativo Windows. Pu� essere trovato sia su Redmine sia su FTP ISEO.
	L'installazione pu� essere lanciata semplicemente eseguendo il file di Setup. Il percorso di installazione di default � C:\Program Files (x86)\Iseo01Utility.
	La cartella \UpdateFiles contiene a sua volta le seguenti sottocartelle:
		\UpdateFiles\configuration	% dove sostituire il file di configurazione .CF0
		\UpdateFiles\firmware		% dove sostituire il file firmware .SCA
		\UpdateFiles\loader
		\UpdateFiles\tabel		% dove sostituire il file tabelle .BIN

	� inoltre necessario utilizzare il convertitore USB-Locbus per poter collegare il dispositivo locbus al portatile su cui � installato l'ISEOUpdater.
	Per poter effettuare la connessione, il dispositivo deve essere settato su Canale Locbus 1.
		(*) Nel caso dell'attuatore, basta seguire questa procedura:
			- Accendere l'attuatore e controllare i LED rossi:
				se blinkano 1 volta (Locbus 1) = Lettore/Validatore
				se blinkano 2 volte (Locbus 2) = Varco stand-alone
			- Per modificare il canale locbus di appartenenza, premere i due pulsanti in basso contemporaneamente per circa 1 secondo
			- Riaccendere l'attuatore e verificare se i LED rossi blinkano tante volte quante richiesto; in caso contrario, ripetere la procedura

	- Eseguire il file Iseo01Utility > IseoUpdater.exe
	- Nel menu a tendina "Select device", selezionare "I+O Click (VMN345)"
	- Il software riconosce automaticamente la porta COM (deve essere inferiore a 9) su cui � connesso il dispositivo
		(*) Se necessario, nella sezione "Parametri Locbus" � possibile modificare manualmente il sotto-indirizzo del dispositivo
	- Nella sezione "Operation", cliccare su "Table"
	- Cliccare sul pulsante "Link device"
	- Il software automaticamente acquisisce il Baudrate e imposta la comunicazione con il dispositivo, mostrandone le caratteristiche a destra nella sezione "Device info"
	- Cliccare sul simbolo della cartella verde "Select File" per andare a puntare al file .BIN di cui fare il download nel dispositivo
	- Una volta selezionato, confermare col pulsante a spunta verde
	- A questo punto, cliccare sulla freccia verde "Update device" per far partire il download
	- Finito il download, � possibile scollegare l'attuatore ed eventualmente resettare il canale Locbus preesistente


APPENDICE: APP ARGO
----------------------------------------------------
	- Scaricare l'app ARGO ISEO da Store
	- Attivare il Bluetooth su smartphone
	- Sull'applicazione appare la lista delle serrature meccatroniche (Libra o Aries), con MAC address salvato
	- Avvicinare la tessera Master su Libra
	- Il Libra usato diventa rosso sull'app: � entrato in modalit� manutenzione
	- Cliccare sul Libra sull'app: mostra le Carte e gli Utenti abilitati




# TAVOLETTA GRAFOMETRICA SIGPAD 200
======================================================================
Prerequisiti hardware:
- Tavoletta grafometrica (ovvero, Evolis SigPad 200)
	Collegata a workstation tramite cavo USB
	Visibile in gestione dispositivi come Dispositivo HID generico
- Driver Evolis TWAIN 8.0.0 (https://it.evolis.com/driver-supporto/driver-tablet-per-firme)
	* Il driver riporta la dicitura DEMO nel nome file, anche se non ha scadenza

Prerequisiti software:
- Micronpass Web >=7.4.17
- TrayClient >=1.3.0 (non disponibile con IEhosting)

Configurazione server:
- MicronConfig > Parametri > Micronpass > Nome device acquisizione firme = "signotec twain32/SignCap"	% Setta il dispositivo di acquisizione
- MicronConfig > Parametri > Micronpass > Abilita firma del pass visitatori = True			% Attiva la funzionalit�
- MicronConfig > Parametri > Micronpass > Default per richiedi firma del pass visitatori = True		% Setta la relativa checkbox a True di default

Configurazione client:
- Installare Framework 4.5.2
- Scaricare il file TWAIN DRIVER 8.0.0 da https://it.evolis.com/driver-supporto/driver-tablet-per-firme
	- Installare il driver: al termine dell'installazione, viene proposta la maschera di configurazione
	- Twain Settings > Resolution of the output = 300 dpi
	- Twain Settings > Fixed size for the output = 0 height, 0 width
	- Twain Settings > Rotation of the output = 0
	- Twain Settings > Line width of the signature = 3
	- Twain Settings > Button position = Bottom
	*** Il software di setup � comunque disponibile a posteriori in C:\Program Files (x86)\signotec\"signotec Twain"\STPadConfig.exe

Utilizzo
La tavoletta � utilizzabile solo nella Gestione Visitatori
- Dalla maschera di dettaglio del visitatore, appare la casella "Richiedi firma del pass visitatori" (stato di default secondo il parametro suddetto)
- Stampa pass (da menu Comandi, da menu Multipass oppure da casella Stampa Immediata del Pass)
- Si apre la finestra "signotec/pad" che riproduce e aggiorna lo stato del display del SigPad
- Il SigPad entra in modalit� acquisizione
	X rossa = abortisce l'operazione
	Frecce blu = pulisce il display
	Spunta verde = conferma
- Il visitatore usa il pennino per firmare e conferma cliccando sulla spunta verde
- Il pass visitatori viene visualizzato a schermo con l'immagine della firma acquisita



# ARM (MXP450, MCT700, MCT900)
======================================================================
uname -r: Linux imx6solosabresd 3.10.17-mh366on385-80707-gdac46dc-dirty #31 SMP PREEMPT Wed Nov 25 10:31:28 CET 2015 armv7l GNU/Linux

ARM di Zilio (scrivania): 172.16.15.1

STRUTTURA

Applicativi principali:
	Karpos Engine						% Modulo di gestione principale
		Locbus
		MariaDB
		Funzioni:
			Ingressi digitali (>=1.2.2)						% Funzione gestita sempre e comunque dal Karpos Engine
			Uscite digitali, es. rel� (>= 1.2.0)					% Funzione gestita sempre e comunque dal Karpos Engine
			Gestione serrature (>= 1.2.0)						% Funzione gestita sempre e comunque dal Karpos Engine
			Credenziali onboard (>= 1.2.2)						% Funzione gestita da Karpos in assenza di kDisplay
			Segnalazione LED rosso/verde sulla scheda (>= 1.2.2), remotabile	% Funzione gestita da Karpos in assenza di kDisplay
			Gestione buzzer (>= 1.2.2), remotabile					% Funzione gestita da Karpos in assenza di kDisplay
	kDisplay						% Modulo di gestione del display grafico
		Local Interface: Display
		Local Interface: Keyboard
		Local Interface: Biometric, Magnetizer
		Local Interface: RFID Badge
		Funzioni:
			Display grafico
	kConnector						% Modulo di comunicazione con il MicronService


	(*) Se per sbaglio installo la versione con kDisplay su un terminale senza display, ovviamente tutte le funzioni di gestione delle credenziali e delle segnalazioni utenti non funzioneranno (perch� vengono 'affittate' al kDisplay, il quale per� non trova il display per ricevere input)
		- In tal caso, basta rimuovere fisicamente o cancellare l'eseguibile kDisplay (riavviando poi tutti gli applicativi) dalla cartella /root/: a quel punto, il Karpos Engine si adatta automaticamente ed 'eredita' le funzioni del kDisplay

PREREQUISITI PER L'INSTALLAZIONE
- MPW Application Suite >= 7.4.5
- Browser: preferibilmente Chrome
- Porte TCPIP: 3001 (comunicazione col terminale), 22 (SSH e SFTP), 80 (HTTP)
- SSH Client: Putty

FORMATTARE SD CON SISTEMA OPERATIVO:
SD 8GB 'vergine' a disposizione, montata su adattatore USB/SD

	- Scaricare Win32DiskImager da internet, installarlo ed eseguirlo
	- Selezionare il dispositivo (es. G: o H:) su cui scrivere l'immagine
	- Dal pulsante Esplora, andare a pescare il file .img di nome "SD8G_NOSW_static.img"
	- Cliccare su "Scrivi" per scrivere l'immagine nell'SD
	- L'SD cos� formattata conterr� i file system di base di Linux, compreso il file di configurazione di rete con l'IP statico 192.168.0.250

INSTALLARE GLI APPLICATIVI:

	- Aprire Filezilla e collegarsi a sftp://192.168.0.250, utenza "root" (ed eventuale password)
	- Drag&drop del file "packages_X_X_X.tar.gz" (dove X_X_X � la versione) nella cartella root della SD
	- A trasferimento completato, aprire Putty e collegarsi in SSH su 192.168.0.250
	- Login con "root" (ed eventuale password)
	- Inserire il comando
		tar -xvf packages_X_X_X.tar.gz
	- Il pacchetto tar.gz viene spacchettato dentro alla cartella "packages"
	- Spostarsi dentro alla suddetta cartella con il comando
		cd packages
	- Eseguire i seguenti comandi:
		./kInstall_.....sh		per i dispositivi SENZA display
		./kInstall_...._disp.sh		per i dispositivi CON display
	- Attendere il completamento dell'installazione
	- Dare comando di "reboot" e chiudere il Putty

FOLDERS
	/karpos
	/kDisplay
	/kConnector++
	
	/uSD/TRANS		% Contiene un file .dat contenente tutti gli eventi 'transazione' (Timbratura, Monitor Testine, antipassback) da inviare al Micronservice; sarebbero poi quelli che si possono recuperare usando l'utility kRecovery


ATTIVARE GLI APPLICATIVI PER LA PRIMA VOLTA:

	- Quando riprende il ping, riconnettersi col Putty come sopra
	- Lanciare il comando di start
		./kManager start
	- Attendere alcuni secondi: il kSupervisor sta creando il database "dbkarpos" nel MySQL locale e sta facendo partire tutti gli applicativi
		(*) Se il terminale ha il display, questo si accende sulla home page
	- Una volta che il database "dbkarpos" � stato creato, � possibile accedere alla pagina web
	- Aprire un browser e puntare all'indirizzo IP del terminale; si apre il Karpos Configurator: accedere con password "admin"
	- Parametri importanti:
		OPTIONS > GENERAL > Plant Code = 12345 (deve corrispondere al codice impianto KARM nei parametri del Micronservice)
		OPTIONS > GENERAL > Panel Code = [] (deve corrispondere al codice terminale nel Micronconfig)
		(Se i servizi si riavviano, � normale)
	- Ricordarsi di cliccare su SAVE alla fine delle modifiche
	- Eventualmente, SERVICES > RESTART per applicare tutte le modifiche pendenti

	(*) Altre opzioni:
		OPTIONS > GENERAL > AESKey = 			% Chiave di crittografia (stringa alfanumerica, max 16 char) nel traffico TCP tra terminale e servizio
		OPTIONS > CONNECTION > KeepAliveTimeout = 60	% tempo di invio keepalive, come da parametro del MicronService
		OPTIONS > CONNECTION > SendTimeOut = 30		% Parametro di timeout interno del terminale
		OPTIONS > CONNECTION > ServerIPAddress		% Indirizzo IP del server (IP locale se il terminale � in DHCP, oppure IP pubblico
		OPTIONS > CONNECTION > TCPConnMode 		% Modalit� di connessione TCP/IP (1=Server/listen, ovvero il terminale � in ascolto e il server chiama il terminale, come da funzionamento GNet; 2=Client, ovvero il terminale prende l'iniziativa per aprire la connessione verso il server: da utilizzare, p.e. in DHCP, tutte le volte in cui la tabella di routing non consente al server di poter raggiungere il terminale; in tal caso si dovr� procedere in direzione opposta, cio� far chiamare il server da parte del terminale)
		OPTIONS > CONNECTION > TCPPort = 3001		% Classica porta per la comunicazione TCP/IP (porta chiamata sul terminale se TCPConnMode=1, altrimenti porta del server da chiamare se TCPConnMode=2)
		OPTIONS > [nome applicativo]			% Sono parametri temporanei, autocreati per ogni applicativo
		OPTIONS > MISCELLANEOUS > DB_SaveAlarm		% Memorizza le transazioni allame su database locale (tabella T030STAMPING) oltre al file .dat su uSD/TRANS/
		OPTIONS > MISCELLANEOUS > DB_SaveStamping	% Memorizza le transazioni timbratura su database locale (tabella T030STAMPING) oltre al file .dat su uSD/TRANS/ (questo � fondamentale per avere le timbrature a bordo e poter utilizzare, p.e., le query in locale QL01, QL02, QL03)
		OPTIONS > MISCELLANEOUS > MenuPassword		% Password del menu per il display
		OPTIONS > POWERSAVE >
		OPTIONS > USER > Language			% Lingua del terminale (parametro passato dal Micronconfig)
		OPTIONS > USER > LongDateStyle			% Formato data lunga (parametro passato dal Micronconfig)
		OPTIONS > USER > ShortDateStyle			% Formato data corta (parametro passato dal Micronconfig)

	CALIBRAZIONE DISPLAY

	- Se i servizi sono in Running, arrestarli da pagina web oppure da comando su Putty ("./kManager stop")
	- Riavviare il terminale ("reboot") in modo che possa avviarsi in modalit� 'manutenzione' (il file "maintenance" � presente nella root)
	- Eseguire i seguenti comandi di sistema:
		"ts_calibrate" > Permette di inserire cinque coppie di coordinate, premendo a display in corrispondenza delle crocette; questo processo serve a tarare il touch screen
		"ts_test" > Dopo la taratura, � possibile collaudare la calibrazione usando la funzione DRAG (per trascinare il cursore) o DRAW (per disegnare su schermo)
	- Uscire con "quit" a display oppure con "CTRL+C" su Putty
	- Riavviare i servizi da pagina web oppure da Putty ("./kManager start")
		
		(*) NOTA: I parametri di calibrazione del display vengono salvati localmente in qualche cartella di sistema di Linux; aggiornare il package KARM non li rimuove, ma formattare/sostituire la SD ovviamente s�

	MENU A DISPLAY

	Per dispositivi con il kDisplay, nel Karpos Configurator esiste un parametro in OPTIONS > CONNECTION > MENU PASSWORD che permette di settare la password di accesso al Menu del terminale (pulsante "Menu" a display); valore di default: 13579
	Previo inserimento della password, il Menu mostra:
	- Info: visualizza a video l'equivalente del comando terminale IFCONFIG
	- Ping: previo inserimento, nel Karpos Configurator, del campo OPTIONS > CONNECTION > IP SERVER, fa un test di ping
	- Spegni: esegue lo shutdown del terminale


	FUNZIONAMENTO IN NAT/PAT:

		Funzionamento in PAT (server con IP pubblico, es. 82.193.34.116):
		es. Terminale #1 (192.168.7.243)
			- Configurazione lato server:
				- Micronconfig > Terminale base > indirizzo IP = 0.0.0.0
				- Micronconfig > Terminale base > Porta = <porta utilizzata> (p.e.6000)
				- Micronconfig > Terminale base > Tipo connessione = Listen (DHCP)
			- Configurazione lato terminale:
				- Configuratore web > Options > Connection > Server IP Address = <IP pubblico del server di destinazione>
				- Configuratore web > Options > Connection > TCP/IP Connection Mode = 2 (Client)
				- Configuratore web > Options > Connection > TCPPort = <porta utilizzata> (p.e.6000)
				- Configuratore web > Network > [Inserire i parametri di rete LOCALE (p.e. 192.168.2.1, ecc.)
		es. Terminale #2 (192.168.7.244)
			identico, ma usando la porta 6001
		(ovviamente va strutturata una PAT sul router con la seguente mappatura
			82.193.34.116:6000 = 192.168.7.243:80
			82.193.34.116:6001 = 192.168.7.244:80
			)

	FUNZIONAMENTO IN DHCP

		

DATABASE DBKARPOS

	Per conoscere le credenziali di accesso al database, aprire /home/root/karpos.cfg

	Per collegarsi al database:
		mysql -u root					% Connessione al MariaDB con utenza root
		MariaDB[none] > show databases;			% Per vedere la lista dei database a sistema
		MariaDB[none] > use dbkarpos;			% Per cambiare database in uso da none a dbkarpos
		MariaDB[dbkarpos] > show tables;		% Per vedere tutte le tabelle del database in uso
		MariaDB[dbkarpos] > select * from T000FLAGS;	% Per vedere tutto il contenuto della tabella T000FLAGS

	Per abilitare le connessioni dall'esterno sul database MySQL interno al terminale:
		root@imxsolosabresd:/# nano /etc/my.cnf
			commentare #skip-external-locking
			commentare #skip-networking
			commentare #bind-address
		MariaDB [(none)]> use mysql;
		MariaDB [mysql]> GRANT ALL ON *.* to root@'x.x.x.x' IDENTIFIED BY '[INSERIRE-ROOT-PASSWORD]'; 	% x.x.x.x � l'IP del client
		MariaDB [mysql]> FLUSH PRIVILEGES;
		root@imx6solosabresd:/# /etc/init.d/mysql restart


	Sintassi di base:
		Select * from NOME_TABELLA 	% Seleziona tutte le colonne da NOME_TABELLA
		where CAMPO = VALORE		% Condizione di select
		order by CAMPO desc		% Criterio di ordinamento
		limit 20			% Equivalente di TOP VALORE su SQL (mostra solo le prime 20 righe)

	Tabelle MySQL di dbkarpos:
	+-----------------------+
	| Tables_in_dbkarpos    |
	+-----------------------+
	| T000FLAGS             | Parametri di configurazione di base (visibili nella pagina Options del web configurator)
	| T001LBM               |
	| T002DEVICE            |
	| T003DEVICE_INPUT      |
	| T004DEVICE_ALARM      |
	| T005LOCK              | Tabella delle serrature configurate su questo terminale, con relative propriet�
	| T006DEVICE_OUTPUT     | Tabella degli out dei dispositivi configurati sotto questo terminale
	| T007OBJECT_TYPE       | Parametri di configurazione delle periferiche
	| T008APB               |
	| T009READER            |
	| T010GATE              |
	| T011GATE_CMD          |
	| T012LANGUAGES         |
	| T013LANGUAGESMESSAGES |
	| T014BIOM              |
	| T015DEVICE_PARAM      | Parametri di configurazione dei device
	| T016GATE_STATE        |
	| T017DEVICE_EXTERN     |
	| T018SCHED_CMD         |
	| T019APB_PARAM         | Parametri di configurazione aree APB
	| T020REASON            | Tabella delle causali
	| T021MEAL              | Tabella dei pasti
	| T022FESTIVITY         | Tabella delle festivit�
	| T023TIME_RANGE        | Tabella delle fasce orarie con relative propriet�
	| T025PROFILE           | Tabella dei profili d'accesso
	| T026APB_BADGE         | Tabella dei presenti in area APB
	| T027LESSONS           |
	| T030STAMPING          | Tabella delle timbrature (si attiva dal configuratore web sulle OPTIONS > MISCELLANEOUS > DB_SaveStamping)
	| T032ALARM             | Tabella degli allarmi (si attiva dal configuratore web sulle OPTIONS > MISCELLANEOUS > DB_SaveAlarm)
	+-----------------------+

	
QUERY SU KDISPLAY
Micronservice >= 7.3.0

	Tipi di query a disposizione:
		QLxx		% Query su database MySQL locale
		QYxx		% Query su database SQL server

	Cartelle create in installazione:
		\MPW\KarposPhotos		% Ospita le foto delle matricole da mostrare tramite query informative
		\MPW\KarposQYTemplates		% Templates formato HTML o TXT per visualizzazione su schermo del terminale base
			es. TEMP-01-03.html		% Template da utilizzare per le query da QY01 a QY03
			es. STYLES.css			% File CSS per lo stile del template
			es. DETL_QYHEAD.html		% Pagina html per il dettaglio dell'header della visualizzazione
			es. DETL_QYROW.html		% Pagina html per il dettaglio della riga record nella visualizzazione
		\MPW\KarposUpdate		% Cartella per inviare update firmware al terminale ARM
		\MPW\KarposUserFiles		% Cartella per la ricezione di file user (tipo logs) da terminali ARM

	Per configurare le query per terminali KARM:
		- In caso di gestione anagrafica: copiare il contenuto della cartella \MPW\KarposQYTemplates\ANAG dentro alla cartella superiore \MPW\KarposQYTemplates
		- In caso di gestione non anagrafica: copiare il contenuto della cartella \MPW\KarposQYTemplates\NOANAG dentro alla cartella superiore \MPW\KarposQYTemplates
		- Per gestione foto: copiare il contenuto di \MPW\Micronpass\Photos dentro alla cartella \MPW\KarposPhotos
		- Per query locali (QLxx): su Configuratore Web > Options > Miscellaneous > DB_SaveStampings = 1
			(*) Attenzione: questo parametro abilita la scrittura delle timbrature sul database MySQL locale (nella T030STAMPINGS): questo sollecita molto la scrittura su SDcard!
		- Micronconfig > Parametri > MicronService > Numero timbrature in buffer QY (0=Disabilita) = [aumentare il valore di default, 22 corrisponde alla capacit� dei terminali GNET]
			Template anagrafici attualmente disponibili: 01 (timbrature del giorno), 02 (timbrature del mese), 03 (ultime timbrature), QL41-50 (programmabili), QY51 (dati anagrafici)
			Template non anagrafici attualmente disponibili: 01 (timbrature del giorno), 02 (timbrature del mese), 03 (ultime timbrature)
		- Riavviare il servizio! (altrimenti il terminale non riesce a caricare i template)

		(*) Per Query ad Host (cio� su timbratura, senza pressione di alcun tasto funzione):
		- Micronconfig > [Terminale base] > Parametri > Stamping > QueryHost = Enabled			% Per attivare le query ad host, se necessario
		- Micronconfig > [Terminale base] > Parametri > Stamping > QueryHostBypass = Enabled		% Per permettere il bypass della query ad host, in caso di mancata connessione al server
		- Micronconfig > [Terminale base] > Parametri > Stamping > QueryHostCode = [insert code]	% Inserire il codice della query, es. 51
			NB: Abilitando la query ad host (quindi QueryHost=Enabled), il CheckWhitelist lo effettua direttamente il server invece di farlo in locale sul terminale
			NB: La QY51 mostra i dati anagrafici e la foto prendendoli direttamente dal database MRT su server, evitando la gestione locale (bisogna comunque impostare i templates e le foto sotto le rispettive cartelle)


PERSONALIZZAZIONE LOGO KDISPLAY
Nella cartello root esiste una folder /kDisplayCfg/Icons contenente i vari elementi grafici che compongono lo schermo.
In particolare esistono due link:
	lrwxrwxrwx    1 root     root            12 Apr 23 21:58 Logo.gif -> Logo_def.gif
	lrwxrwxrwx    1 root     root            12 Jun  7 16:10 Logo.png -> Logo_def.png
Il software di gestione, se trova il link Logo.gif, lo visualizza, o meglio, visualizza il file Logo_def.gif. Questa pu� essere una gif animata, infatti nel funzionamento di default ci sono le stelle che girano.
Sostituendo il file Logo_def.gif puoi personalizzare la gif animata.
Se invece vuoi utilizzare un logo statico, rinomina il link Logo.gif, cos� il software utilizza Logo.png. Anche in questo caso si tratta di un link, per cui devi personalizzare il file Logo_def.png. 
Le dimensioni del file sono circa 500*120 pixel.
Quindi:

	- Prepare an image (500*120 pixel) and rename it Logo_def.png
	- Open Filezilla
		host:		sftp:\\<indirizzoIP>
		username:	root
		password:	M!cr0ntel
	- Move to /home/root/kDisplayCfg/Icons
	- Rename the link Logo_def.gif (so the software will look for Logo_def.png)
	- Upload and overwrite your Logo_def.png
	- Restart all the applications


INVIARE LA CONFIGURAZIONE AL TERMINALE

Il contenuto del file JSON viene copiato nel campo T22PARAMSTRUCT nel database MRT, sottoforma di valore unico
Quello stesso valore viene inviato dal MicronService al kConnector, perch� si occupi di aggiornare il database MySQL a bordo del terminale

Con i terminali ARM l�inizializzazione della macchina non avviene pi� con AZZERAMENTO MEMORIE bens� con

	1) Invio SETUP TERM.ACCESSI: 
		- Caricare tutti i parametri hardware di funzionamento impostati su MicronConfig		
	2) Invio AZZERAMENTO MEMORIE:
		- Non cancella alcun parametro di configurazione
		- Riallinea tutte le tabelle USER con un singolo comando
			- Profili di accesso, causali, fasce orarie, festivit�, comandi schedulati, presenti APB, stato varchi
	3) Invio REBOOT
		- Almeno la prima volta, quanto abbiamo configurato ed avviato la centralina con un nuovo �controller code�

	Questo sistema permette di modificare i parametri a caldo su una o pi� testine mentre sulle altre testine le persone continuano a timbrare.
	MicronConfig, alla modifica dei parametri, anzich� mandare AZZERAMENTO MEMORIE manda solamente SETUP TERM.ACCESSI
	La centralina ARM tenta di applicare a caldo tutti i parametri solamente dove necessario. 
	Solo in caso di evidente mancata applicazione � necessario eseguire un invio REBOOT.

	(*) Importante (MRT 7.40, KARM 1.20)!!! 
	Quando si cambia un'impostazione su un dispositivo e si Salva, bisogna poi anche salvare sul terminale base per fare in modo che il JSON si aggiorni e la configurazione venga mandata al terminale in maniera completa


MICRONCONFIG (STANDARD PER ARM):
Creazione della porta CED: impianto di esempio fatto di n.1 MXP450, n.2 KL611, n.1 KX50

	- Creare i dispositivi
		- Creare l'MXP
			- Parametri base: indirizzo IP, Porta
			- Canali Locbus: Nuovo canale locbus
		- Creare Kleis 1
			- Parametri base: Centralina, canale Locbus, indirizzo fisico
		- Creare Kleis 2
			- Parametri base: Centralina, canale Locbus, indirizzo fisico
		- Creare KX50
			- Parametri base: Centralina, canale Locbus, indirizzo fisico
	- Creare gli Allarmi sinottico (allarmi logici, non necessariamente legati a dell'HW) sul KX50
		- es. Effrazione porta, da monitorare, notificare e giustificare
			- KX 50 > Allarmi sinottico > Nuovo: Codice = 1
			- KX 50 > Allarmi sinottico > Descrizione: "Effrazione"
			- Abilitato: s�
			- Monitoraggio allarme: s� (possibilit� di vederlo su Msinw)
			- Notifica allarme: s�
			- Giustifica allarme: s�
		- es. Segnale antincendio
			- KX 50 > Allarmi sinottico > Nuovo: Codice = 2
			- KX 50 > Allarmi sinottico > Descrizione: "Incendio"
			- Abilitato: s�
			- Monitoraggio allarme: s�
	- Creare le Uscite sull'attuatore
		- es. Elettroserratura
			- KX 50 > Output > Nuovo: Descrizione "Elettroserratura"
			- Numero uscita > 0 (codice identificativo dell'uscita)
			- Propriet� uscita > Segnali uscita > 	Output n.1 = Booster
			- Set: impulsivo (settare un tempo >0)
		- es. Allarme
			- KX 50 > Output > Nuovo: Descrizione "Allarme porta"
			- Numero uscita: 1 (codice identificativo dell'uscita)
			- Propriet� uscita > Segnali uscita >	Output n.0 = Rel�
			- Set > Durata: 0 (perch� un allarme � 'sempre attivo' anche alla fine di qualsiasi durata che si configuri qui)
		- es. Semaforo ON
			- KX 50 > Output > Nuovo: Descrizione "Semaforo ON"
			- Numero uscita: 2 (codice identificativo dell'uscita)
			- Propriet� uscita > Segnali uscita >	Output n.2
			- Set > Durata: 0
		- es. Semaforo OFF
			- KX 50 > Output > Nuovo: Descrizione "Semaforo OFF"
			- Numero uscita: 3 (codice identificativo dell'uscita)
			- Propriet� uscita > Segnali uscita >	Output n.2
			- Reset > Durata: 0

			(*) Le serrature si riferiscono ad un out dell'attuatore o del terminale base in corrispondenza di una timbratura effettuata in ENTRAMBE LE DIREZIONI: � infatti poi la testina a decidere come scaricare la transazione (parametro Direction).
			� possibile definire un out in corrispondenza della sola entrata o della sola uscita SOLO per i terminali di presenze (� infatti una funzionalit� del kDisplay), utilizzando la seguente funzionalit�:
			- Terminale ARM > Parametri > GP01 = Rx-OK-IN 			% Abilita out rel� x (x=0;1) per sola entrata
			- Terminale ARM > Parametri > GP01 = Rx-OK-OUT			% Abilita out rel� x (x=0;1) per sola uscita
			- Terminale ARM > Parametri > GP01 = Rx-OK-IN Rx-OK-OUT		% Abilita out rel� x (X=0;1) per entrata e uscita

	- Creare gli Ingressi sull'attuatore
		- es. Stato porta (che configurer� come sensore porta):
			- KX50 > Input > Nuovo: Descrizione "Sensore porta"
			- Propriet� ingresso > Ingresso > Input 6
			- Analogico/digitale: digitale
			- Stato default: Low
		- es. Pulsante:
			- KX 50 > Input > Nuovo: Descrizione "Pulsante"
			- Propriet� ingresso > Ingresso > Input 7
			- Analogico/digitale: digitale
			- Stato default: Low
			- Tipo di ingresso > Bottone apri porta > Dispositivo serratura: "Kleis 1"
			- Tipo di ingresso > Bottone apri porta > Numero bottone: 1
				(Novit�: � possibile decidere il numero del pulsante, cos� non � pi� vincolato al numero dell'ingresso)
			- Tipo di ingresso > Bottone apri porta > Direzione: Entra
			(*) Creare anagrafica fittizia e badge fittizia (numero ingresso con 2 CIFRE) con codice "999999<n.bottone in 2 cifre>" (in questo caso, ID badge 9999999901 e IDX 99999999999999999901)
			(*) Propriet� di un ingresso:	
				FILTRO ON = Tempo 'virtuale' di filtro prima che il sistema si accorga che la porta si � aperta
				FILTRO OFF = Tempo 'virtuale' di filtro prima che il sistema si accorga che la porta si � chiusa
				In presenza di un FILTRO OFF per uno stato porta, � necessario che:
				Tempo di transito da impostare = Tempo filtro off + Tempo transito reale
		- es. Incendio (che configurer� come allare sinottico e come output diretto in corrispondenza di questo ingresso, quindi svincolato dalla serratura):
			- KX 50 > Input > Nuovo: Descrizione: "Incendio"
			- Propriet� ingresso > Ingresso > Input 2
			- Analogico/digitale: digitale
			- Stato default: Low
			- Allarme sinottico > Dispositivo: KX50
			- Allarme sinottico > Numero: 2-Incendio
		- Comando output > Dispositivo: KX50
		- Comando output > Numero: 2-Semaforo ON
	- Creare le Serrature per combinare le propriet� suddette
		- es. Elettroserratura con allarme da sinottico, con un certo tempo di transito, abilitata all'emergenza varchi
			- MXP450 > Serrature > Nuovo: Codice e Descrizione (es. "Serratura CED")
			- Modello: GENERIC LOCK
			- Allarme sinottico > Dispositivo: KX50
			- Allarme sinottico > Numero: 1-Effrazione
			- Comando serratura > Dispositivo: KX50 (il menu a tendina propone tutti i dispositivi con degli Output definiti)
			- Comando serratura > Numero: 0-Elettroserratura
			- Output allarme > Dispositivo: KX50, 
			- Output allarme > Numero: 1-Allarme
			- Tempo di transito: 5 sec
			- Abilitazione emergenza varchi: s� (abilita alla funzione emergenza varchi)
	- Legare le serrature ai lettori per completare la cablatura dei dispositivi
		- Kleis 1 > Parametri base > Serratura: 1-Serratura CED
		- Kleis 2 > Parametri base > Serratura: 1-Serratura CED
		- KX50 > Parametri base > Serratura: 0-Nessuno
	- Definire i parametri
		- es. Attivazione della tecnologia di lettura sui Kleis
			- Kleis 1/2 > Parametri > Reader > N1 = 13-Mifare(T1)

	Ticket:

		Tipo ticket = 0						% Layout base
			Riga 1: intestazione di 20 caratteri
			Riga 2: numero tessera (IDX)
			Riga 3: data ora di timbratura
			Riga 4: verso di timbratura
			Riga 5: eventuale codice causale

		Tipo ticket = 1						% Layout base senza verso di timbratura
			Riga 1: intestazione di 20 caratteri
			Riga 2: numero tessera (IDX)
			Riga 3: data ora di timbratura
			Riga 4: eventuale codice causale

		Tipo ticket = 2 					% Layout anagrafico
			Riga 1: intestazione di 20 caratteri
			Riga 2: numero tessera (ID)
			Riga 3: data ora
			Riga 4: Cognome
			Riga 5: Nome
			Riga 6: Matricola
			Riga 7: Descrizione causale

		Tipo ticket = 3						% Layout compatto
			Riga 1:	Data Ora
			Riga 2: numero tessera (ID)

		Tipo ticket = 4						% Layout con spazio per la firma
			Riga 1: Intestazione
			Riga 2: Progressivo
			Riga 3: numero tessera (IDX)
			Riga 4: Data Ora
			Riga 5: Descrizione causale
			Riga 6,7,8: Spazio per la firma

		Tipo ticket = 5						% Layout con linea dedicata alla firma
			Riga 1: Intestazione
			Riga 2: numero tessera (ID)
			Riga 3: Data Ora
			Riga 4: Cognome
			Riga 5: Nome
			Riga 6: Matricola
			Riga 7: Codice causale
			Riga 8: Descrizione causale
			Riga 9,10: blank
			Riga 11: Firma

		Tipo ticket = 6						% kDisplay >= 1.3.2
			Riga 1: Intestazione
			Riga 2: Data ora
			Riga 3: Numero tessera (ID)
			Riga 4: Matricola (due volte)
			Riga 5: Descrizione causale
			Riga 6: Gruppo
			Riga 7: progressivo ticket


DIAGNOSTICA DI BASE
Diagnostica su <applicativo>:

	LOGS
	
	I seguenti applicativi generano i corrispettivi log e i corrispettivi file di configurazione dei log:
		karpos		/home/root/uSD/LOGS/AAMMGG_log_karpos		BOOT_FLAGLOG_karpos
		kConnector++	/home/root/uSD/LOGS/AAMMGG_log_kconnector	BOOT_FLAGLOG_kconnector
		kDisplay	/home/root/uSD/LOGS/AAMMGG_log_kdisplay		BOOT_FLAGLOG_kdisplay
		kSupervisor	/home/root/uSD/LOGS/AAMMGG_log_supervisor	BOOT_FLAGLOG_ksupervisor

		Se necessario, � possibile creare un file FLAGLOG_k... seguendo le istruzioni:
			- cp BOOT_FLAGLOG_k... FLAGLOG_k..._off				% Per copiare il file di origine
			- cat FLAGLOG_k..._off > [applicare le modifiche desiderate]	% Per creare, dalla copia, il file flaglog richiesto
			- cp FLAGLOG_k..._off FLAGLOG_k...				% per rinominare il file con la dicitura corretta
		Contrariamente ai file BOOT_FLAGLOG_k..., che vengono letti al boot degli applicativi (e quindi le modifiche richiederanno un restart degli applicativi per essere effettive), il file FLAGLOG_k... viene letto ogni 20 secondi e sovrascritto sul BOOT_FLAGLOG_k... corrispondente.
	
	PERMANENT_LOG		% Crea il file di log BOOT_FLAGLOG_xxxxxx (se c'� gi�, lo sovrascrive)
	CLEAR_PERMANENT_LOG	% Cancella il file di log BOOT_FLAGLOG_xxxxxx (al primo riavvio dei servizi, per�, viene creato da zero secondo impostazioni di default) 
	LOG_FILE		% Scrive il log su file invece che mandarlo su standard output di Linux
	ALL_MESSAGE		% Scrivi tutto sul file di log
	ALL_ERRORS		% Scrivi solo gli errori sul file di log
	MAIN___			% Scrivi le funzioni di Main sul file di log

	Esempio di abilitazione di un log serie 'all_message':
		- da /home/root > cat BOOT_FLAGLOG_<applicativo>
		- modificare il file, commentando ALL_ERROR e togliendo il commento a ALL_MESSAGE
		- reboot
		- a dispositivo riavviato, spostarsi su /home/root/uSD/LOGS
		- per cancellare i log:
			rm <nomefile>

	Lettura log in tempo reale:
		tail -f <file_name> | grep "<stringa>"

		Esempi di stringhe da cercare:
			LBrec				Record locbus generico
			<cod.terminale>;LBrec: OD"	Record locbus che riguarda un KX50 (0D)
			<cod.terminale>;LBrec: 0C"	Record locbus che riguarda un Kleis (0C)		


ASSISTENZE CRITICHE:
	- Il terminale d� "Collegato" e "Scollegato" periodicamente sul NoService: significa che il parametro del MicronService "Tempo in millisecondi invio KeepAlive a terminali KARM" � troppo basso - deve essere almeno 60000 ms

LIBVIO
Libreria di comunicazione verso i dispositivi locbus

	Aggiornamento della libreria (vers.X.X.X):
	- Viene prodotto il file .tar.bz2, contenente a sua volta il file .tar.gz da scompattare con 7Zip: il file interessato si trova nella cartella "libvIO_X.X.X\armv7l" e si chiama "libvIO-linux-armv7l_X.X.X.so"
	- Filezilla > [collegarsi al terminale] > /home/root > [upload del file .so]
	- Collegarsi con Putty ed eseguire i comandi:
		./kManager stop					% per fermare gli applicativi
		cp libvIO-linuix-arm7l_X.X.X.so /usr/lib	% per copiare il file in /usr/lib
		cd /usr/lib					% per spostarsi in /usr/lib
		ls libvIO* -l					% verificare l'elenco delle librerie libvIO: notare il collegamento "libvIO.so" alla versione attualmente in uso
		rm libvIO.so					% rimozione del vecchio collegamento
		ln -s libvIO-linux-arm7l_X.X.X.so libvIO.so	% creazione del nuovo collegamento
		ls libvIO* -l					% verificare che il nuovo collegamento punti alla nuova versione della libreria
		cd /home/root					% per tornare alla root
		./kManager start				% per riavviare gli applicativi


DATA ORA
Comandi da Putty:
	date							% Restituisce la data ora
	date <MMDDhhmmYYYY.ss>					% Inserire la data ora nel formato richiesto
Aggiornamento del fuso orario:
	cd /etc							% per spostarsi in /etc
	ls localtime -l						% Stato del link localtime, in assenza di preconfigurazione questo collegamento non dovrebbe puntare a nulla
		(se il collegamento localtime esiste gi�, cancellarlo)
	ln -s /usr/share/zoneinfo/Europe/Rome localtime		% Crea un link puntante alla cartella zoneinfo/Europe/Rome
	date							% D� l'indicazione della data ora; indica CEST (in ora legale) o CET (in ora solare) al posto di UTC


AGGIORNAMENTO PACKAGE COMPLETO
----------------------------------------------------



AGGIORNAMENTO SINGOLI APPLICATIVI
----------------------------------------------------
Se si rimane entro la stessa versione del database mariadb (prime due cifre della release), � sufficiente sovrascrivere l'eseguibile dell'applicativo tramite FTP e riciclare gli applicativi.
Questa operazione per� va fatta manualmente e dovendola fare per molti terminali potrebbe essere fastidioso.
Subentra quindi il tool KarposUpdate:

\MPW\KarposUpdate
Cartella che serve a spedire il file inserito nella folder tramite SFTP

	- Inserire nella cartella il file contenente l'aggiornamento
		<CCCCCCCC>_<FFFFF>.tar.gz
			CCCCCCCC = Codice terminale come configurato su Micronconfig
			FFFFF = Nome file a piacimento
	- il file finisce sotto /uSD/Update e viene rinominato come "update.tar.gz"
	- il kConnector controlla periodicamente se esiste un file "update.tar.gz" in quel percorso
	- se lo trova:
		- crea il file "uSD/Update/update_ready"
		- invia un file "notify_quit" al kSupervisor
		- il kSupervisor scompatta update.tar.gz in /uSD/Update/update_dir/
		- il kSupervisor lancia /uSD/Update/Update_dir/install_update.sh
		- Alla fine dell'esecuzione, il kSupervisor cancella tutto il contenuto di /uSD/UPDATE/update e riavvia tutti gli applicativi


NMAP
----------------------------------------------------
Nel caso in cui si volesse passare al DHCP, � possibile scoprire l�indirizzo IP assegnato al terminale tramite una DHCP Console di Windows Server oppure tramite l�utility (da scaricare da FTP Bitech) nmap.
Scaricare e scompattare il file nmap-7.12-win32.zip
Sotto la cartella creata lanciare winpcap-nmap-4.13.exe per installare winpcap.

SCANSIONE MAC ADDRESS

Per effettuare una scansione dei MAC address, aprire il prompt, spostarsi nella cartella nmap-7.12 e lanciare il comando nmap �sP xxx.xxx.xxx.* (dove xxx.xxx.xxx.* sia la classe di rete dove cercare il dispositivo, es. 192.168.0.*).
L�elenco presentato mostra l�indirizzo IP e il MAC address di ogni terminale nella rete.

SCANSIONE PORTE 
Da effettuare a partire da una macchina 'esterna' a quella che si vuole diagnosticare	

	Esempio di uso di nmap per fare una scansione sulla macchina TARGET dalla macchina BASE:

		base# nmap -sS -O target
		Starting nmap 3.27 ( www.insecure.org/nmap/ ) at 2003-06-17 13:03 CEST
		Insufficient responses for TCP sequencing (3), OS detection may be less accurate
		Interesting ports on target (12.34.56.78):
		(The 1619 ports scanned but not shown below are in state: closed)
		Port       State       Service
		22/tcp     open        ssh
		25/tcp     open        smtp
		53/tcp     open        domain
		80/tcp     open        http
		Remote OS guesses: Mac OS X 10.1.4 (Darwin Kernel 5.4) on iMac, Mac OS X 10.1.5, FreeBSD 4.3 - 4.4PRERELEASE, FreeBSD 5.0-CURRENT (Jan 2003), FreeBSD 5.0-RELEASE (x86)
		Uptime 13.967 days (since Tue Jun  3 13:51:42 2003)
	
		Nmap run completed -- 1 IP address (1 host up) scanned in 16.704 seconds



MIFARE DESFIRE
----------------------------------------------------
Prerequisiti HW: 
	Kleis Cortex VMN429 (>=MH11G040)
	kit ZY00153 USB-to-Locbus Converter (pi� alimentatore a 12V)
Prerequisiti FW: 
	k>=1.2.5 
	d>=1.2.16
Prerequisiti SW: 
	KleisConfig - tool per la programmazione dei device di lettura DESFire sotto architettura ARM
	% Documentazione: MT_MRT_KARM_General_Info, paragrafo 16.1
	% Documentazione: MT_MIC-Desfire_KleisConfig.doc

Configurazione Hardware:
	- Copiare i files KleisConfig (ultima versione) spacchettandoli in una cartella del PC usato per configurare
	- Collegare il lato locbus del convertitore al connettore del Kleis
	- Collegare il lato USB al PC usato per configurare e prendere nota della porta COM utilizzata dalla Gestione Dispositivi
	- Aprire KleisConfig.exe
	- KleisConfig > Comm Port > [inserire porta COM]							% La porta COM selezionata viene salvata nel file di configurazione del programma e riproposta al successivo riavvio del programma
	- KleisConfig > Template Config > Sel. template 0 ("ISEO DESFire no password") > Update			% Selezione del template 0
		- KleisConfig > Desfire Template Configuration > Configuration ID = 0 					% Codice progressivo del template; ATTENZIONE: la tecnologia 21-Mifare Desfire impostata sull'MXP450 far� sempre riferimento al template ID=0
		- KleisConfig > Desfire Template Configuration > Description = [inserire descrizione del template]	% Descrizione del template
		- KleisConfig > Desfire Template Configuration > Application ID = F47400 				% Application ID: � un codice di 3 byte in notazione esadecimale. Coincide con il codice rilasciato da NFC.
			per ISEO: AID = F47400
			per MICRONTEL: AID = 00561A
		- KleisConfig > Desfire Template Configuration > File ID = [num.file]					% Numero del file da leggere che contiene le informazioni che deve leggere la testina
			per ISEO: File ID = 3
			per MICRONTEL: File ID = 0
		- KleisConfig > Desfire Template Configuration > Key len = 16						% Lunghezza della password di accesso al file
		- KleisConfig > Desfire Template Configuration > Key (hex) = [inserire la password Desfire] 		% Chiave di accesso al file, obbligatoriamente lunga 32 caratteri: va indicato con rappresentazione HEX (es. 1234=30313233).
			% Per indicare l'assenza di password, impostare una stringa di 32 caratteri '0'
			% La password di default � costituita da una stringa di 32 caratteri '1'
			% Stessa password del campo Chiave Personale nella definizione delle tecnologie su V364
		- KleisConfig > Desfire Template Configuration > Key ID = [id della chiave]				% Numero della chiave da usare per l'accesso al file: le card DESFire prevedono fino a N possibili password
		- KleisConfig > Desfire Template Configuration > Data Offset = [offset]					% Offset di partenza del dato che deve leggere la testina nel fileID specificato
		- KleisConfig > Desfire Template Configuration > Data Len = [bytes]					% Numero di byte che deve leggere la testina a partire dall'offset
	- Tutti i parametri vengono salvati dentro a un file XML nella cartella dell'applicativo
	- KleisConfig > Device detecting > [parte il polling continuo sul Communication Log]				% Il programma tenta di comunicare con tutti i dispositivi presenti sul bus, finch� non ne trova uno connesso
	- KleisConfig > Set Configuration > [se va tutto bene, ricevi il messaggio "Sending Command completed successfully"]
	- KleisConfig > Stop 

- MicronConfig > Tabelle > Tecnologie Testine > [aggiungere l
******************************


# SMARTHOTEL
============================================================================================================================================
Progetto di integrazione con il gestionale hotel di Siemens SmartHotel


Nuova scheda Cortex VMN388 ("KX100" o "RoomController")

- Codice periferica:
	0C = KK/KL
	0D = IO
	11 = RoomController
- Caratteristiche hardware: 
	CPU ARM Cortex
	1 MB flash
	128 kB RAM
	kernel rtOS (real-time operating system)
	Autobaudrate fino a 38400
	3 jumper di indirizzamento fisico
	6 input (connettori "IAC_INPUT_PLATFORM_GPIO_x" dove 1<=x<=6)
		IN-OUT1 SC.ISP 		% Stato porta
		IN-OUT2 SC.IAUX		% Ausiliario: allarme, allagamento, servizi utente, richiesta lavanderia, ecc.
		IN-OUT3 SC.ILC		% Pulsante luci di cortesia
		IN-OUT4 SC.ISOS		% Ingresso SOS tirante bagno
		il resto � spare
		* Attenzione: il RoomController gestisce questi ingressi in autonomia, quindi non esporta gli allarmi nella T47ACCSTATOALLARMI
		* Andranno comunque configurati nella T22ACCTERMINALI perch� devono poter essere mappati dal MicronService
		* Identicamente, andranno configurati i corrispondenti allarmi sinottici
	6 output tipo relay (connettori "IAC_INPUT_PLATFORM_GPIO_x" dove 6<=x<=12)
		I primi due sono spare
		IN-OUT9 SC.OLC 		% Comando luci di cortesia
		IN-OUT10 SC.OBELL	% Comando campanello (simbolo campanello sul lettore)
		IN-OUT11 SC.OT		% Comando teleruttore servizi camera
		IN-OUT12 SC.OS		% Comando elettroserratura
	Batteria al litio (non ricaricabile, durata 5y) per real-time clock 28 MHz
	2 connettori per lettori RFID (connettori "IAC_INPUT_PLATFORM_READER_x" dove 1<=x<=2) (in modalit� 'antenna remotata')
		Lettore esterno
		Lettore interno
		* Attenzione che non � come il locbus
			* Anche la distanza � molto minore rispetto al locbus (max. 10m)
			* Lettore esterno e interno vanno collegati ai rispettivi connettori, la posizione � scolpita da codice! Se no poi si rischia che i LED non funzionino
- Componenti firmware/software:
	- Firmware Microhard 
	- Software BTRCTxxx.IFB (versione x.x.x)
		* Verr� implementato un applicativo lato MXP450 per upgrade firmware del RoomController
			Per il momento si utilizza il software Iseo IAC Firmware Updater, che richiede cavo locbus apposito
			Un simile applicativo richieder� l'arresto del modulo Karpos
				In quel caso, le stanze incluse nel locbus funzionano offline (il RoomController non riceve prenotazioni e non trasmette timbrature, ecc.)
		* v. tabella di compatibilit� RoomController-Karpos
		Comandi inclusi: 
			Tabella white list (200 righe), salvate su flash solo dopo 2 minuti senza aggiornamenti dall'MXP450
				Include: codice badge, data-ora inizio validit�, data-ora fine validit�, attributo GUEST/STAFF, attributo SUITE
				% La tabella � ereditata da MXP450 (che l'ha a sua volta ricevuta dal MicronService), inviata via kConnector e Karpos alla memoria flash del RoomController
				% � il modulo Karpos che si occupa di tenere il pacchetto white list in un buffer, da cui lo estrarr� appena la scheda RoomController � collegato e online sul locbus
				% Il buffer suddetto � nella cache del processo Karpos, quindi evitare di killare il processo senza usare il kManager (che salva invece il buffer in /uSD/ROOMCTRL/'queue [device_code]')!
				% Se si dovesse perdere il buffer del RoomController, � sufficiente reinviare il comando WhiteLists
			Tabella timbrature (50 righe), salvate su RAM				
			Gestione di stanza

Nuova scheda VMN432 (Lettori RFID di camera)

- Caratteristiche hardware:
	Lettore esterno
		6 retroilluminazioni, di cui 3 tasti (centrale e riga in basso)
			riga superiore: camera occupata/non occupata 
			riga in alto: non disturbare, prenota pulizia 
			riga centrale: campanello
			riga in basso: transito accettato, transito rifiutato
	Lettore interno ("lettore tasca")
		3 retroilluminazioni, di cui 3 tasti
			riga centrale: non disturbare (disattiva il campanello) e attiva non disturbare sul lettore esterno
			riga in basso: SOS (disattiva SOS), prenotazione pulizia (attiva prenota pulizia sul lettore esterno)
				* Prenota pulizia pu� essere anche remotato su un comando esterno tipo pulsante e collegato all'input AUX
	* Il sistema prevede la presenza di entrambi i lettori per ogni RoomController
		Se fossero previsti varchi per cui il lettore interno non serve (es. motivi estetici, varchi non adibiti a camere, locali di manutenzione, ecc.), si pu� installare anche solo il lettore esterno
		Con la stessa configurazione, il solo lettore esterno funziona esattamente come un lettore di controllo accessi standard, per aprire una porta
		In pi�, c'� anche la funzione del campanello con il corrispondente output
		* Nel caso in cui si scollegasse la testina interna, e si fosse resettata l'elettronica RoomController, non basta ricollegarla per far funzionare tutti i tasti (l'antenna RFID funziona).
			Bisognerebbe inviare un reset software al RoomController, da web request oppure da tasto sull'elettronica


Configurazione impianto:

MicronConfig >= 7.5.32
* Un MXP450 pu� gestire sullo stesso locbus sia dei lettori Kleis sia dei terminali RoomController
* Un RoomController per stanza, dotato di 2 lettori RFID
- Varco camera con 2 out di varco per le abilitazioni degli ospiti:
	out1 software: GUEST (per distinguere da Staff)
	out2 software: SUITE (per identificare la prenotazione Suite)
- Tabelle > Tipi varchi:
	0001 CAMERA		% Da associare ai varchi Camera
	0002 AREA COMUNE	% Da associare ai varchi Aree Comuni
	0003 SERVIZIO		% Da associare ai varchi Servizio
	ecc.
	* � fondamentale distinguere i varchi con tipo=Camera dagli altri: il MicronHotelWS ha infatti una request (POST /api/Entrances) che si basa su questo valore
		Con questa funzione, SmartHotel ottiene dal database MRT l'elenco dei varchi e dei terminali, ciascuno con le proprie caratteristiche
		In questa maniera, SmartHotel ottiene una mappatura di tutto l'impianto - per sapere quali sono le camere (e quindi le potenziali suite), le aree comuni (ristoranti, cucina, ecc.), ecc.
- Nuovo dispositivo RoomController
- Avendo una gestione autonoma, i varchi dipendenti da RoomController NON necessitano la configurazione della Serratura
- RoomController > Input:
	* Nonostante siano comunque gestiti dall'elettronica, vanno configurati su MicronConfig per fare in modo che MrtWebServiceHotel li riceva come allarmi
	* Gli ingressi in questo caso sono logici, da NON confondere con quelli fisici - che invece NON sono monitorabili a livello software
	* Copiare tutti gli input negli allarmi sinottici, cos� da ricevere notifica degli ingressi.
	* In assenza di input e allarmi, il RoomController funziona lo stesso, ma non trasmette niente al server.
	in0	Effrazione varco
	in1 	Presenza GUEST
	in2	Presenza STAFF
	in3 	Stato DND
	in4	Stato SOS
	in5	Stato AUX
	in6	Stato offline Lettore1 (da implementare)
	in7	Stato offline Lettore2 (da implementare)
- RoomController > Parametri > RoomController
* Ad ogni setup, il modulo Karpos si accorge che esistono schede RoomController sotto il proprio locbus e ri-bootstrappa l'applicativo a bordo dell'elettronica
	AuxMode	= Stato			% Aux: Stato= cambio di stato a seconda dell'input fisico, Commutazione= segue lo stato del digital input
	AuxSMode = Mai			% Aux: Aux State (da scegliere se AuxMode=Modalit� Stato): Mai, Sempre, Ospite (occupato solo da GUEST), Personale (occupato solo da STAFF), Disponibile, Occupato
	AuxTmodeExt = disabilitato	% Aux: Aux Toggle (da scegliere se AuxMode=Modalit� Commutazione) External Reader: disabilitato, abilitato, abilitato ON, abilitato OFF
	AuxTModeOff = Mai		% Aux: Aux Toggle (da scegliere se AuxMode=Modalit� Commutazione) Off: Ospite (occupato solo da GUEST), Personale (occupato solo da STAFF), Disponibile (0), Occupato
	AuxTModeOn = Mai		% Aux: Aux Toggle (da scegliere se AuxMode=Modalit� Commutazione) On: Ospite (occupato solo da GUEST), Personale (occupato solo da STAFF), Disponibile (0), Occupato
	AuxTModePocket = disabilitato	% Aux: Aux Toggle (da scegliere se AuxMode=Modalit� Commutazione) Internal Pocket Reader: disabilitato, abilitato, abilitato ON, abilitato OFF
		* Nota: input fisico, input digitale e tasto "timbratura accettata" su lettore esterno possono attivare l'Aux
		* Il fatto che l'input da lettore sia abilitato dipende dai parametri AuxTmodeExt e AuxTmodePocket
		* In ogni caso, l'on e l'off dell'Aux sono abilitati a seconda dei parametri AuxTModeOff e AuxTModeOn
	BellPulse = 1000		% Campanello: Durata dell'impulso per il campanello in millisecondi
	CourtesyMode = impulso		% Luci di cortesia: Impulso= segnale impulsivo all'inserimento del badge nel lettore tasca o all'ingresso; commutazione= cambio stato a seconda dell'input fisico
	CourtesyTime = 10		% Luci di cortesia: Durata delle luci di cortesia in secondi
	DoorFilterTime = 20		% Porta: tempo di filtro apertura quando la camera � occupata, in secondi
	DoorPulse = 4000		% Porta: tempo di eccitazione dell'elettroserratura e di illuminazione del LED del lettore esterno, in millisecondi
	DoorTransitTime = 20		% Porta: tempo di transito in secondi a partire dalla timbratura, *a prescindere* dall'apertura/chiusura della porta stessa; � usato anche dopo aver rimosso il badge dal lettore tasca, per lasciare il tempo di uscire senza creare allarmi; se uguale a 0, non gestisce lo stato porta
	Enabled	= Enabled 		% Generale: Abilita o disabilita le automazioni di RoomController, ovvero tutti gli altri parametri; se disabilitato, il RoomController verr� considerato un modulo I/O standard (non ancora implementato)
	SuiteDevice = [device code]	% Suite: selezionare l'altro dispositivo con cui questo deve creare una Suite
	SupplyExtraTime = 30		% Tempo supplementare servizi alimentazione, in secondi
- RoomController > Parametri > Reader > [specificare tecnologia di lettura sulla testina N1]
	Per il momento, le tecnologie utilizzate nei progetti Hotel sono:
		13-MIFARE UID
		21-MIFARE DESFIRE
			Richiede CustomSmartcard = DESFIRE_GENERIC (ovvero formato Desfire masterizzato appositamente per SiemensHotel, quindi il badge dovr� essere scritto da Siemens)
				AID: 0x123456 (da definire)
			In questo caso, su KleisConfig:
				baudrate: 38400
				locbus type: RoomController
				Template > AID
				Template > File ID
				Template > Password (do not save)
			* La responsabilit� di configurazione del device (e della manutenzione del database delle password, per ogni cliente!) va data al fornitore (Microntel) o all'installatore (Siemens)				
Esempio di impianto:
	Impianto PIANO TERRA: varchi INGRESSO HALL, UFFICIO RECEPTION, PALESTRA, LAVANDERIA, PISCINA
	Impianto PIANO 1: varchi CAMERA 101, CAMERA 102, ..., RISTORANTE, ecc.


Livello applicativo:

- Le propriet� anagrafiche sono sincronizzate con DesigoSmartHotel tramite MrtHotelWS
- Aziende interne obbligatorie
	cod. GUEST (parametrico da MicronConfig > Parametri > MrtHotelWS)
	cod. STAFF (parametrico da MicronConfig > Parametri > MrtHotelWS)
		Deve contenere: personale di staff (es.cameriera), direttore, pulsante apriporta
- Personale Staff e Direzione pu� essere gestito con white list di gruppo
- I Guest, invece, vanno gestiti con abilitazioni personali
	validit� di abilitazione infinita (tanto l'autorizzazione vera e propria � gestita da DataOraInizioMatricola e DataOraFineMatricola)
	varchi comuni gestiti normalmente (anche come Gruppo di Varchi)
	varchi camera gestiti con out varco "GUEST" o "SUITE" (i due sono cumulativi, non mutualmente esclusivi)
		L'out di varco "GUEST"
		L'out di varco "SUITE" � per ospiti che hanno prenotato una suite
			Una suite � un ambiente costituito da pi� stanze fisiche (in realt� da SmartHotel arrivano profili su entrambe le stanze)
			Nel caso di suite, i RoomController si parlano tra di loro e replicano la sola funzionalit� di 'presenza in stanza'
			Quindi, nell'esempio: Se la suite � costituita da camera 101 e 102, allora Camera 101 con outvarco "SUITE" e Camera 102 con outvarco "SUITE" sono equivalenti nel profilo d'accesso
			* La Suite pu� essere costruita da dispositivi presenti sotto la stessa centralina, ma su canali locbus diversi
		* Gli out di varco arrivano da SmartHotel con requests diverse

	
Livello WebService:
- Nuovo web service MicronHotelWS tipo REST basato su JSON, in ascolto verso il software SmartHotel
	http://ip-address:port/micronhotelws/swagger/index.html
- L'utility swagger serve a simulare le chiamate di SmartHotel, utilizzabile per diagnostica da browser
- Tra le requests verso MicronHotelWS c'� anche la possibilit� di eseguire comandi da remoto
	Il sistema SmartHotel infatti � integrato con un app su smartphone da cui � possibile inviare:
	com.1	Reset SOS
	com.2	Reset AUX
	com.3 	Reset DND
	com.4	Reset SUITE	% Da usare in caso di disallineamenti tra un RoomController e l'altro nella Suite
	com.12	Set AUX
	com.13 	Set DND
	com.14	Set SUITE	% Imposta la gestione presenza tipo Suite
	com.255	Reboot
- Parametri:
	Codice Azienda Interna per ospiti = GUEST
	Codice tipo varco per camere hotel = [codice tipo varco Camera]
		* Ogni volta che da SmartHotel il MicronHotelWS riceve un profilo d'accesso, se questo � un tipo varco Camera, allora aggiunge automaticamente al profilo d'accesso il comando di varco GUEST
	Codice comando di varco per Camera Utilizzata come Suite = 2
	Codice comando di varco per Camera Occupata da Ospite = 1
	Fascia oraria di default = 0001-Always
	Codice Azienda Interna per personale = STAFF
	Numero traccia badge = 1
	Chiave per generazione token autenticazione Swagger = [random]


Come si usa:

* NOTA: inserendo il jumper JP_SW_SPARE prima di dare alimentazione, l'elettronica RoomController � autoconfigurata in modalit� demo ANCHE SENZA collegamento locbus all'MXP450
	Questo tipo di funzionamento ha una serie di parametri di default e sovrascrive interamente la configurazione precedente.
	La funzionalit� demo si sostituisce alla configurazione eventualmente gi� presente sulla scheda fino al prossimo riavvio della scheda in mancanza di jumper.
	I parametri di default sono:
		- UID 4byte (Mifare Classic): interpretato come GUEST
		- UID 7byte (Mifare Desfire): interpretato come STAFF
	Sempre in modalit� demo, premendo lo switch SW_1 si possono testare tutti i LED e le uscite digitali
	Tornando in modalit� normale (cambiando di nuovo il jumper JP_SW_SPARE), l'elettronica torna a funzionare con la configurazione precedente.


# FUNZIONALITA' MIC-COVID

### GNet

Configurazione MXP250 / MCT350:

Dove si collega:

- MXP250 () --> 
- MCT350 (connettore J4.5=GND, J4.6=In) --> In2 con stato a riposo ALTO

Firmware minimo: 3.4V (Solo ITALIANO)

- [Gest.Doc.] MicronConfig > Varco > OutVarco1 = HEALTH_PRIVACY
- [Gest.Doc.] MicronConfig > Varco > OutVarco2 = DISEASE_CERT
	** Attenzione: su MXP450 gli out di varco relativi alla documentazione sono parametrabili; su elettroniche GNet l'ordine è scolpito su firmware
- MicronConfig > TBase(MCT) > Ingressi > In2 (con stato a riposo High)
- MicronConfig > TBase(MXP) > MultiI/O > Ingresso6 = Face detect
- MicronConfig > TBase(MXP) > MultiI/O > Ingresso7 = HighTempDetect
- MicronConfig > TBase/KK > Testina1 > Setup Sorteggiatore >
	> Frequenza Sorteggiatore = 1, 
	> Out = [IMPOSTARE OUT, v.GPParam44]
	> SorteggiaIngresso = ENABLED
		*** Il firmware, in tutte queste funzionalità, gestisce esclusivamente la direzione di ingresso!
- MicronConfig > TBase/KK > GPParam39 = 			% Modalità di gestione
	= 0: controlli sanitari disabilitati. Il terminale funziona come normale controllo accessi
	= 1: controllo anche senza white list. Sono effettuati i controlli tramite dispositivo digitale
	= 2: controllo completo, sia documentale che su dispositivo digitale.
	es.GP39=1 su MCT privo di white list
- MicronConfig > TBase/KK > GPParam34 = 			% Modalità di rilevazione dello stato di salute e relativo timeout
	Nibble basso (bit 0..3): tempo di attesa, in secondi, del segnale di rilevazione termica (qualsiasi esso sia) - ovvero, quando tempo posso restare davanti alla videocamera perché essa mi rilevi la temperatura - durante questo periodo il lettore rimane in attesa
	Nibble alto (bit 4..7): Valore 1 (0001) rileva buono stato di salute (tipo “tablet”). 
				Valore 2 (0010) rileva cattivo stato di salute (tipo termocamera Hikvision)
	es. tablet in uso, 5 secondi di attesa = 00010101bin = 21dec
	Una formula veloce può essere 
		- GP34=16+[secondi] per il tablet
		- GP34=32+[secondi] per la videocamera
	Se ne deduce il tempo massimo di attesa è 1111bin=15dec, cioè 15 secondi
- MicronConfig > TBase/KK > GPParam41 =			% Dispositivo di Face Detection (SOLO se necessario)
	Il parametro indica l’indirizzo Lockbus del dispositivo Kx50 che gestisce l’eventuale segnale di Face Detection. L’ingresso digitale di tale dispositivo è Inout1 (Ingresso 6, in MicronConfig). Se in fase di timbratura non viene rilevato questo ingresso, la timbratura stessa termina con Reply=8, Status=3.
	Il valore 0 indica che non è presente un segnale di Face Detection.
	es. GP41=1 (KX50 con indirizzo 1)
- MicronConfig > TBase/KK > GPParam42 =			% Dispositivo di rilevazione termica
	Il parametro indica l’indirizzo Lockbus del dispositivo Kx50 che gestisce il segnale di rilevazione termica.
	L’ingresso digitale di tale dispositivo è Inout2 (Ingresso 7, in MicronConfig)
	Se applicato sul terminale base (per il momento *SOLO* MCT), vale il valore fisso GP41=255.
	Il valore 0 indica che non è presente un segnale di rilevazione termica.
	es. GP42=1 (inout2 sul KX50 con indirizzo 1)
	es. GP42=255 (in2 sul MCT)
- MicronConfig > TBase/KK > GPParam44 =			% Segnalazione tramite digital out
	Tramite questo parametro è possibile utilizzare i parametri del sorteggiatore imparziale per una eventuale segnalazione esterna (lampada, cicalino) e per impedire ulteriori timbrature per un numero di secondi specificato in GPParam31. Il normale funzionamento del’imparziale, in questo caso, è disattivato.
	es. GP44=1 (Utilizza la configurazione del sorteggiatore imparziale per il digital out)
- MicronConfig > TBase/KK > GPParam31 =			% Durata del digital out	
	L'attivazione del digital out del sorteggiatore imparziale impedisce ulteriori timbrature per tutta la durata specificata qui.
	es. GP31=15 (Digital out per 15 secondi)

Utilizzo:
Il display (o la testina) mostra:
	- "CERTIFICATO MALATTIA IN CORSO" ("CERTIF CHK")
	- "MANCA DOCUMENTAZIONE PRIVACY" ("NO PRIVACY")
	- "VISO NON RILEVATO" ("NO FACE")
	- "ANOMALIA IN CONTROLLI SANITARI" ("HEALTH CHK") (T>Tallarme oppure NoMask nel caso di tablet)






### KARM

Prerequisiti software
MicronService >= 7.5.402
MicronPass >= 7.5.401
MicronConfig >= 7.5.38

MCT700 senza locbus:

	Prerequisiti firmware
		package >= 1.4.0
		kDisplay >= 1.4.2w

	Tablet Ganz:
	- Parametri > HealthChecks > HDInDevice = [se stesso]
	- Parametri > HealthChecks > HDInNum = 0 			% Mettendo 0, il firmware presuppone l'uso dell'unico input presente sull'elettronica dell'MCT700
	- Parametri > HealthChecks > HDMode = Rileva stato di buona salute (ingr.dig.)
	- Parametri > HealthChecks > HDTime = 5
	- Parametri > HealthChecks > Mode = Controlli sanitari senza gestione documentale
		
	*Il controllo sanitario è applicato sempre solo nella direzione di ingresso*

### Micronpass Web

Prerequisiti hardware:
	Videocamera HIKVISION modelli DS-K1T671TM / DS-K5671-3XF (tornello)
	- Entrambi i modelli sono dotati di wi-fi
	- Sensore all'ossido di vanadio (VOx) non raffreddato
		Il sensore lavora con un cambio di resistenza, tensione o corrente quando riscaldato da radiazione infrarossa: i valori delle grandezze elettriche modificate sono poi comparati ai valori di temperatura operativa
	- Richiede un ambiente con aria condizionata controllata (10-35°C)
	- Se la temperatura rilevata supera una temperatura di soglia, la videocamera va in "allarme" e può essere configurata per cambiare lo stato dell'out digitale
		È proprio lo stato del segnale che la centralina MXP450 va a leggere per convalidare la timbratura
	

Chiamiamo "postazione di controllo":
	a. Postazione standard allestita PRIMA dei tornelli periferici (v. STANDARD)
	b. Postazione standard allestita SUI tornelli periferici (v. STANDARD)
	c. Postazione custom Freudenberg allestita PRIMA di alcuni varchi critici (v. CUSTOM)
		Custom perchè include:
		i. Disabilitazione automatica della matricola (ARM/GNet)
		ii. Controllo on-line via plug-in MicronService (solo ARM)


Procedura di controllo STANDARD:

0) Controllo di white list

1) Gestione documentale - Attestato di malattia DISEASE_CERT
	=TRUE		% Procede
	=FALSE		% ovvero Certificato di Malattia in corso di validità: transito rifiutato con apposito flag T37ESITO=bit3, T37STATUS=2 e salvato su registro anagrafico

	- Abbinare alle matricole D/E uno o più documento/i tipo DISEASE_CERT (attestato di malattia, PDF o JPG) con data di fine malattia obbligatoria
		associato all'anagrafica dipendente tramite HR
		associato all'anagrafica dipendente tramite HR
	Se un documento DISEASE_CERT ha data di fine malattia ancora in vigore, i varchi anti-Covid-19 impediscono l'accesso
	** Se non esistesse un documento fisico, è previsto un Wizard apposito per la generazione del documento virtuale
	** Richiede gestione documentale dipendenti e esterni

2) Gestione documentale - Accettazione della privacy verifiche sanitarie:
	=TRUE		% Procede
	=FALSE		% ovvero Documento della Privacy Sanitaria scaduto o assente: transito rifiutato con apposito flag T37ESITO=bit3, T37STATUS=1 e salvato su registro anagrafico

	- Abbinare alle matricole D/E/V un documento unico tipo HEALTH_PRIVACY (accettazione privacy sanitaria, PDF o JPG) con eventuale data di scadenza
		automaticamente/manualmente associato all'anagrafica dipendente tramite HR
			*** Abbinamento automatico tramite MicronImport: decidere con HR riguardo a questo
		automaticamente/manualmente associato all'anagrafica esterno tramite HR
			*** Abbinamento automatico tramite MicronImport: decidere con HR riguardo a questo
		associato all'anagrafica visitatore durante la registrazione insieme all'accettazione privacy (appReception/MrtVisitors)
	Se il documento HEALTH_PRIVACY è assente o con data scaduta (l'assenza della data implica una validità infinita), allora i varchi anti-Covid-19 non controllano la persona e impediscono l'accesso
	** Se non esistesse un documento fisico, è previsto un Wizard apposito per la generazione del documento virtuale
	** Richiede gestione documentale dipendenti e esterni

3) Controllo di idoneità sanitaria
	=TRUE		% Transito completato e accettato
	=FALSE		% Transito rifiutato con apposito flag T37ESITO=bit3, T37STATUS=3 e salvato su registro anagrafico

	- Lo strumento per il controllo di idoneità sanitaria è una videocamera termica ed eventualmente a riconoscimento facciale
		Un uso ottimale della videocamera termica richiede:
		a. distanza 1.5-2m con ottica da 3mm
		b. inclinazione <20° rispetto al soggetto da inquadrare
		c. tempo-spazio di acllimatamento termico (~2min) per le persone che arrivano da fuori
	- La videocamera si interfaccerà su ingresso digitale sia con MXP250 sia con MXP450
	- Al momento non è possibile interfacciarsi a livelli superiori (es. TCP/IP, HTTP, ecc.): l'SDK della videocamera non è studiato per integrazioni con architettura ARM Imx6

	** Richiede una personalizzazione firmware MXP450 per la gestione dei segnali digitali della videocamera

** Richiede nuova tabella REGISTROSANITARIO (Data-ora, matricola, tipomatricola, azienda, varco, terminale, tipo evento, descrizione evento)
	La tabella NON è modificabile dall'utente ed è sottoposto a cancellazione secondo le regole GDPR
** Richiede i comandi di varco HEALTH_PRIVACY e DISEASE_CERT interpretati da MicronService
** Richiede nuova sezione parametri HEALTHCHECKS
	HEALTHCHECKS > DISEASECERT = 0		% N. Comando di varco per disease certification check
	HEALTHCHECKS > HEALTHPRIVACY = 0	% N. Comando di varco per health privacy documentation check
	HEALTHCHECKS > MODE = 			% Modalità di funzionamento
		0 = Controllo sanitario disattivato
		1 = Controllo sanitario obbligatorio a prescindere dai controlli documentali, utilizzabile anche senza white list
		2 = Controllo sanitario completo e controllo documentale
	HEALTHCHECKS > INDEVICEFD = 0		% Dispositivo con videocamera a riconoscimento facciale
	HEALTHCHECKS > INNUMFD = 0		% Ingresso con videocamera a riconoscimento facciale
	HEALTHCHECKS > INDEVICETD = 0		% Dispositivo con videocamera termica 
	HEALTHCHECKS > INNUMTD = 0		% Ingresso con videocamera termica
	HEALTHCHECKS > RAFFLER = 0		% Funzione raffler (0/1)
** MicronService usa nuovo valore in ESITO (bit3 = altri motivi)
** MicronService usa nuovi valori in STATUS (1 = mancanza accettazione HEALTH_PRIVACY, 2 = certificato medico in corso DISEASE_CERT, 3 = controllo sanitario non superato)
	L'uso dei nuovi valori per MicronService salva entrambi i dati nella T025PROFILE del terminale, rendendolo indipendente dal server



Procedure aggiuntive CUSTOM:

1) Job di disabilitazione: disabilita automaticamente l'anagrafica su tutto il sistema di controllo accessi a seguito del controllo sanitario
	- Realizzabile anche per impianti misti Gnet/ARM o solo GNet
	- è incluso un meccanismo di notifica email/SMS a più destinatari
	- La riabilitazione della matricola e la sua uscita dall'edificio andranno gestite manualmente
2) Inibire l'accesso a determinati varchi periferici in assenza del passagio dalla postazione di controllo
	- Realizzabile solo da parte di varchi basati su elettroniche ARM (su cui è possibile implementare l'uso dei plugin MicronService)
3) Report personalizzato dei transiti "anomali", ovvero fatti su varchi esistenti SENZA essere passati dalla postazione di controllo
	- Ovviamente questa soluzione è esclusiva, o comunque di priorità inferiore, rispetto alla sol.2

### Plugin

- Pacchetto disponibile in /MRT/MRT_FX4_PC_EXE/MicronServicePlugins
- Copiare e spacchettare $CheckPoint110 dentro MPW\ServicePlugin
- Configurazione del plugin nel file msrv_checkpoint_0110.dll.config
- Imposta la gestione dei Falsi Positivi:

	*** La gestione dei Falsi Positivi è pensata per tutte quelle realtà in cui:
		a. il dipendente passa dal varco anti-Covid e non risulta conforme a uno dei controlli
		b. per il punto a, la matricola associata al dipendente viene disattivata automaticamente (T26FLAGABIL='0', T26UTENTEMODIFICA='MicronService')
		c. il dipendente è soggetto per policy interne a una nuova misurazione, fatta in maniera indipendente
		d. il dipendente risulta conforme al secondo controllo sanitario e quindi viene riattivato
			i. può essere riattivato da Micronpass Web (MatricolaAttiva=ENABLED)
			ii. può essere riattivato da MicronpassMVC (RiattivaMatricola - abilitato SOLO SE T26UTENTEMODIFICA='MicronService')
		e. 
	

    <!-- Se vuoto considera valide solo timbrature accettate -->
    <!-- Altrimenti indicare lo status (o gli status separati da virgola) di timbratura di controllo -->
    <!-- sanitario da considerare comunque validi: -->
    <!-- 1 = Mancata accettazione privacy sanitaria -->
    <!-- 2 = Certificato di malattia in corso di validità -->
    <!-- 3 = Controllo sanitario anti Covid-19 non superato -->
    <add key="FalsiPositivi" value="" />

- Imposta l'architettura di controllo, inserendo i varchi che eseguono il controllo (<Varco>) e i varchi oggetto di controllo (<VarcoControllato>)

  <!-- Varchi di timbratura con elenco varchi controllati e scadenza max minuti -->
  <!-- inoltre occorre indicare la direzione 1=Solo entrata, 2=Solo uscita, 3=Entrata e uscita-->
  <Varchi>
    <Varco Codice="00000001" Verso="3">
      <VarchiControllati>
        <VarcoControllato Codice="00000002" MaxMinuti="17" />
      </VarchiControllati>
    </Varco>
  </Varchi>
  
  <!-- 
    ESEMPIO

    Le timbrature rilevate sul varco 12345678 vengono validate per la presenza di almeno
    una timbratura accettata entro 7 minuti sul varco 77777777 o entro 4 minuti sul varco
    88888888. Il controllo di timbratura viene effettuato sia in ingresso che in uscita
    
    <Varco Codice="12345678" Verso="3">
      <VarchiControllati>
        <VarcoControllato Codice="77777777" MaxMinuti="7" Direzione="1" />
        <VarcoControllato Codice="88888888" MaxMinuti="4" />
      </VarchiControllati>
    </Varco>

  -->

- L'esito restituito dal plugin (esito=8, status=4 "Controllo plugin non superato", evento di tipo Generico) va a completare la timbratura nella T116ACCBUFFER
- La descrizione dell'evento risiede nel parametro 

A. Normale varco di controllo accessi
	HEALTHCHECKS>Mode=Disabilitato
B. Mode=Controlli documentali
	HEALTHCHECKS>DiseaseCert=
	HEALTHCHECKS>HealthPrivacy=
C. Mode=Controlli sanitari integrati con gestione documentale
	FaceDetection(FD):
		HEALTHCHECKS>FDInDevice=	(0=disabilitato)
		HEALTHCHECKS>FDInNum=
		HEALTHCHECKS>FDLevel=
		HEALTHCHECKS>FDTime=
	HealthDetection(HD):
		HEALTHCHECKS>HDMode=
			Rileva stato di malattia (ingr.dig.)	es. HIK-VISION
			Rileva stato di buona salute (ingr.dig.)	es. GANZ
			Termocamera				es. HIK-VISION (HTTP)
		HEALTHCHECKS>HDInDevice=
		HEALTHCHECKS>HDInNum=
		HDLevel= Normal(High)/Inverted
		HEALTHCHECKS>HDTime=

### Tablet GANZ

Hardware

Problematiche riscontrate:

Il tablet ha un firmware interno che gestisce autonomamente il controllo sanitario e la timbratura.

NB: In alcuni casi il tablet potrebbe rispondere "protesi": in questo caso intende che non identifica il volto, ed i casi possono essere:
	a. persone di colore con mascherina nera	
	b. colore della mascherina troppo simile al colore della pelle
	c. sorgente luminosa troppo intensa dietro alla persona
	d. mascherina personalizzata non identificata dal database

Compatibilmente con la disponibilità del cliente, al verificarsi del caso, può essere eseguire delle foto della persona con la mascherina indossata per poterla caricare sul database.
Nella prossima release di firmware del tablet la segnalazione “protesi” dovrebbe essere modificata (non ancora identificato con cosa).

E’ anche emerso che la temperatura rilevata dal tablet sulla persona cambia se indossata o non la mascherina, la misurazione è esatta con mascherina ed aumenta in mancanza della stessa, 
è quindi fondamentale dal cliente fare presente che le misurazioni devono essere eseguite tutte con o tutte senza mascherina.
In caso di misurazione con mascherina, sulle impostazioni non è necessario eseguire nessuna azione, viceversa,
in misurazione senza mascherina, è necessario eseguire una misurazione con un termometro manuale, verificare la misurazione del tablet e compensare la stessa nelle impostazioni della pagina web
“Temperature-taking setting” con un valore di solito pari a -0.500000 (il segno - meno davanti indica una diminuzione della temperatura rilevata, nessun segno indica un aumento della temperatura rilevata)

E’ sempre opportuno consigliare al cliente la misurazione con mascherina in quanto se il tablet è settato per rilevare indistintamente con e senza mascherina, una persona con 37,5° effettiva, 
se indossa la mascherina viene rilevata con 37° e quindi può accedere.

Alla ricezione di aggiornamenti firmware, verrà inviata comunicazione e gli stessi saranno salvati sul server.
A disposizione per chiarimenti.  


Configurazione tablet Ganz

Le ultime versioni firmware e software possono essere scaricate da https://www.ganzsecurity.eu/index.php/en7s02t
Versione di firmware minima: V20.3.22.5_K00017283.zip
Dalle ultime versioni firmware NON è più necessario installare il gestionale di controllo accessi SDP2000.

Configurazione del dispositivo da browser (Chrome o Firefox)

- Accesso:
	- Aprire http://192.168.1.88:7080
	- Login con credenziali di default:
		username:	admin
		password:	12345
- Versioni:
	- System > System Configuration > Version info 		% Versioni installate a bordo
- Data ora:
	- System > System Configuration > Date			% Impostazioni di data-ora
		> Time Zone						% Impostare la time zone
		> Set Date-time manually = [TRUE/FALSE]			% Impostare la data ora manualmente
		> Synchronize with the computer = [TRUE/FALSE]		% Impostare la data ora dal PC
		> Receive date-time from NTP				% Impostare la data ora da un server NTP
	- System > System Configuration > Dst			% Impostazioni ora legale
		> Daylight saving time = [TRUE/FALSE]			% Attiva/disattiva l'ora legale
- Gestione firmware:
	- System > System Configuration > Maintain
		> Reboot						% Riavvia il dispositivo
		> Restore factory settings				% Riporta allo stato di fabbrica
		> Upgrade (Browse/Upgrade)				% Uploada il file .img e lo applica
- Visualizzazione e UI:
	- System > System configuration > Display configuration
		> Display configuration = [IP ADDRESS, SERIAL or NAME]		% Cosa mostrare a display
		> Language = [ITALIANO, INGLESE, POLACCO, SPAGNOLO, FRANCESE, TURCO, GIAPPONESE]
		> Device Name						% Inserire il nome del dispositivo
		> Temperature scale = [CELSIUS, FAHRENHEIT]		% Unità di misura della temperatura
	- System > Volume > Volume					% Permette di alzare/abbassare il volume
	- System > Light > Light					% Permette di regolare la luminosità del display
- Rete:
	- Network > Basic Setup > TCP/IP				% Permette di modificare i parametri di rete
	- Network > Advanced Setup > SMTP				% Permette di inserire i parametri SMTP per l'invio della mail
- Funzionalità di utilizzo:	
	- Face Recognition > Face Recognition 
		> Stranger Passage = [TRUE/FALSE]		% Bypassa il sistema interno di controllo accessi
		> Detection Mask = [TRUE/FALSE]			% Per impostare l'obbligatorietà della mascherina
		> Relay time = [from 100ms to 10000ms]		% Tempo di attivazione del relè: mettere più corto possibile
		> Relay direction = [normal/reverse]		% Decidere per che cosa deve attivarsi il relè (normal= relè su buona salute, reverse=relè su cattiva salute)
		> Living body = [TRUE/FALSE]			% Capacità di distinguere le immagini 2D (tipo foto)
		> Thermal map = [TRUE/FALSE]			% Rilevamento termico
- Manutenzione:
	- System > Restart Timing > Restart Timing		% Imposta un orario di riavvio schedulato


#### Deprecato di sotto

- Installare il software SDP2000 sul server
	Attenzione: il computer su cui viene installato il software rimane indissolubilmente legato al tablet
	Il software si installa con avvio in esecuzione automatica
- Aprire http://localhost:8686 (Chrome) per aprire la pagina web ("Smart Device Platform") installata localmente
	L'indirizzo IP usato è uno di quelli disponibili sulle NIC della macchina
- Entrare con credenziali di default
	username:	admin
	password:	admin
- Collegare il tablet alla rete e attendere che si accenda
- Se la rete ha un DHCP, lui automaticamente si prende un indirizzo IP
	IP default: 192.168.1.140 (DHCP=Enabled)
- Smart Device Platform > Device > Search device > [leggere l'indirizzo IP dinamico assegnato]
- Per la configurazione del tablet, aprire IE>http://[INDIRIZZO-IP-TABLET]:7080, si apre la pagina "INtelligent Terminal"
	username:	admin
	password:	12345
- Intelligent Terminal > NEtwork > DHCP = FALSE
- Intelligent Terminal > Display Configuration > Language = [SET LANGUAGE]
- Intelligent Terminal > Temperature taking > Temperatura di compensazione = 0.000 [su questo dispositivo la compensazione va fatta manualmente, se necessario]
- Smart Device Platform > Device > Add
- Smart Device Platform > Device > Settings
	Basic paramters > 
	Network Config > 
	Remote config > 
		> Upgrade firmware					% Possibilità di aggiornare il firmware
		> Volume settings = 5					% Volume dell'interfaccia audio
		> Supplementary lighting setting = TRUE/FALSE		% Lucetta aggiuntiva sopra il display
		> Relay opening and closing control = [200ms-10s]
		> Restore factory settings
	Version info
	Function parameters > 
		> Temperature check = TRUE		% Controllo temperatura
		> Alarm temperature = 37.5		% Temperatura di allarme
		> Stranger access = TRUE		% Accetta gli sconosciuti
		> Check Mask = TRUE/FALSE		% Controlla la mascherina
		> Save Photo = TRUE/FALSE		% Salva le foto nel database mysql

- Per riportare allo stato di fabbrica,
	Intelligent terminal > Maintain > Restore Factory Settings
	Il terminale perde tutta la configurazione e CAMBIA l'indirizzo IP

### Videocamera HIKVISION

Installazione postazione rilevazione temperatura

ARCHITETTURA:

Componenti standard:
	- MXP450
	- KL
	- KX
	- Videocamera HIKVISION DS-2TD2617B (richiede ETH e POWER 12VDC/220VAC, può anche essere PoE)

- Distanza testata 2m dal lettore KL
	Sono disponibili distanze maggiori, cambiando l'ottica della telecamera
	Con un'ottica diversa NON sono state testate le configurazioni
	La telecamera venduta corrisponde a queste quote
	Per configurazione interna, NON vede facce oltre i 3m
- Altezza ottimale 2.2m (a parete, *non* a soffitto, altrimenti bisogna cambiare la configurazione interna)
- La videocamera NON è da esterno
- La videocamera NON va installata nei pressi di fonti termiche rilevanti (sole, ventole, fan coil, etc.)
- La videocamera ha due soglie:
	- Preallarme (T>35.5): segnalazione contenente i dati della temperatura letta
	- Allarme (T>37.5): segnalazione di temperatura superiore alla temperatura di soglia 
	Se al di sotto della temperatura di preallarme, la videocamera NON invia niente

CONFIGURAZIONE:

Hardware

Configurare videocamera:
(è possibile uploadare un template di configurazione standard)
IP default: 192.168.1.64
	Utente amministratore: admin, M!cr0ntel
	Utente operatore (solo Live): cliente, Cl!ente1
	% Fino a 3 login errati sono autorizzati prima del blocco login
- Upgrade firmware (digicap.dav) 
- Impostare indirizzo IP di produzione
	Configurazione > Rete > Disattivare DHCP
	Configurazione > Rete > TCP/IP > [IMPOSTARE PARAMETRI DI RETE] > Salva
	Configurazione > Rete > Impostazione avanzate > Ascolto HTTP > IP destinazione = [IMPOSTARE IP DEL MXP450]
									> Porta = 8080		
		% Il pulsante TEST conferma se c'è qualcuno in ascolto a quell'indirizzo su quella porta
		% Questo è importante perché la videocamera deve sapere a quale destinazione inviare i messaggi
		% Potenzialmente si potrebbero avere più videocamere per terminale MXP450	
- Configurazione > Manutenzione > Aggiornamento e manutenzione > Importa config.file > [BROWSE CONFIGURATIONDATA FILE] > Importa
	% L'upload del template mantiene lo stesso indirizzo IP di partenza
- Configurazione > Rilevamento temperatura > Impost. di base > [IMPOSTA AREA DI DISEGNO]
-
- È possibile anche configurare nuovi utenti (tipo UTENTE) che abbiano solo la visibilità del video live



Logica del firmware MXP450:
(Al momento non ancora implementato su MCT700)
1) La videocamera invia pacchetti TCP con la lettura in tempo reale
	La videocamera invia anche la differenza tra preallarme e allarme (tramite flag)
	* Da pagina web della videocamera:
		Configurazione > Configurazione temp. corporea > Allarme se la temperatura = [IMPOSTA T_ALLARME]
		Configurazione > Configurazione temp. corporea > Temperatura di preallarme = [IMPOSTA T_PREALLARME]
2) L'MXP450 continua a ricevere i pacchetti della videocamera e tiene in memoria i pacchetti con corrispondente timestamp
	NB: al momento non è ancora stato implementato un meccanismo di 'keepalive' per controllare lo stato della videocamera
3) L'utente timbra sul lettore
4) L'MXP450 va a controllare i pacchetti con timestamp corrispondente agli ultimi N secondi (parametrabile)
	Se messaggio con preallarme, prosegue con il flusso di timbratura
	Se messaggio con allarme, scatena il messaggio di errore


- La videocamera invia messaggi TCP differenti per eventi di preallarme e di allarme, contenenti l'informazione della temperatura
	A quel punto il terminale MXP450 riceve l'informazione e gestisce gli output di sorta
- La videocamera ha solo 1 output fisico: per MXP450 è inutilizzato perché viene gestita la messaggistica TCP
	Per MXP250 è possibile utilizzarlo, ma si sappia che il sistema NON è integrato allo stesso livello che con l'MXP450 (è un po' "degradato")
- La videocamera effettua un riconoscimento facciale 2D basato sugli occhi
	La videocamera quindi legge ANCHE facce visualizzate su un display
	Questo però è comune a tutti i dispositivi dotati di riconoscimento facciale
- La videocamera è molto più veloce nella misurazione della temperatura che non il Kleis nella lettura del badge
- Al termine dell'installazione, la videocamera richiede un'autocalibrazione che dura 15-30min prima di essere operativa


Software

Prerequisiti:
	Database MRT 7.5/4xx
		Script di upgrade:
		-	201912121059478_ExtendendVisitors.sql per passare alla versione 7.5.100
		-	202001031132139_CongedoVisitatore.sql per passare alla versione 7.5.200
		-	202002251338486_Mrt7510.sql per passare alla versione 7.5.300
		-	202004111624012_Mrt7513.sql per passare alla versione 7.5.400
	+ MicronConfig >= 7.5.36
	MicronService >= 7.5.402
	Micronpass Web >= 7.5.401
		In caso di upgrade da versioni <7.5.400 è necessario aggiornare web.config
	MicronpassMVC >= 7.5.12
	Firmware MXP450
	Firmware MXP250
	
Parte documentale dipendenti & esterni:
- MicronConfig > Parametri > Micronpass > 202-Gestione documentale dipendenti = [0/1]
- MicronConfig > Parametri > Micronpass > 203-Blocca dipendenti senza documenti = [0/1]
- MicronConfig > Parametri > Micronpass > 204-Gestione documentale coll.esterni = [0/1]
- MicronConfig > Parametri > Micronpass > 205-Blocca collaboratori senza documenti = [0/1]
- MicronConfig > Parametri > Micronpass > 208-Abilita controllo documenti HEALTH_PRIVACY = [0/1]
	% Permette di caricare un documento HEALTH_PRIVACY default per i dipendenti
	% Il caricamento consente l'inserimento di un nuovo documento, non la sovrascrittura di quelli già presenti
- Micronpass Web > Autorizzazioni > Dipendenti > Gestione documentale
- Micronpass Web > Autorizzazioni > Dipendenti > Wizard accettazione privacy sanitaria
- Micronpass Web > Autorizzazioni > Esterni > Gestione documentale
- Micronpass Web > Autorizzazioni > Esterni > Wizard accettazione privacy sanitaria
- Micronpass MVC > Impostazioni > Tipi documento > Nuovo > 
	Codice 
	Descrizione
	Numero massimo documenti per anagrafica
	Numero massimo di file per documento
	Consenti multilingua
	Scadenza obbligatoria
	Consenti modifica della scadenza
	Scadenza predefinita in giorni
	Avviso scadenza in giorni
	Sorgenti supportate

	% Inserire i documenti tipo HEALTH_PRIVACY e DISEASE_CERT
- Micronpass Web > [Dip.] > Nuovo documento > Tipo documento = 
- MicronConfig > Varco di controllo > OutVarco software = HEALTH_PRIVACY
	% Permette il controllo, a fronte di una timbratura, della presenza del documento HEALTH_PRIVACY
- MicronConfig > Varco di controllo > OutVarco software = DISEASE_CERT
	% Permette il controllo, a fronte di una timbratura, della presenza del documento DISEASE_CERT

Parametri Health-Checks:
- MicronConfig > MXP450 > Parametri > HEALTHCHECKS > FDINDEVICE 
- MicronConfig > MXP450 > Parametri > HEALTHCHECKS > FDINNUM
- MicronConfig > MXP450 > Parametri > HEALTHCHECKS > FDLEVEL
- MicronConfig > MXP450 > Parametri > HEALTHCHECKS > FDTIME
- MicronConfig > MXP450 > Parametri > HEALTHCHECKS > HDMODE
- MicronConfig > MXP450 > Parametri > HEALTHCHECKS > HDINDEVICE
- MicronConfig > MXP450 > Parametri > HEALTHCHECKS > HDINNUM
- MicronConfig > MXP450 > Parametri > HEALTHCHECKS > HDLEVEL
- MicronConfig > MXP450 > Parametri > HEALTHCHECKS > HDTIME

Parametri registro sanitario (Micronpass MVC)
- MicronConfig > Parametri > MicronService > 58-Frase per mancanza approvazione privacy in reg.san. = [es.TIMBRATURA RIFIUTATA PER MANCANZA HEALTH PRIVACY]
- MicronConfig > Parametri > MicronService > 59-Frase per presenza certificato di malattia in reg.san = [es.TIMBRATURA RIFIUTATA PER CERT.MED. IN CORSO]
- MicronConfig > Parametri > MicronService > 60-Frase per non superamento controllo anti-Covid19 in reg.san = [es.TIMBRATURA RIFIUTATA PER CONTROLLO SANITARIO]
	% Valido per varchi di controllo sanitario
- MicronConfig > Parametri > MicronService > 61-Frase per non superamento controllo sanitario al checkpoint = [es.TIMBRATURA RIFIUTATA PER CONTROLLO SANITARIO AL CHECKPOINT]
	% Valido per postazione stand-alone e successiva timbratura su varco con plug-in di controllo
- MicronConfig > Parametri > MicronService > 62-Blocca anagrafiche a seguito di non superamento controllo sanitario = [0/1]
	% Disabilita una matricola che non ha passato i controlli sanitari di cui ai parametri 61 e 62
- MicronpassMVC > Nuovo widget > 


UTILIZZO:

- Le distanze specificate sopra vincolano l'uso del lettore e della videocamera alla lettura di UNA PERSONA ALLA VOLTA
	Vuol dire che entro il campo della videocamera deve entrare al massimo una persona
	Solo in questa maniera è possibile associare timbratura e lettura termica
- Per l'uso ottimale della videocamera:
	- Seguire le distanze specificate sopra (la configurazione standard è stata testata su di esse)
	- Togliersi il cappello (impedisce la lettura della temperatura corporea)
	- Togliersi gli occhiali (sono molto sensibili alla temperatura, specialmente se metallici)


