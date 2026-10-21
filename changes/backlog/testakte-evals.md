---
effort: L
utility: L
---

# Keine Testakte und keine Evals

Ob eine Änderung an `regeln.md`, an einem Skill oder am Agenten die Arbeit
verbessert oder verschlechtert, lässt sich nicht prüfen: Es gibt keine
Beispielakte und keine Evals. Eine echte Akte zum Ausprobieren kommt nicht in
Frage, weil das Plugin-Repo öffentlich ist.

Idee aus der Überprüfung: eine Beispielakte mit einem erfundenen Patienten im
Repo, Evals mit `claude plugin eval` für die Kernabläufe (neuer Befund,
Warnzeichen, Termin).

Dazu die Gegenprüfung (`agents/aenderung-gegenpruefen.md`), bei ihrer
Abnahme nur durch Lesen geprüft. Offen ist:

- ob sie läuft: nach schrittweisem, vollständigem und liegen gebliebenem
  Bau, und vor jedem Commit an `BEURTEILUNG.md` (`agents/akte-nachziehen.md`,
  Schritt 5);
- ob sie eingebaute Fehler findet: einen falschen Wert, eine fehlende
  Angabe, eine Schlussfolgerung als Fakt, einen falschen Empfehlungsgrad,
  einen Widerspruch zu einer Allergie;
- was der Benutzer erfährt, wenn sie scheitert
  (`agents/akte-nachziehen.md:109`, „Gescheitert“).

Geklärt am 21.10.2026 mit Claude Code 2.1.306 und einem Test-Agenten, aus
dem Gespräch und eine Ebene tiefer aus einem anderen Subagenten gestartet:
`${CLAUDE_PLUGIN_ROOT}` im Text eines Subagenten wird auf beiden Ebenen
ersetzt, und `akte-stand` liegt im `PATH`. Die Umgebungsvariable
`$CLAUDE_PLUGIN_ROOT` ist in Bash dagegen leer; in Befehlen darf sie also
nicht stehen.
