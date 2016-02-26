-- Oracle Audit Script
-- v 2.0.0
-- Author TMR
-- Run As : DBA
-----------

SET PAGESIZE 0 -- to set an infinite pagesize and avoid headings , titles and so on ...
SET LINESIZE 32766  -- the length of the line.
SET TRIM ON
SET TRIMSPOOL ON -- otherwise every line in the spoolfile is filled up with blanks until the linesize is reached.
SET TRIMOUT ON -- otherwise every line in the output is filled up with blanks until the linesize is reached.
SET WRAP OFF -- Truncates the line if its is longer then LINESIZE. This should not happen if linesize is large enough.
SET TERMOUT OFF -- suppresses the printing of the results to the output. The lines are still written to the spool file.


SET serveroutput ON SIZE 1000000

spool ORA11G-01.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='APEX_040000' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('oracle')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from sys.user$ where name='APEX_040000' and password='EE7785338B8FFE3D';
spool off;

spool ORA11G-02.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='APPQOSSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('appqossys')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='APPQOSSYS';
spool off;

spool ORA11G-03.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='CTXSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('ctxsys')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='CTXSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('change_on_install')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='CTXSYS';
spool off;

spool ORA11G-04.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='DBSNMP' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('dbsnmp')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='DBSNMP';
spool off;

spool ORA11G-05.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='DIP' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('dip')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='DIP';
spool off;

spool ORA11G-06.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='EXFSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('exfsys')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='EXFSYS';
spool off;

spool ORA11G-07.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='MDDATA' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('mddata')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='MDDATA';
spool off;

spool ORA11G-08.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='MDSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('sys')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='MDSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('mdsys')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='MDSYS';
spool off;

spool ORA11G-09.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='LBACSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('lbacsys')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='LBACSYS';
spool off;

spool ORA11G-10.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='OLAPSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('manager')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='OLAPSYS';
spool off;

spool ORA11G-11.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='ORACLE_OCM' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('oracle_ocm')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='ORACLE_COM';
spool off;

spool ORA11G-12.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='ORDDATA' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('orddata')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='ORDDATA';
spool off;

spool ORA11G-13.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='ORDPLUGINS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('ordplugins')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='ORDPLUGINS';
spool off;

spool ORA11G-14.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='ORDSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('ordsys')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='ORDSYS';
spool off;

spool ORA11G-15.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='OUTLN' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('outln')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='OUTLN';
spool off;

spool ORA11G-16.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='OWBSYS_AUDIT' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('owbsys_audit')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='OWBSYS_AUDIT';
spool off;

spool ORA11G-17.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='OWBSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('owbsys')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='OWBSYS';
spool off;

spool ORA11G-18.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='SI_INFORMTN_SCHEMA' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('si_informtn_schema')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='SI_INFORMTN_SCHEMA';
spool off;

spool ORA11G-19.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='SPATIAL_CSW_ADMIN_USR' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('spatial_csw_admin_usr')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='SPATIAL_CSW_ADMIN_USR';
spool off;

spool ORA11G-20.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='SPATIAL_WFS_ADMIN_USR' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('spatial_wfs_admin_usr')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='SPATIAL_WFS_ADMIN_USR';
spool off;

spool ORA11G-21.txt
select 'defaultpwd' as defaultpassword from sys.user$ where name='SYS' and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('manager')||hextoraw(substr(spare4,43,20)), 3))) union select 'defaultpwd' as defaultpassword from sys.user$ where name='SYS' and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('change_on_install')||hextoraw(substr(spare4,43,20)), 3))) union select 'defaultpwd' as defaultpassword from sys.user$ where name='SYS' and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('d_syspw')||hextoraw(substr(spare4,43,20)), 3))) union select 'defaultpwd' from dba_users_with_defpwd where username='SYS';
spool off;

