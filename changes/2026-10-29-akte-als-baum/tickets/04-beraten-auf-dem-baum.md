---
criteria:  CRITERIA.md
closes:    AC-1, AC-6, AC-7, AC-12, AC-18, AC-19, AC-26, AC-30
advances:  AC-8
after:     03-einarbeiten-in-den-baum
status:    done
attempts:  1
---

## Build
Die Beratung arbeitet auf dem Baum: Regeln und Überblick sind beim Start ganz im Kontext, vor einer Antwort liest sie die Kapitel, die die Frage berühren, und Skills und Recherche-Agenten lesen und schreiben Baum und Beurteilung statt `AKTE.md` und `BEURTEILUNG.md` im bisherigen Aufbau.

## Done when
> **AC-1** Beim Start jeder Sitzung hat die Beratung die Regeln und den Überblick ganz im Kontext, ohne eine Datei nachzulesen.

> **AC-6** Vor einer beratenden Antwort liest die Beratung jedes Kapitel ganz, dessen Zeile im Überblick die Frage berührt. In einem Kapitel mit Unterkapiteln gilt dasselbe für die Zeilen dort, und so weiter nach unten, bis die Frage beantwortet ist. Bei einer Folgefrage zum selben Thema liest sie nicht neu. Fehlt ein Kapitel, auf das ein Verweis zeigt, oder lässt es sich nicht lesen, sagt die Antwort das in einem Satz, beruht auf dem Übrigen und schlägt `/einarbeiten` vor.

> **AC-7** Bei einem neuen Thema nennt die Beratung vor der Antwort in ein, zwei Sätzen, was aus der Akte die Antwort trägt, inhaltlich und ohne Namen von Dateien oder Kapiteln. Steht nichts dazu in der Akte, sagt sie das. Bei Warnzeichen der Stufe 1 oder 2 kommt die Dringlichkeit zuerst.

> **AC-12** Einschätzungen, Warnzeichen mit Stufe, Fristen und das, was beobachtet wird, erarbeitet das Modell und hängt sie an die Beurteilung in `unterlagen/` an. Jeder Eintrag ist datiert, als Einschätzung eines Modells gekennzeichnet und wird nie umgeschrieben. Im Gespräch entstehen sie als Entwurf, ohne Commit und ohne Bestätigung durch den Benutzer. Das Einarbeiten committet sie nach einer Gegenprüfung.

> **AC-18** Die Skills `anamnese`, `neue-information`, `einarbeiten`, `diagnose`, `naechste-schritte`, `vorsorge`, `termin-vorbereiten` und `notfallpass` geben aus, was sie heute ausgeben, auf Grundlage des Baums. Am Ende der Erstbefragung baut `anamnese` den Baum statt `AKTE.md` im bisherigen Aufbau und legt keine `BEURTEILUNG.md` an.

> **AC-19** Die Liste unter „Evidenz“ in `regeln.md` nennt statt der Nierenfunktion allgemein, was die Wahl oder Dosis eines Mittels ändert, etwa die Funktion von Niere oder Leber.

> **AC-26** Fehlt der Überblick, meldet der Start der Sitzung das; die erste Antwort sagt es in einem Satz und schlägt `/einarbeiten` vor.

> **AC-30** Gesundheitsdaten kommen nie ins Gedächtnis von Claude und nie ins Plugin-Repo.

Zu den ACs unter „Toward“:

- AC-8: In einer Testakte im neuen Aufbau steht eine Vorgeschichte, die eine Suche nach den naheliegenden Stichwörtern nicht trifft. Die Antwort auf eine Frage dazu geht von dieser Vorgeschichte aus, ohne dass der Benutzer sie erzählt.

Den Fall für AC-8 legt `.claude/skills/run/neue-testakte` an; Ticket 05 baut darauf.

## Toward
> **AC-8** In der umgestellten Akte des Benutzers geht die Antwort auf eine Frage zur Physio von den Schmerzen in der linken Flanke aus, ohne dass der Benutzer sie erzählt. Ebenso bei zwei, drei weiteren Fragen, die der Benutzer stellt und deren Antwort er kennt.

## Technical decisions
> **Concepts** Der **Überblick** (`AKTE.md`) verweist auf **Kapitel**. Ein Kapitel gehört entweder zu einem **Problem**, also allem, was behandelt oder abgeklärt wird, auch ohne Diagnose, oder zu einem übergreifenden Thema. Ein Kapitel kann **Unterkapitel** haben. Ein Problem ist **aktiv**, **ruhend** oder **abgeschlossen**; „Beobachten“ bleibt das Wort für Themen, die mit einer Messreihe verfolgt werden. Überblick und Kapitel haben je eine **Höchstlänge**. Die **Beurteilung** ist eine Unterlage in `unterlagen/`, die nur angehängt wird. Überblick und Kapitel fassen Unterlagen, Literatur und Beurteilung zusammen. `BEURTEILUNG.md` entfällt.

