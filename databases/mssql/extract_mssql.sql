/*

FUNCTION :
   Run as root to document the security level of MySQL server.
   The idea is to extract configuration files for offline analysis.

 TESTED ON : 
   ---

 REFERENCES :
   CIS MySQL server Benchmark security
*/

SELECT 'SQL Server Version & Information';
SELECT SERVERPROPERTY('ProductLevel') as SP_installed, SERVERPROPERTY('ProductVersion') as Version;

SELECT 'SQL Server global configuration';
exec sp_configure;

SELECT 'SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = ad hoc distributed queries; '
SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = 'ad hoc distributed queries'; 

SELECT 'SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = ad hoc distributed queries; '
SELECT '/*CIS 2.2 SQL*/'
SELECT name,CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = 'clr enabled'; 

SELECT 'SELECT name,CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = clr enabled; '
SELECT '/*CIS 2.3 SQL*/'
SELECT name,CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = 'Cross db ownership chaining';

SELECT 'SELECT name,CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = Cross db ownership chaining;'
SELECT '/*2.4 SQL*/'
SELECT name,CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = 'Database Mail XPs';

SELECT 'SELECT name,CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = Database Mail XPs;'
SELECT '/*2.5 SQL*/'
SELECT name,CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = 'Ole Automation Procedures';

SELECT 'SELECT name,CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = Ole Automation Procedures;'
SELECT '/*2.6 SQL*/'
SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = 'Remote access'; 

SELECT 'SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = Remote access; '
SELECT '/*2.7 SQL*/'
SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = 'Remote admin connections' AND SERVERPROPERTY('IsClustered') = 0;

SELECT 'SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = Remote admin connections AND SERVERPROPERTY(IsClustered) = 0;'
SELECT '/*2.8 SQL*/'
SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = 'Scan for startup procs';

SELECT 'SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = Scan for startup procs;'
SELECT '/*2.9 SQL*/'
SELECT name FROM sys.databases WHERE is_trustworthy_on = 1 AND name != 'msdb' AND state = 0; 

SELECT 'SELECT name FROM sys.databases WHERE is_trustworthy_on = 1 AND name != msdb AND state = 0;'
SELECT '/*2.13+14 sa*/'

SELECT 'SELECT name, is_disabled FROM sys.server_principals WHERE sid = 0x01;'
SELECT name, is_disabled FROM sys.server_principals WHERE sid = 0x01; 

SELECT '/*2.15*/'
SELECT 'SELECT CONVERT(INT, ISNULL(value, value_in_use)) AS config_value FROM  sys.configurations WHERE  name = Nxp_cmdshell ;'
SELECT CONVERT(INT, ISNULL(value, value_in_use)) AS config_value FROM  sys.configurations WHERE  name = N'xp_cmdshell' ;

SELECT '/*3.*/'
SELECT '/*3.1 SQL*/'
SELECT 'exec xp_loginconfig login mode;'
exec xp_loginconfig 'login mode'; 

SELECT '/*3.3 SQL*/'
SELECT 'exec sp_change_users_login @Action=Report;'
exec sp_change_users_login @Action='Report'; 

SELECT '/*4.2*/'
SELECT 'SELECT SQLLoginName = sp.name FROM sys.server_principals sp JOIN sys.sql_logins AS sl ON sl.principal_id = sp.principal_id WHERE sp.type_desc = SQL_LOGIN AND sp.name in (SELECT name AS IsSysAdmin FROM sys.server_principals p WHERE IS_SRVROLEMEMBER(sysadmin,name) = 1) AND sl.is_expiration_checked <> 1;'
SELECT SQLLoginName = sp.name FROM sys.server_principals sp JOIN sys.sql_logins AS sl ON sl.principal_id = sp.principal_id WHERE sp.type_desc = 'SQL_LOGIN' AND sp.name in (SELECT name AS IsSysAdmin FROM sys.server_principals p WHERE IS_SRVROLEMEMBER('sysadmin',name) = 1) AND sl.is_expiration_checked <> 1;

SELECT '/*4.3*/'
SELECT 'SELECT SQLLoginName = sp.name,PasswordPolicyEnforced = CAST(sl.is_policy_checked AS BIT) FROM sys.server_principals sp JOIN sys.sql_logins AS sl ON sl.principal_id = sp.principal_id WHERE sp.type_desc = SQL_LOGIN;'
SELECT SQLLoginName = sp.name,PasswordPolicyEnforced = CAST(sl.is_policy_checked AS BIT) FROM sys.server_principals sp JOIN sys.sql_logins AS sl ON sl.principal_id = sp.principal_id WHERE sp.type_desc = 'SQL_LOGIN'; 

SELECT '/*5.*/'
SELECT '/*5.1*/'
SELECT '/*5.2 SQL*/'
SELECT 'SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = Default trace enabled; '
SELECT name, CAST(value as int) as value_configured, CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = 'Default trace enabled'; 

