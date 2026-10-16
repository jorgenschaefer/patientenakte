---
name: naechste-schritte
description: Sagt, was der Patient als Nächstes tun sollte, in welcher Reihenfolge und warum – Arzttermine und was dort zu besprechen ist, Physiotherapie, Übungen, Ernährung, Alltag, Organisatorisches. Benutzen bei Fragen wie „was steht an“, „was ist jetzt am wichtigsten“, „was muss ich als Nächstes machen“.
---

# Nächste Schritte

1. `akte-stand` ausführen; meldet es Änderungen, zuerst den Skill
   `akte-aktualisieren` ausführen.
2. Nach veralteten Ständen fragen, die für die Reihenfolge zählen: Hat ein
   Termin stattgefunden, liegt ein Ergebnis vor, hat eine Therapie begonnen?
   Antworten über den Skill `neue-information` aufnehmen.
3. Alles Offene sammeln: „Offen“ in `AKTE.md` (ärztlich veranlasst oder
   empfohlen, Termine), „Offen“ in `BEURTEILUNG.md` (Empfehlungen des
   Modells), Fristen aus der Medikation.
4. Fällige Vorsorge aus „Vorsorge“ in `BEURTEILUNG.md` übernehmen und mit
   einordnen, ohne den Skill `vorsorge` auszuführen. Ist der Abschnitt leer
   oder älter als eine Diagnose oder ein Mittel in `AKTE.md`, das in der
   Antwort sagen, mit Datum und dem, was seitdem neu ist, und `/vorsorge`
   vorschlagen.
5. Ordnen nach:
   1. **Sicherheit und Fristen:** was vor einem bestimmten Ereignis erledigt
      sein muss, etwa eine Untersuchung vor einem Therapiebeginn, und was
      sonst Schaden anrichten kann;
   2. **Termine der nächsten zwei Wochen** und was dafür vorbereitet sein
      muss;
   3. **Wirkung:** was den Verlauf am meisten beeinflusst;
   4. **Aufwand:** Kleines, das nebenbei geht, darf vorrücken.
6. Antworten, geordnet nach Zeit:
   - **Jetzt und diese Woche**, **in den nächsten Wochen**, **bis in drei
     Monaten**: was überfällig ist oder in dieser Zeit ansteht. Späteres
     nur, wenn vorher etwas zu tun ist, etwa einen Termin zu buchen; sonst
     eine Zeile, wie viele Punkte ab wann folgen, mit Verweis auf „Offen“ in
     `BEURTEILUNG.md`;
   - jeder Punkt: was zu tun ist, bei wem, bis wann, und in einem Satz warum,
     mit der Quelle aus `BEURTEILUNG.md` (Kurzname und Empfehlungsnummer);
   - danach, was dauerhaft gilt: Übungen, Ernährung, Alltag und die
     Warnzeichen aus `BEURTEILUNG.md` mit ihrer Stufe. Neue Warnzeichen
     dort eintragen.
7. Ergibt sich eine neue Empfehlung, mit dem Skill `leitlinie` belegen und
   in `BEURTEILUNG.md` eintragen.
