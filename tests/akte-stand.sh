#!/usr/bin/env bash
# Tests für bin/akte-stand und für das, was hooks/regeln-einspielen und
# hooks/stand-einspielen beim Start einer Sitzung ausgeben. Jeder Fall baut
# eine Akte in einem eigenen temporären Verzeichnis, das am Ende gelöscht
# wird.
#
#   tests/akte-stand.sh
set -uo pipefail

wurzel=$(cd "$(dirname "$0")/.." && pwd)
stand=$wurzel/bin/akte-stand
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# Ohne Einfluss der Git-Konfiguration des Benutzers, und kein Repo oberhalb
# von $tmp darf als Akte gelten.
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1 GIT_CEILING_DIRECTORIES=$tmp
export GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@t GIT_COMMITTER_NAME=t GIT_COMMITTER_EMAIL=t@t

nicht_abgeschlossen='AKTE.md oder kapitel/ hat Änderungen ohne Commit aus einem Bau, der nicht abgeschlossen ist.'
auf_dem_stand='AKTE.md und kapitel/ sind auf dem Stand von unterlagen/.'
bisheriger_aufbau='Die Akte hat den bisherigen Aufbau mit BEURTEILUNG.md und weicht vom neuen Aufbau aus AKTE.md und kapitel/ ab.'
bisheriger_aufbau_nicht_abgeschlossen='AKTE.md hat Änderungen ohne Commit aus einem Bau, der nicht abgeschlossen ist.'
nicht_eingebunden='.claude/CLAUDE.md bindet den Überblick AKTE.md nicht ein.'
umstellung_nicht_abgeschlossen='Eine Umstellung auf den neuen Aufbau ist nicht abgeschlossen.'
# Claude Code übernimmt die Ausgabe eines Hooks nur bis etwa 10.000 Zeichen
# ganz in den Kontext; längere ersetzt es durch ihre ersten 2 KB und den
# Pfad einer Datei. Gemessen: 9.890 Zeichen ganz, 10.672 gekürzt.
grenze_hook=9500
fehler=0

main() {
  commit_vor_der_liste
  akte_commit_ohne_pruefsummen
  auf_dem_stand
  neu_und_entfernt
  pruefsummen_nicht_committet
  gebaut_nicht_abgeschlossen
  neue_akte_nie_committet
  bau_in_stapeln_abgebrochen
  ohne_git
  kapitel_ohne_commit
  bisheriger_aufbau_eingearbeitet
  bisheriger_aufbau_auf_dem_stand
  bisheriger_aufbau_nicht_abgeschlossen
  umstellung_begonnen
  umstellung_beurteilung_entfernt
  ueberblick_fehlt
  ueberblick_nicht_eingebunden
  ueberblick_hoechstlaenge
  kapitel_hoechstlaenge
  hoechstlaengen_einstellbar
  verweise_ins_leere
  literatur_ohne_datei
  literatur_ohne_zeile
  literatur_zeile_unvollstaendig
  literatur_ohne_uebersicht
  fristen_vorbei
  fristen_ohne_datum
  zwischenstand_pruefen
  zwischenstand_bei_der_umstellung
  start_meldet_baum
  start_meldet_fehlenden_ueberblick
  start_meldet_bisherigen_aufbau
  start_hooks_eingetragen
  start_regeln_ganz
  start_stand_unter_der_grenze
  vorlage_eingehalten
  vorlage_abweichend
  vorlage_fristen_ohne_datum
  vorlage_bisheriger_aufbau
  stapel_einer
  stapel_geschnitten
  stapel_bilder
  stapel_reihenfolge
  stapel_anamnese_ohne_datum
  stapel_anamnese_ohne_kopfzeile
  stapel_historie_tage
  stapel_historie_anteilig
  stapel_historie_vorab
  stapel_seitenzahl_unbekannt
  stapel_historie_ohne_ueberschrift
  stapel_beurteilung_tage
  stapel_beurteilung_ohne_ueberschrift
  stapel_ohne_pdfinfo
  stapel_ohne_pdf_ohne_pdfinfo
  stapel_grenzen_einstellbar
  einheit_tage
  einheit_vorab
  einheit_beurteilung
  einheit_ohne_beurteilung
  einheit_falscher_aufruf
  einheit_ohne_historie
  einheit_ohne_abschnitt
  exit $fehler
}

commit_vor_der_liste() {
  neue_akte
  bauen
  local x
  x=$(git rev-parse --short HEAD)
  echo zwei >> unterlagen/a.md && git commit -qam a2
  echo drei >> unterlagen/a.md && git commit -qam a3
  pruefe "Commit vor der Liste" "Eingearbeitet bis Commit $x.
geändert: unterlagen/a.md" "$("$stand")"
  pruefe "Diff ab dem Commit zeigt beide Änderungen" "+zwei
+drei" "$(git diff "$x" -- unterlagen/a.md | grep '^+[a-z]')"
}

akte_commit_ohne_pruefsummen() {
  neue_akte
  bauen
  local x
  x=$(git rev-parse --short HEAD)
  echo zwei >> unterlagen/a.md && git commit -qam a2
  echo Text >> AKTE.md && git commit -qam text
  echo Text >> kapitel/grundlage.md && git commit -qam text
  pruefe "Commit an AKTE.md ohne Prüfsummen verschiebt nichts" "Eingearbeitet bis Commit $x.
geändert: unterlagen/a.md" "$("$stand")"
}

auf_dem_stand() {
  neue_akte
  bauen
  pruefe "Auf dem Stand" "$auf_dem_stand" "$("$stand")"
}

neu_und_entfernt() {
  neue_akte
  bauen
  echo b > unterlagen/b.md && git rm -q unterlagen/a.md
  git add unterlagen && git commit -qm umbau
  pruefe "Neue und entfernte Unterlagen" "Eingearbeitet bis Commit $(git rev-parse --short HEAD~1).
entfernt: unterlagen/a.md
neu: unterlagen/b.md" "$("$stand")"
}

pruefsummen_nicht_committet() {
  neue_akte
  "$stand" --aktualisieren
  echo zwei >> unterlagen/a.md
  pruefe "Prüfsummen nicht committet" "$nicht_abgeschlossen
geändert: unterlagen/a.md" "$("$stand")"
}

gebaut_nicht_abgeschlossen() {
  neue_akte
  bauen
  echo zwei >> unterlagen/a.md && git commit -qm a2 -- unterlagen/a.md
  "$stand" --aktualisieren
  pruefe "Gebaut, nicht abgeschlossen" "$nicht_abgeschlossen" "$("$stand")"
  echo drei >> unterlagen/a.md && git commit -qm a3 -- unterlagen/a.md
  pruefe "Nicht abgeschlossen, ohne Commit-Zeile" "$nicht_abgeschlossen
geändert: unterlagen/a.md" "$("$stand")"
}

