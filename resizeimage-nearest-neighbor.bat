@echo off
if "%~1"=="" (
  echo enter file name and scale % percentage to resize image (resize pixels to nearest neighbor)
  echo example: 
  echo "    resizeimage abc_file.png 50% new_file_name.jpg"
) else (
  magick "%~1" -interpolate Integer -filter point -scale "%~2" "%~3"
)