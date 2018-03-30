@ECHO OFF
SET ThisDir=%~dp0
SET PSScript=set_SteamHomepage.ps1
SET ScriptPath=%ThisDir%powershell\%PSScript%
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%ScriptPath%""' -Verb RunAs}";