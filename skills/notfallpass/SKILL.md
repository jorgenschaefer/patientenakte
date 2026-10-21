---
name: notfallpass
description: Gibt den Text für den Notfallpass auf dem Pixel-Handy aus, Feld für Feld – Blutgruppe, Allergien, Medikamente, medizinische Informationen und die übrigen Felder –, kurz und zum Kopieren. Benutzen, wenn der Benutzer danach fragt, etwa nachdem der Skill einarbeiten es angeboten hat.
---

# Notfallpass

Wer den Notfallpass liest, hat keine Zeit: Rettungsdienst, Notaufnahme,
eine fremde Praxis. Er steht auf dem Sperrbildschirm und soll auf einen
Handybildschirm passen.

1. Aus `AKTE.md` zusammenstellen, nach den Feldern des Notfallpasses auf
   dem Pixel und in deren Reihenfolge, jedes als eigener Block zum
   Kopieren:
   - **Name**
   - **Geburtsdatum**
   - **Blutgruppe**
   - **Größe**
   - **Gewicht**
   - **Allergien:** Auslöser und Reaktion.
   - **Schwangerschaft:** nur, wenn eine besteht, mit Woche.
   - **Medikamente:** alle aus „Medikation → Aktuell“, auch
     Bedarfsmedikation und Nahrungsergänzung, je Zeile Präparat, Wirkstoff,
     Dosis und Schema, etwa `Ibuprofen 400 mg (Ibuprofen) – bei Bedarf,
     max. 3×/Tag`. Darüber der Stand.
   - **Adresse**
   - **Medizinische Informationen:** Diagnosen, die im Notfall zählen, etwa
     Diabetes, Epilepsie, Herzerkrankung, Gerinnungsstörung, ohne
     ausgeheilte Erkrankungen und Nebenbefunde; Implantate und
     Hilfsmittel, die im Notfall zählen (Herzschrittmacher, künstliche
     Herzklappe); Patientenverfügung und Vorsorgevollmacht mit Ort;
     Hausarzt mit Telefonnummer.
   - **Organspender:** wie in `AKTE.md` festgehalten.

   Nur, was in `AKTE.md` steht, ohne Quellen in eckigen Klammern, und nur
   die geltenden Angaben, nie was dort als überholt steht. Keine
   Verneinung, die `AKTE.md` nicht selbst enthält: „keine Allergien“ oder
   „keine Implantate“ nur, wenn es dort so steht; dass etwas fehlt, heißt
   nicht, dass es das nicht gibt. Leere Felder weglassen. Fachbegriffe und
   gängige Abkürzungen sind erlaubt, die Leser sind Fachleute.
2. Immer alle Felder vollständig ausgeben, auch wenn sich nur eines
   geändert hat.
3. Dazu sagen, welche Felder leer geblieben sind; steht im Handy dort
   noch etwas, soll der Benutzer es prüfen und leeren, wenn es nicht mehr
   gilt. Außerdem sagen, dass Notfallkontakte im Handy selbst eingetragen
   werden.
   Nennt der Benutzer etwas Fehlendes, nimmst du es mit dem Skill
   `neue-information` auf.
