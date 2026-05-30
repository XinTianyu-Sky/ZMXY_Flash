@echo off
chcp 65001 >nul
setlocal

:: pack.bat - Package full distributable version
:: Usage: pack.bat [output_zip_name]

set GAME_DIR=D:\GitHub\XinTianyu-Sky\ZMXY_Flash\game
set PACK_NAME=%1
if "%PACK_NAME%"=="" set PACK_NAME=zmxy3_full.zip
set PACK_DIR=D:\GitHub\XinTianyu-Sky\ZMXY_Flash\release

echo === Packaging ZMXY3 Full Release ===

:: Clean and setup
if exist "%PACK_DIR%" rmdir /S /Q "%PACK_DIR%"
mkdir "%PACK_DIR%"

:: Core launcher files
echo [1/4] Copying launcher...
copy "%GAME_DIR%\造梦西游之再续天庭.exe" "%PACK_DIR%\" /Y >nul
xcopy "%GAME_DIR%\Adobe AIR" "%PACK_DIR%\Adobe AIR\" /E /I /Y /Q >nul
xcopy "%GAME_DIR%\META-INF" "%PACK_DIR%\META-INF\" /E /I /Y /Q >nul
copy "%GAME_DIR%\launch.swf" "%PACK_DIR%\" /Y >nul
xcopy "%GAME_DIR%\gameData" "%PACK_DIR%\gameData\" /E /I /Y /Q >nul

:: Modified launch.swf (if exists)
echo [2/4] Checking for modified launch.swf...
if exist "D:\GitHub\XinTianyu-Sky\ZMXY_Flash\dist\launch.swf" (
    copy "D:\GitHub\XinTianyu-Sky\ZMXY_Flash\dist\launch.swf" "%PACK_DIR%\" /Y >nul
    echo   Using modified launch.swf from dist\
)

:: All assets
echo [3/5] Copying assets...
xcopy "%GAME_DIR%\assets" "%PACK_DIR%\assets\" /E /I /Y /Q >nul

:: Player README
echo [4/5] Adding README...
(
echo 造梦西游3再续天庭 v0.85
echo.
echo === 如何开始玩 ===
echo.
echo 解压后双击 "造梦西游之再续天庭.exe" 即可启动游戏。
echo.
echo 首次运行时 Windows 可能会弹出 SmartScreen 警告，点击"更多信息" → "仍要运行"。
echo.
echo 游戏存档保存在 gameData 目录下，为本地文件。建议定期备份。
echo.
echo === 快捷操作 ===
echo.
echo   I    打开/关闭背包
echo   S    打开/关闭技能面板
echo   P    打开/关闭宠物面板
echo   J K L U 等  技能快捷键
echo   方向键  移动和跳跃
echo.
echo === 常见问题 ===
echo.
echo Q: 游戏打不开？
echo A: 确保 Adobe AIR 目录与 exe 在同一文件夹，不要移动或删除。
echo.
echo Q: 怎么全屏？
echo A: 游戏窗口默认大小，暂不支持全屏。
echo.
echo Q: 存档在哪？
echo A: gameData\ 目录下，复制整个文件夹即可备份/迁移存档。
echo.
echo === 关于 ===
echo.
echo 基于 B 站"机智的远远"社区二次开发单机版。
echo 作者：夕眼、石竹
echo 版本：v0.85 (2023-01-22)
) > "%PACK_DIR%\README.txt"

:: Zip it
echo [5/5] Creating %PACK_NAME%...
cd /d "%PACK_DIR%"
powershell -command "Compress-Archive -Path * -DestinationPath '..\%PACK_NAME%' -Force"

echo.
echo === Done ===
dir "..\%PACK_NAME%" 2>nul
echo Package: %PACK_DIR%\..\%PACK_NAME%
