<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE
 
.NOTES

#>


# Tutti i servizi il cui eseguibile si trova in MPW
# Get-WmiObject permette la compatibilità con Powershell 5.1 (ma *NON* con Powershell Core)
Get-CimInstance win32_service | 
Where-object { $_.PathName -like "*$($Applications.RootFolderName)*" } | 
Select-Object -Property Name, PathName, StartMode, State | Format-Table
<#
Get-WmiObject win32_service | 
Where-object { $_.PathName -like "*MPW*" } | 
Select-Object -Property Name, PathName, StartMode, State | Format-Table
#>