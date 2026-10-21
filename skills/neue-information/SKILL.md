---
name: neue-information
description: Neue Angaben zum Patienten im Gespräch als Entwurf aufnehmen, ohne Commit – einen Befund, einen Laborwert, ein Arztgespräch, eine neue oder veränderte Beschwerde, eine Änderung der Medikation, eine Korrektur, eine Beobachtung zu einem Thema unter „Beobachten“ in BEURTEILUNG.md. Benutzen, wenn der Benutzer etwas mitteilt, das nach der Regel in regeln.md in die Unterlagen gehört. Eingearbeitet wird später mit dem Skill einarbeiten.
---

# Neue Information

Du nimmst die Angabe als Entwurf ohne Commit auf und berätst weiter. Den
Wortlaut lässt du hier nicht bestätigen und fragst auch nicht, ob noch etwas
dazukommt; das geschieht gesammelt im Skill `einarbeiten`.

Einen neuen Messwert ordnest du, wann immer du ihn kommentierst, gegen die
Reihe desselben Parameters ein, aus Befunden unter „Messwerte“ in `AKTE.md`,
aus einer Messreihe in deren CSV: frühere Werte
mit Datum, Differenz zum letzten Wert in Zahlen, ob er gestiegen, gesunken
oder gleich ist, ob er einen Trend fortsetzt und ob er im Referenzbereich
bleibt.

1. **Prüfen, ob es hineingehört,** nach der Regel in `regeln.md`.
   Antworten auf die Fragen des Skills `akte-pruefen` gehören immer hinein,
   auch unauffällige und Ablehnungen. Sonst trägst du es nicht ein, fragst
   nicht danach und der Skill endet.
2. **Nachfragen**, was zur Einordnung fehlt, nur soweit es nach dieser Regel
   zählt: Datum, wer was gesagt oder verordnet hat, seit wann, wie stark.
3. **Ablegen** als Entwurf, ohne Commit:
   - **Befund als Datei:** lesen, dann ablegen als
     `unterlagen/JJJJ-MM-TT-<art>_<absender>.<endung>` mit dem Datum des
     Befunds, nicht des Eingangs. Eine vorhandene Datei ersetzt du nie: Ist
     der Name vergeben, häng vor der Endung `-2`, `-3` … an. Zugelassen
     sind PDF, JPG und PNG; HEIC liest du nicht, der Benutzer soll es als
     JPG schicken.
   - **Aussage, Ereignis, Arztgespräch, Korrektur:** als Eintrag an
     `unterlagen/historie.md` anhängen. Ändert oder ergänzt der Benutzer
     einen Entwurf, änderst du den Entwurf. Eine Korrektur eines
     committeten Eintrags ist ein neuer Eintrag und nennt den, den sie
     korrigiert; committete Einträge bleiben unverändert.
   - **Beobachtungen und Messwerte:** als Zeile an die CSV des Themas aus
     „Beobachten“ anhängen. Fehlt die Datei, sie mit den Spalten von dort
     als erster Zeile anlegen.
4. **Medikation prüfen,** wenn ein Mittel neu hinzukommt oder sich Dosis
   oder Schema ändern: mit dem Skill `leitlinie` die Fachinformation lesen,
   Abschnitt 4.2 (Dosierung, auch bei eingeschränkter Nieren- oder
   Leberfunktion), 4.3 (Gegenanzeigen), 4.4 (Warnhinweise), 4.5
   (Wechselwirkungen) und 4.6 (Schwangerschaft und Stillzeit). Weichen Dosis
   oder Schema von 4.2 ab, etwa täglich statt wöchentlich, frag nach, ob die
   Angabe stimmt; eine Berichtigung änderst du im Entwurf aus Schritt 3.
   Stimmt sie oder weiß der Benutzer es nicht, rat
   ihm, sie vor der nächsten Einnahme mit Arzt oder Apotheke zu klären;
   nimmt er das Mittel schon so ein und kann das schaden, gilt die
   Dringlichkeit aus den Regeln wie bei neuen Beschwerden. Abgleichen mit
   `AKTE.md` und den übrigen neuen Angaben, wie unter „Evidenz“ in
   `regeln.md` beschrieben, auch gegen Bedarfsmedikation und
   Nahrungsergänzung. Dem Benutzer das Ergebnis gleich sagen, auch wenn
   nichts dagegen spricht. Spricht etwas dagegen, es gleich mit dem Skill
   `beurteilung-aendern` unter „Offen“ oder „Warnzeichen“ eintragen.
