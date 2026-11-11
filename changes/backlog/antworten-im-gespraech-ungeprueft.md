---
effort: L
value: L
---

# Antworten im Gespräch werden nie gegengeprüft

Geprüft werden nur Einträge der Beurteilung und der Baum aus Überblick und
Kapiteln (`agents/akte-nachziehen.md`, „Gegenprüfung“). Was das Modell in der Beratung
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
(`agents/aenderung-gegenpruefen.md`, „nicht prüfbar“).

## Warnzeichen entstehen in jeder Antwort neu

Alle geltenden Warnzeichen stehen im Überblick, der ab dem Start ganz im
Kontext ist (`vorlagen/AKTE.md:23-25`), und eine Beschwerde, die dort steht,
ist mindestens so dringend wie die Stufe dort (`regeln.md:107-109`). In der
Antwort nennt das Modell aber auch Warnzeichen, die dort nicht stehen, und
erzeugt sie jedes Mal neu, ohne Leitlinie und ohne geprüfte Stufe;
`naechste-schritte` hängt neue nur nachträglich an die Beurteilung an
(`skills/naechste-schritte/SKILL.md:45-46`).

Zwei Läufe von `naechste-schritte` in echten Beratungen, gut eine Stunde
auseinander, über dieselbe Akte (noch vor dem Baum aus Überblick und
Kapiteln):

- Ein Notfall-Warnzeichen der Wirbelsäule (Blasen- oder Darmstörung mit
  Taubheit im Gesäß) stand unter „zum Hausarzt“, also zu niedrig gestuft.
- Die Fieberschwelle unter einer immunsuppressiven Therapie war einmal
  38,5 °C, einmal jedes Fieber.
- Eine erneute Ohnmacht hieß einmal „112“, im anderen Lauf fehlte sie.

Idee aus der Bewertung: In einer Antwort nur Warnzeichen nennen, die in der
Akte stehen oder mit einer Leitlinie belegt und dann eingetragen werden, und
ihre Stufe gegen die Stufen der Regeln prüfen.
