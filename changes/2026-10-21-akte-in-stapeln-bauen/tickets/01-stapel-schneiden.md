---
criteria:  CRITERIA.md
closes:    AC-3, AC-14, AC-15
advances:  AC-1, AC-2, AC-13, AC-19
after:
status:    done
attempts:  1
---

## Build
`akte-stand --stapel`: zählt die Seiten der Unterlagen, ordnet die Einheiten nach Datum und teilt sie in Stapel. Dazu schreibt `neue-information` neue Einträge in `historie.md` unter eine Datumsüberschrift, die `--stapel` liest.

## Done when
> **AC-3** Die Reihenfolge folgt dem Datum: Befunde nach dem Datum vorn im Dateinamen, die Tage in `historie.md` nach ihrer Überschrift `## TT.MM.JJJJ`, `anamnese.md` nach dem letzten Datum in ihrer Kopfzeile und ohne Datum dort nach ihrem ersten Commit. Bei gleichem Datum kommen erst Befunde, dann `anamnese.md`, dann `historie.md`. Text vor der ersten Überschrift `## TT.MM.JJJJ` gehört zum ersten Tag. Nach allen datierten Einheiten kommen die Dateien ohne Datum im Namen, danach die CSVs, aufgeteilt wie in AC-2.

> **AC-14** Ein neuer Eintrag in `historie.md` steht unter einer Überschrift `## TT.MM.JJJJ` mit dem Datum der Mitteilung; gibt es die Überschrift schon, darunter.

> **AC-15** Die Grenze von 20 Seiten und die 10.000 Zeichen je Seite stehen je an genau einer Stelle; ändert man dort einen Wert, schneidet `akte-stand --stapel` nach AC-2 mit dem neuen Wert.

Zu den ACs unter „Toward“:

- AC-1: `akte-stand --stapel` zählt die Seiten so, und liegen alle Unterlagen zusammen bei höchstens 20 Seiten, gibt es genau einen Stapel aus.
- AC-2: `akte-stand --stapel` schneidet die Stapel so; gebaut wird damit noch nichts.
- AC-13: `akte-stand --stapel` stellt ein PDF ohne bestimmbare Seitenzahl in einen eigenen Stapel und gibt die Zeile `Seitenzahl unbekannt: <pfad>` aus; `historie.md` ohne Datumsüberschrift ist eine Einheit an der Stelle der Dateien ohne Datum, und die Ausgabe endet mit `historie.md ohne Datumsüberschriften.`
- AC-19: Ohne `pdfinfo` bricht `akte-stand --stapel` mit Exit-Code 1 und einer Meldung auf stderr ab, die poppler-utils nennt.

## Toward
> **AC-1** Die Seiten einer Unterlage werden so gezählt: eine PDF-Seite als eine Seite, ein Bild als eine Seite, eine Textdatei je angefangene 10.000 Zeichen als eine Seite. Liegen alle Unterlagen zusammen bei höchstens 20 Seiten, läuft ein vollständiger Bau in einem einzigen Lauf des Subagenten `akte` mit einer Gegenprüfung.

> **AC-2** Liegen sie darüber, wird in Stapeln gebaut: Die Einheiten kommen in der Reihenfolge aus AC-3 nacheinander in einen Stapel, bis die nächste ihn über 20 Seiten brächte; mit ihr beginnt der nächste Stapel. Eine Einheit ist eine Datei oder ein Tag in `historie.md`. Sie wird nie auf zwei Stapel geteilt; eine Einheit über 20 Seiten bildet einen Stapel für sich. Ein Tag in `historie.md` zählt anteilig, seine Zeichen geteilt durch 10.000 ohne Aufrunden; aufgerundet wird erst die Seitenzahl eines Stapels.

> **AC-13** Ein PDF, dessen Seitenzahl sich nicht bestimmen lässt, bildet einen eigenen Stapel, und die Rückmeldung nennt es. Hat `historie.md` keine Überschrift `## TT.MM.JJJJ`, ist sie eine einzige Einheit an der Stelle der Dateien ohne Datum, und die Rückmeldung nennt das.

> **AC-19** Fehlt `pdfinfo`, bricht `akte-stand --stapel` mit einer Meldung ab, die poppler-utils nennt und mit einem Exit-Code ungleich 0, und `akte-nachziehen` meldet, dass der vollständige Bau nicht gelaufen ist.

