---
effort: L
utility: L
---

# Übertragene Werte und Zitate aus Leitlinien werden nicht verlässlich geprüft

Ein Zahlendreher in `AKTE.md` wirkt in jeder späteren Beratung weiter, weil
die Beratung `unterlagen/` nur gezielt liest (`regeln.md:59-61`). Der
Kontrollbau in `skills/akte-aktualisieren/SKILL.md:15-17` ist optional, und
den Vergleich macht wieder das Modell.

Bei Leitlinien lässt `skills/leitlinie/SKILL.md:31-33` Empfehlungsnummer,
Empfehlungsgrad, Evidenzniveau und Konsensstärke „festhalten“, sagt aber
nicht, wo. In `BEURTEILUNG.md` stehen nur Metadaten der Quelle
(`vorlagen/BEURTEILUNG.md:9`). Ob ein Eintrag „Leitlinie“ wirklich so in der
Leitlinie steht, lässt sich später nicht nachprüfen.

Idee aus der Überprüfung: ein Script, das die Zahlen jeder neuen oder
geänderten Zeile in `AKTE.md` in der Textfassung der zitierten Quelle sucht
und Angaben ohne Beleg meldet; Empfehlungen aus Leitlinien wörtlich mit
Seitenzahl in `BEURTEILUNG.md`.
