---
criteria:  CRITERIA.md
closes:    AC-8, AC-15, AC-16, AC-21, AC-22, AC-29, AC-31
advances:
after:     04-beraten-auf-dem-baum
status:    ready
attempts:  0
---

## Build
`/einarbeiten` stellt eine Akte im bisherigen Aufbau auf den Baum um; bis dahin berät sie wie heute. Dazu eine kleine erfundene Testakte, die Teilung und Umstellung zeigt, das README und das Glossar.

## Done when
> **AC-8** In der umgestellten Akte des Benutzers geht die Antwort auf eine Frage zur Physio von den Schmerzen in der linken Flanke aus, ohne dass der Benutzer sie erzählt. Ebenso bei zwei, drei weiteren Fragen, die der Benutzer stellt und deren Antwort er kennt.

> **AC-15** Eine bestehende Akte mit `AKTE.md` und `BEURTEILUNG.md` im bisherigen Aufbau meldet beim Start, dass sie vom neuen Aufbau abweicht. `/einarbeiten` stellt sie dann so um: `BEURTEILUNG.md` wird auf die eigenen Einschätzungen des Modells gekürzt und der erste datierte Eintrag der Beurteilung. Er enthält die Einschätzungen, die Warnzeichen mit Stufe, die Fristen aus „Offen“, die Themen unter „Beobachten“, den Vorsorgeplan samt dem, was geprüft wurde und nicht zutrifft, und Aussagen einer Leitlinie, deren Quelle nicht in `literatur/` vorliegt, mit dieser Quelle. Aussagen einer Leitlinie, deren Quelle in `literatur/` vorliegt, verlieren ihren Wortlaut, behalten aber den Verweis auf Quelle und Stelle. Es fallen weg: der Abschnitt „Quellen“ und die Herleitungen. Angaben des Patienten, Abgelehntes und Organisatorisches, die noch nicht in den Unterlagen stehen, kommen als Entwurf nach `unterlagen/historie.md`, und der Benutzer bestätigt ihren Wortlaut. Danach wird der Baum gebaut und gegengeprüft, und die alte `AKTE.md` und `BEURTEILUNG.md` werden entfernt.

> **AC-16** Bricht die Umstellung ab, bleiben die alte `AKTE.md` und `BEURTEILUNG.md` unverändert, die Beratung arbeitet weiter auf ihrer Grundlage, und der Start der nächsten Sitzung meldet den Abbruch. Bestätigte Einträge in `historie.md` bleiben. Ein neuer Versuch legt den ersten Eintrag der Beurteilung und die Entwürfe in `historie.md` nicht ein zweites Mal an. Ein nicht abgeschlossener Bau im bisherigen Aufbau wird bei der Umstellung verworfen.

> **AC-21** Das Plugin-Repo hat ein Glossar mit den Begriffen, die bleiben, und den neuen aus „Concepts“.

> **AC-22** Eine kleine erfundene Testakte im Plugin-Repo zeigt mit dem Skill `run`: Ein Kapitel über seiner Grenze wird beim Einarbeiten geteilt, eine Akte im bisherigen Aufbau wird umgestellt, und danach zeigt kein Verweis ins Leere.

> **AC-29** Nach der Umstellung gibt es die alte `AKTE.md` und `BEURTEILUNG.md` nur noch in der Git-Geschichte der Akte. Zwischenstände eines Baus werden gelöscht, wenn er abgeschlossen ist.

> **AC-31** Eine Akte im bisherigen Aufbau berät bis zur Umstellung wie heute auf Grundlage der alten `AKTE.md` und `BEURTEILUNG.md` und nimmt neue Angaben als Entwurf auf. Beim Start einer Sitzung läuft das Einarbeiten in ihr nicht von selbst, sondern wird vorgeschlagen; jedes `/einarbeiten` stellt sie zuerst um.

## Technical decisions
> **Concepts** Der **Überblick** (`AKTE.md`) verweist auf **Kapitel**. Ein Kapitel gehört entweder zu einem **Problem**, also allem, was behandelt oder abgeklärt wird, auch ohne Diagnose, oder zu einem übergreifenden Thema. Ein Kapitel kann **Unterkapitel** haben. Ein Problem ist **aktiv**, **ruhend** oder **abgeschlossen**; „Beobachten“ bleibt das Wort für Themen, die mit einer Messreihe verfolgt werden. Überblick und Kapitel haben je eine **Höchstlänge**. Die **Beurteilung** ist eine Unterlage in `unterlagen/`, die nur angehängt wird. Überblick und Kapitel fassen Unterlagen, Literatur und Beurteilung zusammen. `BEURTEILUNG.md` entfällt.

> **Wire formats** Von außen hängt nur der Aufbau bestehender Akten ab. Eine Akte im bisherigen Aufbau erhält beim Start die Meldung, dass sie abweicht, und wird mit `/einarbeiten` umgestellt (AC-15). Braucht der Weg für AC-1 eine Datei in der Akte, etwa für Claude Code, legt die Umstellung sie an. Sonst keine.

