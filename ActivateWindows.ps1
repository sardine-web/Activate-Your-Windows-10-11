# Check for administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltinRole] "Administrator")) {
    Write-Host "Error: This script must be run as administrator."
    Pause
    exit 1
}

# Execute commands
slmgr.vbs /upk
slmgr.vbs /cpky
slmgr.vbs /ckms
DISM /online /Get-TargetEditions
sc.exe config LicenseManager start= auto
sc.exe start LicenseManager
sc.exe config wuauserv start= auto
sc.exe start wuauserv
changepk.exe /productkey VK7JG-NPHTM-C97JM-9MPGT-3V66T
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
slmgr /skms kms8.msguides.com
slmgr /ato
