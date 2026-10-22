---
effort: S
utility: S
---

# Angaben einer entfernten Unterlage fallen beim Neubau ohne Hinweis weg

Nach einem vollständigen Bau gleicht je Stapel ein Prüfer die neue
`AKTE.md` mit `HEAD:AKTE.md` ab, aber nur für Angaben, deren Quelle auf
eine Einheit seines Stapels zeigt (`agents/akte-nachziehen.md`,
„Vollständiger Bau“ Schritt 4; `agents/aenderung-gegenpruefen.md`,
„Abgleich mit der vorigen Fassung“). Eine Angabe, deren Unterlage
inzwischen entfernt ist, gehört zu keinem Stapel und wird von keinem
Abgleich gesehen. Dass sie wegfällt, ist richtig; die Rückmeldung sagt
es aber nicht.

Aufgefallen bei der Abnahme des Baus in Stapeln (Review, Ticket 02).