> **Hard to reverse** Die Umstellung entfernt `AKTE.md` im bisherigen Aufbau und `BEURTEILUNG.md` und verwirft dabei die Herleitungen, den Abschnitt „Quellen“ und den Wortlaut von Leitlinien, die in `literatur/` vorliegen. Das gibt eine Akte, die die Beratung zu jeder Frage kennen kann. Es kostet, dass die Herleitungen nur noch in der Git-Geschichte stehen. Außerdem wird die Beurteilung nur angehängt und nie umgeschrieben (AC-12, AC-27). Das gibt Einschätzungen, die von Beratung zu Beratung gleich bleiben. Es kostet, dass sie mit der Akte wächst, dass jeder Neubau sie lesen muss und dass ein falscher Eintrag nur durch einen neuen überholt werden kann.

## Context
Nach den Tickets 01 bis 04 gibt es den Baum, die Beurteilung, Neubau, schrittweises Einarbeiten und die Beratung darauf. Die Namen aus 01 und 02 gelten hier. Seit Ticket 01 meldet der Start, dass eine Akte mit `BEURTEILUNG.md` im Hauptverzeichnis vom neuen Aufbau abweicht. Der erste Eintrag der Beurteilung hat die Form, die Ticket 02 festgelegt hat. Hat Ticket 04 für AC-1 eine Datei in neuen Akten angelegt, legt die Umstellung dieselbe an.

Ticket 04 hat `regeln.md`, die Skills und die Recherche-Agenten auf den Baum umgeschrieben. Für eine Akte im bisherigen Aufbau kommt eine Regel nach `regeln.md`, nicht ein Weg in jeden Skill: Bis zur Umstellung liest die Beratung die alte `AKTE.md` und `BEURTEILUNG.md` an Stelle von Überblick und Kapiteln. Einschätzungen aus dem Gespräch kommen auch dort als Entwurf nach `unterlagen/beurteilung.md`, wie Ticket 04 es baut; der erste Eintrag der Umstellung steht vor ihnen. „Wie heute“ und die alte Form stehen im Commit `4b52c31`, vor dieser Änderung: in `regeln.md`, den Skills, `agents/akte-nachziehen.md`, `vorlagen/AKTE.md` und `vorlagen/BEURTEILUNG.md`. Die Grenze der Hook-Ausgabe, die der Check seit Ticket 04 festhält, gilt auch mit den Regeln für den bisherigen Aufbau.

`.claude/skills/run/neue-testakte` legt eine Testakte an; mit `--klein` gibt es dazu eine Kopie des Plugins mit kleinen Stapelgrenzen. `.claude/skills/run/SKILL.md` beschreibt, wie man das Plugin darin startet; der Auto-Modus dort lehnt `git checkout HEAD -- AKTE.md` ab, das Zurücksetzen eines liegen gebliebenen Baus. Für AC-8 nimmt dieser Bau den erfundenen Fall aus Ticket 04 und legt ihn als Akte im bisherigen Aufbau an, mit `AKTE.md` und `BEURTEILUNG.md` in der alten Form, die `neue-testakte` selbst schreibt, weil es Vorlagen und Bau dafür nicht mehr gibt, stellt sie um und stellt die Frage dazu. Damit beweist der Bau AC-8 an der Testakte. Abgenommen wird AC-8 erst mit dem Schritt des Benutzers nach dem Lauf, unter „Not here“.

Das README beschreibt heute `AKTE.md` und `BEURTEILUNG.md` im bisherigen Aufbau. Das Glossar kommt als `UBIQUITOUS_LANGUAGE.md` ins Hauptverzeichnis des Plugin-Repos. Es entsteht zuletzt, weil es den Stand nach der Änderung beschreibt.

Security policy sagt „None.“: Eine neue Berechtigung, etwa in den Einstellungen einer Akte, wäre eine Abweichung.

## Not here
- At deployment, a person: Der Benutzer stellt seine eigene Akte mit `/einarbeiten` um, bestätigt den Wortlaut der Entwürfe in `historie.md` und stellt dann die Frage zur Physio und zwei, drei weitere, deren Antwort er kennt (AC-8).
- At deployment, a person: Der Benutzer überprüft nach der Umstellung seiner Akte beide Höchstlängen.
- At deployment, a person: Der Entwickler prüft in einer interaktiven Sitzung, wie `.claude/skills/run/SKILL.md` es vorschreibt, dass die Umstellung einen liegen gebliebenen Bau im bisherigen Aufbau verwirft (AC-16), und gibt das Zurücksetzen dort frei. Der Bau zeigt diesen Fall nicht im Auto-Modus.
- Eine große erfundene Testakte mit festen Fragen, um Änderungen an der Beratung zu messen (Backlog: `testakte-evals`).

## Left standing
