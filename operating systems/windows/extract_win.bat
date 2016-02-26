@echo off
title WinEnum Batch by TmR

systeminfo | findstr /B /C:"OS Name" /C:"OS Version" > systeminfo.out
echo %logonserver% > logonserver.out
hostname > hostname.out
echo %username% current_username.out
net users > local_users.out
net user /domain > domain_users.out
net user Administrator /domain > admin_domain.out
ipconfig /all > network_config.txt
route print > route_config.out
arp -A > arp_cache.out
netstat -ano > listenning_services.out
netsh firewall show state > firewall_state.out
netsh firewall show config > firewall_config.out
schtasks /query /fo LIST /v > schtasks.out
echo %path% > path_value.out
wmic qfe get Caption,Description,HotFixID,InstalledOn > list_installed_updates.out
reg.exe save HKLM\SAM sam_dump.out
reg.exe save HKLM\SYSTEM sys_dump.out

accesschk.exe /accepteula -uwdqs Utilisateurs c:\ > rw_directories.out
accesschk.exe /accepteula -uwdqs "Utilisateurs authentifiés" c:\ > rw_directories_2.out
accesschk.exe /accepteula -uwqs Utilisateurs c:\ > rw_files.out
accesschk.exe /accepteula -uwqs "Utilisateurs authentifiés" c:\ > rw_files_2.out

powershell.exe -nop -exec bypass -command " Import-Module PowerUp.ps1; Invoke-AllChecks | Out-File-Encoding ASCII checks.txt"
