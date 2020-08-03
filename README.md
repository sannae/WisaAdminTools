## NOTES
- Only works with SQL Server
- TESTED ON
    - Windows Server 2019 Datacenter
    - PowerShell 5.0
- INPUT REQUIRED
    - CSV file with required IIS features in the same directory (maybe replace with JSON?)
    - SQLEXPR_x64_ENU.exe in same directory (if needed) (English only for now)
    - SSMS-SETUP-ENU.exe in same directory (if needed) (English only for now)
    - MRTxxx.exe in same directory
    - Modules/SqlServer PowerShell module (last release downloadable from https://www.powershellgallery.com/packages/Sqlserver)

## TODO
- Insert CheckProgramInstallation function
- Add speed-test
- Add DSC test at the end of the script

## USEFUL LINKS
- https://jrsoftware.org/ishelp/index.php?topic=setupcmdline - Setup command line arguments
