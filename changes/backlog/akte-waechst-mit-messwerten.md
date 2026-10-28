---
effort: M
utility: M
---

# AKTE.md wächst mit jedem Laborwert

„Messwerte“ in `vorlagen/AKTE.md:47-49` verlangt je Parameter alle Werte,
älteste zuerst, je mit Quelle. Mit jedem Laborbefund wird der Abschnitt
länger, ohne Grenze. In einer echten Akte hatte er nach gut zwei Wochen
etwa 1.900 Wörter; „Diagnosen und Nebenbefunde“ (`vorlagen/AKTE.md:15-17`)
etwa 2.100, weil zu einer Diagnose auch ältere Befunde einzeln stehen.

Das widerspricht `regeln.md`, Abschnitt „Dateien“: `AKTE.md` ist der
aktuelle Stand, „mit knappem Verlauf, wo er für Entscheidungen zählt“.

Idee aus der Überprüfung: In `AKTE.md` je Parameter nur der letzte Wert,
der Trend und die Werte, die für Entscheidungen zählen; die ganze Reihe in
einer CSV, wie die Messreihen unter „Beobachten“. Bei den Diagnosen der
aktuelle Stand je Diagnose; ältere Befunde bleiben in `unterlagen/`.
