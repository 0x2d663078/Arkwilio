#!/bin/sh
#
# FUNCTION :
#   Run as root to document the security level of JBoss 4.
#   The idea is to extract configuration files for offline analysis.
#
# TESTED ON : 
#   Linux Distro
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
	echo "Example : $0 /opt/jboss-4.2.2.GA/"
	exit 1
fi

if [ ! -d "$JBOSS_HOME" ] ; then
	echo "Le chemin ($JBOSS_HOME) n'existe pas"
	exit 1
fi

AUDIT_DIR="/tmp/auditjboss"
CURRENT_DIR=$(pwd)
OUTFILES=$(pwd)"/EXTRACT_Jboss_"`date +%Y_%m_%d-%H:%M:%S`
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

echo "[+] Getting permissions on $JBOSS_HOME"
ls -alR $JBOSS_HOME > jboss-permissions.txt

echo "[+] Getting config. files"
echo "[+] Getting main configuration file (server.xml)"
cat $JBOSS_HOME/server/default/deploy/jboss-web.deployer/server.xml > all.server.xml.txt
cat $JBOSS_HOME/server/all/deploy/jboss-web.deployer/server.xml > all.server.xml.txt

echo "[+] Getting jboss-web.deployer configuration file"
cat $JBOSS_HOME/server/default/deploy/jboss-web.deployer/conf/web.xml > default.web.xml.txt
cat $JBOSS_HOME/server/all/deploy/jboss-web.deployer/conf/web.xml > all.web.xml.txt

echo "[+] Getting jboss-beans configuration file"
$JBOSS_HOME/server/default/deploy/jbossws.sar/jbossws.beans/META-INF/jboss-beans.xml  > default.jboss-beans.xml.txt
$JBOSS_HOME/server/all/deploy/jbossws.sar/jbossws.beans/META-INF/jboss-beans.xml > all.jboss-beans.xml.txt

echo "[+] Getting JMX-Console configuration files"
cat $JBOSS_HOME/server/all/deploy/jmx-console.war/WEB-INF/jboss-web.xml > all.jmx-console.war.jboss-web.xml.txt
cat $JBOSS_HOME/server/all/deploy/jmx-console.war/WEB-INF/web.xml > all.jmx-console.war.web.xml.txt
cat $JBOSS_HOME/server/all/conf/login-config.xml > all.jmx-console.war.login-config.xml.txt
cat $JBOSS_HOME/server/default/deploy/jmx-console.war/WEB-INF/jboss-web.xml > default.jmx-console.war.jboss-web.xml.txt
cat $JBOSS_HOME/server/default/deploy/jmx-console.war/WEB-INF/web.xml > default.jmx-console.war.web.xml.txt
cat $JBOSS_HOME/server/default/conf/login-config.xml > default.jmx-console.war.login-config.xml.txt

echo "[+] Getting Web-Console configuration files"
cat $JBOSS_HOME/server/default/deploy/management/console-mgr.sar/web-console.war/WEB-INF/jboss-web.xml > default.console-mgr.sar.jboss-web.xml.txt
cat $JBOSS_HOME/server/default/deploy/management/console-mgr.sar/web-console.war/WEB-INF/web.xml > default.console-mgr.sar.web.xml.txt
cat $JBOSS_HOME/server/all/deploy/management/console-mgr.sar/web-console.war/WEB-INF/jboss-web.xml > all.console-mgr.sar.jboss-web.xml.txt
cat $JBOSS_HOME/server/all/deploy/management/console-mgr.sar/web-console.war/WEB-INF/web.xml > all.console-mgr.sar.web.xml.txt

echo "[+] Getting HTTP Invoker configuration files"
cat $JBOSS_HOME/server/all/deploy/httpha-invoker.sar/invoker.war/WEB-INF/web.xml > all.httpha-invoker.sar.web.xml.txt
cat $JBOSS_HOME/server/default/deploy/httpha-invoker.sar/invoker.war/WEB-INF/jboss-web.xml > default.httpha-invoker.sar.jboss-web.xml.txt
cat $JBOSS_HOME/server/all/deploy/http-invoker.sar/invoker.war/WEB-INF/web.xml > all.http-invoker.sar.web.xml.txt
cat $JBOSS_HOME/server/default/deploy/http-invoker.sar/invoker.war/WEB-INF/jboss-web.xml > default.http-invoker.sar.jboss-web.xml.txt

echo "[+] Getting JMX Invoker configuration files"
cat $JBOSS_HOME/server/default/deploy/jmx-invoker-service.xml > default.jmx-invoker-service.xml.txt 
cat $JBOSS_HOME/server/all/deploy/jmx-invoker-service.xml > all.jmx-invoker-service.xml.txt

ps -ef > jboss-process.txt
cat /etc/passwd > passwd.txt
cat /etc/shadow > shadow.txt
passwd -S jboss > jboss-status.txt

tar cvzf "$OUTFILES.tar" "$AUDIT_DIR"
cd "$CURRENT_DIR"
echo "DONE ! config saved at $OUTFILES"
