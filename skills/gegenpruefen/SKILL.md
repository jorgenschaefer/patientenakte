---
name: gegenpruefen
description: Lässt eine Änderung an AKTE.md oder BEURTEILUNG.md vor dem Commit vom Subagenten patientenakte:gegenpruefung in frischem Kontext gegen ihre Quellen prüfen und arbeitet die Funde ab. Benutzen nur aus den Skills akte-aktualisieren und beurteilung-aendern heraus.
---

# Gegenprüfen

Der Subagent `patientenakte:gegenpruefung` prüft die Änderung in frischem
Kontext.

- **Auftrag:** die geprüfte Datei und die Quellen der Änderung als Pfade,
  bei `AKTE.md` mit den Angaben aus Schritt 4 von `akte-aktualisieren`.
  Den Diff liest der Subagent selbst mit `git diff HEAD -- <datei>`. Bei
  `BEURTEILUNG.md` sind die Quellen die neuen oder geänderten Unterlagen,
  die mit ihr in denselben Commit kommen; sind es keine, steht das im
  Auftrag. Bei einer Kürzung im Skill `akte-pruefen` kommt
  `HEAD:BEURTEILUNG.md` dazu. Sonst nichts: keine Begründung und keine
  Überlegung zur Änderung, keine Zusammenfassung, keine weiteren Unterlagen
  oder Literatur.
- **Funde:** Jeden Fund liest du an der genannten Fundstelle nach und
  berichtigst die bestätigten. Dem Benutzer nennst du alle Funde: die
  berichtigten mit der Berichtigung, die verworfenen mit Grund, die nicht
  prüfbaren als ungeprüft mit Grund. Bei `AKTE.md` mit den Änderungen nach
  dem Commit, bei `BEURTEILUNG.md` vor dem Commit. Danach läuft die
  Gegenprüfung für diese Änderung nicht noch einmal.
- **Keine Funde:** Antwortet der Subagent „Keine Funde.“, sagst du das dem
  Benutzer in einem Satz.
- **Gescheitert:** Bricht der Subagent ab oder gibt er weder Funde noch
  „Keine Funde.“ zurück, sagst du dem Benutzer, dass die Gegenprüfung nicht
  gelaufen ist, nicht „nichts gefunden“. Dann geht es mit dem Commit
  weiter.
