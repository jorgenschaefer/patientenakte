---
effort: M
utility: M
---

# Befunde nur als PDF, ohne OCR und ohne Abgleich mit dem Patienten

`skills/neue-information/SKILL.md:15-17` sieht für Befunde nur
`unterlagen/JJJJ-MM-TT-<art>_<absender>.pdf` vor. Befunde kommen aber oft als
Handyfoto oder als Scan ohne Textebene. Bei Scans liefert `pdftotext` nichts
(`agents/akte.md:22`, `skills/leitlinie/SKILL.md:24`), sodass jede spätere
Suche im Text oder Prüfung gegen die Quelle ins Leere geht.

Beim Ablegen wird auch nicht geprüft,
- ob Name und Geburtsdatum auf dem Befund zum Patienten der Akte passen,
- ob dieselbe Datei schon in `unterlagen/` liegt.

Idee aus der Überprüfung: Bilder zulassen oder in PDF wandeln, Scans mit OCR
(z. B. `ocrmypdf`) durchsuchbar machen, Duplikate über die Prüfsumme erkennen.
