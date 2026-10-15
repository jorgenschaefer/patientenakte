# Gemeinsame Teile von pre-commit und commit-msg: prüft Text gegen die private
# Sperrliste mit Begriffen, die nicht ins öffentliche Repo gehören.
#
# Die Sperrliste enthält einen Begriff pro Zeile; Groß- und Kleinschreibung
# zählt nicht, leere Zeilen und Zeilen mit # am Anfang werden übergangen.

sperrliste=${PATIENTENAKTE_SPERRLISTE:-${XDG_CONFIG_HOME:-$HOME/.config}/patientenakte/sperrliste}

# Schreibt die Begriffe der Sperrliste in eine temporäre Datei und gibt ihren
# Pfad aus. Bricht ab, wenn die Sperrliste fehlt.
begriffe() {
  if [[ ! -f $sperrliste ]]; then
    echo "Sperrliste $sperrliste fehlt; ohne sie wird nicht committet." >&2
    echo "Eine leere Datei reicht, wenn es keine Akte mit Begriffen gibt." >&2
    exit 1
  fi
  local datei
  datei=$(mktemp)
  grep -v -e '^[[:space:]]*$' -e '^[[:space:]]*#' "$sperrliste" \
    | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' > "$datei" || true
  echo "$datei"
}

# Liest Zeilen der Form "<ort>:<text>" und gibt für jeden Treffer
# "<ort>: <begriff>" aus. Gibt 1 zurück, wenn es Treffer gab.
pruefen() {
  local liste=$1 treffer=0 ort text begriff
  [[ -s $liste ]] || { cat > /dev/null; return 0; }
  while IFS= read -r zeile; do
    ort=${zeile%%:*}
    text=${zeile#*:}
    while IFS= read -r begriff; do
      echo "$ort: $begriff"
      treffer=1
    done < <(grep -o -i -F -f "$liste" <<< "$text" || true)
  done
  return $treffer
}
