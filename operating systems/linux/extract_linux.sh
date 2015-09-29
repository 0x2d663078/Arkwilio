#!/bin/sh
#
#   Run as root to document the security level of a Linux server.
#   The idea is to extract configuration files for offline analysis.
#
clear

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as priviliged user !" 2>/dev/null
 exit 1
fi

AUDIT_DIR="/tmp/audit"
CURRENT_DIR=$(pwd)
OUTFILES=$(pwd)"/EXTRACT_Linux_"`date +%Y_%m_%d-%H:%M:%S`
REPORT=$AUDIT_DIR"/report.log"
AUTHOR="tmr"
SIG="temmar.abdessamad@gmail.com"
V="1.0"
CHECK_NUMBER=13
CURRENT_CHECK=1

#Basic functions used inside this scripts
#save content to a file
#$1 : content
#$2 : file name
#$3 : error message
function savetofile {

if [ -e "$2" ]; then
	echo "[X] File name $2 already exist !"
fi

if [ "$1" ]; then
	echo "$1" > "$2.txt" 
else
	:
fi

}  

if [ -e "$AUDIT_DIR" ]; then
    rm -rf "$AUDIT_DIR".old
    mv "$AUDIT_DIR" "$AUDIT_DIR".old
fi

mkdir "$AUDIT_DIR" 2>/dev/null

cd "$AUDIT_DIR" 2>/dev/null

echo $" ______________________________________"
echo -e "/" "\e[00;33mLinux Configuration Auditor Script  \e[00m" "\\"
echo -e "\\" "\e[00;33mVersion : 1.0\e[00m" "                       /"
echo $" --------------------------------------"
echo $"        \\   ^__^"
echo $"         \\  (oo)\\_______"
echo $"            (__)\       )\/\""
echo $"                ||----w |"
echo $"                ||     ||"
echo ""
echo ""
echo -e "\e[00;33mScript started at:"; date |tee -a $REPORT 2>/dev/null
echo -e "\e[00m\n" |tee -a $REPORT 2>/dev/null


echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Gathering System Kernel information\e[00m" |tee -a $REPORT 2>/dev/null
#uname informations
unameinfo=`uname -a 2>>$REPORT`
savetofile "$unameinfo" "unameinfo" 
#OS release
release=`cat /etc/*-release 2>>$REPORT`
savetofile "$release" "release"
#server hostname
hostname=`hostname 2>>$REPORT`
savetofile "$hostname" "hostname"
#System banner configurations files
issue=`cat /etc/issue 2>>$REPORT`
savetofile "$issue" "issue"
motd=`cat /etc/motd 2>>$REPORT`
savetofile "$motd" "motd"
issuenet=`cat /etc/issue.net 2>>$REPORT`
savetofile "$issuenet" "issuenet"


CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Gathering users/groups informations\e[00m" |tee -a $REPORT 2>/dev/null

#last logged on user information
lastlogedonusrs=`lastlog |grep -v "Never" 2>>$REPORT`
savetofile "$lastlogedonusrs" "lastlogedonusrs"

#Getting username uid & gid from /etc/passwd
usersinfo=`cat /etc/passwd | cut -d ":" -f 1,2,3,4 2>>$REPORT`
savetofile "$usersinfo" "usersinfo"

#lists all id's and respective group(s)
grpinfo=`for i in $(cat /etc/passwd 2>>$REPORT| cut -d":" -f1 2>>$REPORT);do id $i;done 2>>$REPORT`
savetofile "$grpinfo" "grpinfo"

#pull out vital sudoers info
sudoers=`cat /etc/sudoers 2>>$REPORT | grep -v -e '^$'|grep -v "#"`
savetofile "$sudoers" "sudoers"

CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Getting network configuration\e[00m" |tee -a $REPORT 2>/dev/null
#nic information
nicinfo=`/sbin/ifconfig -a 2>>$REPORT`
savetofile "$nicinfo" "nicinfo"
#dns settings
dnsinfo=`cat /etc/resolv.conf 2>>$REPORT | grep "nameserver"`
savetofile "$dnsinfo" "dnsinfo"
#default route configuration
defroute=`route 2>>$REPORT | grep default`
savetofile "$defroute" "defroute"
#Listening TCP
tcpservs=`lsof -i TCP -n -P 2>>$REPORT`
savetofile "$tcpservs" "tcpservs"
#listening UDP
udpservs=`lsof -i UDP -n -P 2>>$REPORT`
savetofile "$udpservs" "udpservs"
#sysctl content
sysctlcontent=`cat /etc/sysctl.conf 2>>$REPORT`
savetofile "$sysctlcontent" "sysctlcontent"
#SSH server configuration
#tudu : debian and other distribution has differents path/location
sshdconfig=`cat /etc/ssh/sshd_config 2>>$REPORT`
savetofile "$sshdconfig" "sshdconfig"
#Time managment
ntpconfig=`cat /etc/ntp.conf 2>>$REPORT`
savetofile "$ntpconfig" "ntpconfig" 
uptime=`uptime`
savetofile "$uptime" "uptime"
timezone=`/etc/timezone 2>>$REPORT`
savetofile "$timezone" "timezone"
ntpq=`ntpq -p -n 2>>$REPORT`
savetofile "$ntpq" "ntpq" 
ntpps=`ps -edf | grep ntp 2>>$REPORT`
savetofile "$ntpps" "ntpps"


CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Service & Process\e[00m" |tee -a $REPORT 2>/dev/null

#running processes
psaux=`ps aux 2>>$REPORT`
savetofile "$psaux" "psaux"

#lookup process binary path and permissisons
procperm=`ps aux | awk '{print $11}'|xargs -r ls -la 2>>$REPORT |awk '!x[$0]++'`
savetofile "$procperm" "procperm"

#listing system services
systemservices=`chkconfig --list 2>>$REPORT`
savetofile "$systemservices" "systemservices"

#tudu : extract associated binaries from inetd.conf & show permisisons of each
#inetdbinperms=`cat /etc/inetd.conf 2>>$REPORT | awk '{print $7}' |xargs -r ls -la 2>>$REPORT`
#savetofile "$inetdbinperms" "inetdbinperms"

#Content of xinet.conf
#xinetdread=`cat /etc/xinetd.conf 2>/dev/null`

#/etc/init.d/ binary permissions
initdread=`ls -la /etc/init.d 2>>$REPORT`
savetofile "$initdread" "initdread"

#init.d files NOT belonging to root!
initdperms=`find /etc/init.d/ \! -uid 0 -type f 2>>$REPORT |xargs -r ls -la 2>>$REPORT`
savetofile "$initdperms" "initdperms"

#/etc/rc.d/init.d binary permissions
rcdread=`ls -la /etc/rc.d/init.d 2>>$REPORT`
savetofile "$rcdread" "rcdread"

#init.d files NOT belonging to root!
rcdperms=`find /etc/rc.d/init.d \! -uid 0 -type f 2>>$REPORT |xargs -r ls -la 2>>$REPORT`
savetofile "$rcdperms" "rcdperms"


CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Gathering programs/binaries informations\e[00m" |tee -a $REPORT 2>/dev/null

#list installed software
listsoft=`dpkg --list 2>>$REPORT && rpm -qa --qf '%{INSTALLTIME} (%{INSTALLTIME:date}): %{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n' 2>>$REPORT | sort -n 2>>$REPORT`
savetofile "$listsoft" "listsoft"

#known 'good' breakout binaries
interestingbinaries=`which nmap perl awk find bash sh man more less vi vim nc netcat python ruby lua irb wget gcc tcpdump 2>>$REPORT`
savetofile "$interestingbinaries" "interestingbinaries"

#sudo version - check to see if there are any known vulnerabilities with this
sudover=`sudo -V 2>/dev/null| grep "Sudo version" 2>/dev/null`
savetofile "$sudover" "sudover"

#tudu : search for installed compilers (gcc & javac)
compiler=`dpkg --list 2>>$REPORT | grep compiler | grep -v decompiler 2>>$REPORT && rpm -qa --qf "%{NAME}\n" 2>>$REPORT | sort | grep 'javac*\|gcc*' 2>>$REPORT`
savetofile "$compiler" "compiler"

CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) System startup/boot configuration\e[00m" |tee -a $REPORT 2>/dev/null
#tudu : for other distro
grubconf=`cat /etc/grub.conf 2>>$REPORT | grep -v "#"`
savetofile "$grubconf" "grubconf"


CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) System partitions configuration\e[00m" |tee -a $REPORT 2>/dev/null
fstabcontent=`cat /etc/fstab | grep -v "#" 2>>$REPORT`
savetofile "$fstabcontent" "fstabcontent"


CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Check system integrity\e[00m" |tee -a $REPORT 2>/dev/null
#tudu : add corresponding command on debian and the other distro
sysintegrity=`debsums --changed 2>>$REPORT && rpm -qVa 2>>$REPORT | awk '$2 != "c" { print $0}' 2>>$REPORT`
savetofile "$sysintegrity" "sysintegrity"


CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Audit/review permissions on files & directories\e[00m" |tee -a $REPORT 2>/dev/null

#Tudu : looking for files that doesn't belong to a user but can write to them (history)
#looks for world-reabable files - this may take some time
wrfiles=`find / -path "*/proc/*" -perm -4 -type f -exec ls -al {} \; 2>/dev/null`
savetofile $wrfiles "wrfiles"

#are there any .rhosts files accessible - these may allow an attacker to login as another user.
rhostsusr=`find /home -iname *.rhosts -exec ls -la {} 2>/dev/null \; -exec cat {} 2>/dev/null \;`
bsdrhostsusr=`find /usr/home -iname *.rhosts -exec ls -la {} 2>/dev/null \; -exec cat {} 2>/dev/null \;`
rhostssys=`find /etc -iname hosts.equiv -exec ls -la {} 2>/dev/null \; -exec cat {} 2>>/dev/null \;`
savetofile "$rhostsusr\n$bsdrhostsusr\n$rhostssys" "rhostsfiles"

#permissions on sensitive files
permstvfiles=`ls -al /etc/group /etc/sysctl.conf /etc/ssh/sshd_config /etc/login.defs /etc/fstab /etc/grub.conf /etc/passwd /etc/shadow 2>/dev/null`
savetofile "$permstvfiles" "permstvfiles"

#list nfs shares/permisisons etc.
nfsexports=`ls -al /etc/exports 2>>$REPORT; cat /etc/exports 2>>$REPORT`
savetofile "$nfsexports" "nfsexports"

#looking for credentials in /etc/fstab
fstab=`cat /etc/fstab 2>>$REPORT |grep username |awk '{sub(/.*\username=/,"");sub(/\,.*/,"")}1'| xargs -r echo username:; cat /etc/fstab 2>/dev/null |grep password |awk '{sub(/.*\password=/,"");sub(/\,.*/,"")}1'| xargs -r echo password:; cat /etc/fstab 2>/dev/null |grep domain |awk '{sub(/.*\domain=/,"");sub(/\,.*/,"")}1'| xargs -r echo domain:`
fstabcred=`cat /etc/fstab 2>/dev/null |grep cred |awk '{sub(/.*\credentials=/,"");sub(/\,.*/,"")}1'| xargs -I{} sh -c 'ls -la {}; cat {}'`
savetofile "$fstab\n\n$fstabcred" "fstabcred"

#extract any user history files that are accessible
usrhist=`ls -al /home/*/.*_history 2>/dev/null`
savetofile "$usrhist" "usrhist"

#can we read roots *_history files - could be passwords stored etc.
roothist=`ls -la /root/.*_history 2>/dev/null`
savetofile "$roothist" "roothist"

#Tudu : looks for interesting administration scripts (python, perl, bash ...)
adminscripts=`find /home/ -name "*.sh" -exec ls -al {} \; 2>/dev/null`
savetofile "$adminscripts" "adminscripts"

#Tudu : Checks permissions on ssh files - this may take some time
#sshfiles=`find / -name "id_dsa*" -o -name "id_rsa*" -o -name "known_hosts" -o -name "authorized_hosts" -o -name "authorized_keys" 2>/dev/null |xargs -r ls`
#looks for unowned files & directories - this may take some time
unownedfiles=`find / \( -nouser -o -nogroup \) -exec ls -al {} \; 2>/dev/null`
savetofile "$unownedfiles" "unownedfiles"

#lists word-writable suid/guid files
wwsuid=`df --local -P 2>>$REPORT | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -4007 -exec ls -al {} \; 2>/dev/null`
wwguid=`df --local -P 2>>$REPORT | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -2007 -exec ls -al {} \; 2>/dev/null`
savetofile "$wwwsuid\n\n$wwguid" "wwsguid"

#list of 'interesting' suid files - feel free to make additions
intsuid=`find / -perm -4000 -type f 2>/dev/null | grep -w 'nmap\|perl\|'awk'\|'find'\|'bash'\|'sh'\|'man'\|'more'\|'less'\|'vi'\|'vim'\|'nc'\|'netcat'\|python\|ruby\|lua\|irb\|pl' | xargs -r ls -la` 2>/dev/null
savetofile "$initsuid" "initsuid"

#su usage permissions
suconfig=`cat /etc/pam.d/su 2>>$REPORT | grep -v "#" 2>/dev/null`
savetofile "$suconfig" "suconfig"


CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Getting environment configuration (paths, available shells ...)\e[00m" |tee -a $REPORT 2>/dev/null

#current path configuration
pathinfo=`echo $PATH 2>>$REPORT`
savetofile "$pathinfo" "pathinfo"

#lists available shells
shellinfo=`cat /etc/shells 2>>$REPORT`
savetofile "$shellinfo" "shellinfo"

#umask value with both octal and symbolic output
umaskval=`umask -S 2>>$REPORT & umask 2>>$REPORT`
savetofile "$umaskval" "umaskval"

#umask value as in /etc/login.defs
umaskdef=`cat /etc/login.defs 2>>$REPORT |grep -i UMASK 2>>$REPORT |grep -v "#" 2>/dev/null`
savetofile "$umaskdef" "umaskdef"

#tudu : umask value in profile.bashrc

CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Password policy & storage information\e[00m" |tee -a $REPORT 2>/dev/null

#login.defs configuration file
logindefs=`cat /etc/login.defs 2>>$REPORT | grep "PASS_MAX_DAYS\|PASS_MIN_DAYS\|PASS_WARN_AGE\|ENCRYPT_METHOD" 2>/dev/null | grep -v "#" 2>/dev/null`
savetofile "$logindefs" "logindefs"

#hashing algorithm used for password storage
#tudu : equivalent for authconfig command
hashalgo=`authconfig --test 2>>$REPORT | grep hashing`
savetofile "$hashalgo" "hashalgo"

#Read shadow file test password strength
passwordhash=`cat /etc/shadow /etc/security/passwd 2>>$REPORT`
savetofile "$passwordhash" "passwordhash"

CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Gathering informaions about existing Jobs/Tasks\e[00m" |tee -a $REPORT 2>/dev/null
#are there any cron jobs configured
cronjobs=`ls -al /etc/cron* 2>>$REPORT`
savetofile "$cronjobs" "cronjobs"

#can we manipulate these jobs in any way
cronjobwwperms=`find /etc/cron* -perm -0002 -exec ls -la {} \; -exec cat {} 2>/dev/null \;`
savetofile "$cronjobwwperms" "cronjobwwperms"

#crontab contents
crontab=`cat /etc/crontab 2>>$REPORT`
savetofile "$crontab" "crontab"

#crontabs contents
crontabvar=`ls -al /var/spool/cron/crontabs 2>>$REPORT`
savetofile "$crontabvar" "crontabvar"

#Anacron jobs and associated file permissions
anacronjobs=`ls -al /etc/anacrontab 2>>$REPORT; cat /etc/anacrontab 2>>$REPORT`
savetofile "$anacronjobs" "anacronjobs"

#When were jobs last executed (/var/spool/anacron contents)
anacrontab=`ls -al /var/spool/anacron 1>/dev/null`
savetofile "$anacrontab" "anacrontab"

#pull out account names from /etc/passwd and see if any users have associated cronjobs (priv command)
#Jobs held by all users
#cronother=`cat /etc/passwd 2>>$REPORT | cut -d ":" -f 1 | xargs -n1 crontab -l -u 2>/dev/null`
#savetofile "$cronother" "cronother"


CURRENT_CHECK=$((CURRENT_CHECK+1))
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) System Logging & Auditing\e[00m" |tee -a $REPORT 2>/dev/null
syslogconf=`cat /etc/syslog.conf 2>>$REPORT`
savetofile "$syslogconf" "syslogconf"
#tudu
#find /var/log -type f -exec ls -l {} \; | cut -c 17-35 | sort -u
log_for_everybody=`find /var/log -perm +004 -exec ls -al {} \; 2>>$REPORT`
savetofile "$log_for_everybody" "log_for_everybody"

log_not_owned_by_root=`find /var/log \! -group root \! -group adm -exec ls -ld {} \; 2>>$REPORT`
savetofile "$log_for_everybody" "log_for_everybody"

auditrules=`cat /etc/audit/audit.rules 2>>$REPORT`
savetofile "$auditrules" "auditrules"

#tudu
#yum check-update > yum_update.txt
#cat /etc/shadow > shadow.txt
#readmasterpasswd=`cat /etc/master.passwd 2>/dev/null`
#add shellshok check
tarcmd=`tar cvzf "$OUTFILES.tar" "$AUDIT_DIR" 2>/dev/null`
echo $tarcmd >> $REPORT
cd "$CURRENT_DIR"

echo ""
echo -e "\e[00;33m### SCAN COMPLETE ! CONFIG SAVED AT $OUTFILES.tar ###\e[00m" |tee -a $REPORT 2>/dev/null