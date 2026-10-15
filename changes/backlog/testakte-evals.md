---
effort: L
utility: M
---

# Keine Testakte, keine Evals, keine Tests für `akte-stand`

Ob eine Änderung an `regeln.md`, an einem Skill oder am Agenten die Arbeit
verbessert oder verschlechtert, lässt sich nicht prüfen: Es gibt keine
Beispielakte, keine Evals und keine Tests für `bin/akte-stand`. Eine echte
Akte zum Ausprobieren kommt nicht in Frage, weil das Plugin-Repo öffentlich
ist.

Idee aus der Überprüfung: eine Beispielakte mit einem erfundenen Patienten im
Repo, Evals mit `claude plugin eval` für die Kernabläufe (neuer Befund,
Warnzeichen, Termin) und Tests für `akte-stand`.
