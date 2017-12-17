@echo off
CLS
TITLE Copy-Files
COLOR 4E
echo "Beginn: Kopiere"
REM Autoexec
copy /Y ".\autoexec.cfg" "D:\Programme\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\cfg\autoexec.cfg"
echo "autoexec.cfg kopiert"
REM ---------------------
REM Textmod-Dateien
copy /Y ".\textmod\csgo_textmod.txt" "D:\Programme\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\resource\csgo_textmod.txt"
echo "csgo_textmod.txt kopiert"
REM ---------------------
REM Font-Dateien
copy /Y ".\font\Calibri\fontlib_custom.swf" "D:\Programme\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\resource\flash\fontlib_custom.swf"
echo "fontlib_custom.swf kopiert"
copy /Y ".\font\Calibri\fontmapping.cfg" "D:\Programme\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\resource\flash\fontmapping.cfg"
echo "fontmapping.cfg kopiert"
REM ---------------------
REM Radar-Dateien
copy /Y ".\radar\files\*.dds" "D:\Programme\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\resource\overviews"
echo "Radar-Dateien kopiert"
REM ---------------------
echo "Ende: Fertig"

