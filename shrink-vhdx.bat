@echo off

echo ---
echo shutdown all wsl VM
echo ---

wsl --shutdown
wsl -l -v

echo wsl --shutdown
echo wsl -l -v

echo ---
echo %cd%
echo ---


echo ---
for %%a in (*.vhdx) do set "vmFileName=%%a"
if "%vmFileName%"=="" (
    echo no .vhdx vm file:  %vmFileName%
    set "vmFileName=xxxxxxxxxxxxxxxxx "
) else (
    echo found 1 .vhdx vm file:  %vmFileName%
)
echo ---

echo ---
echo diskpark 
echo ---

echo #commands
echo ---

echo select vdisk file="%cd%\%vmFileName%"
echo attach vdisk readonly
echo compact vdisk
echo detach vdisk
echo exit
echo ---
echo caution: commands above are IO intensive and may take several minutes

start /w diskpart

pause