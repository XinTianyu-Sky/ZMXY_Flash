@echo off
chcp 65001 >nul
setlocal

:: run_test.bat - Setup test environment and launch the game with modified SWFs
:: First run does one-time setup (copies launcher + creates assets symlink)

set GAME_DIR=D:\software\Game\zmxy3\造梦西游3再续天庭0.85
set DIST_DIR=D:\GitHub\XinTianyu-Sky\ZMXY_Flash\dist

:: One-time setup
if not exist "%DIST_DIR%\造梦西游之再续天庭.exe" (
    echo [Setup] First run: copying game launcher to dist\ ...
    copy "%GAME_DIR%\造梦西游之再续天庭.exe" "%DIST_DIR%\" /Y >nul
    xcopy "%GAME_DIR%\Adobe AIR" "%DIST_DIR%\Adobe AIR\" /E /I /Y /Q >nul
    xcopy "%GAME_DIR%\META-INF" "%DIST_DIR%\META-INF\" /E /I /Y /Q >nul
    if not exist "%DIST_DIR%\gameData" xcopy "%GAME_DIR%\gameData" "%DIST_DIR%\gameData\" /E /I /Y /Q >nul
    echo [Setup] Done.
)

:: Create assets symlink if not exists
if not exist "%DIST_DIR%\assets" (
    mklink /J "%DIST_DIR%\assets" "%GAME_DIR%\assets" >nul 2>&1
    if errorlevel 1 (
        echo WARNING: Cannot create symlink. Copying assets (slow, one-time)...
        xcopy "%GAME_DIR%\assets" "%DIST_DIR%\assets\" /E /I /Y /Q >nul
    )
)

:: Copy modified launch.swf if we have one
if exist "%DIST_DIR%\launch.swf" (
    echo [Test] Using modified launch.swf
)

:: Launch
echo [Test] Starting game...
start "" "%DIST_DIR%\造梦西游之再续天庭.exe"
