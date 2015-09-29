# Arkwilio

A collection of bash scripts to document the security level of an operating system, web server or database. The idea is to perform local scan to gather/extract configuration files for offline analysis.

These scripts has almost no dependencies,  so it's very self-containe and can be used on almost all Unix based systems and versions. List of covered products :

* Linux (RedHat & Debian).
* Apache HTTPD Server.
* Apache Tomcat.
* IIS.
* JBoss AS.
* MySQL.
* Postgres.
* Oracle.

This toolkit can be useful in the following situations :

* The device do not support remote access, or the network department may be very protective and do not provide valide credentials to perform authenticated remote scanning.
* The device is located on a a part of the network that block classic remote scanners (for example : due to a NIDS) or remote code execution.

This toolkit is dedicated to :

* System administrators
* Security Consultants / Pentesters.
* Security officers
* Security professionals


# Usage

1. Clone or download the project files. No compilation or installation is required.
2. Run as privileged user to perform a deep scan.

Sample usage : perform a scan of a Linux Server

```bash
#./extract_linux.sh
 ______________________________________
/ Linux Configuration Auditor Script   \
\ Version : 1.0                        /
 --------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/"
                ||----w |
                ||     ||


Script started at:
Mon Sep 28 21:40:43 CDT 2015


[!] (1/13) Gathering System Kernel information
[!] (2/13) Gathering users/groups informations
[!] (3/13) Getting network configuration
[!] (4/13) Service & Process
[!] (5/13) Gathering programs/binaries informations
[!] (6/13) System startup/boot configuration
[!] (7/13) System partitions configuration
[!] (8/13) Check system integrity
[!] (9/13) Audit/review permissions on files & directories
[!] (10/13) Getting environment configuration (paths, available shells ...)
[!] (11/13) Password policy & storage information
[!] (12/13) Gathering informaions about existing Jobs/Tasks
[!] (13/13) System Logging & Auditing
### SCAN COMPLETE ! CONFIG SAVED AT /home/audit/EXTRACT_Linux_2015_09_28-21:40:43.tar ###
```

At the end of execution, the output is saved in one single compressed file (. tar) to facilitate download from the audited/scanned system. Then, you can perfom further security analysis/check at your own. 

# REFERENCES :

These scripts uses tests from many standards and hardening guides :

* CIS Security Hardening Guide.
* NIST/DoD Hardening Guide.
* JBoss Hardening Guide.

This project is also based on [LinEnum](https://github.com/rebootuser/LinEnum) tool, which is an advanced script for Local Linux Enumeration & Privilege Escalation Checks.
