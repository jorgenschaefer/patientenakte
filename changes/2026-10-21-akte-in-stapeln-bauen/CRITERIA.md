# Criteria: AKTE.md vollständig in Stapeln bauen

## Problem
Ein vollständiger Bau von `AKTE.md` und seine Gegenprüfung lesen jeweils
alle Unterlagen in einem einzigen Kontext. Fällig wird ein vollständiger Bau
für jede bestehende Akte nach jeder Änderung an `vorlagen/AKTE.md`, dazu beim
ersten Bau einer Akte und auf Wunsch. Mit jeder Unterlage wächst der
Kontext, bis er nicht mehr reicht; schon vorher übersieht ein Bau Angaben,
die ein schrittweiser Bau hätte. Stattdessen soll ein vollständiger Bau mit
seiner Gegenprüfung bei jeder Größe der Akte durchlaufen und so vollständig
und richtig sein wie ein schrittweiser.

Der Fall: Am 21.10.2026 baute eine echte Akte `AKTE.md` vollständig neu,
weil sie nach einem Umbau des Plugins von der Vorlage abwich. 25
Unterlagen, darunter 21 PDFs mit 43 Seiten und 12 MB. Der Subagent `akte`
kam auf 263.000 Token Kontext und lief 10 Minuten, davon etwa 40.000 Token
für das Lesen der alten `AKTE.md`; die Gegenprüfung danach auf 192.000
Token. Schrittweise Bauten liegen bei 15.000 bis 50.000 Token. Beide liefen
durch, ohne Komprimierung. Die Gegenprüfung fand mehrere Fehler, darunter
einen Vermerk „überholt“, den die vorige Fassung hatte und der Neubau
verloren hat. Zu sehen in den Transkripten dieser Akte; Gesundheitsdaten,
nicht in diesem Repo.