> **Wire formats** Von außen hängt nur der Aufbau bestehender Akten ab. Eine Akte im bisherigen Aufbau erhält beim Start die Meldung, dass sie abweicht, und wird mit `/einarbeiten` umgestellt (AC-15). Braucht der Weg für AC-1 eine Datei in der Akte, etwa für Claude Code, legt die Umstellung sie an. Sonst keine.

> **Hard to reverse** Die Umstellung entfernt `AKTE.md` im bisherigen Aufbau und `BEURTEILUNG.md` und verwirft dabei die Herleitungen, den Abschnitt „Quellen“ und den Wortlaut von Leitlinien, die in `literatur/` vorliegen. Das gibt eine Akte, die die Beratung zu jeder Frage kennen kann. Es kostet, dass die Herleitungen nur noch in der Git-Geschichte stehen. Außerdem wird die Beurteilung nur angehängt und nie umgeschrieben (AC-12, AC-27). Das gibt Einschätzungen, die von Beratung zu Beratung gleich bleiben. Es kostet, dass sie mit der Akte wächst, dass jeder Neubau sie lesen muss und dass ein falscher Eintrag nur durch einen neuen überholt werden kann.

## Context
Heute spielt `hooks/regeln-einspielen` beim Start `regeln.md` (10.816 Byte) und den Stand ein. Claude Code schneidet die Ausgabe eines Hooks ab etwa 10 KB ab; im Fall vom 28.10. kamen nur die ersten 2 KB in den Kontext. Auf welchem Weg Regeln und Überblick ganz in den Kontext kommen, entscheidet dieser Bau. Braucht der Weg eine Datei in der Akte, legen `anamnese` und `.claude/skills/run/neue-testakte` sie in einer neuen Akte an, und Ticket 05 legt dieselbe bei der Umstellung an. Dateien für Claude Code, etwa `.claude/`, sind im Hauptverzeichnis erlaubt (AC-20). Auch in einer Akte ohne diese Datei, etwa im bisherigen Aufbau, bringt der Start Regeln und Stand ganz in den Kontext; das baut dieses Ticket, und der Check hält die Grenze der Hook-Ausgabe fest.

`regeln.md` verlangt heute, vor jeder Beratung `AKTE.md` und `BEURTEILUNG.md` zu lesen. Einschätzungen, Warnzeichen, „Offen“, „Beobachten“ und „Abgelehnt“ schreibt es nach `BEURTEILUNG.md`. Diese Skills und Agenten lesen oder schreiben Abschnitte von `AKTE.md` oder `BEURTEILUNG.md`: `diagnose`, `naechste-schritte`, `vorsorge` mit `agents/vorsorge-recherche.md`, `termin-vorbereiten`, `notfallpass`, `neue-information` und `agents/leitlinien-recherche.md`, das Quellen unter „Quellen“ in `BEURTEILUNG.md` einträgt. Neue Einschätzungen des Modells kommen jetzt als Entwurf nach `unterlagen/beurteilung.md`, in der Form, die Ticket 02 festgelegt hat. Committet werden sie beim Einarbeiten, wie es Ticket 03 baut.

Die Meldungen des Stands stammen aus Ticket 01: fehlender Überblick, Kapitel oder Überblick über der Grenze, Enddatum der Fristen vorbei, Akte im bisherigen Aufbau. Die Regeln für eine Akte im bisherigen Aufbau sind Sache von Ticket 05.

Dass Medizinisches in die Akte gehört und nicht ins Gedächtnis, steht heute unter „Regeln“ in `regeln.md`.

Security policy sagt „None.“: Eine neue Berechtigung, etwa in den Einstellungen einer Akte, wäre eine Abweichung.

