---
effort: M
utility: L
---

# Der SessionStart-Hook liefert den Stand der Akte nicht selbst

`regeln.md:17-29` weist das Modell an, vor der ersten Antwort zu prüfen, ob
`unterlagen/anamnese.md` fehlt, und `akte-stand` auszuführen. Ob das
geschieht, hängt am Modell. `hooks/regeln-einspielen` spielt nur die Regeln
ein.

Außerdem fällt nichts davon auf:
- `termin-*.md` mit vergangenem Datum, deren Nachbereitung
  (`skills/termin-vorbereiten/SKILL.md:27-32`) vergessen wurde;
- Leitlinien mit abgelaufenem „gültig bis“ oder einer Prüfung, die älter als
  drei Monate ist (`skills/leitlinie/SKILL.md:15-20`).

Idee aus der Überprüfung: Der Hook prüft das im Projektverzeichnis selbst und
spielt das Ergebnis mit den Regeln ein.
