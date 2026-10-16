# Criteria: Gegenprüfung nach Änderungen an AKTE.md und BEURTEILUNG.md

## Problem

Jede spätere Beratung nimmt `AKTE.md` und `BEURTEILUNG.md` als Grundlage
(`regeln.md:38`, `agents/akte.md:7-9`). Beim Ändern einer der beiden Dateien
kann ein Fehler hineinkommen: eine Angabe aus den Unterlagen, die fehlt, ein
falsch übernommener Wert, eine falsche Quelle in eckigen Klammern, eine
Schlussfolgerung, die in `AKTE.md` als Fakt steht, oder eine Empfehlung in
`BEURTEILUNG.md`, die so nicht in der Quelle steht. Heute sucht nur das
Modell nach solchen Fehlern, das die Änderung gemacht hat. In `AKTE.md` prüft
es dabei nur Messwerte und Dosierungen
(`skills/akte-aktualisieren/SKILL.md`, Schritt 4), in `BEURTEILUNG.md` gar
nichts (`regeln.md:105`). Der Benutzer sieht den Diff von `AKTE.md`, kann aber
nicht jede Angabe an der Quelle nachlesen. Stattdessen soll ein solcher
Fehler gefunden werden, bevor die Änderung committet ist und weitere
Beratungen darauf aufbauen.

Der Fall: Eine Angabe des Benutzers stand schon in `unterlagen/`, fehlte
aber in `AKTE.md`. In einer späteren Sitzung wurde er deshalb noch einmal
danach gefragt. Welche Akte und welche Angabe es war, ist nicht festgehalten.

## Acceptance criteria

- **AC-1** Vor jeder Bitte an den Benutzer um das Ok für `AKTE.md` prüft ein Agent in frischem Kontext die Änderung: nach einem schrittweisen oder vollständigen Bau, nach dem Durchsehen eines liegen gebliebenen Baus und nach einer Berichtigung aus dem Bau „vollständig zur Kontrolle“.
- **AC-2** Vor jedem Commit, der `BEURTEILUNG.md` ändert, läuft dieselbe Prüfung, gleich aus welchem Skill oder aus der freien Beratung. Ausgenommen ist der Commit, der `BEURTEILUNG.md` in einer neuen Akte aus der Vorlage anlegt.
- **AC-3** Der Auftrag an den Prüfer enthält die geänderte Datei, den Diff und die Quellen der Änderung, aber nicht die Begründungen oder Überlegungen des Modells, das die Änderung gemacht hat. Quellen der Änderung sind bei einem schrittweisen Bau die gemeldeten Unterlagen, bei einem vollständigen Bau alle Unterlagen, beim Durchsehen eines liegen gebliebenen Baus die Unterlagen, deren Prüfsumme im Abschnitt „Grundlage“ gegenüber dem letzten Commit von `AKTE.md` neu oder geändert ist, bei einer Berichtigung aus dem Bau „vollständig zur Kontrolle“ alle Unterlagen, bei `BEURTEILUNG.md` die Unterlagen, die im selben Commit neu oder geändert sind.
- **AC-4** Der Prüfer liest `AKTE.md` und `BEURTEILUNG.md` ganz und die Quellen der Änderung vollständig. Ältere Unterlagen und Stellen in `literatur/` liest er nur, soweit eine geänderte Angabe sie zitiert. Andere Unterlagen und andere Literatur nennt der Auftrag nicht.
- **AC-5** Steht in einer Quelle der Änderung eine Angabe, die `AKTE.md` nach `agents/akte.md` führen müsste und die dort fehlt, meldet der Prüfer sie.
- **AC-6** In `AKTE.md` meldet der Prüfer mindestens außerdem: einen Wert, eine Einheit oder einen Referenzbereich, der von der Quelle abweicht; eine Quelle in eckigen Klammern, in der die Angabe nicht steht; eine Schlussfolgerung, die als Fakt dasteht; ein fehlendes Stand-Datum bei einer veränderlichen Angabe; eine Angabe, die eine neue Unterlage überholt hat und die stehen geblieben ist; einen Widerspruch zu einer unveränderten Angabe; einen Eintrag in `BEURTEILUNG.md`, dem eine neue Angabe in `AKTE.md` widerspricht.
- **AC-7** In `BEURTEILUNG.md` meldet der Prüfer mindestens: einen als **Leitlinie** gekennzeichneten Eintrag, dessen Aussage so nicht an der genannten Stelle der Quelle steht; eine Empfehlungsnummer, einen Empfehlungsgrad oder ein Evidenzniveau, das von der Quelle abweicht; einen Widerspruch zu `AKTE.md`, etwa zu Allergien, Medikation oder Diagnosen; einen bestehenden Eintrag, den eine neue Angabe betrifft und der nicht angepasst wurde. Weicht eine Unterlage aus demselben Commit von `AKTE.md` ab, gilt die Unterlage; die Abweichung allein ist kein Fund.
- **AC-8** Jeder Fund nennt Datei, Stelle und die Fundstelle in der Quelle, die ihn belegt. Liegt eine zitierte Quelle nicht lokal vor, meldet der Prüfer den Eintrag als nicht prüfbar, statt ihn zu bestätigen.
- **AC-9** Der Prüfer ändert keine Datei der Akte.
- **AC-10** Das Hauptmodell prüft jeden Fund an der Quelle, berichtigt die bestätigten und nennt dem Benutzer alle Funde: die berichtigten mit der Berichtigung, die verworfenen mit Grund, die nicht prüfbaren als ungeprüft mit Grund. Bei `AKTE.md` geschieht das vor der Bitte um das Ok, bei `BEURTEILUNG.md` vor dem Commit.
- **AC-11** Hat der Prüfer nichts gefunden, sagt das Hauptmodell das dem Benutzer in einem Satz.
- **AC-12** Nach einer Berichtigung läuft der Prüfer für dieselbe Änderung nicht noch einmal.
- **AC-13** `BEURTEILUNG.md` wird weiterhin ohne Ok des Benutzers committet.
- **AC-14** Scheitert der Prüfer oder gibt er kein Ergebnis zurück, sagt das Hauptmodell dem Benutzer, dass die Prüfung nicht gelaufen ist, und meldet nicht „nichts gefunden“. Danach geht der Ablauf weiter: Bei `AKTE.md` folgt die Bitte um das Ok, bei `BEURTEILUNG.md` der Commit.

