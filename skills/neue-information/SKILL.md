---
name: neue-information
description: Neue Angaben zum Patienten aufnehmen – einen Befund, einen Laborwert, ein Arztgespräch, eine neue oder veränderte Beschwerde, eine Änderung der Medikation, eine Korrektur. Benutzen, sobald der Benutzer etwas über seinen Zustand oder seine Behandlung mitteilt, das noch nicht in AKTE.md steht.
---

# Neue Information

1. **Warnzeichen.** Bei neuen oder stärkeren Beschwerden zuerst prüfen, ob
   sie eine ärztliche Behandlung noch am selben Tag oder den Notruf nötig
   machen. Wenn ja, das sofort und deutlich sagen; der Rest wartet.
2. **Nachfragen**, was zur Einordnung fehlt: Datum, wer was gesagt oder
   verordnet hat, seit wann, wie stark. Fehlt `unterlagen/anamnese.md`, zuerst
   den Skill `anamnese` ausführen.
3. **Ablegen:**
   - **Befund als Datei:** lesen, dann ablegen als
     `unterlagen/JJJJ-MM-TT-<art>_<absender>.pdf` mit dem Datum des Befunds,
     nicht des Eingangs.
   - **Aussage, Ereignis, Arztgespräch, Korrektur:** den Eintrag für
     `unterlagen/historie.md` formulieren und zeigen; erst nach Bestätigung
     des Wortlauts anhängen. Eine Korrektur nennt den Eintrag, den sie
     korrigiert; bestehende Einträge bleiben unverändert.
   - **Messwerte:** an die passende CSV in `unterlagen/` anhängen.

   Dann committen.
4. **AKTE.md** mit dem Skill `akte-aktualisieren` nachziehen.
5. **BEURTEILUNG.md prüfen:** Welche Einträge betrifft die Änderung?
   Erledigte und überholte kommen mit Datum und Ergebnis nach „Erledigt“,
   betroffene werden angepasst und neu datiert. Neue Fragen belegst du mit dem
   Skill `leitlinie`. Committen.
6. **Sperrliste:** Bringt die Angabe einen neuen Namen einer Praxis, eines
   Arztes oder einer Klinik, eine markante Diagnose oder ein Medikament, schlag
   vor, den Begriff in die Sperrliste aufzunehmen
   (`~/.config/patientenakte/sperrliste`, ein Begriff pro Zeile). Sie hält
   diese Begriffe aus dem öffentlichen Plugin-Repo fern. Erst nach Zustimmung
   anhängen.
7. **Antworten:** kurz, was sich dadurch an der Einschätzung und an den
   nächsten Schritten ändert. Verschiebt sich die Reihenfolge deutlich, den
   Skill `naechste-schritte` ausführen.
