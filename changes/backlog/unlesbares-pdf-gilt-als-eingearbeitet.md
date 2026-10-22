---
effort: S
utility: M
---

# Ein unlesbares PDF gilt als eingearbeitet

`akte-stand --aktualisieren` schreibt die Prüfsumme jeder Datei in
`unterlagen/` unter „Grundlage“ (`bin/akte-stand`, `aktualisieren`),
auch eines PDFs, aus dem nichts in `AKTE.md` steht, weil es sich nicht
lesen lässt. Danach meldet `akte-stand` es nie wieder; die Lücke bleibt
still, bis jemand die Datei ersetzt.

Gesehen in einer Testakte mit einem kaputten PDF von 16 Byte: Der Bau
meldete es als unlesbar und ohne Seitenzahl, committete aber seine
Prüfsumme.
