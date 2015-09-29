#!/bin/sh
#
# FUNCTION :
#   Run as root to document the security level of JBoss 5.
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
JBOSS_USERNAME=$2
                             
if [ -z "$JBOSS_HOME" ] ; then
	echo "Usage : $0 JBOSS_HOME JBOSS_USERNAME"
	echo "Example : $0 /opt/jboss-x.x.x.GA/ jboss"
	exit 1
fi

if [ ! -d "$JBOSS_HOME" ] ; then
	echo "Le chemin ($JBOSS_HOME) n'existe pas"
	exit 1
fi

check_user=$(grep -c ^$JBOSS_USERNAME /etc/passwd)

if [ $check_user -eq 1 ]; then
    echo ""
else
    echo "L utilisateur ($JBOSS_USERNAME) n existe pas"
    exit 1
fi

AUDIT_DIR="/tmp/auditjboss"
CURRENT_DIR=$(pwd)
OUTFILES=$(pwd)"/EXTRACT_Jboss5_"`date +%Y_%m_%d-%H:%M:%S`
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

echo "[+] Getting config. files"
echo "[+] Getting main configuration file (server.xml)"
cat $JBOSS_HOME/server/default/deploy/jbossweb.sar/server.xml > all.server.xml.txt
cat $JBOSS_HOME/server/all/deploy/jbossweb.sar/server.xml > all.server.xml.txt

echo "[+] Getting jboss-web.deployer configuration file"
cat $JBOSS_HOME/server/default/deployers/jbossweb.deployer/web.xml > default.web.xml.txt
cat $JBOSS_HOME/server/all/deployers/jbossweb.deployer/web.xml > all.web.xml.txt

echo "[+] Getting jboss-beans configuration file"
cat $JBOSS_HOME/server/all/deployers/jbossws.deployer/META-INF/jboss-beans.xml > default.jboss-beans.xml.txt
cat $JBOSS_HOME/server/default/deployers/jbossws.deployer/META-INF/jboss-beans.xml > all.jboss-beans.xml.txt

echo "[+] Getting JMX-Console configuration files"
cat $JBOSS_HOME/server/all/deploy/jmx-console.war/WEB-INF/jboss-web.xml > all.jmx-console.war.jboss-web.xml.txt
cat $JBOSS_HOME/server/all/deploy/jmx-console.war/WEB-INF/web.xml > all.jmx-console.war.web.xml.txt
cat $JBOSS_HOME/server/all/conf/login-config.xml > all.jmx-console.war.login-config.xml.txt
cat $JBOSS_HOME/server/default/deploy/jmx-console.war/WEB-INF/jboss-web.xml > default.jmx-console.war.jboss-web.xml.txt
cat $JBOSS_HOME/server/default/deploy/jmx-console.war/WEB-INF/web.xml > default.jmx-console.war.web.xml.txt
cat $JBOSS_HOME/server/default/conf/login-config.xml > default.jmx-console.war.login-config.xml.txt

echo "[+] Getting Web-Console configuration files"
cat $JBOSS_HOME/server/default/conf/loginconfig.xml > default.loginconfig.xml.txt
cat $JBOSS_HOME/server/default/deploy/management/console-mgr.sar/webconsole.war/WEB-INF/web.xml > default.web.xml.txt
cat $JBOSS_HOME/server/default/conf/props/jmx-console-users.properties > default.users.properties.txt
cat $JBOSS_HOME/server/all/conf/loginconfig.xml > all.loginconfig.xml.txt
cat $JBOSS_HOME/server/all/deploy/management/console-mgr.sar/webconsole.war/WEB-INF/web.xml > all.web.xml.txt
cat $JBOSS_HOME/server/all/conf/props/jmx-console-users.properties > all.jmx-console-users.properties.txt

echo "[+] Getting Admin Console configuration files"
cat $JBOSS_HOME/server/all/conf/login-config.xml > all.login-config.xml.txt 
cat $JBOSS_HOME/server/default/conf/login-config.xml > default.login-config.xml.txt

echo "[+] Getting JBossWS configuration files"
$JBOSS_HOME/server/default/deploy/jbossws.sar/jbossws-management.war/WEBINF/web.xml > default.jbossws-management.war.txt
$JBOSS_HOME/server/all/deploy/jbossws.sar/jbossws-management.war/WEBINF/web.xml > all.jbossws-management.war.txt

echo "[+] Getting HTTP Invoker configuration files"
cat $JBOSS_HOME/server/all/deploy/httpha-invoker.sar/invoker.war/WEB-INF/web.xml > all.httpha-invoker.sar.web.xml.txt
cat $JBOSS_HOME/server/default/deploy/httpha-invoker.sar/invoker.war/WEB-INF/jboss-web.xml > default.httpha-invoker.sar.jboss-web.xml.txt
cat $JBOSS_HOME/server/all/deploy/http-invoker.sar/invoker.war/WEB-INF/web.xml > all.http-invoker.sar.web.xml.txt
cat $JBOSS_HOME/server/default/deploy/http-invoker.sar/invoker.war/WEB-INF/jboss-web.xml > default.http-invoker.sar.jboss-web.xml.txt

echo "[+] Getting JMX Invoker configuration files"
cat $JBOSS_HOME/server/default/deploy/jmx-invoker-service.xml > default.jmx-invoker-service.xml.txt 
cat $JBOSS_HOME/server/all/deploy/jmx-invoker-service.xml > all.jmx-invoker-service.xml.txt

ps -ef > server-process.txt
grep -i $JBOSS_USERNAME /etc/passwd > passwd.txt

tar cvzf "$OUTFILES.tar" "$AUDIT_DIR"
cd "$CURRENT_DIR"
echo "DONE ! config saved at $OUTFILES"
