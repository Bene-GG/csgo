@echo off
CLS
TITLE Copy-Files
COLOR 4E
echo "Kopiere"
copy ".\autoexec.cfg" "D:\Programme\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\cfg\autoexec.cfg"
echo "autoexec.cfg kopiert"
copy ".\textmod\csgo_textmod.txt" "D:\Programme\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\resource\csgo_textmod.txt"
echo "csgo_textmod.txt kopiert"
copy ".\font\Calibri\fontlib_custom.swf" "D:\Programme\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\resource\flash\fontlib_custom.swf"
echo "fontlib_custom.swf kopiert"
copy ".\font\Calibri\fontmapping.cfg" "D:\Programme\Steam\steamapps\common\Counter-Strike Global Offensive\csgo\resource\flash\fontmapping.cfg"
echo "fontmapping.cfg kopiert"
echo "Fertig"