## Technical decisions
> **Stored formats** In der Akte kommt keine committete Datei hinzu. Zwischenfassungen liegen unter `.git/akte-bau/` der Akte, nie committet und nicht in `git status`; ein Bau leert das Verzeichnis zu Beginn und am Ende. Die Kontrolle legt ihre zweite Fassung ebenfalls dort ab statt in `mktemp`. Die Überschrift `## TT.MM.JJJJ` über den Einträgen in `historie.md` wird vorgeschrieben, in `skills/neue-information/SKILL.md`; bestehende Einträge ohne sie werden nicht umgeschrieben (AC-13). Die Kopfzeile von `anamnese.md` bleibt, wie sie `skills/anamnese/SKILL.md` vorgibt.

> **Wire formats** Neu ist `akte-stand --stapel`. Es gibt je Stapel eine Zeile `Stapel N (S Seiten)` aus, darunter je Einheit eine Zeile, eine Datei als Pfad, ein Teil von `historie.md` als `unterlagen/historie.md TT.MM.JJJJ–TT.MM.JJJJ`; Stapel durch eine Leerzeile getrennt. Danach je PDF ohne Seitenzahl eine Zeile `Seitenzahl unbekannt: <pfad>` und, wenn `historie.md` keine Datumsüberschrift hat, die Zeile `historie.md ohne Datumsüberschriften.` Ohne `pdfinfo` Exit-Code 1 und eine Meldung auf stderr. Der Auftrag an den Subagenten `akte` bekommt die Art „Stapel“ mit Zieldatei und den Einheiten eines Stapels. Der Auftrag an `aenderung-gegenpruefen` kann statt `HEAD` eine Vorfassung als Pfad nennen, Quellen als Einheiten wie in `--stapel`, und bekommt die Art „Abgleich mit der vorigen Fassung“. Bisherige Aufrufe von `akte-stand` und bisherige Aufträge bleiben gültig.

> **Trust boundaries** Keine neuen. `pdfinfo` liest die Befunde lokal, wie heute schon `pdftotext` im Subagenten `akte`. Zwischenfassungen enthalten Gesundheitsdaten und bleiben in der Akte, unter `.git/`, auch wenn ein Bau abbricht.

> **Dependencies** `pdfinfo` aus poppler-utils für `akte-stand` und `tests/check.sh`; das README nennt es. Kein Werkzeug zum Erzeugen von PDFs.

## Nudges
> Wie Stapel geschnitten werden, steht nur in `bin/akte-stand`; die Agenten verwenden nur dessen Ausgabe.

> `seiten_je_stapel=20` und `zeichen_je_seite=10000` stehen oben in `bin/akte-stand` neben `akte=AKTE.md`. Die Tests überschreiben sie nicht, sondern erzeugen große Textdateien und schreiben kleine PDFs mit mehreren Seiten selbst, mit `printf` im Test.

> Das README zieht nach: „Die Akte prüfen“, die Beschreibung von `akte-stand` und die Abhängigkeit.

## Context
`bin/akte-stand` kennt heute den Aufruf ohne Argument, `--aktualisieren` und `--vorlage`; die Tests stehen in `tests/akte-stand.sh`, je Fall eine eigene Akte in einem temporären Verzeichnis, und `tests/check.sh` führt sie aus. Die Befunde heißen nach `skills/neue-information/SKILL.md` `JJJJ-MM-TT-<art>_<absender>.<endung>`; die Kopfzeile von `anamnese.md` ist nach `skills/anamnese/SKILL.md` `*Erstbefragung vom TT.MM.JJJJ, …*`. `historie.md` hat heute keine Datumsüberschriften; `neue-information` hängt Einträge nur an.

Ticket 02 baut auf der Ausgabe von `--stapel` auf, genau im Wire format oben. Mehrere Tage von `historie.md`, die im selben Stapel ohne andere Einheit dazwischen aufeinander folgen, stehen auf einer Zeile `unterlagen/historie.md <erster Tag>–<letzter Tag>`; ein einzelner Tag hat dasselbe Datum auf beiden Seiten. Eine Zeile, deren Bereich mit dem ersten Tag beginnt, umfasst auch den Text vor der ersten Überschrift. Eine `historie.md` ohne Datumsüberschrift steht als Pfad allein auf ihrer Zeile.

