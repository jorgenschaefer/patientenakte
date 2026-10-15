---
name: neue-information
description: Neue Angaben zum Patienten aufnehmen – einen Befund, einen Laborwert, ein Arztgespräch, eine neue oder veränderte Beschwerde, eine Änderung der Medikation, eine Korrektur, eine Beobachtung zu einem Thema unter „Beobachten“ in BEURTEILUNG.md. Benutzen, sobald der Benutzer etwas über seinen Zustand oder seine Behandlung mitteilt, das noch nicht in AKTE.md steht und neu und von Belang ist oder ein beobachtetes Thema betrifft.
---

# Neue Information

1. **Prüfen, ob es hineingehört,** nach der Regel in `regeln.md`: neu und
   von Belang, oder ein Thema unter „Beobachten“ in `BEURTEILUNG.md`. Sonst
   endet der Skill hier, ohne Eintrag und ohne Frage danach.
2. **Nachfragen**, was zur Einordnung fehlt: Datum, wer was gesagt oder
   verordnet hat, seit wann, wie stark.
3. **Ablegen:**
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

   Dann committen.
4. **AKTE.md** mit dem Skill `akte-aktualisieren` nachziehen.
5. **Medikation prüfen,** wenn ein Mittel neu hinzukommt oder sich Dosis
   oder Schema ändern: mit dem Skill `leitlinie` die Fachinformation lesen,
   Abschnitt 4.3 (Gegenanzeigen) und 4.5 (Wechselwirkungen). Abgleichen mit
   `AKTE.md`, wie unter „Evidenz“ in `regeln.md` beschrieben, auch gegen
   Bedarfsmedikation und Nahrungsergänzung. Dem Benutzer das Ergebnis
   sagen, auch wenn nichts dagegen spricht.
6. **BEURTEILUNG.md prüfen:** Welche Einträge betrifft die Änderung, auch
   unter „Beobachten“? Erledigte und überholte kommen mit Datum und Ergebnis
   nach „Erledigt“, betroffene werden angepasst und neu datiert. Neue Fragen
   belegst du mit dem Skill `leitlinie`. Was die Prüfung der Medikation
   ergeben hat, kommt unter „Offen“ oder „Warnzeichen“. Committen.
7. **Antworten:** kurz, was sich dadurch an der Einschätzung und an den
   nächsten Schritten ändert. Verschiebt sich die Reihenfolge deutlich, den
   Skill `naechste-schritte` ausführen.
8. **Notfallpass:** Betrifft die Änderung Diagnosen, Medikation, Allergien,
   Implantate oder eine Schwangerschaft, auch beim Absetzen oder Ausheilen,
   den Skill `notfallpass` ausführen und den Benutzer bitten, den Text im
   Handy zu ersetzen.
