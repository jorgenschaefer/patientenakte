---
name: akte-pruefen
description: Bringt die Akte auf den Stand des Plugins, ohne Befunde zu lesen. Prüft AKTE.md, BEURTEILUNG.md, anamnese.md und historie.md gegen die Regeln des Plugins, fragt fehlende Punkte der Anamnese, abgelaufene Fristen und Widersprüche nach, berichtigt die Form, löscht oder schränkt Einträge in BEURTEILUNG.md ein, die AKTE.md nicht mehr trägt, und kürzt BEURTEILUNG.md auf das, was eine künftige Beratung braucht.
disable-model-invocation: true
---

# Akte prüfen

Geprüft wird, was sich ohne Befunde und ohne Literatur prüfen lässt. Du
liest keine Befunde (PDF, JPG, PNG) und von `literatur/` nur `README.md` und
die Dateinamen; auch einen vollständigen Bau von `AKTE.md` startest du
nicht.

## Ablauf

1. **Vorher nachziehen:** den Skill `einarbeiten` ausführen. Erst danach
   prüfen.
2. **Lesen:** `AKTE.md`, `BEURTEILUNG.md`, `unterlagen/anamnese.md`,
   `unterlagen/historie.md`, die Dateinamen in `unterlagen/` und
   `literatur/`, `literatur/README.md` und die erste Zeile jeder CSV in
   `unterlagen/`. Dazu die Regeln, gegen die du prüfst:
   - das Schema in `${CLAUDE_PLUGIN_ROOT}/skills/anamnese/SKILL.md`;
   - „Regeln“ und „Aufbau“ in `${CLAUDE_PLUGIN_ROOT}/agents/akte.md`;
   - `${CLAUDE_PLUGIN_ROOT}/vorlagen/BEURTEILUNG.md` und
     `${CLAUDE_PLUGIN_ROOT}/skills/beurteilung-aendern/SKILL.md`.
3. **Prüfen**, wie unter „Prüfen“ unten, und jeden Fund einer der drei
   Gruppen zuordnen.
4. **Funde nennen,** bevor sich eine Datei ändert, getrennt nach den drei
   Gruppen: was du berichtigst, je mit dem, was mit dem Fund geschieht;
   wonach du fragen wirst; was du nur meldest, je mit dem, was ihn beheben
   würde, etwa der Skill `leitlinie` oder ein Blick in einen bestimmten
   Befund. Danach fragst du und berichtigst ohne weitere Rückfrage.
5. **Fragen,** einzeln und im Gesprächston, nicht als Liste. Antworten zum
   Patienten, auch „erledigt“, welche von zwei Angaben gilt oder dass er
   nichts sagen will, nimmst du mit dem Skill `neue-information` auf; eine
   Ablehnung als Eintrag „möchte zu … keine Angaben machen“. Nach der
   letzten Antwort arbeitest du sie mit dem Skill `einarbeiten` ein. Nennt
   der Benutzer zu einer Quelle auf eine fehlende Datei die richtige,
   berichtigst du die Quelle in Schritt 6 und nennst diese Datei in
   Schritt 9 als weitere Quelle. Was unbeantwortet bleibt, ist offen
   geblieben.
6. **`AKTE.md` berichtigen** nach den Regeln des Subagenten `akte`. Was die
   Antworten schon erledigt haben, entfällt.
7. **`BEURTEILUNG.md` berichtigen** mit dem Skill `beurteilung-aendern`.
   Die Funde gegen `AKTE.md` prüfst du vorher gegen die nachgezogene
   `AKTE.md` erneut.
8. **`BEURTEILUNG.md` kürzen.** Ziel: Dort steht nur, was eine künftige
   Beratung braucht, wie unter „Knapp“ im Kopf der Vorlage.
   1. Jeden Eintrag lesen und fragen: Was davon braucht eine künftige
      Beratung?
   2. Steht mehr da, den Eintrag neu schreiben: die Empfehlung oder
      Einschätzung, Fristen als Datum, die Dringlichkeit, die Grundlage aus
      der Leitlinie in einem Satz je Empfehlung mit Nummer und Graden,
      unter **Modell** der entscheidende Grund, dazu, was der Hinweis unter
      der Überschrift des Abschnitts verlangt. Vorn steht das späteste
      Datum, an dem der Eintrag geschrieben oder geprüft wurde; ein neues
      bekommt er nicht, denn Kürzen ist kein Prüfen.
   3. Eine Quelle, die kein Eintrag mehr zitiert, aus „Quellen“ streichen.
