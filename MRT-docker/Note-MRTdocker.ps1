<#

Alcuni link utili:
    * Interessante introduzione ai Container e Nano Server su Octopus : https://octopus.com/blog/nano-server-future-deployment-models
    * MS Learn's Administer-Containers-in-Azure Learning Path : https://docs.microsoft.com/en-us/learn/paths/administer-containers-in-azure/
    * FreeCodeCamp's Docker Handbook : https://www.freecodecamp.org/news/the-docker-handbook/
    * Stackify's start-to-finish guide to Docker for .NET : https://stackify.com/a-start-to-finish-guide-to-docker-for-net/
#>


# Install Docker (Windows Server)
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider
Restart-Computer -Force

# Pull ASP.NET 4.8 base image
Docker pull mcr.microsoft.com/dotnet/framework/aspnet:4.8
# Pull Windows 1809 as oledlg.dll source for Crystal Reports 
# https://stackoverflow.com/questions/55638049/docker-container-with-support-for-crystal-reports
Docker pull mcr.microsoft.com/windows:1809

# Check dockerfile here
# .......

# Build new image
docker build -t mpasswimage .

# Run (pull, create & start) container
docker run --name mpassw --publish 8080:80 --detach mpasswimage

# Run powershell on the container
docker exec -it mpassw powershell

# Powershell in the container: web configuration
> Remove-IISSite -Name "Default Web Site"
> New-IISSite -Name "mpassw" -BindingInformation "*:80:" -PhysicalPath "$env:systemdrive\MPW\Micronpass" -PassThru
> Get-IISSite -Name "mpassw"

# Powershell in the container: install Crystal Reports
$msiArguments64 = '/qn','/i','"CRRuntime_64bit_13_0_25.msi"'
Start-Process -PassThru -Wait msiexec -ArgumentList $msiArguments64
$msiArguments32 = '/qn','/i','"CRRuntime_32bit_13_0_25.msi"'
Start-Process -PassThru -Wait msiexec -ArgumentList $msiArguments32
# ----> Questa parte va in errore!

# Run cmd on the container
docker exec -it mpassw cmd

# Cmd in the container: modify permissions on folders 
> icacls C:\MPW\Micronpass /grant Everyone:(F)
> icacls \inetpub\wwwroot /grant Everyone:(F)


# Back to host: test web application with default browser
Start-Process 'http://localhost:8080'

# ----------------

# Rename container
# docker rename CONTAINER_NAME MY_NEW_CONTAINER_NAME

# Run a container after getting its ID
# docker start $(docker ps -aqf "name=ASPNET48")