Die README-Teile dieses Tickets: die Beschreibung von `bin/akte-stand` unter „Das Plugin“ nennt `--stapel`, und das README nennt `pdfinfo` aus poppler-utils als Abhängigkeit. „Die Akte prüfen“ zieht Ticket 02 nach.

## Not here
- Alles, was die Ausgabe von `--stapel` verwendet – `einarbeiten`, `akte-nachziehen`, `akte`, `aenderung-gegenpruefen` und der Abschnitt „Die Akte prüfen“ im README – baut Ticket 02.
- Die Meldung von `akte-nachziehen`, dass der vollständige Bau ohne `pdfinfo` nicht gelaufen ist, und die Nennung in der Rückmeldung zu AC-13: Ticket 02.
- Bestehende Einträge in `historie.md` ohne Überschrift werden nicht umgeschrieben.

## Left standing

**Fixes after the last review** (no reviewer saw them):
- The test `stapel_anamnese_ohne_kopfzeile` now puts the bold date line directly under the title. This answers round 2's should-fix that nothing pinned the rule "the header line must be italic". Loosening that rule now fails the test.
- The README and the `pdfinfo` error message no longer say `brew install poppler`. This answers round 2's should-fix (round 1 rated it a nit): `--stapel` needs bash ≥ 4 (`local -A`, `${1,,}`) and the `C.UTF-8` locale, so stock macOS cannot run it. `--stapel` is still not portable to macOS; the existing script already relies on GNU tools there (`sha256sum`, `xargs -r`).
- The paragraph in `skills/neue-information/SKILL.md` is reflowed (round 2 nit).

**Not proven by an automated test:** AC-14 is only a rule in `skills/neue-information/SKILL.md`: the date heading of the message, and an entry going under a heading that already exists. I checked it by reading the text. No test drives a session through the skill.

**Decisions that would be costly to reverse** (ticket 02 reads this output):
- An unreadable PDF's batch header is `Stapel N (? Seiten)`. The wire format only says `S Seiten`, and there is no number to give.
- The header always says `Seiten`, even for 1 (`Stapel 2 (1 Seiten)`), exactly as the wire format has it.
- The notes (`Seitenzahl unbekannt: …`, `historie.md ohne Datumsüberschriften.`) are separated from the last batch by a blank line.
- The date range uses an en dash `–`.
- **Text before the first heading** belongs to the earliest day, not to the first heading in the file. The two are the same when `historie.md` is in order. This matches ticket 02's reading ("a line whose range begins with the first day").
- **Several headings with the same date** are one day, i.e. one unit. So a range never stands for two separate units.
- **The header line of `anamnese.md`** is the first non-empty line after the `# ` title, if it is italic (`*…`, not `**`). The date of its first commit comes from `git log --diff-filter=A`, author date. With neither a header date nor a commit, `anamnese.md` sits with the files that have no date.
- **CSVs always come last**, even with a date in the name.
- **What counts as what:**
  - An image is `.jpg`/`.jpeg`/`.png`, in any case.
  - A PDF is `.pdf` in any case.
  - Every other file counts as text, by characters.
  - A day in `historie.md` counts its heading and line endings, so its days add up to the file.
- `--stapel` sets `LC_ALL=C.UTF-8` so that it counts characters, not bytes. It needs that locale and bash ≥ 4.

**Departure from a nudge:** the nudge says tests do not override `seiten_je_stapel`/`zeichen_je_seite`. `stapel_grenzen_einstellbar` (AC-15) does: it rewrites both in a copy of the script with `sed`, because AC-15 is about changing exactly that place. All other tests use real sizes, as the nudge says.

**Names not taken from a glossary** (the project has no `UBIQUITOUS_LANGUAGE.md`; identifiers are German, like the rest of `bin/akte-stand`, not English as the coding standard asks): `stapel`, `einheiten`, `historie_tage`, `sortierschluessel`, `gewicht`, `anamnese_datum`, `kopfzeilen_datum`, `stapel_schneiden`, and the variable `historie`. `seiten_je_stapel` and `zeichen_je_seite` come from the nudge.
