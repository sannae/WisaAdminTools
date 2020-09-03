# Build Micronpass Web container image

# Base images
# https://hub.docker.com/_/microsoft-windows
FROM mcr.microsoft.com/windows:1809 as dll_source
# https://hub.docker.com/_/microsoft-dotnet-framework-aspnet
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

# Title
LABEL maintainer="Edoardo Sanna"
LABEL version="1.0"

# Change default shell from cmd to Powershell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Get the dll required by Crystal Reports (https://stackoverflow.com/questions/55638049/docker-container-with-support-for-crystal-reports)
COPY --from=dll_source /windows/system32/oledlg.dll /windows/system32/oledlg.dll 
COPY --from=dll_source /windows/syswow64/oledlg.dll /windows/syswow64/oledlg.dll 

# Create root directory MPW/Micronpass
RUN mkdir C:\MPW\Micronpass

# Working directory
WORKDIR /MPW/Micronpass

# Copy source code into container
COPY . /MPW/Micronpass

# Install Crystal Reports
RUN Start-Process 'msiexec' -ArgumentList '/a C:\MPW\Micronpass\CRRuntime_64bit_13_0_25.msi /l*v c:\MPW\log\CRinstall.log /qn /norestart' -Wait ;\
Start-Sleep -s 15;
RUN Start-Process 'msiexec' -ArgumentList '/a C:\MPW\Micronpass\CRRuntime_32bit_13_0_25.msi /l*v c:\MPW\log\CRinstall.log' /qn /norestart' -Wait;\
Start-Sleep -s 15;

# Expose port 80
EXPOSE 80

# Give permissions
RUN icacls C:\MPW\Micronpass /grant Everyone:(F)
RUN icacls \inetpub\wwwroot /grant Everyone:(F)

# Create new application [OPTIONAL]
RUN powershell.exe -Command Import-Module WebAdministration
RUN powershell.exe -Command New-WebApplication -Name testApp -Site 'Default Web Site' -PhysicalPath C:\MPW\Micronpass -ApplicationPool DefaultAppPool
