---
criteria:  CRITERIA.md
closes:    AC-9, AC-10, AC-11, AC-17, AC-24, AC-27, AC-32, AC-33
advances:  AC-12, AC-18
after:     02-baum-neu-bauen
status:    done
attempts:  1
---

## Build
Das Einarbeiten zieht den Baum schrittweise nach: neue Unterlagen und neue Einträge der Beurteilung kommen in die Kapitel, die sie berühren, und in den Überblick, mit Gegenprüfung und innerhalb der Höchstlängen. Dazu Kontrolle und Prüfung für den ganzen Baum.

## Done when
> **AC-9** Jedes Einarbeiten hält die Höchstlängen ein. Dafür fasst es Älteres zusammen, mit einem Verweis auf die Stelle mit den Einzelheiten, oder teilt ein Kapitel in Unterkapitel; ein Kapitel mit Unterkapiteln ist selbst ein kurzer Überblick mit Verweisen. Die Zusammenfassung am Ende des Einarbeitens nennt jede Teilung. Danach ist jede Angabe, die durch keine Unterlage überholt ist, vom Überblick aus über Verweise erreichbar.

> **AC-10** Den Überblick kürzt das Einarbeiten nur an den Teilen, die sich auslagern lassen: die Zeilen unter „Probleme, Vorerkrankungen und Operationen“, etwa indem Abgeschlossenes zu einer Zeile mit Verweis zusammengefasst wird. Reicht das nicht, bleibt der Überblick vollständig und dafür über seiner Grenze.

> **AC-11** Nach jedem Einarbeiten zeigt kein Verweis ins Leere. Was sich nicht beheben ließ, nennt die Zusammenfassung am Ende des Einarbeitens.

> **AC-17** Neubau, Kontrolle und Prüfung der Akte gibt es für den ganzen Baum, wie heute für `AKTE.md`: in Stapeln, ersetzt wird erst nach dem Abgleich mit der vorigen Fassung, und ein Abbruch lässt den Stand, wie er war.

> **AC-24** Ein Kapitel, das nach dem Einarbeiten über seiner Grenze ist, nennt die Zusammenfassung am Ende des Einarbeitens, und der Start jeder Sitzung meldet es wieder, bis es behoben ist.

> **AC-27** Die Beurteilung bleibt für immer in `unterlagen/`, wird nur angehängt und committet.

> **AC-32** Berührt eine neue Unterlage beim Einarbeiten ein Kapitel, liest das Einarbeiten in den Leitlinien in `literatur/`, auf die das Kapitel verweist, die Stellen zu der neuen Angabe. Was dort steht und noch nicht im Kapitel, kommt als Aussage der Literatur mit Stelle hinein; folgt daraus etwas für den Fall, kommt eine neue Einschätzung in die Beurteilung. Die Zusammenfassung am Ende des Einarbeitens nennt beides.

> **AC-33** Der Überblick nennt das Datum, bis zu dem seine Fristen reichen. Ist es beim Start einer Sitzung vorbei, meldet der Start das, und `/einarbeiten` schreibt den Überblick neu, auch ohne neue Unterlagen.

Zu den ACs unter „Toward“:

- AC-12: Das Einarbeiten committet Einträge der Beurteilung ohne Commit nach einer Gegenprüfung. Wie sie im Gespräch entstehen, noch nicht.
- AC-18: `einarbeiten` gibt aus, was es heute ausgibt, auf Grundlage des Baums.

## Toward
> **AC-12** Einschätzungen, Warnzeichen mit Stufe, Fristen und das, was beobachtet wird, erarbeitet das Modell und hängt sie an die Beurteilung in `unterlagen/` an. Jeder Eintrag ist datiert, als Einschätzung eines Modells gekennzeichnet und wird nie umgeschrieben. Im Gespräch entstehen sie als Entwurf, ohne Commit und ohne Bestätigung durch den Benutzer. Das Einarbeiten committet sie nach einer Gegenprüfung.

> **AC-18** Die Skills `anamnese`, `neue-information`, `einarbeiten`, `diagnose`, `naechste-schritte`, `vorsorge`, `termin-vorbereiten` und `notfallpass` geben aus, was sie heute ausgeben, auf Grundlage des Baums. Am Ende der Erstbefragung baut `anamnese` den Baum statt `AKTE.md` im bisherigen Aufbau und legt keine `BEURTEILUNG.md` an.

