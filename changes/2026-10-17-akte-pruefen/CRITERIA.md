# Criteria: Akte nachziehen und ohne Befunde prüfen

## Problem

Ändert das Plugin das Format der Anamnese, von `AKTE.md` oder von
`BEURTEILUNG.md`, kommt die Änderung in bestehenden Akten nicht an. Und nach
vielen Gesprächen kann der Benutzer nicht prüfen lassen, ob die beiden
Dateien noch zueinander und zu ihren eigenen Regeln passen. Stattdessen soll
der Benutzer eine bestehende Akte auf den aktuellen Stand des Plugins bringen
und auf solche Verschiebungen prüfen lassen können, ohne dass alle Befunde
gelesen werden müssen.

Der Fall: Seit 4e64bbe fragt die Anamnese nach der psychischen Verfassung
(`skills/anamnese/SKILL.md:50-52`), und `AKTE.md` hat dafür den Abschnitt
„Psychische Verfassung“ (`agents/akte.md:99`). Die echte Akte des Benutzers
hat keine psychische Anamnese; `anamnese.md` bleibt nach der Erstbefragung
unverändert (`skills/anamnese/SKILL.md:8-10`), und nichts im Plugin fragt
danach. Dieselbe Akte hat 12 MB in `unterlagen/`, zu viel für einen
vollständigen Bau; `AKTE.md` und `BEURTEILUNG.md` zusammen sind rund 140 KB.

## Acceptance criteria

