PowerShell.exe -Command "& {Start-Process PowerShell.exe 'curl.exe -f -k https://raw.githubusercontent.com/vivek030/korplink/main/korplink.ps1 -o "C:\korplinknew.ps1"' -Verb RunAs}"
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""C:\korplinknew.ps1""' -Verb RunAs}"