neue_akte_nie_committet() {
  neues_verzeichnis
  git init -q
  mkdir unterlagen && echo eins > unterlagen/a.md
  git add . && git commit -qm unterlagen
  printf '# Akte\n' > AKTE.md && "$stand" --aktualisieren
  pruefe "Neue AKTE.md, nie committet" "$nicht_abgeschlossen
$nicht_eingebunden" "$("$stand")"
}

bau_in_stapeln_abgebrochen() {
  neue_akte
  bauen
  mkdir .git/akte-bau && printf '# Akte\nZwischenfassung\n' > .git/akte-bau/stapel-1.md
  pruefe "Zwischenfassungen unter .git/akte-bau/ sind kein offener Bau" \
    "$auf_dem_stand" "$("$stand")"
  pruefe "Zwischenfassungen stehen nicht in git status" "" "$(git status --porcelain)"
}

ohne_git() {
  neues_verzeichnis
  mkdir unterlagen && echo eins > unterlagen/a.md
  printf '# Akte\n' > AKTE.md && "$stand" --aktualisieren
  echo zwei >> unterlagen/a.md
  pruefe "Ohne Git" "geändert: unterlagen/a.md" "$("$stand" 2>&1)"
}

kapitel_ohne_commit() {
  neue_akte
  bauen
  echo Text > kapitel/knie.md
  pruefe "Ein Kapitel ohne Commit ist ein nicht abgeschlossener Bau" "$nicht_abgeschlossen" "$("$stand")"
}

bisheriger_aufbau_eingearbeitet() {
  alte_akte
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
  local x
  x=$(git rev-parse --short HEAD)
  echo zwei >> unterlagen/a.md && git commit -qam a2
  pruefe "Bisheriger Aufbau: Prüfsummen am Ende von AKTE.md" "$bisheriger_aufbau
Eingearbeitet bis Commit $x.
geändert: unterlagen/a.md" "$("$stand")"
  pruefe "Bisheriger Aufbau: kein kapitel/" "" "$([[ ! -e kapitel ]] || echo 'kapitel/ angelegt')"
}

bisheriger_aufbau_auf_dem_stand() {
  alte_akte
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
  echo zwei >> unterlagen/a.md && git commit -qam a2
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
  pruefe "Bisheriger Aufbau: auf dem Stand" "$bisheriger_aufbau
AKTE.md ist auf dem Stand von unterlagen/." "$("$stand")"
  pruefe "Bisheriger Aufbau: Prüfsummen ersetzt, nicht angehängt" 1 "$(grep -c '^## Grundlage$' AKTE.md)"
}

bisheriger_aufbau_nicht_abgeschlossen() {
  alte_akte
  "$stand" --aktualisieren
  pruefe "Bisheriger Aufbau: nicht abgeschlossener Bau" "$bisheriger_aufbau
$bisheriger_aufbau_nicht_abgeschlossen" "$("$stand")"
}

# Die Umstellung legt als Erstes den ersten Eintrag der Beurteilung an, mit
# diesem Anlass; ein Eintrag aus dem Gespräch zählt nicht.
umstellung_begonnen() {
  alte_akte
  echo Anamnese > unterlagen/anamnese.md && git add unterlagen && git commit -qm anamnese
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
  printf '# Beurteilung\n\n## 01.03.2025\n\n*Einschätzung eines Modells, nicht ärztlich bestätigt; Anlass: Gespräch über das Knie.*\n' > unterlagen/beurteilung.md
  pruefe "Umstellung: Eintrag aus dem Gespräch ist kein Beginn" 0 "$("$stand" | grep -cxF "$umstellung_nicht_abgeschlossen")"
  printf '\n*Einschätzung eines Modells, nicht ärztlich bestätigt; Anlass: Umstellung von BEURTEILUNG.md.*\n' >> unterlagen/beurteilung.md
  pruefe "Umstellung begonnen, ohne Commit" "$bisheriger_aufbau
$umstellung_nicht_abgeschlossen
Eingearbeitet bis Commit $(git rev-parse --short HEAD).
neu: unterlagen/beurteilung.md" "$("$stand")"
  git add unterlagen && git commit -qm beurteilung
  pruefe "Umstellung begonnen, committet" 1 "$("$stand" | grep -cxF "$umstellung_nicht_abgeschlossen")"
  pruefe "Start: Umstellung nicht abgeschlossen" 1 "$(start_der_sitzung | grep -cxF "$umstellung_nicht_abgeschlossen")"
}

# Die Umstellung entfernt BEURTEILUNG.md vor dem Commit des Baums; bricht
# sie dazwischen ab, bleibt es der bisherige Aufbau, aber die Prüfsummen
# kommen schon nach kapitel/grundlage.md.
umstellung_beurteilung_entfernt() {
  alte_akte
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
  git rm -q BEURTEILUNG.md
  pruefe "Umstellung: BEURTEILUNG.md nur in HEAD ist bisheriger Aufbau" 1 "$("$stand" | grep -cxF "$bisheriger_aufbau")"
  "$stand" --aktualisieren
  pruefe "Umstellung: Prüfsummen in kapitel/grundlage.md, AKTE.md unverändert" "1 0" \
    "$(grep -c '^[0-9a-f]\{64\}  unterlagen/a.md$' kapitel/grundlage.md) $(git diff --name-only -- AKTE.md | wc -l)"
}

ueberblick_fehlt() {
  neues_verzeichnis
  git init -q
  mkdir unterlagen && echo eins > unterlagen/a.md
  git add . && git commit -qm unterlagen
  pruefe "Überblick fehlt" "Der Überblick AKTE.md fehlt.
neu: unterlagen/a.md" "$("$stand")"
}

# Den Überblick bringt .claude/CLAUDE.md in jede Sitzung; ohne die Zeile
# @../AKTE.md beriete die Sitzung ohne ihn.
ueberblick_nicht_eingebunden() {
  neue_akte
  bauen
  printf '*Eigene Notizen.*\n' > .claude/CLAUDE.md && git commit -qam eigene
  pruefe "Überblick nicht eingebunden" "$auf_dem_stand
$nicht_eingebunden" "$("$stand")"
  rm -r .claude && git commit -qam weg
  pruefe "Ohne .claude/CLAUDE.md" "$auf_dem_stand
$nicht_eingebunden" "$("$stand")"
}

ueberblick_hoechstlaenge() {
  neue_akte
  woerter 2000 > AKTE.md
  bauen
  pruefe "Überblick mit 2000 Wörtern" "$auf_dem_stand" "$("$stand")"
  woerter 2001 > AKTE.md && git commit -qam länger
  pruefe "Überblick mit 2001 Wörtern" "$auf_dem_stand
AKTE.md hat 2001 Wörter, mehr als die Höchstlänge von 2000." "$("$stand")"
}

