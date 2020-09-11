<#

Alcuni link utili:
    * Interessante introduzione ai Container e Nano Server su Octopus : https://octopus.com/blog/nano-server-future-deployment-models
    * MS Learn's Administer-Containers-in-Azure Learning Path : https://docs.microsoft.com/en-us/learn/paths/administer-containers-in-azure/
    * FreeCodeCamp's Docker Handbook : https://www.freecodecamp.org/news/the-docker-handbook/
    * Stackify's start-to-finish guide to Docker for .NET : https://stackify.com/a-start-to-finish-guide-to-docker-for-net/
#>


# Installa Docker  su Windows Server
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider
Restart-Computer -Force

# Pull dell'immagine ASP.NET 4.8
Docker pull mcr.microsoft.com/dotnet/framework/aspnet:4.8
# Pull Windows 1809 as oledlg.dll source for Crystal Reports 
# https://stackoverflow.com/questions/55638049/docker-container-with-support-for-crystal-reports
Docker pull mcr.microsoft.com/windows:1809
# MS SQL Server Express image
docker pull microsoft/mssql-server-windows-express:latest

# Check dockerfile here
# .......

# Build new image
docker build -t mpasswimage .

# Run (pull, create & start) container
docker run --name mpassw --publish 8080:80 --detach mpasswimage

# Run powershell on the container
docker exec -it mpassw powershell

# Crea l'application pool MICRONPASS e crea dentro l'applicazione web MPASSW
> Import-Module WebAdministration -SkipEditionCheck -ErrorAction SilentlyContinue
> Import-Module IISAdministration
> $manager = Get-IISServerManager
> $pool = $manager.ApplicationPools.Add("MICRONPASS")
> $pool.ManagedPipelineMode = "Integrated"
> $pool.ManagedRuntimeVersion = "v4.0"
> $pool.Enable32BitAppOnWin64 = $true
> $pool.AutoStart = $true
> $pool.ProcessModel.IdentityType = "ApplicationPoolIdentity"
> $pool.ProcessModel.idleTimeout = "08:00:00"
> $manager.CommitChanges()
> New-WebApplication -Name "mpassw" -Site "Default Web Site" -PhysicalPath "C:\MPW\Micronpass" -ApplicationPool "MICRONPASS"


# Installa Crystal Reports
> $msiArguments64 = '/qn','/i','"CRRuntime_64bit_13_0_25.msi"'
> Start-Process -PassThru -Wait msiexec -ArgumentList $msiArguments64
> $msiArguments32 = '/qn','/i','"CRRuntime_32bit_13_0_25.msi"'
> Start-Process -PassThru -Wait msiexec -ArgumentList $msiArguments32
# ----> Questa parte va in errore!
# ----> https://stackoverflow.com/questions/55638049/docker-container-with-support-for-crystal-reports

# Esegui cmd nel container
docker exec -it mpassw cmd

# cmd: full control everyone sulle cartelle 
> icacls C:\MPW\Micronpass /grant Everyone:(F)
> icacls \inetpub\wwwroot /grant Everyone:(F)

# Indirizzo IP del container
$IP = docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' mpassw

# Apri URL di Micronpass Web
Start-Process 'http://localhost:8080'

# ----------------

# Rename container
# docker rename CONTAINER_NAME MY_NEW_CONTAINER_NAME

# Run a container after getting its ID
# docker start $(docker ps -aqf "name=ASPNET48")
