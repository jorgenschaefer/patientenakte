---
effort: XS
utility: XS
---

# Anamnese prüft erst nach dem Anlegen, ob die Akte ein Git-Repo ist

In `skills/anamnese/SKILL.md:14-21` legt Schritt 1 zuerst `BEURTEILUNG.md`,
`literatur/README.md` und `unterlagen/` an und bricht erst danach ab, wenn das
Verzeichnis kein Git-Repo ist. Die angelegten Dateien bleiben dann liegen. Die
Prüfung gehört an den Anfang.
