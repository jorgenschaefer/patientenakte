---
effort: L
utility: L
---

# AKTE.md gegen die Befunde prüfen und vollständig bauen

Es gibt keine Möglichkeit, `AKTE.md` und `BEURTEILUNG.md` inhaltlich gegen
die Befunde zu prüfen. Für `AKTE.md` gibt es nur den Bau „vollständig zur
Kontrolle“ (`agents/akte-nachziehen.md:25-26`,
`agents/akte-nachziehen.md:46-49`), für `BEURTEILUNG.md` nichts. Fehler,
die vor der Gegenprüfung nach Änderungen (`agents/gegenpruefung.md`) in
die Dateien gekommen sind, findet niemand.

Was ohne die Befunde geht, das Format nachziehen und `AKTE.md` und
`BEURTEILUNG.md` gegeneinander prüfen, leistet die Prüfung im Subagenten
`akte-nachziehen` (`agents/akte-nachziehen.md:113`).
Hier geht es um die Befunde selbst; in einer echten Akte liegen 12 MB in
`unterlagen/`.

Die Prüfung soll ein ausdrücklicher Schritt sein, den der Benutzer anstößt,
nicht beim Start einer Sitzung.

## Vollständiger Bau bei großen Beständen

Ein vollständiger Bau betrifft nicht nur die Prüfung, sondern auch die erste
Verwendung mit einer neuen Akte und jede Akte, deren `AKTE.md` von der
Vorlage abweicht: Das erste `/einarbeiten` dort baut sie vollständig neu
(`agents/akte-nachziehen.md:20-21`, `agents/akte-nachziehen.md:42-45`). Nach
jeder Änderung an `vorlagen/AKTE.md` trifft das alle bestehenden Akten.
Heute liest ein einziger Subagent alle Unterlagen (`agents/akte.md:21-23`);
bei vielen Befunden reicht sein Kontext dafür nicht. Dasselbe gilt für die
Gegenprüfung danach, die alle Unterlagen vollständig liest
(`agents/akte-nachziehen.md:59-60`).

Seit der Subagent `akte-nachziehen` selbst Subagenten startet, ist der Weg
unten möglich: Er kann mehrere Subagenten für die Auszüge und einen für
das Zusammenführen starten, ohne dass das Gespräch etwas davon sieht.
Subagenten dürfen bis zu drei Ebenen unter dem Gespräch liegen; die
Auszüge lägen auf Ebene 2 wie heute `akte`.

Idee: mehrere Subagenten, je einer für einen oder mehrere Befunde, die die
Angaben daraus herausziehen; ein weiterer führt sie zusammen. Nicht je
Abschnitt von `AKTE.md`, weil dann jeder Subagent alle Befunde lesen müsste.
Dazu aus der Besprechung:

- Zusammenführen nicht im Hauptagenten, dessen Kontext die Beratung ist,
  sondern in einem eigenen Subagenten, der nur die Auszüge bekommt.
- Die Auszüge im Format von `AKTE.md`, je Angabe mit Abschnitt, Quelle und
  Datum, damit das Zusammenführen Überholtes, Widersprüche und die
  Reihenfolge der Messwerte entscheiden kann.
- `anamnese.md` und `historie.md` als eigene Stapel; sie ziehen sich durch
  alle Themen, und Korrekturen in `historie.md` beziehen sich auf frühere
  Angaben.
- Erst ab einer gewissen Größe aufteilen.
- Die Gegenprüfung nach einem vollständigen Bau ebenso aufteilen.

## Schrittweiser und vollständiger Bau unterscheiden sich

In einer echten Akte ergab ein vollständiger Neubau über dieselben
Unterlagen eine merklich andere `AKTE.md` als die bis dahin schrittweise
gewachsene:

- Ergänzt wurden Angaben, die tagelang gefehlt hatten: Ergebnisse von
  Vorsorgeuntersuchungen, ein Urinbefund, der Hinweis eines Arztes, ein
  Mittel im Verlauf abzusetzen, und zwei Widersprüche zwischen Befunden,
  die vorher niemand gemeldet hatte.
- Gestrichen wurde der Hinweis, dass ein Befund eine sicherheitsrelevante
  Voruntersuchung vor einem Therapiebeginn nicht enthält. (Die Regel dazu
  ist inzwischen klargestellt, `agents/akte.md:38-44`.)
- Einschränkungen wie „ob mitbestimmt, unbekannt“ fielen bei einem Bau weg.
- Quellen standen teils als Kürzel statt als Dateiname, teils fehlten sie
  bei Messwerten.

Was ein Bau übersieht, bleibt beim schrittweisen Bau dauerhaft weg, weil
dort nur neue und geänderte Dateien gelesen werden (`agents/akte.md:16-20`).
Idee aus der Bewertung: je Unterlage einen Auszug committen, aus dem
`AKTE.md` zusammengesetzt wird, damit beide Bauarten auf denselben
Auszügen beruhen.
