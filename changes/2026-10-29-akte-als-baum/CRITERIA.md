# Criteria: Die Akte als Baum aus Überblick und Kapiteln

## Problem

Die Akte ist zu groß, als dass die Beratung sie bei jeder Frage ganz lesen
könnte. Heute sollen `AKTE.md` und `BEURTEILUNG.md` das als Zusammenfassung
auffangen. Sie sind aber selbst zu groß geworden. `BEURTEILUNG.md` wuchs von
3.700 Wörtern am 12.10.2026 auf 15.300 am 19.10. Nach dem Kürzen am 21.10.
hatte sie 10.200, am selben Tag wieder 17.900 und am 29.10. 21.300. Beide
Dateien sind größer als ein einzelner Lesevorgang. Das Lesewerkzeug hat sie
am 16., 19. und 21.10. abgelehnt („File content (32151 tokens) exceeds
maximum allowed tokens (25000)“). Die Beratung sucht deshalb mit
Stichwörtern und übersieht, was sie nicht zufällig trifft. Ebenso können
Allergien, Warnzeichen oder Abgelehntes übersehen werden.

Stattdessen soll die Beratung zu jeder Frage wissen, was die Akte dazu
enthält: aus den Unterlagen und aus dem, was in früheren Beratungen
eingeschätzt, empfohlen, vereinbart oder abgelehnt wurde. Nicht jedes Detail
muss im Kontext sein. Sie muss aber wissen, dass es etwas gibt und wo es
steht, damit sie es nachliest, statt den Benutzer zu fragen. Das soll so
bleiben, auch wenn die Akte über Monate und Jahre wächst.

Der Fall: In der Beratung am 28.10.2026 nannte der Benutzer ein Rezept für
Physiotherapie. Die Beratung las `AKTE.md` und `BEURTEILUNG.md` nicht, sondern
suchte mit `grep` nach „physio|Rücken|Bandscheib|M51“ und ähnlichen Wörtern,
nie nach „Flanke“ oder „Seite“. Sie ordnete die Physio deshalb einem
Bandscheibenvorfall zu. Der Benutzer musste die Geschichte seiner Schmerzen in
der linken Flanke neu erzählen: Krankenhaus, Klopfschmerz, MRT mit einem
Vorfall rechts, also ohne Zusammenhang. „Flanke“ stand achtmal in `AKTE.md`
und fünfmal in `BEURTEILUNG.md`.

Dazu kam beim Start derselben Sitzung: Die Ausgabe des Hooks war mit 10,5 KB
zu groß. Claude Code gab nur die ersten 2 KB in den Kontext und legte den Rest
in einer Datei ab, die das Modell selbst nachlesen musste. `regeln.md` allein
hat 10.816 Byte.

## Acceptance criteria

### Behaviour

