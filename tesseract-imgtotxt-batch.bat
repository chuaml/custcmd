@echo off
if "%1"=="" (
    echo Tesseract-OCR tesseract custom wrapper
    echo tesseract program is required
    echo "usage dir /b | %0 [saveToDir] [langMode]"
    echo     %0 tempDir
    echo     %0 tempDir eng+equ
    echo     %0 tempDir eng
) else (
    if not exist "%1" mkdir "%1"
    if "%2"=="" (
        for /F "tokens=*" %%x in ('more') do (
            tesseract "%%x" "%1/%%x.txt" --oem 3 --psm 6 -c preserve_interword_spaces=1 -l eng+equ
        )
    ) else (
        for /F "tokens=*" %%x in ('more') do (
            tesseract "%%x" "%1/%%x.txt" --oem 3 --psm 6 -c preserve_interword_spaces=1 -l %2
        )
    )
)
