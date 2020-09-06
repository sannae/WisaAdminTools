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

# Powershell in the container: install Crystal Reports
$msiArguments64 = '/qn','/i','"CRRuntime_64bit_13_0_25.msi"'
Start-Process -PassThru -Wait msiexec -ArgumentList $msiArguments64
$msiArguments32 = '/qn','/i','"CRRuntime_32bit_13_0_25.msi"'
Start-Process -PassThru -Wait msiexec -ArgumentList $msiArguments32

# Indirizzo IP del container
$IP = docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' mpassw

# Back to host: test web application with default browser
Start-Process "http://$IP:8080"

# Create a volume for SQL Data and run the SQL container instance
docker volume create sql-data
docker run --name sql --publish 1433:1433 --detach --volume sql-data:C:/temp/ --env attach_dbs="[{'dbName':'MRT','dbFiles':['C:\\temp\\MRT.mdf','C:\\temp\\MRT_log.ldf']}]" --env sa_password='Micro!Mpw147' --env ACCEP_EULA=Y microsoft/mssql-server-windows-express:latest

# ----------------

# Rename container
# docker rename CONTAINER_NAME MY_NEW_CONTAINER_NAME

# Run a container after getting its ID
# docker start $(docker ps -aqf "name=ASPNET48")