## Not here
- Die Regeln für eine Akte im bisherigen Aufbau, die Umstellung und die Testakte für AC-22: 05.
- Die Prüfung von AC-8 in der echten Akte des Benutzers: nach der Abnahme, siehe 05.
- Eine große erfundene Testakte mit festen Fragen, um Änderungen an der Beratung zu messen (Backlog: `testakte-evals`).
- Die Gegenprüfung von Antworten im Gespräch (Backlog: `antworten-im-gespraech-ungeprueft`).
- Ob eine Leitlinie noch gilt; das braucht eine Suche im Netz und bleibt bei `leitlinien-recherche`.
- Leitlinien, die noch nicht in `literatur/` liegen; sie sucht die Beratung wie heute vor einer Empfehlung.
- Wie viel Raum Warnzeichen einnehmen (Backlog: `warnzeichen-zu-viel-raum`).

## Left standing

- **Behoben nach der letzten Prüfung, von niemandem geprüft (AC-12, AC-26):** zwei Should-fix-Funde aus der zweiten Runde, beide in `regeln.md`.
  - Unter „Beginn einer Sitzung“ widersprachen sich zwei Punkte, wenn der Stand neue Unterlagen und zugleich vorbeigegangene Fristen, eine zu lange Datei oder einen Verweis ins Leere meldet. Jetzt gilt: Neue Unterlagen starten das Einarbeiten, außer der Überblick fehlt. Die übrigen Meldungen werden nur genannt, mit dem Vorschlag `/einarbeiten`, außer das Einarbeiten läuft ohnehin.
  - Ob ein Eintrag der Art Beobachten die Zustimmung des Benutzers braucht, stand an zwei Stellen verschieden. Jetzt gilt: Einschätzungen, Warnzeichen und Fristen kommen ohne Bestätigung an die Beurteilung. Beobachten schlägt die Beratung vor, weil der Benutzer messen muss, und hängt den Eintrag erst an, wenn er zustimmt; so steht es auch im Skill `diagnose`.
- **Wie Regeln, Stand und Überblick in den Kontext kommen (AC-1, AC-26):** Claude Code übernimmt die Ausgabe eines Hooks nur bis etwa 10.000 Zeichen ganz. Gemessen mit Claude Code 2.1.312: 9.890 Zeichen kamen ganz an, 10.672 wurden auf 2 KB gekürzt. Die Grenze gilt je Hook. Darum:
  - `hooks/hooks.json` ruft drei Hooks auf: `regeln-einspielen 1` und `regeln-einspielen 2` geben `regeln.md` in zwei Teilen aus, geteilt vor der Überschrift „# Regeln“, und `stand-einspielen` gibt den Stand aus. Die Reihenfolge der drei ist nicht fest; die Regeln sagen darum nicht mehr „am Ende dieser Regeln“.
  - Der Check hält fest: Jeder Teil hat höchstens 9.500 Zeichen, beide Teile zusammen sind `regeln.md`, der Stand bleibt mit 100 neuen Unterlagen unter der Grenze, und `hooks.json` ruft alle drei auf. Heute hat Teil 1 etwa 5.400 Zeichen und Teil 2 etwa 6.100; das ist Platz für die Regeln, die Ticket 05 für den bisherigen Aufbau braucht.
  - Den Überblick bringt `.claude/CLAUDE.md` in der Akte mit der Zeile `@../AKTE.md`. Claude Code lädt so auch einen Überblick von 20.000 Zeichen ganz. Die Vorlage ist `vorlagen/claude.md`; mit dem Namen `CLAUDE.md` würde Claude Code sie bei der Arbeit am Plugin selbst laden. Der Skill `anamnese` legt die Datei an und committet sie gleich, das ist ein Commit außerhalb von `einarbeiten`, aber ohne Gesundheitsdaten. Ticket 05 muss sie bei der Umstellung genauso anlegen.
  - Der Import gilt ab dem Start einer Sitzung und wird danach nicht neu geladen. Darum liest die Beratung `AKTE.md` nach einem Bau in derselben Sitzung einmal neu. In der zweiten Runde las ein Lauf ihn nicht neu; die Antwort stimmte trotzdem, weil die Rückmeldung des Baus den neuen Stand schon enthielt.
  - Ein sehr großer erster Import mit etwa 200 neuen Unterlagen würde den Stand über die Grenze bringen und kürzen. Das Einarbeiten ruft `akte-stand` dann ohnehin selbst auf.
