@ECHO off
IF "%1"=="SET" GOTO SET
IF "%1"=="UNSET" GOTO UNSET
GOTO END

:SET
ECHO "Set IE proxy"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d http://%2:%3;https://%2:%3;ftp://%2:%3 /f
GOTO END

:UNSET
ECHO "remove IE proxy"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
GOTO END

:END
ECHO "end of script"