- **AC-1** Beim Start jeder Sitzung hat die Beratung die Regeln und den Überblick ganz im Kontext, ohne eine Datei nachzulesen.
- **AC-2** Der Überblick (`AKTE.md`) enthält: unter „Probleme, Vorerkrankungen und Operationen“ je eine Zeile mit Stand, Datum, Status (aktiv, ruhend oder abgeschlossen) und Verweis auf das Kapitel; ganz: Allergien und Unverträglichkeiten, die aktuelle Medikation mit Dosis, was die Wahl oder Dosis eines Mittels ändert, etwa eine Organfunktion, das Alter oder eine Schwangerschaft, und die Warnzeichen mit Stufe; die Fristen der nächsten vier Wochen; die übergreifenden Kapitel, je eine Zeile.
- **AC-3** Abgelehntes steht im Kapitel seines Themas, nicht im Überblick. Eine Ablehnung, die zu keinem Problem gehört, etwa einer Impfung, steht im passenden übergreifenden Kapitel.
- **AC-4** Der Überblick hat eine Höchstlänge, zu Beginn 2.000 Wörter.
- **AC-5** Jedes Kapitel hat eine Höchstlänge, zu Beginn 1.500 Wörter.
- **AC-6** Vor einer beratenden Antwort liest die Beratung jedes Kapitel ganz, dessen Zeile im Überblick die Frage berührt. In einem Kapitel mit Unterkapiteln gilt dasselbe für die Zeilen dort, und so weiter nach unten, bis die Frage beantwortet ist. Bei einer Folgefrage zum selben Thema liest sie nicht neu. Fehlt ein Kapitel, auf das ein Verweis zeigt, oder lässt es sich nicht lesen, sagt die Antwort das in einem Satz, beruht auf dem Übrigen und schlägt `/einarbeiten` vor.
- **AC-7** Bei einem neuen Thema nennt die Beratung vor der Antwort in ein, zwei Sätzen, was aus der Akte die Antwort trägt, inhaltlich und ohne Namen von Dateien oder Kapiteln. Steht nichts dazu in der Akte, sagt sie das. Bei Warnzeichen der Stufe 1 oder 2 kommt die Dringlichkeit zuerst.
- **AC-8** In der umgestellten Akte des Benutzers geht die Antwort auf eine Frage zur Physio von den Schmerzen in der linken Flanke aus, ohne dass der Benutzer sie erzählt. Ebenso bei zwei, drei weiteren Fragen, die der Benutzer stellt und deren Antwort er kennt.
- **AC-9** Jedes Einarbeiten hält die Höchstlängen ein. Dafür fasst es Älteres zusammen, mit einem Verweis auf die Stelle mit den Einzelheiten, oder teilt ein Kapitel in Unterkapitel; ein Kapitel mit Unterkapiteln ist selbst ein kurzer Überblick mit Verweisen. Die Zusammenfassung am Ende des Einarbeitens nennt jede Teilung. Danach ist jede Angabe, die durch keine Unterlage überholt ist, vom Überblick aus über Verweise erreichbar.
- **AC-10** Den Überblick kürzt das Einarbeiten nur an den Teilen, die sich auslagern lassen: die Zeilen unter „Probleme, Vorerkrankungen und Operationen“, etwa indem Abgeschlossenes zu einer Zeile mit Verweis zusammengefasst wird. Reicht das nicht, bleibt der Überblick vollständig und dafür über seiner Grenze.
- **AC-11** Nach jedem Einarbeiten zeigt kein Verweis ins Leere. Was sich nicht beheben ließ, nennt die Zusammenfassung am Ende des Einarbeitens.
- **AC-12** Einschätzungen, Warnzeichen mit Stufe, Fristen und das, was beobachtet wird, erarbeitet das Modell und hängt sie an die Beurteilung in `unterlagen/` an. Jeder Eintrag ist datiert, als Einschätzung eines Modells gekennzeichnet und wird nie umgeschrieben. Im Gespräch entstehen sie als Entwurf, ohne Commit und ohne Bestätigung durch den Benutzer. Das Einarbeiten committet sie nach einer Gegenprüfung.
- **AC-13** Ein Neubau übernimmt je Thema die letzte Einschätzung aus der Beurteilung und prüft sie gegen die Unterlagen. Jede Aussage einer Leitlinie in einem Kapitel liest er an der genannten Stelle der Quelle in `literatur/` neu ab, mit Empfehlungsnummer, Empfehlungsgrad und Evidenzniveau; stimmt sie nicht, berichtigt er sie, und die Zusammenfassung nennt das. Ändert sich eine Einschätzung, kommt die neue Einschätzung mit Grund als neuer Eintrag in die Beurteilung.
- **AC-14** In jedem Kapitel sind Fakten, Aussagen der Literatur und Einschätzungen des Modells sichtbar getrennt. Jede Angabe nennt ihre Quelle: eine Unterlage, eine Stelle in `literatur/` oder einen Eintrag der Beurteilung mit Datum.
- **AC-15** Eine bestehende Akte mit `AKTE.md` und `BEURTEILUNG.md` im bisherigen Aufbau meldet beim Start, dass sie vom neuen Aufbau abweicht. `/einarbeiten` stellt sie dann so um: `BEURTEILUNG.md` wird auf die eigenen Einschätzungen des Modells gekürzt und der erste datierte Eintrag der Beurteilung. Er enthält die Einschätzungen, die Warnzeichen mit Stufe, die Fristen aus „Offen“, die Themen unter „Beobachten“, den Vorsorgeplan samt dem, was geprüft wurde und nicht zutrifft, und Aussagen einer Leitlinie, deren Quelle nicht in `literatur/` vorliegt, mit dieser Quelle. Aussagen einer Leitlinie, deren Quelle in `literatur/` vorliegt, verlieren ihren Wortlaut, behalten aber den Verweis auf Quelle und Stelle. Es fallen weg: der Abschnitt „Quellen“ und die Herleitungen. Angaben des Patienten, Abgelehntes und Organisatorisches, die noch nicht in den Unterlagen stehen, kommen als Entwurf nach `unterlagen/historie.md`, und der Benutzer bestätigt ihren Wortlaut. Danach wird der Baum gebaut und gegengeprüft, und die alte `AKTE.md` und `BEURTEILUNG.md` werden entfernt.
- **AC-16** Bricht die Umstellung ab, bleiben die alte `AKTE.md` und `BEURTEILUNG.md` unverändert, die Beratung arbeitet weiter auf ihrer Grundlage, und der Start der nächsten Sitzung meldet den Abbruch. Bestätigte Einträge in `historie.md` bleiben. Ein neuer Versuch legt den ersten Eintrag der Beurteilung und die Entwürfe in `historie.md` nicht ein zweites Mal an. Ein nicht abgeschlossener Bau im bisherigen Aufbau wird bei der Umstellung verworfen.
- **AC-17** Neubau, Kontrolle und Prüfung der Akte gibt es für den ganzen Baum, wie heute für `AKTE.md`: in Stapeln, ersetzt wird erst nach dem Abgleich mit der vorigen Fassung, und ein Abbruch lässt den Stand, wie er war.
- **AC-18** Die Skills `anamnese`, `neue-information`, `einarbeiten`, `diagnose`, `naechste-schritte`, `vorsorge`, `termin-vorbereiten` und `notfallpass` geben aus, was sie heute ausgeben, auf Grundlage des Baums. Am Ende der Erstbefragung baut `anamnese` den Baum statt `AKTE.md` im bisherigen Aufbau und legt keine `BEURTEILUNG.md` an.
- **AC-19** Die Liste unter „Evidenz“ in `regeln.md` nennt statt der Nierenfunktion allgemein, was die Wahl oder Dosis eines Mittels ändert, etwa die Funktion von Niere oder Leber.
- **AC-20** Im Hauptverzeichnis einer Akte stehen an Inhalten der Akte nur `AKTE.md` und die Themenlisten `termin-*.md`, neben `unterlagen/` und `literatur/`; Dateien für Git und Claude Code, etwa `.gitignore` oder `.claude/`, zählen nicht dazu. Alle Kapitel liegen in einem Unterverzeichnis und sind committet.
- **AC-21** Das Plugin-Repo hat ein Glossar mit den Begriffen, die bleiben, und den neuen aus „Concepts“.
- **AC-22** Eine kleine erfundene Testakte im Plugin-Repo zeigt mit dem Skill `run`: Ein Kapitel über seiner Grenze wird beim Einarbeiten geteilt, eine Akte im bisherigen Aufbau wird umgestellt, und danach zeigt kein Verweis ins Leere.
- **AC-31** Eine Akte im bisherigen Aufbau berät bis zur Umstellung wie heute auf Grundlage der alten `AKTE.md` und `BEURTEILUNG.md` und nimmt neue Angaben als Entwurf auf. Beim Start einer Sitzung läuft das Einarbeiten in ihr nicht von selbst, sondern wird vorgeschlagen; jedes `/einarbeiten` stellt sie zuerst um.
- **AC-32** Berührt eine neue Unterlage beim Einarbeiten ein Kapitel, liest das Einarbeiten in den Leitlinien in `literatur/`, auf die das Kapitel verweist, die Stellen zu der neuen Angabe. Was dort steht und noch nicht im Kapitel, kommt als Aussage der Literatur mit Stelle hinein; folgt daraus etwas für den Fall, kommt eine neue Einschätzung in die Beurteilung. Die Zusammenfassung am Ende des Einarbeitens nennt beides.
- **AC-33** Der Überblick nennt das Datum, bis zu dem seine Fristen reichen. Ist es beim Start einer Sitzung vorbei, meldet der Start das, und `/einarbeiten` schreibt den Überblick neu, auch ohne neue Unterlagen.

