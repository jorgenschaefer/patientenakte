---
criteria:  CRITERIA.md
closes:    AC-1, AC-2, AC-3, AC-4, AC-5, AC-6, AC-7, AC-8, AC-9, AC-10, AC-11, AC-12, AC-13, AC-14
advances:
after:
status:    ready
attempts:  0
---

## Build
Ein Agent `patientenakte:gegenpruefung`, der eine Änderung an `AKTE.md` oder `BEURTEILUNG.md` in frischem Kontext gegen ihre Quellen und gegen beide Dateien prüft, dazu die Regeln, die ihn vor jedem Ok für `AKTE.md` und vor jedem Commit an `BEURTEILUNG.md` aufrufen und seine Funde verarbeiten.

## Done when
> **AC-1** Vor jeder Bitte an den Benutzer um das Ok für `AKTE.md` prüft ein Agent in frischem Kontext die Änderung: nach einem schrittweisen oder vollständigen Bau, nach dem Durchsehen eines liegen gebliebenen Baus und nach einer Berichtigung aus dem Bau „vollständig zur Kontrolle“.

> **AC-2** Vor jedem Commit, der `BEURTEILUNG.md` ändert, läuft dieselbe Prüfung, gleich aus welchem Skill oder aus der freien Beratung. Ausgenommen ist der Commit, der `BEURTEILUNG.md` in einer neuen Akte aus der Vorlage anlegt.

> **AC-3** Der Auftrag an den Prüfer enthält die geänderte Datei, den Diff und die Quellen der Änderung, aber nicht die Begründungen oder Überlegungen des Modells, das die Änderung gemacht hat. Quellen der Änderung sind bei einem schrittweisen Bau die gemeldeten Unterlagen, bei einem vollständigen Bau alle Unterlagen, beim Durchsehen eines liegen gebliebenen Baus die Unterlagen, deren Prüfsumme im Abschnitt „Grundlage“ gegenüber dem letzten Commit von `AKTE.md` neu oder geändert ist, bei einer Berichtigung aus dem Bau „vollständig zur Kontrolle“ alle Unterlagen, bei `BEURTEILUNG.md` die Unterlagen, die im selben Commit neu oder geändert sind.

> **AC-4** Der Prüfer liest `AKTE.md` und `BEURTEILUNG.md` ganz und die Quellen der Änderung vollständig. Ältere Unterlagen und Stellen in `literatur/` liest er nur, soweit eine geänderte Angabe sie zitiert. Andere Unterlagen und andere Literatur nennt der Auftrag nicht.

> **AC-5** Steht in einer Quelle der Änderung eine Angabe, die `AKTE.md` nach `agents/akte.md` führen müsste und die dort fehlt, meldet der Prüfer sie.

> **AC-6** In `AKTE.md` meldet der Prüfer mindestens außerdem: einen Wert, eine Einheit oder einen Referenzbereich, der von der Quelle abweicht; eine Quelle in eckigen Klammern, in der die Angabe nicht steht; eine Schlussfolgerung, die als Fakt dasteht; ein fehlendes Stand-Datum bei einer veränderlichen Angabe; eine Angabe, die eine neue Unterlage überholt hat und die stehen geblieben ist; einen Widerspruch zu einer unveränderten Angabe; einen Eintrag in `BEURTEILUNG.md`, dem eine neue Angabe in `AKTE.md` widerspricht.

> **AC-7** In `BEURTEILUNG.md` meldet der Prüfer mindestens: einen als **Leitlinie** gekennzeichneten Eintrag, dessen Aussage so nicht an der genannten Stelle der Quelle steht; eine Empfehlungsnummer, einen Empfehlungsgrad oder ein Evidenzniveau, das von der Quelle abweicht; einen Widerspruch zu `AKTE.md`, etwa zu Allergien, Medikation oder Diagnosen; einen bestehenden Eintrag, den eine neue Angabe betrifft und der nicht angepasst wurde. Weicht eine Unterlage aus demselben Commit von `AKTE.md` ab, gilt die Unterlage; die Abweichung allein ist kein Fund.

> **AC-8** Jeder Fund nennt Datei, Stelle und die Fundstelle in der Quelle, die ihn belegt. Liegt eine zitierte Quelle nicht lokal vor, meldet der Prüfer den Eintrag als nicht prüfbar, statt ihn zu bestätigen.

> **AC-9** Der Prüfer ändert keine Datei der Akte.

> **AC-10** Das Hauptmodell prüft jeden Fund an der Quelle, berichtigt die bestätigten und nennt dem Benutzer alle Funde: die berichtigten mit der Berichtigung, die verworfenen mit Grund, die nicht prüfbaren als ungeprüft mit Grund. Bei `AKTE.md` geschieht das vor der Bitte um das Ok, bei `BEURTEILUNG.md` vor dem Commit.

> **AC-11** Hat der Prüfer nichts gefunden, sagt das Hauptmodell das dem Benutzer in einem Satz.

> **AC-12** Nach einer Berichtigung läuft der Prüfer für dieselbe Änderung nicht noch einmal.

> **AC-13** `BEURTEILUNG.md` wird weiterhin ohne Ok des Benutzers committet.

