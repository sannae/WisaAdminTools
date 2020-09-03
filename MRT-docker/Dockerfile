# Build Micronpass Web container image

# Base images
FROM mcr.microsoft.com/windows:1809 AS dll_source
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

# Title
LABEL version="1.0"

# Change default shell from cmd to Powershell
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Get the dll required by Crystal Reports (https://stackoverflow.com/questions/55638049/docker-container-with-support-for-crystal-reports)
COPY --from=dll_source /windows/system32/oledlg.dll /windows/system32/oledlg.dll 
COPY --from=dll_source /windows/syswow64/oledlg.dll /windows/syswow64/oledlg.dll 

# Create root directory MPW/Micronpass
RUN mkdir C:\MPW\Micronpass
RUN mkdir C:\MPW\Micronpass\logs

# Working directory
WORKDIR /MPW/Micronpass

# Copy source code into container
COPY . /MPW/Micronpass

# Install Crystal Reports
RUN Start-Process 'msiexec' -ArgumentList '/a C:\MPW\Micronpass\CRRuntime_64bit_13_0_25.msi /l*v c:\MPW\log\CRinstall.log /qn /norestart' -Wait && Start-Sleep -s 15;
RUN Start-Process 'msiexec' -ArgumentList '/a C:\MPW\Micronpass\CRRuntime_32bit_13_0_25.msi /l*v c:\MPW\log\CRinstall.log /qn /norestart' -Wait && Start-Sleep -s 15;

# Expose port 80
EXPOSE 80
