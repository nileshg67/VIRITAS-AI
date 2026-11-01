@echo off
title Veritas Plagiarism Checker
cls
echo ============================================================
echo   VERITAS - AI Plagiarism & Originality Checker
echo ============================================================
echo   Starting local server without npm / Node.js...
echo   Opening in your default browser...
echo.
powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0server.ps1"
pause
