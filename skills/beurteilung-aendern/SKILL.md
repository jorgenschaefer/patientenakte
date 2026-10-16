---
name: beurteilung-aendern
description: Trägt Empfehlungen, Einschätzungen, Warnzeichen, Vorsorge, Beobachtungsthemen und Quellen in BEURTEILUNG.md ein, passt betroffene Einträge an und committet die Änderung mit der Literatur nach der Gegenprüfung. Benutzen für jede Änderung an BEURTEILUNG.md, aus jedem Skill und aus der freien Beratung.
---

# BEURTEILUNG.md ändern

Eingetragen wird gleich (Teil „Eintragen“). Committet wird einmal, wenn das
Anliegen erledigt ist (Teil „Abschließen“).

## Eintragen

Der Aufruf nennt, was hinein soll, oder die neuen Angaben, deren betroffene
Einträge nachzuziehen sind.

1. **Form** nach dem Kopf von `BEURTEILUNG.md` und dem Hinweis unter der
   Überschrift des Abschnitts: Datum vorn, Kennzeichnung, Quelle mit dem
   Kurznamen aus „Quellen“ und Empfehlungsnummer, Empfehlungsgrad,
   Evidenzniveau und Konsensstärke, wo angegeben.
2. **Ein Eintrag je Thema:** Steht es schon da, den Eintrag anpassen und neu
   datieren statt einen zweiten anzulegen. Steht es in einem anderen
   Abschnitt, dort lassen und darauf verweisen.
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

## Abschließen

Am Ende der Antwort, in der `BEURTEILUNG.md` oder `literatur/` geändert
wurde. Sammelt der Skill `neue-information` noch Angaben, erst in dessen
Schritt 7.

1. Committet werden `BEURTEILUNG.md`, `literatur/` und die Unterlagen, die
   der Aufruf nennt. Ist keine davon geändert (`git status --short`), endet
   der Skill.
2. Ist `BEURTEILUNG.md` geändert, die Änderung gegenprüfen lassen, wie unter
   „Gegenprüfung“ in `regeln.md` beschrieben. Ausgenommen sind der Commit,
   der sie aus der Vorlage anlegt, und die Berichtigung eines Funds der
   Gegenprüfung.
3. Diese Dateien in einem Commit committen.

## Berichtigung nach der Gegenprüfung von AKTE.md

Meldet die Gegenprüfung einer Änderung an `AKTE.md` bestätigte Funde in
`BEURTEILUNG.md`, berichtigst du sie gleich. In einen Commit kommt die
Berichtigung erst, wenn der Benutzer die Funde gesehen hat: Hatte
`BEURTEILUNG.md` vorher keine Änderungen ohne Commit, committest du sie dann,
ohne weitere Gegenprüfung; sonst kommt sie mit diesen Änderungen in deren
Commit, später und mit deren Gegenprüfung.
