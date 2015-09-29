#!/bin/sh
#
# FUNCTION :
#   Run as root to document the security level of Apache HTTPD server.
#   The idea is to extract configuration files for offline analysis.
#
# TESTED ON : 
# Debian & RedHat
#
# REFERENCES :
#   CIS Apache/HTTPD server Benchmark security
#
#

clear

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as priviliged user !" 2>/dev/null
 exit 1
fi

AUDIT_DIR="/tmp/audit"
CURRENT_DIR=$(pwd)
OUTFILES=$(pwd)"/EXTRACT_Apache_"`date +%Y_%m_%d-%H:%M:%S`
REPORT=$AUDIT_DIR"/report.log"
AUTHOR="tmr"
SIG="temmar.abdessamad@gmail.com"
V="1.0"
CHECK_NUMBER=12
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
mkdir $AUDIT_DIR/include 2>/dev/null

cd "$AUDIT_DIR" 2>/dev/null

echo $" ______________________________________"
echo -e "/" "\e[00;33mApache Configuration Auditor Script  \e[00m" "\\"
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

if [ -e /usr/sbin/apache2 ]; then
	APACHE_BIN="/usr/sbin/apache2"
elif [ -e /usr/sbin/httpd ]; then
	APACHE_BIN="/usr/sbin/httpd"
else	 
	echo "[!] ERROR ! PLEASE CONTACT THE AUDITOR"
	exit
fi

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


CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Getting Apache prefix folder\e[00m" |tee -a $REPORT 2>/dev/null
APACHE_PREFIX=$($APACHE_BIN -V | grep HTTPD_ROOT | cut -f2 -d"\"")


CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Getting Apache config file name\e[00m" |tee -a $REPORT 2>/dev/null
HTTP_CONF_FILE=$APACHE_PREFIX/$($APACHE_BIN -V | grep SERVER_CONFIG_FILE | cut -f2 -d"\"")
apacheconfigfile=`cat $HTTP_CONF_FILE 2>>$REPORT`
savetofile "$apacheconfigfile" "apacheconfigfile"

CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Getting all included configurations files in apache2.conf/httpd.conf\e[00m" |tee -a $REPORT 2>/dev/null
for item in $(cat $HTTP_CONF_FILE | grep "^Include" | cut -f2 -d " ");
do
  cp -R $APACHE_PREFIX/$item $AUDIT_DIR/include 2>>$REPORT
done
#tudu
#echo "[*] Getting the rest of configuration files :"
#for path in $(find $APACHE_PREFIX -name '*.conf' -type f 2> /dev/null);
#do
#  echo "[*] Content of the $path configuration file :" >> config.files.txt
#  cat $path >> config.files.txt
#done

CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) List Insalled services on system\e[00m" |tee -a $REPORT 2>/dev/null
servicesstatus=`service --status-all 2>>REPORT`
savetofile "$servicesstatus" "servicesstatus"

CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) List Loaded modules\e[00m" |tee -a $REPORT 2>/dev/null
apachemodules=`$APACHE_BIN -M 2>>$REPORT`
savetofile "$apachemodules" "apachemodules"

CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Information about Apache account\e[00m" |tee -a $REPORT 2>/dev/null
#Apache UID account(server must be running)
uidmin=`grep '^UID_MIN' /etc/login.defs 2>>REPORT`
APACHE_USER=$(ps axho user,comm|grep -E "httpd|apache"|uniq|grep -v "root"|awk 'END {if ($1) print $1}')
APACHE_GROUP=$(ps axho group,comm|grep -E "httpd|apache"|uniq|grep -v "root"|awk 'END {if ($1) print $1}')
idapache=`id $APACHE_USER 2>>$REPORT`
savetofile "$idapache" "idapache"

#Apache account shell
apachepasswd=`grep $APACHE_USER /etc/passwd 2>>$REPORT`
apachegroup=`grep $APACHE_GROUP /etc/group 2>>$REPORT`
savetofile "$apachepasswd" "apachepasswd"
savetofile "$apachegroup" "apachegroup"

#Ensure the Apache account is locked
apachestatus=`passwd -S $APACHE_USER  2>>$REPORT`
savetofile "$apachestatus" "apachestatus"


CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Audit permissions on Apache directories & files\e[00m" |tee -a $REPORT 2>/dev/null
listingbase=`ls -alR $APACHE_PREFIX 2>>$REPORT`
savetofile "$listingbase" "listingbase"

#Files in the Apache directory that are not owned by root
find $APACHE_PREFIX  \! -user root -ls > not_root.txt

#Files in the Apache directories other than htdocs with a group other than root :
not_onwned_root=`find $APACHE_PREFIX -path $APACHE_PREFIX/htdocs -prune -o \! -group root -exec ls -al {} \; 2>/dev/null`
savetofile "$not_onwned_root" "not_onwned_root"

#Files or directories in the Apache directory with other write access, excluding symbolic links :
other_write_access=`find -L $APACHE_PREFIX \! -type l \! -type s -perm /o=w -exec ls -al {} \; 2>/dev/null`
savetofile "$other_write_access" "other_write_access"

#Group Write Access for the Apache Directories and Files :"
grp_write_access=`find -L $APACHE_PREFIX \! -type l \! -type s -perm /g=w -exec ls -al {} \; 2>/dev/null`
savetofile "$grp_write_access" "grp_write_access"

#Default CGI Content printenv :"
default_cgi_content=`ls -al $APACHE_PREFIX/cgi-bin/printenv 2>>$REPORT`
savetofile "$default_cgi_content" "default_cgi_content"

CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Log Storage and Rotation\e[00m" |tee -a $REPORT 2>/dev/null
logrotatehttpd=`cat /etc/logrotate.d/apache2 /etc/logrotate.d/httpd 2>>$REPORT`
savetofile "$logrotatehttpd" "logrotate"
logrotateconf=`cat /etc/logrotate.conf 2>>$REPORT`
savetofile "$logrotateconf" "logrotateconf"

#tudu
#echo "[*] Getting .crt files to verify later :"
#for path in $(find / -name '*.crt' -type f 2> /dev/null);
#do
#  echo "[*] Permission on .crt located in $path :" >> cert.path.txt
#  ls -alR $path >> cert.path.txt 
#done

echo "[*] Get all php.ini files (some application try to override the existing php.ini file) :"
for path in $(find / -name 'php.ini' 2> /dev/null);
do
  echo "[*] Content of php.ini located in $path :" >> php.ini.files.txt
  cat $path >> php.ini.files.txt 2>>$REPORT
done

tarcmd=`tar cvzf "$OUTFILES.tar" "$AUDIT_DIR" 2>/dev/null`
echo $tarcmd >> $REPORT
cd "$CURRENT_DIR"

echo -e "\e[00;33m### SCAN COMPLETE ! CONFIG SAVED AT $OUTFILES####################################\e[00m" |tee -a $REPORT 2>/dev/null
