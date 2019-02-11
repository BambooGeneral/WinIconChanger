@echo off
echo Install in progress
pushd %~dp0
powershell -NoProfile -ExecutionPolicy Unrestricted "./iconset.ps1"
pause > nul
exit