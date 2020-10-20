$RemotePath = '/MRT/MRT_FX4_PC_EXE/MRTInstaller/V750'
$LocalPath = 'C:\Users\edoardo.sanna\Desktop\INSTALL\MRT_FX4_PC_EXE'

& "C:\Program Files (x86)\WinSCP\WinSCP.com" `
  /log="$LocalLog" /ini=nul `
  /command `
    "open ftpes://sanna:edo89%2B0304@79.11.21.211/ -certificate=`"`"3f:3f:9f:7a:49:0e:4d:80:12:69:af:70:cb:5c:72:a4:e7:3a:eb:f1`"`"" `
    "cd $RemotePath" `
    