spool ORA11G-22.txt
select 'defaultpwd' as defaultpassword from sys.user$ where name='SYSTEM' and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('manager')||hextoraw(substr(spare4,43,20)), 3))) union select 'defaultpwd' as defaultpassword from sys.user$ where name='SYSTEM' and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('d_systpw')||hextoraw(substr(spare4,43,20)), 3))) union select 'defaultpwd' from dba_users_with_defpwd where username='SYSTEM';
spool off;

spool ORA11G-23.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='WK_TEST' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('wk_test')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='WK_TEST';
spool off;


spool ORA11G-24.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='WKPROXY' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('change_on_install')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='WKPROXY' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('wkproxy')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='WKPROXY';
spool off;

spool ORA11G-25.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='WKSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('wksys')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='WKSYS';
spool off;

spool ORA11G-26.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='WMSYS' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('wmsys')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='WMSYS';
spool off;

spool ORA11G-27.txt
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='XDB' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('xdb')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' as defaultpassword 
from sys.user$ 
where name='XDB' 
 and substr(spare4,3,40)=rawtohex(utl_raw.cast_to_varchar2(sys.dbms_crypto.hash(utl_raw.cast_to_raw('change_on_install')||hextoraw(substr(spare4,43,20)), 3)))
union
select 'defaultpwd' from dba_users_with_defpwd where username='XDB';
spool off;

spool ORA11G-28.txt
SELECT username FROM ALL_USERS WHERE USERNAME='BI';
spool off;

spool ORA11G-29.txt
SELECT username FROM ALL_USERS WHERE USERNAME='HR';
spool off;

spool ORA11G-30.txt
SELECT username FROM ALL_USERS WHERE USERNAME='IX';
spool off;

spool ORA11G-31.txt
SELECT username FROM ALL_USERS WHERE USERNAME='OE';
spool off;

spool ORA11G-32.txt
SELECT username FROM ALL_USERS WHERE USERNAME='PM';
spool off;

spool ORA11G-33.txt
SELECT username FROM ALL_USERS WHERE USERNAME='SCOTT';
spool off;

spool ORA11G-34.txt
SELECT username FROM ALL_USERS WHERE USERNAME='SH';
spool off;

spool ORA11G-ACCOUNT-STATUS.txt
SELECT USERNAME, ACCOUNT_STATUS FROM DBA_USERS WHERE USERNAME in ('APEX_040000','APPQOSSYS','CTXSYS','DBSNMP','DIP','EXFSYS','MDDATA','MDSYS','LBACSYS','OLAPSYS','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','OUTLN','OWBSYS_AUDIT','OWBSYS','SI_INFORMTN_SCHEMA','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','SYSTEM','WK_TEST','WKPROXY','WKSYS','WMSYS','XDB','BI','HR','IX','OE','PM','SCOTT','SH');
spool off;

spool ORA11G-35.txt
SELECT * FROM DBA_REGISTRY_HISTORY;
spool off;

spool ORA11G-38.txt 
SELECT VALUE FROM V$PARAMETER WHERE upper(name)='AUDIT_SYS_OPERATIONS';
spool off;

spool ORA11G-39.txt 
SELECT VALUE FROM V$PARAMETER WHERE upper(name)='AUDIT_TRAIL';
spool off;

spool ORA11G-41.txt 
SELECT value from v$parameter a where upper(name) = 'LOCAL_LISTENER';
spool off;

spool ORA11G-42.txt 
SELECT VALUE FROM V$PARAMETER WHERE upper(name)='O7_DICTIONARY_ACCESSIBILITY';
spool off;

spool ORA11G-48.txt 
SELECT VALUE FROM V$PARAMETER WHERE upper(name)='UTL_FILE_DIR';
spool off;

spool ORA11G-49.txt 
SELECT VALUE FROM V$PARAMETER WHERE upper(name)='SEC_CASE_SENSITIVE_LOGON';
spool off;

spool ORA11G-50.txt 
SELECT VALUE FROM V$PARAMETER WHERE upper(name)='SEC_MAX_FAILED_LOGIN_ATTEMPTS';
spool off;

