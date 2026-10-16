---
name: termin-vorbereiten
description: Erstellt eine Themenliste für einen bevorstehenden Arzt- oder Physiotermin und wertet den Termin danach aus. Benutzen bei „ich habe am … einen Termin bei …“, „was soll ich beim Arzt ansprechen“ und wenn der Benutzer von einem Termin zurückkommt.
---

# Termin vorbereiten

## Vorher

1. `akte-stand` ausführen; meldet es Änderungen, zuerst den Skill
   `akte-aktualisieren`.
2. Aus `AKTE.md` und `BEURTEILUNG.md` sammeln, was in diese Praxis gehört,
   dazu Offenes anderer Praxen, das sich hier miterledigen lässt.
3. `termin-<praxis>-<JJJJ-MM-TT>.md` schreiben:
   - Kopf: Termin, Stand, „Zusammengestellt aus AKTE.md und BEURTEILUNG.md;
     Empfehlungen eines Modells, nicht ärztlich bestätigt.“
   - **Vorher erledigen:** was mitzubringen, abzuholen oder zu klären ist.
   - **Fragen** als Checkliste, Wichtigstes zuerst.
     Jede Frage so formuliert, dass man sie vorlesen kann, mit kurzer
     Begründung und Quelle.
   - **Zur Info für die Praxis:** die für diesen Termin wichtigen Befunde,
     Medikation und Vorgeschichte in wenigen Zeilen. Nur die geltenden
     Angaben, nie was in `AKTE.md` als überholt steht; Daten wie den Beginn
     einer Therapie aus `AKTE.md` abschreiben.

   Allgemeinverständlich, ohne Abkürzungen, die die Praxis nicht kennt.
4. Committen.

## Nachher

1. Die Liste Punkt für Punkt durchgehen: Was wurde besprochen, entschieden,
   verordnet?
2. Die Ergebnisse über den Skill `neue-information` aufnehmen.
3. Die Themenliste löschen und committen.