## Acceptance criteria
- **AC-1** Die Seiten einer Unterlage werden so gezählt: eine PDF-Seite als eine Seite, ein Bild als eine Seite, eine Textdatei je angefangene 10.000 Zeichen als eine Seite. Liegen alle Unterlagen zusammen bei höchstens 20 Seiten, läuft ein vollständiger Bau in einem einzigen Lauf des Subagenten `akte` mit einer Gegenprüfung.
- **AC-2** Liegen sie darüber, wird in Stapeln gebaut: Die Einheiten kommen in der Reihenfolge aus AC-3 nacheinander in einen Stapel, bis die nächste ihn über 20 Seiten brächte; mit ihr beginnt der nächste Stapel. Eine Einheit ist eine Datei oder ein Tag in `historie.md`. Sie wird nie auf zwei Stapel geteilt; eine Einheit über 20 Seiten bildet einen Stapel für sich. Ein Tag in `historie.md` zählt anteilig, seine Zeichen geteilt durch 10.000 ohne Aufrunden; aufgerundet wird erst die Seitenzahl eines Stapels.
- **AC-3** Die Reihenfolge folgt dem Datum: Befunde nach dem Datum vorn im Dateinamen, die Tage in `historie.md` nach ihrer Überschrift `## TT.MM.JJJJ`, `anamnese.md` nach dem letzten Datum in ihrer Kopfzeile und ohne Datum dort nach ihrem ersten Commit. Bei gleichem Datum kommen erst Befunde, dann `anamnese.md`, dann `historie.md`. Text vor der ersten Überschrift `## TT.MM.JJJJ` gehört zum ersten Tag. Nach allen datierten Einheiten kommen die Dateien ohne Datum im Namen, danach die CSVs, aufgeteilt wie in AC-2.
- **AC-4** Nach dem Lauf eines Stapels zitiert die Zwischenfassung keine Quelle, die erst in einem späteren Stapel liegt.
- **AC-5** Der erste Lauf beginnt mit einer Kopie der Vorlage, jeder weitere mit der Zwischenfassung des vorigen. Kein Lauf liest die bisherige `AKTE.md`.
- **AC-6** Jeder Lauf wird gegengeprüft gegen die Fassung vor dem Lauf, mit den Dateien seines Stapels als Quellen, bei `historie.md` nur mit dessen Tagen. Die Gegenprüfung liest keine Unterlage außerhalb des Stapels und prüft nicht gegen `BEURTEILUNG.md`. Was sie findet und sich bestätigt, ist in der Zwischenfassung berichtigt, bevor der nächste Lauf beginnt.
- **AC-7** `AKTE.md` bleibt unverändert, bis der Abgleich mit der vorigen Fassung und die Wiederherstellungen daraus abgeschlossen sind. Bricht der Bau vorher ab, ist `AKTE.md` wie vorher, und `akte-stand` meldet keinen nicht abgeschlossenen Bau.
- **AC-8** Am Ende enthält `AKTE.md` die letzte Zwischenfassung mit den Berichtigungen aus den Gegenprüfungen und den Wiederherstellungen aus dem Abgleich, dazu die Prüfsummen aller Unterlagen, committet in einem Commit wie heute.
- **AC-9** Die Kontrolle baut ihre zweite Fassung ebenso in Stapeln, ohne Gegenprüfung je Lauf. Die Abweichungen zwischen `AKTE.md` und der zweiten Fassung findet ein Abgleich je Stapel wie in AC-17, in beide Richtungen; was sich an der Unterlage bestätigt, wird in `AKTE.md` berichtigt.
- **AC-10** Vor einem vollständigen Bau oder einer Kontrolle sagt `einarbeiten` in einem Satz, dass `AKTE.md` vollständig gebaut wird und in wie vielen Stapeln.
- **AC-11** Nach einem vollständigen Bau nennt die Rückmeldung von `akte-nachziehen` die Zahl der Stapel und je Stapel die Funde seiner Gegenprüfung, „Keine Funde.“ oder dass sie für diesen Stapel nicht gelaufen ist.
- **AC-12** Unter „Offen“ in der Rückmeldung steht kein Punkt, den ein späterer Stapel klärt oder erledigt: kein Widerspruch, den eine spätere Unterlage auflöst, und keine abgelaufene Frist, die eine spätere Unterlage erwähnt.
- **AC-13** Ein PDF, dessen Seitenzahl sich nicht bestimmen lässt, bildet einen eigenen Stapel, und die Rückmeldung nennt es. Hat `historie.md` keine Überschrift `## TT.MM.JJJJ`, ist sie eine einzige Einheit an der Stelle der Dateien ohne Datum, und die Rückmeldung nennt das.
- **AC-14** Ein neuer Eintrag in `historie.md` steht unter einer Überschrift `## TT.MM.JJJJ` mit dem Datum der Mitteilung; gibt es die Überschrift schon, darunter.
- **AC-15** Die Grenze von 20 Seiten und die 10.000 Zeichen je Seite stehen je an genau einer Stelle; ändert man dort einen Wert, schneidet `akte-stand --stapel` nach AC-2 mit dem neuen Wert.
- **AC-16** Schrittweiser Bau und Berichtigung von `AKTE.md` verhalten sich wie heute.
- **AC-17** Nach einem vollständigen Bau, wenn es eine committete `AKTE.md` gibt, wird die neue Fassung mit `HEAD:AKTE.md` abgeglichen, je Stapel ein Prüfer in frischem Kontext. Er liest beide Fassungen und die Dateien seines Stapels, sonst keine Unterlage, und meldet jede Angabe der vorigen Fassung, die eine Datei seines Stapels zitiert und die in der neuen Fassung fehlt oder inhaltlich abweicht, je mit dem, was die Unterlage dazu sagt.
- **AC-18** Eine Angabe aus dem Abgleich, die die Unterlage trägt und keine Unterlage überholt, stellt `akte-nachziehen` mit Quelle wieder her; die übrigen verwirft es mit Grund. Die Rückmeldung nennt beides. Eine Wiederherstellung übernimmt die Angabe der vorigen Fassung und ändert höchstens ihre Form; sie gilt durch den Abgleich, der sie gefunden hat, als gegengeprüft.
- **AC-19** Fehlt `pdfinfo` und liegt ein PDF in `unterlagen/`, bricht `akte-stand --stapel` mit einer Meldung ab, die poppler-utils nennt und mit einem Exit-Code ungleich 0, und `akte-nachziehen` meldet, dass der vollständige Bau nicht gelaufen ist.
- **AC-20** Die fertige Fassung wird einmal gegen `BEURTEILUNG.md` geprüft, ohne Unterlagen zu lesen; ihre Funde gehen wie heute in das Nachziehen von `BEURTEILUNG.md`.
- **AC-21** Meldet `akte-stand` einen nicht abgeschlossenen Bau, für den heute alle Unterlagen gegengeprüft würden, weil der Diff keine Prüfsummen zeigt, wird `AKTE.md` stattdessen auf `HEAD` zurückgesetzt und in Stapeln neu gebaut; fehlt eine committete `AKTE.md`, ab der Vorlage. Keine Gegenprüfung liest dann alle Unterlagen in einem Kontext.

