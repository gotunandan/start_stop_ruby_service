@ECHO OFF

if "%1" == "IE" GOTO IE
if "%1" == "FIREFOX" GOTO FIREFOX
if "%1" == "CHROME" GOTO CHROME
if "%1" == "OPERA" GOTO OPERA
if "%1" == "OPERA_NEW" GOTO OPERA_NEW

GOTO END

:IE
ECHO "cleaning IE"
del /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*"
del /S /Q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Cookies\*"
del /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Windows\History\*"
del /S /Q "%USERPROFILE&"\AppData\LocalLow\Microsoft\Internet Explorer\*"
REG DELETE "HKCU\Software\Microsoft\Internet Explorer" /f

GOTO END

:FIREFOX
ECHO "cleaning firefox"
del /S /Q "%USERPROFILE%\AppData\Local\Mozilla\Firefox\Profiles\*"
del /S /Q "%USERPROFILE%\AppData\Roaming\Mozilla\Firefox\Profiles\*"

GOTO END


:CHROME
ECHO "cleaning chrome"
del /S /Q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\*"

GOTO END

:OPERA
ECHO "cleaning Opera"
del /S /Q "%USERPROFILE%\AppData\Local\Opera\Opera\cache\*"
del /S /Q "%USERPROFILE%\AppData\Local\Opera\Opera\opcache\*"
del /S /Q "%USERPROFILE%\AppData\Local\Opera\Opera\temporary_downloads\*"

del /S /Q "%USERPROFILE%\AppData\Local\Opera\Opera\*"
GOTO END

:OPERA_NEW
ECHO "cleaning opera_new"
del /S /Q "%USERPROFILE%\AppData\Local\Opera Software\Opera Stable\Cache\*"
del /S /Q "%USERPROFILE%\AppData\Roaming\Opera Software\Opera Stable\*"

GOTO END

:END
ECHO "BROWSER CLEANUP DONE"