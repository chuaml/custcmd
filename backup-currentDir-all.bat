@echo off

for %%I in (.) do set currentDirName=%%~nxI

set year=%date:~-4,4%
set month=%date:~-10,2%
set day=%date:~-7,2%

set todayDate=%year%-%month%-%day%

xcopy * "..\backup\%todayDate%\%currentDirName%\" /E /I /Y

pause
