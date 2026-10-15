---
name: notfallpass
description: Gibt den Text für den Notfallpass im Handy aus (Notfallpass auf dem iPhone, Notfallinformationen auf Android) – Erkrankungen, Medikamente, Allergien, Hinweise für den Notfall –, kurz und zum Kopieren. Benutzen, wenn der Benutzer danach fragt, und nach jeder Änderung an Diagnosen, Medikation, Allergien, Implantaten oder Schwangerschaft.
---

# Notfallpass

Wer den Notfallpass liest, hat keine Zeit: Rettungsdienst, Notaufnahme,
eine fremde Praxis. Er steht auf dem Sperrbildschirm und soll auf einen
Handybildschirm passen.

1. `akte-stand` ausführen; meldet es Änderungen, zuerst den Skill
   `akte-aktualisieren`.
2. Aus `AKTE.md` zusammenstellen, nach den Feldern des Notfallpasses, jedes
   als eigener Block zum Kopieren:
   - **Erkrankungen:** Diagnosen, die im Notfall zählen, etwa Diabetes,
     Epilepsie, Herzerkrankung, Gerinnungsstörung. Ausgeheilte Erkrankungen
     und Nebenbefunde weglassen.
   - **Medikamente:** alle aus „Medikation → Aktuell“, auch
     Bedarfsmedikation und Nahrungsergänzung, je Zeile Präparat, Wirkstoff,
     Dosis und Schema, etwa `Ibuprofen 400 mg (Ibuprofen) – bei Bedarf,
     max. 3×/Tag`. Darüber der Stand.
   - **Allergien und Reaktionen:** Auslöser und Reaktion.
   - **Medizinische Hinweise:** Implantate und Hilfsmittel, die im Notfall
     zählen (Herzschrittmacher, künstliche Herzklappe), Schwangerschaft,
     Patientenverfügung und Vorsorgevollmacht mit Ort, Hausarzt mit
     Telefonnummer.
   - **Blutgruppe, Größe, Gewicht,** wenn bekannt.

   Nur, was in `AKTE.md` steht, ohne Quellen in eckigen Klammern. Leere
   Felder weglassen. Fachbegriffe und gängige Abkürzungen sind erlaubt, die
   Leser sind Fachleute.
3. Dazu sagen, welche Felder leer geblieben sind, und dass Notfallkontakte
   und Organspende im Handy selbst eingetragen werden. Nennt der Benutzer
   etwas Fehlendes, kommt es über den Skill `neue-information` in die Akte.
