# Title
LABEL maintainer="Edoardo Sanna"
LABEL version="1.0"

# Base images
FROM mcr.microsoft.com/windows:1809 as dll_source
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

# Get the dll required by Crystal Reports
# https://stackoverflow.com/questions/55638049/docker-container-with-support-for-crystal-reports
COPY --from=dll_source /windows/system32/oledlg.dll /windows/system32/oledlg.dll 
COPY --from=dll_source /windows/syswow64/oledlg.dll /windows/syswow64/oledlg.dll 

# Create root directory MPW/Micronpass
RUN mkdir C:\MPW\Micronpass

# Working directory
WORKDIR C:\MPW\Micronpass

# Copy source code into container
COPY . /MPW/Micronpass

# Check that the files have been successfully copied
RUN dir

# Install Crystal Reports
RUN powershell.exe -Command Start-Process C:\MPW\Micronpass\CRRuntime_64bit_13_0_25.msi -ArgumentList '/l*v c:\temp\install.log' -Wait
RUN powershell.exe -Command Start-Process C:\MPW\Micronpass\CRRuntime_32bit_13_0_25.msi -ArgumentList '/l*v c:\temp\install.log' -Wait

# Expose port 80
EXPOSE 80