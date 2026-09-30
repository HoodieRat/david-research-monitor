@echo off
setlocal
"%LOCALAPPDATA%\Programs\DavidResearchMonitor\ResearchMonitor.Diagnostics.exe" --full
exit /b %errorlevel%
