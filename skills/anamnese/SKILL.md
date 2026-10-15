---
name: anamnese
description: Legt unterlagen/anamnese.md mit einer strukturierten Erstbefragung des Patienten an. Richtet dabei eine neue, leere Akte ein. Benutzen, wenn die Datei fehlt – etwa in einer neuen Akte – oder der Benutzer eine Erstbefragung wünscht.
---

# Anamnese

`unterlagen/anamnese.md` hält den Stand zu einem Datum fest. Gibt es sie
schon, bleibt sie unverändert; Neues gehört über den Skill `neue-information`
in `historie.md`.

## Ablauf

1. In einer neuen Akte zuerst anlegen, was fehlt:
   - `BEURTEILUNG.md` aus `${CLAUDE_PLUGIN_ROOT}/vorlagen/BEURTEILUNG.md`;
   - `literatur/README.md` aus
     `${CLAUDE_PLUGIN_ROOT}/vorlagen/literatur-README.md`;
   - das Verzeichnis `unterlagen/`.

   Ist das Verzeichnis kein Git-Repo, abbrechen und auf das README des
   Plugins verweisen. Committen.
2. Vorhandenes sammeln: Was sagen die Befunde in `unterlagen/` und frühere
   Angaben des Benutzers schon zu den Punkten unten? Daraus Vorschläge
   machen, statt neu zu fragen.
3. Die Punkte nacheinander abfragen. Was der Benutzer nicht weiß, wird als
   „unbekannt“ eingetragen; was er nicht sagen will, bleibt weg.
4. Jeden Abschnitt so zeigen, wie er eingetragen würde, und erst nach
   Bestätigung übernehmen. Vermutungen des Patienten als solche kennzeichnen.
5. Datei schreiben, committen, dann den Skill `akte-aktualisieren` ausführen.

## Schema

- **Stammdaten:** Name, gewünschte Anrede, Geburtsdatum, Geschlecht, Größe,
  Gewicht mit Datum, Krankenkasse, Vorsorgevollmacht und Patientenverfügung,
  Grad der Behinderung (GdB), Pflegegrad
- **Aktuelle Beschwerden:** was, seit wann, Verlauf, was hilft, was
  verschlimmert
- **Vorerkrankungen und Diagnosen** mit Jahr und behandelnder Praxis
- **Operationen, Krankenhaus- und Reha-Aufenthalte**
- **Medikamente**, auch Bedarfsmedikation und Nahrungsergänzung: Dosis,
  Schema, seit wann, verordnet von
- **Allergien und Unverträglichkeiten**
- **Impfungen** laut Impfpass
- **Bisherige Vorsorge:** Früherkennungsuntersuchungen und Check-up mit
  Datum und Ergebnis
- **Vegetative Anamnese:** Appetit, Durst, Gewichtsverlauf, Stuhlgang,
  Wasserlassen, Schlaf, Nachtschweiß, Fieber
- **Gynäkologische Anamnese**, wo zutreffend: Schwangerschaften und
  Geburten, mögliche oder bestehende Schwangerschaft, Verhütung, Wechseljahre
- **Genussmittel:** Rauchen, Alkohol, Sonstiges
- **Familienanamnese**
- **Sozial- und Berufsanamnese:** Beruf, Belastungen, Arbeitsfähigkeit,
  Wohnsituation, Hilfsmittel
- **Sport und Bewegung:** früher und jetzt
- **Behandelnde Ärzte und Therapeuten** mit Kontaktdaten
- **Ziele und Vorlieben:** was der Patient erreichen oder vermeiden möchte,
  auch im Sport, etwa „möchte eine Operation vermeiden“

## Format

```
# Anamnese

*Erstbefragung vom TT.MM.JJJJ, vom Benutzer bestätigt und danach unverändert. Spätere Angaben stehen in historie.md.*

## Stammdaten
…
```
