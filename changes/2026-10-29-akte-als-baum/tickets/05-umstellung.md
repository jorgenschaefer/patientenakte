---
criteria:  CRITERIA.md
closes:    AC-8, AC-15, AC-16, AC-21, AC-22, AC-29, AC-31
advances:
after:     04-beraten-auf-dem-baum
status:    done
attempts:  1
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

- **Behoben nach der letzten Prüfung, von niemandem geprüft (AC-16, AC-22):** zwei Should-fix-Funde aus der zweiten Runde.
  - Bei der Umstellung committet Schritt 4.4 in `agents/akte-nachziehen.md` die Beurteilung jetzt mit `-- unterlagen/beurteilung.md`. Sonst käme das schon vorgemerkte Entfernen von `BEURTEILUNG.md` in diesen Commit statt in den Commit des Baums. Bräche die Umstellung zwischen den beiden Commits ab, hätte `HEAD` dann die alte `AKTE.md` ohne `BEURTEILUNG.md`, und `akte-stand` erkännte den bisherigen Aufbau nicht mehr.
  - `neue-testakte --bisherig` legt als Entwurf aus dem Gespräch jetzt einen Eintrag zur Flanke an statt zum Knie. Bisher hängte `nachtrag` denselben Eintrag zum Knie ein zweites Mal an. Das Einarbeiten wollte die Kopie dann mit `git checkout` zurücknehmen, und das lehnt der Auto-Modus ab.
- **Nicht automatisch geprüft (AC-8, AC-15, AC-16, AC-22, AC-29, AC-31):** Was die Umstellung tut, steht als Text für ein Modell in `regeln.md`, `skills/einarbeiten` und `agents/`. Automatisch geprüft wird nur `bin/akte-stand`: die gemeldete nicht abgeschlossene Umstellung, eine Akte, in der die Umstellung `BEURTEILUNG.md` schon entfernt, aber noch nicht committet hat, und der Zwischenstand, der während der Umstellung als Baum geprüft wird. Die übrigen Kriterien wurden in zwei Prüfrunden mit Testakten nach `.claude/skills/run/SKILL.md` geprüft, Schritt 4, mit drei Umstellungen:
  - AC-31: Vor der Umstellung las die Beratung die alte `AKTE.md` und `BEURTEILUNG.md`, arbeitete nichts ein, schlug `/einarbeiten` vor und hängte Einschätzungen an `unterlagen/beurteilung.md` an, ohne Commit.
  - AC-15: Der erste Eintrag stand vor dem Eintrag aus dem Gespräch und enthielt alle verlangten Arten. Empfehlung 3.2 der Testleitlinie stand nur noch als Verweis da, die Aussage der STIKO mit Wortlaut und Quelle. Der Abschnitt „Quellen“ und die Herleitungen fielen weg. Drei Entwürfe kamen nach `historie.md`: Ibuprofen, die Ablehnung des Statins und das Organisatorische, nicht die Grippeimpfung, die dort schon steht.
  - AC-16: Nach dem ersten `/einarbeiten`, das bei der Bestätigung des Wortlauts endete, meldete der nächste Start die nicht abgeschlossene Umstellung. Ein zweites `/einarbeiten` ließ `historie.md` und `beurteilung.md` Byte für Byte gleich. Einmal brach ein Lauf mitten im Bau ab, weil das Werkzeug des Prüfers ihn nach zehn Minuten beendete. Der nächste Lauf setzte fort, ohne etwas doppelt anzulegen. Nicht gezeigt ist das Verwerfen eines liegen gebliebenen Baus (unter „Not here“).
  - AC-29: `BEURTEILUNG.md` und die alte `AKTE.md` wurden im selben Commit entfernt wie der Baum angelegt wurde. `.git/akte-bau/` war danach gelöscht, `.claude/CLAUDE.md` angelegt, und `akte-stand` meldete nur noch den Stand.
  - AC-22: Mit `woerter_kapitel` bei etwa drei Vierteln des Kapitels zur Hypertonie teilten `nachtrag` und `/einarbeiten` drei Kapitel in Unterkapitel. Danach meldete `akte-stand` keinen Verweis ins Leere.
  - AC-8, nur teilweise gezeigt: Die Antwort auf eine Frage zur Physio nannte den Schmerz in der linken Flanke als Grundlage, begann aber mit einer Einschätzung der Dringlichkeit zum Knie. Grund war ein Eintrag „Knieschmerzen wieder da“, den eine frühere Testfrage desselben Laufs an die Beurteilung gehängt hatte. Eine Frage nach Amoxicillin ging von der Penicillinallergie aus, eine zur Grippeimpfung von der Hypertonie und der Ablehnung im Vorjahr. Auf eine Frage nach Ibuprofen gab es nur die Dringlichkeit zum Knie, keine Antwort. Abgenommen wird AC-8 in der Akte des Benutzers (unter „Not here“).
