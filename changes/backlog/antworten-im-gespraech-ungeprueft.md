---
effort: L
utility: L
---

# Antworten im Gespräch werden nie gegengeprüft

Geprüft werden nur Änderungen an `AKTE.md` und `BEURTEILUNG.md`
(`regeln.md`, Abschnitt „Gegenprüfung“). Was das Modell in der Beratung
antwortet, Themenlisten für einen Termin (`skills/termin-vorbereiten`) und
der Text für den Notfallpass (`skills/notfallpass`) prüft niemand, obwohl
dort die meisten Fehler aus den echten Beratungen standen:

- Eine Themenliste für eine Praxis nannte unter „Zur Info für die Praxis“
  eine Operation, die es nie gab und die in `AKTE.md` als widerlegt stand,
  und ein falsches Datum für den Beginn einer Therapie. Themenlisten gehen
  an Ärzte.
- Die erste Einschätzung eines Laborbefunds, direkt aus dem PDF, las den
  Verlauf eines Werts falsch herum, weil das Labor eine andere Referenz
  hatte; das Modell berichtigte sich erst in der nächsten Antwort.
- Eine Frist für eine Vorsorgeuntersuchung kam aus dem Gedächtnis und war
  falsch; eine spätere Sitzung nannte nach dem Lesen der Richtlinie die
  richtige.

Ein Hindernis: Viele Aussagen stützen sich auf Quellen, die nicht lokal
vorliegen, und sind dann für einen Prüfer nicht prüfbar
(`agents/gegenpruefung.md`, „nicht prüfbar“).