## Technical decisions
> **Concepts** Der **Überblick** (`AKTE.md`) verweist auf **Kapitel**. Ein Kapitel gehört entweder zu einem **Problem**, also allem, was behandelt oder abgeklärt wird, auch ohne Diagnose, oder zu einem übergreifenden Thema. Ein Kapitel kann **Unterkapitel** haben. Ein Problem ist **aktiv**, **ruhend** oder **abgeschlossen**; „Beobachten“ bleibt das Wort für Themen, die mit einer Messreihe verfolgt werden. Überblick und Kapitel haben je eine **Höchstlänge**. Die **Beurteilung** ist eine Unterlage in `unterlagen/`, die nur angehängt wird. Überblick und Kapitel fassen Unterlagen, Literatur und Beurteilung zusammen. `BEURTEILUNG.md` entfällt.

> **Wire formats** Von außen hängt nur der Aufbau bestehender Akten ab. Eine Akte im bisherigen Aufbau erhält beim Start die Meldung, dass sie abweicht, und wird mit `/einarbeiten` umgestellt (AC-15). Braucht der Weg für AC-1 eine Datei in der Akte, etwa für Claude Code, legt die Umstellung sie an. Sonst keine.

> **Hard to reverse** Die Umstellung entfernt `AKTE.md` im bisherigen Aufbau und `BEURTEILUNG.md` und verwirft dabei die Herleitungen, den Abschnitt „Quellen“ und den Wortlaut von Leitlinien, die in `literatur/` vorliegen. Das gibt eine Akte, die die Beratung zu jeder Frage kennen kann. Es kostet, dass die Herleitungen nur noch in der Git-Geschichte stehen. Außerdem wird die Beurteilung nur angehängt und nie umgeschrieben (AC-12, AC-27). Das gibt Einschätzungen, die von Beratung zu Beratung gleich bleiben. Es kostet, dass sie mit der Akte wächst, dass jeder Neubau sie lesen muss und dass ein falscher Eintrag nur durch einen neuen überholt werden kann.

## Context
Nach Ticket 02 gibt es den Baum, die Beurteilung `unterlagen/beurteilung.md` und den Neubau. Die Namen aus 01 und 02 gelten hier.

Heute läuft das Einarbeiten in `agents/akte-nachziehen.md` unter „Ablauf“: Unterlagen committen, `AKTE.md` schrittweise mit `agents/akte.md` bauen, gegenprüfen und committen, dann `BEURTEILUNG.md` nachziehen, gegenprüfen und committen. Dazu kommen dort „Berichtigung“, „Kontrolle“ und „Prüfung“. `skills/einarbeiten` gibt die Rückmeldung an den Benutzer weiter. Mit `BEURTEILUNG.md` entfallen das Nachziehen und das Kürzen in „Prüfung“. Die Beurteilung wird nur angehängt.

`akte-stand` meldet seit Ticket 01 Kapitel über ihrer Grenze, Verweise ins Leere und ein vorbeigegangenes Enddatum der Fristen.

Security policy sagt „None.“: Eine neue Berechtigung, etwa in den Einstellungen einer Akte, wäre eine Abweichung.

## Not here
- Wie Einträge der Beurteilung im Gespräch entstehen, und die übrigen Skills: 04.
- Das Einarbeiten einer Akte im bisherigen Aufbau, also die Umstellung: 05.
- Ob eine Leitlinie noch gilt; das braucht eine Suche im Netz und bleibt bei `leitlinien-recherche`.
- Leitlinien, die noch nicht in `literatur/` liegen; sie sucht die Beratung wie heute vor einer Empfehlung.

## Left standing

- **Behoben nach der letzten Prüfung, von niemandem geprüft (AC-12, AC-27, AC-33, AC-9):** Funde aus der zweiten Runde.
  - Should-fix: Beim Anlass „Berichtigung“ prüft die Gegenprüfung an der Unterlage aus dem Auftrag, nicht an `HEAD`. `HEAD` ist nur beim Anlass „Prüfung“ eine Quelle (`agents/aenderung-gegenpruefen.md`).
  - Should-fix: Der Fall „Fristen vorbei“ im Run-Skill läuft jetzt nach dem Nachtrag. So steht eine offene Frist in einem Kapitel, das der Bau nicht berührt.
  - Nits: Ein fortgesetzter Bau behält die Einträge in `.git/akte-bau/beurteilung-neu.md` und hängt neue dahinter. Die Rückmeldung nennt die Einträge, die Schritt 3 nach einem abgebrochenen Bau committet, als solche. Dazu Grammatik und die Begründung beim Marker `.git/akte-bau/schrittweise`.