- **AC-1** Die Prüfung beginnt nur auf `/akte-pruefen` hin, nie von selbst, auch nicht beim Start einer Sitzung.
- **AC-2** Meldet `akte-stand` beim Aufruf neue oder geänderte Unterlagen oder einen nicht abgeschlossenen Bau, oder hat `unterlagen/` Änderungen ohne Commit, wird das zuerst über `neue-information` oder `akte-aktualisieren` erledigt und danach geprüft.
- **AC-3** Die Prüfung läuft in einer Akte mit 12 MB in `unterlagen/` bis zum Ende durch, mit ihren Gegenprüfungen.
- **AC-4** Sagen weder `anamnese.md` noch `historie.md` noch `AKTE.md` etwas zu einem Punkt des Schemas in `skills/anamnese/SKILL.md`, fragt die Prüfung danach. Ein Punkt ist jede Angabe, die das Schema nennt, etwa „Pflegegrad“ unter „Stammdaten“; eine zusammenfassende Angabe zum Abschnitt, etwa „vegetative Anamnese unauffällig“, deckt dessen Punkte ab. Danach steht die Antwort mit Mitteilungsdatum in `historie.md` und im passenden Abschnitt von `AKTE.md`. Beispiel: die psychische Verfassung in einer Akte, deren Anamnese älter ist als 4e64bbe.
- **AC-5** Ist ein Punkt als „unbekannt“ eingetragen, fragt die Prüfung nicht danach.
- **AC-6** Lehnt der Benutzer eine Angabe ab, steht das mit Datum in `historie.md` und in `AKTE.md` als „keine Angabe“ mit Quelle. Eine spätere Prüfung fragt erst wieder, wenn der Vermerk älter als 12 Monate ist; eine erneute Ablehnung ist ein neuer Vermerk mit neuem Datum.
- **AC-7** Lehnt der Benutzer in der Erstbefragung eine Angabe ab, steht das in `anamnese.md` als „keine Angabe“, statt wegzufallen.
- **AC-8** Jeder dieser Fehler in `AKTE.md` wird gemeldet: Kopf, Name oder Reihenfolge eines Abschnitts weicht vom „Aufbau“ in `agents/akte.md` ab; ein Abschnitt steht nicht im Aufbau; eine Angabe ohne Quelle; eine Quelle in falscher Form oder auf eine Datei, die es nicht gibt; eine veränderliche Angabe ohne Stand-Datum; ein Messwert nicht in der Form aus „Messwerte“; eine überholte Angabe in eigener Zeile; eine doppelte Angabe; zwei Angaben, die sich widersprechen; ein Punkt unter „Offen“ mit abgelaufener Frist.
- **AC-9** Jeder dieser Fehler in `BEURTEILUNG.md` wird gemeldet: Kopf, Hinweis unter einer Überschrift oder Reihenfolge weicht von `vorlagen/BEURTEILUNG.md` ab; ein Abschnitt der Vorlage fehlt; ein Eintrag ohne Datum vorn oder ohne Kennzeichnung; ein Kurzname, der unter „Quellen“ fehlt; eine Quelle ohne Registernummer, Version, Gültigkeit oder Prüfdatum; eine Quelle, deren lokale Datei in `literatur/` fehlt; ein Thema in zwei Einträgen; ein Thema unter „Beobachten“ ohne CSV oder mit anderen Spalten; ein Eintrag, dessen Grundlage `AKTE.md` nicht mehr trägt; ein Punkt unter „Offen“, der laut `AKTE.md` erledigt ist; ein Eintrag, der Allergien, Medikation oder Diagnosen in `AKTE.md` widerspricht.
- **AC-10** Bevor sich eine Datei ändert, nennt die Prüfung alle Funde, getrennt danach, was sie berichtigt, wonach sie fragen wird und was sie nur meldet; bei jedem Fund, den sie berichtigt, steht, was mit ihm geschieht. Danach berichtigt sie ohne weitere Rückfrage.
- **AC-11** Gefragt wird nach fehlenden Punkten der Anamnese, nach Ablehnungen, die älter als 12 Monate sind, nach Punkten unter „Offen“ in `AKTE.md` mit abgelaufener Frist, nach Widersprüchen innerhalb von `AKTE.md` und nach Quellen auf Dateien, die es nicht gibt: einzeln, im Gesprächston. Antworten zum Patienten, auch „erledigt“ oder welche von zwei Angaben gilt, kommen über `neue-information` nach `historie.md`, im Wortlaut vorher bestätigt; nennt der Benutzer zu einer fehlenden Datei die richtige, wird die Quelle in `AKTE.md` berichtigt. Was so beantwortet ist, fragt eine spätere Prüfung nicht noch einmal.
- **AC-12** Alle übrigen Funde berichtigt die Prüfung ohne Rückfrage; ein Abschnitt, der nicht im Aufbau steht, aber zu einem Abschnitt des Aufbaus passt, wird dorthin verschoben. Eine Berichtigung der Form ändert keine Angabe inhaltlich: keinen Wert, keine Einheit, keinen Referenzbereich, keine Diagnosesicherheit und nicht, worauf eine Quelle zeigt.
- **AC-13** Jede Änderung, die die Prüfung an `AKTE.md` oder `BEURTEILUNG.md` macht, läuft vor ihrem Commit durch die Gegenprüfung, und deren Funde werden genannt. Die heutigen Ausnahmen gelten weiter: ein Commit, der nur „Grundlage“ ändert, und die Berichtigung eines Funds der Gegenprüfung.
- **AC-14** Am Ende sind `AKTE.md`, `BEURTEILUNG.md`, `unterlagen/` und `literatur/` committet, und `akte-stand` meldet weder Unterlagen noch einen nicht abgeschlossenen Bau. Die Prüfung fasst zusammen, was berichtigt wurde, die Funde der Gegenprüfungen, was offen geblieben ist und welche Commits entstanden sind; findet sie nichts, sagt sie das in einem Satz.
- **AC-15** Eine zweite Prüfung gleich danach meldet nur, was in der ersten offen geblieben ist.
- **AC-16** Das README nennt `/akte-pruefen` und was die Prüfung tut und was nicht, und sagt zur Erstbefragung, dass eine abgelehnte Angabe als „keine Angabe“ vermerkt wird.
- **AC-17** Nur gemeldet, nicht berichtigt, werden: eine Angabe in `AKTE.md` ohne Quelle; eine Quelle in `BEURTEILUNG.md` ohne Registernummer, Version, Gültigkeit oder Prüfdatum oder ohne Datei in `literatur/`; ein Thema unter „Beobachten“ ohne CSV oder mit anderen Spalten, ohne dass eine CSV geändert wird; ein Abschnitt in `AKTE.md`, der nicht im Aufbau steht und zu keinem Abschnitt des Aufbaus passt. Jeder dieser Funde nennt, was ihn beheben würde, etwa `/leitlinie` oder einen Blick in einen bestimmten Befund, und steht in der Zusammenfassung unter dem, was offen geblieben ist.
- **AC-18** Inhaltliche Funde in `BEURTEILUNG.md` berichtigt die Prüfung so: Ein Eintrag, dessen Grundlage `AKTE.md` nicht mehr trägt, und ein Punkt unter „Offen“, der laut `AKTE.md` erledigt ist, werden gelöscht. Ein Eintrag, der Allergien, Medikation oder Diagnosen widerspricht, wird eingeschränkt und neu datiert oder, wenn nichts von ihm bleibt, gelöscht. Bräuchte es dafür eine neue Empfehlung, wird der Fund nur gemeldet, mit Hinweis auf `/leitlinie`.

## Agreed design

Ein Skill `akte-pruefen` im Hauptagenten, nur vom Benutzer aufrufbar
(`disable-model-invocation: true`). Er prüft `AKTE.md`, `BEURTEILUNG.md`,
`anamnese.md` und `historie.md` gegen die Regeln des Plugins, nennt die
Funde, fragt nach und berichtigt über die vorhandenen Wege, jeweils mit
deren Gegenprüfung: Antworten über `neue-information`, `AKTE.md` wie in
Schritt 7 von `akte-aktualisieren`, `BEURTEILUNG.md` über
`beurteilung-aendern`. Kein neuer Subagent, keine neue Bauart.

`anamnese.md` bleibt unveränderlich; was nachgefragt wird, kommt nach
`historie.md`.

## Technical decisions

