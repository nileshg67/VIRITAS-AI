@echo off
title Veritas Plagiarism Checker (Direct File Mode)
echo Opening Veritas Standalone App in your default browser...
if exist "%~dp0dist\index.html" (
	start "" "%~dp0dist\index.html"
) else (
	start "" "%~dp0app.html"
)
