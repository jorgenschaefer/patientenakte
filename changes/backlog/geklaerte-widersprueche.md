---
effort: XS
utility: M
---

# Geklärte Widersprüche werden dem Benutzer als offen gemeldet

`agents/akte.md` lässt einen Widerspruch, der für die Behandlung zählt, mit
beiden Quellen in `AKTE.md` sichtbar, auch wenn eine neuere oder
korrigierende Angabe ihn auflöst (Abschnitt „Regeln“, „Widersprüche“). Die
Rückmeldung (`agents/akte.md:80-81`) verlangt dann „Widersprüche und
Unklarheiten, die der Benutzer klären sollte“, ohne geklärte von offenen zu
trennen. Der Subagent meldet deshalb jeden sichtbaren Widerspruch als
klärungsbedürftig, auch wenn die Klärung schon in `unterlagen/` steht.

Beim vollständigen Neubau einer Akte (15.10.2026) kamen so zwei Punkte als
„zu klären“ zurück, die der Benutzer längst beantwortet hatte: ein
Widerspruch zwischen einem Befund und der Aussage von Patient und Arzt, den
Anamnese und `historie.md` schon auflösten, und eine im Scan schwer lesbare
Angabe, die der Benutzer in `historie.md` schon ergänzt hatte. Der Subagent
hatte beide Klärungen selbst mit Quelle in `AKTE.md` übernommen.

`skills/akte-aktualisieren/SKILL.md:27-34` (Schritt 4) gibt die gemeldeten
Widersprüche ungeprüft an den Benutzer weiter. Die Hauptsitzung hat ihm
daraus Fragen gestellt, ohne vorher in `unterlagen/` nachzusehen; der
Benutzer musste selbst darauf hinweisen, dass die Antworten schon dastanden.

Überlegung aus dem Gespräch: in der Rückmeldung nur Widersprüche und
Unklarheiten melden, die keine Unterlage auflöst; geklärte bleiben in
`AKTE.md` sichtbar, kommen aber nicht in die Rückmeldung. Dazu in Schritt 4
von `akte-aktualisieren`: bevor ein gemeldeter Punkt dem Benutzer als Frage
gestellt wird, in `unterlagen/` prüfen, ob er schon geklärt ist.
