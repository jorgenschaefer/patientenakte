---
criteria:  CRITERIA.md
closes:    AC-1, AC-2, AC-4, AC-5, AC-6, AC-7, AC-8, AC-9, AC-10, AC-11, AC-12, AC-13, AC-16, AC-17, AC-18, AC-19, AC-20, AC-21
advances:
after:     01-stapel-schneiden
status:    ready
attempts:  0
---

## Build
Ein vollständiger Bau von `AKTE.md` und die Kontrolle laufen als Folge von Stapeln aus `akte-stand --stapel`: je Stapel ein Lauf des Subagenten `akte` in eine Zwischenfassung unter `.git/akte-bau/`, gegengeprüft gegen die Fassung davor, danach ein Abgleich mit der vorigen `AKTE.md` je Stapel, und erst dann wird `AKTE.md` ersetzt und committet.

## Done when
> **AC-1** Die Seiten einer Unterlage werden so gezählt: eine PDF-Seite als eine Seite, ein Bild als eine Seite, eine Textdatei je angefangene 10.000 Zeichen als eine Seite. Liegen alle Unterlagen zusammen bei höchstens 20 Seiten, läuft ein vollständiger Bau in einem einzigen Lauf des Subagenten `akte` mit einer Gegenprüfung.

> **AC-2** Liegen sie darüber, wird in Stapeln gebaut: Die Einheiten kommen in der Reihenfolge aus AC-3 nacheinander in einen Stapel, bis die nächste ihn über 20 Seiten brächte; mit ihr beginnt der nächste Stapel. Eine Einheit ist eine Datei oder ein Tag in `historie.md`. Sie wird nie auf zwei Stapel geteilt; eine Einheit über 20 Seiten bildet einen Stapel für sich. Ein Tag in `historie.md` zählt anteilig, seine Zeichen geteilt durch 10.000 ohne Aufrunden; aufgerundet wird erst die Seitenzahl eines Stapels.

> **AC-4** Nach dem Lauf eines Stapels zitiert die Zwischenfassung keine Quelle, die erst in einem späteren Stapel liegt.

> **AC-5** Der erste Lauf beginnt mit einer Kopie der Vorlage, jeder weitere mit der Zwischenfassung des vorigen. Kein Lauf liest die bisherige `AKTE.md`.

> **AC-6** Jeder Lauf wird gegengeprüft gegen die Fassung vor dem Lauf, mit den Dateien seines Stapels als Quellen, bei `historie.md` nur mit dessen Tagen. Die Gegenprüfung liest keine Unterlage außerhalb des Stapels und prüft nicht gegen `BEURTEILUNG.md`. Was sie findet und sich bestätigt, ist in der Zwischenfassung berichtigt, bevor der nächste Lauf beginnt.

> **AC-7** `AKTE.md` bleibt unverändert, bis der Abgleich mit der vorigen Fassung und die Wiederherstellungen daraus abgeschlossen sind. Bricht der Bau vorher ab, ist `AKTE.md` wie vorher, und `akte-stand` meldet keinen nicht abgeschlossenen Bau.

> **AC-8** Am Ende enthält `AKTE.md` die letzte Zwischenfassung mit den Berichtigungen aus den Gegenprüfungen und den Wiederherstellungen aus dem Abgleich, dazu die Prüfsummen aller Unterlagen, committet in einem Commit wie heute.

> **AC-9** Die Kontrolle baut ihre zweite Fassung ebenso in Stapeln, ohne Gegenprüfung je Lauf. Die Abweichungen zwischen `AKTE.md` und der zweiten Fassung findet ein Abgleich je Stapel wie in AC-17, in beide Richtungen; was sich an der Unterlage bestätigt, wird in `AKTE.md` berichtigt.

> **AC-10** Vor einem vollständigen Bau oder einer Kontrolle sagt `einarbeiten` in einem Satz, dass `AKTE.md` vollständig gebaut wird und in wie vielen Stapeln.

> **AC-11** Nach einem vollständigen Bau nennt die Rückmeldung von `akte-nachziehen` die Zahl der Stapel und je Stapel die Funde seiner Gegenprüfung, „Keine Funde.“ oder dass sie für diesen Stapel nicht gelaufen ist.

