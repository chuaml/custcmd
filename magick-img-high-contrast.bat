@echo off
if "%~1"=="" (
    echo ImageMagick magick CLI is require,
    echo usage, batch process image file from pipeline standard input
    echo pipe from " dir /b *.jpg | ..."
    echo "  %0 1[saveToDir]  "
    echo "  %0 tempDir  "
) else (
    if not exist "%~1" mkdir "%~1"
    for /F "tokens=*" %%a in ('more') do (
        echo "%%a" -colorspace gray -sharpen 0x1 -normalize -threshold 50%% -resize 50%% -sharpen 0x1 -bordercolor white -border 16 "%~1/"%%a
        magick "%%a" -colorspace gray -sharpen 0x1 -normalize -threshold 50%% -resize 50%% -sharpen 0x1 -bordercolor white -border 16 "%~1/"%%a
    )
)