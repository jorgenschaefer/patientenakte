---
name: naechste-schritte
description: Sagt, was der Patient als Nächstes tun sollte, in welcher Reihenfolge und warum – Arzttermine und was dort zu besprechen ist, Physiotherapie, Übungen, Ernährung, Alltag, Organisatorisches. Benutzen bei Fragen wie „was steht an“, „was ist jetzt am wichtigsten“, „was muss ich als Nächstes machen“.
---

# Nächste Schritte

1. `bin/akte-stand` ausführen; meldet es Änderungen, zuerst den Skill
   `akte-aktualisieren` ausführen.
2. Nach veralteten Ständen fragen, die für die Reihenfolge zählen: Hat ein
   Termin stattgefunden, liegt ein Ergebnis vor, hat eine Therapie begonnen?
   Antworten über den Skill `neue-information` aufnehmen.
3. Alles Offene sammeln: „Offen“ in `AKTE.md` (ärztlich veranlasst, Termine),
   „Offen“ in `BEURTEILUNG.md` (Empfehlungen), Fristen aus der Medikation.
4. Ordnen nach:
   1. **Sicherheit und Fristen:** was vor einem bestimmten Ereignis erledigt
      sein muss, etwa eine Untersuchung vor einem Therapiebeginn, und was
      sonst Schaden anrichten kann;
   2. **Termine der nächsten zwei Wochen** und was dafür vorbereitet sein
      muss;
   3. **Wirkung:** was den Verlauf am meisten beeinflusst;
   4. **Aufwand:** Kleines, das nebenbei geht, darf vorrücken.
5. Antworten, geordnet nach Zeit:
   - **Jetzt und diese Woche**, **in den nächsten Wochen**, **später**;
   - jeder Punkt: was zu tun ist, bei wem, bis wann, und in einem Satz warum,
     mit der Quelle aus `BEURTEILUNG.md` (Kurzname und Empfehlungsnummer);
   - danach, was dauerhaft gilt: Übungen, Ernährung, Alltag und auf welche
     Warnzeichen zu achten ist.
6. Ergibt sich eine neue Empfehlung, mit dem Skill `leitlinie` belegen und
   in `BEURTEILUNG.md` eintragen.
   Die Antwort selbst wird nicht gespeichert.
