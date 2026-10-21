---
name: vorsorge
description: Stellt den Plan aus Früherkennung, Impfungen und regelmäßigen Kontrollen auf – nach Alter und Geschlecht, Diagnosen, Medikation, Beruf und Familie –, mit Fälligkeit, Quelle und Kostenträger. Benutzen bei Fragen wie „welche Vorsorge steht an“, „welche Vorsorgeuntersuchungen brauche ich“, „was zahlt die Kasse an Früherkennung“, „wann ist der nächste Check-up“, „welche regelmäßigen Kontrollen sollte ich machen“.
---

# Vorsorge

Den Plan stellt der Subagent `patientenakte:vorsorge` auf; er sucht die
Quellen und trägt ihn unter „Vorsorge“ in `BEURTEILUNG.md` ein. Hier
bleibt, was den Benutzer braucht.

1. Den Subagenten starten. Der Auftrag nennt Angaben aus diesem Gespräch,
   die für die Vorsorge zählen und noch nicht in `AKTE.md` stehen, etwa
   Entwürfe in `unterlagen/` ohne Commit, und, wenn der Benutzer nur nach
   einem Teil gefragt hat, diesen Teil.
2. Die Fragen aus seiner Rückmeldung stellen, wie in `regeln.md`
   beschrieben. Danach den Subagenten noch einmal starten, mit den
   Antworten im Auftrag; weiß der Benutzer keine Antwort, entfällt das.
3. Antworten mit der Tabelle und den Erläuterungen aus der Rückmeldung.
   Eine Quelle, die er nicht herunterladen konnte, behandelst du wie unter
   „Evidenz“ in `regeln.md` beschrieben.
