---
name: neue-information
description: Neue Angaben zum Patienten aufnehmen – einen Befund, einen Laborwert, ein Arztgespräch, eine neue oder veränderte Beschwerde, eine Änderung der Medikation, eine Korrektur, eine Beobachtung zu einem Thema unter „Beobachten“ in BEURTEILUNG.md. Benutzen, sobald der Benutzer etwas über seinen Zustand oder seine Behandlung mitteilt, das noch nicht in AKTE.md steht und neu und von Belang ist oder ein beobachtetes Thema betrifft.
---

# Neue Information

Jede Angabe nimmst du gleich auf (Schritte 1 bis 5). Eingearbeitet wird
einmal, wenn der Benutzer nichts mehr hinzuzufügen hat (Schritte 6 bis 10):
So muss er die Akte nicht nach jeder Angabe neu durchsehen.

Stehen in `unterlagen/` beim Aufruf schon Einträge aus einer früheren
Sitzung, die nicht committet sind (`git status unterlagen/`), nimmst du sie
wie neue Angaben auf: Statt einen Eintrag zu formulieren, zeigst du den
vorhandenen und lässt ihn bestätigen. Weil er noch nicht committet ist,
darfst du ihn dabei ändern oder entfernen. Die Einträge aus diesem Gespräch
bleiben bis Schritt 7 absichtlich ohne Commit; sie zeigst du nicht erneut.

## Aufnehmen

1. **Prüfen, ob es hineingehört,** nach der Regel in `regeln.md`: neu und
   von Belang, oder ein Thema unter „Beobachten“ in `BEURTEILUNG.md`. Sonst
   trägst du es nicht ein und fragst nicht danach. Liegen schon
   aufgenommene Angaben ohne Commit vor, geht es mit Schritt 5 weiter, sonst
   endet der Skill hier.
2. **Nachfragen**, was zur Einordnung fehlt: Datum, wer was gesagt oder
   verordnet hat, seit wann, wie stark.
3. **Ablegen,** noch ohne Commit:
   - **Befund als Datei:** lesen, dann ablegen als
     `unterlagen/JJJJ-MM-TT-<art>_<absender>.pdf` mit dem Datum des Befunds,
     nicht des Eingangs.
   - **Aussage, Ereignis, Arztgespräch, Korrektur:** den Eintrag für
     `unterlagen/historie.md` formulieren und zeigen; erst nach Bestätigung
     des Wortlauts anhängen. Eine Korrektur nennt den Eintrag, den sie
     korrigiert; bestehende Einträge bleiben unverändert.
   - **Beobachtungen und Messwerte:** die Zeile für die CSV des Themas aus
     „Beobachten“ zeigen; erst nach Bestätigung anhängen. Fehlt die Datei,
     sie mit den Spalten von dort als erster Zeile anlegen.
4. **Medikation prüfen,** wenn ein Mittel neu hinzukommt oder sich Dosis
   oder Schema ändern: mit dem Skill `leitlinie` die Fachinformation lesen,
   Abschnitt 4.3 (Gegenanzeigen) und 4.5 (Wechselwirkungen). Abgleichen mit
   `AKTE.md` und den übrigen neuen Angaben, wie unter „Evidenz“ in
   `regeln.md` beschrieben, auch gegen Bedarfsmedikation und
   Nahrungsergänzung. Dem Benutzer das Ergebnis gleich sagen, auch wenn
   nichts dagegen spricht. Spricht etwas dagegen, es gleich unter „Offen“
   oder „Warnzeichen“ in `BEURTEILUNG.md` eintragen, damit es auch bei einer
   abgebrochenen Sitzung nicht verloren geht.
5. **Fragen, ob noch etwas dazukommt,** bevor du die Akte nachziehst. Was
   noch kommt, nimmst du ab Schritt 1 auf.

## Einarbeiten

6. **BEURTEILUNG.md prüfen:** Welche Einträge betreffen die neuen Angaben,
   auch unter „Einschätzungen“ und „Beobachten“? Erledigte und überholte
   werden gelöscht; ein Ergebnis, das noch nicht in `unterlagen/` steht,
   kommt wie in Schritt 3 nach `historie.md`. Abgelehnte, die sonst weiter
   gelten würden, kommen mit Datum und Grund nach „Abgelehnt“. Betroffene
   werden angepasst und neu datiert.
   Neue Fragen belegst du mit dem Skill `leitlinie`.
7. **Committen:** die neuen Unterlagen und `BEURTEILUNG.md` in einem Commit.
8. **AKTE.md** mit dem Skill `akte-aktualisieren` nachziehen.
9. **Antworten:** kurz, was sich dadurch an der Einschätzung und an den
   nächsten Schritten ändert. Verschiebt sich die Reihenfolge deutlich, den
   Skill `naechste-schritte` ausführen.
10. **Notfallpass:** Betrifft eine Angabe Diagnosen, Medikation, Allergien,
    Implantate oder eine Schwangerschaft, auch beim Absetzen oder Ausheilen,
    den Skill `notfallpass` ausführen und den Benutzer bitten, den Text im
    Handy zu ersetzen.
