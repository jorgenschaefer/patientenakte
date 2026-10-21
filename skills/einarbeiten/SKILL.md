---
name: einarbeiten
description: Arbeitet alles Ausstehende in die Akte ein und macht alle Commits an unterlagen/, BEURTEILUNG.md, literatur/ und AKTE.md – Entwürfe in unterlagen/ ohne Commit, neue oder geänderte Unterlagen, Änderungen an BEURTEILUNG.md und literatur/ ohne Commit, einen nicht abgeschlossenen Bau von AKTE.md –, mit gesammelter Bestätigung und Gegenprüfung. Benutzen zu Beginn einer Sitzung, wenn etwas aussteht, auf /einarbeiten, wenn der Benutzer das Angebot am Ende des Gesprächs annimmt, und wenn er AKTE.md neu aufbauen oder gegen die Unterlagen prüfen lassen will.
---

# Einarbeiten

Der Aufruf kann einen Bau von `AKTE.md` nennen, vollständig oder
vollständig zur Kontrolle, und für Änderungen, die nicht aus Unterlagen
stammen, die Quellen der Gegenprüfung, etwa `HEAD:AKTE.md` nach einer
Berichtigung der Form im Skill `akte-pruefen`.

Kommen ab Schritt 4 neue Entwürfe oder Einträge in `BEURTEILUNG.md` dazu,
auch aus den Skills, die die Schritte 8 und 9 ausführen, geht es mit ihnen
ab Schritt 3 weiter. Die Schritte 8 und 9 laufen am Ende einmal für alles.

1. **Sammeln:** `git status --short` und `akte-stand`. Am Ende eines
   Gesprächs dazu das Gespräch selbst: Was nach der Regel in `regeln.md` in
   die Unterlagen gehört und noch nicht als Entwurf dasteht, nimmst du mit
   dem Skill `neue-information` auf. Steht nichts aus und nennt der Aufruf
   keinen Bau, sagst du das in einem Satz, und der Skill endet.
2. **Unbesprochene Dateien:** Eine neue Datei in `unterlagen/`, die weder
   committet ist noch in diesem Gespräch abgelegt wurde, etwa ein PDF mit
   einem Namen außerhalb des Schemas, nimmst du mit dem Skill
   `neue-information` auf. Gehört sie danach nicht hinein, fragst du, ob du
   sie aus `unterlagen/` entfernen sollst; will der Benutzer sie behalten,
   kommt sie mit in den Commit.
3. **Bestätigen lassen:** alle Entwürfe auf einmal zeigen, die Einträge in
   `historie.md` und die Zeilen in CSV-Dateien so, wie sie im Diff zu
   `HEAD` stehen, die abgelegten Befunde mit Dateinamen. Was nach der Regel
   in `regeln.md` nicht hineingehört, schlägst du zum Streichen vor.
   Änderungen des Benutzers am Wortlaut übernimmst du in den Entwurf;
   gestrichene Einträge entfernst du.
4. **`BEURTEILUNG.md` nachziehen:** die Einträge, die die neuen Angaben
   betreffen, mit dem Skill `beurteilung-aendern`. Ein Ergebnis, das noch
   nicht in `unterlagen/` steht, kommt wie in Schritt 3 des Skills
   `neue-information` nach `historie.md` und wird bestätigt wie in
   Schritt 3 hier. Neue Fragen belegst du mit dem Skill `leitlinie`.
5. **Unterlagen und Beurteilung committen:** Ist `BEURTEILUNG.md` geändert,
   außer beim Anlegen aus der Vorlage, die Änderung mit dem Skill
   `gegenpruefen` gegenprüfen lassen; Quellen sind die neuen Unterlagen
   dieses Commits oder die aus dem Aufruf. Dann `BEURTEILUNG.md`,
   `literatur/` und die neuen Unterlagen in einem Commit. Ist keine davon
   geändert, entfällt der Commit.
6. **`AKTE.md` nachziehen** mit dem Skill `akte-aktualisieren`, mit dem Bau
   und den Quellen aus dem Aufruf. Ist `AKTE.md` danach geändert, sie
   allein committen. Hat die Gegenprüfung `BEURTEILUNG.md` berichtigt, die
   Berichtigung danach allein committen, ohne weitere Gegenprüfung.
7. **Änderungen nennen:** den Diff des Commits von `AKTE.md`, inhaltlich
   zusammengefasst, und die Funde der Gegenprüfung. Die offenen
   Widersprüche und Unklarheiten, die der Subagent `akte` meldet, stellst
   du als Fragen, außer solchen, deren Antwort nach der Regel in
   `regeln.md` nicht in die Unterlagen käme; die geklärten nennst du nur
   kurz mit ihrer Quelle. Erkennt der Benutzer etwas als falsch
   übernommen, berichtigst du `AKTE.md` nach den Regeln des Subagenten
   `akte` und gehst ab Schritt 6 weiter, als Berichtigung mit der
   Unterlage, aus der es stammt, als Quelle. Ist eine Unterlage selbst
   falsch oder nennt er Neues, nimmst du es mit dem Skill
   `neue-information` auf und gehst ab Schritt 3 weiter.
8. **Antworten:** kurz, was sich dadurch an der Einschätzung und an den
   nächsten Schritten ändert. Verschiebt sich die Reihenfolge deutlich, den
   Skill `naechste-schritte` ausführen.
9. **Notfallpass:** Betrifft eine Angabe Diagnosen, Medikation, Allergien,
   Implantate oder eine Schwangerschaft, auch beim Absetzen oder Ausheilen,
   oder wurde `AKTE.md` neu angelegt, den Skill `notfallpass` ausführen und
   den Benutzer bitten, den Text im Handy zu ersetzen.
