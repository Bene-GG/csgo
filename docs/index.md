---
title: Home
layout: default
---
# Bene's CSGO Config

## Inhalt

[Installationsorte](./#installationsorte)
[Autoexec](./#autoexec)
[Textmod](./#textmod)
[Schriftart](https://github.com/Bene-GG/bene-cfg#schriftart)
[Steam-Autologin](https://github.com/Bene-GG/bene-cfg#steam-autologin)

## Installationsorte

### Autoexec

* autoexec.cfg in diesen Ordner:
  `*:\*\steamapps\common\Counter-Strike Global Offensive\csgo\cfg\`

(* = kann abweichen)

### Textmod

* csgo_textmod.txt in diesen Ordner:
  `*:\*\steamapps\common\Counter-Strike Global Offensive\csgo\resource\`

(* = kann abweichen)

* "-language textmod" ohne die Anführungszeichen zu den CSGO-Startoptionen hinzufügen.

### Schriftart

* fontlib_custom.swf und fontmapping.cfg in diesen Ordner und ggf. überschreiben:

  `*:\*\steamapps\common\Counter-Strike Global Offensive\csgo\resource\flash`

### Radar

* Inhalt von \radar\files in diesen Ordner und überschreiben:

  `*:\*\steamapps\common\Counter-Strike Global Offensive\csgo\resource\overviews`

### Steam-Autologin

1. Datei "`Steam-Autologin.cmd`" an einem gewünschten Ort abspeichern
2. Verknüpfung zur Datei erstellen (Rechtsklick -> Verknüpfung erstellen)
3. Eigenschaften der Verknüpfung öffnen (Rechtsklick -> Eigenschaften)
4. "Ziel" anpassen: Am Ende des Eintrags "`<Accountname>`" "`<Steampfad>`" hinzufügen
 z.B.: `C:\Name_Autologin.cmd "PeterLustig224" "D:\Programme\Steam"`
5. "`Steam-Autologin.cmd`" ausführen, im erscheinenden Steam-Fenster Login-Daten normal eingeben und den Haken unten setzen

Von nun an kann man per Doppelklick mit der jeweiligen Verknüpfung direkt zum gewünschten Steam-Account verbinden.
