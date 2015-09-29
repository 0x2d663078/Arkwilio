#!/bin/sh
#
# FUNCTION :
#   Run as root to document the security level of JBoss 6.
#   The idea is to extract configuration files for offline analysis.
#
# TESTED ON : 
#   -----
#
# REFERENCES :
#   JBoss Hardening Guide 
#
#

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root !" 1>&2
   exit 1
fi

JBOSS_HOME=$1
                             
if [ -z "$JBOSS_HOME" ] ; then
	echo "Usage : $0 JBOSS_HOME"
	echo "Example : $0 /opt/jboss-x.x.x.GA/"
	exit 1
fi

if [ ! -d "$JBOSS_HOME" ] ; then
	echo "Le chemin ($JBOSS_HOME) n'existe pas"
	exit 1
fi

AUDIT_DIR="/tmp/auditjboss"
CURRENT_DIR=$(pwd)
OUTFILES=$(pwd)"/EXTRACT_Jboss_6_"`date +%Y_%m_%d-%H:%M:%S`
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
echo -e "/" "\e[00;33mJBoss Configuration Auditor Script  \e[00m" "\\"
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


echo "[+] Getting permissions on $JBOSS_HOME :"
ls -alR $JBOSS_HOME > jboss-permissions.txt

echo "[+] Getting config. files :"

echo "[+] Getting JMXConnector configuration file"
cat $JBOSS_HOME/server/default/deploy/jmx-jboss-beans.xml > default.jmx-jboss-beans.xml.txt
cat $JBOSS_HOME/server/all/deploy/jmx-jboss-beans.xml > all.jmx-jboss-beans.xml.txt

echo "[+] Getting HTTP Invoker configuration files"
cat $JBOSS_HOME/all/deploy/httpha-invoker.sar/invoker.war/WEB-INF/web.xml > all.httpha-invoker.sar.web.xml.txt
cat $JBOSS_HOME/default/deploy/httpha-invoker.sar/invoker.war/WEB-INF/jboss-web.xml > default.httpha-invoker.sar.jboss-web.xml.txt
cat $JBOSS_HOME/all/deploy/http-invoker.sar/invoker.war/WEB-INF/web.xml > all.http-invoker.sar.web.xml.txt
cat $JBOSS_HOME/default/deploy/http-invoker.sar/invoker.war/WEB-INF/jboss-web.xml > default.http-invoker.sar.jboss-web.xml.txt

ps -ef > jboss-process.txt
cat /etc/passwd > passwd.txt
cat /etc/shadow > shadow.txt
passwd -S jboss > jboss-status.txt

tar cvzf "$OUTFILES.tar" "$AUDIT_DIR"
cd "$CURRENT_DIR"
echo "DONE ! config saved at $OUTFILES"