- **Stored formats** Neu ist die Ablehnung einer Angabe: in `historie.md` als Eintrag „möchte zu … keine Angaben machen“ mit Mitteilungsdatum, in `anamnese.md` als „keine Angabe“, in `AKTE.md` als „keine Angabe [Quelle]“ im passenden Abschnitt. Bestehende Akten haben keine Vermerke; ihre erste Prüfung fragt jeden fehlenden Punkt, auch früher abgelehnte. Kopf und Hinweise von `BEURTEILUNG.md` und der Aufbau von `AKTE.md` bestehender Akten kommen über die Prüfung selbst auf den aktuellen Stand; sonst keine Migration.
- **Wire formats** Neu ist der Befehl `/akte-pruefen`, nur vom Benutzer aufrufbar. Die Beschreibung von `akte-aktualisieren` greift bei „prüfen“ nur noch für die Prüfung gegen die Befunde. Sonst entfällt nichts.
- **Trust boundaries** Keine. Gelesen werden nur Dateien der Akte und des Plugins; Gesundheitsdaten bleiben im Repo der Akte.
- **Dependencies** Keine.

## Nudges

- Die Prüfliste steht in `skills/akte-pruefen/SKILL.md` und verweist auf die Regeln, statt sie abzuschreiben: Das Format bleibt in `agents/akte.md`, `vorlagen/BEURTEILUNG.md` und im Schema in `skills/anamnese/SKILL.md`, damit eine künftige Formatänderung ohne Änderung des Skills geprüft wird.
- Die Prüfung selbst liest keine Befunde (PDF, JPG, PNG) und von `literatur/` nur `README.md` und die Dateinamen.
- Die Regel für Ablehnungen hat ihren Platz in `skills/anamnese/SKILL.md` neben „unbekannt“ (Zeile 25-26), die Frist von 12 Monaten in `skills/akte-pruefen/SKILL.md`, die Form in `AKTE.md` in `agents/akte.md`.
- Formfehler in `AKTE.md` berichtigt der Hauptagent nach den Regeln des Subagenten `akte`, wie in Schritt 7 von `akte-aktualisieren`, aber mit der vorigen Fassung (`git show HEAD:AKTE.md`) als Quelle der Gegenprüfung. Dafür lässt `agents/gegenpruefung.md` diese Quelle zu; ist sie die Quelle, liest die Gegenprüfung keine Unterlagen, die eine geänderte Angabe zitiert (heute Zeile 29-31). Kein eigener Agent und keine eigene Art von Auftrag. Für `BEURTEILUNG.md` ohne neue Unterlagen nennt der Auftrag an die Gegenprüfung keine Quellen, wie in `regeln.md`, „Gegenprüfung“.
- `regeln.md` erwähnt die Prüfung nicht; sie ist kein Teil der Beratung.

## Out of scope

- Prüfung von `AKTE.md` und `BEURTEILUNG.md` gegen Befunde und Literatur, und der vollständige Bau bei großen Beständen (`changes/backlog/akte-vollstaendig-bauen-und-pruefen.md`).
- Prüfung, ob Leitlinien noch gelten.
- Ein Hinweis beim Start der Sitzung, dass eine Prüfung ansteht.

## Ruled out

- **Ein Subagent prüft, der Hauptagent berichtigt** - die Prüfung läuft in einer eigenen Sitzung, da schützt ein eigener Kontext keine Beratung; verifiziert wird über die Gegenprüfung.
- **Formatstand in der Akte mit einer Liste der Formatänderungen** - die Liste muss bei jeder Änderung gepflegt werden und findet nur, was jemand vermerkt hat.
- **`anamnese.md` veränderlich oder mit Nachträgen** - `AKTE.md` ist schon der fortgeschriebene Stand, und `[anamnese]` verlöre seine Datierung.
- **Ablehnungen nicht vermerken, oder außerhalb der Akte** - die Frage käme bei jeder Prüfung wieder, und eine Beratung wüsste nicht, dass die Lücke gewollt ist.
- **Gegenprüfung einer Formberichtigung gegen die zitierten Unterlagen** - eine Formberichtigung berührt viele Zeilen, die Gegenprüfung läse dann fast alle Befunde; auch in kleinen Commits je Abschnitt, bei „Messwerte“ trotzdem.
- **Keine Gegenprüfung für reine Formänderungen** - ob beim Umstellen etwas verloren ging, prüfte niemand.
- **Ein eigener Agent für die Gegenprüfung einer Formberichtigung** - er doppelte Prompt, Rückmeldung und die Regeln unter „Gegenprüfung“, nur für eine andere Quelle.
- **Funde, die Befunde oder Literatur brauchen, erfragen oder doch berichtigen** - Registernummern und die Herkunft alter Angaben weiß der Benutzer meist nicht; sie nachzutragen hieße Netz und Befunde.
- **Inhaltliche Berichtigungen an `BEURTEILUNG.md` vorher bestätigen lassen, einmal oder einzeln** - der Benutzer will sie ohne Rückfrage, wie in der Beratung; die Liste vorher nennt, was mit jedem Fund geschieht.
- **Nachfrage nach Ablehnungen auch in der Beratung** - wer etwas nicht sagen will, soll nicht bei jeder passenden Frage darauf angesprochen werden.
