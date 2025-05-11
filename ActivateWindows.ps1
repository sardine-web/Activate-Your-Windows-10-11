#Requires -RunAsAdministrator

# Check Windows Version
$osInfo = Get-ComputerInfo | Select-Object OsName, OsVersion
Write-Host "Windows Version: $($osInfo.OsName) - Build $($osInfo.OsVersion)`n"

# Admin check
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Error: This script must be run as administrator." -ForegroundColor Red
    Read-Host "Press Enter to exit..."
    exit 1
}

# Main commands
slmgr /upk
slmgr /cpky
slmgr /ckms
DISM /online /Get-TargetEditions
sc.exe config LicenseManager start= auto
Start-Service LicenseManager
sc.exe config wuauserv start= auto
Start-Service wuauserv
changepk.exe /productkey VK7JG-NPHTM-C97JM-9MPGT-3V66T
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr /skms kms8.msguides.com
slmgr /ato
