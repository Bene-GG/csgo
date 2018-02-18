@echo off
mode con: cols=75 lines=50
TITLE Bene-CFG-Autoinstall.cmd
CLS
goto START
BESCHREIBUNG:
    Installiert die hier verfügbaren Modifikationen.
:START
cd %~dp0
:CSGOPFADHOLEN
set WinRegistryCSGO=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 730
set WinRegistryCSGOPathVal=InstallLocation

FOR /F "tokens=2*" %%A IN ('REG.exe query "%WinRegistryCSGO%" /v "%WinRegistryCSGOPathVal%"') DO (set CSGOOrdner=%%B)


REM USRLOCALCSGO
echo. && echo Umgebungsvariable setzen, damit Konfigurationen wieder aus dem CSGO-Ordner,
CHOICE /C JN /M "anstatt aus Steam\userdata geladen werden?"
IF ERRORLEVEL 2 GOTO AUTOEXECQ
IF ERRORLEVEL 1 GOTO CSGOENVVAR
:CSGOENVVAR
echo.
call set_PathUSRLOCALCSGO.cmd
echo.
echo Umgebungsvariable USRLOCALCSGO angepasst
REM ---------------------

REM Autoexec
:AUTOEXECQ

echo. && CHOICE /C JN /M "Autoexec kopieren/ueberschreiben?"
IF ERRORLEVEL 2 GOTO TEXTMODQ
IF ERRORLEVEL 1 GOTO AUTOEXEC
:AUTOEXEC
copy /Y ".\autoexec.cfg" "%CSGOOrdner%\csgo\cfg\autoexec.cfg"
echo autoexec.cfg kopiert
REM ---------------------

REM Textmod-Dateien
:TEXTMODQ
echo. && CHOICE /C JN /M "Textmod kopieren/ueberschreiben?"
IF ERRORLEVEL 2 GOTO FONTQ
IF ERRORLEVEL 1 GOTO TEXTMOD
:TEXTMOD
copy /Y ".\textmod\csgo_textmod.txt" "%CSGOOrdner%\csgo\resource\csgo_textmod.txt"
echo csgo_textmod.txt kopiert
REM ---------------------

REM Font-Dateien
:FONTQ

echo. && CHOICE /C JN /M "Schriftart kopieren/ueberschreiben?"
IF ERRORLEVEL 2 GOTO RADARQ
IF ERRORLEVEL 1 GOTO FONT
:FONT
copy /Y ".\font\Calibri\fontlib_custom.swf" "%CSGOOrdner%\csgo\resource\flash\fontlib_custom.swf"
echo fontlib_custom.swf kopiert
copy /Y ".\font\Calibri\fontmapping.cfg" "%CSGOOrdner%\csgo\resource\flash\fontmapping.cfg"
echo fontmapping.cfg kopiert
REM ---------------------

REM Radar-Dateien
:RADARQ

echo. && CHOICE /C JN /M "Radarbilder kopieren/ueberschreiben?"
IF ERRORLEVEL 2 GOTO ENDQ
IF ERRORLEVEL 1 GOTO RADAR
:RADAR
copy /Y ".\radar\files\*.dds" "%CSGOOrdner%\csgo\resource\overviews"
echo Radar-Dateien kopiert
REM ---------------------

:ENDQ

echo. && CHOICE /C JN /M "Skript beenden (J) oder neustarten (N)?"
IF ERRORLEVEL 2 GOTO START
IF ERRORLEVEL 1 GOTO END
:END
echo Ende: Fertig
exit /b 0