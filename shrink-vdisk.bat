@echo off
wsl --shutdown
wsl -l -v

echo wsl --shutdown
echo wsl -l -v

echo ---
echo %cd%
echo ---

echo ---
echo diskpark 
echo ---

echo #commands
echo ---
echo select vdisk file="%cd%\*************.vhdx"
echo attach vdisk readonly
echo compact vdisk
echo detach vdisk
echo exit
echo ---
echo caution: commands above are IO intensive and may take several minutes

start /w diskpart
