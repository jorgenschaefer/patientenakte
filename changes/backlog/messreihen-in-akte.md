---
effort: M
utility: M
---

# Messreihen stehen in AKTE.md nur zusammengefasst

Messreihen aus den CSV stehen in `AKTE.md` nur „zusammengefasst mit Verweis
auf die CSV“ (`agents/akte.md:97`). `neue-information` verlangt aber, jeden
neuen Messwert gegen die Reihe desselben Parameters unter „Messwerte“ in
`AKTE.md` einzuordnen, mit früheren Werten, Differenz und Trend
(`skills/neue-information/SKILL.md:19-23`). Für Werte aus einer CSV geht
das mit `AKTE.md` allein nicht; die Einzelwerte stehen nur in der CSV.

Umgekehrt ändert jede neue CSV-Zeile die Prüfsumme der Datei. `akte-stand`
meldet sie als geändert, und `AKTE.md` wird samt Gegenprüfung neu gebaut,
auch wenn sich an der Zusammenfassung nichts ändert.