## Agreed design
Ein vollständiger Bau ist eine Folge schrittweiser Bauten. `akte-stand`
teilt die Unterlagen nach Datum in Stapel von höchstens 20 Seiten;
`akte-nachziehen` baut in eine Datei außerhalb des Arbeitsverzeichnisses,
startet für jeden Stapel den Subagenten `akte` mit der Zwischenfassung des
vorigen, lässt jeden Lauf gegen seine Vorfassung gegenprüfen und berichtigt
vor dem nächsten Lauf. Danach gleicht je Stapel ein Prüfer die fertige
Fassung mit der vorigen ab, `akte-nachziehen` stellt Bestätigtes wieder
her, und erst dann wird die Fassung nach `AKTE.md` kopiert und committet.
Eine kleine Akte ist ein einziger Stapel und läuft denselben Weg.

## Technical decisions
- **Stored formats** In der Akte kommt keine committete Datei hinzu. Zwischenfassungen liegen unter `.git/akte-bau/` der Akte, nie committet und nicht in `git status`; ein Bau leert das Verzeichnis zu Beginn und am Ende. Die Kontrolle legt ihre zweite Fassung ebenfalls dort ab statt in `mktemp`. Die Überschrift `## TT.MM.JJJJ` über den Einträgen in `historie.md` wird vorgeschrieben, in `skills/neue-information/SKILL.md`; bestehende Einträge ohne sie werden nicht umgeschrieben (AC-13). Die Kopfzeile von `anamnese.md` bleibt, wie sie `skills/anamnese/SKILL.md` vorgibt.
- **Wire formats** Neu ist `akte-stand --stapel`. Es gibt je Stapel eine Zeile `Stapel N (S Seiten)` aus, darunter je Einheit eine Zeile, eine Datei als Pfad, ein Teil von `historie.md` als `unterlagen/historie.md TT.MM.JJJJ–TT.MM.JJJJ`; Stapel durch eine Leerzeile getrennt. Danach je PDF ohne Seitenzahl eine Zeile `Seitenzahl unbekannt: <pfad>` und, wenn `historie.md` keine Datumsüberschrift hat, die Zeile `historie.md ohne Datumsüberschriften.` Ohne `pdfinfo` Exit-Code 1 und eine Meldung auf stderr. Der Auftrag an den Subagenten `akte` bekommt die Art „Stapel“ mit Zieldatei und den Einheiten eines Stapels. Der Auftrag an `aenderung-gegenpruefen` kann statt `HEAD` eine Vorfassung als Pfad nennen, Quellen als Einheiten wie in `--stapel`, und bekommt die Art „Abgleich mit der vorigen Fassung“. Bisherige Aufrufe von `akte-stand` und bisherige Aufträge bleiben gültig.
- **Trust boundaries** Keine neuen. `pdfinfo` liest die Befunde lokal, wie heute schon `pdftotext` im Subagenten `akte`. Zwischenfassungen enthalten Gesundheitsdaten und bleiben in der Akte, unter `.git/`, auch wenn ein Bau abbricht.
- **Dependencies** `pdfinfo` aus poppler-utils für `akte-stand` und `tests/check.sh`; das README nennt es. Kein Werkzeug zum Erzeugen von PDFs.

