---
criteria:  CRITERIA.md
closes:    AC-1, AC-2, AC-3, AC-4, AC-5, AC-6, AC-7, AC-8, AC-9, AC-10, AC-11, AC-12, AC-13, AC-14, AC-15, AC-16, AC-17, AC-18
advances:
after:
status:    ready
attempts:  0
---

## Build
Der Befehl `/akte-pruefen`: ein Skill im Hauptagenten, nur vom Benutzer aufrufbar, der `AKTE.md`, `BEURTEILUNG.md`, `anamnese.md` und `historie.md` ohne Befunde gegen die Regeln des Plugins prüft, die Funde nennt, nachfragt und über die vorhandenen Wege berichtigt. Dazu die Ablehnung einer Angabe als neues gespeichertes Format, in der Erstbefragung wie in der Prüfung.

## Done when

> **AC-1** Die Prüfung beginnt nur auf `/akte-pruefen` hin, nie von selbst, auch nicht beim Start einer Sitzung.

> **AC-2** Meldet `akte-stand` beim Aufruf neue oder geänderte Unterlagen oder einen nicht abgeschlossenen Bau, oder hat `unterlagen/` Änderungen ohne Commit, wird das zuerst über `neue-information` oder `akte-aktualisieren` erledigt und danach geprüft.

> **AC-3** Die Prüfung läuft in einer Akte mit 12 MB in `unterlagen/` bis zum Ende durch, mit ihren Gegenprüfungen.

> **AC-4** Sagen weder `anamnese.md` noch `historie.md` noch `AKTE.md` etwas zu einem Punkt des Schemas in `skills/anamnese/SKILL.md`, fragt die Prüfung danach. Ein Punkt ist jede Angabe, die das Schema nennt, etwa „Pflegegrad“ unter „Stammdaten“; eine zusammenfassende Angabe zum Abschnitt, etwa „vegetative Anamnese unauffällig“, deckt dessen Punkte ab. Danach steht die Antwort mit Mitteilungsdatum in `historie.md` und im passenden Abschnitt von `AKTE.md`. Beispiel: die psychische Verfassung in einer Akte, deren Anamnese älter ist als 4e64bbe.

> **AC-5** Ist ein Punkt als „unbekannt“ eingetragen, fragt die Prüfung nicht danach.

> **AC-6** Lehnt der Benutzer eine Angabe ab, steht das mit Datum in `historie.md` und in `AKTE.md` als „keine Angabe“ mit Quelle. Eine spätere Prüfung fragt erst wieder, wenn der Vermerk älter als 12 Monate ist; eine erneute Ablehnung ist ein neuer Vermerk mit neuem Datum.

> **AC-7** Lehnt der Benutzer in der Erstbefragung eine Angabe ab, steht das in `anamnese.md` als „keine Angabe“, statt wegzufallen.

> **AC-8** Jeder dieser Fehler in `AKTE.md` wird gemeldet: Kopf, Name oder Reihenfolge eines Abschnitts weicht vom „Aufbau“ in `agents/akte.md` ab; ein Abschnitt steht nicht im Aufbau; eine Angabe ohne Quelle; eine Quelle in falscher Form oder auf eine Datei, die es nicht gibt; eine veränderliche Angabe ohne Stand-Datum; ein Messwert nicht in der Form aus „Messwerte“; eine überholte Angabe in eigener Zeile; eine doppelte Angabe; zwei Angaben, die sich widersprechen; ein Punkt unter „Offen“ mit abgelaufener Frist.

> **AC-9** Jeder dieser Fehler in `BEURTEILUNG.md` wird gemeldet: Kopf, Hinweis unter einer Überschrift oder Reihenfolge weicht von `vorlagen/BEURTEILUNG.md` ab; ein Abschnitt der Vorlage fehlt; ein Eintrag ohne Datum vorn oder ohne Kennzeichnung; ein Kurzname, der unter „Quellen“ fehlt; eine Quelle ohne Registernummer, Version, Gültigkeit oder Prüfdatum; eine Quelle, deren lokale Datei in `literatur/` fehlt; ein Thema in zwei Einträgen; ein Thema unter „Beobachten“ ohne CSV oder mit anderen Spalten; ein Eintrag, dessen Grundlage `AKTE.md` nicht mehr trägt; ein Punkt unter „Offen“, der laut `AKTE.md` erledigt ist; ein Eintrag, der Allergien, Medikation oder Diagnosen in `AKTE.md` widerspricht.

