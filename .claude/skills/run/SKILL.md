---
name: run
description: Startet das Plugin patientenakte in einer Testakte mit einer erfundenen Patientin, um eine Änderung an Agenten, Skills, Hook oder bin/akte-stand im echten Claude Code zu sehen. Benutzen, wenn das Plugin laufen, eine Änderung im Ablauf gezeigt oder ein Bau des Baums aus AKTE.md und kapitel/ ausprobiert werden soll.
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
   - Mit `--klein` gibt es danach eine zweite Zeile aus: eine Kopie des
     Plugins mit 2 Seiten je Stapel und 500 Zeichen je Seite, in der die
     Testakte in fünf Stapeln gebaut wird. Änderungen am Repo danach
     erreichen die Kopie nicht.
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
   - Teilung eines Kapitels: mit `--klein` in der Kopie des Plugins
     `woerter_kapitel` in `bin/akte-stand` auf etwa 250 senken.
4. Was geschah, zeigen `git log --stat`, `AKTE.md`, `kapitel/`, das Ende
   von `unterlagen/beurteilung.md` und, solange ein Bau läuft oder wenn er
   abbricht, `.git/akte-bau/`.

Danach die Verzeichnisse aus Schritt 1 löschen und das Transkript
`~/.claude/projects/-tmp-testakte-*`.

Ein Neubau sucht keine Literatur im Netz; er liest nur, was in
`literatur/` liegt.
