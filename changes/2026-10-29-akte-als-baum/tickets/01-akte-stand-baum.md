---
criteria:  CRITERIA.md
closes:    AC-4, AC-5, AC-23, AC-25
advances:  AC-11, AC-15, AC-24, AC-26, AC-31, AC-33
after:
status:    done
attempts:  1
---

## Build
`akte-stand` und der Start einer Sitzung kennen den Baum: wo seine Prüfsummen stehen, was ein nicht abgeschlossener Bau ist, die beiden Höchstlängen, Verweise ins Leere, ein fehlender Überblick, das Enddatum seiner Fristen und eine Akte im bisherigen Aufbau.

## Done when
> **AC-4** Der Überblick hat eine Höchstlänge, zu Beginn 2.000 Wörter.

> **AC-5** Jedes Kapitel hat eine Höchstlänge, zu Beginn 1.500 Wörter.

> **AC-23** Ein nicht abgeschlossener Bau wird beim Start einer Sitzung gemeldet, wie heute.

> **AC-25** Einen Überblick über seiner Grenze meldet der Start jeder Sitzung.

Zu den ACs unter „Toward“:

- AC-11: `akte-stand` meldet jeden Verweis in Überblick und Kapiteln, der auf keine Datei zeigt.
- AC-15: Der Start einer Sitzung in einer Akte im bisherigen Aufbau meldet, dass sie vom neuen Aufbau abweicht. Die Umstellung selbst noch nicht.
- AC-24: Der Start jeder Sitzung meldet jedes Kapitel über seiner Höchstlänge.
- AC-26: Der Start einer Sitzung meldet einen fehlenden Überblick. Was die erste Antwort dazu sagt, noch nicht.
- AC-31: In einer Akte im bisherigen Aufbau meldet `akte-stand` neue, geänderte und entfernte Unterlagen und einen nicht abgeschlossenen Bau wie heute, gegen die Prüfsummen am Ende der alten `AKTE.md`.
- AC-33: Ist das Datum, bis zu dem die Fristen des Überblicks reichen, beim Start vorbei, meldet der Start das.

## Toward
> **AC-11** Nach jedem Einarbeiten zeigt kein Verweis ins Leere. Was sich nicht beheben ließ, nennt die Zusammenfassung am Ende des Einarbeitens.

> **AC-15** Eine bestehende Akte mit `AKTE.md` und `BEURTEILUNG.md` im bisherigen Aufbau meldet beim Start, dass sie vom neuen Aufbau abweicht. `/einarbeiten` stellt sie dann so um: `BEURTEILUNG.md` wird auf die eigenen Einschätzungen des Modells gekürzt und der erste datierte Eintrag der Beurteilung. Er enthält die Einschätzungen, die Warnzeichen mit Stufe, die Fristen aus „Offen“, die Themen unter „Beobachten“, den Vorsorgeplan samt dem, was geprüft wurde und nicht zutrifft, und Aussagen einer Leitlinie, deren Quelle nicht in `literatur/` vorliegt, mit dieser Quelle. Aussagen einer Leitlinie, deren Quelle in `literatur/` vorliegt, verlieren ihren Wortlaut, behalten aber den Verweis auf Quelle und Stelle. Es fallen weg: der Abschnitt „Quellen“ und die Herleitungen. Angaben des Patienten, Abgelehntes und Organisatorisches, die noch nicht in den Unterlagen stehen, kommen als Entwurf nach `unterlagen/historie.md`, und der Benutzer bestätigt ihren Wortlaut. Danach wird der Baum gebaut und gegengeprüft, und die alte `AKTE.md` und `BEURTEILUNG.md` werden entfernt.

> **AC-24** Ein Kapitel, das nach dem Einarbeiten über seiner Grenze ist, nennt die Zusammenfassung am Ende des Einarbeitens, und der Start jeder Sitzung meldet es wieder, bis es behoben ist.

> **AC-26** Fehlt der Überblick, meldet der Start der Sitzung das; die erste Antwort sagt es in einem Satz und schlägt `/einarbeiten` vor.

> **AC-31** Eine Akte im bisherigen Aufbau berät bis zur Umstellung wie heute auf Grundlage der alten `AKTE.md` und `BEURTEILUNG.md` und nimmt neue Angaben als Entwurf auf. Beim Start einer Sitzung läuft das Einarbeiten in ihr nicht von selbst, sondern wird vorgeschlagen; jedes `/einarbeiten` stellt sie zuerst um.

