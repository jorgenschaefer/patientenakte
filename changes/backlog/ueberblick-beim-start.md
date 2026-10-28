---
effort: M
utility: L
---

# Die Beratung sieht die Akte nur in Bruchstücken

`regeln.md:59-60` verlangt, vor jeder Beratung `AKTE.md` und
`BEURTEILUNG.md` zu lesen. In einer echten Akte waren das nach gut zwei
Wochen etwa 8.000 und 21.000 Wörter, zusammen gut 200 KB. Das geht nicht
mehr in den Kontext:

- `cat AKTE.md BEURTEILUNG.md` landete als zu große Ausgabe in einer Datei;
  das Modell las davon einen Ausschnitt von gut 35 KB.
- Andere Sitzungen lasen die Dateien nie ganz, sondern suchten mit
  `grep -i -E "<stichwort>|<stichwort>|…"` und lasen einzelne Zeilen mit
  `sed -n`.

Die Prüfungen unter „Evidenz“ (Allergien, aktuelle Medikation, Diagnosen,
Nierenfunktion, Schwangerschaft) und die Regeln zu „Warnzeichen“ und
„Abgelehnt“ greifen nur, wenn das Modell diese Angaben gesehen hat. Mit
`grep` sieht es sie nur, wenn ein Suchwort zufällig passt. Das erklärt
wohl auch einen Teil von `warnzeichen-pro-antwort-neu.md`.

Idee aus der Überprüfung: oben in `AKTE.md` ein Abschnitt „Überblick“ mit
fester Höchstlänge (etwa 600 Wörter): aktive Probleme, aktuelle Medikation,
Allergien, Immunstatus und Risiken, Gegenanzeigen. Der Hook
`hooks/regeln-einspielen` gibt ihn beim Start jeder Sitzung aus, dazu
„Warnzeichen“ und die Fristen unter „Offen“ aus `BEURTEILUNG.md`. Die Regel
in `regeln.md:59-60` hieße dann: Der Überblick ist da; zum Thema der Frage
liest du die passenden Abschnitte ganz. `akte-nachziehen` zieht den
Überblick nach, die Gegenprüfung prüft ihn wie jede andere Änderung.
