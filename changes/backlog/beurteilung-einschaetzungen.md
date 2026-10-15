---
effort: S
utility: M
---

# `BEURTEILUNG.md` hat keinen Ort für dauerhafte Einschätzungen

Die Vorlage (`vorlagen/BEURTEILUNG.md:7-27`) kennt Quellen, Warnzeichen,
Beobachten, Vorsorge, Offen und Abgelehnt. Wo eine Einschätzung hingehört,
die in jeder Beratung gilt, ohne dass etwas zu erledigen ist, sagt sie
nicht. Solche Einträge sind in einer echten Akte zahlreich:

- was zu meiden oder zu beachten ist: ein Schmerzmittel wegen einer
  Grunderkrankung, das Infektrisiko unter einer Immunsuppression beim
  Training;
- wie Befunde bei diesem Patienten zu deuten sind: ein Entzündungsmarker,
  der bei ihm nicht anschlägt, ein Wert, der nur im Verlauf zählt;
- vermutete Ursachen einer Beschwerde;
- was im Blick bleibt, ohne dass etwas ansteht: Warnzeichen aus einer
  Leitlinie, die zu einer bestehenden Diagnose passen.

Beim Umstellen einer Akte auf das neue Format (15.10.2026) landeten sie
deshalb in einem eigenen, nicht vorgesehenen Abschnitt „Einschätzungen für
Training und Physiotherapie“, unter „Vorsorge“ (Deutung von Laborwerten)
oder unter „Offen“, wo sie nie erledigt werden.

Überlegung aus dem Gespräch: ein allgemeiner Abschnitt „Einschätzungen“
direkt nach „Warnzeichen“, weil er wie diese in jeder Beratung zählt, etwa:

```
## Einschätzungen

*Was in jeder Beratung gilt, ohne dass etwas zu erledigen ist: was zu meiden oder zu beachten ist, wie Befunde bei diesem Patienten zu deuten sind, vermutete Ursachen. Je mit Datum, Thema und Kennzeichnung, etwa „NSAR meiden – wegen Magengeschwür – Leitlinie: …“. Ändert eine neue Angabe die Grundlage, wird der Eintrag geprüft; überholte werden gelöscht.*
```

Damit der Abschnitt gepflegt wird, müsste Schritt 6 in
`skills/neue-information/SKILL.md:52-58` ihn so ausdrücklich nennen wie
heute „Beobachten“.
