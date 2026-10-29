@echo off
setlocal

cd /d "%~dp0"

echo Airacare Web App + Backend
echo.
echo Serves the browser web UI through Flask.
echo Uses the Android TFLite backend by default and Firebase web records.
echo Local URL: http://localhost:8000
echo.

venv\Scripts\python.exe web_backend.py

pause
