if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

function Show-Menu

{
    param (
        [string]$Title = 'Select type of User'
    )
    Clear-Host
    Write-Host "================ $Title ================"
 
    Write-Host "Press 1 for Default users."
    Write-Host "Press 2 for Management users."
    Write-Host "Press Q to quit."
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
         $dns = "45.90.28.58,2a07:a8c0::e9:59cb"
Do {$email = Read-Host 'Enter Email ID'} while ([string]::IsNullOrWhiteSpace($email))
Do {$id = Read-Host 'Enter Friendly Name'} while ([string]::IsNullOrWhiteSpace($id))
$hostname = hostname
$name = "$id/$hostname"
Do {$api = Read-Host 'Enter API Key'} while ([string]::IsNullOrWhiteSpace($api))
$json = @"
{\"Email\":\"$email\",\"Identifier\":\"$name\",\"DNSStr\":\"$dns\"}
"@
curl.exe --silent  -f -k -X POST "https://digamber.korplink.com/api/v1/provisioning/peers" -H "accept: text/plain" -H "authorization: Basic $api" -H "Content-Type: application/json" -d $json -o "C:\krpl.conf"
Start-Process msiexec.exe -ArgumentList '/q','DO_NOT_LAUNCH=True','/I', 'https://download.wireguard.com/windows-client/wireguard-amd64-0.4.9.msi' -Wait -NoNewWindow -PassThru | Out-Null
Start-Process 'C:\Program Files\WireGuard\wireguard.exe' -ArgumentList '/installtunnelservice', '"C:\krpl.conf"' -Wait -NoNewWindow -PassThru | Out-Null
Start-Process sc.exe -ArgumentList 'config', 'WireGuardTunnel$krpl', 'start= delayed-auto' -Wait -NoNewWindow -PassThru | Out-Null
Start-Service -Name WireGuardTunnel$krpl -ErrorAction SilentlyContinue
curl.exe --silent  -f -k "https://raw.githubusercontent.com/vivek030/update/main/wgupdate.xml" -o "C:\wgupdate.xml"
schtasks /Create /XML "C:\wgupdate.xml" /TN wgupdate
Start-ScheduledTask -TaskName wgupdate
ipconfig /flushdns
Write-Host "KorpLink VPN installed succesfully with auto update " -ForegroundColor Green


     } '2' {
         $dns = "45.90.28.63,2a07:a8c0::ae:4156"
Do {$email = Read-Host 'Enter Email ID'} while ([string]::IsNullOrWhiteSpace($email))
Do {$id = Read-Host 'Enter Friendly Name'} while ([string]::IsNullOrWhiteSpace($id))
$hostname = hostname
$name = "$id/$hostname"
Do {$api = Read-Host 'Enter API Key'} while ([string]::IsNullOrWhiteSpace($api))
$json = @"
{\"Email\":\"$email\",\"Identifier\":\"$name\",\"DNSStr\":\"$dns\"}
"@
curl.exe --silent  -f -k -X POST "https://digamber.korplink.com/api/v1/provisioning/peers" -H "accept: text/plain" -H "authorization: Basic $api" -H "Content-Type: application/json" -d $json -o "C:\krpl.conf"
Start-Process msiexec.exe -ArgumentList '/q','DO_NOT_LAUNCH=True','/I', 'https://download.wireguard.com/windows-client/wireguard-amd64-0.4.9.msi' -Wait -NoNewWindow -PassThru | Out-Null
Start-Process 'C:\Program Files\WireGuard\wireguard.exe' -ArgumentList '/installtunnelservice', '"C:\krpl.conf"' -Wait -NoNewWindow -PassThru | Out-Null
Start-Process sc.exe -ArgumentList 'config', 'WireGuardTunnel$krpl', 'start= delayed-auto' -Wait -NoNewWindow -PassThru | Out-Null
Start-Service -Name WireGuardTunnel$krpl -ErrorAction SilentlyContinue
curl.exe --silent  -f -k "https://raw.githubusercontent.com/vivek030/update/main/wgupdate.xml" -o "C:\wgupdate.xml"
schtasks /Create /XML "C:\wgupdate.xml" /TN wgupdate
Start-ScheduledTask -TaskName wgupdate
ipconfig /flushdns
Write-Host "KorpLink VPN installed succesfully with auto update " -ForegroundColor Green
     } 'q' {
         return
     }
 }

}

show-menu




