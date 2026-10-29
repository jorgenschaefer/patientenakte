---
criteria:  CRITERIA.md
closes:    AC-2, AC-3, AC-13, AC-14, AC-20, AC-28
advances:  AC-9, AC-10, AC-11, AC-12, AC-17, AC-18, AC-27, AC-29, AC-33
after:     01-akte-stand-baum
status:    done
attempts:  1
---

## Build
Der Neubau schreibt den Baum: den Überblick `AKTE.md` und die Kapitel in `kapitel/`, in Stapeln, aus `unterlagen/` mit der Beurteilung und aus `literatur/`. Eine neue Akte bekommt nach der Erstbefragung den Baum und keine `BEURTEILUNG.md`.

## Done when
> **AC-2** Der Überblick (`AKTE.md`) enthält: unter „Probleme, Vorerkrankungen und Operationen“ je eine Zeile mit Stand, Datum, Status (aktiv, ruhend oder abgeschlossen) und Verweis auf das Kapitel; ganz: Allergien und Unverträglichkeiten, die aktuelle Medikation mit Dosis, was die Wahl oder Dosis eines Mittels ändert, etwa eine Organfunktion, das Alter oder eine Schwangerschaft, und die Warnzeichen mit Stufe; die Fristen der nächsten vier Wochen; die übergreifenden Kapitel, je eine Zeile.

> **AC-3** Abgelehntes steht im Kapitel seines Themas, nicht im Überblick. Eine Ablehnung, die zu keinem Problem gehört, etwa einer Impfung, steht im passenden übergreifenden Kapitel.

> **AC-13** Ein Neubau übernimmt je Thema die letzte Einschätzung aus der Beurteilung und prüft sie gegen die Unterlagen. Jede Aussage einer Leitlinie in einem Kapitel liest er an der genannten Stelle der Quelle in `literatur/` neu ab, mit Empfehlungsnummer, Empfehlungsgrad und Evidenzniveau; stimmt sie nicht, berichtigt er sie, und die Zusammenfassung nennt das. Ändert sich eine Einschätzung, kommt die neue Einschätzung mit Grund als neuer Eintrag in die Beurteilung.

> **AC-14** In jedem Kapitel sind Fakten, Aussagen der Literatur und Einschätzungen des Modells sichtbar getrennt. Jede Angabe nennt ihre Quelle: eine Unterlage, eine Stelle in `literatur/` oder einen Eintrag der Beurteilung mit Datum.

> **AC-20** Im Hauptverzeichnis einer Akte stehen an Inhalten der Akte nur `AKTE.md` und die Themenlisten `termin-*.md`, neben `unterlagen/` und `literatur/`; Dateien für Git und Claude Code, etwa `.gitignore` oder `.claude/`, zählen nicht dazu. Alle Kapitel liegen in einem Unterverzeichnis und sind committet.

> **AC-28** Überblick und Kapitel sind ein Cache: Sie werden beim Einarbeiten überschrieben, ältere Fassungen gibt es nur in der Git-Geschichte der Akte, und sie lassen sich aus `unterlagen/` und `literatur/` neu bauen.

Zu den ACs unter „Toward“:

- AC-9: Der Neubau hält beide Höchstlängen ein, indem er Älteres mit Verweis zusammenfasst oder ein Kapitel in Unterkapitel teilt. Seine Rückmeldung nennt jede Teilung.
- AC-10: Der Neubau kürzt den Überblick nur an den Zeilen unter „Probleme, Vorerkrankungen und Operationen“. Reicht das nicht, bleibt der Überblick vollständig.
- AC-11: Nach einem Neubau zeigt kein Verweis ins Leere. Was er nicht beheben konnte, nennt seine Rückmeldung.
- AC-12: Die Beurteilung `unterlagen/beurteilung.md` gibt es, und der Neubau hängt seine Einträge datiert und als Einschätzung eines Modells gekennzeichnet an. Er committet sie nach einer Gegenprüfung.
- AC-17: Den Neubau gibt es für den ganzen Baum, in Stapeln. Ersetzt wird erst nach dem Abgleich mit der vorigen Fassung, und ein Abbruch lässt den Stand, wie er war.
- AC-18: Am Ende der Erstbefragung baut `anamnese` den Baum statt `AKTE.md` im bisherigen Aufbau und legt keine `BEURTEILUNG.md` an.
- AC-27: Der Neubau hängt an die Beurteilung nur an und committet sie.
- AC-29: Ist der Neubau abgeschlossen, sind seine Zwischenstände gelöscht.
- AC-33: Der Überblick nennt unter `## Fristen bis TT.MM.JJJJ` das Datum, bis zu dem seine Fristen reichen.

