# Install Docker (Windows Server)
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider
Restart-Computer -Force

# Pull ASP.NET 4.8 base image
Docker pull mcr.microsoft.com/dotnet/framework/aspnet:4.8

# Rename image
docker tag mcr.microsoft.com/dotnet/framework/aspnet:4.8 aspnet48baseimage

# Create file
New-Item -Path . -Name "Dockerfile" -ItemType "file" -Value '
    # Base image
    FROM aspnet48baseimage

    # Shell
    SHELL [ "powershell.exe" ]

    # Create root directory MPW/Micronpass
    RUN cd \
    RUN New-Item -Path . -Name "MPW\Micronpass" -ItemType "directory"

    # Work directory
    WORKDIR C:\MPW\Micronpass

    # Copy source code into container
    COPY . .

    # Remove Default Website
    RUN Remove-IISSite -Name "Default Web Site"
    RUN New-IISSite -Name "mpassw" -BindingInformation "*:80:" -PhysicalPath "$env:systemdrive\MPW\Micronpass" -PassThru

    # Check that the files have been successfully copied
    RUN dir
'

# Build new image
docker build -t ASPNET48 .

# Run (pull, create & start) container
docker run --name ASPNET48 --publish 8080:80 --detach aspnet48baseimage

# Start PowerShell on running container
docker exec -it ASPNET48 powershell



# ----------------

# Rename container
# docker rename CONTAINER_NAME MY_NEW_CONTAINER_NAME

# Run a container after getting its ID
# docker start $(docker ps -aqf "name=ASPNET48")
