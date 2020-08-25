# Modules
Import-Module WebAdministration
Import-Module IISAdministration



# Lista dei servizi il cui percorso contiene \MPW
Get-Service | Where-Object {$_.BinaryPathName -like '*MPW*'} | Select-Object Name,DisplayName,Status,StartupType,BinaryPathName | Format-Table

# Lista delle applicazioni web il cui percorso contiene \MPW
Get-Webapplication | Where-Object {$_.PhysicalPath -like '*MPW*' } | Select-Object path,PhysicalPath,applicationPool,enabledProtocols | Format-Table

# Lista degli application pool nell'IIS
Get-IISAppPool 

