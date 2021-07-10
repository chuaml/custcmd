@echo off
java -cp "%~dp0./java/PPointSearcher.jar" Searcher.PPointSearcher --help

echo current working directory: "%CD%"
echo java -cp "%~dp0./java/PPointSearcher.jar" Searcher.PPointSearcher -w -c

:askdir
set /p searchdir="search directory: "
if "%searchdir%"=="" (set searchdir=.)
if EXIST "%searchdir%" (
echo "%searchdir%"
call java -cp "%~dp0./java/PPointSearcher.jar" Searcher.PPointSearcher -p "%searchdir%"
) ELSE (
echo no such directory, please re-enter valid dir.
goto askdir
)
pause