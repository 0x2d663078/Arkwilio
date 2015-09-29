#!/bin/sh
#
# FUNCTION :
#   Run as root to document the security level of Postgres server.
#   The idea is to extract configuration files for offline analysis.
#
# TESTED ON : 
#   RedHat
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
OUTFILES=$(pwd)"/EXTRACT_Postgres_"`date +%Y_%m_%d-%H:%M:%S`
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

cd "$AUDIT_DIR" 2>/dev/null

echo $" ______________________________________"
echo -e "/" "\e[00;33mPostgres Configuration Auditor Script  \e[00m" "\\"
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


echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Gathering System information\e[00m" |tee -a $REPORT 2>/dev/null
#uname informations
unameinfo=`uname -a 2>>$REPORT`
savetofile "$unameinfo" "unameinfo" 

#OS release
release=`cat /etc/*-release 2>>$REPORT`
savetofile "$release" "release"

#server hostname
hostname=`hostname 2>>$REPORT`
savetofile "$hostname" "hostname"

echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Postgres version details\e[00m" |tee -a $REPORT 2>/dev/null
postgver=`psql -V 2>>$REPORT`
savetofile "$postgver" "postgver"

CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Getting pg_hba.conf\e[00m" |tee -a $REPORT 2>/dev/null
pg_hbaconf=`cat /etc/postgresql/*.*/main/pg_hba.conf 2>>$REPORT`
savetofile "$pg_hbaconf" "pg_hbaconf"

CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Getting postgresql.conf\e[00m" |tee -a $REPORT 2>/dev/null
postgresqlconf=`cat /etc/postgresql/*.*/main/postgresql.conf 2>>$REPORT`

CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Getting Permissions on files & directories\e[00m" |tee -a $REPORT 2>/dev/null
permdata=`ls -alR /var/lib/postgresql/*.*/main 2>>$REPORT`
savetofile "$permdata" "permdata"
permconf=`ls -alR /etc/postgresql/ 2>>$REPORT`
savetofile "$permconf" "permconf" 

CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) List Insalled services on system\e[00m" |tee -a $REPORT 2>/dev/null
servicesstatus=`service --status-all 2>>REPORT`
savetofile "$servicesstatus" "servicesstatus"

CURRENT_CHECK=$((CURRENT_CHECK+1)) 
echo -e "\e[00;31m[!] ($CURRENT_CHECK/$CHECK_NUMBER) Check default postgres passwords to connect to DB 'template0'\e[00m" |tee -a $REPORT 2>/dev/null
postcon1=`psql -U postgres template0 -c 'select version()' 2>/dev/null | grep version`
if [ "$postcon1" ]; then
  echo -e "\e[00;33m***We can connect to Postgres DB 'template0' as user 'postgres' with no password!:\e[00m\n$postcon1" |tee -a $report 2>/dev/null
  echo -e "\n" |tee -a $REPORT 2>/dev/null
else 
  :
fi

postcon11=`psql -U postgres template1 -c 'select version()' 2>/dev/null | grep version`
if [ "$postcon11" ]; then
  echo -e "\e[00;33m***We can connect to Postgres DB 'template1' as user 'postgres' with no password!:\e[00m\n$postcon11" |tee -a $REPORT 2>/dev/null
  echo -e "\n" |tee -a $REPORT 2>/dev/null
else 
  :
fi

postcon2=`psql -U pgsql template0 -c 'select version()' 2>/dev/null | grep version`
if [ "$postcon2" ]; then
  echo -e "\e[00;33m***We can connect to Postgres DB 'template0' as user 'psql' with no password!:\e[00m\n$postcon2" |tee -a $REPORT 2>/dev/null
  echo -e "\n" |tee -a $REPORT 2>/dev/null
else 
  :
fi

postcon22=`psql -U pgsql template1 -c 'select version()' 2>/dev/null | grep version`
if [ "$postcon22" ]; then
  echo -e "\e[00;33m***We can connect to Postgres DB 'template1' as user 'psql' with no password!:\e[00m\n$postcon22" |tee -a $REPORT 2>/dev/null
  echo -e "\n" |tee -a $REPORT 2>/dev/null
else 
  :
fi


#tudu : Getting user system configuration"
#cat /etc/passwd > passwd.txt
#ps -ef > process-list.txt

tarcmd=`tar cvzf "$OUTFILES.tar" "$AUDIT_DIR" 2>/dev/null`
echo $tarcmd >> $REPORT
cd "$CURRENT_DIR"

echo -e "\e[00;33m### SCAN COMPLETE ! CONFIG SAVED AT $OUTFILES####################################\e[00m" |tee -a $REPORT 2>/dev/null