## Toward
> **AC-9** Jedes Einarbeiten hält die Höchstlängen ein. Dafür fasst es Älteres zusammen, mit einem Verweis auf die Stelle mit den Einzelheiten, oder teilt ein Kapitel in Unterkapitel; ein Kapitel mit Unterkapiteln ist selbst ein kurzer Überblick mit Verweisen. Die Zusammenfassung am Ende des Einarbeitens nennt jede Teilung. Danach ist jede Angabe, die durch keine Unterlage überholt ist, vom Überblick aus über Verweise erreichbar.

> **AC-10** Den Überblick kürzt das Einarbeiten nur an den Teilen, die sich auslagern lassen: die Zeilen unter „Probleme, Vorerkrankungen und Operationen“, etwa indem Abgeschlossenes zu einer Zeile mit Verweis zusammengefasst wird. Reicht das nicht, bleibt der Überblick vollständig und dafür über seiner Grenze.

> **AC-11** Nach jedem Einarbeiten zeigt kein Verweis ins Leere. Was sich nicht beheben ließ, nennt die Zusammenfassung am Ende des Einarbeitens.

> **AC-12** Einschätzungen, Warnzeichen mit Stufe, Fristen und das, was beobachtet wird, erarbeitet das Modell und hängt sie an die Beurteilung in `unterlagen/` an. Jeder Eintrag ist datiert, als Einschätzung eines Modells gekennzeichnet und wird nie umgeschrieben. Im Gespräch entstehen sie als Entwurf, ohne Commit und ohne Bestätigung durch den Benutzer. Das Einarbeiten committet sie nach einer Gegenprüfung.

> **AC-17** Neubau, Kontrolle und Prüfung der Akte gibt es für den ganzen Baum, wie heute für `AKTE.md`: in Stapeln, ersetzt wird erst nach dem Abgleich mit der vorigen Fassung, und ein Abbruch lässt den Stand, wie er war.

> **AC-18** Die Skills `anamnese`, `neue-information`, `einarbeiten`, `diagnose`, `naechste-schritte`, `vorsorge`, `termin-vorbereiten` und `notfallpass` geben aus, was sie heute ausgeben, auf Grundlage des Baums. Am Ende der Erstbefragung baut `anamnese` den Baum statt `AKTE.md` im bisherigen Aufbau und legt keine `BEURTEILUNG.md` an.

> **AC-27** Die Beurteilung bleibt für immer in `unterlagen/`, wird nur angehängt und committet.

> **AC-29** Nach der Umstellung gibt es die alte `AKTE.md` und `BEURTEILUNG.md` nur noch in der Git-Geschichte der Akte. Zwischenstände eines Baus werden gelöscht, wenn er abgeschlossen ist.

> **AC-33** Der Überblick nennt das Datum, bis zu dem seine Fristen reichen. Ist es beim Start einer Sitzung vorbei, meldet der Start das, und `/einarbeiten` schreibt den Überblick neu, auch ohne neue Unterlagen.

## Technical decisions
> **Concepts** Der **Überblick** (`AKTE.md`) verweist auf **Kapitel**. Ein Kapitel gehört entweder zu einem **Problem**, also allem, was behandelt oder abgeklärt wird, auch ohne Diagnose, oder zu einem übergreifenden Thema. Ein Kapitel kann **Unterkapitel** haben. Ein Problem ist **aktiv**, **ruhend** oder **abgeschlossen**; „Beobachten“ bleibt das Wort für Themen, die mit einer Messreihe verfolgt werden. Überblick und Kapitel haben je eine **Höchstlänge**. Die **Beurteilung** ist eine Unterlage in `unterlagen/`, die nur angehängt wird. Überblick und Kapitel fassen Unterlagen, Literatur und Beurteilung zusammen. `BEURTEILUNG.md` entfällt.

