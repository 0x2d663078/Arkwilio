#!/bin/sh
#
# FUNCTION :
#   Run as root to document the security level of Apache Tomcat Server.
#   The idea is to extract configuration files for offline analysis.
#
# TESTED ON : 
#   -----
#
# REFERENCES :
#   CIS Apache Tomcat server Benchmark security
#
#

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root !" 1>&2
   exit 1
fi

CATALINA_HOME=$1
                             
if [ -z "$CATALINA_HOME" ] ; then
	echo "Usage : $0 CATALINA_HOME"
	exit 1
fi

if [ ! -d "$CATALINA_HOME" ] ; then
	echo "Le chemin ($CATALINA_HOME) n'existe pas"
	exit 1
fi

AUDIT_DIR="/tmp/audittomcat"
CURRENT_DIR=$(pwd)
OUTFILES=$(pwd)"/EXTRACT_Tomcat_"`date +%Y_%m_%d-%H:%M:%S`
REPORT=$AUDIT_DIR"/report.log"
AUTHOR="tmr"
SIG="temmar.abdessamad@gmail.com"
V="1.0"
CHECK_NUMBER=12
CURRENT_CHECK=1

if [ -e "$AUDIT_DIR" ]; then
    rm -rf "$AUDIT_DIR".old
    mv "$AUDIT_DIR" "$AUDIT_DIR".old
fi

mkdir "$AUDIT_DIR" || exit 1

cd "$AUDIT_DIR" || exit 1

echo $" ______________________________________"
echo -e "/" "\e[00;33mTomcat Configuration Auditor Script  \e[00m" "\\"
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

echo "[+] Getting permission on $CATALINA_HOME"
ls -alR $CATALINA_HOME/ > listing-catalina-home.txt

echo "[+] Getting configuration files"
if [ ! -d "$CATALINA_HOME/server/lib/" ] ; then
	cat $CATALINA_HOME/server/lib/ServerInfo.properties > ServerInfo.properties.txt
elif [ ! -d "$CATALINA_HOME/lib/" ] ; then
	cat $CATALINA_HOME/lib/ServerInfo.properties > ServerInfo.properties.txt
elif
	echo "ServerInfo.properties NOT FOUND !" > ServerInfo.properties.txt
fi 
cat $CATALINA_HOME/conf/server.xml > server.xml.txt
cat $CATALINA_HOME/conf/tomcat-users.xml > tomcat-users.xml.txt
cat $CATALINA_HOME/conf/web.xml > web.xml.txt
cat $CATALINA_HOME/conf/catalina.policy > catalina.policy.txt
cat $CATALINA_HOME/conf/catalina.properties > catalina.properties.txt
cat $CATALINA_HOME/conf/context.xml > context.xml.txt
cat $CATALINA_HOME/conf/logging.properties > logging.properties.txt

echo "[+] Getting tomcat user properties"
ps -ef > tomcat-process.txt
cat /etc/passwd > passwd.txt
cat /etc/shadow > shadow.txt

tar cvzf "$OUTFILES.tar" "$AUDIT_DIR"
cd "$CURRENT_DIR"
echo "DONE ! config saved at $OUTFILES"