@echo off
call BuildVariables.cmd
if not exist %COOKED% mkdir %COOKED%
if not exist %PACKED% mkdir %PACKED%

echo Clearing old files............
set folder="%COMPILED%"
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
echo Creating Custom Icons.........
echo Packaging bundles.............
cd /d "%MODKITPATH%"
call wcc_lite cook -platform=pc -mod="%MODDED%" -basedir="%WITCHERBASEDIR%" -outdir="%COOKED%"
call wcc_lite buildcache textures -basedir="%MODDED%" -platform=pc -db="%COOKED%\cook.db" -out="%PACKED%\texture.cache"
call wcc_lite pack -dir="%MODDED%" -outdir="%PACKED%"
call wcc_lite metadatastore -path="%PACKED%"
echo.
echo Success. Bundles packaged.