## Agreed design

Ein Agent in frischem Kontext prüft vor jedem Commit an `AKTE.md` oder
`BEURTEILUNG.md` die Änderung gegen ihre Quellen und gegen beide Dateien als
Ganzes. Die Regel steht in `regeln.md`. Seine Funde gehen an das Hauptmodell,
das jeden an der Quelle prüft; der Benutzer sieht alle Funde, berichtigte und
verworfene.

## Technical decisions

- **Stored formats** Keine. Der Aufbau von `AKTE.md` und `BEURTEILUNG.md` bleibt, und es kommen keine neuen Dateien in die Akte.
- **Wire formats** Keine.
- **Trust boundaries** Keine neuen. Der Prüfer liest dieselben Gesundheitsdaten wie der Agent `akte`, in derselben Sitzung, und ruft nichts außerhalb ab.
- **Dependencies** Keine.

## Nudges

- Ein Agent für beide Dateien, `agents/gegenpruefung.md` (`patientenakte:gegenpruefung`); der Auftrag nennt, welche Datei geprüft wird. Werkzeuge Read, Grep, Glob und Bash, ohne Write und Edit.
- Was als Fehler gilt, formuliert der Prüfer nicht neu: `AKTE.md` prüft er gegen die Regeln in `agents/akte.md`, `BEURTEILUNG.md` gegen den Kopf der Datei und den Abschnitt „Evidenz“ in `regeln.md`.
- Die Regel, vor jedem Commit an `BEURTEILUNG.md` prüfen zu lassen, steht einmal in `regeln.md`, bei „`BEURTEILUNG.md` änderst du frei“ und der Commit-Regel. Die Skills, die committen, wiederholen sie nicht; nur `akte-aktualisieren` ruft den Prüfer ausdrücklich in Schritt 4 auf.
- In `skills/akte-aktualisieren/SKILL.md`, Schritt 4, entfällt das eigene Nachlesen von Messwerten und Dosierungen durch das Hauptmodell; das übernimmt der Prüfer.
- Der Abschnitt „Aufbau“ im `README.md` nennt den neuen Agenten.

## Out of scope

- Die vollständige Prüfung der bestehenden Dateien, inhaltlich und auf das aktuelle Format (`changes/backlog/akte-vollstaendig-pruefen.md`).
- Evals für den Prüfer.
- Einträge in `unterlagen/`; deren Wortlaut bestätigt der Benutzer schon vor dem Schreiben.

## Ruled out

- **Script, das prüft, ob jede Unterlage in `AKTE.md` zitiert ist** - viel Aufwand für wenig Gewinn und viele falsche Treffer, weil überholte Angaben zu Recht fehlen (`agents/akte.md:34`).
- **Liste „Nicht übernommen“ in `AKTE.md`** - war nur nötig, um die falschen Treffer des Scripts zu vermeiden, und fällt mit ihm weg.
- **Zweiter, unabhängiger Bau zum Abgleich bei jedem Bau** - kostet jeden Bau doppelt und prüft `BEURTEILUNG.md` nicht.
- **Hook, der `git commit` bis zur Prüfung sperrt** - ein Fremdkörper in einem Plugin aus Regeln und Skills, und eine nach einer abgebrochenen Sitzung liegen gebliebene Markierung verklemmt ihn.
- **Prüfung von `BEURTEILUNG.md` nur beim Einarbeiten neuer Angaben** - lässt die Einträge aus `leitlinie`, `vorsorge` und der freien Beratung ungeprüft, wo Empfehlungen entstehen, die so nicht in der Quelle stehen.
- **Ok des Benutzers auch für `BEURTEILUNG.md`** - ein zusätzlicher Halt in fünf Abläufen macht `vorsorge` und `leitlinie` zäh.
- **Stilles Berichtigen durch das Hauptmodell** - dann entscheidet wieder allein das Modell, das den Fehler gemacht hat, ob ein Fund zählt.