> **AC-33** Der Überblick nennt das Datum, bis zu dem seine Fristen reichen. Ist es beim Start einer Sitzung vorbei, meldet der Start das, und `/einarbeiten` schreibt den Überblick neu, auch ohne neue Unterlagen.

## Technical decisions
> **Concepts** Der **Überblick** (`AKTE.md`) verweist auf **Kapitel**. Ein Kapitel gehört entweder zu einem **Problem**, also allem, was behandelt oder abgeklärt wird, auch ohne Diagnose, oder zu einem übergreifenden Thema. Ein Kapitel kann **Unterkapitel** haben. Ein Problem ist **aktiv**, **ruhend** oder **abgeschlossen**; „Beobachten“ bleibt das Wort für Themen, die mit einer Messreihe verfolgt werden. Überblick und Kapitel haben je eine **Höchstlänge**. Die **Beurteilung** ist eine Unterlage in `unterlagen/`, die nur angehängt wird. Überblick und Kapitel fassen Unterlagen, Literatur und Beurteilung zusammen. `BEURTEILUNG.md` entfällt.

> **Wire formats** Von außen hängt nur der Aufbau bestehender Akten ab. Eine Akte im bisherigen Aufbau erhält beim Start die Meldung, dass sie abweicht, und wird mit `/einarbeiten` umgestellt (AC-15). Braucht der Weg für AC-1 eine Datei in der Akte, etwa für Claude Code, legt die Umstellung sie an. Sonst keine.

> **Hard to reverse** Die Umstellung entfernt `AKTE.md` im bisherigen Aufbau und `BEURTEILUNG.md` und verwirft dabei die Herleitungen, den Abschnitt „Quellen“ und den Wortlaut von Leitlinien, die in `literatur/` vorliegen. Das gibt eine Akte, die die Beratung zu jeder Frage kennen kann. Es kostet, dass die Herleitungen nur noch in der Git-Geschichte stehen. Außerdem wird die Beurteilung nur angehängt und nie umgeschrieben (AC-12, AC-27). Das gibt Einschätzungen, die von Beratung zu Beratung gleich bleiben. Es kostet, dass sie mit der Akte wächst, dass jeder Neubau sie lesen muss und dass ein falscher Eintrag nur durch einen neuen überholt werden kann.

## Context
Heute vergleicht `bin/akte-stand` die Dateien in `unterlagen/` mit den Prüfsummen im Abschnitt „Grundlage“ am Ende von `AKTE.md`. Ein nicht abgeschlossener Bau sind Änderungen ohne Commit an `AKTE.md`. `--vorlage` vergleicht `AKTE.md` und `BEURTEILUNG.md` mit `vorlagen/`. Die Tests stehen in `tests/akte-stand.sh`. `hooks/regeln-einspielen` gibt beim Start `regeln.md` und die Ausgabe von `akte-stand` aus; Claude Code schneidet die Ausgabe eines Hooks ab etwa 10 KB ab.

Diese Namen legt dieses Ticket fest; die Tickets 02 bis 05 bauen darauf:

- Die Kapitel liegen in `kapitel/`, ein Kapitel als `kapitel/<name>.md`, seine Unterkapitel in `kapitel/<name>/`.
- Ein Verweis ist ein Markdown-Link mit einem Pfad relativ zu der Datei, in der er steht.
- Die Prüfsummen des Baums stehen in `kapitel/grundlage.md`, nicht im Überblick: Der Überblick ist in jeder Sitzung ganz im Kontext (AC-1). `grundlage.md` ist kein Kapitel.
- Die beiden Höchstlängen stehen in Wörtern oben in `bin/akte-stand`, neben `seiten_je_stapel`. Die Agenten lesen sie dort.
- Der Überblick nennt das Ende seiner Fristen in der Überschrift `## Fristen bis TT.MM.JJJJ`. Geschrieben wird sie in Ticket 02.
- Eine Akte im bisherigen Aufbau ist eine mit `BEURTEILUNG.md` im Hauptverzeichnis.
- Im neuen Aufbau ist ein nicht abgeschlossener Bau eine Änderung ohne Commit an `AKTE.md` oder in `kapitel/`.

Was `--vorlage` für den Baum vergleicht, gehört zu den Vorlagen in Ticket 02.

Security policy sagt „None.“: Eine neue Berechtigung, etwa in den Einstellungen einer Akte, wäre eine Abweichung.

