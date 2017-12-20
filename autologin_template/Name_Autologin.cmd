@echo off
SETLOCAL EnableExtensions

set username=Steam-Username
set steamdir=Steam-Pfad

:START
:STEAMPRUEFUNG
echo Pruefe, ob Steam laeuft...
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq Steam.exe"') DO IF %%x==Steam.exe (goto STEAMBEENDEN)ELSE (goto AUTOLOGIN)
goto AUTOLOGIN

:STEAMBEENDEN
echo Beende den Steam-Prozess...
cd /d "%steamdir%"
start /WAIT Steam.exe -shutdown
:STEAMBEENDENWAIT
echo Warte auf Beendigung...
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq Steam.exe"') DO IF NOT %%x==Steam.exe (goto AUTOLOGIN)ELSE (goto STEAMBEENDENWAIT)
goto AUTOLOGIN

:AUTOLOGIN
echo Setze Registry-Werte...
reg add "HKCU\Software\Valve\Steam" /v AutoLoginUser /t REG_SZ /d %username% /f
reg add "HKCU\Software\Valve\Steam" /v RememberPassword /t REG_DWORD /d 1 /f
echo Starte Steam...
start steam://open/main
goto EOF

:EOF
exit /b 0
