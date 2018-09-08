@echo off
CLS
TITLE Copy-Files
COLOR 4E
echo "Passe Prozesseigenschaften fuer CSGO (Ryzen 1600X) an."
PowerShell "gps -processname "csgo" | &{ $input.moveNext(); $input.Current.ProcessorAffinity = 4094 }"
PowerShell "gps -processname "csgo" | &{ $input.moveNext(); $input.Current.PriorityClass = 'AboveNormal' }"
PowerShell "Set-MpPreference -DisableRealtimeMonitoring $true"
TASKKILL /F /T /IM NvTelemetryContainer.exe /IM OneDrive.exe /IM acrotray.exe /IM acrobat_sl.exe /IM AdobeUpdateService.exe /IM ctfmon.exe /IM OfficeClickToRun.exe /IM OfficeClickToRun.exe /IM OfficeClickToRun.exe /IM OfficeClickToRun.exe /IM OfficeClickToRun.exe /IM OfficeClickToRun.exe /IM OfficeClickToRun.exe
net stop UsoSvc