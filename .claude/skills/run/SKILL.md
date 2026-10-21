---
name: run
description: Startet das Plugin patientenakte in einer Testakte mit einer erfundenen Patientin, um eine Änderung an Agenten, Skills, Hook oder bin/akte-stand im echten Claude Code zu sehen. Benutzen, wenn das Plugin laufen, eine Änderung im Ablauf gezeigt oder ein Bau von AKTE.md ausprobiert werden soll.
---

# Das Plugin laufen lassen

Nie in einer echten Akte: Akten enthalten Gesundheitsdaten.

1. Testakte anlegen:
   - `.claude/skills/run/neue-testakte` gibt den Pfad einer neuen Akte in
     einem temporären Verzeichnis aus: Anamnese, zwei Befunde als Text,
     `historie.md` mit drei Tagen, `BEURTEILUNG.md` aus der Vorlage, alles
     committet, `AKTE.md` fehlt. Das Plugin ist dieses Repo.
   - Mit `--klein` gibt es danach eine zweite Zeile aus: eine Kopie des
     Plugins mit 2 Seiten je Stapel und 500 Zeichen je Seite, in der die
     Testakte in drei Stapeln gebaut wird. Änderungen am Repo danach
     erreichen die Kopie nicht.
2. In der Akte Claude Code mit dem Plugin starten, nicht interaktiv etwa:

   ```bash
   cd <akte> && claude -p --plugin-dir <plugin> \
     --permission-mode bypassPermissions "/einarbeiten"
   ```

   Der Hook `regeln-einspielen` spielt den Stand ein. Der erste Aufruf baut
   `AKTE.md` vollständig, weil sie fehlt; ein zweiter mit
   „/einarbeiten und bau die Akte neu“ baut sie noch einmal und gleicht mit
   der vorigen Fassung ab, „/einarbeiten und kontrollier die Akte“ macht
   die Kontrolle.
3. Was geschah, zeigen `git log --stat`, `AKTE.md` und, solange ein Bau
   läuft oder wenn er abbricht, `.git/akte-bau/`.

Danach die Verzeichnisse aus Schritt 1 löschen und das Transkript
`~/.claude/projects/-tmp-testakte-*`.

`literatur/` braucht Internet: `einarbeiten` lässt beim Nachziehen von
`BEURTEILUNG.md` Leitlinien suchen.
