# Converte file JSON in oggetto array
# Specificare il full path del JSON
# Il JSON contiene i dettagli dell'applicazione .NET e ASP.NET

# Struttura JSON:
#
#

function Get-Applications {
    [CmdletBinding()]
    param ( 
        [ValidateScript( { (Test-Path $_) -and ($(Get-Item $_).extension -eq ".json") } )]
        [string]$JsonFullPath 
    )
    
    Get-Content -Raw -Path $JsonFullPath | ConvertFrom-Json

}