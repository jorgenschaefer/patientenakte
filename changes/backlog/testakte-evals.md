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

Dazu die Gegenprüfung (`agents/gegenpruefung.md`), bei ihrer Abnahme nur
durch Lesen geprüft. Offen ist:

- ob sie läuft: nach schrittweisem, vollständigem und liegen gebliebenem
  Bau, und vor jedem Commit an `BEURTEILUNG.md`, der über den Skill
  `beurteilung-aendern` geht (`skills/beurteilung-aendern/SKILL.md:42-49`);
- ob sie eingebaute Fehler findet: einen falschen Wert, eine fehlende
  Angabe, eine Schlussfolgerung als Fakt, einen falschen Empfehlungsgrad,
  einen Widerspruch zu einer Allergie;
- ob der Prüfer `agents/akte.md` und `regeln.md` überhaupt findet: Er
  kennt sie nur über `${CLAUDE_PLUGIN_ROOT}` im Text des Agenten
  (`agents/gegenpruefung.md:35,37`). Laut Doku ersetzt Claude Code die
  Variable dort, laut Berichten anderer bei Subagenten nicht immer;
- was der Benutzer erfährt, wenn sie scheitert (`regeln.md`, „Gescheitert“).
