---
name: vorsorge
description: Stellt den Plan aus Früherkennung, Impfungen und regelmäßigen Kontrollen auf – nach Alter und Geschlecht, Diagnosen, Medikation, Beruf und Familie –, mit Fälligkeit, Quelle und Kostenträger. Benutzen bei Fragen wie „welche Vorsorge steht an“, „welche Vorsorgeuntersuchungen brauche ich“, „was zahlt die Kasse an Früherkennung“, „wann ist der nächste Check-up“, „welche regelmäßigen Kontrollen sollte ich machen“.
---

# Vorsorge

Vorsorge heißt hier alles, was ohne akuten Anlass regelmäßig oder ab einem
Alter ansteht, nicht nur die gesetzliche Früherkennung. Jede Quelle in
Schritt 2 wird jedes Mal geprüft, auch wenn der Benutzer nur nach einem Teil
fragt; was nicht zutrifft, kommt mit Grund unter „geprüft, ohne Ergebnis“.

1. Übernehmen, was schon steht: „Vorsorge“, „Impfungen und Immunstatus“ und
   „Offen“ in `AKTE.md`, „Vorsorge“, „Beobachten“ und „Offen“ in
   `BEURTEILUNG.md`. Was dort mit nicht veralteter Prüfung steht, nicht neu
   suchen.
2. Die übrigen Quellen mit dem Subagenten `patientenakte:leitlinie` prüfen:
   1. **Alter und Geschlecht:** die Richtlinien des G-BA zu
      Gesundheitsuntersuchung, Krebsfrüherkennung, organisierten
      Früherkennungsprogrammen und Ultraschallscreening; die zahnärztliche
      Untersuchung mit Bonusheft; wo zutreffend Kinder- und
      Jugenduntersuchungen und Schwangerschaftsvorsorge. Dazu die
      Altersgrenzen der nächsten Jahre. Zu jeder dieser Untersuchungen
      außerdem, was die Leitlinien zu den Krankheiten, nach denen die
      Untersuchung sucht, zur Früherkennung bei Menschen ohne diese Diagnose
      empfehlen. Danach im AWMF-Register nach Leitlinien suchen, die für
      Alter und Geschlecht eine Untersuchung ohne Anlass empfehlen, die keine
      Kassenleistung ist, auch nach Leitlinien zu einer Krankheit, die
      Früherkennung oder Screening nicht im Titel tragen.
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
   6. **Darüber hinaus:** Präventionskurse der Kassen; die
      Früherkennungsleistungen, die der IGeL-Monitor des Medizinischen
      Dienstes für Alter und Geschlecht bewertet, mit seiner Bewertung, auch
      für die Selbstzahlerleistungen aus 1. bis 5.; Bonusprogramm und
      Satzungsleistungen der Krankenkasse aus `AKTE.md`, sonst den Benutzer
      danach fragen.

   Gesetze und Kassenregeln im Normtext lesen.
3. Beim Prüfen:
   - **Fälligkeit aus dem Wortlaut** der Quelle berechnen; viele
     Richtlinien rechnen in Kalenderjahren, nicht ab Datum.
   - **Krankheitsbezogene Kontrollen** ersetzen oder verkürzen oft die
     allgemeine Früherkennung; dann nur die eine nennen und sagen, dass die
     Kasse sie meist als Krankenbehandlung zahlt.
   - **Widersprechen sich G-BA und Leitlinie,** beides nennen.
   - **Empfiehlt eine Leitlinie** („soll“, „sollte“ oder „kann“) eine
     Untersuchung, die keine Kassenleistung ist, oder bewertet der
     IGeL-Monitor sie positiv oder tendenziell positiv, kommt sie mit
     Selbstzahler als Kostenträger in die Tabelle. Zahlt die Krankenkasse
     des Benutzers sie als Satzungsleistung oder im Bonusprogramm, steht
     dort Kasse, bei einem Zuschuss mit dessen Höhe. Empfiehlt die Leitlinie
     eine Kassenleistung früher oder öfter, als die Kasse sie zahlt, bleibt
     die Zeile der Kasse, und nur die übrigen Termine kommen in eine eigene
     Zeile mit Selbstzahler. Bewertet der IGeL-Monitor eine Untersuchung
     anders als die Leitlinie, beides nennen.
   - **Hängt ein Intervall an einem Befund,** es daraus bestimmen; ändert
     ein Befund aus der Akte es nicht, das ausdrücklich sagen.
4. Fehlt für eine zutreffende Untersuchung der letzte Termin, danach fragen,
   zusammengehörige in einem Satz, wie in `regeln.md` beschrieben, und die
   Antworten über den Skill `neue-information` aufnehmen.
5. Antworten:
   - eine Tabelle: Untersuchung, Anlass (Alter, Diagnose, Mittel, Beruf),
     zuletzt laut Akte, wieder fällig, Quelle (Kurzname, Empfehlungsnummer,
     Grad), Kostenträger (Kasse, Arbeitgeber, Selbstzahler); Überfälliges
     zuerst, dann nach Fälligkeit;
   - darunter zu jeder Zeile, die eine Abweichung oder Begründung braucht,
     was die Quelle sagt und, getrennt, die Übertragung auf den Fall;
   - „geprüft, ohne Ergebnis“: je Zeile, was und warum nicht;
   - welche Termine lange vorher gebucht werden müssen.
6. Mit dem Skill `beurteilung-aendern` unter „Vorsorge“ eintragen, was neu
   ist oder sich geändert hat, auch „geprüft, ohne Ergebnis“.
