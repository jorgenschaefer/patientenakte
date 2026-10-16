---
effort: M
utility: L
---

# Nicht gelesene Unterlagen gelten als eingearbeitet

`akte-stand --aktualisieren` schreibt die Prüfsummen aller Dateien in
`unterlagen/` nach `AKTE.md` (`bin/akte-stand:23-26`, `:60`), unabhängig
davon, ob der Subagent `akte` sie lesen konnte. Der Skill nimmt an, es seien
die Prüfsummen der Unterlagen, „die der Subagent gelesen hat“
(`skills/akte-aktualisieren/SKILL.md:24`). Danach meldet `akte-stand` die
Datei nie wieder, und niemand merkt, dass ihr Inhalt in `AKTE.md` fehlt.

Betroffen sind Dateien, die der Subagent nicht oder nur teilweise liest:

- Formate außerhalb von PDF, JPG und PNG, etwa HEIC, DOCX oder XML, die
  der Benutzer selbst nach `unterlagen/` legt; `neue-information` lässt nur
  PDF, JPG und PNG zu (`skills/neue-information/SKILL.md:37-38`), aber nur
  für Dateien, die über den Skill kommen;
- lange PDFs, von denen nur die ersten Seiten gelesen werden;
- Scans ohne Textebene, deren Werte nur als Bild vorliegen.

In den echten Beratungen waren die meisten Befunde Scans ohne Textebene; ein
Fall, in dem eine Datei unbemerkt ungelesen blieb, ist dort nicht belegt.