> **AC-14** Scheitert der Prüfer oder gibt er kein Ergebnis zurück, sagt das Hauptmodell dem Benutzer, dass die Prüfung nicht gelaufen ist, und meldet nicht „nichts gefunden“. Danach geht der Ablauf weiter: Bei `AKTE.md` folgt die Bitte um das Ok, bei `BEURTEILUNG.md` der Commit.

## Technical decisions
> **Stored formats** Keine. Der Aufbau von `AKTE.md` und `BEURTEILUNG.md` bleibt, und es kommen keine neuen Dateien in die Akte.

> **Wire formats** Keine.

> **Trust boundaries** Keine neuen. Der Prüfer liest dieselben Gesundheitsdaten wie der Agent `akte`, in derselben Sitzung, und ruft nichts außerhalb ab.

> **Dependencies** Keine.

## Nudges
> Ein Agent für beide Dateien, `agents/gegenpruefung.md` (`patientenakte:gegenpruefung`); der Auftrag nennt, welche Datei geprüft wird. Werkzeuge Read, Grep, Glob und Bash, ohne Write und Edit.

> Was als Fehler gilt, formuliert der Prüfer nicht neu: `AKTE.md` prüft er gegen die Regeln in `agents/akte.md`, `BEURTEILUNG.md` gegen den Kopf der Datei und den Abschnitt „Evidenz“ in `regeln.md`.

> Die Regel, vor jedem Commit an `BEURTEILUNG.md` prüfen zu lassen, steht einmal in `regeln.md`, bei „`BEURTEILUNG.md` änderst du frei“ und der Commit-Regel. Die Skills, die committen, wiederholen sie nicht; nur `akte-aktualisieren` ruft den Prüfer ausdrücklich in Schritt 4 auf.

> In `skills/akte-aktualisieren/SKILL.md`, Schritt 4, entfällt das eigene Nachlesen von Messwerten und Dosierungen durch das Hauptmodell; das übernimmt der Prüfer.

> Der Abschnitt „Aufbau“ im `README.md` nennt den neuen Agenten.

## Context
Das Plugin besteht aus Regeln und Prompts, nicht aus Code: `regeln.md` (von einem SessionStart-Hook in jede Sitzung eingespielt), die Skills unter `skills/`, bisher ein Agent, `agents/akte.md`, der `AKTE.md` aus `unterlagen/` baut, und das Script `bin/akte-stand`. Der neue Agent liegt neben `agents/akte.md` und folgt dessen Aufbau (Frontmatter mit `name`, `description`, `tools`).

Heute prüft nur das Modell, das die Änderung gemacht hat: in `skills/akte-aktualisieren/SKILL.md`, Schritt 4, liest es neue Messwerte und Dosierungen selbst nach; für `BEURTEILUNG.md` steht in `regeln.md` unter „# Regeln“ nur „`BEURTEILUNG.md` änderst du frei …“, dazu die Commit-Regel am Ende desselben Abschnitts.

Die Abläufe, die dieses Ticket berührt:

- `akte-aktualisieren` kennt drei Arten des Baus (schrittweise, vollständig, vollständig zur Kontrolle in eine Datei im Scratchpad) und den liegen gebliebenen Bau: einer, der nicht bis Schritt 5 kam; `akte-stand --aktualisieren` hat dann schon die Prüfsummen im Abschnitt „Grundlage“ von `AKTE.md` eingetragen, die gemeldeten Dateien nennt `akte-stand` nicht mehr, und welche Unterlagen der Bau gelesen hat, zeigt `git diff AKTE.md` an den neuen oder geänderten Prüfsummen. Schritt 4 zeigt dem Benutzer die Änderungen und bittet um das Ok, Schritt 5 committet.
- `BEURTEILUNG.md` wird ohne Ok committet aus `neue-information` (Schritt 7, zusammen mit den neuen Unterlagen), `vorsorge`, `leitlinie`, `naechste-schritte` und der freien Beratung. `anamnese` legt sie aus `vorlagen/BEURTEILUNG.md` an; dieser Commit ist ausgenommen.
- Im Ablauf von `neue-information` läuft der Prüfer also zweimal: einmal für `BEURTEILUNG.md` vor dem Commit der Unterlagen, danach in `akte-aktualisieren` für `AKTE.md`.

Ein Test im Sinne von `tests/check.sh` ist für Prompts nicht möglich, und Evals für den Prüfer sind ausdrücklich nicht Teil dieser Änderung; wie die ACs geprüft wurden, gehört unter `## Left standing`.

## Not here
- Die vollständige Prüfung der bestehenden Dateien, inhaltlich und auf das aktuelle Format (`changes/backlog/akte-vollstaendig-pruefen.md`). Der Prüfer sieht sich die ganzen Dateien an, um Widersprüche zur Änderung zu finden, nicht, um Altbestand zu prüfen.
- Evals für den Prüfer.
- Einträge in `unterlagen/`; deren Wortlaut bestätigt der Benutzer schon vor dem Schreiben.
- Kein Hook, kein Script und keine Markierung in der Akte, die den Commit bis zur Prüfung sperrt; die Regel steht in `regeln.md` und in Schritt 4 von `akte-aktualisieren`.
- Die übrigen Skills, die `BEURTEILUNG.md` committen, bekommen keinen eigenen Aufruf des Prüfers.

## Left standing
