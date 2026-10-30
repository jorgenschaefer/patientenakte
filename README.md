# patientenakte

Ein Plugin für [Claude Code](https://claude.com/claude-code), das auf
Grundlage einer persönlichen Patientenakte in medizinischen,
psychologischen und psychotherapeutischen, physiotherapeutischen,
ernährungswissenschaftlichen und sportwissenschaftlichen Fragen berät: nach aktuellen Leitlinien, mit Quellen
und mit klarer Trennung zwischen dem, was in Befunden steht, und dem, was ein
Modell daraus schließt.

Es ersetzt keine ärztliche Behandlung. Es hilft, Befunde zu ordnen, Termine
vorzubereiten und Fragen zu stellen.

Die Regeln sind auf Deutsch und auf das deutsche Gesundheitswesen
ausgerichtet: AWMF-Leitlinien, Nationale VersorgungsLeitlinien, STIKO.

## Installation

Das Plugin braucht `pdfinfo` und `pdftotext` aus poppler-utils, um die
Seiten der Befunde zu zählen und die Textfassung der Literatur zu
schreiben, ebenso `tests/check.sh`; unter Debian und Ubuntu mit
`sudo apt install poppler-utils`.

Das Plugin wird nie global aktiviert, sondern nur in den Akten. Sonst
spielt es seine Regeln in jede Sitzung ein, auch in solche, die mit keiner
Akte zu tun haben.

Einmal den Marketplace hinzufügen:

```bash
claude plugin marketplace add jorgenschaefer/patientenakte
```

Für jede Akte ein neues, leeres Repo anlegen und das Plugin nur dort
aktivieren:

```bash
mkdir ~/Projects/akte-<name>
cd ~/Projects/akte-<name>
git init
claude plugin install patientenakte@patientenakte --scope local
```

`--scope local` trägt das Plugin in `.claude/settings.local.json` der Akte
ein.

**Akten gehören nie in ein öffentliches Repo.** Sie enthalten
Gesundheitsdaten. Ein Remote für die Akte nur privat anlegen, etwa mit
`gh repo create akte-<name> --private --source .`.

## Das erste Gespräch

In der Akte `claude` starten und etwas schreiben, ein „Hallo“ genügt. Claude
legt `literatur/`, `unterlagen/` und `.claude/CLAUDE.md` an und beginnt mit
der Erstbefragung: Stammdaten, Beschwerden, Vorerkrankungen,
Medikamente, Allergien, Impfungen und Vorsorge, psychische Verfassung,
Lebensumstände, Sport, die
behandelnden Ärzte und die eigenen Ziele. Claude fragt nacheinander und zeigt
jeden Abschnitt, bevor er in `unterlagen/anamnese.md` eingetragen wird. Was
man nicht weiß, wird als „unbekannt“ vermerkt; was man nicht sagen will,
als „keine Angabe“.

Vorhandene Befunde kann man vorher nach `unterlagen/` legen. Claude übernimmt
daraus, was schon drinsteht, und fragt dann weniger.

Am Ende baut Claude die Akte aus der Anamnese und den Befunden: den
Überblick `AKTE.md` und die Kapitel in `kapitel/`.

## Folgegespräche

Jede weitere Sitzung kann direkt mit einer Frage beginnen, in normalen
Sätzen; eine Befehlssyntax gibt es nicht, nur `/einarbeiten` (siehe „Neue
Befunde und Angaben“ und „Die Akte prüfen“).

**Eine Frage**, etwa „Darf ich mit meinem Knie wieder joggen?“, beantwortet
Claude auf Grundlage der Akte. Der Überblick ist von Beginn an im Kontext;
vor der Antwort liest Claude jedes Kapitel, das die Frage berührt, auch
über Umwege, etwa eine Beschwerde, die eine Übung betrifft. Bei einem
neuen Thema sagt Claude zuerst in ein, zwei Sätzen, was aus der Akte die
Antwort trägt. Vor einer Empfehlung
zu Diagnostik, Therapie, Medikation, Training oder Vorsorge sucht Claude
die passende Leitlinie oder Studie, prüft, ob sie noch gilt, und legt sie in
`literatur/` ab. Die Antwort nennt die Quelle und trennt, was dort steht, von
dem, was Claude daraus für den eigenen Fall schließt. Bei neuen oder stärkeren
Beschwerden sagt Claude zuerst, wie dringend der Arzt ist: Notruf 112, noch
heute, in ein bis drei Tagen oder beim nächsten regulären Termin.
Fehlt für eine Antwort ein aktueller Stand, etwa ein Blutwert von vor einem
Jahr, fragt Claude nach.

Weitere Anliegen:

- **„Was steht als Nächstes an?“** Claude sammelt alles Offene aus der Akte
  und ordnet es nach Dringlichkeit: diese Woche, die nächsten
  Wochen, später, dazu, was dauerhaft gilt.
- **„Ich habe seit drei Tagen Kopfschmerzen, was kann das sein?“** Claude
  prüft zuerst auf Warnzeichen, fragt dann nach den Beschwerden, legt ein
  Leitsymptom fest und geht die möglichen Ursachen durch, die gefährlichen
  zuerst. Am Ende stehen eine Verdachtsdiagnose, was der Arzt untersuchen
  sollte, wie dringend das ist und bei welchen Veränderungen man früher
  gehen muss.
- **„Welche Vorsorge steht bei mir an?“** Claude geht Früherkennung nach
  Alter und Geschlecht, die Kontrollen aus Diagnosen und Medikamenten,
  arbeitsmedizinische Vorsorge, Familie und Impfungen durch und gibt eine
  Tabelle mit Fälligkeit, Quelle und Kostenträger aus, dazu, was geprüft
  wurde und nicht zutrifft. Fehlt ein letzter Termin, fragt Claude danach.
- **„Ich habe am Donnerstag einen Termin beim Orthopäden.“** Claude legt eine
  Themenliste `termin-<praxis>-<datum>.md` an: was mitzubringen ist, Fragen
  zum Vorlesen, das Wichtigste zuerst, und eine kurze Zusammenfassung für die
  Praxis. Nach dem Termin geht Claude die Liste mit einem durch, nimmt die
  Ergebnisse auf und löscht sie.
- **„Was sagt die Leitlinie zu …?“** Claude sucht die Quelle und gibt wieder,
  was sie sagt, mit Empfehlungsgrad und Evidenzniveau.
- **„Was gehört in meinen Notfallpass?“** Claude gibt für jedes Feld des
  Notfallpasses auf dem Pixel-Handy einen kurzen Text zum Kopieren aus, von
  Blutgruppe und Allergien bis zu Medikamenten und medizinischen
  Informationen. Nach einer Änderung daran bietet Claude den neuen Text
  an.

## Neue Befunde und Angaben

Einen neuen Befund, etwa einen MRT-Befund als PDF, gibt man Claude im
Gespräch: Pfad nennen oder Datei in den Prompt ziehen, dazu, was es ist.
Claude liest ihn, fragt nach, was zur Einordnung fehlt, und legt ihn mit
Datum, Art und Absender im Namen in `unterlagen/` ab.

Ebenso im Gespräch mitteilen lassen sich Beschwerden, Ergebnisse eines
Arztgesprächs, Änderungen der Medikation und Messwerte. Claude nimmt nur
auf, was eine Angabe der Akte oder eine künftige Empfehlung ändern
würde, nicht etwa, dass man ein Rezept heute einlöst; Beobachtungen wie
Schlaf oder Schmerzstärke nur zu Themen, die laut Beurteilung beobachtet
werden, als Zeile in deren CSV. Ein neues Medikament oder
eine geänderte Dosis prüft Claude gleich auf Dosierung, Gegenanzeigen und
Wechselwirkungen.
Lehnt man eine Empfehlung ab, kommt das mit Grund nach `historie.md`, und
Claude schlägt sie nicht erneut vor. Was Claude für den Fall einschätzt,
jedes Warnzeichen und jede Frist, hängt Claude gleich an die Beurteilung
`unterlagen/beurteilung.md` an.

Im Gespräch bleibt das alles ein Entwurf ohne Commit, und Claude berät
weiter, ohne den Wortlaut einzeln bestätigen zu lassen. Eingearbeitet wird
am Ende des Gesprächs mit `/einarbeiten`, was Claude anbietet, wenn man
erkennbar Schluss macht. Neue Unterlagen und Entwürfe einer abgebrochenen
Sitzung arbeitet Claude beim Start der nächsten Sitzung ein; anderes, was
zu beheben ist, etwa vorbeigegangene Fristen, nennt Claude dann und
schlägt `/einarbeiten` vor. Legt man mitten in einer Sitzung eine Datei
nach `unterlagen/`, ohne sie im Gespräch zu nennen, arbeitet `/einarbeiten`
sie ein. Claude zeigt dann die neuen Einträge in `historie.md` auf einmal
zur Bestätigung, denn sie geben die eigenen Aussagen wieder; Messwerte,
Befunde und Beurteilungen schreibt Claude ohne Rückfrage. Den Rest
erledigt ein Subagent, damit das Gespräch nicht mit den Unterlagen
vollläuft: Er committet die Unterlagen, dann die neuen Einträge der
Beurteilung und `literatur/` nach einer Gegenprüfung in frischem Kontext,
und zieht die Kapitel nach, die die neuen Angaben berühren, und den
Überblick, ebenfalls nach einer Gegenprüfung. Wird ein Kapitel zu lang,
teilt er es in Unterkapitel. Claude fasst dann
zusammen, was sich geändert hat, stellt Widersprüche zwischen den
Unterlagen als Fragen, sagt, was sich an der Einschätzung ändert, und
bietet an, die nächsten Schritte, die Vorsorge oder den Notfallpass zu
zeigen, wenn sie sich geändert haben.

Liegt beim Start einer Sitzung die Themenliste eines vergangenen Termins,
spricht Claude sie von sich aus an.

## Die Akte prüfen

Ändert sich das Plugin, folgen ältere Akten nicht mehr den Vorlagen für
den Überblick und die Kapitel. Claude sagt das beim Start einer Sitzung,
gleicht aber nur auf `/einarbeiten` hin an und baut dann die Akte neu.
Ebenso auf Wunsch baut Claude die Akte neu oder zur Kontrolle ein zweites
Mal und vergleicht beide Fassungen, etwa mit „/einarbeiten und bau die Akte
neu“.

Neubau und Kontrolle laufen in Stapeln, deren Höchstzahl an Seiten oben
in `bin/akte-stand` steht, die Unterlagen in der Reihenfolge ihres Datums;
nur eine größere Unterlage bildet einen größeren Stapel für sich. Claude
sagt vorher, in wie vielen.
Jeder Stapel wird in einen Zwischenstand unter `.git/akte-bau/`
eingearbeitet, beim Neubau gegen seine Unterlagen gegengeprüft. Ein
Abschluss prüft danach die Einschätzungen gegen die neuen Kapitel und
hängt an die Beurteilung an, was sich geändert hat. Dann gleicht Claude
die neue Fassung je Stapel mit der bisherigen ab.
Beim Neubau stellt Claude wieder her, was verloren ging und keine
Unterlage überholt, und ersetzt dann den Baum; bei der Kontrolle
berichtigt Claude den Baum, wo sich die zweite Fassung an der Unterlage
bestätigt. Die Zwischenstände werden danach gelöscht. Bricht der Bau ab,
bleibt der Baum, wie er war, und der Neubau beginnt beim nächsten Mal von
vorn.

Mit „/einarbeiten und prüf die Akte“ prüft Claude außerdem, ob der Baum
und die Beurteilung noch ihren Regeln folgen und zueinander passen. Die
Prüfung beginnt nur auf Wunsch, nie von selbst. Gefragt wird nach Punkten
der Erstbefragung, zu denen die Akte nichts sagt, etwa der psychischen
Verfassung in einer älteren Akte, nach abgelaufenen Fristen, nach
Widersprüchen und nach Quellen auf Dateien, die es nicht gibt. Die
Antworten kommen wie jede Angabe nach `unterlagen/historie.md`. Eine
abgelehnte Angabe wird als „keine Angabe“ vermerkt; danach fragt die
Prüfung erst nach zwölf Monaten wieder. Form und Doppeltes im Baum
berichtigt Claude ohne Rückfrage, mit Gegenprüfung. Ein Eintrag der
Beurteilung, den der Baum nicht mehr trägt, bekommt einen neuen Eintrag,
der ihn aufhebt.

Die Prüfung selbst liest keine Befunde und keine Literatur und prüft nicht,
ob Leitlinien noch gelten. Was nur damit zu klären wäre, etwa eine Angabe
ohne Quelle oder eine Leitlinie ohne Registernummer, meldet sie mit dem,
was es beheben würde.

## Eine Akte im bisherigen Aufbau

Akten, die vor dem Baum angelegt wurden, haben eine `AKTE.md` mit allen
Fakten und eine `BEURTEILUNG.md` mit allen Einschätzungen. Claude meldet
das beim Start jeder Sitzung und berät bis zur Umstellung wie bisher auf
Grundlage dieser beiden Dateien. Neue Angaben nimmt Claude als Entwurf auf,
neue Einschätzungen kommen an die Beurteilung `unterlagen/beurteilung.md`.
Von selbst arbeitet Claude in einer solchen Akte nichts ein, sondern
schlägt `/einarbeiten` vor.

Jedes `/einarbeiten` stellt die Akte zuerst um:

1. Ein nicht abgeschlossener Bau der alten `AKTE.md` wird verworfen.
2. `BEURTEILUNG.md` wird auf die eigenen Einschätzungen des Modells
   gekürzt und der erste Eintrag der Beurteilung: Einschätzungen,
   Warnzeichen mit Stufe, Fristen aus „Offen“, die Themen unter
   „Beobachten“ und der Vorsorgeplan samt dem, was geprüft wurde und nicht
   zutrifft. Aussagen einer Leitlinie, die in `literatur/` liegt, bleiben
   nur als Verweis auf Quelle und Stelle; die übrigen bleiben mit ihrer
   Quelle. Der Abschnitt „Quellen“ und die Herleitungen fallen weg.
3. Angaben des Patienten, Abgelehntes und Organisatorisches aus
   `BEURTEILUNG.md`, die noch in keiner Unterlage stehen, kommen als
   Entwurf nach `unterlagen/historie.md`. Claude zeigt sie mit den übrigen
   Entwürfen zur Bestätigung.
4. Claude baut den Baum neu, mit Gegenprüfung und Abgleich mit der alten
   `AKTE.md`, legt `.claude/CLAUDE.md` an und entfernt die alte `AKTE.md`
   und `BEURTEILUNG.md` im selben Commit. Danach stehen sie nur noch in der
   Git-Geschichte der Akte.

Bricht die Umstellung ab, bleiben die alte `AKTE.md` und `BEURTEILUNG.md`,
wie sie waren, und Claude berät weiter auf ihrer Grundlage. Der Start der
nächsten Sitzung meldet den Abbruch, und das nächste `/einarbeiten` setzt
fort, ohne den ersten Eintrag der Beurteilung oder die Entwürfe ein
zweites Mal anzulegen.

## Aufbau

Das Plugin enthält nur das Gerüst: Regeln, Skills, Agenten, Scripts und
Vorlagen. Jede Akte ist ein eigenes, privates Git-Repo:

```
AKTE.md            der Überblick: was in jeder Beratung gelten muss, je Problem eine Zeile
kapitel/           je Problem und übergreifendem Thema ein Kapitel, mit Unterkapiteln
kapitel/grundlage.md  Prüfsummen der eingearbeiteten Unterlagen, kein Kapitel
unterlagen/        Befunde als PDF oder Foto, anamnese.md, historie.md, beurteilung.md, Messreihen als CSV
literatur/         Leitlinien, Studien und Fachinformationen als PDF und Textfassung
.claude/CLAUDE.md  bindet den Überblick beim Start jeder Sitzung ein
termin-*.md        Themenliste für einen Termin, wird danach gelöscht
```

### Überblick und Kapitel

Der Überblick `AKTE.md` nennt, was in jeder Beratung gelten muss:
Allergien, die ganze Medikation, was die Wahl oder Dosis eines Mittels
ändert, alle Warnzeichen und die Fristen der nächsten vier Wochen. Dazu
je Problem eine Zeile mit Status und Verweis auf sein Kapitel. Ein
Problem ist alles, was behandelt oder abgeklärt wird, auch ohne Diagnose;
es ist aktiv, ruhend oder abgeschlossen. Übergreifende Themen wie
Medikation, Impfungen oder Vorsorge haben eigene Kapitel. Ein Kapitel
hat die Abschnitte Fakten, Literatur, Einschätzungen und Abgelehnt, und
wird es zu lang, Unterkapitel.

Überblick und Kapitel haben je eine Höchstlänge in Wörtern, oben in
`bin/akte-stand`. Sie fassen Unterlagen, Literatur und Beurteilung
zusammen, jede Angabe mit Quelle in eckigen Klammern, und lassen sich
jederzeit daraus neu bauen.

### Fakten und Beurteilung

Wohin eine Angabe gehört, entscheidet ihre Herkunft. Was von einem Arzt,
aus einem Befund oder vom Patienten stammt, kommt nach `unterlagen/`,
auch dass der Patient eine Empfehlung ablehnt.

Was ein Modell für den Fall schließt, steht in der Beurteilung
`unterlagen/beurteilung.md`: Einschätzungen, Warnzeichen mit Stufe,
Fristen und was beobachtet wird. Sie wird nur angehängt, nie umgeschrieben,
damit Einschätzungen von Beratung zu Beratung gleich bleiben. Ein Eintrag
gilt, bis ein späterer mit demselben Thema und derselben Art ihn ablöst
oder ein Eintrag „Aufgehoben“ ihn streicht. Wie Einträge aussehen, steht
in ihrem Kopf. Was eine Quelle aus `literatur/` sagt, steht in den
Kapiteln unter „Literatur“, mit Stelle; die Übersicht der Quellen mit
Prüfdatum steht in `literatur/README.md`.

### Das Plugin

- `regeln.md` – die Regeln für die Beratung: Rolle, Beginn einer Sitzung,
  Beraten, Einarbeiten, eine Akte im bisherigen Aufbau, Dateien,
  Dringlichkeit, wohin eine Angabe gehört, und unter „Evidenz“, dass vor
  jeder Empfehlung eine Quelle geprüft wird.
- `hooks/regeln-einspielen` – spielt beim Start jeder Sitzung `regeln.md`
  in zwei Teilen ein, weil Claude Code die Ausgabe eines Hooks nur bis zu
  einer Länge ganz übernimmt.
- `hooks/stand-einspielen` – spielt beim Start den Stand der Akte und
  vergangene Termine ein; fehlt `unterlagen/anamnese.md`, verlangt er die
  Erstbefragung.
- `bin/akte-stand` – meldet, welche Unterlagen noch nicht im Baum
  eingearbeitet sind, ob ein Bau nicht abgeschlossen ist, einen fehlenden
  Überblick, Überblick und Kapitel über ihrer Höchstlänge, Verweise ins
  Leere, abgelaufene Fristen, Quellen in `literatur/` ohne Datei und
  Dateien dort ohne vollständige Zeile in `literatur/README.md`; meldet
  eine Akte im bisherigen Aufbau
  und eine Umstellung, die nicht abgeschlossen ist. Schreibt mit
  `--aktualisieren` die Prüfsummen nach `kapitel/grundlage.md`; meldet mit
  `--vorlage`, ob Überblick oder Kapitel von ihrer Vorlage abweichen; teilt
  mit `--stapel` die Unterlagen in der Reihenfolge ihres Datums nach
  Seitenzahl in Stapel für einen Neubau; gibt mit `--einheit` einen Teil
  von `historie.md` oder `beurteilung.md` aus, wie ihn `--stapel` nennt.
- `bin/literatur-text` – schreibt zu einem PDF in `literatur/` die
  Textfassung in der Reihenfolge des Lesens und nennt die Seiten, deren
  Inhalt nicht als Text darin steht.
- `vorlagen/` – Vorlagen für den Überblick `AKTE.md`, die Kapitel, die
  Beurteilung, `literatur/README.md` und `.claude/CLAUDE.md` der Akte
  (`claude.md`); sie legen Abschnitte und Hinweise fest.
- `skills/` – laufen im Gespräch und können den Benutzer fragen:
  - `anamnese` – Erstbefragung, richtet eine neue Akte ein;
  - `neue-information` – nimmt eine neue Angabe als Entwurf in
    `unterlagen/` auf;
  - `einarbeiten` – stellt eine Akte im bisherigen Aufbau um, sammelt,
    was aussteht, lässt die neuen Einträge in `historie.md` bestätigen
    und startet `akte-nachziehen`;
  - `diagnose` – klärt Beschwerden ab wie in der Sprechstunde;
  - `naechste-schritte` – was ansteht, nach Dringlichkeit;
  - `vorsorge` – Vorsorgeplan mit Fälligkeit, Quelle und Kostenträger;
  - `termin-vorbereiten` – Themenliste vor einem Termin, Auswertung danach;
  - `notfallpass` – Text für den Notfallpass, Feld für Feld.
- `agents/` – laufen in eigenem Kontext und erreichen den Benutzer nicht;
  was nur er beantworten kann, geben sie als Frage zurück:
  - `leitlinien-recherche` – sucht eine Leitlinie, Studie oder
    Fachinformation, prüft ihre Gültigkeit, legt sie in `literatur/` ab und
    gibt zurück, was sie sagt;
  - `vorsorge-recherche` – stellt den Vorsorgeplan auf und hängt ihn an
    die Beurteilung an;
  - `akte-nachziehen` – committet die Unterlagen und die Beurteilung,
    zieht den Baum nach, lässt jede Änderung gegenprüfen und committet
    sie; stellt eine Akte im bisherigen Aufbau um, gleicht auf Wunsch an
    die Vorlagen an, baut neu, kontrolliert und prüft die Akte;
  - `akte` – schreibt den Baum aus `unterlagen/` und `literatur/`,
    schrittweise, einen Stapel eines Neubaus oder dessen Abschluss;
  - `aenderung-gegenpruefen` – prüft eine Änderung am Baum, an einem
    Zwischenstand oder an der Beurteilung vor dem Commit gegen ihre
    Quellen, den ersten Eintrag einer Umstellung gegen `BEURTEILUNG.md`;
    gleicht nach Neubau und Kontrolle je Stapel mit dem vorigen Baum ab.

### Ablauf

1. **Beginn einer Sitzung:** Die Hooks liefern Regeln und Stand,
   `.claude/CLAUDE.md` den Überblick. Stehen neue Unterlagen, Entwürfe
   ohne Commit oder ein nicht abgeschlossener Bau aus, läuft zuerst
   `einarbeiten`, außer der Überblick fehlt oder die Akte hat den
   bisherigen Aufbau.
2. **Beratung:** auf Grundlage des Überblicks, der Kapitel, die die Frage
   berühren, und der Angaben aus dem Gespräch, die noch nicht
   eingearbeitet sind. Vor einer Empfehlung prüft `leitlinien-recherche`
   die Quelle, außer ein Kapitel nennt sie schon mit nicht veralteter
   Prüfung.
3. **Neue Angaben:** `neue-information` legt sie als Entwurf in
   `unterlagen/` ab; Einschätzungen, Warnzeichen und Fristen hängt Claude
   an die Beurteilung an. Beides ohne Commit.
4. **Einarbeiten:** `einarbeiten` sammelt alles Ausstehende und lässt die
   neuen Einträge in `historie.md` bestätigen. `akte-nachziehen` macht dann
   die Commits: die Unterlagen, die Beurteilung mit `literatur/` nach
   einer Gegenprüfung und den Baum nach einer Gegenprüfung. Seine Fragen
   stellt `einarbeiten`; die Antworten werden aufgenommen und eingearbeitet
   wie jede neue Angabe.

### Wer wen aufruft

```
Gespräch                         Subagent, Ebene 1        Subagent, Ebene 2
einarbeiten ───────────────────▶ akte-nachziehen ──┬───▶ akte
                                                   └───▶ aenderung-gegenpruefen
vorsorge ──────────────────────▶ vorsorge-recherche ───▶ leitlinien-recherche
regeln.md, diagnose,
naechste-schritte ─────────────▶ leitlinien-recherche
```

- Nur `akte-nachziehen` committet, und erst nach einer Gegenprüfung; alles
  andere schreibt Entwürfe. Ausnahme ist `.claude/CLAUDE.md`, das
  `anamnese` beim Einrichten committet.
- Den Baum schreiben nur die Subagenten `akte` und `akte-nachziehen`.
  Steht dort etwas Falsches, weil eine Unterlage falsch ist, kommt die
  Korrektur in `historie.md`.
- Mit dem Benutzer spricht nur das Gespräch; die Subagenten für Vorsorge
  und Einarbeiten werden nur aus ihrem Skill gestartet.
- Rückfragen kommen als Rückmeldung zurück und lösen einen neuen Lauf aus,
  keinen Aufruf in die Gegenrichtung.

## Lizenz

GPL-3.0 oder später, siehe `LICENSE`.
