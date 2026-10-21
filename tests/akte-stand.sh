#!/usr/bin/env bash
# Tests für bin/akte-stand. Jeder Fall baut eine Akte in einem eigenen
# temporären Verzeichnis, das am Ende gelöscht wird.
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

nicht_abgeschlossen='AKTE.md hat Änderungen ohne Commit aus einem Bau, der nicht abgeschlossen ist.'
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
  vorlage_eingehalten
  vorlage_abweichend
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
  stapel_ohne_pdfinfo
  stapel_grenzen_einstellbar
  exit $fehler
}

commit_vor_der_liste() {
  neue_akte
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
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
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
  local x
  x=$(git rev-parse --short HEAD)
  echo zwei >> unterlagen/a.md && git commit -qam a2
  echo Text >> AKTE.md && git commit -qam text
  pruefe "Commit an AKTE.md ohne Prüfsummen verschiebt nichts" "Eingearbeitet bis Commit $x.
geändert: unterlagen/a.md" "$("$stand")"
}

auf_dem_stand() {
  neue_akte
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
  pruefe "Auf dem Stand" "AKTE.md ist auf dem Stand von unterlagen/." "$("$stand")"
}

neu_und_entfernt() {
  neue_akte
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
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
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
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
  pruefe "Neue AKTE.md, nie committet" "$nicht_abgeschlossen" "$("$stand")"
}

bau_in_stapeln_abgebrochen() {
  neue_akte
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
  mkdir .git/akte-bau && printf '# Akte\nZwischenfassung\n' > .git/akte-bau/stapel-1.md
  pruefe "Zwischenfassungen unter .git/akte-bau/ sind kein offener Bau" \
    "AKTE.md ist auf dem Stand von unterlagen/." "$("$stand")"
  pruefe "Zwischenfassungen stehen nicht in git status" "" "$(git status --porcelain)"
}

ohne_git() {
  neues_verzeichnis
  mkdir unterlagen && echo eins > unterlagen/a.md
  printf '# Akte\n' > AKTE.md && "$stand" --aktualisieren
  echo zwei >> unterlagen/a.md
  pruefe "Ohne Git" "geändert: unterlagen/a.md" "$("$stand" 2>&1)"
}

vorlage_eingehalten() {
  neues_verzeichnis
  cp "$wurzel/vorlagen/AKTE.md" "$wurzel/vorlagen/BEURTEILUNG.md" .
  mkdir unterlagen && echo eins > unterlagen/a.md
  "$stand" --aktualisieren
  sed -i '/^## Allergien/a\
\
- Penicillin: Exanthem [anamnese]' AKTE.md
  sed -i '/^## Warnzeichen/,/^## /{/^\*/a\
\
- 01.01.2026 – Fieber über 39 °C – noch heute
}' BEURTEILUNG.md
  pruefe "Vorlage eingehalten" "" "$("$stand" --vorlage)"
}

vorlage_abweichend() {
  neues_verzeichnis
  printf '# Akte\n\n## Stammdaten\n' > AKTE.md
  sed '/^## Abgelehnt/,$d' "$wurzel/vorlagen/BEURTEILUNG.md" > BEURTEILUNG.md
  pruefe "Vorlage nicht eingehalten" "AKTE.md weicht von der Vorlage ab.
BEURTEILUNG.md weicht von der Vorlage ab." "$("$stand" --vorlage)"
  cp "$wurzel/vorlagen/AKTE.md" .
  sed -i 's/^\*Was der Patient erreichen.*/*Was er will.*/' AKTE.md
  rm BEURTEILUNG.md
  pruefe "Hinweis geändert, BEURTEILUNG.md fehlt" "AKTE.md weicht von der Vorlage ab." "$("$stand" --vorlage)"
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
  mkdir unterlagen bin
  echo 1 > unterlagen/a.md
  # Ein PATH mit allem, was akte-stand braucht, außer pdfinfo.
  local befehl
  for befehl in awk basename bash dirname env find git readlink sort tail tr wc; do
    ln -s "$(command -v "$befehl")" bin/
  done
  local ausgabe code
  ausgabe=$(PATH=$PWD/bin "$stand" --stapel 2>&1 >/dev/null)
  code=$?
  pruefe "Ohne pdfinfo Exit-Code 1" 1 "$code"
  pruefe "Ohne pdfinfo nennt die Meldung poppler-utils" 1 "$(grep -c poppler-utils <<< "$ausgabe")"
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
  pruefe "Die Grenzen stehen nicht in den Texten des Plugins" "" \
    "$(grep -rEn '(^|[^0-9])20 Seiten|10\.?000 Zeichen' "$wurzel"/README.md \
      "$wurzel"/regeln.md "$wurzel"/agents "$wurzel"/skills)"
}

# Eine Akte mit einer Unterlage und einer AKTE.md ohne Prüfsummen, beide
# committet.
neue_akte() {
  neues_verzeichnis
  git init -q
  mkdir unterlagen && echo eins > unterlagen/a.md
  printf '# Akte\n' > AKTE.md
  git add . && git commit -qm start
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
