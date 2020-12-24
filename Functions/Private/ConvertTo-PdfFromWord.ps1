# Converte i file Word (doc, docx) nel percorso LOCALPATH in Pdf
function ConvertTo-PdfFromWord {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, 
            HelpMessage = "Digitare il percorso completo in cui salvare i file")]
        [ValidateScript ( { Test-Path $_ } )]
        [string] $LocalPath  
    )

    # Apri applicazione Word
    $word = New-Object -ComObject word.application
    $FormatPDF = 17
    $word.visible = $false 
    $types = '*.docx', '*.doc'
    
    # Files nel percorso
    $files = Get-ChildItem -Path $LocalPath -Include $Types -Recurse -ErrorAction Stop
        
    # Conversione in PDF
    ForEach ($f in $files) {
        $path = $LocalPath + '\' + $f.Name.Substring(0, ($f.Name.LastIndexOf('.')))
        $doc = $word.documents.open($f.FullName) 
        $doc.saveas($path, $FormatPDF) 
        $doc.close()
        Write-Verbose "Ho convertito in PDF il file $($f.Name)"
    }

    # Chiusura applicazione Word
    Start-Sleep -Seconds 2 
    $word.Quit()
  
    # Pulizia dei file DOC
    Remove-item -Path "$LocalPath\*.doc","$LocalPath\*.docx"
    Write-Verbose "Fine conversione file DOC in PDF"

}