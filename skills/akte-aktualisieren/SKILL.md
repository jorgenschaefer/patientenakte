---
name: akte-aktualisieren
description: Baut AKTE.md aus neuen oder geänderten Dateien in unterlagen/ nach, in einem Subagenten. Benutzen nach jeder Änderung in unterlagen/, wenn akte-stand Änderungen meldet, oder wenn der Benutzer AKTE.md neu aufbauen oder prüfen lassen will.
---

# AKTE.md aktualisieren

1. Die Unterlagen müssen committet sein. Dann `akte-stand` ausführen.
   Meldet es nichts und ist kein vollständiger Neubau gewünscht, ist
   `AKTE.md` aktuell. Meldet es nicht durchgesehene Änderungen an `AKTE.md`,
   stammen sie aus einem Bau, der nicht bis Schritt 5 kam: Sie gehören in
   Schritt 4 mit dazu. Ohne gemeldete Dateien gleich mit Schritt 4 weiter.
2. Den Subagenten `patientenakte:akte` starten. Im Auftrag stehen die
   Ausgabe von `akte-stand` und die Art des Baus:
   - **schrittweise** in `AKTE.md`: der Normalfall;
   - **vollständig** in `AKTE.md`: wenn sie fehlt oder der Benutzer es will;
   - **vollständig zur Kontrolle** in eine Datei im Scratchpad: Danach
     vergleichst du sie mit `AKTE.md`. Jede Abweichung ist ein möglicher
     Fehler einer der beiden Fassungen; prüf sie an der Quelle.
3. Gleich nach einem Bau in `AKTE.md`: `akte-stand --aktualisieren`. So
   stehen dort die Prüfsummen der Unterlagen, die der Subagent gelesen hat;
   was später in `unterlagen/` dazukommt, meldet `akte-stand` beim nächsten
   Mal.
4. Dem Benutzer die Änderungen zeigen: `git diff AKTE.md`, inhaltlich
   zusammengefasst, dazu die Widersprüche und Unklarheiten, die der Subagent
   meldet. Sag ihm, was sein Ok bestätigt: dass `AKTE.md` die Unterlagen
   richtig wiedergibt. Ist eine Unterlage selbst falsch, spricht das nicht
   gegen das Ok; die Korrektur folgt in Schritt 6. Hat der Subagent etwas
   falsch übernommen, berichtigst du `AKTE.md` nach den Regeln des Subagenten
   (Quelle, Stand) und zeigst die Berichtigung vor dem Ok.
5. Nach dem Ok `AKTE.md` committen. Ohne Ok die Änderungen mit
   `git restore AKTE.md` verwerfen; war `AKTE.md` neu, sie löschen.
6. Ist eine Unterlage selbst falsch oder nennt der Benutzer beim Durchsehen
   Neues, kommt das erst jetzt über den Skill `neue-information` in
   `unterlagen/`; der zieht `AKTE.md` erneut nach.