> **Wire formats** Von außen hängt nur der Aufbau bestehender Akten ab. Eine Akte im bisherigen Aufbau erhält beim Start die Meldung, dass sie abweicht, und wird mit `/einarbeiten` umgestellt (AC-15). Braucht der Weg für AC-1 eine Datei in der Akte, etwa für Claude Code, legt die Umstellung sie an. Sonst keine.

> **Hard to reverse** Die Umstellung entfernt `AKTE.md` im bisherigen Aufbau und `BEURTEILUNG.md` und verwirft dabei die Herleitungen, den Abschnitt „Quellen“ und den Wortlaut von Leitlinien, die in `literatur/` vorliegen. Das gibt eine Akte, die die Beratung zu jeder Frage kennen kann. Es kostet, dass die Herleitungen nur noch in der Git-Geschichte stehen. Außerdem wird die Beurteilung nur angehängt und nie umgeschrieben (AC-12, AC-27). Das gibt Einschätzungen, die von Beratung zu Beratung gleich bleiben. Es kostet, dass sie mit der Akte wächst, dass jeder Neubau sie lesen muss und dass ein falscher Eintrag nur durch einen neuen überholt werden kann.

## Context
Heute baut `agents/akte-nachziehen.md` unter „Vollständiger Bau“ `AKTE.md` in Stapeln aus `akte-stand --stapel`: Zwischenfassungen unter `.git/akte-bau/`, je Stapel ein Lauf von `agents/akte.md` und eine Gegenprüfung mit `agents/aenderung-gegenpruefen.md`, dann je Stapel ein Abgleich mit `HEAD:AKTE.md`, erst danach Ersetzen und Commit. Die Regeln für `AKTE.md` stehen in `agents/akte.md` unter „Regeln“ und „Aufbau“, das Gerüst in `vorlagen/AKTE.md`. `skills/anamnese` und `.claude/skills/run/neue-testakte` legen heute `BEURTEILUNG.md` aus `vorlagen/BEURTEILUNG.md` an.

Von Ticket 01: `kapitel/`, Verweise als relative Markdown-Links, die Prüfsummen in `kapitel/grundlage.md`, die Höchstlängen oben in `bin/akte-stand`, die Überschrift `## Fristen bis TT.MM.JJJJ` und was ein nicht abgeschlossener Bau ist.

Dieses Ticket legt fest, worauf 03, 04 und 05 bauen:

- Die Beurteilung ist `unterlagen/beurteilung.md`. Ihre Einträge stehen unter Überschriften `## TT.MM.JJJJ` mit dem Datum des Eintrags, wie in `historie.md`. Die Vorlage dafür liegt in `vorlagen/`. `akte-stand --stapel` und `--einheit` teilen sie an diesen Überschriften wie `historie.md`, weil sie nur wächst.
- Die Vorlagen für Überblick und Kapitel, die feste Liste der übergreifenden Kapitel und wie eine Angabe ihre Quelle nennt. Heute: `[2025-03-01-labor]`, `[historie TT.MM.JJJJ]`, `[anamnese]`. Neu sind eine Stelle in `literatur/` und ein Eintrag der Beurteilung mit Datum. Kapitel nach Fachgebiet und Kapitel, die das Modell frei schneidet, sind ausgeschlossen.

Was `akte-stand --vorlage` im neuen Aufbau vergleicht, gehört zu den Vorlagen dieses Tickets. Es meldet nur Abweichungen, die das Angleichen beheben kann; die Beurteilung schreibt das Angleichen nie um. In einer Akte im bisherigen Aufbau meldet `--vorlage` nichts; dort meldet Ticket 01 die Abweichung vom neuen Aufbau.

Die Regeln für Überblick und Kapitel, die dieses Ticket in `agents/akte.md` schreibt, gelten für jeden Bau. Ticket 03 setzt den schrittweisen Bau darauf.