### What production must show

- **AC-23** Ein nicht abgeschlossener Bau wird beim Start einer Sitzung gemeldet, wie heute.
- **AC-24** Ein Kapitel, das nach dem Einarbeiten über seiner Grenze ist, nennt die Zusammenfassung am Ende des Einarbeitens, und der Start jeder Sitzung meldet es wieder, bis es behoben ist.
- **AC-25** Einen Überblick über seiner Grenze meldet der Start jeder Sitzung.
- **AC-26** Fehlt der Überblick, meldet der Start der Sitzung das; die erste Antwort sagt es in einem Satz und schlägt `/einarbeiten` vor.

### Security policy

None.

### Information model

- **AC-27** Die Beurteilung bleibt für immer in `unterlagen/`, wird nur angehängt und committet.
- **AC-28** Überblick und Kapitel sind ein Cache: Sie werden beim Einarbeiten überschrieben, ältere Fassungen gibt es nur in der Git-Geschichte der Akte, und sie lassen sich aus `unterlagen/` und `literatur/` neu bauen.
- **AC-29** Nach der Umstellung gibt es die alte `AKTE.md` und `BEURTEILUNG.md` nur noch in der Git-Geschichte der Akte. Zwischenstände eines Baus werden gelöscht, wenn er abgeschlossen ist.
- **AC-30** Gesundheitsdaten kommen nie ins Gedächtnis von Claude und nie ins Plugin-Repo.

