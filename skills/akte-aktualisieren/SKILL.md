---
name: akte-aktualisieren
description: Baut AKTE.md aus den Unterlagen nach, in einem Subagenten, oder prüft eine Berichtigung daran, lässt die Änderung gegenprüfen und berichtigt die Funde, ohne zu committen. Benutzen nur aus dem Skill einarbeiten.
---

# AKTE.md aktualisieren

Die Unterlagen sind committet; dafür sorgt der Skill `einarbeiten`. Der
Aufruf nennt die Art und bei einer Berichtigung ihre Quellen.

1. `akte-stand` ausführen. Meldet es nichts und nennt der Aufruf weder
   einen vollständigen Bau noch eine Berichtigung, endet der Skill. Meldet
   es einen nicht abgeschlossenen Bau, gehören dessen Änderungen an
   `AKTE.md` in Schritt 4 mit dazu. Ohne gemeldete Dateien gleich mit
   Schritt 4 weiter.
2. Nach der Art:
   - **schrittweise** in `AKTE.md`, der Normalfall, und **vollständig** in
     `AKTE.md`, wenn sie fehlt oder der Benutzer es will: den Subagenten
     `patientenakte:akte` starten, im Auftrag die Ausgabe von `akte-stand`
     und die Art des Baus;
   - **vollständig zur Kontrolle** in eine Datei im Scratchpad: ebenso.
     Danach vergleichst du sie mit `AKTE.md`. Jede Abweichung ist ein
     möglicher Fehler einer der beiden Fassungen; prüf sie an der Quelle
     und berichtige `AKTE.md` nach den Regeln des Subagenten `akte`;
   - **Berichtigung:** `AKTE.md` ist schon nach den Regeln des Subagenten
     `akte` berichtigt; kein Subagent.
3. Gleich nach einem Bau in `AKTE.md`: `akte-stand --aktualisieren`. So
   stehen dort die Prüfsummen der Unterlagen, die der Subagent gelesen hat;
   was später in `unterlagen/` dazukommt, meldet `akte-stand` beim nächsten
   Mal.
4. Ist `AKTE.md` gegenüber dem letzten Commit unverändert
   (`git status --short AKTE.md` ist leer) oder nur im Abschnitt
   „Grundlage“ geändert, etwa nach neuen Zeilen in einer Messreihe, geht es
   ohne Gegenprüfung mit Schritt 5 weiter. Sonst mit dem Skill
   `gegenpruefen` gegenprüfen lassen. Quellen der Änderung sind:
   - nach einem schrittweisen Bau die gemeldeten Dateien mit ihrem Status
     und dem Commit aus `akte-stand`;
   - nach einem vollständigen Bau und nach einer Berichtigung aus dem Bau
     „vollständig zur Kontrolle“ alle Unterlagen;
   - nach einer Berichtigung die Quellen aus dem Aufruf;
   - für einen liegen gebliebenen Bau dazu die Unterlagen, deren Prüfsumme
     unter „Grundlage“ in `git diff HEAD -- AKTE.md` neu oder geändert ist;
     zeigt der Diff keine, weil `AKTE.md` noch nie committet war oder der
     Bau vollständig war, alle Unterlagen.

   Bestätigte Funde in `AKTE.md` berichtigst du nach den Regeln des
   Subagenten `akte` (Quelle, Stand), bestätigte Funde in `BEURTEILUNG.md`
   mit dem Skill `beurteilung-aendern`.
5. An `einarbeiten` zurückgeben: ob `AKTE.md` geändert ist und ob
   `BEURTEILUNG.md` berichtigt wurde, die Funde der Gegenprüfung und die
   offenen Widersprüche und Unklarheiten, die der Subagent `akte` meldet.