Eine Akte im bisherigen Aufbau wird ab hier nicht mehr gebaut. Ihre Umstellung ist Ticket 05.

Security policy sagt „None.“: Eine neue Berechtigung, etwa in den Einstellungen einer Akte, wäre eine Abweichung.

## Not here
- Schrittweiser Bau, Kontrolle und Prüfung des Baums, und das Lesen in `literatur/` zu einer neuen Unterlage (AC-32): 03.
- Wie die Beratung den Baum liest, und die übrigen Skills: 04.
- Die Umstellung einer Akte im bisherigen Aufbau: 05.
- Ob eine Leitlinie noch gilt; das braucht eine Suche im Netz und bleibt bei `leitlinien-recherche`.
- Leitlinien, die noch nicht in `literatur/` liegen; sie sucht die Beratung wie heute vor einer Empfehlung.
- Wie viel Raum Warnzeichen einnehmen (Backlog: `warnzeichen-zu-viel-raum`).

## Left standing

- **Behoben nach der letzten Prüfung, von niemandem geprüft (AC-2, AC-12, AC-13):** Drei Should-fix-Funde und zwei Nits aus der zweiten Runde.
  - Welcher Eintrag der Beurteilung gilt: Ein späterer Eintrag löst einen früheren nur ab, wenn Thema und Art gleich sind. „Aufgehoben“ nennt Art und Datum des Eintrags, den es aufhebt. Mehrere Warnzeichen oder Fristen zu einem Problem bekommen je ein eigenes Thema, etwa „Hypertonie, Blutdruckkrise“. Das steht jetzt gleich in `vorlagen/beurteilung.md`, `vorlagen/kapitel.md`, `agents/akte.md` und `agents/aenderung-gegenpruefen.md`.
  - Der Status eines Problems folgt jetzt aus allen Fakten des Kapitels, nicht nur aus der letzten Unterlage. Eine offene Behandlung, Abklärung oder Frist aus jeder Unterlage macht es aktiv. Eine frühere Operation oder Erkrankung, die keine Unterlage als fortbestehend nennt, ist abgeschlossen.
  - Die Testakte hat jetzt einen ruhenden Heuschnupfen und eine abgeschlossene Appendektomie. Die Form ihrer Einträge passt zur Vorlage.
- **Nicht automatisch geprüft (AC-2, AC-3, AC-13, AC-14, AC-20, AC-28; Toward AC-12, AC-17, AC-27, AC-29, AC-33):** Was der Neubau schreibt, steht in den Agenten und ist Text für ein Modell; kein Test prüft es. Geprüft wurde es in drei Läufen der Testakte nach `.claude/skills/run/SKILL.md`, einer davon mit `--klein` in fünf Stapeln. Die Läufe zeigten:
  - Im Hauptverzeichnis stehen nur `AKTE.md`, `kapitel/`, `unterlagen/` und `literatur/`; die Kapitel sind committet.
  - Die falschen Grade der Leitlinie sind nach `literatur/` berichtigt, und die Zusammenfassung nennt das.
  - Die überholten Einträge sind als neue Einträge an `unterlagen/beurteilung.md` angehängt und vor dem Baum committet.
  - Die abgelehnte Impfung steht im Kapitel Impfungen.
  - Ein zweiter Neubau gleicht mit der vorigen Fassung ab, und `.git/akte-bau/` ist danach gelöscht.

  Automatisch geprüft wird nur `bin/akte-stand`.
