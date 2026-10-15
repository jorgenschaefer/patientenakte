#!/usr/bin/env bash
# Der Check des Projekts: Tests und shellcheck. Läuft aus jedem Verzeichnis.
#
#   tests/check.sh
set -euo pipefail
cd "$(dirname "$0")/.."

tests/akte-stand.sh
shellcheck bin/* hooks/regeln-einspielen tests/*.sh