spool ORA11G-51.txt 
SELECT VALUE FROM V$PARAMETER WHERE upper(name)='SEC_PROTOCOL_ERROR_FURTHER_ACTION';
spool off;

spool ORA11G-52.txt 
SELECT VALUE FROM V$PARAMETER WHERE upper(name)='SEC_PROTOCOL_ERROR_TRACE_ACTION';
spool off;

spool ORA11G-53.txt 
SELECT VALUE FROM V$PARAMETER WHERE upper(name)='SEC_RETURN_SERVER_RELEASE_BANNER';
spool off;

spool ORA11G-55.txt 
SELECT VALUE FROM V$PARAMETER WHERE lower(name)='_trace_files_public';
spool off;

spool ORA11G-ALL-V-PARAMETER.txt 
SELECT * FROM V$PARAMETER;
spool off;

spool ORA11G-56.txt 
SELECT PROFILE, RESOURCE_NAME, LIMIT FROM DBA_PROFILES WHERE PROFILE='DEFAULT' AND RESOURCE_NAME='FAILED_LOGIN_ATTEMPTS';
spool off;

spool ORA11G-57.txt 
SELECT PROFILE, RESOURCE_NAME, LIMIT FROM DBA_PROFILES WHERE PROFILE='DEFAULT' AND RESOURCE_NAME='PASSWORD_LOCK_TIME';
spool off;

spool ORA11G-58.txt 
SELECT PROFILE, RESOURCE_NAME, LIMIT FROM DBA_PROFILES WHERE PROFILE='DEFAULT' AND RESOURCE_NAME='PASSWORD_LIFE_TIME';
spool off;

spool ORA11G-59.txt 
SELECT PROFILE, RESOURCE_NAME, LIMIT FROM DBA_PROFILES WHERE PROFILE='DEFAULT' AND RESOURCE_NAME='PASSWORD_REUSE_MAX';
spool off;

spool ORA11G-60.txt 
SELECT PROFILE, RESOURCE_NAME, LIMIT FROM DBA_PROFILES WHERE PROFILE='DEFAULT'AND RESOURCE_NAME='PASSWORD_REUSE_TIME';
spool off;

spool ORA11G-61.txt 
SELECT PROFILE, RESOURCE_NAME, LIMIT FROM DBA_PROFILES WHERE PROFILE='DEFAULT'AND RESOURCE_NAME='PASSWORD_GRACE_TIME';
spool off;

spool ORA11G-62.txt 
SELECT USERNAME FROM DBA_USERS WHERE AUTHENTICATION_TYPE='EXTERNAL';
spool off;

spool ORA11G-63.txt 
SELECT PROFILE, RESOURCE_NAME FROM DBA_PROFILES WHERE RESOURCE_NAME='PASSWORD_VERIFY_FUNCTION';
spool off;

spool ORA11G-64.txt 
SELECT PROFILE, RESOURCE_NAME, LIMIT FROM DBA_PROFILES WHERE RESOURCE_NAME='SESSIONS_PER_USER' AND PROFILE='DEFAULT';
spool off;

spool ORA11G-65.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='DBMS_ADVISOR' AND GRANTEE ='PUBLIC';
spool off;

spool ORA11G-67.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='DBMS_JAVA' AND GRANTEE = 'PUBLIC';
spool off;

spool ORA11G-68.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='DBMS_JAVA_TEST' AND GRANTEE ='PUBLIC';
spool off;

spool ORA11G-69.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS WHERE TABLE_NAME='DBMS_JOB' AND GRANTEE='PUBLIC';
spool off;

spool ORA11G-70.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='DBMS_LDAP' AND GRANTEE ='PUBLIC';
spool off;

spool ORA11G-74.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS WHERE TABLE_NAME='DBMS_SCHEDULER' AND GRANTEE='PUBLIC';
spool off;

