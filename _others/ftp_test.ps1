# Install module (requires Internet connection)
Install-Module -Name PSFTP
# List available commands in the module
Get-Command -Module PSFTP

# ...

#ftp server 
$ftp = "ftp://79.11.21.211/" 
$user = "sanna" 
$pass = "edo89+0304"
$SetType = "bin"  
$remotePickupDir = Get-ChildItem '//79.11.21.211/MC_Commesse/CO Bausch/004_ModificheReport/Software/Report' -recurse
$webclient = New-Object System.Net.WebClient 

$webclient.Credentials = New-Object System.Net.NetworkCredential($user,$pass)  
foreach($item in $remotePickupDir){ 
    $uri = New-Object System.Uri($ftp+$item.Name) 
    #$webclient.UploadFile($uri,$item.FullName)
    $webclient.DownloadFile($uri,$item.FullName)
}