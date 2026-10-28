---
effort: S
utility: L
---

# Die Regel „Knapp“ hält BEURTEILUNG.md nicht klein

Der Kopf von `vorlagen/BEURTEILUNG.md:7` verlangt: nur, was eine künftige
Beratung braucht, „nicht die Herleitung und nicht der Weg dahin“, unter
**Leitlinie** ein Satz je Empfehlung. In einer echten Akte hatte
`BEURTEILUNG.md` nach gut zwei Wochen trotzdem etwa 21.000 Wörter, mehr als
doppelt so viel wie `AKTE.md`; „Offen“ allein hatte etwa 8.000.

Die Einträge unter **Modell** enthalten die ganze Herleitung: was für und
gegen eine Ursache spricht, welche Untersuchungen unauffällig waren, und
Angaben des Patienten („laut Patient …“, Ergebnisse eigener Tests). Diese
Angaben gehören nach `unterlagen/historie.md` und von dort in `AKTE.md`.

Idee aus der Überprüfung: eine Höchstlänge, die ein Script prüft, statt
einer Regel in Prosa. `akte-stand --vorlage` (`bin/akte-stand`,
`vorlage_pruefen`) zählt die Wörter je Eintrag und je Abschnitt und meldet
beim Start der Sitzung, was zu lang ist, wie heute eine Abweichung von der
Vorlage; gekürzt wird dann mit `/einarbeiten`. Grenzen etwa: Einschätzung
drei Sätze, je Empfehlung ein Satz. Wer die Herleitung behalten will,
findet sie in der Commit-Nachricht oder in einer Datei, die nicht bei jeder
Beratung gelesen wird.
