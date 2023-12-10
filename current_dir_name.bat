@echo off

@REM bug fix, to allow use !varName_123! where variable is the latest set value
setlocal enabledelayedexpansion

@REM set current dir name
for %%I in (.) do set currentDirName=%%~nxI
echo !currentDirName!
