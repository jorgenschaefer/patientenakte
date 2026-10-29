---
name: naechste-schritte
description: Sagt, was der Patient als Nächstes tun sollte, in welcher Reihenfolge und warum – Arzttermine und was dort zu besprechen ist, Physiotherapie, Übungen, Ernährung, Alltag, Organisatorisches. Benutzen bei Fragen wie „was steht an“, „was ist jetzt am wichtigsten“, „was muss ich als Nächstes machen“.
---

# Nächste Schritte

1. Nach veralteten Ständen fragen, die für die Reihenfolge zählen: Hat ein
   Termin stattgefunden, liegt ein Ergebnis vor, hat eine Therapie begonnen?
2. Alles Offene sammeln: die Fristen im Überblick und, weil dort nur die
   der nächsten vier Wochen stehen, die in den Kapiteln jedes aktiven
   Problems und in `kapitel/medikation.md`, je ärztlich veranlasst oder
   empfohlen unter „Fakten“ und vom Modell empfohlen unter
   „Einschätzungen“; dazu Fristen in Einträgen der Beurteilung ohne
   Commit.
3. Fällige Vorsorge aus `kapitel/vorsorge.md` und `kapitel/impfungen.md`
   übernehmen und mit einordnen, ohne den Skill `vorsorge` auszuführen.
   Fehlen dort Einschätzungen zur Vorsorge oder stammen sie aus der Zeit
   vor einer Diagnose oder einem Mittel aus dem Überblick, das in der
   Antwort sagen, mit Datum und dem, was seitdem neu ist, und `/vorsorge`
   vorschlagen.
4. Ordnen nach:
   1. **Sicherheit und Fristen:** was vor einem bestimmten Ereignis erledigt
      sein muss, etwa eine Untersuchung vor einem Therapiebeginn, und was
      sonst Schaden anrichten kann;
   2. **Termine der nächsten zwei Wochen** und was dafür vorbereitet sein
      muss;
   3. **Wirkung:** was den Verlauf am meisten beeinflusst;
   4. **Aufwand:** Kleines, das nebenbei geht, darf vorrücken.
5. Antworten, geordnet nach Zeit:
   - **Jetzt und diese Woche**, **in den nächsten Wochen**, **bis in drei
     Monaten**: was überfällig ist oder in dieser Zeit ansteht. Späteres
     nur, wenn vorher etwas zu tun ist, etwa einen Termin zu buchen; sonst
     eine Zeile, wie viele Punkte ab wann folgen;
   - jeder Punkt: was zu tun ist, bei wem, bis wann, und in einem Satz warum,
     mit der Quelle aus dem Kapitel: der Name der Leitlinie aus
     `literatur/README.md` und die Empfehlungsnummer;
   - danach, was dauerhaft gilt: Übungen, Ernährung, Alltag und die
     Warnzeichen aus dem Überblick mit ihrer Stufe. Neue Warnzeichen an die
     Beurteilung anhängen.
6. Ergibt sich eine neue Empfehlung, mit dem Subagenten
   `patientenakte:leitlinien-recherche` belegen und an die Beurteilung
   anhängen.