- **Nicht automatisch geprüft (AC-9, AC-10, AC-11, AC-17, AC-24, AC-27, AC-32, AC-33; Toward AC-12, AC-18):** Alles in diesem Ticket ist Text für ein Modell in `agents/` und `skills/einarbeiten`; `bin/akte-stand` ist unverändert, und kein Test prüft die Agenten. Geprüft wurde in zwei Läufen der Testakte nach `.claude/skills/run/SKILL.md`:
  - Neubau, dann `nachtrag` und `/einarbeiten`: Der Eintrag aus dem Gespräch wurde gegengeprüft, berichtigt und vor dem Baum committet. Empfehlung 3.3 kam mit Stelle ins Kapitel zur Hypertonie, eine neue Einschätzung daraus an die Beurteilung, und die Zusammenfassung nannte beides. Die Beurteilung wuchs nur am Ende. Danach meldete `akte-stand` nur den Stand, und `.git/akte-bau/` war gelöscht.
  - Fristen vorbei ohne neue Unterlagen: Ein Commit nur an `AKTE.md`, das Datum vier Wochen nach heute, Gegenprüfung ohne Funde.
- **Nicht vorgeführt (AC-9, AC-10, AC-24, AC-17):** Keine Datei kam in die Nähe ihrer Höchstlänge. Teilen, Kürzen des Überblicks und ein Kapitel über der Grenze liefen also nie. Ebenso nicht gelaufen: Kontrolle, Prüfung und der Abbruch eines Baus mit Fortsetzung. Dass der Überblick die Fristen auch aus Kapiteln übernimmt, die der Bau nicht berührt, zeigte kein Lauf; die Testakte hatte damals keine offene Frist.
- **Abweichung (Context, Prüfung):** Die Prüfung berichtigt die Beurteilung nicht mehr durch Löschen. Wo ein Eintrag nicht mehr trägt oder widerspricht, hängt sie einen Eintrag „Aufgehoben“ oder einen eingeschränkten neuen Eintrag an, mit Gegenprüfung, wie der Neubau. Sonst bliebe er gültig, weil die Beurteilung nie umgeschrieben wird.
- **Abweichung (AC-12, `literatur/`):** Das Einarbeiten committet Änderungen in `literatur/` ohne Commit zusammen mit der Beurteilung, nach einer Gegenprüfung (Schritt 3 in `agents/akte-nachziehen.md`). Seit Ticket 02 committete niemand mehr `literatur/`, und neue Einträge der Beurteilung zitieren solche Dateien.
- **Entscheidungen, auf die 04 und 05 bauen:**
  - Es steht etwas aus, wenn `unterlagen/` oder `literatur/` Änderungen ohne Commit haben oder `akte-stand` etwas anderes meldet als den Stand. Dazu zählen auch nur vorbeigegangene Fristen, zu lange Dateien und Verweise ins Leere; dann läuft ein schrittweiser Bau ohne Dateien. Ob der Start einer Sitzung darum `einarbeiten` von selbst startet, steht in `regeln.md` und gehört zu 04.
  - Jeder schrittweise Bau zieht Warnzeichen und Fristen des Überblicks aus allen Kapiteln nach und setzt das Datum der Fristen auf vier Wochen nach heute.
  - Ein schrittweiser Bau schreibt neue Einträge nach `.git/akte-bau/beurteilung-neu.md`, Anlass „Einarbeiten von <Dateien>.“; die Prüfung mit Anlass „Prüfung der Akte.“. Der Marker `.git/akte-bau/schrittweise` lässt einen abgebrochenen schrittweisen Bau ohne neue Prüfsumme schrittweise fortsetzen statt neu bauen.
  - Die Gegenprüfung kennt die Arten „Baum“ mit Anlass (schrittweiser Bau, Berichtigung, Prüfung) und „Beurteilung“. Die Prüfungen für `BEURTEILUNG.md` und ihre Kürzung sind aus `agents/aenderung-gegenpruefen.md` entfernt, weil sie niemand mehr aufrief; braucht die Umstellung in 05 sie, schreibt sie sie neu.
- **Nicht von diesem Ticket:** `README.md` beschreibt noch durchweg den bisherigen Aufbau, auch das Einarbeiten, die Prüfung und dass `akte-nachziehen` `leitlinien-recherche` aufruft; das tut es nicht mehr. `agents/akte-nachziehen.md` lässt „Dateien“ in `regeln.md` lesen, wo noch `BEURTEILUNG.md` steht (04). Ein Lauf antwortete auf Englisch, und die Zusammenfassung nannte „akte-stand“ beim Namen; beides kommt aus der Ausgabe von `skills/einarbeiten` und wäre eine Sache für 04.
- **Lücke zu AC-28 (Ticket 02):** Eine Aussage der Literatur, die das Einarbeiten zu einer neuen Angabe aufnimmt und aus der keine Einschätzung folgt, zitiert keine Beurteilung. Ein Neubau ohne vorige Fassung bekäme sie nicht wieder; mit voriger Fassung stellt sie der Abgleich „mit Literatur“ wieder her.
- **Blast radius:** Jedes `/einarbeiten` in einer Akte im neuen Aufbau läuft über den geänderten Ablauf. Ein Revert stellt die Texte wieder her; Einträge, die schon an `unterlagen/beurteilung.md` angehängt und committet sind, bleiben.
