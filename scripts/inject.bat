@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: inject.bat - Inject a modified .as script into a target SWF
:: Usage: inject.bat <swf_rel_path> <class_name> <script_file>
:: Example: inject.bat launch.swf com.dusk.game.allConst src\launch\allConst.as

set FFDEC=java -jar D:\GitHub\XinTianyu-Sky\ZMXY_Flash\tools\ffdec_15.0.0\ffdec.jar
set GAME_DIR=D:\GitHub\XinTianyu-Sky\ZMXY_Flash\game
set DECODER=D:\GitHub\XinTianyu-Sky\ZMXY_Flash\build\zmxy_decoder_v2.exe
set TEMP=D:\GitHub\XinTianyu-Sky\ZMXY_Flash\build\temp_inject
set OUTPUT_DIR=D:\GitHub\XinTianyu-Sky\ZMXY_Flash\dist

if "%3"=="" (
    echo Usage: inject.bat ^<swf_rel_path^> ^<class_name^> ^<script_file^>
    echo   swf_rel_path: SWF file relative to game dir (e.g. launch.swf or assets\Common1.swf)
    echo   class_name:   fully qualified class name in the SWF (e.g. com.dusk.game.allConst)
    echo   script_file:  path to modified .as file (e.g. src\launch\allConst.as)
    exit /b 1
)

set SWF_NAME=%~n1
if "%SWF_NAME:~-4%" neq ".swf" set SWF_NAME=%SWF_NAME%.swf

:: Determine if this is launch.swf (not obfuscated) or an asset SWF (obfuscated)
echo %1 | findstr /i "launch.swf" >nul
if %errorlevel%==0 (
    set NEEDS_DECODE=0
    set SWF_PATH=%GAME_DIR%\launch.swf
) else (
    set NEEDS_DECODE=1
    set SWF_PATH=%GAME_DIR%\%1
)

if not exist "%SWF_PATH%" (
    echo ERROR: SWF not found: %SWF_PATH%
    exit /b 1
)

if not exist "%~fn3" (
    echo ERROR: Script file not found: %3
    exit /b 1
)

if not exist "%TEMP%" mkdir "%TEMP%"
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

copy "%SWF_PATH%" "%TEMP%\%SWF_NAME%" /Y >nul

if "%NEEDS_DECODE%"=="1" (
    echo [1/3] Decoding %SWF_NAME%...
    echo 0 | "%DECODER%" "%TEMP%\%SWF_NAME%" >nul 2>&1
) else (
    echo [1/3] No decode needed (launch.swf)
)

echo [2/3] Injecting %2 into %SWF_NAME%...
%FFDEC% -replace "%TEMP%\%SWF_NAME%" "%TEMP%\injected_%SWF_NAME%" "%2" "%~f3" 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Injection failed
    exit /b 1
)

if "%NEEDS_DECODE%"=="1" (
    echo [3/3] Re-encoding...
    echo 1 | "%DECODER%" "%TEMP%\injected_%SWF_NAME%" >nul 2>&1
)

move "%TEMP%\injected_%SWF_NAME%" "%OUTPUT_DIR%\%SWF_NAME%" >nul
echo Done: %OUTPUT_DIR%\%SWF_NAME%