- **Nicht geprüft (AC-15):** Bricht die Umstellung vor der Bestätigung ab und folgt eine neue Sitzung, erkennt `einarbeiten` die Entwürfe der Umstellung nur an ihrem Wortlaut, etwa „(aus BEURTEILUNG.md, Stand …)“. Nur dann schlägt es sie nicht zum Streichen vor. Gelaufen ist nur der Weg mit `--continue` in derselben Sitzung.
- **Abweichung (Context, `akte-stand`):** Eine Akte gilt auch dann als bisheriger Aufbau, wenn `BEURTEILUNG.md` nur noch in `HEAD` steht. Das tritt ein, wenn die Umstellung die Datei schon entfernt, aber noch nicht committet hat. Die Prüfsummen schreibt `--aktualisieren` in diesem Fall schon nach `kapitel/grundlage.md`. Außerhalb des Arbeitsverzeichnisses, etwa in einem Zwischenstand unter `.git/akte-bau/`, gilt das nicht. Sonst würde ein Abbruch kurz vor dem letzten Commit wie ein liegen gebliebener Bau im neuen Aufbau aussehen.
- **Entscheidungen, die teuer zu ändern sind:**
  - Den Beginn einer Umstellung erkennt `akte-stand` an der Zeile „Anlass: Umstellung von BEURTEILUNG.md.“ in `unterlagen/beurteilung.md`. Daran erkennt die Umstellung auch, dass sie ihren ersten Eintrag und die Entwürfe schon angelegt hat. Die Meldung lautet „Eine Umstellung auf den neuen Aufbau ist nicht abgeschlossen.“.
  - Der erste Eintrag trägt das Datum des letzten Commits von `BEURTEILUNG.md`. Er steht hinter den committeten Einträgen und vor denen aus dem Gespräch, denn diese sind jünger.
  - `einarbeiten` startet `akte-nachziehen` bei der Umstellung zweimal: mit „Umstellung, Entwürfe“ vor der Bestätigung und mit „Umstellung“ danach.
  - Die Beratung kennt `CLAUDE_PLUGIN_ROOT` nicht; gemessen mit `echo` in `claude -p`. Darum findet die Regel für den bisherigen Aufbau die Vorlage der Beurteilung über den Pfad von `akte-stand` im `PATH`.
- **Glossar (AC-21):** `UBIQUITOUS_LANGUAGE.md` entstand ohne die Rückfragen, die der Skill `ubiquitous-language` vorsieht, weil der Lauf ohne Benutzer lief. Zu bestätigen sind:
  - die Namen, die frühere Tickets offen ließen: Abschluss, Zwischenstand, Aufgehoben, die Namen der übergreifenden Kapitel;
  - die Namen aus diesem Ticket: Umstellung, „bisheriger Aufbau“, „Abgleich mit der vorigen Fassung“, „Stand der Akte“;
  - die Aliase, die vermieden werden sollen: „Akte“ für `AKTE.md` und „Diagnose“ für ein Problem.

  Abweichend vom Format des Skills stehen in Klammern die deutschen Namen aus dem Code, denn das Plugin benennt seinen Code auf Deutsch. `stand-einspielen` und `vorlagen/claude.md` sind Dateinamen, keine Begriffe der Akte, und stehen nicht im Glossar.
- **Blast radius:** Jedes `/einarbeiten` in einer Akte im bisherigen Aufbau stellt sie um und entfernt `AKTE.md` und `BEURTEILUNG.md`. Ein Revert des Plugins holt die Dateien nicht zurück, die Akte hat sie dann nur noch in ihrer Git-Geschichte. Auch der erste Eintrag der Beurteilung und die Entwürfe in `historie.md` bleiben. Zurück in den bisherigen Aufbau kommt eine Akte nur mit Git in der Akte selbst.