- **Entscheidungen (AC-6, AC-12, AC-26):**
  - Von selbst startet der Start einer Sitzung das Einarbeiten nur bei neuen, geänderten oder entfernten Unterlagen, einem nicht abgeschlossenen Bau und Änderungen ohne Commit in `unterlagen/` oder `literatur/`. Alle übrigen Meldungen werden genannt, mit dem Vorschlag `/einarbeiten`; die Beschreibung des Skills `einarbeiten` verweist dafür auf `regeln.md`.
  - Die Beratung hängt jede Einschätzung für den Fall, jedes Warnzeichen und jede Frist noch in derselben Antwort an die Beurteilung an. In der ersten Runde hatte die Bedingung „wenn sie für künftige Gespräche zählen“ das Anhängen ganz ausfallen lassen.
  - `leitlinien-recherche` trägt Quellen nur noch in `literatur/README.md` ein; ob eine Prüfung veraltet ist, steht dort. `vorsorge-recherche` hängt den Plan als Einträge „Vorsorge, <Untersuchung> – Frist“ an die Beurteilung an. Was geprüft wurde und nicht zutrifft, hängt es als Einschätzung an.
  - Die Zusammenfassung von `einarbeiten` ist auf Deutsch und nennt keine Scripts oder Subagenten (aus dem Left standing von Ticket 03).
- **Nicht automatisch geprüft (AC-6, AC-7, AC-12, AC-18, AC-19, AC-26, AC-30; Toward AC-8):** Was die Beratung tut, steht in `regeln.md`, `skills/` und `agents/`; kein Test prüft diesen Text. Geprüft wurde in zwei Runden mit der Testakte nach `.claude/skills/run/SKILL.md`, in etwa 20 Sitzungen:
  - AC-1: Ohne Werkzeuge nannte eine Sitzung alle Probleme, die Allergie, die Medikation, das Warnzeichen mit Stufe, die Fristen und die Regeln.
  - AC-6: Bei einem neuen Thema las die Beratung genau die passenden Kapitel, bei einer Folgefrage nicht neu. Fehlte ein Kapitel, sagte sie das und schlug `/einarbeiten` vor, aber in drei Sätzen statt einem. Den Abstieg in Unterkapitel zeigte kein Lauf, weil die Testakte keine hat.
  - AC-7: Die Antwort begann mit dem, was aus der Akte zählt, ohne Namen von Dateien; einmal in vier Sätzen statt ein, zwei. Ohne Angaben in der Akte sagte sie das. Bei 192/116 mit Kopfschmerz kam der Notruf zuerst.
  - Toward AC-8: Die Testakte hat jetzt einen Schmerz in der linken Flanke beim Drehen (Historie vom 20.10.2025). Auf die Frage nach Übungen für die Rumpfmuskulatur ging die Antwort von ihm aus, ohne dass er genannt wurde.
  - AC-12: Entwürfe hatten die Form der Vorlage, ohne Commit und ohne Bestätigung, und `/einarbeiten` committete sie nach der Gegenprüfung.
  - AC-18: Gelaufen sind `naechste-schritte`, `notfallpass`, `termin-vorbereiten`, `diagnose`, `neue-information` und `einarbeiten`. Nicht gelaufen sind `anamnese` (eine ganze Erstbefragung) und `vorsorge` mit `vorsorge-recherche` und `leitlinien-recherche`, weil die Suche im Netz zu teuer ist; dort ist nur der Text geändert.
  - AC-26: Ohne Überblick sagte die erste Antwort das und schlug `/einarbeiten` vor, in zwei Sätzen am Ende, nach der Dringlichkeit.
  - AC-19 und AC-30 sind Wortlaut von `regeln.md`. In keinem Lauf entstand ein Gedächtnis, und nichts wurde außerhalb der Testakten geschrieben.
- **Gesehen in den Läufen, nicht von diesem Ticket:**
  - Das Einarbeiten committet die Beurteilung vor der Gegenprüfung des Baums. Einmal fand diese danach eine falsche Seitenzahl in einem neuen Eintrag, der schon committet war (Ticket 03).
  - Ein zweiter Eintrag am selben Tag kam unter die vorhandene Überschrift, mit eigener Zeile für den Anlass.
  - Eine Frist ohne Datum, ein Warnzeichen der Stufe 3 mit einem Fall „noch heute“, und ein Wechsel zwischen „du“ und „Sie“ (Backlog: `anrede-wechselt`).
- **Für Ticket 05:** `regeln.md` beschreibt nur den Baum. Eine Akte im bisherigen Aufbau bekommt bis 05 dieselben Regeln, nur mit der Meldung des Stands, dass sie abweicht.
- **Namen ohne Glossar:** `stand-einspielen` und `vorlagen/claude.md`.
- **Blast radius:** Der Start jeder Sitzung in jeder Akte läuft über die drei Hooks. Ein Revert stellt den einen Hook wieder her. Eine schon angelegte `.claude/CLAUDE.md` bleibt dann in der Akte; sie lädt weiter nur den Überblick.
