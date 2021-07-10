@echo off
for /l %%x in (1,1,%2) do (
    curl "%1" -o nul %3 %4 %5
)

echo.
echo powershell command: 
echo for($i=0;$i -lt %2;$i++){curl "%1" %3 %4 %5}