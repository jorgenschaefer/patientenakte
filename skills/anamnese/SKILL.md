---
name: anamnese
description: Legt unterlagen/anamnese.md mit einer strukturierten Erstbefragung des Patienten an. Benutzen, wenn die Datei fehlt – etwa in einer neuen Akte – oder der Benutzer eine Erstbefragung wünscht.
---

# Anamnese

`unterlagen/anamnese.md` hält den Stand zu einem Datum fest. Gibt es sie
schon, bleibt sie unverändert; Neues gehört über den Skill `neue-information`
in `historie.md`.

## Ablauf

1. Vorhandenes sammeln: Was sagen die Befunde in `unterlagen/` und frühere
   Angaben des Benutzers schon zu den Punkten unten? Daraus Vorschläge
   machen, statt neu zu fragen.
2. Die Punkte nacheinander abfragen, wenige Fragen auf einmal. Was der
   Benutzer nicht weiß, wird als „unbekannt“ eingetragen; was er nicht sagen
   will, bleibt weg.
3. Jeden Abschnitt so zeigen, wie er eingetragen würde, und erst nach
   Bestätigung übernehmen. Umformulieren ist erlaubt, wenn der Benutzer
   zustimmt. Vermutungen des Patienten als solche kennzeichnen.
4. Datei schreiben, committen, dann den Skill `akte-aktualisieren` ausführen.

## Schema

- **Stammdaten:** Geburtsdatum, Geschlecht, Größe, Gewicht mit Datum,
  Krankenkasse, Vorsorgevollmacht und Patientenverfügung
- **Aktuelle Beschwerden:** was, seit wann, Verlauf, was hilft, was
  verschlimmert
- **Vorerkrankungen und Diagnosen** mit Jahr und behandelnder Praxis
- **Operationen und Krankenhausaufenthalte**
- **Medikamente**, auch Bedarfsmedikation und Nahrungsergänzung: Dosis,
  Schema, seit wann, verordnet von
- **Allergien und Unverträglichkeiten**
- **Impfungen** laut Impfpass
- **Vegetative Anamnese:** Appetit, Durst, Gewichtsverlauf, Stuhlgang,
  Wasserlassen, Schlaf, Nachtschweiß, Fieber
- **Genussmittel:** Rauchen, Alkohol, Sonstiges
- **Familienanamnese**
- **Sozial- und Berufsanamnese:** Beruf, Belastungen, Arbeitsfähigkeit,
  Wohnsituation
- **Sport und Bewegung:** früher und jetzt, Ziele
- **Behandelnde Ärzte und Therapeuten** mit Kontaktdaten

## Format

```
# Anamnese

*Erstbefragung vom TT.MM.JJJJ, vom Benutzer bestätigt und danach unverändert. Spätere Angaben stehen in historie.md.*

## Stammdaten
…
```
