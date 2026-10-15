---
effort: M
utility: M
---

# Befunde nur als PDF, Scans ohne Textfassung, keine Erkennung von Duplikaten

`skills/neue-information/SKILL.md:11-13` sieht für Befunde nur
`unterlagen/JJJJ-MM-TT-<art>_<absender>.pdf` vor. Befunde kommen aber oft als
Handyfoto.

Scans ohne Textebene kann das Read-Tool als Bild lesen, `pdftotext` liefert
für sie aber nichts (`skills/leitlinie/SKILL.md:23`). Damit geht jede Suche
im Text und jede maschinelle Prüfung gegen die Quelle ins Leere.

Beim Ablegen wird nicht geprüft, ob dieselbe Datei schon in `unterlagen/`
liegt.

Idee aus der Überprüfung: Bilder zulassen oder in PDF wandeln, Scans mit OCR
(z. B. `ocrmypdf`) durchsuchbar machen, Duplikate über die Prüfsumme erkennen.
