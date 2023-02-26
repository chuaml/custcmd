@echo off
if "%1"=="" (
    echo Tesseract-OCR tesseract custom wrapper
    echo tesseract program is required
    echo usage %0 [input_file_img] [langMode]
    echo     %0 input_pic.jpg
    echo     %0 input_pic.jpg eng+equ
    echo     %0 input_pic.jpg eng
    echo default options, if not given, output to console 
    echo     - --oem 3 --psm 6 -c preserve_interword_spaces=1 -l eng+equ
) else (
    if "%2"=="" (
        tesseract "%1" - --oem 3 --psm 6 -c preserve_interword_spaces=1 -l eng+equ
    ) else (
        tesseract "%1" - --oem 3 --psm 6 -c preserve_interword_spaces=1 -l %2
    )
)
