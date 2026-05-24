@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set FFDEC=java -jar D:\GitHub\XinTianyu-Sky\ZMXY_Flash\tools\ffdec_15.0.0\ffdec.jar
set GAME_DIR=D:\software\Game\zmxy3\造梦西游3再续天庭0.85
set OUT_DIR=D:\GitHub\XinTianyu-Sky\ZMXY_Flash\decompiled

echo ==========================================
echo   ZMXY3 Full SWF Decompilation
echo ==========================================

:: === A-class: Scripts + Images + Sounds ===

echo.
echo [A] Decompiling numbered core modules...
for %%f in (0 1 2 3 4 5 6 7 8 9 10 12 13 14 15 16 17 18 20 21 22 30 43 44 45 46 53 98 99 116) do (
    if exist "%GAME_DIR%\assets\%%f.swf" (
        echo   %%f.swf...
        %FFDEC% -export script,image,sound "%OUT_DIR%\core\%%f" "%GAME_DIR%\assets\%%f.swf" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
    )
)

echo.
echo [A] Decompiling date-named modules...
for %%f in (20120117 20120119 20120203 20120808) do (
    if exist "%GAME_DIR%\assets\%%f.swf" (
        echo   %%f.swf...
        %FFDEC% -export script,image,sound "%OUT_DIR%\core\%%f" "%GAME_DIR%\assets\%%f.swf" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
    )
)

echo.
echo [A] Decompiling system SWFs...
for %%f in (pet1 MagicWeapon MagicWeapon2 EndlessMode ThreeBothers Role1Effect SD1) do (
    if exist "%GAME_DIR%\assets\%%f.swf" (
        echo   %%f.swf...
        %FFDEC% -export script,image,sound "%OUT_DIR%\systems\%%f" "%GAME_DIR%\assets\%%f.swf" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
    )
)

echo.
echo [A] Decompiling UI SWFs...
for %%f in (Common1 StageCommon EIcon1 EIcon2 mouse backpack1 shop past hdDoor jifenActivity sgzz OtherMat1 Otherzm) do (
    if exist "%GAME_DIR%\assets\%%f.swf" (
        echo   %%f.swf...
        %FFDEC% -export script,image "%OUT_DIR%\ui\%%f" "%GAME_DIR%\assets\%%f.swf" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
    )
)

echo.
echo [A] Decompiling SpecialUI SWFs...
for %%f in (WuKong TangSeng BaJie ShaShen) do (
    if exist "%GAME_DIR%\assets\SpecialUI\%%f.swf" (
        echo   SpecialUI/%%f.swf...
        %FFDEC% -export script,image "%OUT_DIR%\characters\%%f_UI" "%GAME_DIR%\assets\SpecialUI\%%f.swf" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
    )
)

:: === B-class: Images/Sounds only (asset SWFs) ===

echo.
echo [B] Exporting character sprites...
for %%f in (WuKong TangSeng BaJie ShaShen) do (
    if exist "%GAME_DIR%\assets\%%f.swf" (
        echo   %%f.swf...
        %FFDEC% -export image "%OUT_DIR%\characters\%%f" "%GAME_DIR%\assets\%%f.swf" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
    )
)

echo.
echo [B] Exporting monster sprites...
for %%f in (Monster1000 Monster1007 Monster1008 Monster1111 Monster47 Monster60) do (
    if exist "%GAME_DIR%\assets\%%f.swf" (
        echo   %%f.swf...
        %FFDEC% -export image "%OUT_DIR%\monsters\%%f" "%GAME_DIR%\assets\%%f.swf" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
    )
)

echo.
echo [B] Exporting equipment sprites...
if exist "%GAME_DIR%\assets\cs_zb" (
    for %%f in ("%GAME_DIR%\assets\cs_zb\*.swf") do (
        echo   cs_zb/%%~nxf...
        %FFDEC% -export image "%OUT_DIR%\equipment\%%~nf" "%%f" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
    )
)

echo.
echo [B] Exporting Music.swf...
if exist "%GAME_DIR%\assets\Music.swf" (
    echo   Music.swf (this may take a while)...
    %FFDEC% -export sound "%OUT_DIR%\music" "%GAME_DIR%\assets\Music.swf" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
)

echo.
echo [B] Exporting fonts.swf...
if exist "%GAME_DIR%\assets\fonts.swf" (
    echo   fonts.swf...
    %FFDEC% -export font "%OUT_DIR%\fonts" "%GAME_DIR%\assets\fonts.swf" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
)

:: === C-class: Level SWFs (mixed) ===

echo.
echo [C] Decompiling level SWFs...
if exist "%GAME_DIR%\assets\levels" (
    for %%f in ("%GAME_DIR%\assets\levels\*.swf") do (
        echo   levels/%%~nxf...
        %FFDEC% -export script,image "%OUT_DIR%\levels\%%~nf" "%%f" 2>&1 | findstr /C:"OK" /C:"ERROR" /C:"finished"
    )
)

echo.
echo ==========================================
echo   Decompilation Complete!
echo ==========================================
