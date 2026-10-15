#!/usr/bin/env bash
# Tests für bin/akte-stand. Jeder Fall baut eine Akte in einem eigenen
# temporären Verzeichnis, das am Ende gelöscht wird.
#
#   tests/akte-stand.sh
set -uo pipefail

stand=$(cd "$(dirname "$0")/.." && pwd)/bin/akte-stand
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# Ohne Einfluss der Git-Konfiguration des Benutzers, und kein Repo oberhalb
# von $tmp darf als Akte gelten.
export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1 GIT_CEILING_DIRECTORIES=$tmp
export GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@t GIT_COMMITTER_NAME=t GIT_COMMITTER_EMAIL=t@t

nicht_durchgesehen='AKTE.md hat Änderungen, die nicht committet und noch nicht durchgesehen sind.'
fehler=0

main() {
  commit_vor_der_liste
  akte_commit_ohne_pruefsummen
  auf_dem_stand
  neu_und_entfernt
  pruefsummen_nicht_committet
  gebaut_nicht_durchgesehen
  neue_akte_nie_committet
  ohne_git
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
  pruefe "Prüfsummen nicht committet" "$nicht_durchgesehen
geändert: unterlagen/a.md" "$("$stand")"
}

gebaut_nicht_durchgesehen() {
  neue_akte
  "$stand" --aktualisieren && git commit -qm akte -- AKTE.md
  echo zwei >> unterlagen/a.md && git commit -qm a2 -- unterlagen/a.md
  "$stand" --aktualisieren
  pruefe "Gebaut, nicht durchgesehen" "$nicht_durchgesehen" "$("$stand")"
  echo drei >> unterlagen/a.md && git commit -qm a3 -- unterlagen/a.md
  pruefe "Nicht durchgesehen, ohne Commit-Zeile" "$nicht_durchgesehen
geändert: unterlagen/a.md" "$("$stand")"
}

neue_akte_nie_committet() {
  neues_verzeichnis
  git init -q
  mkdir unterlagen && echo eins > unterlagen/a.md
  git add . && git commit -qm unterlagen
  printf '# Akte\n' > AKTE.md && "$stand" --aktualisieren
  pruefe "Neue AKTE.md, nie committet" "$nicht_durchgesehen" "$("$stand")"
}

ohne_git() {
  neues_verzeichnis
  mkdir unterlagen && echo eins > unterlagen/a.md
  printf '# Akte\n' > AKTE.md && "$stand" --aktualisieren
  echo zwei >> unterlagen/a.md
  pruefe "Ohne Git" "geändert: unterlagen/a.md" "$("$stand" 2>&1)"
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
