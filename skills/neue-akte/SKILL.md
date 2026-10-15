---
name: neue-akte
description: Legt eine neue, leere Patientenakte als eigenes Git-Repo an. Benutzen, wenn der Benutzer eine Akte für sich oder eine weitere Person anlegen will.
---

# Neue Akte

1. Erfragen: für wen die Akte ist und wo sie liegen soll. Vorschlag:
   `~/Projects/patientenakte-<vorname>`. Existiert das Verzeichnis schon,
   abbrechen.
2. Anlegen und `git init`:
   - `BEURTEILUNG.md` aus `${CLAUDE_PLUGIN_ROOT}/vorlagen/BEURTEILUNG.md`;
   - `literatur/README.md` aus
     `${CLAUDE_PLUGIN_ROOT}/vorlagen/literatur-README.md`;
   - ein leeres Verzeichnis `unterlagen/`.

   `AKTE.md` entsteht erst mit der Anamnese. Committen.
3. Fragen, ob ein privates Remote angelegt werden soll, etwa mit
   `gh repo create <name> --private --source <verzeichnis>`. Nie öffentlich.
4. Sagen, wie es weitergeht: im neuen Verzeichnis eine Sitzung mit dem Plugin
   starten (`claude --plugin-dir <plugin-verzeichnis>`); dort beginnt die
   Arbeit mit dem Skill `anamnese`.
