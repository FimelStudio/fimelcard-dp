@echo off
chcp 65001 >nul 2>&1
title Unicode Obfuscation Engine v2.0
setlocal EnableDelayedExpansion

REM ============================================================
REM  Unicode Obfuscation Engine - Windows Launcher v2.0
REM  Drag this .bat into PowerShell or double-click to run.
REM  On first run, auto-downloads portable Python (once).
REM ============================================================

set "SCRIPT_DIR=%~dp0"
set "PY_DIR=%SCRIPT_DIR%python"
set "PY_EXE=%PY_DIR%\python.exe"
set "SCRIPT=%SCRIPT_DIR%obfuscate_standalone.py"
set "PYTHON_VERSION=3.11.9"
set "PYTHON_URL=https://www.python.org/ftp/python/%PYTHON_VERSION%/python-%PYTHON_VERSION%-embed-amd64.zip"
set "ZIP_FILE=%SCRIPT_DIR%python-embed.zip"

REM --- 1. Try bundled Python ---
if exist "%PY_EXE%" (
    "%PY_EXE%" "%SCRIPT%" %*
    goto :done
)

REM --- 2. Try system Python ---
where python >nul 2>&1
if !errorlevel! equ 0 (
    python "%SCRIPT%" %*
    goto :done
)

REM --- 3. Try py launcher ---
where py >nul 2>&1
if !errorlevel! equ 0 (
    py "%SCRIPT%" %*
    goto :done
)

REM --- 4. Auto-download portable Python ---
echo.
echo  Python not found. Downloading portable Python %PYTHON_VERSION%...
echo  This only happens once.
echo.

REM Use PowerShell to download
powershell -Command "try { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%PYTHON_URL%' -OutFile '%ZIP_FILE%' -UseBasicParsing } catch { Write-Host $_.Exception.Message; exit 1 }"

if !errorlevel! neq 0 (
    echo.
    echo  [ERROR] Download failed. Please check your internet connection.
    echo  Or install Python from https://www.python.org/
    echo.
    pause
    goto :done
)

echo  Extracting...
if not exist "%PY_DIR%" mkdir "%PY_DIR%"
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%PY_DIR%' -Force"

if not exist "%PY_EXE%" (
    echo.
    echo  [ERROR] Extraction failed.
    echo.
    pause
    goto :done
)

REM Clean up zip
del "%ZIP_FILE%" >nul 2>&1

echo  Starting...
echo.

"%PY_EXE%" "%SCRIPT%" %*

:done
endlocal
