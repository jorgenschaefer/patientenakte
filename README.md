# patientenakte

Ein Plugin für [Claude Code](https://claude.com/claude-code), das auf
Grundlage einer persönlichen Patientenakte in medizinischen,
physiotherapeutischen, ernährungswissenschaftlichen und
sportwissenschaftlichen Fragen berät: nach aktuellen Leitlinien, mit Quellen
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
stellt sich vor, legt `BEURTEILUNG.md`, `literatur/` und `unterlagen/` an und
beginnt mit der Erstbefragung: Stammdaten, Beschwerden, Vorerkrankungen,
Medikamente, Allergien, Impfungen, Lebensumstände, Sport und die
behandelnden Ärzte. Claude fragt nacheinander und zeigt jeden Abschnitt, bevor
er in `unterlagen/anamnese.md` eingetragen wird. Was man nicht weiß, wird als
„unbekannt“ vermerkt; was man nicht sagen will, bleibt weg.

Vorhandene Befunde kann man vorher nach `unterlagen/` legen. Claude übernimmt
daraus, was schon drinsteht, und fragt dann weniger.

Am Ende baut Claude `AKTE.md` aus der Anamnese und den Befunden. Ab dann
beginnt jede Sitzung mit einer Begrüßung, und man kann Fragen stellen, einen
Termin vorbereiten lassen oder fragen, was als Nächstes ansteht.

## Neue Befunde und Angaben

Einen neuen Befund, etwa einen MRT-Befund als PDF, gibt man Claude im
Gespräch: Pfad nennen oder Datei in den Prompt ziehen, dazu, was es ist.
Claude liest ihn, fragt nach, was zur Einordnung fehlt, legt ihn mit Datum,
Art und Absender im Namen in `unterlagen/` ab, zieht `AKTE.md` und
`BEURTEILUNG.md` nach und sagt, was sich an den nächsten Schritten ändert.
Jeder Schritt wird ein Commit in der Akte.

Ebenso im Gespräch mitteilen lassen sich Beschwerden, Ergebnisse eines
Arztgesprächs, Änderungen der Medikation und Messwerte. Claude zeigt den
Eintrag für `unterlagen/historie.md` vorher zur Bestätigung.

Liegen beim Start einer Sitzung neue Dateien in `unterlagen/`, spricht
Claude sie von sich aus an.

## Aufbau

Das Plugin enthält nur das Gerüst: Regeln, Skills, einen Agenten und ein
Script. Jede Akte ist ein eigenes, privates Git-Repo:

```
AKTE.md          aktueller Stand aus unterlagen/, nur Fakten mit Quelle
BEURTEILUNG.md   Empfehlungen und Einschätzungen des Modells, mit Quelle
unterlagen/      Befunde als PDF, anamnese.md, historie.md, Messreihen als CSV
literatur/       Leitlinien und Studien als PDF und Textfassung
```

Das Plugin im Einzelnen:

- `regeln.md` – die Regeln für die Beratung; ein SessionStart-Hook spielt sie
  in jede Sitzung ein.
- `skills/` – `neue-information`, `naechste-schritte`, `termin-vorbereiten`,
  `akte-aktualisieren`, `anamnese`, `leitlinie`.
- `agents/akte.md` – baut `AKTE.md` aus `unterlagen/`.
- `bin/akte-stand` – meldet, welche Unterlagen noch nicht in `AKTE.md`
  eingearbeitet sind.
- `vorlagen/` – Vorlagen für `BEURTEILUNG.md` und `literatur/README.md`.

## Lizenz

GPL-3.0 oder später, siehe `LICENSE`.
