/* Crea totali parziali */

-- Totale presenze
DECLARE @TotalePresenze NVARCHAR(100)
SET @TotalePresenze = (
	SELECT COUNT(*) AS [Totale Presenze MCT700] FROM T22ACCTERMINALI
	WHERE ( T22PRESENZEMODE = '1' OR T22MENSAMODE = '1' ) --Presenze o mensa
	AND T22KK='0' --Terminale base
	AND T22ABILITATO='1' --Attivi
	AND T22GNTYPE = 'KARM' --MCT700
	AND T22TIPOTESTINA = '13' --Mifare attivo
)

-- Totale accessi terminali base
DECLARE @TotaleAccessiCentraline NVARCHAR(100)
SET @TotaleAccessiCentraline = (
	SELECT COUNT(*) AS [Totale centraline MXP450] FROM T22ACCTERMINALI
	WHERE T22KK='0' --Terminale base
	AND T22ABILITATO = '1' --Attivi
	AND T22TIPOTESTINA = '255' --Nessuna tecnologia
	AND T22GNTYPE = 'KARM' --MXP450
)

-- Totale lettori controllo accessi
DECLARE @TotaleAccessiLettori NVARCHAR(100)
SET @TotaleAccessiLettori = (
	SELECT COUNT(*) AS [Totale lettori KL/KK] FROM T22ACCTERMINALI
	WHERE ( T22KK <> '0' AND T22KK < 30 ) --Dispositivo KK/KL	 	/* ATTENZIONE */
	AND T22ABILITATO ='1' --Attivi
	AND T22TIPOTESTINA = '13' --Mifare attivo
	AND T22GNTYPE = 'KARM' --Sotto MCT700 o MXP450
)

-- Totale attuatori
DECLARE @TotaleAccessiAttuatori NVARCHAR(100)
SET @TotaleAccessiAttuatori = (
	SELECT COUNT(*) AS [Totale attuatori KX50] FROM T22ACCTERMINALI
	WHERE ( T22KK <> '0' AND T22KK >= 30 ) --Dispositivo IO			/* ATTENZIONE */
	AND T22ABILITATO ='1' --Attivi
	AND T22TIPOTESTINA = '13' --Mifare attivo
	AND T22GNTYPE = 'KARM' --Sotto MCT700 o MXP450
)

/* Tabella finale */
DECLARE @TerminaliAttivi TABLE (TipoTerminale NVARCHAR(100), Quantità INT)
INSERT INTO @TerminaliAttivi VALUES
	('Terminali Presenze',@TotalePresenze),
	('Terminali Accessi Centraline',@TotaleAccessiCentraline),
	('Terminali Accessi Lettori',@TotaleAccessiLettori),
	('Terminali Accessi Attuatori',@TotaleAccessiAttuatori)
SELECT * FROM @TerminaliAttivi