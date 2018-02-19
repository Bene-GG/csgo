@echo off
IF NOT DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min %~dpnx0 %1 && exit
TITLE %~nx0 - Loginskript mit Steam-Benutzernamen %1
SETLOCAL EnableExtensions
IF %1!==! (goto FEHLERPARAM1)ELSE (goto START)
goto START
BESCHREIBUNG:
    Automatischer Login eines Steam-Kontos ohne Passwort oder Authenticator-Eingabe nachdem man einmalig pro Account die Daten
    eingegeben hat.
    Dieses Skript muss mit dem Steam-Benutzernamen als ersten Parameter (Startoption) gestartet werden.
    => z.B. eine Verknüpfung erstellen und unter den Eigenschaften bei "Ziel" folgendes mit einem Leerzeichen getrennt anfügen: "Peterlustig69"
        => Ziel: "C:\Users\Peter\Documents\Steam-Autologin.cmd" "Peterlustig69"

:START
:EINSTELLUNGEN
set FreundesListeBeiStart=1
set CSGOAutomatischStarten=0

:BENUTZERNAMEAUSPARAM
echo Setze Benutzernamen aus Parameter
set username=%1
goto STEAMPFADHOLEN

:STEAMPFADHOLEN
echo Hole Steam-Pfad aus Registry...
set WinRegistrySteam=HKCU\Software\Valve\Steam
set WinRegistrySteamPathVal=SteamPath

FOR /F "tokens=2*" %%A IN ('REG.exe query "%WinRegistrySteam%" /v "%WinRegistrySteamPathVal%"') DO (set SteamOrdner=%%B)

:STEAMPRUEFUNG
echo Pruefe, ob Steam laeuft...
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq Steam.exe"') DO IF %%x==Steam.exe (goto STEAMBEENDEN)ELSE (goto AUTOLOGIN)
goto AUTOLOGIN

:STEAMBEENDEN
echo Beende den Steam-Prozess...
cd /d "%SteamOrdner%"
start /WAIT Steam.exe -shutdown

:STEAMBEENDENWAIT
echo Warte auf Beendigung...
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq Steam.exe"') DO IF NOT %%x==Steam.exe (goto STEAMBEENDENWAIT2)ELSE (goto STEAMBEENDENWAIT)
:STEAMBEENDENWAIT2
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq SteamService.exe"') DO IF NOT %%x==SteamService.exe (goto STEAMBEENDENWAIT3)ELSE (goto STEAMBEENDENWAIT2)
:STEAMBEENDENWAIT3
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq steamwebhelper.exe"') DO IF NOT %%x==steamwebhelper.exe (goto STEAMBEENDENWAIT4)ELSE (goto STEAMBEENDENWAIT3)
:STEAMBEENDENWAIT4
IF EXIST ".crash" GOTO STEAMBEENDENWAIT4
goto AUTOLOGIN

:AUTOLOGIN
echo Setze Registry-Werte...
reg add %WinRegistrySteam% /v AutoLoginUser /t REG_SZ /d %username% /f
reg add %WinRegistrySteam% /v RememberPassword /t REG_DWORD /d 1 /f
echo Starte Steam...
start steam://open/main
echo Pruefe, ob Freundesliste nach dem Start geoeffnet werden soll...
if %FreundesListeBeiStart%==1 (start steam://open/friends)
echo Pruefe, ob Counter-Strike: Global Offensive gestartet werden soll...
if %CSGOAutomatischStarten%==1 (start steam://run/730)

goto EOF

:FEHLERPARAM1
echo FEHLER: Parameter1 (Steam-Benutzername) fehlt.
pause
goto EOF

:EOF
echo Beende Skript...
exit
