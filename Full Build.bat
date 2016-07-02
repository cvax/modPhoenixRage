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


echo.
echo.
echo Encoding localization w3strings.........
cd /d "%W3STRINGSENCODER%"
call w3strings --encode %STRINGS%\locale.en.csv --id-space %W3STRINGSIDSPACE%

echo Removing debug Witcher Script files.........
del %STRINGS%\locale.en.csv.w3strings.ws

echo Renaming to proper language names...........
ren %STRINGS%\locale.en.csv.w3strings en.w3strings

echo Generating other languages from English.....
copy %STRINGS%\en.w3strings %PACKED%\ar.w3strings
copy %STRINGS%\en.w3strings %PACKED%\br.w3strings
copy %STRINGS%\en.w3strings %PACKED%\cz.w3strings
copy %STRINGS%\en.w3strings %PACKED%\de.w3strings
copy %STRINGS%\en.w3strings %PACKED%\en.w3strings
copy %STRINGS%\en.w3strings %PACKED%\es.w3strings
copy %STRINGS%\en.w3strings %PACKED%\esmx.w3strings
copy %STRINGS%\en.w3strings %PACKED%\fr.w3strings
copy %STRINGS%\en.w3strings %PACKED%\hu.w3strings
copy %STRINGS%\en.w3strings %PACKED%\it.w3strings
copy %STRINGS%\en.w3strings %PACKED%\jp.w3strings
copy %STRINGS%\en.w3strings %PACKED%\kr.w3strings
copy %STRINGS%\en.w3strings %PACKED%\pl.w3strings
copy %STRINGS%\en.w3strings %PACKED%\ru.w3strings
copy %STRINGS%\en.w3strings %PACKED%\zh.w3strings
del %STRINGS%\en.w3strings
echo.
echo Success. W3Strings packaged.


echo.
echo.
echo Bundling scripts.........
XCOPY "%SCRIPTS%" "%PACKEDSCRIPTS%" /S/Y
echo.
echo Success. Scripts packaged.



echo.
echo.
:choice
set /P c="Install %NAME% to Witcher 3? (Y/N)"
if /I "%c%" EQU "Y" goto :movespot
if /I "%c%" EQU "N" goto :exitspot
goto :choice
:movespot
if not exist %GAMEPATH%\Mods\%NAME% mkdir %GAMEPATH%\Mods\%NAME%
XCOPY "%COMPILED%" "%GAMEPATH%\Mods" /S/Y
echo.
echo.
echo %NAME% successfully installed to Witcher 3.
echo Remember to use Script Merger if you have other mods installed.
pause 
exit
:exitspot
echo.
echo.
echo %NAME% generated successfully.
pause 
exit