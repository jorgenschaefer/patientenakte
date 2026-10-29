---
name: run
description: Startet das Plugin patientenakte in einer Testakte mit einer erfundenen Patientin, um eine Änderung an Agenten, Skills, Hook oder bin/akte-stand im echten Claude Code zu sehen. Benutzen, wenn das Plugin laufen, eine Änderung im Ablauf gezeigt, ein Bau des Baums aus AKTE.md und kapitel/, die Teilung eines Kapitels oder die Umstellung einer Akte im bisherigen Aufbau ausprobiert werden soll.
---

# Das Plugin laufen lassen

Nie in einer echten Akte: Akten enthalten Gesundheitsdaten.

1. Testakte anlegen:
   - `.claude/skills/run/neue-testakte` gibt den Pfad einer neuen Akte in
     einem temporären Verzeichnis aus: Anamnese, zwei Befunde als Text,
     `historie.md` mit vier Tagen, die Beurteilung
     `unterlagen/beurteilung.md` mit einem Tag und eine erfundene
     Leitlinie in `literatur/`, alles committet; der Baum aus `AKTE.md`
     und `kapitel/` fehlt. Die Beurteilung zitiert die Leitlinie mit
     falschen Graden, und zwei ihrer Einträge sind durch `historie.md`
     überholt. Ein Neubau sollte beides berichtigen. Dazu
     `.claude/CLAUDE.md`, die den Überblick in jede Sitzung bringt. Das
     Plugin ist dieses Repo.
   - Mit `--kopie` gibt es danach eine zweite Zeile aus: eine Kopie des
     Plugins, in der man etwa die Höchstlängen oben in `bin/akte-stand`
     ändern kann. Mit `--klein` hat die Kopie 2 Seiten je Stapel und 500
     Zeichen je Seite, und die Testakte wird in fünf Stapeln gebaut.
     Änderungen am Repo danach erreichen die Kopie nicht.
   - Mit `--bisherig` hat die Akte den bisherigen Aufbau: die alte
     `AKTE.md` mit den Prüfsummen am Ende und `BEURTEILUNG.md`, beide
     committet, ohne `.claude/CLAUDE.md` und ohne Baum. Dazu eine
     Messreihe `unterlagen/blutdruck.csv` und als Entwurf ohne Commit
     `unterlagen/beurteilung.md` mit einem Eintrag aus einem Gespräch.
     `BEURTEILUNG.md` zitiert die Testleitlinie im Wortlaut mit falschen
     Graden und eine Empfehlung der STIKO, die nicht in `literatur/`
     liegt, hat Herleitungen und den Abschnitt „Quellen“, und sie nennt
     Ibuprofen, die Ablehnung eines Statins und eine Erledigung, die in
     keiner Unterlage stehen.
2. In der Akte Claude Code mit dem Plugin starten, nicht interaktiv etwa:

   ```bash
   cd <akte> && claude -p --plugin-dir <plugin> \
     --permission-mode auto "/einarbeiten"
   ```

   Der Auto-Modus lehnt `git checkout HEAD -- AKTE.md kapitel` ab, mit dem ein
   liegen gebliebener Bau zurückgesetzt wird, auch mit `--allowedTools`.
   Diesen Fall in einer interaktiven Sitzung prüfen und das Zurücksetzen
   dort freigeben.

   Die Hooks `regeln-einspielen` und `stand-einspielen` spielen Regeln und
   Stand ein. Der erste Aufruf baut den Baum neu, weil `AKTE.md` fehlt; ein
   zweiter mit
   „/einarbeiten und bau die Akte neu“ baut ihn noch einmal und gleicht mit
   der vorigen Fassung ab, „/einarbeiten und kontrollier die Akte“ macht
   die Kontrolle.