> **AC-10** Bevor sich eine Datei ändert, nennt die Prüfung alle Funde, getrennt danach, was sie berichtigt, wonach sie fragen wird und was sie nur meldet; bei jedem Fund, den sie berichtigt, steht, was mit ihm geschieht. Danach berichtigt sie ohne weitere Rückfrage.

> **AC-11** Gefragt wird nach fehlenden Punkten der Anamnese, nach Ablehnungen, die älter als 12 Monate sind, nach Punkten unter „Offen“ in `AKTE.md` mit abgelaufener Frist, nach Widersprüchen innerhalb von `AKTE.md` und nach Quellen auf Dateien, die es nicht gibt: einzeln, im Gesprächston. Antworten zum Patienten, auch „erledigt“ oder welche von zwei Angaben gilt, kommen über `neue-information` nach `historie.md`, im Wortlaut vorher bestätigt; nennt der Benutzer zu einer fehlenden Datei die richtige, wird die Quelle in `AKTE.md` berichtigt. Was so beantwortet ist, fragt eine spätere Prüfung nicht noch einmal.

> **AC-12** Alle übrigen Funde berichtigt die Prüfung ohne Rückfrage; ein Abschnitt, der nicht im Aufbau steht, aber zu einem Abschnitt des Aufbaus passt, wird dorthin verschoben. Eine Berichtigung der Form ändert keine Angabe inhaltlich: keinen Wert, keine Einheit, keinen Referenzbereich, keine Diagnosesicherheit und nicht, worauf eine Quelle zeigt.

> **AC-13** Jede Änderung, die die Prüfung an `AKTE.md` oder `BEURTEILUNG.md` macht, läuft vor ihrem Commit durch die Gegenprüfung, und deren Funde werden genannt. Die heutigen Ausnahmen gelten weiter: ein Commit, der nur „Grundlage“ ändert, und die Berichtigung eines Funds der Gegenprüfung.

> **AC-14** Am Ende sind `AKTE.md`, `BEURTEILUNG.md`, `unterlagen/` und `literatur/` committet, und `akte-stand` meldet weder Unterlagen noch einen nicht abgeschlossenen Bau. Die Prüfung fasst zusammen, was berichtigt wurde, die Funde der Gegenprüfungen, was offen geblieben ist und welche Commits entstanden sind; findet sie nichts, sagt sie das in einem Satz.

> **AC-15** Eine zweite Prüfung gleich danach meldet nur, was in der ersten offen geblieben ist.

> **AC-16** Das README nennt `/akte-pruefen` und was die Prüfung tut und was nicht, und sagt zur Erstbefragung, dass eine abgelehnte Angabe als „keine Angabe“ vermerkt wird.

> **AC-17** Nur gemeldet, nicht berichtigt, werden: eine Angabe in `AKTE.md` ohne Quelle; eine Quelle in `BEURTEILUNG.md` ohne Registernummer, Version, Gültigkeit oder Prüfdatum oder ohne Datei in `literatur/`; ein Thema unter „Beobachten“ ohne CSV oder mit anderen Spalten, ohne dass eine CSV geändert wird; ein Abschnitt in `AKTE.md`, der nicht im Aufbau steht und zu keinem Abschnitt des Aufbaus passt. Jeder dieser Funde nennt, was ihn beheben würde, etwa `/leitlinie` oder einen Blick in einen bestimmten Befund, und steht in der Zusammenfassung unter dem, was offen geblieben ist.

> **AC-18** Inhaltliche Funde in `BEURTEILUNG.md` berichtigt die Prüfung so: Ein Eintrag, dessen Grundlage `AKTE.md` nicht mehr trägt, und ein Punkt unter „Offen“, der laut `AKTE.md` erledigt ist, werden gelöscht. Ein Eintrag, der Allergien, Medikation oder Diagnosen widerspricht, wird eingeschränkt und neu datiert oder, wenn nichts von ihm bleibt, gelöscht. Bräuchte es dafür eine neue Empfehlung, wird der Fund nur gemeldet, mit Hinweis auf `/leitlinie`.

## Technical decisions

