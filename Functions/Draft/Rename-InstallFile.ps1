# Rinomina un nome file
# ad es. Input = '$FILENAME1234'
# ad es. Output --> FileName = 'FILENAME'
# ad es. Output --> FileVersion = [version]1.2.34


# $($file.Name).ToCharArray() 

function Rename-InstallFile {
    [CmdletBinding()]
    param (
        [string]$Path
    )

    $FileName = @() # Will store the file name as string
    $fileversion = @() # Will store the file version as version

    foreach ( $char in $($Path.Name).ToCharArray() ) {
        if ($char -eq '.') {
            break
        }
        $char

        # Check for special characters ('$')
        # Check for numbers and divide by Major, Minor and Patches

    } 

}