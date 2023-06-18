@echo off
REM different mode of operation
REM original doc, refer https://terser.org/docs/cli-usage/
if "%~1"=="--file" (
    REM Read files to be process from input stream
    for /F "tokens=*" %%a in ('more') do (
      npx terser "%%a" --output "%2/%%a" --compress --mangle
    )
) else if "%~1"=="--" (
    REM Read plaintext to be process from input stream, save as %2 filename
    REM minify-js -- gg.js < tdcx.flash.learn.login.js
    npx terser --output "%2" --compress --mangle
) else if "%~1"=="" (
    REM explaination
    echo .
    echo --file  to take and process files name from input stream
    echo --  to take plaintext code from input stream
    echo [in file] [output file]  to minify a file
) else (
    REM Use command-line arguments; input file %1, output file %2
    npx terser "%1" --output "%2" --compress --mangle
)
