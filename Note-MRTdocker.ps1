# Install Docker (Windows Server)
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider
Restart-Computer -Force

# Pull ASP.NET 4.8 base image
Docker pull mcr.microsoft.com/dotnet/framework/aspnet:4.8

# Rename image (if needed)
docker tag mcr.microsoft.com/dotnet/framework/aspnet:4.8 aspnet48baseimage

# Create Dockerfile
New-Item -Path . -Name "Dockerfile" -ItemType "file" -Value '

    # Base image and author
    FROM aspnet48baseimage
    MAINTAINER Edoardo Sanna

    # Create root directory MPW/Micronpass
    RUN mkdir C:\MPW\Micronpass

    # Copy source code into container
    COPY ./MPW/Micronpass /MPW/Micronpass

    # Remove Default Website
    RUN powershell Remove-IISSite -Name "Default Web Site"
    RUN powershell New-IISSite -Name "mpassw" -BindingInformation "*:80:" -PhysicalPath "$env:systemdrive\MPW\Micronpass" -PassThru

    # Check that the files have been successfully copied
    RUN dir

'

# Build new image
docker build -t mpasswimage .

# Run (pull, create & start) container
docker run --name mpassw  --publish 8080:80 --detach mpasswimage

# Test web application with default browser
Start-Process 'http://localhost:8080'

# Start PowerShell on running container
# docker exec -it ASPNET48 powershell



# ----------------

# Rename container
# docker rename CONTAINER_NAME MY_NEW_CONTAINER_NAME

# Run a container after getting its ID
# docker start $(docker ps -aqf "name=ASPNET48")
