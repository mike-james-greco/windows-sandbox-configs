@echo off

set LOGFILE=%1
del %LOGFILE% > nul 2>&1

echo [%date% %time%] Installing WinGet >> %LOGFILE% 2>&1

REM Install NuGet Provider
echo [%date% %time%] Installing NuGet Provider >> %LOGFILE% 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Install-PackageProvider -Name NuGet -Force" > nul 2>&1
if %errorlevel% neq 0 (
    echo [%date% %time%] Failed to install NuGet Provider with error code %errorlevel% >> %LOGFILE% 2>&1
    exit /b %errorlevel%
)

REM Install Microsoft.WinGet.Client Module
echo [%date% %time%] Installing Microsoft.WinGet.Client Module >> %LOGFILE% 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery" > nul 2>&1
if %errorlevel% neq 0 (
    echo [%date% %time%] Failed to install Microsoft.WinGet.Client Module with error code %errorlevel% >> %LOGFILE% 2>&1
    exit /b %errorlevel%
)

REM Repair WinGet Package Manager
echo [%date% %time%] Bootstrapping WinGet Package Manager >> %LOGFILE% 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Repair-WinGetPackageManager" > nul 2>&1
if %errorlevel% neq 0 (
    echo [%date% %time%] Failed to bootstrap WinGet Package Manager with error code %errorlevel% >> %LOGFILE% 2>&1
    exit /b %errorlevel%
)

echo [%date% %time%] WinGet Installed >> %LOGFILE% 2>&1