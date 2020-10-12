-- Versione installata
SELECT 
    T05VALORE AS [Versione installata] 
FROM T05COMFLAGS 
WHERE T05TIPO='DBVER'

-- Servizi btService con rispettiva GNetPath
SELECT 
    T03CODICE AS Codice, 
    T03DESCRIZIONE AS Descrizione, 
    CASE T03CONFIGGN 
        WHEN '' THEN 'KARM' 
        ELSE T03CONFIGGN 
        END AS [GNet Path] 
FROM T03COMSERVICES

-- Famiglie di firmware presenti sul campo
SELECT
    T22GNTYPE AS [Versione Firmware],COUNT(T22CODICE) AS [Terminali base attivi] 
FROM T22ACCTERMINALI 
WHERE T22KK='0' AND T22ABILITATO='1' 
GROUP BY T22GNTYPE

-- Terminali base attivi
SELECT 
    T22CODICE AS Codice, 
    T22DESCRIZIONE AS Descrizione, 
    T22GNTYPE AS [Firmware], 
    T22GNNUN AS RamoNodo, 
    T22GNIP AS IndirizzoIP 
FROM T22ACCTERMINALI 
WHERE T22KK='0' AND T22ABILITATO='1'
