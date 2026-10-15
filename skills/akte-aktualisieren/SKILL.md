---
name: akte-aktualisieren
description: Baut AKTE.md aus neuen oder geänderten Dateien in unterlagen/ nach, in einem Subagenten. Benutzen nach jeder Änderung in unterlagen/, wenn bin/akte-stand Änderungen meldet, oder wenn der Benutzer AKTE.md neu aufbauen oder prüfen lassen will.
---

# AKTE.md aktualisieren

1. Die Unterlagen müssen committet sein. Dann `bin/akte-stand` ausführen.
   Meldet es nichts und ist kein vollständiger Neubau gewünscht, ist
   `AKTE.md` aktuell.
2. Den Subagenten `akte` starten. Im Auftrag stehen die Ausgabe von
   `bin/akte-stand` und die Art des Baus:
   - **schrittweise** in `AKTE.md`: der Normalfall;
   - **vollständig** in `AKTE.md`: wenn sie fehlt oder der Benutzer es will;
   - **vollständig zur Kontrolle** in eine Datei im Scratchpad: Danach
     vergleichst du sie mit `AKTE.md`. Jede Abweichung ist ein möglicher
     Fehler einer der beiden Fassungen; prüf sie an der Quelle.
3. Dem Benutzer die Änderungen zeigen: `git diff AKTE.md`, inhaltlich
   zusammengefasst, dazu die Widersprüche und Unklarheiten, die der Subagent
   meldet.
4. Ist etwas falsch übertragen, korrigierst du es in `AKTE.md`. Ist eine
   Unterlage falsch, kommt die Korrektur über den Skill `neue-information` in
   `historie.md`.
5. Nach dem Ok des Benutzers: `bin/akte-stand --aktualisieren`, dann `AKTE.md`
   committen.
