@ECHO OFF

REM
REM FUNCTION :
REM   Run as a privilged user to document the security level of IIS server.
REM   The idea is to extract configuration files for offline analysis.
REM
REM TESTED ON : 
REM  Windows Server 2008
REM
REM REFERENCES :
REM   CIS Apache/HTTPD server Benchmark security
REM
REM

@setlocal enableextensions
@cd /d "%~dp0"

IF NOT EXIST ".\outfiles" (
mkdir outfiles
)

echo IIS config. EXTRACTOR By TMR

set app_cmd=%systemroot%\system32\inetsrv\appcmd.exe

ipconfig /all >> .\outfiles\MS-INFO.txt

ver >> .\outfiles\MS-INFO-VER.txt

%systemroot%\system32\inetsrv\appcmd.exe list vdir >> .\outfiles\MS-IIS001.txt

dir /a %systemdrive%\inetpub\AdminScripts >> .\outfiles\MS-IIS002-1.txt
dir /a %systemdrive%\inetpub\scripts\IISSamples >> .\outfiles\MS-IIS002-2.txt
dir /a %programfiles%\Common Files\System\msadc >> .\outfiles\MS-IIS002-3.txt
%app_cmd% list vdir "Default Web Site/IISHelp" >> .\outfiles\MS-IIS002-4.txt

%app_cmd% list sites >> .\outfiles\MS-IIS003.txt

%app_cmd% list config /section:directoryBrowse >> .\outfiles\MS-IIS004.txt

%app_cmd% list config /section:applicationPools >> .\outfiles\MS-IIS005-1.txt

%app_cmd% list apppools >> .\outfiles\MS-IIS005-2.txt

%app_cmd% list app >> .\outfiles\MS-IIS005-2.txt

%app_cmd% list config -section:system.webServer/security/authorization /text:* >> .\outfiles\MS-IIS006.txt

%app_cmd% list config -section:system.webServer/security/authentication/basicAuthentication /text:* >> .\outfiles\MS-IIS007-1.txt
%app_cmd% list config -section:system.webServer/security/authentication/windowsAuthentication /text:* >> .\outfiles\MS-IIS007-2.txt
%app_cmd% list config -section:system.webServer/security/authentication/clientCertificateMappingAuthentication /text:* >> .\outfiles\MS-IIS007-3.txt
%app_cmd% list config -section:system.webServer/security/authentication/digestAuthentication /text:* >> .\outfiles\MS-IIS007-4.txt
%app_cmd% list config -section:system.webServer/security/authentication/anonymousAuthentication /text:* >> .\outfiles\MS-IIS007-5.txt
%app_cmd% list config -section:system.webServer/security/authentication/iisClientCertificateMappingAuthentication /text:* >> .\outfiles\MS-IIS007-6.txt

%app_cmd% list config -section:system.webServer/security/authentication/basicAuthentication /text:* >> .\outfiles\MS-IIS008-1.txt
%app_cmd% list config -section:system.webServer/security/authentication/windowsAuthentication /text:* >> .\outfiles\MS-IIS008-2.txt
%app_cmd% list config -section:system.webServer/security/authentication/clientCertificateMappingAuthentication /text:* >> .\outfiles\MS-IIS008-3.txt
%app_cmd% list config -section:system.webServer/security/authentication/digestAuthentication /text:* >> .\outfiles\MS-IIS008-4.txt
%app_cmd% list config -section:system.webServer/security/authentication/anonymousAuthentication /text:* >> .\outfiles\MS-IIS008-5.txt
%app_cmd% list config -section:system.webServer/security/authentication/iisClientCertificateMappingAuthentication /text:* >> .\outfiles\MS-IIS008-6.txt

%app_cmd% list config -section:system.web/deployment /text:* >> .\outfiles\MS-IIS009-1.txt

%app_cmd% list config /section:compilation >> .\outfiles\MS-IIS010-1.txt
%app_cmd% list config -section:system.web/compilation /text:* >> .\outfiles\MS-IIS010-2.txt

%app_cmd% list config -section:system.web/cutomErrors /text:* >> .\outfiles\MS-IIS011.txt

%app_cmd% list config -section:system.web/sessionState /text:* >> .\outfiles\MS-IIS012-1.txt

%app_cmd% list config -section:system.web/httpCookies /text:* >> .\outfiles\MS-IIS012-2.txt

%app_cmd% list config -section:system.web/machineKey /text:* >> .\outfiles\MS-IIS013.txt

%app_cmd% list config -section:system.web/trust /text:* >> .\outfiles\MS-IIS014.txt

%app_cmd% list config -section:system.webServer/security/requestFiltering /text:* >> .\outfiles\MS-IIS015.txt

%app_cmd% list config >> .\outfiles\MS-IIS-ALL.txt 

echo DONE ! CONFIG SAVED AT OUTFILES
pause


