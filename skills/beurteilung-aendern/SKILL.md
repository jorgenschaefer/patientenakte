---
name: beurteilung-aendern
description: Trägt Empfehlungen, Einschätzungen, Warnzeichen, Vorsorge, Beobachtungsthemen und Quellen in BEURTEILUNG.md ein, passt betroffene Einträge an, ohne Commit; committet wird im Skill einarbeiten. Benutzen für jede Änderung an BEURTEILUNG.md, aus jedem Skill und aus der freien Beratung.
---

# BEURTEILUNG.md ändern

Eingetragen wird gleich, ohne Commit. Committet wird im Skill
`einarbeiten`.

Der Aufruf nennt, was hinein soll, oder die neuen Angaben, deren betroffene
Einträge nachzuziehen sind.

1. **Form** nach dem Kopf von `BEURTEILUNG.md` und dem Hinweis unter der
   Überschrift des Abschnitts: Datum vorn, Kennzeichnung, Quelle mit dem
   Kurznamen aus „Quellen“ und Empfehlungsnummer, Empfehlungsgrad,
   Evidenzniveau und Konsensstärke, wo angegeben.
2. **Ein Eintrag je Thema:** Steht es schon da, den Eintrag auf dem neuen
   Stand neu schreiben, nach „Knapp“ im Kopf der Vorlage
   `${CLAUDE_PLUGIN_ROOT}/vorlagen/BEURTEILUNG.md`, und neu datieren, statt
   einen zweiten anzulegen oder etwas anzuhängen. Steht es in einem
   anderen Abschnitt, dort lassen und darauf verweisen.
3. **Betroffene Einträge** in allen Abschnitten, auch unter „Einschätzungen“
   und „Beobachten“: Erledigte und überholte löschen. Abgelehnte, die sonst
   weiter gelten würden, mit Datum und Grund nach „Abgelehnt“. Die übrigen
   anpassen und neu datieren. Ein Thema unter „Beobachten“ kommt erst dazu,
   wenn der Benutzer zustimmt.
4. **Quellen:** Eine neue Quelle mit Kurzname, Registernummer, Version,
   Gültigkeit, Prüfdatum und lokaler Datei eintragen; was nur aus
   Sekundärquellen oder Auszügen stammt, als solches kennzeichnen. Nach einer
   erneuten Prüfung das Prüfdatum anpassen und einen Vermerk „nicht prüfbar“
   streichen. Ließ sich die Gültigkeit nicht prüfen, das Prüfdatum nicht
   anpassen (bei einer neuen Quelle keins eintragen) und „nicht prüfbar am
   TT.MM.JJJJ“ mit Grund vermerken; ein früherer Vermerk wird ersetzt.
