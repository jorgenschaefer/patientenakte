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
legt `BEURTEILUNG.md`, `literatur/` und `unterlagen/` an und beginnt mit der Erstbefragung: Stammdaten, Beschwerden, Vorerkrankungen,
Medikamente, Allergien, Impfungen und Vorsorge, psychische Verfassung,
Lebensumstände, Sport, die
behandelnden Ärzte und die eigenen Ziele. Claude fragt nacheinander und zeigt
jeden Abschnitt, bevor er in `unterlagen/anamnese.md` eingetragen wird. Was
man nicht weiß, wird als „unbekannt“ vermerkt; was man nicht sagen will,
als „keine Angabe“.

Vorhandene Befunde kann man vorher nach `unterlagen/` legen. Claude übernimmt
daraus, was schon drinsteht, und fragt dann weniger.

Am Ende baut Claude `AKTE.md` aus der Anamnese und den Befunden.

## Folgegespräche

Jede weitere Sitzung kann direkt mit einer Frage beginnen, in normalen
Sätzen; eine Befehlssyntax gibt es nicht, nur `/einarbeiten` (siehe „Neue
Befunde und Angaben“ und „Die Akte prüfen“).

**Eine Frage**, etwa „Darf ich mit meinem Knie wieder joggen?“, beantwortet
Claude auf Grundlage von `AKTE.md` und `BEURTEILUNG.md`. Vor einer Empfehlung
zu Diagnostik, Therapie, Medikation, Training oder Vorsorge sucht Claude
die passende Leitlinie oder Studie, prüft, ob sie noch gilt, und legt sie in
`literatur/` ab. Die Antwort nennt die Quelle und trennt, was dort steht, von
dem, was Claude daraus für den eigenen Fall schließt. Bei neuen oder stärkeren
Beschwerden sagt Claude zuerst, wie dringend der Arzt ist: Notruf 112, noch
heute, in ein bis drei Tagen oder beim nächsten regulären Termin.
Fehlt für eine Antwort ein aktueller Stand, etwa ein Blutwert von vor einem
Jahr, fragt Claude nach.

Weitere Anliegen:

- **„Was steht als Nächstes an?“** Claude sammelt alles Offene aus Akte und
  Beurteilung und ordnet es nach Dringlichkeit: diese Woche, die nächsten
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
auf, was eine Angabe in `AKTE.md` oder eine künftige Empfehlung ändern
würde, nicht etwa, dass man ein Rezept heute einlöst; Beobachtungen wie
Schlaf oder Schmerzstärke nur zu Themen, die unter „Beobachten“ in
`BEURTEILUNG.md` stehen, als Zeile in deren CSV. Ein neues Medikament oder
eine geänderte Dosis prüft Claude gleich auf Dosierung, Gegenanzeigen und
Wechselwirkungen.

Im Gespräch bleibt das alles ein Entwurf ohne Commit, und Claude berät
weiter, ohne den Wortlaut einzeln bestätigen zu lassen. Eingearbeitet wird
am Ende des Gesprächs mit `/einarbeiten`, was Claude anbietet, wenn man
erkennbar Schluss macht; was dann noch aussteht, arbeitet Claude beim Start
der nächsten Sitzung ein, auch neue Dateien in `unterlagen/` und Entwürfe
einer abgebrochenen Sitzung. Legt man mitten in einer Sitzung eine Datei
nach `unterlagen/`, ohne sie im Gespräch zu nennen, arbeitet `/einarbeiten`
sie ein. Claude zeigt dann die neuen Einträge in `historie.md` auf einmal
zur Bestätigung, denn sie geben die eigenen Aussagen wieder; Messwerte,
Befunde und Beurteilungen schreibt Claude ohne Rückfrage. Den Rest
erledigt ein Subagent, damit das Gespräch nicht mit den Unterlagen
vollläuft: Er committet die Unterlagen, zieht `AKTE.md` nach und danach
`BEURTEILUNG.md` gegen die neue `AKTE.md`, beide nach einer Gegenprüfung
in frischem Kontext und je in einem eigenen Commit. Claude fasst dann
zusammen, was sich geändert hat, stellt Widersprüche zwischen den
Unterlagen als Fragen, sagt, was sich an der Einschätzung ändert, und
bietet an, die nächsten Schritte, die Vorsorge oder den Notfallpass zu
zeigen, wenn sie sich geändert haben.

Liegt beim Start einer Sitzung die Themenliste eines vergangenen Termins,
spricht Claude sie von sich aus an.

