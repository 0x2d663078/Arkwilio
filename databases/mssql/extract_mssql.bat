@ECHO OFF
@setlocal enableextensions
@cd /d "%~dp0"

IF NOT EXIST ".\outfiles" (
mkdir .\outfiles
)
secedit /export /cfg .\outfiles\mssql\backup_gpo.inf 
powershell.exe -noprofile -executionpolicy bypass -file extract_mssql.ps1

ECHO EXTRACTION TERMINEE !