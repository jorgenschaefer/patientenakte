---
effort: M
utility: XL
---

# Akte nachziehen und ohne Befunde prüfen

Das Format ändert sich mit dem Plugin, die Akten ziehen aber nicht nach:
`BEURTEILUNG.md` wird einmal bei der Anamnese aus `vorlagen/BEURTEILUNG.md`
kopiert (`skills/anamnese/SKILL.md:15`), und `AKTE.md` wird meist
schrittweise gebaut, sodass ein geänderter Aufbau in `agents/akte.md` nur in
neue Abschnitte gelangt; der schrittweise Bau liest nur neue und geänderte
Dateien (`agents/akte.md:16-20`).

Auch `unterlagen/anamnese.md` zieht nicht nach. Seit 4e64bbe fragt die
Anamnese nach der psychischen Verfassung (`skills/anamnese/SKILL.md:50-52`),
und `AKTE.md` hat dafür den Abschnitt „Psychische Verfassung“
(`agents/akte.md:99`). In einer bestehenden Akte bleibt `anamnese.md`
nach der Erstbefragung aber unverändert (`skills/anamnese/SKILL.md:8-10`).
Nach dem neuen Punkt fragt deshalb niemand, und der neue Abschnitt in
`AKTE.md` hat keine Quelle.

Der Benutzer möchte nach einer solchen Änderung nachziehen können, und nach
vielen Gesprächen prüfen, ob `AKTE.md` und `BEURTEILUNG.md` noch stimmen
oder sich verschoben haben. Das ist kein vollständiger Neubau, geht aber in
diese Richtung.

Abgegrenzt nach dem, was ohne die Befunde geht: In einer echten Akte liegen
12 MB in `unterlagen/`, zu viel für einen Subagenten; `AKTE.md` und
`BEURTEILUNG.md` zusammen sind rund 140 KB. Die Prüfung gegen die Befunde
steht unter „AKTE.md gegen die Befunde prüfen und vollständig bauen“
(`changes/backlog/akte-vollstaendig-bauen-und-pruefen.md`). Hier, aus der
Besprechung:

- `AKTE.md` und `BEURTEILUNG.md` gegen den aktuellen Aufbau in
  `agents/akte.md` und `vorlagen/BEURTEILUNG.md` prüfen und nachziehen.
- Fehlende Punkte der Anamnese nachfragen und über `neue-information` in
  `historie.md` eintragen.
- Prüfen, soweit es ohne Befunde geht: ob sich `BEURTEILUNG.md` noch auf
  `AKTE.md` stützt, Überholtes, Widersprüche, Doppeltes, und ob beide den
  eigenen Regeln folgen, etwa bei Kennzeichnung und Stand-Datum.

Die Prüfung soll ein ausdrücklicher Schritt sein, den der Benutzer anstößt,
nicht beim Start einer Sitzung.
