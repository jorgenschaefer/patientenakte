---
effort: L
utility: L
---

# AKTE.md vollständig bauen und prüfen

Es gibt keine Möglichkeit, beide Dateien vollständig zu prüfen, inhaltlich
und auf das aktuelle Format. Inhaltlich gibt es für `AKTE.md` nur den Bau
„vollständig zur Kontrolle“ (`skills/akte-aktualisieren/SKILL.md:20`), für
`BEURTEILUNG.md` nichts. Fehler, die vor der Gegenprüfung nach Änderungen
(`agents/gegenpruefung.md`) in die Dateien gekommen sind, findet niemand.

Das Format ändert sich mit dem Plugin, die Akten ziehen aber nicht nach:
`BEURTEILUNG.md` wird einmal bei der Anamnese aus `vorlagen/BEURTEILUNG.md`
kopiert (`skills/anamnese/SKILL.md:15`), und `AKTE.md` wird meist
schrittweise gebaut, sodass ein geänderter Aufbau in `agents/akte.md` nur in
neue Abschnitte gelangt.

Die Prüfung soll ein ausdrücklicher Schritt sein, den der Benutzer anstößt,
nicht beim Start einer Sitzung.

## Vollständiger Bau bei großen Beständen

Ein vollständiger Bau betrifft nicht nur die Prüfung, sondern auch die erste
Verwendung mit einer neuen Akte (`skills/akte-aktualisieren/SKILL.md:19`).
Heute liest ein einziger Subagent alle Unterlagen (`agents/akte.md:22-23`);
bei vielen Befunden reicht sein Kontext dafür nicht. Dasselbe gilt für die
Gegenprüfung danach, die alle Unterlagen vollständig liest
(`skills/akte-aktualisieren/SKILL.md:33-35`).

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
  ist inzwischen klargestellt, `agents/akte.md:37-43`.)
- Einschränkungen wie „ob mitbestimmt, unbekannt“ fielen bei einem Bau weg.
- Quellen standen teils als Kürzel statt als Dateiname, teils fehlten sie
  bei Messwerten.

Was ein Bau übersieht, bleibt beim schrittweisen Bau dauerhaft weg, weil
dort nur neue und geänderte Dateien gelesen werden (`agents/akte.md:17-21`).
Idee aus der Bewertung: je Unterlage einen Auszug committen, aus dem
`AKTE.md` zusammengesetzt wird, damit beide Bauarten auf denselben
Auszügen beruhen.