## Agreed design

Die Akte wird ein Baum aus Zusammenfassungen über `unterlagen/` und
`literatur/`. Oben steht der Überblick `AKTE.md`, den die Beratung bei jeder
Frage ganz sieht. Er verweist auf Kapitel, je eines zu einem Problem im Sinn
der problemorientierten Krankenakte, dazu feste übergreifende Kapitel wie
Medikation, Allergien, Impfungen, Vorsorge, Stammdaten und Lebensumstände.
Ein Kapitel, das seine Höchstlänge erreicht, fasst Älteres mit Verweis
zusammen oder teilt sich in Unterkapitel; so wird der Baum mit den Jahren
tiefer, aber kein Kapitel größer als seine Grenze. Die Einschätzungen des
Modells sind eine eigene Unterlage, die nur angehängt wird, damit sie von
Beratung zu Beratung gleich bleiben, bis es einen Grund gibt, sie zu ändern.
Beide Höchstlängen stehen an einer Stelle im Plugin und werden nach der
Umstellung der echten Akte überprüft. Auf welchem Weg Regeln und Überblick ganz in den Kontext
kommen (AC-1), entscheidet der Bau; die Ausgabe eines Hooks allein reicht
nicht, weil Claude Code sie ab etwa 10 KB abschneidet.

## Technical decisions

