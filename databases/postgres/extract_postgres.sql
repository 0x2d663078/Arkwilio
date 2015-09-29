
-- \i extract.sql
\o /tmp/audit/outputsql.txt
\qecho '****************************************************************'
\qecho '|'
\qecho '| password weakness'
\qecho '|'
\qecho '****************************************************************'
\qecho ''
SELECT usename,passwd FROM pg_shadow WHERE usename LIKE 'postgres';
SELECT usename,passwd FROM pg_shadow WHERE passwd not LIKE 'md5%' OR length(passwd) <> 35;
SELECT user FROM mysql.user WHERE user = 'root' OR user='';
\qecho '****************************************************************'
\qecho '|'
\qecho '| Test and Default table/databse/shcema'
\qecho '|'
\qecho '****************************************************************'
\qecho ''
SELECT table_name FROM information_schema.tables WHERE table_schema LIKE 'test';
SELECT datname FROM pg_database where datname LIKE 'template1' OR datname LIKE 'public';
select schema_name from information_schema.schemata WHERE schema_name LIKE 'template1' OR schema_name LIKE 'public';
\qecho '****************************************************************'
\qecho '|'
\qecho '|  List Roles'
\qecho '|'
\qecho '****************************************************************'
\qecho ''
\du
\l
\qecho '****************************************************************'
\qecho '|'
\qecho '|  List table, view, and sequence access privileges '
\qecho '|'
\qecho '****************************************************************'
\qecho ''
\dp
\qecho '****************************************************************'
\qecho '|'
\qecho '|  Lists schema permissions'
\qecho '|'
\qecho '****************************************************************'
\dn+
\qecho '****************************************************************'
\qecho '|'
\qecho '| Lists default access privilege settings'
\qecho '|'
\qecho '****************************************************************'
\qecho ''
\ddp
\qecho '****************************************************************'
\qecho '|'
\qecho '| DB version'
\qecho '|'
\qecho '****************************************************************'
\qecho ''
SELECT version();
\o