# patientenakte

Ein Plugin für [Claude Code](https://claude.com/claude-code), das auf
Grundlage einer persönlichen Patientenakte in medizinischen,
physiotherapeutischen und sportwissenschaftlichen Fragen berät: nach
aktuellen Leitlinien, mit Quellen und mit klarer Trennung zwischen dem, was
in Befunden steht, und dem, was ein Modell daraus schließt.

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
  `akte-aktualisieren`, `anamnese`, `leitlinie`, `neue-akte`.
- `agents/akte.md` – baut `AKTE.md` aus `unterlagen/`.
- `bin/akte-stand` – meldet, welche Unterlagen noch nicht in `AKTE.md`
  eingearbeitet sind.
- `vorlagen/` – Vorlagen für neue Akten.
- `githooks/` – Prüfung gegen eine private Sperrliste, siehe unten.

## Benutzung

Nur benutzen:

```
/plugin install patientenakte --marketplace jorgenschaefer/patientenakte
```

Wer das Plugin während einer Beratung verbessern will, bindet eine
Arbeitskopie als lokalen Marketplace ein. Claude Code lädt das Plugin dann
direkt aus der Arbeitskopie, Änderungen greifen nach `/reload-plugins`:

```bash
git clone https://github.com/jorgenschaefer/patientenakte ~/Projects/patientenakte
claude plugin marketplace add ~/Projects/patientenakte
```

In der Akte, in `.claude/settings.local.json`:

```json
{
  "enabledPlugins": { "patientenakte@patientenakte": true },
  "permissions": {
    "additionalDirectories": ["/home/<benutzer>/Projects/patientenakte"]
  }
}
```

`additionalDirectories` erlaubt Claude, in die Arbeitskopie zu schreiben.
Eine neue Akte legt der Skill `neue-akte` an („leg eine neue Akte an“).

Die Regeln sind auf Deutsch und auf das deutsche Gesundheitswesen
ausgerichtet: AWMF-Leitlinien, Nationale VersorgungsLeitlinien, STIKO.

## Am Plugin arbeiten

Das Repo ist öffentlich, die Akten nicht. Damit beim Verbessern des Plugins
nichts aus einer Akte hierher gerät, prüfen Git-Hooks jeden Commit gegen eine
Sperrliste:

```bash
git config core.hooksPath githooks
mkdir -p ~/.config/patientenakte
$EDITOR ~/.config/patientenakte/sperrliste
```

Die Sperrliste enthält einen Begriff pro Zeile: Namen der Patienten, Praxen,
Ärzte und Kliniken, markante Diagnosen und Medikamente aus allen Akten. Groß-
und Kleinschreibung zählt nicht; Zeilen mit `#` am Anfang sind Kommentare.
`pre-commit` prüft die hinzugefügten Zeilen, `commit-msg` die
Commit-Message. Fehlt die Liste, wird nicht committet; eine leere Datei
genügt, wer keine Akte hat. Ein anderer Ort lässt sich mit
`PATIENTENAKTE_SPERRLISTE` angeben.

Vor einer Veröffentlichung zusätzlich die ganze Historie prüfen:

```bash
git log -p | grep -i -F -f <(grep -v -e '^\s*$' -e '^#' ~/.config/patientenakte/sperrliste)
```

Änderungen an Skills und Agent greifen nach `/reload-plugins`, Änderungen an
`regeln.md` in einer neuen Sitzung.

## Lizenz

GPL-3.0 oder später, siehe `LICENSE`.