3. Für ein schrittweises Einarbeiten nach dem ersten Bau
   `.claude/skills/run/nachtrag <akte>`: Es committet einen Befund zum
   Blutdruck, der Empfehlung 3.3 der Leitlinie berührt, und hängt einen
   Eintrag an die Beurteilung an, ohne Commit. Ein `/einarbeiten` danach
   sollte die Beurteilung nach einer Gegenprüfung committen, die
   Empfehlung 3.3 mit Stelle ins Kapitel zur Hypertonie aufnehmen, daraus
   eine neue Einschätzung an die Beurteilung hängen und beides in der
   Zusammenfassung nennen. Weitere Fälle:
   - Fristen vorbei, nach dem Nachtrag: in `AKTE.md` das Datum unter
     `## Fristen bis` auf einen vergangenen Tag setzen und committen;
     `/einarbeiten` schreibt dann den Überblick neu, ohne neue Unterlagen.
     Die Wiedervorstellung aus dem Befund des Nachtrags ist überfällig und
     sollte unter den Fristen stehen, auch wenn der Bau ihr Kapitel nicht
     berührt.
   - Beraten auf dem Baum, nach dem ersten Bau: `claude -p` mit „Welche
     Übungen für die Rumpfmuskulatur kann ich ins Training einbauen?“. Die
     Antwort sollte vom Schmerz in der linken Flanke beim Drehen ausgehen,
     den keine Suche nach den Wörtern der Frage findet, und vorher in ein,
     zwei Sätzen sagen, was aus der Akte sie trägt, ohne Namen von Dateien.
4. Umstellung, mit einer Akte aus `neue-testakte --bisherig`:
   - Beraten bis zur Umstellung: `claude -p` mit einer Frage, etwa „Darf
     ich gegen die Knieschmerzen Ibuprofen nehmen?“. Die Antwort sollte
     aus der alten `AKTE.md` und `BEURTEILUNG.md` kommen, nichts
     einarbeiten, `/einarbeiten` für die Umstellung vorschlagen und eine
     neue Einschätzung an `unterlagen/beurteilung.md` hängen.
   - `claude -p ... "/einarbeiten"` legt die Entwürfe an und fragt nach
     ihrem Wortlaut; die Sitzung endet dort, und die Umstellung ist
     abgebrochen. `historie.md` sollte drei Entwürfe haben: Ibuprofen, das
     Statin und die Erledigung, nicht die Grippeimpfung, die dort schon
     steht. `unterlagen/beurteilung.md` sollte den ersten Eintrag mit dem
     Anlass „Umstellung von BEURTEILUNG.md.“ vor dem Eintrag aus dem
     Gespräch haben. Der Start der nächsten Sitzung meldet die nicht
     abgeschlossene Umstellung, und ein zweites `/einarbeiten` legt
     nichts davon noch einmal an.
   - Mit `claude -p --continue ... "Der Wortlaut passt."` geht die
     Umstellung weiter. Danach gibt es im Hauptverzeichnis `AKTE.md`,
     `kapitel/`, `unterlagen/`, `literatur/` und `.claude/CLAUDE.md`,
     `BEURTEILUNG.md` nur noch in `git log`, und `akte-stand` meldet nur
     den Stand. Eine Frage zur Physiotherapie sollte danach vom Schmerz in
     der linken Flanke ausgehen.
   - Teilung eines Kapitels beim Einarbeiten: die Akte mit `--kopie`
     anlegen und mit der Kopie umstellen. Danach `woerter_kapitel` oben in
     `bin/akte-stand` der Kopie auf etwa drei Viertel der Wörter des
     Kapitels zur Hypertonie senken (`wc -w kapitel/*.md`), etwa 300 bei
     420; knapp darunter kürzt der Bau das Kapitel, statt es zu teilen.
     Dann `nachtrag` und `/einarbeiten`: Das Kapitel sollte in
     Unterkapitel geteilt werden, und `akte-stand` danach keinen Verweis
     ins Leere melden.
5. Was geschah, zeigen `git log --stat`, `AKTE.md`, `kapitel/`, das Ende
   von `unterlagen/beurteilung.md` und, solange ein Bau läuft oder wenn er
   abbricht, `.git/akte-bau/`.

Danach die Verzeichnisse aus Schritt 1 löschen und das Transkript
`~/.claude/projects/-tmp-testakte-*`.

Ein Neubau sucht keine Literatur im Netz; er liest nur, was in
`literatur/` liegt.