- **Nicht vorgeführt (AC-9, AC-10, AC-11, AC-18):** Die Testakte ist zu klein, um ein Kapitel zu teilen, den Überblick über seine Höchstlänge zu bringen oder einen Verweis ins Leere zu reparieren. Die Regeln dafür stehen in `agents/akte.md` unter „Höchstlängen“ und „Verweise“, aber kein Lauf hat sie gebraucht. Die Erstbefragung mit `anamnese` lief nicht; geändert ist dort nur der Text: keine `BEURTEILUNG.md`, am Ende der Baum.
- **Abweichung (Context, Beurteilung):** Der Neubau hängt nicht nur geänderte Einschätzungen an, sondern im Abschluss auch Einträge der Art „Aufgehoben“, wenn eine Einschätzung gar nicht mehr gilt, etwa nach einer erledigten Frist. Sonst bliebe sie in der Beurteilung gültig, weil diese nie umgeschrieben wird.
- **Entscheidungen, auf die 03, 04 und 05 bauen:**
  - Die Beurteilung ist `unterlagen/beurteilung.md` nach `vorlagen/beurteilung.md`. Ein Eintrag steht unter `## TT.MM.JJJJ`, darunter die kursive Zeile `*Einschätzung eines Modells, nicht ärztlich bestätigt; Anlass: …*`, dann je Eintrag eine Zeile `- **Thema – Art:** Inhalt. Grund: …`. Die Arten sind Einschätzung, Warnzeichen, Frist, Beobachten und Aufgehoben.
  - `akte-stand --stapel` und `--einheit` teilen die Beurteilung an diesen Überschriften. Am selben Tag kommt sie nach `historie.md`.
  - Die Vorlage für Kapitel ist `vorlagen/kapitel.md`, mit den Abschnitten Fakten, Literatur, Einschätzungen, Abgelehnt und Unterkapitel. Der Status steht unter dem Hinweis.
  - Die übergreifenden Kapitel sind genau diese: `person`, `behandelnde`, `medikation`, `psyche`, `gynaekologie`, `impfungen`, `vorsorge` und `messwerte`.
  - So nennt eine Angabe ihre Quelle: `[literatur/<datei ohne Endung> <Stelle>]` und `[beurteilung TT.MM.JJJJ]`.
  - `akte-stand --vorlage` vergleicht den Überblick und jedes Kapitel ohne seinen Titel. Das Datum der Fristen zählt dabei nicht mit. Im bisherigen Aufbau meldet es nichts.
  - Der Neubau arbeitet in `.git/akte-bau/stapel-N/` und `.git/akte-bau/abschluss/` und schreibt die neuen Einträge in `.git/akte-bau/beurteilung-neu.md`. Er committet zuerst die Beurteilung, dann `AKTE.md` und `kapitel/` zusammen.
  - `vorlagen/BEURTEILUNG.md` ist gelöscht, auch weil es auf Dateisystemen ohne Groß- und Kleinschreibung mit `vorlagen/beurteilung.md` zusammenfiele. Der Name `vorlagen/AKTE.md` bleibt, mit der Vorlage für den Überblick.
- **Für 03 (AC-17, AC-18):** Ein neues Problem bekommt beim Neubau keine erste Einschätzung und keine Warnzeichen. Der Neubau sucht keine Literatur und legt keine neuen Themen an. Eine neue Akte hat darum nach der Erstbefragung leere Abschnitte für Einschätzungen und Warnzeichen, bis 03 oder 04 sie füllt. Bis 03 gilt außerdem:
  - Der schrittweise Bau committet noch „`AKTE.md` allein“.
  - „Kontrolle“ und „Prüfung“ in `agents/akte-nachziehen.md` beschreiben noch den bisherigen Aufbau.
  - `skills/einarbeiten` nennt in seiner Zusammenfassung an den Benutzer noch `BEURTEILUNG.md`.

  Eine Akte im bisherigen Aufbau wird nicht mehr gebaut: Ihre Unterlagen werden nur committet. Der Branch sollte darum als Ganzes landen.
- **Namen ohne Glossar:** Abschluss (der letzte Schritt eines Neubaus), Zwischenstand, die Art „Aufgehoben“ und die Namen der übergreifenden Kapitel. Sie sind zu bestätigen, wenn 05 das Glossar schreibt.
- **Blast radius:** Wer `/einarbeiten` in einer Akte im bisherigen Aufbau aufruft, bekommt keinen Bau mehr, bis 05 die Umstellung bringt. Ein Revert stellt `vorlagen/BEURTEILUNG.md` und die alte Vorlage wieder her. Akten, die schon als Baum gebaut sind, bleiben dabei, wie sie sind, ebenso Einträge, die schon an `unterlagen/beurteilung.md` angehängt sind.