spool ORA11G-75.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='DBMS_SQL' and GRANTEE='PUBLIC';
spool off;

spool ORA11G-78.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='UTL_FILE' AND GRANTEE = ('PUBLIC');
spool off;

spool ORA11G-80.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS WHERE TABLE_NAME='UTL_TCP' AND GRANTEE = 'PUBLIC';
spool off;

spool ORA11G-81.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='UTL_MAIL' and GRANTEE ='PUBLIC';
spool off;

spool ORA11G-82.txt 
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='UTL_SMTP' and GRANTEE = 'PUBLIC';
spool off;

spool ORA11G-83.txt   
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='UTL_DBWS' AND GRANTEE ='PUBLIC';
spool off;
spool ORA11G-84.txt   
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='UTL_ORAMTS' AND GRANTEE ='PUBLIC';
spool off;

spool ORA11G-85.txt   
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='UTL_HTTP' AND GRANTEE = 'PUBLIC';
spool off;

spool ORA11G-86.txt   
SELECT GRANTEE, TABLE_NAME FROM DBA_TAB_PRIVS where TABLE_NAME='HTTPURITYPE' AND GRANTEE ='PUBLIC' ;
spool off;

spool ORA11G-102.txt
SELECT GRANTEE, PRIVILEGE FROM DBA_SYS_PRIVS where PRIVILEGE='SELECT ANY DICTIONARY' AND GRANTEE NOT IN ('DBA','DBSNMP','OEM_MONITOR','OLAPSYS','ORACLE_OCM','SYSMAN','WMSYS');
spool off;
  
spool ORA11G-103.txt 
SELECT GRANTEE, PRIVILEGE FROM DBA_SYS_PRIVS where PRIVILEGE='SELECT_ANY_TABLE';
spool off;

spool ORA11G-106.txt
SELECT GRANTEE, PRIVILEGE FROM DBA_SYS_PRIVS where PRIVILEGE='BECOME USER' AND GRANTEE NOT IN ('DBA','SYS','IMP_FULL_DATABASE');
spool off;
  
spool ORA11G-107.txt
SELECT GRANTEE, PRIVILEGE FROM DBA_SYS_PRIVS where PRIVILEGE='CREATE PROCEDURE' and GRANTEE NOT IN ( 'DBA','DBSNMP','MDSYS','OLAPSYS','OWB$CLIENT','OWBSYS','RECOVERY_CATALOG_OWNER','SPATIAL_CSW_ADMIN_USR','SPATIAL_WFS_ADMIN_USR','SYS','APEX_030200','APEX_040000','APEX_040100','APEX_040200');
spool off;
 
spool ORA11G-110.txt
SELECT * FROM DBA_SYS_PRIVS WHERE PRIVILEGE='GRANT ANY OBJECT PRIVILEGE' AND GRANTEE NOT IN ('DBA','SYS','IMP_FULL_DATABASE','DATAPUMP_IMP_FULL_DATABASE');
spool off;
  
spool ORA11G-111.txt
SELECT * FROM DBA_SYS_PRIVS WHERE PRIVILEGE='GRANT ANY ROLE' AND GRANTEE NOT IN ('DBA','SYS','DATAPUMP_IMP_FULL_DATABASE','IMP_FULL_DATABASE','SPATIAL_WFS_ADMIN_USR','SPATIAL_CSW_ADMIN_USR');
spool off;
  
spool ORA11G-112.txt
SELECT * FROM DBA_SYS_PRIVS WHERE PRIVILEGE='GRANT ANY PRIVILEGE' AND GRANTEE NOT IN ('DBA','SYS','IMP_FULL_DATABASE','DATAPUMP_IMP_FULL_DATABASE');
spool off;
  
spool ORA11G-116.txt 
SELECT GRANTEE, GRANTED_ROLE FROM DBA_ROLE_PRIVS WHERE GRANTED_ROLE='DBA' AND GRANTEE NOT IN ('SYS','SYSTEM');
spool off;

