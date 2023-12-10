@echo off
if "%~1"=="" (
  echo enter file name and scale % percentage to resize image
  echo example: 
  echo "    resizeimage abc_file.png 50% new_file_name.jpg"
) else (
  magick "%~1" -scale "%~2" "%~3"
)