> **Stored formats** Neu ist die Ablehnung einer Angabe: in `historie.md` als Eintrag „möchte zu … keine Angaben machen“ mit Mitteilungsdatum, in `anamnese.md` als „keine Angabe“, in `AKTE.md` als „keine Angabe [Quelle]“ im passenden Abschnitt. Bestehende Akten haben keine Vermerke; ihre erste Prüfung fragt jeden fehlenden Punkt, auch früher abgelehnte. Kopf und Hinweise von `BEURTEILUNG.md` und der Aufbau von `AKTE.md` bestehender Akten kommen über die Prüfung selbst auf den aktuellen Stand; sonst keine Migration.

> **Wire formats** Neu ist der Befehl `/akte-pruefen`, nur vom Benutzer aufrufbar. Die Beschreibung von `akte-aktualisieren` greift bei „prüfen“ nur noch für die Prüfung gegen die Befunde. Sonst entfällt nichts.

> **Trust boundaries** Keine. Gelesen werden nur Dateien der Akte und des Plugins; Gesundheitsdaten bleiben im Repo der Akte.

> **Dependencies** Keine.

## Nudges

> Die Prüfliste steht in `skills/akte-pruefen/SKILL.md` und verweist auf die Regeln, statt sie abzuschreiben: Das Format bleibt in `agents/akte.md`, `vorlagen/BEURTEILUNG.md` und im Schema in `skills/anamnese/SKILL.md`, damit eine künftige Formatänderung ohne Änderung des Skills geprüft wird.

> Die Prüfung selbst liest keine Befunde (PDF, JPG, PNG) und von `literatur/` nur `README.md` und die Dateinamen.

> Die Regel für Ablehnungen hat ihren Platz in `skills/anamnese/SKILL.md` neben „unbekannt“ (Zeile 25-26), die Frist von 12 Monaten in `skills/akte-pruefen/SKILL.md`, die Form in `AKTE.md` in `agents/akte.md`.

> Formfehler in `AKTE.md` berichtigt der Hauptagent nach den Regeln des Subagenten `akte`, wie in Schritt 7 von `akte-aktualisieren`, aber mit der vorigen Fassung (`git show HEAD:AKTE.md`) als Quelle der Gegenprüfung. Dafür lässt `agents/gegenpruefung.md` diese Quelle zu; ist sie die Quelle, liest die Gegenprüfung keine Unterlagen, die eine geänderte Angabe zitiert (heute Zeile 29-31). Kein eigener Agent und keine eigene Art von Auftrag. Für `BEURTEILUNG.md` ohne neue Unterlagen nennt der Auftrag an die Gegenprüfung keine Quellen, wie in `regeln.md`, „Gegenprüfung“.

> `regeln.md` erwähnt die Prüfung nicht; sie ist kein Teil der Beratung.

## Context
Das vereinbarte Design: Ein Skill `akte-pruefen` im Hauptagenten, nur vom Benutzer aufrufbar (`disable-model-invocation: true`). Er prüft `AKTE.md`, `BEURTEILUNG.md`, `anamnese.md` und `historie.md` gegen die Regeln des Plugins, nennt die Funde, fragt nach und berichtigt über die vorhandenen Wege, jeweils mit deren Gegenprüfung: Antworten über `neue-information`, `AKTE.md` wie in Schritt 7 von `akte-aktualisieren`, `BEURTEILUNG.md` über `beurteilung-aendern`. Kein neuer Subagent, keine neue Bauart. `anamnese.md` bleibt unveränderlich; was nachgefragt wird, kommt nach `historie.md`.

Der Anlass: Seit 4e64bbe fragt die Anamnese nach der psychischen Verfassung, und `AKTE.md` hat dafür „Psychische Verfassung“. Die echte Akte des Benutzers hat keine psychische Anamnese, 12 MB in `unterlagen/` und rund 140 KB in `AKTE.md` und `BEURTEILUNG.md` zusammen.

Was es schon gibt:

