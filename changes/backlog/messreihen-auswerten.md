---
effort: M
utility: M
---

# Messreihen und Laborwerte werden nicht maschinell ausgewertet

`agents/akte.md:65` verlangt in `AKTE.md` eine Tabelle mit Wert, Referenz und
Verlauf und fasst Messreihen aus den CSV-Dateien zusammen. Das Rechnen
(letzter Wert, Spanne, Tendenz) übernimmt das Modell. Laborwerte stehen
verstreut in einzelnen Befunden; ein Verlauf über mehrere Befunde muss jedes
Mal neu zusammengesucht werden. Für die CSV-Dateien gibt es kein Format
(`regeln.md:43`, `skills/neue-information/SKILL.md:22`).

Idee aus der Überprüfung: eine gemeinsame Labor-CSV im Langformat (Datum,
Parameter, Wert, Einheit, Referenz, Quelle) und ein Script, das je Parameter
letzten Wert, Spanne und Tendenz ausgibt.
