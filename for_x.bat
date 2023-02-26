@echo off
for /F "tokens=*" %%x in ('more') do (
  %*
)