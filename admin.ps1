curl.exe -f -k https://raw.githubusercontent.com/vivek030/korplink/main/korplink.ps1 -o "C:\korplink.ps1"
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""C:\korplink.ps1""' -Verb RunAs}"
