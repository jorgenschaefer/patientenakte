---
effort: M
utility: M
---

# AKTE.md und BEURTEILUNG.md lassen sich nicht als Ganzes prüfen

Es gibt keine Möglichkeit, beide Dateien vollständig zu prüfen, inhaltlich
und auf das aktuelle Format. Inhaltlich gibt es für `AKTE.md` nur den Bau
„vollständig zur Kontrolle“ (`skills/akte-aktualisieren/SKILL.md:20`), für
`BEURTEILUNG.md` nichts. Fehler, die vor der Gegenprüfung nach Änderungen
(`agents/gegenpruefung.md`) in die Dateien gekommen sind, findet niemand.

Das Format ändert sich mit dem Plugin, die Akten ziehen aber nicht nach:
`BEURTEILUNG.md` wird einmal bei der Anamnese aus `vorlagen/BEURTEILUNG.md`
kopiert (`skills/anamnese/SKILL.md:15`), und `AKTE.md` wird meist
schrittweise gebaut, sodass ein geänderter Aufbau in `agents/akte.md` nur in
neue Abschnitte gelangt.

Die Prüfung soll ein ausdrücklicher Schritt sein, den der Benutzer anstößt,
nicht beim Start einer Sitzung.