## Nudges
- Wie Stapel geschnitten werden, steht nur in `bin/akte-stand`; die Agenten verwenden nur dessen Ausgabe.
- `seiten_je_stapel=20` und `zeichen_je_seite=10000` stehen oben in `bin/akte-stand` neben `akte=AKTE.md`. Die Tests überschreiben sie nicht, sondern erzeugen große Textdateien und schreiben kleine PDFs mit mehreren Seiten selbst, mit `printf` im Test.
- Ein Stapel ist für den Subagenten `akte` ein schrittweiser Bau mit vorgegebener Dateiliste; kein neuer Agent. Auch ein einzelner Stapel läuft diesen Weg, ohne Sonderfall.
- Jeder Lauf von `akte` bekommt im Auftrag die offenen Punkte der vorigen Läufe und meldet zurück, welche er klärt oder erledigt; abgelaufene Fristen meldet erst der letzte Lauf.
- Der Abgleich mit der vorigen Fassung baut auf der Berichtigung der Form in `agents/aenderung-gegenpruefen.md` auf, die schon `HEAD:AKTE.md` als Quelle kennt; anders als dort darf eine Angabe fehlen, wenn eine Unterlage sie überholt.
- Die Prüfung gegen `BEURTEILUNG.md` (AC-20) ist ein Lauf von `aenderung-gegenpruefen` ohne Quellen, wie ihn `agents/akte-nachziehen.md` Schritt 5 schon kennt.
- Das README zieht nach: „Die Akte prüfen“, die Beschreibung von `akte-stand` und die Abhängigkeit.

## Out of scope
- `BEURTEILUNG.md` gegen die Literatur prüfen; eigener Backlog-Eintrag.
- Angaben ohne Anlass auffrischen, etwa aus `anamnese.md`; eigener Backlog-Eintrag.
- Einen abgebrochenen Bau in Stapeln dort fortsetzen, wo er stehen blieb; er beginnt von vorn.
- Den Kontext von `akte-nachziehen` selbst begrenzen; er wächst mit den Rückmeldungen je Stapel, die kurz sind.

## Ruled out
- **Auszüge je Stapel parallel, dann Zusammenführen** - Widersprüche über Stapelgrenzen sieht nur das Zusammenführen, und dem liegen die Quellen nicht vor.
- **Committeter Auszug je Unterlage** - L–XL Aufwand, ein neues Verzeichnis in jeder Akte, und jede Änderung der Regeln in `agents/akte.md` macht alle Auszüge ungültig.
- **PDFs vorher in Text umwandeln** - verschiebt die Grenze nur und versagt bei Scans.
- **Stapel nach Anzahl Dateien, Zeitraum oder Schätzung des Agenten** - ungleiche Stapel oder nicht reproduzierbar; die Dateigröße sagt nichts über die Token.
- **`historie.md` und `anamnese.md` an festen Stellen statt nach Datum** - die Reihenfolge widerspricht dann der Zeitfolge, und ein Lauf müsste erkennen, dass eine gerade gelesene Angabe älter ist als eine schon eingetragene.
- **Ein Commit je Stapel** - unfertige Fassungen von `AKTE.md` in der Historie, und `akte-stand` müsste Zwischenstände verstehen.
- **Eine Gegenprüfung am Ende, aufgeteilt nach Stapeln** - meldet zu Recht überholte Angaben früher Stapel als fehlend.
- **Gegenprüfung je Stapel mit den älteren Unterlagen, die geänderte Zeilen zitieren** - jede Messwertzeile zitiert alle früheren Befunde, späte Stapel läsen fast alles wieder.
- **Ein einziger Abgleich mit der vorigen Fassung über alle Unterlagen** - nach einer großen Änderung der Vorlage wieder alle Unterlagen in einem Kontext.
- **Vor dem Bau fragen** - der Benutzer hat den Bau selbst verlangt.
- **Neue Angaben im Abgleich am Ende noch einmal prüfen** - sie sind je Stapel geprüft; nach einer Änderung der Vorlage wäre fast jede Zeile neu, und der Abgleich müsste wieder alle Unterlagen lesen.
- **Zwischenfassungen in `mktemp`** - bleiben bei einem Abbruch mit Gesundheitsdaten außerhalb der Akte liegen.
