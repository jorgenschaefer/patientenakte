---
effort: S
utility: M
---

# `git diff` zeigt beim schrittweisen Bau von AKTE.md nichts

`skills/akte-aktualisieren/SKILL.md:8` verlangt, dass die Unterlagen vor dem
Bau committet sind. `agents/akte.md:18` sagt dem Agenten aber, bei geänderten
Textdateien zeige `git diff`, was neu ist. Nach dem Commit ist dieser Diff
leer. Der Agent muss dann raten oder die ganze Datei, etwa `historie.md`, neu
lesen und ihren Inhalt gegen `AKTE.md` abgleichen.

Idee aus der Überprüfung: `akte-stand --aktualisieren` schreibt den Commit in
den Block „Grundlage“ (`bin/akte-stand:50`), `akte-stand` gibt ihn mit aus,
und der Agent vergleicht mit `git diff <commit> HEAD -- <datei>`.
