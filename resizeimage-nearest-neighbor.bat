@echo off
IF not exist "%2" mkdir "%2"
for /F "tokens=*" %%a in ('more') do (
  magick %%a -interpolate Integer -filter point -resize "%1" "%2"/%%a
)