# Aggiunge una nuova causale a tutti i terminali di presenze
# NON vengono fatti controlli di ridondanza o di preesistenza! è una funzione molto artigianale...

function Add-NewCausalePresenze {
    [CmdletBinding()]
    param (
        [ValidateScript ( { $_.length -eq 4 } )]
        [string]$CodiceCausale,
        [string]$DescrizioneCausale,
        [ValidateScript ( { ( $_ -ge 1 ) -and ( $_ -le 8 ) } )]
        [int]$CodiceTastoFunzione # Inserire una sola cifra, sarà elaborata in seguito
    )

    # Elabora tasto funzione
    $CodiceTastoFunzione = '0' + $CodiceTastoFunzione.ToString() # <-- Questo ancora non funziona

    # Aggiungi causale
    $AddCausaleQuery = "
    -- Aggiungi causale
    DECLARE @CodiceCausale NVARCHAR(4) = '$CodiceCausale'
    DECLARE @DescrizioneCausale NVARCHAR(255) = '$Descrizionecausale'
    DECLARE @UpdateTime NVARCHAR(14) = CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS NVARCHAR(14))
    INSERT INTO T72ACCCAUSALIPRES VALUES ('0001',@CodiceCausale,@DescrizioneCausale,'INSTALLATORE',@UpdateTime)
    "
    Invoke-DatabaseQuery -Query $AddCausaleQuery

    # Setup Causale
    $Varchi = $( Invoke-DatabaseQuery -Query "SELECT DISTINCT T73VARCO AS VARCHI FROM T73ACCSETUPPRES" ).VARCHI

    ForEach ( $CodiceVarco in $Varchi ) {

        $SetupCausale = "
        -- Setup causali presenze
        DECLARE @Varco NVARCHAR(8) = '$CodiceVarco'
        DECLARE @TastoFunzione NVARCHAR(2) = '$CodiceTastoFunzione'
        DECLARE @CodiceCausale NVARCHAR(4) = '$CodiceCausale'
        DECLARE @UpdateTime NVARCHAR(14) = CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS NVARCHAR(14))
        INSERT INTO T73ACCSETUPPRES VALUES ('0001',@Varco,@TastoFunzione,@CodiceCausale,'INSTALLATORE',@UpdateTime)
        "
        Invoke-DatabaseQuery -Query $SetupCausale

    }
} 