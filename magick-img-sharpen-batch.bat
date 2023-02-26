@echo off
if "%1"=="" (
    echo ImageMagick magick CLI is require,
    echo usage, batch process image file from pipeline standard input
    echo "  %0 1[saveToDir] 2[decimalAmount] "
    echo "  %0 tempDir 2.0 "
) else (
    if not exist "%1" mkdir "%1"
    for /F "tokens=*" %%a in ('more') do (
        magick "%%a" -level 1.0 -sharpen 0x"%2" "%1"/%%a
    )
)