# grundlage.md ist kein Kapitel und zählt nicht, so lang sie auch ist.
kapitel_hoechstlaenge() {
  neue_akte
  mkdir -p kapitel/knie
  woerter 1500 > kapitel/knie.md
  woerter 1501 > kapitel/ruecken.md
  woerter 1501 > kapitel/knie/meniskus.md
  "$stand" --aktualisieren
  woerter 1600 >> kapitel/grundlage.md
  git add kapitel && git commit -qm bau
  pruefe "Kapitel und Unterkapitel über der Höchstlänge" "$auf_dem_stand
kapitel/knie/meniskus.md hat 1501 Wörter, mehr als die Höchstlänge von 1500.
kapitel/ruecken.md hat 1501 Wörter, mehr als die Höchstlänge von 1500." "$("$stand")"
}

hoechstlaengen_einstellbar() {
  neue_akte
  mkdir bin
  sed -e 's/^woerter_ueberblick=2000$/woerter_ueberblick=3/' \
    -e 's/^woerter_kapitel=1500$/woerter_kapitel=2/' "$stand" > bin/akte-stand
  chmod +x bin/akte-stand
  mkdir kapitel
  woerter 4 > AKTE.md
  woerter 3 > kapitel/knie.md
  bin/akte-stand --aktualisieren
  git add AKTE.md kapitel && git commit -qm bau
  pruefe "Höchstlängen an einer Stelle einstellbar" "$auf_dem_stand
AKTE.md hat 4 Wörter, mehr als die Höchstlänge von 3.
kapitel/knie.md hat 3 Wörter, mehr als die Höchstlänge von 2." "$(bin/akte-stand)"
  pruefe "Die Höchstlängen stehen sonst nirgends" "woerter_ueberblick=2000
woerter_kapitel=1500" "$(grep -Ew '2000|1500|2\.000|1\.500' "$stand")"
}

