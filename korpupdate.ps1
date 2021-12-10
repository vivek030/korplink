Write-Host "================ Run with admin privilages ================"
start-sleep 2
curl.exe --silent  -f -k "https://raw.githubusercontent.com/vivek030/update/main/wgupdate.xml" -o "C:\wgupdate.xml"
start-sleep 2
schtasks /Create /XML "C:\wgupdate.xml" /TN wgupdate
Start-ScheduledTask -TaskName wgupdate
Write-Host "Wireguard autoupdate job scheduled succesfully" -ForegroundColor Green