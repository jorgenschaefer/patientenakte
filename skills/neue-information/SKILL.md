---
name: neue-information
description: Neue Angaben zum Patienten aufnehmen – einen Befund, einen Laborwert, ein Arztgespräch, eine neue oder veränderte Beschwerde, eine Änderung der Medikation, eine Korrektur, eine Beobachtung zu einem Thema unter „Beobachten“ in BEURTEILUNG.md. Benutzen, sobald der Benutzer etwas über seinen Zustand oder seine Behandlung mitteilt, das noch nicht in AKTE.md steht und neu und von Belang ist oder ein beobachtetes Thema betrifft.
---

# Neue Information

Jede Angabe nimmst du gleich auf (Schritte 1 bis 5). Eingearbeitet wird
einmal, wenn der Benutzer nichts mehr hinzuzufügen hat (Schritte 6 bis 10).

Stehen in `unterlagen/` beim Aufruf schon Einträge aus einer früheren
Sitzung, die nicht committet sind (`git status unterlagen/`), nimmst du sie
wie neue Angaben auf: Statt einen Eintrag zu formulieren, zeigst du den
vorhandenen und lässt ihn bestätigen. Weil er noch nicht committet ist,
darfst du ihn dabei ändern oder entfernen. Die Einträge aus diesem Gespräch
bleiben bis Schritt 7 absichtlich ohne Commit; sie zeigst du nicht erneut.

Einen neuen Messwert ordnest du, wann immer du ihn kommentierst, gegen die
Reihe desselben Parameters ein, aus Befunden unter „Messwerte“ in `AKTE.md`,
aus einer Messreihe in deren CSV: frühere Werte
mit Datum, Differenz zum letzten Wert in Zahlen, ob er gestiegen, gesunken
oder gleich ist, ob er einen Trend fortsetzt und ob er im Referenzbereich
bleibt.

## Aufnehmen

1. **Prüfen, ob es hineingehört,** nach der Regel in `regeln.md`: neu und
   von Belang, oder ein Thema unter „Beobachten“ in `BEURTEILUNG.md`.
   Antworten auf die Fragen des Skills `akte-pruefen` gehören immer hinein,
   auch unauffällige und Ablehnungen. Sonst
   trägst du es nicht ein und fragst nicht danach. Liegen schon
   aufgenommene Angaben ohne Commit vor, geht es mit Schritt 5 weiter, sonst
   endet der Skill hier.
2. **Nachfragen**, was zur Einordnung fehlt: Datum, wer was gesagt oder
   verordnet hat, seit wann, wie stark.
3. **Ablegen,** noch ohne Commit:
   - **Befund als Datei:** lesen, dann ablegen als
     `unterlagen/JJJJ-MM-TT-<art>_<absender>.<endung>` mit dem Datum des
     Befunds, nicht des Eingangs. Eine vorhandene Datei ersetzt du nie: Ist
     der Name vergeben, häng vor der Endung `-2`, `-3` … an. Zugelassen
     sind PDF, JPG und PNG; HEIC liest du nicht, der Benutzer soll es als
     JPG schicken.
   - **Aussage, Ereignis, Arztgespräch, Korrektur:** den Eintrag für
     `unterlagen/historie.md` formulieren und zeigen; erst nach Bestätigung
     des Wortlauts anhängen. Eine Korrektur nennt den Eintrag, den sie
     korrigiert; bestehende Einträge bleiben unverändert.
   - **Beobachtungen und Messwerte:** die Zeile für die CSV des Themas aus
     „Beobachten“ zeigen; erst nach Bestätigung anhängen. Fehlt die Datei,
     sie mit den Spalten von dort als erster Zeile anlegen.
4. **Medikation prüfen,** wenn ein Mittel neu hinzukommt oder sich Dosis
   oder Schema ändern: mit dem Skill `leitlinie` die Fachinformation lesen,
   Abschnitt 4.2 (Dosierung, auch bei eingeschränkter Nieren- oder
   Leberfunktion), 4.3 (Gegenanzeigen), 4.4 (Warnhinweise), 4.5
   (Wechselwirkungen) und 4.6 (Schwangerschaft und Stillzeit). Weichen Dosis
   oder Schema von 4.2 ab, etwa täglich statt wöchentlich, frag nach, ob die
   Angabe stimmt; eine Berichtigung änderst du im Eintrag aus Schritt 3, er
   ist noch nicht committet. Stimmt sie oder weiß der Benutzer es nicht, rat
   ihm, sie vor der nächsten Einnahme mit Arzt oder Apotheke zu klären;
   nimmt er das Mittel schon so ein und kann das schaden, gilt die
   Dringlichkeit aus den Regeln wie bei neuen Beschwerden. Abgleichen mit
   `AKTE.md` und den übrigen neuen Angaben, wie unter „Evidenz“ in
   `regeln.md` beschrieben, auch gegen Bedarfsmedikation und
   Nahrungsergänzung. Dem Benutzer das Ergebnis gleich sagen, auch wenn
   nichts dagegen spricht. Spricht etwas dagegen, es gleich mit dem Skill
   `beurteilung-aendern` unter „Offen“ oder „Warnzeichen“ eintragen, damit
   es auch bei einer abgebrochenen Sitzung nicht verloren geht.
5. **Fragen, ob noch etwas dazukommt,** bevor du die Akte nachziehst. Was
   noch kommt, nimmst du ab Schritt 1 auf.

## Einarbeiten

6. **BEURTEILUNG.md nachziehen:** die Einträge, die die neuen Angaben
   betreffen, mit dem Skill `beurteilung-aendern`. Ein Ergebnis, das noch
   nicht in `unterlagen/` steht, kommt wie in Schritt 3 nach `historie.md`.
   Neue Fragen belegst du mit dem Skill `leitlinie`.
7. **Committen:** mit dem Skill `beurteilung-aendern` abschließen, die neuen
   Unterlagen im selben Commit.
8. **AKTE.md** mit dem Skill `akte-aktualisieren` nachziehen.
9. **Antworten:** kurz, was sich dadurch an der Einschätzung und an den
   nächsten Schritten ändert. Verschiebt sich die Reihenfolge deutlich, den
   Skill `naechste-schritte` ausführen.
10. **Notfallpass:** Betrifft eine Angabe Diagnosen, Medikation, Allergien,
    Implantate oder eine Schwangerschaft, auch beim Absetzen oder Ausheilen,
    den Skill `notfallpass` ausführen und den Benutzer bitten, den Text im
    Handy zu ersetzen.
