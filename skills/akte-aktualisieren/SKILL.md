---
name: akte-aktualisieren
description: Baut AKTE.md aus neuen oder geänderten Dateien in unterlagen/ nach, in einem Subagenten. Benutzen, wenn der Skill neue-information die gesammelten Angaben einarbeitet, wenn akte-stand Änderungen meldet, oder wenn der Benutzer AKTE.md neu aufbauen oder prüfen lassen will.
---

# AKTE.md aktualisieren

1. Die Unterlagen müssen committet sein. Sind sie es nicht
   (`git status unterlagen/`), sie zuerst mit dem Skill `neue-information`
   einarbeiten; der führt diesen Skill danach selbst aus. Sonst
   `akte-stand` ausführen.
   Meldet es nichts und ist kein vollständiger Neubau gewünscht, ist
   `AKTE.md` aktuell. Meldet es einen nicht abgeschlossenen Bau, gehören
   dessen Änderungen an `AKTE.md` in Schritt 4 mit dazu. Ohne gemeldete Dateien gleich mit Schritt 4 weiter.
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
4. Ist `AKTE.md` gegenüber dem letzten Commit unverändert
   (`git status --short AKTE.md` ist leer), endet der Skill hier. Sonst
   zuerst den Subagenten `patientenakte:gegenpruefung` starten, wie unter
   „Gegenprüfung“ in `regeln.md` beschrieben. Quellen der Änderung sind:
   - nach einem schrittweisen Bau die gemeldeten Dateien mit ihrem Status
     und dem Commit aus `akte-stand`;
   - nach einem vollständigen Bau alle Unterlagen;
   - nach einer Berichtigung aus dem Bau „vollständig zur Kontrolle“ alle
     Unterlagen;
   - für einen liegen gebliebenen Bau dazu die Unterlagen, deren Prüfsumme
     unter „Grundlage“ in `git diff HEAD -- AKTE.md` neu oder geändert ist;
     zeigt der Diff keine, weil `AKTE.md` noch nie committet war oder der
     Bau vollständig war, alle Unterlagen.

   Bestätigte Funde in `AKTE.md` berichtigst du nach den Regeln des
   Subagenten `akte` (Quelle, Stand). Bestätigte Funde in `BEURTEILUNG.md`
   berichtigst du mit dem Skill `beurteilung-aendern`, Abschnitt
   „Berichtigung nach der Gegenprüfung von AKTE.md“.
5. `AKTE.md` committen.
6. Dem Benutzer die Änderungen nennen: den Diff des Commits, inhaltlich
   zusammengefasst, und die Funde der Gegenprüfung. Die offenen
   Widersprüche und Unklarheiten, die der Subagent `akte` meldet, stellst du
   ihm als Fragen; die geklärten nennst du nur kurz mit ihrer Quelle.
7. Erkennt der Benutzer etwas als falsch übernommen, berichtigst du es nach
   den Regeln des Subagenten `akte` und gehst ab Schritt 4 weiter, mit der
   Unterlage, aus der es stammt, als Quelle. Ist eine Unterlage selbst
   falsch oder nennt der Benutzer Neues, kommt das über den Skill
   `neue-information` in `unterlagen/`; der zieht `AKTE.md` erneut nach.