9. **Einarbeiten** mit dem Skill `einarbeiten`. Der Aufruf nennt für
   `AKTE.md`, wenn du sie berichtigt hast, eine Berichtigung mit
   `HEAD:AKTE.md` und den Dateien aus Schritt 5 als Quellen; für
   `BEURTEILUNG.md` keine Quellen, nach einer Kürzung `HEAD:BEURTEILUNG.md`.
10. **Abschließen:** `AKTE.md`, `BEURTEILUNG.md`, `unterlagen/` und
    `literatur/` sind committet, und `akte-stand` meldet nichts. Dann fasst
    du zusammen: was berichtigt wurde, die Funde der Gegenprüfungen, was
    offen geblieben ist, darunter alles nur Gemeldete, ob `BEURTEILUNG.md`
    gekürzt wurde, und die Commits mit Hash und Titel. Gab es keine Funde,
    sagst du das in einem Satz.

## Prüfen

**Fragen:**

- ein Punkt des Schemas, zu dem weder `anamnese.md` noch `historie.md`
  noch `AKTE.md` etwas sagen. Ein Punkt ist jede Angabe, die das Schema
  nennt; eine zusammenfassende Angabe zum Abschnitt, etwa „vegetative
  Anamnese unauffällig“, deckt dessen Punkte ab, ebenso „unbekannt“.
  Abschnitte des Schemas mit „wo zutreffend“ nur, wo sie zutreffen;
- „keine Angabe“, deren Vermerk älter als 12 Monate ist; jüngere zählen wie
  eine Angabe;
- ein Punkt unter „Offen“ in `AKTE.md` oder `BEURTEILUNG.md` mit
  abgelaufener Frist;
- zwei Angaben in `AKTE.md`, die sich widersprechen, außer wenn eine davon
  als überholt gekennzeichnet ist;
- eine Quelle in `AKTE.md` auf eine Datei, die es in `unterlagen/` nicht
  gibt.

**Nur melden:**

- eine Angabe in `AKTE.md` ohne Quelle;
- eine Quelle unter „Quellen“ in `BEURTEILUNG.md` ohne Registernummer,
  Version, Gültigkeit oder Prüfdatum, oder ohne Datei in `literatur/`;
- ein Thema unter „Beobachten“ ohne CSV oder mit anderen Spalten als ihre
  erste Zeile; die CSV änderst du nicht;
- ein Abschnitt in `AKTE.md`, der nicht im Aufbau steht und zu keinem
  Abschnitt des Aufbaus passt;
- ein Fund in `BEURTEILUNG.md`, dessen Berichtigung eine neue Empfehlung
  bräuchte.

**Berichtigen**, alles Übrige:

- `AKTE.md` gegen „Regeln“ und „Aufbau“: Kopf, Name und Reihenfolge der
  Abschnitte; ein Abschnitt, der nicht im Aufbau steht, kommt in den
  passenden; Form einer Quelle; Stand-Datum, aus der Quelle der Angabe;
  Form der Messwerte; eine überholte Angabe in eigener Zeile; eine doppelte
  Angabe.
- `BEURTEILUNG.md` gegen die Vorlage und `beurteilung-aendern`: Kopf,
  Hinweise unter den Überschriften und Reihenfolge wie in der Vorlage; ein fehlender
  Abschnitt der Vorlage; ein Eintrag ohne Datum vorn oder ohne
  Kennzeichnung; ein Kurzname, der unter „Quellen“ fehlt, nachgetragen
  mit dem, was `literatur/README.md` zu ihm nennt, der Rest wie oben nur
  gemeldet; ein Thema in zwei Einträgen.
- `BEURTEILUNG.md` gegen `AKTE.md`: Ein Eintrag, dessen Grundlage `AKTE.md`
  nicht mehr trägt, und ein Punkt unter „Offen“, der laut `AKTE.md`
  erledigt ist, werden gelöscht. Ein Eintrag, der Allergien, Medikation oder
  Diagnosen widerspricht, wird eingeschränkt und neu datiert oder, wenn
  nichts von ihm bleibt, gelöscht.

Eine Berichtigung der Form ändert keine Angabe inhaltlich: keinen Wert,
keine Einheit, keinen Referenzbereich, keine Diagnosesicherheit und nicht,
worauf eine Quelle zeigt, außer bei einer Quelle, zu der der Benutzer in
Schritt 5 die richtige Datei genannt hat. Ginge es nicht ohne, meldest du
den Fund nur.