spool ORA11G-117.txt
SELECT GRANTEE, PRIVILEGE FROM DBA_TAB_PRIVS WHERE TABLE_NAME='AUD$' and grantee not in ('DELETE_CATALOG_ROLE');
spool off;

spool ORA11G-118.txt
SELECT GRANTEE, PRIVILEGE FROM DBA_TAB_PRIVS WHERE TABLE_NAME='USER_HISTORY$'; 
spool off;

spool ORA11G-119.txt
SELECT GRANTEE, PRIVILEGE FROM DBA_TAB_PRIVS WHERE TABLE_NAME='USER$' and grantee not in ('CTXSYS','XDB','APEX_030200', 'APEX_040000','APEX_040100','APEX_040200'); 
spool off;

spool ORA11G-120.txt
SELECT GRANTEE, PRIVILEGE FROM DBA_TAB_PRIVS WHERE TABLE_NAME='SCHEDULER$_CREDENTIAL'; 
spool off;

spool ORA11G-121.txt  
SELECT GRANTEE, PRIVILEGE FROM dba_tab_privs WHERE TABLE_NAME LIKE 'DBA_%' and grantee not in ('APEX_030200','APPQOSSYS','AQ_ADMINISTRATOR_ROLE','CTXSYS','EXFSYS','MDSYS','OLAP_XS_ADMIN','OLAPSYS','ORDSYS','OWB$CLIENT','OWBSYS','SELECT_CATALOG_ROLE','WM_ADMIN_ROLE','WMSYS','XDBADMIN') and table_name not in ('DBA_SDO_MAPS','DBA_SDO_STYLES','DBA_SDO_THEMES','LBACSYS','ADM_PARALLEL_EXECUTE_TASK');
spool off;

spool ORA11G-122.txt
select owner,table_name from all_tables where owner='SYS' and table_name='USER$MIG'; 
spool off;

spool ORA11G-123.txt
SELECT * FROM DBA_SYS_PRIVS where privilege='EXECUTE ANY PROCEDURE' and grantee='OUTLN'; 
spool off;

spool ORA11G-124.txt
SELECT * FROM DBA_SYS_PRIVS where privilege='EXECUTE ANY PROCEDURE' and grantee='DBSNMP'; 
spool off;

spool ORA11G-129.txt  
SELECT USER_NAME, SUCCESS, FAILURE FROM DBA_PRIV_AUDIT_OPTS WHERE PRIVILEGE='CREATE SESSION';
spool off;
  
spool ORA11G-130.txt  
select USER_NAME, SUCCESS, FAILURE from DBA_STMT_AUDIT_OPTS where AUDIT_OPTION in ('CREATE USER','USER');
spool off;
  
spool ORA11G-131.txt  
select USER_NAME, SUCCESS, FAILURE from DBA_STMT_AUDIT_OPTS where AUDIT_OPTION in ('ALTER USER', 'USER');
spool off;
  
spool ORA11G-132.txt  
select USER_NAME, SUCCESS, FAILURE from DBA_STMT_AUDIT_OPTS where AUDIT_OPTION in ('DROP USER','USER');
spool off;
  
spool ORA11G-144.txt 
select * from DBA_PRIV_AUDIT_OPTS where privilege='GRANT ANY OBJECT PRIVILEGE';
spool off;
  
spool ORA11G-145.txt 
select * from DBA_PRIV_AUDIT_OPTS where privilege='GRANT ANY PRIVILEGE';
spool off;

spool ORA11G-155.txt 
SELECT * from DBA_OBJ_AUDIT_OPTS where OBJECT_NAME='AUD$';
spool off;
  
spool ORA11G-156.txt 
SELECT USER_NAME, SUCCESS, FAILURE FROM DBA_PRIV_AUDIT_OPTS WHERE PRIVILEGE='ALTER SYSTEM';
spool off;
