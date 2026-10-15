---
name: vorsorge
description: Stellt den Plan aus Früherkennung, Impfungen und regelmäßigen Kontrollen auf – nach Alter und Geschlecht, Diagnosen, Medikation, Beruf und Familie –, mit Fälligkeit, Quelle und Kostenträger. Benutzen bei Fragen wie „welche Vorsorge steht an“, „welche Vorsorgeuntersuchungen brauche ich“, „was zahlt die Kasse an Früherkennung“, „wann ist der nächste Check-up“, „welche regelmäßigen Kontrollen sollte ich machen“, und aus dem Skill naechste-schritte.
---

# Vorsorge

Vorsorge heißt hier alles, was ohne akuten Anlass regelmäßig oder ab einem
Alter ansteht, nicht nur die gesetzliche Früherkennung. Jede Quelle in
Schritt 3 wird jedes Mal geprüft, auch wenn der Benutzer nur nach einem Teil
fragt; was nicht zutrifft, kommt mit Grund unter „geprüft, ohne Ergebnis“.

1. `akte-stand` ausführen; meldet es Änderungen, zuerst den Skill
   `akte-aktualisieren`.
2. Übernehmen, was schon steht: „Vorsorge“, „Impfungen und Immunstatus“ und
   „Offen“ in `AKTE.md`, „Vorsorge“, „Beobachten“ und „Offen“ in
   `BEURTEILUNG.md`. Was dort mit nicht veralteter Prüfung steht, nicht neu
   suchen.
3. Die übrigen Quellen mit dem Skill `leitlinie` prüfen:
   1. **Alter und Geschlecht:** die Richtlinien des G-BA zu
      Gesundheitsuntersuchung, Krebsfrüherkennung, organisierten
      Früherkennungsprogrammen und Ultraschallscreening; die zahnärztliche
      Untersuchung mit Bonusheft; wo zutreffend Kinder- und
      Jugenduntersuchungen und Schwangerschaftsvorsorge. Dazu die
      Altersgrenzen der nächsten Jahre.
   2. **Jede Diagnose und jeder Nebenbefund** aus `AKTE.md`, auch
      Risikozustände wie ein erhöhtes Diabetesrisiko: die Leitlinie der
      Diagnose, in den Kapiteln zu Verlaufskontrolle, Komplikationen,
      Krebsrisiko, Manifestationen außerhalb des Organs, Mangelzuständen und
      Knochen. Passt keine Leitlinie zur Frage, das sagen.
   3. **Jedes Mittel** unter „Medikation → Aktuell“ und frühere mit
      Spätrisiko: Fachinformation Abschnitt 4.4, dazu 4.2 und 4.8, wo dort
      Kontrollen stehen.
   4. **Lebensumstände:** Familienanamnese mit Verwandtschaftsgrad, Beruf
      und Nebenberuf mit arbeitsmedizinischer Vorsorge, Rauchen, Alkohol,
      Gewicht.
   5. **Impfungen:** Standard- und Indikationsimpfungen der STIKO, bei
      Immunsuppression ihre Anwendungshinweise, abgeglichen mit dem
      Impfstatus.
   6. **Darüber hinaus:** Präventionskurse der Kassen; Selbstzahlerleistungen
      nur, wenn eine Leitlinie einen Nutzen nennt; Bonusprogramm und
      Satzungsleistungen der Krankenkasse aus `AKTE.md`, sonst den Benutzer
      danach fragen.

   Gesetze und Kassenregeln im Normtext lesen.
4. Beim Prüfen:
   - **Fälligkeit aus dem Wortlaut** der Quelle berechnen; viele
     Richtlinien rechnen in Kalenderjahren, nicht ab Datum.
   - **Krankheitsbezogene Kontrollen** ersetzen oder verkürzen oft die
     allgemeine Früherkennung; dann nur die eine nennen und sagen, dass die
     Kasse sie meist als Krankenbehandlung zahlt.
   - **Widersprechen sich G-BA und Leitlinie,** beides nennen.
   - **Hängt ein Intervall an einem Befund,** es daraus bestimmen; ändert
     ein Befund aus der Akte es nicht, das ausdrücklich sagen.
5. Fehlt für eine zutreffende Untersuchung der letzte Termin, danach fragen,
   zusammengehörige in einem Satz, wie in `regeln.md` beschrieben, und die
   Antworten über den Skill `neue-information` aufnehmen.
6. Antworten:
   - eine Tabelle: Untersuchung, Anlass (Alter, Diagnose, Mittel, Beruf),
     zuletzt laut Akte, wieder fällig, Quelle (Kurzname, Empfehlungsnummer,
     Grad), Kostenträger (Kasse, Arbeitgeber, Selbstzahler); Überfälliges
     zuerst, dann nach Fälligkeit;
   - darunter zu jeder Zeile, die eine Abweichung oder Begründung braucht,
     was die Quelle sagt und, getrennt, die Übertragung auf den Fall;
   - „geprüft, ohne Ergebnis“: je Zeile, was und warum nicht;
   - welche Termine lange vorher gebucht werden müssen.
7. Unter „Vorsorge“ in `BEURTEILUNG.md` eintragen, was neu ist oder sich
   geändert hat, auch „geprüft, ohne Ergebnis“. Was an anderer Stelle in
   `BEURTEILUNG.md` steht, dort lassen und darauf verweisen. Committen.
