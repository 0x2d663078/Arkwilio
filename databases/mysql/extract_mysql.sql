-- version beta
-- tudu : find a solution to save show vars and db output to multiple files

show variables;
show databases;
select * from mysql.user into outfile '/tmp/audit/variables.out';
select * from mysql.host into outfile '/tmp/audit/mysql_host_lists.out';
select * from mysql.tables_priv into outfile '/tmp/audit/mysql_tables_priv.out';
select * from mysql.collumns_priv into outfile '/tmp/audit/mysql_collumns_priv.out';
select * from mysql.procs_priv into outfile '/tmp/audit/mysql_procs_priv.out'
select user from mysql.user where user = 'root' into outfile '/tmp/audit/default_username.out';
select User, Password from mysql.user where length(password) < 41 into outfile '/tmp/audit/mysql_weak_passwords.out';
select user, password from mysql.user where length(password) = 0 or password is null into outfile '/tmp/audit/mysql_weak_passwords_2.out';
select user from mysql.user where host = '%' into outfile '/tmp/audit/wildcards_hosts.out';
select user from mysql.user where user = '' into outfile '/tmp/audit/blanck_users_name.out';
select user, host from mysql.user where (Select_priv = 'Y') or (Insert_priv = 'Y') or (Update_priv = 'Y') or (Delete_priv = 'Y') or (Create_priv = 'Y') or (Drop_priv = 'Y') into outfile '/tmp/audit/mysql_users_privs.out';
select user, host from mysql.db where db = 'mysql' and ( (Select_priv = 'Y') or (Insert_priv = 'Y') or (Update_priv = 'Y') or (Delete_priv = 'Y') or (Create_priv = 'Y') or (Drop_priv = 'Y')) into outfile '/tmp/audit/mysql_db_privs.out';
select user, host from mysql.user where File_priv = 'Y' into outfile '/tmp/audit/File_priv.out';
select user, host from mysql.user where Process_priv = 'Y' into outfile '/tmp/audit/Process_priv.out';
select user, host from mysql.user where Super_priv = 'Y' into outfile '/tmp/audit/Super_priv.out';
select user, host from mysql.user where Shutdown_priv = 'Y' into outfile '/tmp/audit/Shutdown_priv.out';
select user, host from mysql.user where Create_user_priv = 'Y' into outfile '/tmp/audit/Create_user_priv.out';
select user, host from mysql.user where Reload_user_priv = 'Y' into outfile '/tmp/audit/Reload_user_priv.out';
select user, host from mysql.user where Create_user_priv = 'Y' into outfile '/tmp/audit/Create_user_priv.out';