- Skills liegen als `skills/<name>/SKILL.md` mit Frontmatter `name` und `description`; noch keiner setzt `disable-model-invocation`. Das README zählt die Skills unter „Aufbau“ auf und beschreibt die Erstbefragung unter „Das erste Gespräch“; dort steht heute „was man nicht sagen will, bleibt weg“.
- `skills/anamnese/SKILL.md`: Schritt 3 (Zeile 25-26) regelt „unbekannt“ und lässt Abgelehntes heute wegfallen; das Schema (Zeile 32-62) ist die Liste der Punkte, gegen die AC-4 prüft; `anamnese.md` bleibt nach der Erstbefragung unverändert (Zeile 8-10).
- `agents/akte.md`: „Regeln“ (Quellen, Stand, Messwerte, Widersprüche mit „überholt“ in derselben Zeile, „Offen“ mit Frist) und „Aufbau“ (Zeile 84-110, „Abschnitte ohne Inhalt lässt du weg“) sind die Regeln, gegen die AC-8 prüft. Eine Form für „keine Angabe“ gibt es dort noch nicht.
- `vorlagen/BEURTEILUNG.md` ist Kopf, Hinweise und Reihenfolge, gegen die AC-9 prüft; Form der Einträge und Quellen steht in `skills/beurteilung-aendern/SKILL.md`, „Eintragen“.
- `skills/akte-aktualisieren/SKILL.md`: Schritt 4 startet die Gegenprüfung und nimmt einen Commit aus, der nur „Grundlage“ ändert; Schritt 7 ist der Weg, auf dem der Hauptagent `AKTE.md` selbst nach den Regeln des Subagenten `akte` berichtigt und ab Schritt 4 weitergeht. Seine Beschreibung greift heute auch bei „AKTE.md … prüfen lassen“.
- `skills/beurteilung-aendern/SKILL.md`, „Abschließen“: Gegenprüfung vor dem Commit, mit den Ausnahmen Anlage aus der Vorlage und Berichtigung eines Funds der Gegenprüfung.
- `skills/neue-information/SKILL.md`: zeigt jeden Eintrag für `historie.md` und hängt ihn erst nach Bestätigung des Wortlauts an; danach zieht es `BEURTEILUNG.md` und über `akte-aktualisieren` `AKTE.md` nach, schrittweise und mit Gegenprüfung gegen `historie.md`.
- `agents/gegenpruefung.md`: „Auftrag“ (Zeile 12-23) nennt als Quellen meist Dateien in `unterlagen/`; „Lesen“ (Zeile 29-31) liest ältere Unterlagen, die eine geänderte Angabe zitiert. Eine vorige Fassung von `AKTE.md` als Quelle kennt es noch nicht.
- `regeln.md`, „Gegenprüfung“: wie Funde der Gegenprüfung berichtigt und dem Benutzer genannt werden, und was gilt, wenn sie scheitert.
- `bin/akte-stand` meldet neue, geänderte und entfernte Unterlagen und einen nicht abgeschlossenen Bau; `hooks/regeln-einspielen` ruft es beim Start jeder Sitzung auf.
- `regeln.md` (Zeile 116-122) lässt eine Mitteilung des Patienten nur nach `unterlagen/` kommen, wenn sie neu und von Belang ist, und `neue-information` wendet das in Schritt 1 an. Eine Ablehnung passt in keine der dort genannten Arten, eine unauffällige Antwort wie „kein Nachtschweiß“ womöglich auch nicht. So, wie es heute steht, würde `neue-information` die Antworten auf die Fragen der Prüfung also verwerfen, und AC-4, AC-6, AC-11 und AC-15 hingen davon ab, dass sie ankommen. Wo das aufgelöst wird, entscheidet der Build; der Nudge zu `regeln.md` gilt dabei.
- Wo eine Antwort in `AKTE.md` landet, entscheidet wie bei jedem Eintrag in `historie.md` der Subagent `akte` nach seinem „Aufbau“. Für einige Abschnitte des Schemas, etwa „Aktuelle Beschwerden“, „Vegetative Anamnese“ und „Operationen, Krankenhaus- und Reha-Aufenthalte“, hat der Aufbau keinen gleichnamigen Abschnitt; diese Zuordnung macht der Subagent schon heute beim Bau aus `anamnese.md`.
- `tests/check.sh` testet nur `bin/akte-stand` und läuft shellcheck; für das Verhalten der Skills gibt es keinen automatischen Test (`changes/backlog/testakte-evals.md` ist der Backlog-Eintrag dazu).

## Not here
- Prüfung von `AKTE.md` und `BEURTEILUNG.md` gegen Befunde und Literatur, und der vollständige Bau bei großen Beständen (`changes/backlog/akte-vollstaendig-bauen-und-pruefen.md`).
- Prüfung, ob Leitlinien noch gelten.
- Ein Hinweis beim Start der Sitzung, dass eine Prüfung ansteht.
- `hooks/regeln-einspielen` bleibt, wie es ist.
- Kein neuer Abschnitt im „Aufbau“ von `agents/akte.md`.

## Left standing
