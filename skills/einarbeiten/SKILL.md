---
name: einarbeiten
description: Arbeitet alles Ausstehende in die Akte ein – Entwürfe in unterlagen/ ohne Commit, neue oder geänderte Unterlagen, Änderungen an BEURTEILUNG.md und literatur/ ohne Commit, einen nicht abgeschlossenen Bau von AKTE.md –, mit gesammelter Bestätigung, Gegenprüfung und Commits. Benutzen zu Beginn einer Sitzung, wenn etwas aussteht, auf /einarbeiten und wenn der Benutzer das Angebot am Ende des Gesprächs annimmt.
---

# Einarbeiten

Kommen ab Schritt 4 neue Entwürfe oder Einträge in `BEURTEILUNG.md` dazu,
auch aus den Skills, die die Schritte 7 und 8 ausführen, geht es mit ihnen
ab Schritt 3 weiter. Die Schritte 7 und 8 laufen am Ende einmal für alles.

1. **Sammeln:** `git status --short` und `akte-stand`. Am Ende eines
   Gesprächs dazu das Gespräch selbst: Was nach der Regel in `regeln.md` in
   die Unterlagen gehört und noch nicht als Entwurf dasteht, nimmst du mit
   dem Skill `neue-information` auf. Steht nichts aus, sagst du das in einem
   Satz, und der Skill endet.
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
   betreffen, mit dem Skill `beurteilung-aendern`, Teil „Eintragen“. Ein
   Ergebnis, das noch nicht in `unterlagen/` steht, kommt wie in Schritt 3
   des Skills `neue-information` nach `historie.md` und wird bestätigt wie
   in Schritt 3 hier. Neue Fragen belegst du mit dem Skill `leitlinie`.
5. **Committen:** mit dem Skill `beurteilung-aendern`, Teil „Abschließen“,
   die neuen Unterlagen im selben Commit.
6. **AKTE.md** mit dem Skill `akte-aktualisieren` nachziehen.
7. **Antworten:** kurz, was sich dadurch an der Einschätzung und an den
   nächsten Schritten ändert. Verschiebt sich die Reihenfolge deutlich, den
   Skill `naechste-schritte` ausführen.
8. **Notfallpass:** Betrifft eine Angabe Diagnosen, Medikation, Allergien,
   Implantate oder eine Schwangerschaft, auch beim Absetzen oder Ausheilen,
   den Skill `notfallpass` ausführen und den Benutzer bitten, den Text im
   Handy zu ersetzen.