- **Concepts** Der **Überblick** (`AKTE.md`) verweist auf **Kapitel**. Ein Kapitel gehört entweder zu einem **Problem**, also allem, was behandelt oder abgeklärt wird, auch ohne Diagnose, oder zu einem übergreifenden Thema. Ein Kapitel kann **Unterkapitel** haben. Ein Problem ist **aktiv**, **ruhend** oder **abgeschlossen**; „Beobachten“ bleibt das Wort für Themen, die mit einer Messreihe verfolgt werden. Überblick und Kapitel haben je eine **Höchstlänge**. Die **Beurteilung** ist eine Unterlage in `unterlagen/`, die nur angehängt wird. Überblick und Kapitel fassen Unterlagen, Literatur und Beurteilung zusammen. `BEURTEILUNG.md` entfällt.
- **Wire formats** Von außen hängt nur der Aufbau bestehender Akten ab. Eine Akte im bisherigen Aufbau erhält beim Start die Meldung, dass sie abweicht, und wird mit `/einarbeiten` umgestellt (AC-15). Braucht der Weg für AC-1 eine Datei in der Akte, etwa für Claude Code, legt die Umstellung sie an. Sonst keine.
- **Hard to reverse** Die Umstellung entfernt `AKTE.md` im bisherigen Aufbau und `BEURTEILUNG.md` und verwirft dabei die Herleitungen, den Abschnitt „Quellen“ und den Wortlaut von Leitlinien, die in `literatur/` vorliegen. Das gibt eine Akte, die die Beratung zu jeder Frage kennen kann. Es kostet, dass die Herleitungen nur noch in der Git-Geschichte stehen. Außerdem wird die Beurteilung nur angehängt und nie umgeschrieben (AC-12, AC-27). Das gibt Einschätzungen, die von Beratung zu Beratung gleich bleiben. Es kostet, dass sie mit der Akte wächst, dass jeder Neubau sie lesen muss und dass ein falscher Eintrag nur durch einen neuen überholt werden kann.

## Out of scope

- Eine große erfundene Testakte mit festen Fragen, um Änderungen an der Beratung zu messen (Backlog: `testakte-evals`).
- Die Gegenprüfung von Antworten im Gespräch (Backlog: `antworten-im-gespraech-ungeprueft`).
- Ob eine Leitlinie noch gilt; das braucht eine Suche im Netz und bleibt bei `leitlinien-recherche`.
- Leitlinien, die noch nicht in `literatur/` liegen; sie sucht die Beratung wie heute vor einer Empfehlung.
- Wie viel Raum Warnzeichen einnehmen (Backlog: `warnzeichen-zu-viel-raum`).

## Ruled out

- **Literatur nur auf eine Frage hin lesen** - was eine Leitlinie zu einem neuen Befund sagt, bliebe unbemerkt, bis jemand fragt.
- **Bei jedem Neubau die ganzen zitierten Leitlinien lesen** - leicht tausende Seiten; die zitierten Stellen und die Stellen zu neuen Angaben reichen.
- **Eine Höchstlänge allein für `BEURTEILUNG.md`** - sie hält die Datei lesbar, schiebt Einzelheiten aber dorthin, wo die Beratung sie nicht findet.
- **Ein Subagent, der vor jeder Antwort die ganze Akte liest** - kostet bei jeder Frage Zeit und Tokens, mit der Akte wachsend.
- **Kapitel nach Fachgebiet** - viele Probleme liegen zwischen Fachgebieten, etwa die Flanke zwischen Orthopädie, Urologie und Physiotherapie.
- **Kapitel, die das Modell frei schneidet** - jeder Neubau schnitte anders, und Fassungen ließen sich schwer vergleichen.
- **Namen von Dokumenten in der Antwort** - hilft nur, wenn der Benutzer den Aufbau kennt, und das soll er nicht müssen.
- **Ein Baum, der nicht committet wird** - kein Vergleich mit der vorigen Fassung, und nach einem Klonen ein langer Neubau.
- **Eine Umstellung ohne die alte Beurteilung** - Fristen, Warnzeichen und Einschätzungen, die nur dort stehen, gingen verloren.
- **Ein Modell ohne Notizen zwischen den Beratungen** - Einschätzungen entstünden jedes Mal neu und fielen verschieden aus, wie die Fieberschwelle in `warnzeichen-pro-antwort-neu`.
- **Abgelehntes im Überblick** - kann sehr lang werden; im Kapitel seines Themas sieht die Beratung es, bevor sie dazu empfiehlt.
- **Das Glossar vor der Änderung anlegen** - es beschriebe einen Stand, den die Änderung falsch macht.
