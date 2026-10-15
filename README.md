# patientenakte

Ein Plugin für [Claude Code](https://claude.com/claude-code), das auf
Grundlage einer persönlichen Patientenakte in medizinischen,
physiotherapeutischen, ernährungswissenschaftlichen und
sportwissenschaftlichen Fragen berät: nach aktuellen Leitlinien, mit Quellen
und mit klarer Trennung zwischen dem, was in Befunden steht, und dem, was ein
Modell daraus schließt.

Es ersetzt keine ärztliche Behandlung. Es hilft, Befunde zu ordnen, Termine
vorzubereiten und Fragen zu stellen.

## Aufbau

Das Plugin enthält nur das Gerüst: Regeln, Skills, einen Agenten und ein
Script. Jede Akte ist ein eigenes, privates Git-Repo:

```
AKTE.md          aktueller Stand aus unterlagen/, nur Fakten mit Quelle
BEURTEILUNG.md   Empfehlungen und Einschätzungen des Modells, mit Quelle
unterlagen/      Befunde als PDF, anamnese.md, historie.md, Messreihen als CSV
literatur/       Leitlinien und Studien als PDF und Textfassung
```

**Akten gehören nie in ein öffentliches Repo.** Sie enthalten
Gesundheitsdaten.

Das Plugin im Einzelnen:

- `regeln.md` – die Regeln für die Beratung; ein SessionStart-Hook spielt sie
  in jede Sitzung ein.
- `skills/` – `neue-information`, `naechste-schritte`, `termin-vorbereiten`,
  `akte-aktualisieren`, `anamnese`, `leitlinie`.
- `agents/akte.md` – baut `AKTE.md` aus `unterlagen/`.
- `bin/akte-stand` – meldet, welche Unterlagen noch nicht in `AKTE.md`
  eingearbeitet sind.
- `vorlagen/` – Vorlagen für `BEURTEILUNG.md` und `literatur/README.md`.

## Benutzung

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
claude
```

`--scope local` trägt das Plugin in `.claude/settings.local.json` der Akte
ein. In der ersten Sitzung beginnt Claude mit dem Skill `anamnese`. Er legt
`BEURTEILUNG.md`, `literatur/` und `unterlagen/` an und führt durch die
Erstbefragung.

Ein Remote für die Akte nur privat anlegen, etwa mit
`gh repo create akte-<name> --private --source .`.

### Neue Befunde und Angaben

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

### Mit einer Arbeitskopie des Plugins

Wer das Plugin während einer Beratung verbessern will, fügt statt des
GitHub-Repos eine Arbeitskopie als Marketplace hinzu. Claude Code lädt das
Plugin dann direkt aus der Arbeitskopie:

```bash
git clone https://github.com/jorgenschaefer/patientenakte ~/Projects/patientenakte
claude plugin marketplace add ~/Projects/patientenakte
```

Damit Claude in die Arbeitskopie schreiben darf, in der Akte zusätzlich in
`.claude/settings.local.json`:

```json
{
  "permissions": {
    "additionalDirectories": ["/home/<benutzer>/Projects/patientenakte"]
  }
}
```

Die Regeln sind auf Deutsch und auf das deutsche Gesundheitswesen
ausgerichtet: AWMF-Leitlinien, Nationale VersorgungsLeitlinien, STIKO.

## Am Plugin arbeiten

Das Repo ist öffentlich und enthält nie Daten aus einer Akte; Beispiele
werden erfunden oder allgemein formuliert.

Änderungen an Skills und Agent greifen nach `/reload-plugins`, Änderungen an
`regeln.md` in einer neuen Sitzung.

## Lizenz

GPL-3.0 oder später, siehe `LICENSE`.