## Die Akte prüfen

Ändert sich das Plugin, folgen ältere Akten nicht mehr den Vorlagen für
`AKTE.md` und `BEURTEILUNG.md`. Claude sagt das beim Start einer Sitzung,
gleicht aber nur auf `/einarbeiten` hin an: `AKTE.md` wird dann aus den
Unterlagen neu gebaut, `BEURTEILUNG.md` an die Vorlage angepasst.
Ebenso auf Wunsch baut Claude `AKTE.md` neu oder zur Kontrolle ein zweites
Mal und vergleicht beide Fassungen, etwa mit „/einarbeiten und bau die Akte
neu“.

Mit „/einarbeiten und prüf die Akte“ prüft Claude außerdem, ob `AKTE.md`
und `BEURTEILUNG.md` noch ihren Regeln folgen und zueinander passen. Die
Prüfung beginnt nur auf Wunsch, nie von selbst. Gefragt wird nach Punkten
der Erstbefragung, zu denen die Akte nichts sagt, etwa der psychischen
Verfassung in einer älteren Akte, nach abgelaufenen Fristen unter „Offen“
in `AKTE.md` und `BEURTEILUNG.md`, nach Widersprüchen und nach Quellen auf
Dateien, die es nicht gibt. Die Antworten kommen wie jede Angabe nach
`unterlagen/historie.md`. Eine abgelehnte Angabe wird als „keine Angabe“
vermerkt; danach fragt die Prüfung erst nach zwölf Monaten wieder. Form,
Doppeltes und Einträge in `BEURTEILUNG.md`, die `AKTE.md` nicht mehr trägt,
berichtigt Claude ohne Rückfrage, jeweils mit Gegenprüfung. Zum Schluss
kürzt Claude `BEURTEILUNG.md` auf das, was eine künftige Beratung braucht,
ohne eine Empfehlung oder Frist zu verlieren.

Die Prüfung selbst liest keine Befunde und keine Literatur und prüft nicht,
ob Leitlinien noch gelten. Was nur damit zu klären wäre, etwa eine Angabe
ohne Quelle oder eine Leitlinie ohne Registernummer, meldet sie mit dem,
was es beheben würde.

## Aufbau

Das Plugin enthält nur das Gerüst: Regeln, Skills, Agenten und ein
Script. Jede Akte ist ein eigenes, privates Git-Repo:

```
AKTE.md          aktueller Stand aus unterlagen/, nur Fakten mit Quelle
BEURTEILUNG.md   Empfehlungen und Einschätzungen des Modells, mit Quelle
unterlagen/      Befunde als PDF oder Foto, anamnese.md, historie.md, Messreihen als CSV
literatur/       Leitlinien und Studien als PDF und Textfassung
```

Das Plugin im Einzelnen:

- `regeln.md` – die Regeln für die Beratung; ein SessionStart-Hook spielt sie
  mit dem Stand der Akte in jede Sitzung ein.
- `skills/` – `neue-information`, `einarbeiten`, `naechste-schritte`,
  `diagnose`, `termin-vorbereiten`, `notfallpass`, `vorsorge`,
  `anamnese`.
- `agents/leitlinie.md` – sucht eine Leitlinie oder Studie, prüft ihre
  Gültigkeit, legt sie in `literatur/` ab und gibt zurück, was sie sagt.
- `agents/vorsorge.md` – stellt den Vorsorgeplan auf und gibt zurück,
  wonach der Benutzer gefragt werden muss.
- `agents/einarbeitung.md` – arbeitet Unterlagen ein, lässt gegenprüfen,
  committet; gleicht an die Vorlagen an und prüft die Akte.
- `agents/akte.md` – baut `AKTE.md` aus `unterlagen/`.
- `agents/gegenpruefung.md` – prüft eine Änderung an `AKTE.md` oder
  `BEURTEILUNG.md` vor dem Commit gegen ihre Quellen und gegen beide Dateien.
- `bin/akte-stand` – meldet, welche Unterlagen noch nicht in `AKTE.md`
  eingearbeitet sind, ob ein Bau von `AKTE.md` nicht abgeschlossen ist und
  ob `AKTE.md` und `BEURTEILUNG.md` von ihrer Vorlage abweichen.
- `vorlagen/` – Vorlagen für `AKTE.md`, `BEURTEILUNG.md` und
  `literatur/README.md`.

## Lizenz

GPL-3.0 oder später, siehe `LICENSE`.
