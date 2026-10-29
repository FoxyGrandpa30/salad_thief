@echo off
setlocal
cd /d "%~dp0"
if exist "pcgrid-live-amd64.iso" goto exists
if exist "pcgrid-live-amd64.iso.partial" goto partial
if not exist "pcgrid-iso.part001.bin" goto missing
if not exist "pcgrid-iso.part002.bin" goto missing
if not exist "pcgrid-iso.part003.bin" goto missing
if not exist "pcgrid-iso.part004.bin" goto missing
if not exist "pcgrid-iso.part005.bin" goto missing
if not exist "pcgrid-iso.part006.bin" goto missing
if not exist "pcgrid-iso.part007.bin" goto missing
if not exist "pcgrid-iso.part008.bin" goto missing
if not exist "pcgrid-iso.part009.bin" goto missing
if not exist "pcgrid-iso.part010.bin" goto missing
if not exist "pcgrid-iso.part011.bin" goto missing
if not exist "pcgrid-iso.part012.bin" goto missing
if not exist "pcgrid-iso.part013.bin" goto missing
if not exist "pcgrid-iso.part014.bin" goto missing
if not exist "pcgrid-iso.part015.bin" goto missing
if not exist "pcgrid-iso.part016.bin" goto missing
if not exist "pcgrid-iso.part017.bin" goto missing
echo Reconstructing the ISO from 17 parts. This can take a few minutes.
copy /b "pcgrid-iso.part001.bin"+"pcgrid-iso.part002.bin"+"pcgrid-iso.part003.bin"+"pcgrid-iso.part004.bin"+"pcgrid-iso.part005.bin"+"pcgrid-iso.part006.bin"+"pcgrid-iso.part007.bin"+"pcgrid-iso.part008.bin"+"pcgrid-iso.part009.bin"+"pcgrid-iso.part010.bin"+"pcgrid-iso.part011.bin"+"pcgrid-iso.part012.bin"+"pcgrid-iso.part013.bin"+"pcgrid-iso.part014.bin"+"pcgrid-iso.part015.bin"+"pcgrid-iso.part016.bin"+"pcgrid-iso.part017.bin" "pcgrid-live-amd64.iso.partial" >nul
if errorlevel 1 goto failed
echo Verifying the complete ISO checksum...
powershell.exe -NoLogo -NoProfile -NonInteractive -Command "$ErrorActionPreference='Stop'; try { $h=(Get-FileHash -LiteralPath 'pcgrid-live-amd64.iso.partial' -Algorithm SHA256).Hash; if ($h -ne '50acf472a49f3b944bcb8b9fcdd0994dbc0305c4850159b5595a8f7c3d09a986') { throw 'ISO checksum mismatch' }; Move-Item -LiteralPath 'pcgrid-live-amd64.iso.partial' -Destination 'pcgrid-live-amd64.iso' -ErrorAction Stop } catch { Write-Error $_; exit 1 }"
if errorlevel 1 goto failed
echo SUCCESS: pcgrid-live-amd64.iso matches the original verified build.
echo Write this ISO to a spare boot USB using the project instructions.
pause
exit /b 0
:missing
echo ERROR: One or more image parts are missing. Extract the complete downloaded ZIP.
pause
exit /b 1
:exists
echo An ISO already exists in this folder. Move it elsewhere before retrying.
pause
exit /b 1
:partial
echo An unfinished .partial file exists. Move it elsewhere before retrying.
pause
exit /b 1
:failed
echo Assembly or verification failed. The .partial file is not a usable boot image.
echo Keep the displayed error and report it. The original parts have not been changed.
pause
exit /b 1
