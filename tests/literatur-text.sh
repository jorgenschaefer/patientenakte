#!/usr/bin/env bash
# Tests für bin/literatur-text. Jeder Fall schreibt seine PDFs in ein
# eigenes temporäres Verzeichnis, das am Ende gelöscht wird.
#
#   tests/literatur-text.sh
set -uo pipefail

wurzel=$(cd "$(dirname "$0")/.." && pwd)
text=$wurzel/bin/literatur-text
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
fehler=0

main() {
  spalten_nacheinander
  getrennte_woerter
  seiten_ohne_text
  alle_seiten_ohne_text
  vorhandene_textfassung
  falscher_aufruf
  exit $fehler
}

# Mit -layout liefe der Satz der linken Spalte durch die rechte.
spalten_nacheinander() {
  neues_verzeichnis
  seiten_pdf leitlinie.pdf "$(spalte 10 'Links eins' 'links zwei')$(spalte 210 'Rechts eins' 'rechts zwei')"
  "$text" leitlinie.pdf > /dev/null
  pruefe "Zwei Spalten nacheinander" "Links eins
links zwei
Rechts eins
rechts zwei" "$(tr -d '\f' < leitlinie.txt | sed '/^$/d')"
}

getrennte_woerter() {
  neues_verzeichnis
  seiten_pdf leitlinie.pdf "$(spalte 10 'ist ein Ka-' 'tarakt als Folge' 'Langzeit-' 'Therapie')"
  "$text" leitlinie.pdf > /dev/null
  pruefe "Am Zeilenende getrennte Wörter verbunden" "ist ein Katarakt als Folge
LangzeitTherapie" "$(tr -d '\f' < leitlinie.txt | sed '/^$/d')"
}

seiten_ohne_text() {
  neues_verzeichnis
  local voll
  voll=$(spalte 10 'eins zwei drei vier fuenf sechs sieben acht neun zehn')
  seiten_pdf leitlinie.pdf "$voll" '' "$(spalte 10 'neun Woerter auf dieser Seite sind zu wenig hier')" "$voll" ''
  pruefe "Seiten ohne Text" "Ohne Text in leitlinie.pdf: Seiten 2–3, 5 von 5; im PDF lesen." "$("$text" leitlinie.pdf)"
  seiten_pdf leitlinie.pdf "$voll" ''
  pruefe "Eine Seite ohne Text" "Ohne Text in leitlinie.pdf: Seite 2 von 2; im PDF lesen." "$("$text" leitlinie.pdf)"
  seiten_pdf leitlinie.pdf "$voll"
  pruefe "Alle Seiten mit Text" "" "$("$text" leitlinie.pdf)"
}

alle_seiten_ohne_text() {
  neues_verzeichnis
  seiten_pdf scan.PDF '' ''
  pruefe "Ein Scan ohne Textschicht" "Ohne Text in scan.PDF: alle 2 Seiten; im PDF lesen." "$("$text" scan.PDF)"
  seiten_pdf scan.pdf ''
  pruefe "Ein Scan mit einer Seite" "Ohne Text in scan.pdf: die einzige Seite; im PDF lesen." "$("$text" scan.pdf)"
  pruefe "Auch dann eine Textfassung" "ja" "$([[ -f scan.txt ]] && echo ja)"
}

vorhandene_textfassung() {
  neues_verzeichnis
  seiten_pdf leitlinie.pdf "$(spalte 10 'Neu')"
  echo Alt > leitlinie.txt
  "$text" leitlinie.pdf > /dev/null
  pruefe "Eine vorhandene Textfassung wird ersetzt" "Neu" "$(tr -d '\f' < leitlinie.txt | sed '/^$/d')"
}

falscher_aufruf() {
  neues_verzeichnis
  "$text" bild.png 2> fehler.txt
  pruefe "Nur PDFs" "2 Aufruf: $text <datei.pdf>" "$? $(cat fehler.txt)"
  "$text" fehlt.pdf 2> fehler.txt
  pruefe "PDF fehlt" "1 fehlt.pdf gibt es nicht." "$? $(cat fehler.txt)"
}

# Ein PDF mit einer Seite je Argument; ein Argument ist der Inhalt der
# Seite als PDF-Operatoren, etwa aus spalte().
seiten_pdf() { # Pfad, Inhalt je Seite …
  local pfad=$1
  shift
  local n=$# i=0 inhalt
  {
    printf '%%PDF-1.4\n1 0 obj<</Type/Catalog/Pages 2 0 R>>endobj\n'
    printf '2 0 obj<</Type/Pages/Count %d/Kids[' "$n"
    for ((i = 0; i < n; i++)); do printf '%d 0 R ' $((4 + 2 * i)); done
    printf ']>>endobj\n3 0 obj<</Type/Font/Subtype/Type1/BaseFont/Helvetica>>endobj\n'
    i=0
    for inhalt; do
      printf '%d 0 obj<</Type/Page/Parent 2 0 R/MediaBox[0 0 400 300]/Resources<</Font<</F1 3 0 R>>>>/Contents %d 0 R>>endobj\n' $((4 + 2 * i)) $((5 + 2 * i))
      printf '%d 0 obj<</Length %d>>stream\n%s\nendstream endobj\n' $((5 + 2 * i)) ${#inhalt} "$inhalt"
      i=$((i + 1))
    done
    printf 'trailer<</Root 1 0 R>>\n%%%%EOF\n'
  } > "$pfad"
}

# Eine Spalte Text, links an der Stelle x, eine Zeile je Argument nach x.
spalte() { # x, Zeilen …
  local x=$1 zeile
  shift
  printf 'BT /F1 10 Tf %d 280 Td 12 TL' "$x"
  for zeile; do printf " (%s) '" "$zeile"; done
  printf ' ET '
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