verweise_ins_leere() {
  neue_akte
  mkdir -p kapitel
  cat > AKTE.md <<'MD'
# Akte

[Knie](kapitel/knie.md), [fehlt](kapitel/fehlt.md) und [Abschnitt](kapitel/knie.md#meniskus).
[Befund](unterlagen/a.md "Titel"), [Leitlinie](https://register.awmf.org/x), [oben](#akte).
![Bild](unterlagen/bild.png), [Klammern](<kapitel/knie.md>), [Klammern fehlt](<kapitel/ohne datei.md> "Titel").
MD
  cat > kapitel/knie.md <<'MD'
# Knie

[Befund](../unterlagen/a.md), [Meniskus](knie/meniskus.md), [falsch](unterlagen/a.md).
MD
  bauen
  pruefe "Verweise ins Leere" "$auf_dem_stand
Verweis ins Leere in AKTE.md: kapitel/fehlt.md
Verweis ins Leere in AKTE.md: unterlagen/bild.png
Verweis ins Leere in AKTE.md: kapitel/ohne datei.md
Verweis ins Leere in kapitel/knie.md: knie/meniskus.md
Verweis ins Leere in kapitel/knie.md: unterlagen/a.md" "$("$stand")"
}

literatur_ohne_datei() {
  neue_akte
  literatur_mit_uebersicht
  mkdir -p kapitel unterlagen
  cat > AKTE.md <<'MD'
# Akte

- Knie [literatur/leitlinie Empfehlung 1; literatur/fehlt-im-akte § 2]
- Muster [literatur/<Dateiname ohne Endung> <Stelle>], [historie 01.01.2026]
MD
  cat > kapitel/knie.md <<'MD'
# Knie

- [literatur/seiten Startseite], [literatur/fehlt-im-kapitel], [literatur/fehlt-im-kapitel 2]
MD
  printf '# Beurteilung

- **Knie – Einschätzung:** A. Grund: B [literatur/fehlt-in-der-beurteilung 3].
' > unterlagen/beurteilung.md
  git add . && git commit -qm literatur
  bauen
  pruefe "Quellen ohne Datei in literatur/" "$auf_dem_stand
Quelle ohne Datei in AKTE.md: literatur/fehlt-im-akte
Quelle ohne Datei in kapitel/knie.md: literatur/fehlt-im-kapitel
Quelle ohne Datei in unterlagen/beurteilung.md: literatur/fehlt-in-der-beurteilung" "$("$stand")"
}

literatur_ohne_zeile() {
  neue_akte
  literatur_mit_uebersicht
  : > literatur/ohne-zeile.pdf
  : > literatur/ohne-zeile.txt
  mkdir literatur/ordner-ohne-zeile
  bauen
  pruefe "Quellen ohne Zeile in literatur/README.md" "$auf_dem_stand
Quelle ohne Zeile in literatur/README.md: literatur/ohne-zeile
Quelle ohne Zeile in literatur/README.md: literatur/ordner-ohne-zeile" "$("$stand")"
}

literatur_zeile_unvollstaendig() {
  neue_akte
  literatur_mit_uebersicht
  : > literatur/leer.pdf
  : > literatur/kurz.pdf
  : > literatur/neu.pdf
  : > literatur/neu-ohne-vermerk.pdf
  cat >> literatur/README.md <<'MD'
| `leer` | Quelle |  | bis 2030 | 01.01.2026 | 01.01.2026 |  |
| `kurz` | Quelle | 2026 | bis 2030 |
| `neu` | Quelle | 2026 | nicht prüfbar am 01.01.2026: gesperrt | 01.01.2026 |  | [Seite](https://x) |
| `neu-ohne-vermerk` | Quelle | 2026 | bis 2030 | 01.01.2026 |  | [Seite](https://x) |
MD
  bauen
  pruefe "Zeilen in literatur/README.md mit leeren Spalten" "$auf_dem_stand
Zeile in literatur/README.md ohne Version / Stand: leer
Zeile in literatur/README.md ohne Herkunft: leer
Zeile in literatur/README.md ohne Abgerufen: kurz
Zeile in literatur/README.md ohne Geprüft: kurz
Zeile in literatur/README.md ohne Herkunft: kurz
Zeile in literatur/README.md ohne Geprüft: neu-ohne-vermerk" "$("$stand")"
}

literatur_ohne_uebersicht() {
  neue_akte
  mkdir literatur
  : > literatur/leitlinie.pdf
  printf '# Akte

- [literatur/fehlt]
' > AKTE.md
  bauen
  pruefe "literatur/ ohne README.md" "$auf_dem_stand
Quelle ohne Datei in AKTE.md: literatur/fehlt
literatur/README.md fehlt." "$("$stand")"
}

fristen_vorbei() {
  neue_akte
  printf '# Akte

## Fristen bis 01.01.2000
' > AKTE.md
  bauen
  pruefe "Fristen vorbei" "$auf_dem_stand
Die Fristen in AKTE.md reichen bis 01.01.2000; das Datum ist vorbei." "$("$stand")"
  printf '# Akte

## Fristen bis %s
' "$(date -d yesterday +%d.%m.%Y)" > AKTE.md
  git commit -qam gestern
  pruefe "Fristen bis gestern" "$auf_dem_stand
Die Fristen in AKTE.md reichen bis $(date -d yesterday +%d.%m.%Y); das Datum ist vorbei." "$("$stand")"
  printf '# Akte

## Fristen bis %s
' "$(date +%d.%m.%Y)" > AKTE.md
  git commit -qam heute
  pruefe "Fristen bis heute sind nicht vorbei" "$auf_dem_stand" "$("$stand")"
}

fristen_ohne_datum() {
  neue_akte
  printf '# Akte\n\n## Fristen bis 1.1.2026\n' > AKTE.md
  bauen
  pruefe "Fristen ohne lesbares Datum" "$auf_dem_stand
Die Überschrift der Fristen in AKTE.md nennt kein Datum als TT.MM.JJJJ: ## Fristen bis 1.1.2026" "$("$stand")"
  printf '# Akte\n\n## Fristen\n' > AKTE.md
  git commit -qam ohne
  pruefe "Fristen ganz ohne Datum" "$auf_dem_stand
Die Überschrift der Fristen in AKTE.md nennt kein Datum als TT.MM.JJJJ: ## Fristen" "$("$stand")"
  printf '# Akte\n\n## Fristen bis 31.13.2099\n' > AKTE.md
  git commit -qam monat
  pruefe "Fristen mit einem Datum, das es nicht gibt" "$auf_dem_stand
Die Überschrift der Fristen in AKTE.md nennt kein Datum als TT.MM.JJJJ: ## Fristen bis 31.13.2099" "$("$stand")"
  printf '# Akte\n\n## Fristen bis 01.01.2000' > AKTE.md
  git commit -qam zeilenende
  pruefe "Fristen in der letzten Zeile ohne Zeilenende" "$auf_dem_stand
Die Fristen in AKTE.md reichen bis 01.01.2000; das Datum ist vorbei." "$("$stand")"
}

# Der Neubau prüft seinen Zwischenstand unter .git/akte-bau/ mit akte-stand
# in dessen Verzeichnis: Höchstlängen, Verweise und Fristen wie im Baum.
zwischenstand_pruefen() {
  neue_akte
  bauen
  mkdir -p .git/akte-bau/stapel-1/kapitel
  cd .git/akte-bau/stapel-1 || return
  printf '# Akte\n\n[Knie](kapitel/knie.md)\n\n## Fristen bis TT.MM.JJJJ\n' > AKTE.md
  woerter 1501 > kapitel/messwerte.md
  pruefe "Zwischenstand prüfen" "AKTE.md und kapitel/ sind auf dem Stand von unterlagen/.
kapitel/messwerte.md hat 1501 Wörter, mehr als die Höchstlänge von 1500.
Verweis ins Leere in AKTE.md: kapitel/knie.md
Die Überschrift der Fristen in AKTE.md nennt kein Datum als TT.MM.JJJJ: ## Fristen bis TT.MM.JJJJ" "$("$stand")"
}

# Der Neubau bei der Umstellung prüft seinen Zwischenstand als Baum, obwohl
# HEAD noch BEURTEILUNG.md hat.
zwischenstand_bei_der_umstellung() {
  alte_akte
  mkdir -p .git/akte-bau/abschluss/kapitel
  cd .git/akte-bau/abschluss || return
  printf '# Akte\n\n[Knie](kapitel/knie.md)\n' > AKTE.md
  pruefe "Zwischenstand bei der Umstellung" "AKTE.md und kapitel/ sind auf dem Stand von unterlagen/.
Verweis ins Leere in AKTE.md: kapitel/knie.md" "$("$stand")"
}

start_meldet_baum() {
  neue_akte
  echo Anamnese > unterlagen/anamnese.md
  mkdir kapitel
  woerter 1501 > kapitel/knie.md
  bauen
  { printf '## Fristen bis 01.01.2000
'; woerter 2001; } > AKTE.md
  local start
  start=$(start_der_sitzung)
  pruefe "Start: nicht abgeschlossener Bau" 1 "$(grep -cxF "$nicht_abgeschlossen" <<< "$start")"
  pruefe "Start: Überblick über der Höchstlänge" 1 \
    "$(grep -cxF 'AKTE.md hat 2005 Wörter, mehr als die Höchstlänge von 2000.' <<< "$start")"
  pruefe "Start: Kapitel über der Höchstlänge" 1 \
    "$(grep -cxF 'kapitel/knie.md hat 1501 Wörter, mehr als die Höchstlänge von 1500.' <<< "$start")"
  pruefe "Start: Fristen vorbei" 1 \
    "$(grep -cxF 'Die Fristen in AKTE.md reichen bis 01.01.2000; das Datum ist vorbei.' <<< "$start")"
}

start_meldet_fehlenden_ueberblick() {
  neues_verzeichnis
  git init -q
  mkdir unterlagen && echo Anamnese > unterlagen/anamnese.md
  git add . && git commit -qm anamnese
  pruefe "Start: Überblick fehlt" 1 "$(start_der_sitzung | grep -cxF 'Der Überblick AKTE.md fehlt.')"
}

start_meldet_bisherigen_aufbau() {
  alte_akte
  echo Anamnese > unterlagen/anamnese.md
  "$stand" --aktualisieren
  local start
  start=$(start_der_sitzung)
  pruefe "Start: bisheriger Aufbau" 1 "$(grep -cxF "$bisheriger_aufbau" <<< "$start")"
  pruefe "Start: bisheriger Aufbau, nicht abgeschlossener Bau" 1 \
    "$(grep -cxF "$bisheriger_aufbau_nicht_abgeschlossen" <<< "$start")"
}

# Was die Tests unten einzeln aufrufen, ruft Claude Code beim Start auf.
start_hooks_eingetragen() {
  # shellcheck disable=SC2016 # Die Befehle stehen so in hooks.json.
  pruefe "Start: alle Hooks in hooks.json" '"${CLAUDE_PLUGIN_ROOT}/hooks/regeln-einspielen" 1
"${CLAUDE_PLUGIN_ROOT}/hooks/regeln-einspielen" 2
"${CLAUDE_PLUGIN_ROOT}/hooks/stand-einspielen"' \
    "$(python3 -c 'import json, sys
for h in json.load(open(sys.argv[1]))["hooks"]["SessionStart"][0]["hooks"]:
    print(h["command"])' "$wurzel/hooks/hooks.json")"
}

# Die Regeln kommen in zwei Hooks; zusammen ohne ihre Kopfzeilen sind sie
# regeln.md.
start_regeln_ganz() {
  neue_akte
  local teil1 teil2
  teil1=$(regeln_teil 1)
  teil2=$(regeln_teil 2)
  pruefe "Start: Regeln ganz eingespielt" "" \
    "$(diff <(regeln_teil 1 | sed 1,2d; regeln_teil 2 | sed 1,2d) "$wurzel/regeln.md")"
  pruefe "Start: Teil 1 der Regeln unter der Grenze eines Hooks" "höchstens $grenze_hook Zeichen" "$(unter_der_grenze "$teil1")"
  pruefe "Start: Teil 2 der Regeln unter der Grenze eines Hooks" "höchstens $grenze_hook Zeichen" "$(unter_der_grenze "$teil2")"
}

regeln_teil() { # Nummer
  CLAUDE_PLUGIN_ROOT=$wurzel CLAUDE_PROJECT_DIR=$PWD "$wurzel/hooks/regeln-einspielen" "$1"
}

# Die ersten Unterlagen einer großen Akte, alle auf einmal hinzugefügt.
start_stand_unter_der_grenze() {
  neue_akte
  echo Anamnese > unterlagen/anamnese.md
  local i
  for ((i = 1; i <= 100; i++)); do
    echo "$i" > "unterlagen/2025-01-$(printf '%03d' "$i")-arztbrief_klinik-fuer-orthopaedie.pdf"
  done
  pruefe "Start: Stand mit 100 neuen Unterlagen unter der Grenze eines Hooks" "höchstens $grenze_hook Zeichen" \
    "$(unter_der_grenze "$(CLAUDE_PLUGIN_ROOT=$wurzel CLAUDE_PROJECT_DIR=$PWD "$wurzel/hooks/stand-einspielen")")"
}

# Was der Hook stand-einspielen beim Start einer Sitzung in der Akte im
# aktuellen Verzeichnis unter „Stand der Akte“ ausgibt.
start_der_sitzung() {
  CLAUDE_PLUGIN_ROOT=$wurzel CLAUDE_PROJECT_DIR=$PWD "$wurzel/hooks/stand-einspielen" |
    sed '0,/^# Stand der Akte$/d'
}

# Ein Baum nach den Vorlagen, mit Inhalt, einem Datum der Fristen, Titeln
# der Kapitel und einem Unterkapitel; dazu Prüfsummen und eine Beurteilung,
# die nicht verglichen werden.
vorlage_eingehalten() {
  baum_nach_vorlage
  pruefe "Vorlage eingehalten" "" "$("$stand" --vorlage)"
}

vorlage_abweichend() {
  baum_nach_vorlage
  sed -i '/^## Warnzeichen/,/^## Fristen/{/^## Fristen/!d}' AKTE.md
  sed -i 's/^\*Was der Patient abgelehnt hat.*/*Abgelehnt.*/' kapitel/knie/meniskus.md
  echo '## Verlauf' >> kapitel/medikation.md
  pruefe "Vorlage nicht eingehalten" "AKTE.md weicht von der Vorlage ab.
kapitel/knie/meniskus.md weicht von der Vorlage ab.
kapitel/medikation.md weicht von der Vorlage ab." "$("$stand" --vorlage)"
}

# Die Überschrift der Fristen nennt ein Datum; ohne Datum weicht sie ab.
vorlage_fristen_ohne_datum() {
  baum_nach_vorlage
  sed -i 's/^## Fristen bis .*/## Fristen/' AKTE.md
  pruefe "Fristen ohne Datum weichen von der Vorlage ab" "AKTE.md weicht von der Vorlage ab." "$("$stand" --vorlage)"
}

# Im bisherigen Aufbau meldet die Abweichung vom neuen Aufbau der Stand.
vorlage_bisheriger_aufbau() {
  neues_verzeichnis
  printf '# Akte\n\n## Stammdaten\n' > AKTE.md
  printf '# Beurteilung\n\n## Quellen\n' > BEURTEILUNG.md
  pruefe "Vorlage im bisherigen Aufbau: keine Meldung" "" "$("$stand" --vorlage)"
}

baum_nach_vorlage() {
  neues_verzeichnis
  mkdir -p unterlagen kapitel/knie
  echo eins > unterlagen/a.md
  printf '# Beurteilung\n\n## 01.01.2026\n\n- Knie – Einschätzung: x\n' > unterlagen/beurteilung.md
  "$stand" --aktualisieren
  sed -e 's/^## Fristen bis TT.MM.JJJJ$/## Fristen bis 26.11.2026/' \
    -e '/^\*Alle, je mit Reaktion/a\
\
- Penicillin: Exanthem [anamnese]' "$wurzel/vorlagen/AKTE.md" > AKTE.md
  sed -e 's/^# Thema$/# Knie rechts/' -e '/^\*Kapitel der Akte/a\
\
Status: aktiv seit 03.02.2025 [2025-02-03-mrt]' "$wurzel/vorlagen/kapitel.md" > kapitel/knie.md
  sed 's/^# Thema$/# Meniskus/' "$wurzel/vorlagen/kapitel.md" > kapitel/knie/meniskus.md
  sed 's/^# Thema$/# Medikation/' "$wurzel/vorlagen/kapitel.md" > kapitel/medikation.md
}

stapel_einer() {
  neues_verzeichnis
  mkdir unterlagen
  pdf unterlagen/2026-02-01-labor_hausarzt.pdf 3
  echo Bild > unterlagen/2026-01-15-roentgen_klinik.jpg
  echo Brief > unterlagen/2026-03-01-brief_klinik.md
  pruefe "Ein Stapel" "Stapel 1 (5 Seiten)
unterlagen/2026-01-15-roentgen_klinik.jpg
unterlagen/2026-02-01-labor_hausarzt.pdf
unterlagen/2026-03-01-brief_klinik.md" "$("$stand" --stapel)"
}

stapel_geschnitten() {
  neues_verzeichnis
  mkdir unterlagen
  pdf unterlagen/2026-01-01-a.pdf 15
  pdf unterlagen/2026-01-02-b.pdf 5
  pdf unterlagen/2026-01-03-c.pdf 1
  pdf unterlagen/2026-01-04-d.pdf 25
  zeichen 10001 > unterlagen/2026-01-05-e.md
  zeichen 10000 ä > unterlagen/2026-01-06-f.md
  pruefe "Bis 20 Seiten in einem Stapel, eine Einheit darüber für sich" "Stapel 1 (20 Seiten)
unterlagen/2026-01-01-a.pdf
unterlagen/2026-01-02-b.pdf

Stapel 2 (1 Seiten)
unterlagen/2026-01-03-c.pdf

Stapel 3 (25 Seiten)
unterlagen/2026-01-04-d.pdf

Stapel 4 (3 Seiten)
unterlagen/2026-01-05-e.md
unterlagen/2026-01-06-f.md" "$("$stand" --stapel)"
  pruefe "Zeichen, nicht Bytes, auch ohne UTF-8 in der Umgebung" "Stapel 1 (1 Seiten)
unterlagen/2026-01-06-f.md" "$(rm unterlagen/2026-01-0[1-5]* && LC_ALL=C "$stand" --stapel)"
  pruefe "Zeichen, nicht Bytes, ohne LC_ALL" "Stapel 1 (1 Seiten)
unterlagen/2026-01-06-f.md" "$(env -u LC_ALL LC_CTYPE=C "$stand" --stapel)"
}

stapel_bilder() {
  neues_verzeichnis
  mkdir unterlagen
  zeichen 30000 > unterlagen/2026-01-01-foto.png
  zeichen 30000 > unterlagen/2026-01-02-foto.JPEG
  pruefe "Ein Bild ist eine Seite" "Stapel 1 (2 Seiten)
unterlagen/2026-01-01-foto.png
unterlagen/2026-01-02-foto.JPEG" "$("$stand" --stapel)"
}

stapel_reihenfolge() {
  neues_verzeichnis
  mkdir unterlagen
  echo 1 > unterlagen/gewicht.csv
  echo 1 > unterlagen/arztbrief.md
  echo 1 > unterlagen/2026-03-01-labor_hausarzt.md
  echo 1 > unterlagen/2026-01-01-labor_hausarzt.md
  printf '# Anamnese\n\n*Erstbefragung vom 01.02.2026, ergänzt am 01.03.2026. Spätere Angaben stehen in historie.md.*\n\nGeboren am 01.01.1970.\n' > unterlagen/anamnese.md
  pruefe "Reihenfolge nach Datum, dann ohne Datum, dann CSV" "Stapel 1 (5 Seiten)
unterlagen/2026-01-01-labor_hausarzt.md
unterlagen/2026-03-01-labor_hausarzt.md
unterlagen/anamnese.md
unterlagen/arztbrief.md
unterlagen/gewicht.csv" "$("$stand" --stapel)"
}

stapel_anamnese_ohne_datum() {
  neues_verzeichnis
  git init -q
  mkdir unterlagen
  echo 1 > unterlagen/2026-02-01-labor_hausarzt.md
  echo 1 > unterlagen/2026-03-01-labor_hausarzt.md
  echo 1 > unterlagen/arztbrief.md
  printf '# Anamnese\n\n*Erstbefragung, vom Benutzer bestätigt.*\n\nSeit 01.01.2020 Asthma.\n' > unterlagen/anamnese.md
  pruefe "anamnese.md ohne Datum und ohne Commit" "Stapel 1 (4 Seiten)
unterlagen/2026-02-01-labor_hausarzt.md
unterlagen/2026-03-01-labor_hausarzt.md
unterlagen/anamnese.md
unterlagen/arztbrief.md" "$("$stand" --stapel)"
  git add . && GIT_AUTHOR_DATE='2026-02-15T12:00:00' git commit -qm start
  echo 2 >> unterlagen/anamnese.md && git commit -qam später
  pruefe "anamnese.md ohne Datum nach ihrem ersten Commit" "Stapel 1 (4 Seiten)
unterlagen/2026-02-01-labor_hausarzt.md
unterlagen/anamnese.md
unterlagen/2026-03-01-labor_hausarzt.md
unterlagen/arztbrief.md" "$("$stand" --stapel)"
}

stapel_anamnese_ohne_kopfzeile() {
  neues_verzeichnis
  mkdir unterlagen
  echo 1 > unterlagen/2026-01-01-labor_hausarzt.md
  printf '# Anamnese\n\n**Geburtsdatum:** 01.01.1970\n' > unterlagen/anamnese.md
  pruefe "Eine fette Zeile unter dem Titel ist keine Kopfzeile" "Stapel 1 (2 Seiten)
unterlagen/2026-01-01-labor_hausarzt.md
unterlagen/anamnese.md" "$("$stand" --stapel)"
}

stapel_historie_tage() {
  neues_verzeichnis
  mkdir unterlagen
  echo 1 > unterlagen/2026-01-03-labor_hausarzt.md
  echo 1 > unterlagen/2026-01-05-labor_hausarzt.md
  printf '# Anamnese\n\n*Erstbefragung vom 05.01.2026.*\n' > unterlagen/anamnese.md
  printf '# Historie\n\nVorab.\n\n## 05.01.2026\n\nA\n\n## 02.01.2026\n\nB\n\n## 05.01.2026\n\nC\n\n## 10.01.2026\n\nD\n' > unterlagen/historie.md
  pruefe "Tage in historie.md nach Datum, aufeinander folgende auf einer Zeile" "Stapel 1 (4 Seiten)
unterlagen/historie.md 02.01.2026–02.01.2026
unterlagen/2026-01-03-labor_hausarzt.md
unterlagen/2026-01-05-labor_hausarzt.md
unterlagen/anamnese.md
unterlagen/historie.md 05.01.2026–10.01.2026" "$("$stand" --stapel)"
}

# Ein Tag zählt anteilig: drei Tage zu 0,6 Seiten passen zu 18 Seiten in
# einen Stapel, der vierte nicht mehr.
stapel_historie_anteilig() {
  neues_verzeichnis
  mkdir unterlagen
  pdf unterlagen/2026-01-01-ct_klinik.pdf 18
  local tag
  for tag in 01 02 03 04; do
    # 14 Zeichen Überschrift, 5985 Zeichen Text, ein Zeilenende: 6000
    printf '## %s.02.2026\n%s\n' "$tag" "$(zeichen 5985 ü)"
  done > unterlagen/historie.md
  pruefe "Tage in historie.md zählen anteilig" "Stapel 1 (20 Seiten)
unterlagen/2026-01-01-ct_klinik.pdf
unterlagen/historie.md 01.02.2026–03.02.2026

Stapel 2 (1 Seiten)
unterlagen/historie.md 04.02.2026–04.02.2026" "$("$stand" --stapel)"
}

# Die Beurteilung wird an ihren Datumsüberschriften geteilt wie historie.md,
# am selben Tag nach historie.md; aufeinander folgende Tage derselben Datei
# stehen auf einer Zeile, Tage verschiedener Dateien nie.
stapel_beurteilung_tage() {
  neues_verzeichnis
  mkdir unterlagen
  echo 1 > unterlagen/2026-01-03-labor_hausarzt.md
  printf '# Historie\n\n## 02.01.2026\n\nA\n\n## 03.01.2026\n\nB\n' > unterlagen/historie.md
  printf '# Beurteilung\n\n## 02.01.2026\n\nX\n\n## 04.01.2026\n\nY\n\n## 05.01.2026\n\nZ\n' > unterlagen/beurteilung.md
  pruefe "Tage in beurteilung.md nach Datum, nach historie.md" "Stapel 1 (2 Seiten)
unterlagen/historie.md 02.01.2026–02.01.2026
unterlagen/beurteilung.md 02.01.2026–02.01.2026
unterlagen/2026-01-03-labor_hausarzt.md
unterlagen/historie.md 03.01.2026–03.01.2026
unterlagen/beurteilung.md 04.01.2026–05.01.2026" "$("$stand" --stapel)"
}

# Wie historie.md: ohne Datumsüberschrift eine Einheit und ein Hinweis.
stapel_beurteilung_ohne_ueberschrift() {
  neues_verzeichnis
  mkdir unterlagen
  printf '# Historie\n\nA\n' > unterlagen/historie.md
  printf '# Beurteilung\n\n### 13.03.2026\n' > unterlagen/beurteilung.md
  pruefe "beurteilung.md ohne Datumsüberschrift" "Stapel 1 (2 Seiten)
unterlagen/beurteilung.md
unterlagen/historie.md

historie.md ohne Datumsüberschriften.
beurteilung.md ohne Datumsüberschriften." "$("$stand" --stapel)"
}

# Der Text vor der ersten Überschrift zählt zum frühesten Tag, 05.01., nicht
# zum ersten in der Datei: mit ihm passt der Tag nicht mehr zum CT.
stapel_historie_vorab() {
  neues_verzeichnis
  mkdir unterlagen
  pdf unterlagen/2026-01-07-ct_klinik.pdf 19
  printf '%s\n## 10.01.2026\nA\n## 05.01.2026\nB\n' "$(zeichen 15000)" > unterlagen/historie.md
  pruefe "Text vor der ersten Überschrift zählt zum frühesten Tag" "Stapel 1 (2 Seiten)
unterlagen/historie.md 05.01.2026–05.01.2026

Stapel 2 (20 Seiten)
unterlagen/2026-01-07-ct_klinik.pdf
unterlagen/historie.md 10.01.2026–10.01.2026" "$("$stand" --stapel)"
}

stapel_seitenzahl_unbekannt() {
  neues_verzeichnis
  mkdir unterlagen
  echo 1 > unterlagen/2026-01-01-a.md
  echo kaputt > unterlagen/2026-01-02-b.pdf
  echo 1 > unterlagen/2026-01-03-c.md
  echo kaputt > unterlagen/scan.PDF
  pruefe "PDF ohne Seitenzahl als eigener Stapel" "Stapel 1 (1 Seiten)
unterlagen/2026-01-01-a.md

Stapel 2 (? Seiten)
unterlagen/2026-01-02-b.pdf

Stapel 3 (1 Seiten)
unterlagen/2026-01-03-c.md

Stapel 4 (? Seiten)
unterlagen/scan.PDF

Seitenzahl unbekannt: unterlagen/2026-01-02-b.pdf
Seitenzahl unbekannt: unterlagen/scan.PDF" "$("$stand" --stapel)"
}

stapel_historie_ohne_ueberschrift() {
  neues_verzeichnis
  mkdir unterlagen
  echo 1 > unterlagen/2026-01-01-a.md
  echo 1 > unterlagen/arztbrief.md
  echo 1 > unterlagen/zahnarzt.md
  echo 1 > unterlagen/gewicht.csv
  printf '# Historie\n\n12.03.2026: Husten.\n### 13.03.2026\n' > unterlagen/historie.md
  pruefe "historie.md ohne Datumsüberschrift bei den Dateien ohne Datum" "Stapel 1 (5 Seiten)
unterlagen/2026-01-01-a.md
unterlagen/arztbrief.md
unterlagen/historie.md
unterlagen/zahnarzt.md
unterlagen/gewicht.csv

historie.md ohne Datumsüberschriften." "$("$stand" --stapel)"
}

stapel_ohne_pdfinfo() {
  neues_verzeichnis
  mkdir unterlagen
  echo 1 > unterlagen/a.md
  pdf unterlagen/2026-01-01-b.PDF 1
  ohne_pdfinfo
  local ausgabe code
  ausgabe=$(PATH=$PWD/bin "$stand" --stapel 2>&1 >/dev/null)
  code=$?
  pruefe "Ohne pdfinfo Exit-Code 1" 1 "$code"
  pruefe "Ohne pdfinfo nennt die Meldung poppler-utils" 1 "$(grep -c poppler-utils <<< "$ausgabe")"
}

stapel_ohne_pdf_ohne_pdfinfo() {
  neues_verzeichnis
  mkdir unterlagen
  echo 1 > unterlagen/a.md
  ohne_pdfinfo
  local ausgabe code
  ausgabe=$(PATH=$PWD/bin "$stand" --stapel 2>&1)
  code=$?
  pruefe "Ohne PDF läuft --stapel ohne pdfinfo" "0
Stapel 1 (1 Seiten)
unterlagen/a.md" "$code
$ausgabe"
}

# Legt bin/ mit allem an, was akte-stand braucht, außer pdfinfo; für PATH.
ohne_pdfinfo() {
  mkdir bin
  local befehl
  for befehl in awk basename bash dirname env find git readlink sort tail tr wc; do
    ln -s "$(command -v "$befehl")" bin/
  done
}

# Mit 2 Seiten je Stapel und 100 Zeichen je Seite: a hat 2 Seiten, b und c
# je eine.
stapel_grenzen_einstellbar() {
  neues_verzeichnis
  mkdir unterlagen bin
  sed -e 's/^seiten_je_stapel=20$/seiten_je_stapel=2/' \
    -e 's/^zeichen_je_seite=10000$/zeichen_je_seite=100/' "$stand" > bin/akte-stand
  chmod +x bin/akte-stand
  zeichen 150 > unterlagen/2026-01-01-a.md
  pdf unterlagen/2026-01-02-b.pdf 1
  echo 1 > unterlagen/2026-01-03-c.md
  pruefe "Grenzen an einer Stelle einstellbar" "Stapel 1 (2 Seiten)
unterlagen/2026-01-01-a.md

Stapel 2 (2 Seiten)
unterlagen/2026-01-02-b.pdf
unterlagen/2026-01-03-c.md" "$(bin/akte-stand --stapel)"
  pruefe "Die Grenzen stehen sonst nirgends" "seiten_je_stapel=20
zeichen_je_seite=10000" "$(grep -Ew '20|10000|10\.000' "$stand")"
  # -z liest jede Datei als eine Zeile, so zählt auch eine Zahl am
  # Zeilenende; fehlt ein Pfad, steht grep's Meldung in der Ausgabe.
  pruefe "Die Grenzen stehen nicht in den Texten des Plugins" "" \
    "$(grep -rEzo '(^|[^0-9])20\s+Seiten|10\.?000\s+Zeichen' "$wurzel"/README.md \
      "$wurzel"/regeln.md "$wurzel"/agents "$wurzel"/skills 2>&1 | tr '\0' '\n')"
}

# Abschnitte mit demselben Datum gehören zusammen, auch wenn ein anderer
# dazwischen steht; der Text vor der ersten Überschrift gehört zum
# frühesten Tag, 02.01., und fehlt hier.
einheit_tage() {
  historie_mit_tagen
  pruefe "Einheit: nur die Abschnitte im Zeitraum" "## 05.01.2026

A

## 05.01.2026

C

## 10.01.2026

D" "$("$stand" --einheit "unterlagen/historie.md 05.01.2026–10.01.2026")"
}

einheit_vorab() {
  historie_mit_tagen
  pruefe "Einheit ab dem frühesten Tag mit dem Text davor" "# Historie

Vorab.

## 02.01.2026

B" "$("$stand" --einheit "unterlagen/historie.md 02.01.2026–02.01.2026")"
}

einheit_beurteilung() {
  historie_mit_tagen
  printf '# Beurteilung\n\nKopf.\n\n## 05.01.2026\n\nX\n\n## 10.01.2026\n\nY\n' > unterlagen/beurteilung.md
  pruefe "Einheit aus beurteilung.md" "# Beurteilung

Kopf.

## 05.01.2026

X" "$("$stand" --einheit "unterlagen/beurteilung.md 05.01.2026–05.01.2026")"
}

einheit_ohne_beurteilung() {
  historie_mit_tagen
  local ausgabe code
  ausgabe=$("$stand" --einheit "unterlagen/beurteilung.md 02.01.2026–02.01.2026" 2>&1)
  code=$?
  pruefe "Einheit ohne beurteilung.md: Exit-Code 1 und Meldung" "1
unterlagen/beurteilung.md gibt es nicht." "$code
$ausgabe"
}

einheit_falscher_aufruf() {
  historie_mit_tagen
  local ausgabe code
  ausgabe=$("$stand" --einheit unterlagen/anamnese.md 2>&1)
  code=$?
  pruefe "Einheit ohne Zeitraum: Exit-Code 2 und Meldung" "2
akte-stand --einheit nimmt einen Teil von unterlagen/historie.md oder unterlagen/beurteilung.md, wie --stapel ihn ausgibt, etwa \"unterlagen/historie.md 03.02.2025–17.06.2025\"; bekommen: unterlagen/anamnese.md" "$code
$ausgabe"
}

einheit_ohne_historie() {
  neues_verzeichnis
  mkdir unterlagen
  local ausgabe code
  ausgabe=$("$stand" --einheit "unterlagen/historie.md 02.01.2026–02.01.2026" 2>&1)
  code=$?
  pruefe "Einheit ohne historie.md: Exit-Code 1 und Meldung" "1
unterlagen/historie.md gibt es nicht." "$code
$ausgabe"
}

# 03.01. liegt zwischen zwei Tagen, keiner fällt in den Zeitraum.
einheit_ohne_abschnitt() {
  historie_mit_tagen
  local ausgabe code
  ausgabe=$("$stand" --einheit "unterlagen/historie.md 03.01.2026–04.01.2026" 2>&1)
  code=$?
  pruefe "Einheit ohne Abschnitt im Zeitraum: Exit-Code 1 und Meldung" "1
unterlagen/historie.md hat keinen Abschnitt vom 03.01.2026 bis 04.01.2026." "$code
$ausgabe"
}

historie_mit_tagen() {
  neues_verzeichnis
  mkdir unterlagen
  printf '# Historie\n\nVorab.\n\n## 05.01.2026\n\nA\n\n## 02.01.2026\n\nB\n\n## 05.01.2026\n\nC\n\n## 10.01.2026\n\nD\n' > unterlagen/historie.md
}

# Eine Akte im neuen Aufbau mit einer Unterlage, einer AKTE.md und der
# .claude/CLAUDE.md, die sie einbindet, alle committet, ohne
# kapitel/grundlage.md.
neue_akte() {
  neues_verzeichnis
  git init -q
  mkdir unterlagen .claude && echo eins > unterlagen/a.md
  printf '# Akte\n' > AKTE.md
  cp "$wurzel/vorlagen/claude.md" .claude/CLAUDE.md
  git add . && git commit -qm start
}

# literatur/ mit der Übersicht aus der Vorlage und zwei Quellen mit
# vollständiger Zeile, eine davon ein Verzeichnis, wie Webseiten es sind.
literatur_mit_uebersicht() {
  mkdir -p literatur/seiten
  : > literatur/leitlinie.pdf
  : > literatur/leitlinie.txt
  : > literatur/seiten/start.html
  {
    sed '/^## Nicht gespeichert/,$d' "$wurzel/vorlagen/literatur-README.md"
    cat <<'MD'
| `leitlinie` | Quelle | 2026 | bis 2030 | 01.01.2026 | 01.01.2026 | [Seite](https://x) |
| `seiten/` | Webseiten | 2026 | bis zur nächsten Änderung | 01.01.2026 | 01.01.2026 | [Seite](https://x) |
MD
  } > literatur/README.md
}

# Wie neue_akte, aber im bisherigen Aufbau mit BEURTEILUNG.md.
alte_akte() {
  neue_akte
  printf '# Beurteilung\n' > BEURTEILUNG.md
  git add . && git commit -qm beurteilung
}

# Schreibt die Prüfsummen und committet den Baum, wie am Ende eines Baus.
bauen() {
  "$stand" --aktualisieren && git add AKTE.md kapitel && git commit -qm bau
}

woerter() { # Anzahl
  local i
  for ((i = 0; i < $1; i++)); do printf 'w '; done
  echo
}

zeichen() { # Anzahl, Zeichen (x ohne Angabe)
  local zeile
  printf -v zeile '%*s' "$1" ''
  printf '%s' "${zeile// /${2:-x}}"
}

pdf() { # Pfad, Seiten
  local i
  {
    printf '%%PDF-1.4\n1 0 obj<</Type/Catalog/Pages 2 0 R>>endobj\n'
    printf '2 0 obj<</Type/Pages/Count %d/Kids[' "$2"
    for ((i = 3; i < $2 + 3; i++)); do printf '%d 0 R ' "$i"; done
    printf ']>>endobj\n'
    for ((i = 3; i < $2 + 3; i++)); do
      printf '%d 0 obj<</Type/Page/Parent 2 0 R/MediaBox[0 0 9 9]>>endobj\n' "$i"
    done
    printf 'trailer<</Root 1 0 R>>\n%%%%EOF\n'
  } > "$1"
}

unter_der_grenze() { # Ausgabe eines Hooks
  local n
  n=$(LC_ALL=C.UTF-8 wc -m <<< "$1")
  if ((n <= grenze_hook)); then
    echo "höchstens $grenze_hook Zeichen"
  else
    echo "$n Zeichen"
  fi
}

neues_verzeichnis() {
  cd "$(mktemp -d -p "$tmp")" || exit 1
}

pruefe() { # Name, erwartet, tatsächlich
  if [[ $2 == "$3" ]]; then
    echo "ok: $1"
    return
  fi
  printf 'FEHLER: %s\n  erwartet:\n%s\n  tatsächlich:\n%s\n' "$1" "$2" "$3"
  fehler=1
}

main
