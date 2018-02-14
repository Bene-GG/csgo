@echo off
TITLE CSGO-Umgebungsvariable für Multiaccounting
goto START
BESCHREIBUNG:
    Setzt die Umgebungsvariable "USRLOCALCSGO" auf den Pfad zur CSGO-Installation, damit dortige Configdateien wieder funktionieren.
    Muss als Administrator ausgeführt werden
:START

:CSGOPFADHOLEN
echo Hole CSGO-Pfad aus Registry...
set WinRegistryCSGO=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 730
set WinRegistryCSGOPathVal=InstallLocation

FOR /F "tokens=2*" %%A IN ('REG.exe query "%WinRegistryCSGO%" /v "%WinRegistryCSGOPathVal%"') DO (set CSGOOrdner=%%B)

echo Setze USRLOCALCSGO auf "%CSGOORDNER%"
setx USRLOCALCSGO "%CSGOORDNER%\csgo" /M
exit /b 0