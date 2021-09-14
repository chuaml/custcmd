@echo off
for %%I in (.) do set currentDirName=%%~nxI
7z a -tzip -mx1 "%currentDirName%.zip" %*
