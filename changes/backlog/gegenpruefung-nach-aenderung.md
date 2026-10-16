---
effort: M
utility: L
---

# Änderungen an AKTE.md und BEURTEILUNG.md werden nicht gegengeprüft

In der Beratung lesen die Modelle nur `AKTE.md` und `BEURTEILUNG.md`
(`regeln.md:38`, `agents/akte.md:9-11`). Ein Fehler in einer der beiden
Dateien wirkt deshalb in jeder späteren Sitzung als Grundlage weiter: ein
falsch übernommener Wert, eine falsche Quelle in eckigen Klammern, eine
Schlussfolgerung, die als Fakt in `AKTE.md` steht, oder eine Empfehlung in
`BEURTEILUNG.md`, die so nicht in der Leitlinie steht.

Nach einem Bau von `AKTE.md` prüft bisher nur das Hauptmodell, und auch das
nur die Messwerte und Dosierungen an der Quelle
(`skills/akte-aktualisieren/SKILL.md`, Schritt 4). Der Benutzer sieht den
Diff vor dem Ok, kann aber nicht jede Angabe an der Quelle nachlesen.
`BEURTEILUNG.md` wird an vielen Stellen ohne zweite Prüfung geändert
(`regeln.md:105`, `skills/neue-information/SKILL.md` Schritte 4 und 6,
`skills/leitlinie/SKILL.md:50`, `skills/vorsorge/SKILL.md:67`,
`skills/naechste-schritte/SKILL.md:37`).

Gedacht ist eine Gegenprüfung nach jeder Änderung durch ein Modell in
frischem Kontext, das das Ergebnis und die Quellen bekommt, aber nicht die
Überlegungen des ersten Modells, und das ausdrücklich Fehler suchen soll,
jeden mit Fundstelle. Den Prüfer kann `akte-vollstaendig-pruefen.md`
mitbenutzen.
