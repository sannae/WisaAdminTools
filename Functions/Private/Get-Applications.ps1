<#
.SYNOPSIS
    Converte il contenuto di un file JSON in un oggetto PSCustomObject.
.DESCRIPTION
    Questa funzione è richiamata dal file principale del modulo
    In questo modo viene resa globale la variabile contenente i parametri principali dell'application suite.
.NOTES
    0.9 (da testare)
#>

function Get-Applications {
    [CmdletBinding()]
    param ( 
        [ValidateScript( { (Test-Path $_) -and ($(Get-Item $_).extension -eq ".json") } )]
        [string]$JsonFullPath 
    )
    
    Get-Content -Raw -Path $JsonFullPath | ConvertFrom-Json

}