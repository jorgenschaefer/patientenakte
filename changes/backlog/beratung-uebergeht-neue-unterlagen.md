---
effort: S
utility: L
---

# Die Beratung übergeht Unterlagen, die noch nicht in AKTE.md stehen

Meldet `akte-stand` beim Start neue oder geänderte Unterlagen, schlagen die
Regeln nur `neue-information` oder `akte-aktualisieren` vor
(`regeln.md:24-28`). Lehnt der Benutzer ab oder fragt er erst etwas anderes,
berät das Modell weiter auf Grundlage von `AKTE.md`, denn `unterlagen/`
liest es nur gezielt, „wenn eine Angabe in `AKTE.md` zweifelhaft ist“
(`regeln.md:67-68`). Ein neuer Befund, der eine Empfehlung ändern würde,
etwa ein neuer Laborwert oder ein abgesetztes Mittel, bleibt dann
unberücksichtigt, ohne dass die Antwort das sagt.

Für nicht durchgesehene Änderungen an `AKTE.md` ist geregelt, auf welcher
Fassung beraten wird (`regeln.md:29-31`); für noch nicht eingearbeitete
Unterlagen fehlt eine solche Regel.
