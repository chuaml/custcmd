@echo off
@REM %~1 = path = 1st given arguement with dobule quotes removed
if "%~1"=="" (
    echo specify a path to zip files
    echo example:
    echo     zip "[ dir | filename ]"
) else (
    @REM bug fix, to allow use !varName_123! where variable is the latest set value
    setlocal enabledelayedexpansion

    @REM set current dir name
    for %%I in ("%~1") do set currentDirName=%%~nxI

    if not exist "%~1" (
        echo "directory not found:  %~1"
    ) else (
        if exist "%~1/*" (
            @REM zip all files in %~1
            7z a -tzip -mx1 "!currentDirName!.zip" "%~1/*"
        ) else (
            @REM zip a file; %~1 is a file , not dir
            7z a -tzip -mx1 "!currentDirName!.zip" "%~1"
        )
    )
)
