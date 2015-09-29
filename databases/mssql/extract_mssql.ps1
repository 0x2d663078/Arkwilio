Import-module servermanager

$targetdir = ".\outfiles\mssql\"

if(!(Test-Path -Path $targetdir )){
    New-Item -ItemType directory -Path $targetdir
}

Get-windowsfeature >> .\outfiles\mssql\Server_Role.txt
Get-WmiObject Win32_QuickFixEngineering |  select description,HotFixId,Name | Export-CSV .\outfiles\mssql\MS-SQL-Liste-Patch.csv
netstat -ano|select-string 1433.+listening > .\outfiles\mssql\MS-SQL-2-11.txt