> **AC-12** Unter „Offen“ in der Rückmeldung steht kein Punkt, den ein späterer Stapel klärt oder erledigt: kein Widerspruch, den eine spätere Unterlage auflöst, und keine abgelaufene Frist, die eine spätere Unterlage erwähnt.

> **AC-13** Ein PDF, dessen Seitenzahl sich nicht bestimmen lässt, bildet einen eigenen Stapel, und die Rückmeldung nennt es. Hat `historie.md` keine Überschrift `## TT.MM.JJJJ`, ist sie eine einzige Einheit an der Stelle der Dateien ohne Datum, und die Rückmeldung nennt das.

> **AC-16** Schrittweiser Bau und Berichtigung von `AKTE.md` verhalten sich wie heute.

> **AC-17** Nach einem vollständigen Bau, wenn es eine committete `AKTE.md` gibt, wird die neue Fassung mit `HEAD:AKTE.md` abgeglichen, je Stapel ein Prüfer in frischem Kontext. Er liest beide Fassungen und die Dateien seines Stapels, sonst keine Unterlage, und meldet jede Angabe der vorigen Fassung, die eine Datei seines Stapels zitiert und die in der neuen Fassung fehlt oder inhaltlich abweicht, je mit dem, was die Unterlage dazu sagt.

> **AC-18** Eine Angabe aus dem Abgleich, die die Unterlage trägt und keine Unterlage überholt, stellt `akte-nachziehen` mit Quelle wieder her; die übrigen verwirft es mit Grund. Die Rückmeldung nennt beides. Eine Wiederherstellung übernimmt die Angabe der vorigen Fassung und ändert höchstens ihre Form; sie gilt durch den Abgleich, der sie gefunden hat, als gegengeprüft.

> **AC-19** Fehlt `pdfinfo`, bricht `akte-stand --stapel` mit einer Meldung ab, die poppler-utils nennt und mit einem Exit-Code ungleich 0, und `akte-nachziehen` meldet, dass der vollständige Bau nicht gelaufen ist.

> **AC-20** Die fertige Fassung wird einmal gegen `BEURTEILUNG.md` geprüft, ohne Unterlagen zu lesen; ihre Funde gehen wie heute in das Nachziehen von `BEURTEILUNG.md`.

> **AC-21** Meldet `akte-stand` einen nicht abgeschlossenen Bau, für den heute alle Unterlagen gegengeprüft würden, weil der Diff keine Prüfsummen zeigt, wird `AKTE.md` stattdessen auf `HEAD` zurückgesetzt und in Stapeln neu gebaut; fehlt eine committete `AKTE.md`, ab der Vorlage. Keine Gegenprüfung liest dann alle Unterlagen in einem Kontext.

## Technical decisions
> **Stored formats** In der Akte kommt keine committete Datei hinzu. Zwischenfassungen liegen unter `.git/akte-bau/` der Akte, nie committet und nicht in `git status`; ein Bau leert das Verzeichnis zu Beginn und am Ende. Die Kontrolle legt ihre zweite Fassung ebenfalls dort ab statt in `mktemp`. Die Überschrift `## TT.MM.JJJJ` über den Einträgen in `historie.md` wird vorgeschrieben, in `skills/neue-information/SKILL.md`; bestehende Einträge ohne sie werden nicht umgeschrieben (AC-13). Die Kopfzeile von `anamnese.md` bleibt, wie sie `skills/anamnese/SKILL.md` vorgibt.

> **Wire formats** Neu ist `akte-stand --stapel`. Es gibt je Stapel eine Zeile `Stapel N (S Seiten)` aus, darunter je Einheit eine Zeile, eine Datei als Pfad, ein Teil von `historie.md` als `unterlagen/historie.md TT.MM.JJJJ–TT.MM.JJJJ`; Stapel durch eine Leerzeile getrennt. Danach je PDF ohne Seitenzahl eine Zeile `Seitenzahl unbekannt: <pfad>` und, wenn `historie.md` keine Datumsüberschrift hat, die Zeile `historie.md ohne Datumsüberschriften.` Ohne `pdfinfo` Exit-Code 1 und eine Meldung auf stderr. Der Auftrag an den Subagenten `akte` bekommt die Art „Stapel“ mit Zieldatei und den Einheiten eines Stapels. Der Auftrag an `aenderung-gegenpruefen` kann statt `HEAD` eine Vorfassung als Pfad nennen, Quellen als Einheiten wie in `--stapel`, und bekommt die Art „Abgleich mit der vorigen Fassung“. Bisherige Aufrufe von `akte-stand` und bisherige Aufträge bleiben gültig.