## Not here
- Den Baum schreiben: der Neubau in 02, das schrittweise Einarbeiten in 03.
- Wie die Beratung auf diese Meldungen antwortet, steht in `regeln.md`: für den neuen Aufbau in 04, für den bisherigen in 05.
- Die Umstellung und die Meldung einer abgebrochenen Umstellung: 05.

## Left standing

- **Review, Should-fix, nicht behoben (AC-15, AC-31):** Ob eine Akte den bisherigen Aufbau hat, entscheidet allein `BEURTEILUNG.md`. Der heutige `akte-nachziehen` ruft `akte-stand --aktualisieren` auf und committet danach nur `AKTE.md`. In einer Akte ohne `BEURTEILUNG.md` landen die Prüfsummen dann in einer `kapitel/grundlage.md` ohne Commit. Heute tritt das nicht auf, weil die Anamnese `BEURTEILUNG.md` beim Einrichten anlegt; neue Akten haben also den bisherigen Aufbau. Das Problem entsteht erst, wenn Ticket 02 die Anamnese ändert, ohne `akte-nachziehen` auf `kapitel/` umzustellen. Der Branch sollte deshalb als Ganzes landen, nicht nach diesem Ticket allein.
- **Review, Nits, nicht behoben (AC-11):** Als Verweis ins Leere gemeldet werden auch funktionierende Links: mit `%20`, mit `)` im Pfad und in Code-Spans. Nicht geprüft werden Links mit Leerraum innerhalb der Klammern, etwa `[x]( pfad )`, und Referenz-Links wie `[r]: pfad`. Nicht behoben, weil `regeln.md` Dateinamen in Kleinbuchstaben ohne Leerzeichen und ohne Klammern verlangt und die Agenten aus Ticket 02 und 03 Inline-Links schreiben.
- **Behoben nach der letzten Prüfung, von niemandem geprüft (AC-33):** Ein Datum, das es nicht gibt, etwa `31.13.2099`, wird als nicht lesbar gemeldet (Should-fix aus der zweiten Runde). Die Fristen-Überschrift zählt auch in der letzten Zeile ohne Zeilenende (Nit aus der zweiten Runde).
- **Abweichung (AC-33):** Steht eine Überschrift `## Fristen…` im Überblick, ohne ein gültiges Datum als TT.MM.JJJJ zu nennen, meldet `akte-stand`: „Die Überschrift der Fristen in AKTE.md nennt kein Datum als TT.MM.JJJJ: …“. Das Ticket verlangt nur die Meldung abgelaufener Fristen; ohne die neue Meldung würde ein falsch geschriebenes Datum die Warnung stumm abschalten. Fehlt die Überschrift ganz, meldet `akte-stand` nichts, denn geschrieben wird sie erst in Ticket 02.
- **Neue Meldungen, auf die Ticket 04 und 05 antworten (AC-15, AC-23, AC-25, AC-24, AC-26, AC-11, AC-33):** Im neuen Aufbau lauten sie: „AKTE.md oder kapitel/ hat Änderungen ohne Commit aus einem Bau, der nicht abgeschlossen ist.“, „AKTE.md und kapitel/ sind auf dem Stand von unterlagen/.“, „Der Überblick AKTE.md fehlt.“, „<datei> hat N Wörter, mehr als die Höchstlänge von M.“, „Verweis ins Leere in <datei>: <ziel>“ und „Die Fristen in AKTE.md reichen bis TT.MM.JJJJ; das Datum ist vorbei.“ Im bisherigen Aufbau ist eine neue Zeile vorangestellt: „Die Akte hat den bisherigen Aufbau mit BEURTEILUNG.md und weicht vom neuen Aufbau aus AKTE.md und kapitel/ ab.“ Alles andere bleibt dort wie bisher. Die Höchstlängen heißen `woerter_ueberblick` und `woerter_kapitel` und werden wie mit `wc -w` gezählt, also auch Markdown-Zeichen wie `#` und `|`.
- **Nicht von diesem Ticket (AC-26):** Im neuen Aufbau vergleicht `--vorlage` `AKTE.md` noch mit der alten Vorlage. Darum meldet der Start jeder Sitzung zusätzlich „AKTE.md weicht von der Vorlage ab.“ Das gehört zu Ticket 02.
- **Blast radius:** Jede Akte ohne `BEURTEILUNG.md` gilt jetzt als neuer Aufbau. Ihre Prüfsummen erwartet `akte-stand` dann in `kapitel/grundlage.md`. Ein Revert nimmt das zurück; eine `kapitel/grundlage.md`, die schon geschrieben wurde, bleibt aber in der Akte liegen.