> **Trust boundaries** Keine neuen. `pdfinfo` liest die Befunde lokal, wie heute schon `pdftotext` im Subagenten `akte`. Zwischenfassungen enthalten Gesundheitsdaten und bleiben in der Akte, unter `.git/`, auch wenn ein Bau abbricht.

> **Dependencies** `pdfinfo` aus poppler-utils für `akte-stand` und `tests/check.sh`; das README nennt es. Kein Werkzeug zum Erzeugen von PDFs.

## Nudges
> Wie Stapel geschnitten werden, steht nur in `bin/akte-stand`; die Agenten verwenden nur dessen Ausgabe.

> Ein Stapel ist für den Subagenten `akte` ein schrittweiser Bau mit vorgegebener Dateiliste; kein neuer Agent. Auch ein einzelner Stapel läuft diesen Weg, ohne Sonderfall.

> Jeder Lauf von `akte` bekommt im Auftrag die offenen Punkte der vorigen Läufe und meldet zurück, welche er klärt oder erledigt; abgelaufene Fristen meldet erst der letzte Lauf.

> Der Abgleich mit der vorigen Fassung baut auf der Berichtigung der Form in `agents/aenderung-gegenpruefen.md` auf, die schon `HEAD:AKTE.md` als Quelle kennt; anders als dort darf eine Angabe fehlen, wenn eine Unterlage sie überholt.

> Die Prüfung gegen `BEURTEILUNG.md` (AC-20) ist ein Lauf von `aenderung-gegenpruefen` ohne Quellen, wie ihn `agents/akte-nachziehen.md` Schritt 5 schon kennt.

> Das README zieht nach: „Die Akte prüfen“, die Beschreibung von `akte-stand` und die Abhängigkeit.

## Context
Ticket 01 hat `akte-stand --stapel` gebaut, genau im Wire format oben: Mehrere Tage von `historie.md`, die im selben Stapel aufeinander folgen, stehen auf einer Zeile `unterlagen/historie.md <erster Tag>–<letzter Tag>`; ein einzelner Tag hat dasselbe Datum auf beiden Seiten. Eine Zeile, deren Bereich mit dem ersten Tag beginnt, umfasst auch den Text vor der ersten Überschrift, den AC-3 dem ersten Tag zuordnet, samt seinen Einträgen mit älterem Datum; so lesen sie der Lauf, seine Gegenprüfung und der Abgleich. Eine `historie.md` ohne Datumsüberschrift steht als Pfad allein auf ihrer Zeile. Die README-Teile zu `akte-stand` und zur Abhängigkeit hat Ticket 01 geschrieben; dieses Ticket zieht „Die Akte prüfen“ nach.

Heute: `agents/akte-nachziehen.md` Schritt 3 startet für „vollständig“ den Subagenten `akte` direkt auf `AKTE.md` und lässt danach gegen alle Unterlagen gegenprüfen; die Kontrolle baut in eine Datei aus `mktemp`. `agents/akte.md` kennt die Arten „schrittweise“ und „vollständig“. `agents/aenderung-gegenpruefen.md` liest die Änderung mit `git diff HEAD -- <datei>` und kennt `HEAD:AKTE.md` als Quelle nur bei einer Berichtigung der Form. `skills/einarbeiten/SKILL.md` Schritt 4 startet `akte-nachziehen` mit „Neubau“ oder „Kontrolle“. `akte-stand` meldet einen nicht abgeschlossenen Bau, sobald `AKTE.md` Änderungen ohne Commit hat.

## Not here
- Wie Stapel geschnitten und Seiten gezählt werden und die Datumsüberschrift in `historie.md`: Ticket 01, in `bin/akte-stand` und `skills/neue-information/SKILL.md`.
- `BEURTEILUNG.md` gegen die Literatur prüfen; eigener Backlog-Eintrag.
- Angaben ohne Anlass auffrischen, etwa aus `anamnese.md`; eigener Backlog-Eintrag.
- Einen abgebrochenen Bau in Stapeln dort fortsetzen, wo er stehen blieb; er beginnt von vorn.
- Den Kontext von `akte-nachziehen` selbst begrenzen; er wächst mit den Rückmeldungen je Stapel, die kurz sind.

## Left standing
