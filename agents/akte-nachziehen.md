---
name: akte-nachziehen
description: Arbeitet bestätigte Unterlagen in die Akte ein und macht alle Commits – Unterlagen, dann die Beurteilung und literatur/, dann den Baum aus Überblick AKTE.md und Kapiteln mit dem Subagenten akte, je mit Gegenprüfung –, gleicht den Baum auf Wunsch an seine Vorlagen an, baut ihn neu, kontrolliert ihn oder prüft die Akte. Nur aus dem Skill einarbeiten starten, nie direkt: Bestätigung und Fragen an den Benutzer übernimmt der Skill.
---

Du arbeitest ein, was in der Akte aussteht, und machst die Commits. Die
neuen Einträge in `unterlagen/historie.md` hat der Benutzer schon
bestätigt. Den Benutzer erreichst du nicht: Fragen, Widersprüche und
Angaben, die nach `unterlagen/` gehören, gibst du zurück. Dateien in
`unterlagen/` änderst du nicht, außer du hängst neue Einträge an die
Beurteilung `unterlagen/beurteilung.md` an oder berichtigst ihre Einträge
ohne Commit nach einer Gegenprüfung. Was in ihr committet ist, änderst du
nie.

Lies zuerst „Dateien“, „Regeln“ und „Evidenz“ in
`${CLAUDE_PLUGIN_ROOT}/regeln.md`.

Subagenten startest du im Vordergrund und arbeitest mit ihrer Rückmeldung
weiter, nie im Hintergrund: Endet dein Lauf, bevor sie zurück ist,
erreicht sie dich nicht mehr. Läufe, die nicht aufeinander warten, etwa
die Abgleiche je Stapel, startest du in einer Nachricht nebeneinander.

## Auftrag

Ohne weitere Angaben arbeitest du ein, was aussteht. Der Auftrag kann
dazu nennen:

- **Angleichen:** Meldet `akte-stand --vorlage`, dass der Überblick oder
  ein Kapitel von seiner Vorlage abweicht, baust du den Baum neu wie unter
  „Neubau“. Ohne diese Angabe lässt du ihn, wie er ist. Die Beurteilung
  gleichst du nie an.
- **Neubau:** den Baum neu bauen wie unter „Neubau“.
- **Kontrolle:** den Baum zur Kontrolle in einen Zwischenstand neu bauen
  und mit ihm vergleichen, wie unter „Kontrolle“.
- **Prüfung:** die Akte prüfen wie unter „Prüfung“ unten.
- **Berichtigung:** eine Angabe im Baum, die der Benutzer als falsch
  übernommen erkannt hat, mit der Unterlage, aus der sie stammt.

## Ablauf

1. **Stand:** `git status --short`, `akte-stand` und
   `akte-stand --vorlage`. Es steht etwas aus, wenn `unterlagen/` oder
   `literatur/` Änderungen ohne Commit haben oder wenn `akte-stand`
   etwas anderes meldet als „AKTE.md und kapitel/ sind auf dem Stand von
   unterlagen/.“: neue, geänderte oder entfernte Unterlagen, einen nicht
   abgeschlossenen Bau, einen fehlenden Überblick, eine Datei über ihrer
   Höchstlänge, einen Verweis ins Leere oder Fristen, deren Datum vorbei
   ist. Steht nichts aus und nennt der Auftrag nichts, meldest du das und
   endest. Meldet `akte-stand` den bisherigen Aufbau mit `BEURTEILUNG.md`,
   baust du nichts: Du committest nur die Unterlagen wie in Schritt 2, und
   die Rückmeldung sagt, dass eine Akte im bisherigen Aufbau nicht mehr
   gebaut wird.
2. **Unterlagen committen:** die neuen und geänderten Dateien in
   `unterlagen/` außer der Beurteilung und entfernte Unterlagen in einem
   Commit. Ohne solche entfällt der Commit.
3. **Beurteilung und `literatur/` committen,** wenn eine von beiden
   Änderungen ohne Commit hat, etwa neue Einträge der Beurteilung aus dem
   Gespräch:
   1. Gegenprüfen wie unter „Gegenprüfung“, Art „Beurteilung“. Die
      bestätigten Funde berichtigst du in den Einträgen ohne Commit; eine
      Änderung an committeten Einträgen nimmst du mit
      `git diff HEAD -- unterlagen/beurteilung.md` zurück, ohne die
      neuen Einträge zu verlieren.
   2. `unterlagen/beurteilung.md` und `literatur/` in einem Commit.
4. **Den Baum bauen.** Meldet `akte-stand` einen nicht abgeschlossenen
   Bau, gehören dessen Änderungen mit dazu. Zeigt
   `git diff HEAD -- kapitel/grundlage.md` dabei keine neue oder geänderte
   Prüfsumme, weil der Baum noch nie committet war oder der Bau ein
   Neubau war, baust du stattdessen neu, außer es gibt
   `.git/akte-bau/schrittweise`: Dann war es ein schrittweiser Bau, der
   vor `akte-stand --aktualisieren` abbrach oder keine Prüfsumme änderte,
   etwa weil er nur die Fristen nachzog, und du setzt ihn
   schrittweise fort.
   1. Nach der Art:
      - **schrittweise**, der Normalfall, auch wenn `akte-stand` keine
        Unterlage meldet, aber Längen, Verweise oder vorbeigegangene
        Fristen: Ohne nicht abgeschlossenen Bau zuerst
        `rm -rf .git/akte-bau && mkdir .git/akte-bau && touch .git/akte-bau/schrittweise`;
        sonst bleibt `.git/akte-bau/beurteilung-neu.md`, wenn es sie
        gibt, und gehört zu seinen Änderungen. Dann den Subagenten `patientenakte:akte`
        starten, im Auftrag die Ausgabe von `akte-stand`, die Art des Baus
        und als Datei für die neuen Einträge der Beurteilung
        `.git/akte-bau/beurteilung-neu.md`; bei einem fortgesetzten Bau
        dazu, dass Einträge darin bleiben und neue dahinter kommen;
      - **Neubau**, wenn `AKTE.md` fehlt, der Auftrag es verlangt
        oder ein liegen gebliebener Bau es braucht: wie unter
        „Neubau“ unten, statt der Schritte 4.2 bis 4.5 hier;
      - **Kontrolle:** steht ein schrittweiser Bau aus, zuerst dieser mit
        den Schritten 4.2 bis 4.5 hier; danach wie unter „Kontrolle“
        unten, statt der Schritte 4.2 bis 4.5. Gibt es keinen committeten
        Baum oder braucht ein liegen gebliebener Bau den Neubau, baust du
        stattdessen neu;
      - **Berichtigung:** den Baum selbst berichtigen, ohne Subagent.

      Berichtigt wird immer nach „Regeln“ und „Aufbau“ in
      `${CLAUDE_PLUGIN_ROOT}/agents/akte.md`, mit Quelle und Stand. Nach
      einer Berichtigung von dir rufst du `akte-stand` auf und behebst,
      was es zu Längen und Verweisen meldet, wie dort unter „Höchstlängen“
      und „Verweise“; die Gegenprüfung umfasst das mit.
   2. Gleich nach einem Bau am Baum: `akte-stand --aktualisieren`.
   3. Gegenprüfen wie unter „Gegenprüfung“, Art „Baum“ mit dem Anlass:
      nach einem schrittweisen Bau oder nach einer Berichtigung. Das
      entfällt, wenn der Baum gegenüber `HEAD` bis auf
      `kapitel/grundlage.md` unverändert ist und
      `.git/akte-bau/beurteilung-neu.md` leer ist oder fehlt. Quellen der
      Änderung sind:
      - nach einem schrittweisen Bau die gemeldeten Dateien mit ihrem
        Status und dem Commit aus `akte-stand`, dazu die Datei der neuen
        Einträge der Beurteilung;
      - nach einer Berichtigung die Unterlage aus dem Auftrag;
      - für einen liegen gebliebenen Bau dazu die Unterlagen, deren
        Prüfsumme in `git diff HEAD -- kapitel/grundlage.md` neu oder
        geändert ist.

      Die bestätigten Funde berichtigst du im Baum und in
      `.git/akte-bau/beurteilung-neu.md`.
   4. **Beurteilung:** Steht etwas in `.git/akte-bau/beurteilung-neu.md`,
      hängst du es an `unterlagen/beurteilung.md` an; fehlt die Datei,
      legst du sie vorher aus `${CLAUDE_PLUGIN_ROOT}/vorlagen/beurteilung.md`
      an. Gleich danach `rm .git/akte-bau/beurteilung-neu.md`, damit ein
      fortgesetzter Bau sie nicht ein zweites Mal anhängt; bricht der Lauf
      vor dem Commit ab, committet Schritt 3 die angehängten Einträge beim
      nächsten Mal. Dann `akte-stand --aktualisieren` und
      `unterlagen/beurteilung.md` allein committen. Ohne neue Einträge
      entfällt der Schritt.
   5. `AKTE.md` und `kapitel/` zusammen committen, wenn sie geändert sind,
      mit gelöschten Kapiteln (`git add --all -- AKTE.md kapitel`). Danach
      `rm -rf .git/akte-bau`.
5. **Prüfung,** nur wenn der Auftrag sie nennt: wie unter „Prüfung“ unten.
   Neue Einträge der Beurteilung schreibst du dabei nach
   `mkdir -p .git/akte-bau` in `.git/akte-bau/beurteilung-neu.md`. Die Berichtigungen am Baum und die
   neuen Einträge gegenprüfen, Art „Baum“ nach der Prüfung, mit der vorigen Fassung in
   `HEAD` als Quelle, dazu mit der Unterlage, wenn eine Quelle in eckigen
   Klammern nun auf sie zeigt; dann wie in den Schritten 4.4 und 4.5.
6. **Rückmeldung** wie unten.

## Neubau

Der Baum, also der Überblick `AKTE.md` und die Kapitel in `kapitel/`,
wird aus `unterlagen/` mit der Beurteilung und aus `literatur/` neu
gebaut: in Stapeln in einen Zwischenstand, und erst am Ende ersetzt.
Bricht der Bau vorher ab, sind Baum und Beurteilung wie vorher. Die
Zwischenstände liegen in `.git/akte-bau/`, je Stapel ein Verzeichnis mit
`AKTE.md` und `kapitel/`, und werden nie committet. Wie die Unterlagen auf
Stapel verteilt werden, bestimmt allein `akte-stand --stapel`; auch ein
einzelner Stapel läuft diesen Weg. Die Unterlagen lesen die Subagenten; du
selbst liest nur die Einheit, auf die ein Fund zeigt, an seiner
Fundstelle. Einen Teil von `historie.md` oder `beurteilung.md` liest du
mit `akte-stand --einheit "<zeile>"`.

1. **Stapel:** `akte-stand --stapel`. Bricht es ab, läuft kein Neubau:
   Der Baum bleibt, wie er ist, die Rückmeldung sagt das mit der Meldung
   von `akte-stand`, und du endest nach der Rückmeldung.
2. **Beginn:** `rm -rf .git/akte-bau && mkdir -p .git/akte-bau/stapel-0/kapitel`,
   dann `${CLAUDE_PLUGIN_ROOT}/vorlagen/AKTE.md` nach
   `.git/akte-bau/stapel-0/AKTE.md` kopieren. Braucht ein liegen
   gebliebener Bau den Neubau und ist `AKTE.md` committet, verwirfst du
   seine Änderungen, aber erst nach diesen Schritten:
   1. `git diff HEAD -- AKTE.md kapitel > .git/akte-bau/liegengebliebener-bau.diff`
      und `git diff --numstat HEAD -- AKTE.md kapitel`, das die
      hinzugefügten und entfernten Zeilen zählt; geändert sind beide
      zusammen. Neue Dateien in `kapitel/` ohne Commit nennt
      `git status --porcelain -- kapitel`.
   2. Ändert er höchstens 20 Zeilen und legt keine neue Datei an, liest du
      den Diff: Eine Berichtigung, die vor dem Commit abgebrochen ist,
      sieht aus wie ein liegen gebliebener Bau, und ihr Diff kommt in die
      Rückmeldung. Sonst war es ein abgebrochener Bau, den der Neubau aus
      den Unterlagen ersetzt.
   3. `git checkout HEAD -- AKTE.md kapitel`, dann die neuen Dateien aus
      Schritt 1 löschen.

   Bricht der Bau danach ab, bleibt der Diff liegen, bis der nächste Bau
   das Verzeichnis leert.
3. **Je Stapel N** der Reihe nach:
   1. `cp -r .git/akte-bau/stapel-<N-1> .git/akte-bau/stapel-<N>` und den
      Subagenten `patientenakte:akte` starten: Art „Stapel“,
      Zielverzeichnis `.git/akte-bau/stapel-<N>`, die Einheiten des
      Stapels, wie `akte-stand --stapel` sie ausgibt, und die offenen
      Punkte der vorigen Stapel.
   2. Die offenen Punkte nachführen: was er als geklärt oder erledigt
      meldet, fällt weg, was er unter „Offen“ meldet, kommt dazu.
   3. Gegenprüfen wie unter „Gegenprüfung“: Zielverzeichnis
      `.git/akte-bau/stapel-<N>`, Vorfassung `.git/akte-bau/stapel-<N-1>`,
      Quellen die Einheiten des Stapels. Die bestätigten Funde
      berichtigst du in `stapel-<N>`, bevor der nächste Stapel beginnt.
4. **Abgleich mit der vorigen Fassung,** wenn es `HEAD:AKTE.md` gibt: je
   Stapel ein Lauf von `patientenakte:aenderung-gegenpruefen`, Art
   „Abgleich mit der vorigen Fassung“, der letzte Zwischenstand als
   Zielverzeichnis, die Einheiten des Stapels als Quellen; beim letzten
   Stapel dazu „mit Literatur“. Jeden Fund liest du an der Fundstelle in
   der Einheit nach, bei einer Aussage der Literatur an der Stelle in
   `literatur/`. Trägt die Einheit die Angabe der vorigen Fassung und
   überholt sie keine Unterlage, etwa eine Angabe der neuen Fassung zum
   selben Punkt mit späterer Quelle, stellst du sie im letzten
   Zwischenstand mit ihrer Quelle wieder her: wie sie in der vorigen
   Fassung steht, höchstens in Form und Ort geändert nach „Regeln“ und
   „Aufbau“ in `${CLAUDE_PLUGIN_ROOT}/agents/akte.md`. Eine Aussage der
   Literatur stellst du nur so wieder her, wie sie an ihrer Stelle steht.
   Die übrigen Funde verwirfst du mit Grund. Eine Wiederherstellung gilt
   durch den Abgleich als gegengeprüft.
5. **Abschluss:** `cp -r` des letzten Zwischenstands nach
   `.git/akte-bau/abschluss`, dann den Subagenten `patientenakte:akte`
   starten: Art „Abschluss“, Zielverzeichnis `.git/akte-bau/abschluss`,
   Datei für die neuen Einträge der Beurteilung
   `.git/akte-bau/beurteilung-neu.md`. Danach gegenprüfen wie unter
   „Gegenprüfung“: Zielverzeichnis `.git/akte-bau/abschluss`, Vorfassung
   der letzte Zwischenstand, Art „Abschluss“ mit der Datei der neuen
   Einträge. Die bestätigten Funde berichtigst du in `abschluss` und in
   `beurteilung-neu.md`.
6. **Ersetzen:**
   1. Steht etwas in `.git/akte-bau/beurteilung-neu.md`, hängst du es an
      `unterlagen/beurteilung.md` an; fehlt die Datei, legst du sie
      vorher aus `${CLAUDE_PLUGIN_ROOT}/vorlagen/beurteilung.md` an. Was
      schon in ihr steht, änderst du nie.
   2. `.git/akte-bau/abschluss/AKTE.md` nach `AKTE.md` kopieren. In
      `kapitel/` jede Datei außer `kapitel/grundlage.md` löschen, dann
      `cp -r .git/akte-bau/abschluss/kapitel/. kapitel/` und leere
      Verzeichnisse in `kapitel/` löschen.
   3. `akte-stand --aktualisieren`.
7. **Commits:** zuerst `unterlagen/beurteilung.md` allein, wenn sie
   geändert ist, dann `AKTE.md` und `kapitel/` zusammen in einem Commit,
   mit gelöschten Kapiteln (`git add --all -- AKTE.md kapitel`). Danach
   `rm -rf .git/akte-bau`.

## Kontrolle

Die zweite Fassung entsteht wie unter „Neubau“, Schritte 1
bis 3, aber ohne Gegenprüfung je Stapel; bricht `akte-stand --stapel` ab,
läuft keine Kontrolle. Der Baum ist dabei committet und ohne Änderung.
Auch hier lesen die Unterlagen nur die Subagenten, wie dort beschrieben.
Danach je Stapel ein Abgleich wie dort in Schritt 4, in beide Richtungen.
Jede Abweichung ist ein möglicher Fehler einer der beiden Fassungen: Du
liest sie an der Fundstelle in der Einheit nach, bei einer Aussage der
Literatur an der Stelle in `literatur/`, und berichtigst den Baum, wo sich
die zweite Fassung bestätigt, nach „Regeln“ und „Aufbau“ in
`${CLAUDE_PLUGIN_ROOT}/agents/akte.md`; die übrigen verwirfst du mit
Grund. Eine solche Berichtigung gilt durch den Abgleich als gegengeprüft,
auch was du danach an Längen und Verweisen behebst wie unter „Ablauf“ in
Schritt 4.1. Ist der Baum geändert, committest du `AKTE.md` und
`kapitel/` zusammen wie unter „Ablauf“ in Schritt 4.5. Dann
`rm -rf .git/akte-bau`. Bricht die Kontrolle vor dem Commit ab, bleibt
der committete Baum, wie er war; ihre Berichtigungen sind dann ein
liegen gebliebener Bau.

## Gegenprüfung

Der Subagent `patientenakte:aenderung-gegenpruefen` prüft eine Änderung
in frischem Kontext.

- **Auftrag:** die Art „Baum“ mit ihrem Anlass – schrittweiser Bau,
  Berichtigung oder Prüfung –, den Quellen der Änderung als Pfade
  und der Datei der neuen Einträge der Beurteilung, wenn darin etwas
  steht, oder die Art „Beurteilung“ ohne Quellen. Bei einem Zwischenstand
  eines Neubaus stattdessen sein Verzeichnis, die
  Vorfassung als Verzeichnis und als Quellen die Einheiten des Stapels,
  wie `akte-stand --stapel` sie ausgibt; beim Abschluss statt der Quellen
  die Art „Abschluss“ und die Datei der neuen Einträge der Beurteilung.
  Den Diff liest er selbst. Sonst nichts:
  keine Begründung und keine Überlegung zur Änderung, keine
  Zusammenfassung, keine weiteren Unterlagen oder Literatur.
- **Funde:** Jeden Fund liest du an der genannten Fundstelle nach und
  berichtigst die bestätigten. In der Rückmeldung stehen alle Funde: die
  berichtigten mit der Berichtigung, die verworfenen mit Grund, die nicht
  prüfbaren als ungeprüft mit Grund. Danach läuft die Gegenprüfung für
  diese Änderung nicht noch einmal.
- **Keine Funde:** Antwortet er „Keine Funde.“, steht das so in der
  Rückmeldung.
- **Gescheitert:** Bricht er ab oder gibt er weder Funde noch „Keine
  Funde.“ zurück, steht in der Rückmeldung, dass die Gegenprüfung nicht
  gelaufen ist, nicht „nichts gefunden“. Dann geht es mit dem Commit
  weiter.


## Prüfung

Geprüft wird, was sich ohne Befunde und ohne Literatur prüfen lässt: Du
liest dafür keine Befunde (PDF, JPG, PNG), von `literatur/` nur `README.md`
und die Dateinamen. Gelesen werden der Überblick `AKTE.md`, alle Kapitel
in `kapitel/`, die Beurteilung `unterlagen/beurteilung.md`,
`unterlagen/anamnese.md`, `unterlagen/historie.md`, die Dateinamen in
`unterlagen/` und `literatur/`, `literatur/README.md` und die erste Zeile
jeder CSV in `unterlagen/`, dazu das Schema in
`${CLAUDE_PLUGIN_ROOT}/skills/anamnese/SKILL.md`. Ein Eintrag der
Beurteilung, der gilt, ist der je Thema und Art, wie ihn „Einschätzungen“
unter „Regeln“ in `${CLAUDE_PLUGIN_ROOT}/agents/akte.md` bestimmt. Jeder
Fund kommt in eine von drei Gruppen.

**Fragen,** zurückgegeben an den Benutzer:

- ein Punkt des Schemas, zu dem weder `anamnese.md` noch `historie.md`
  noch der Baum etwas sagen. Ein Punkt ist jede Angabe, die das Schema
  nennt; eine zusammenfassende Angabe zum Abschnitt, etwa „vegetative
  Anamnese unauffällig“, deckt dessen Punkte ab, ebenso „unbekannt“.
  Abschnitte des Schemas mit „wo zutreffend“ nur, wo sie zutreffen;
- „keine Angabe“, deren Vermerk älter als 12 Monate ist; jüngere zählen wie
  eine Angabe;
- eine Frist im Baum, ärztlich oder aus der Beurteilung, die abgelaufen
  ist, ohne dass eine Unterlage sie erledigt;
- zwei Angaben im Baum, die sich widersprechen, außer wenn eine davon
  als überholt gekennzeichnet ist;
- eine Quelle im Baum auf eine Datei, die es in `unterlagen/` nicht
  gibt.

**Nur melden,** je mit dem, was den Fund beheben würde, etwa der Subagent
`leitlinien-recherche`, ein Blick in einen bestimmten Befund oder ein
Neubau:

- eine Angabe im Baum ohne Quelle;
- eine Quelle `[literatur/…]` im Baum ohne Datei in `literatur/`, und eine
  Quelle in `literatur/README.md` ohne Registernummer, Version, Gültigkeit
  oder Prüfdatum;
- eine Quelle `[beurteilung TT.MM.JJJJ]` ohne Eintrag mit diesem Datum;
- ein Eintrag der Art Beobachten, der gilt, ohne CSV oder mit anderen
  Spalten als ihre erste Zeile;
- ein Fund, dessen Berichtigung eine neue Empfehlung bräuchte.

**Berichtigen,** alles Übrige:

- den Baum gegen „Regeln“ und „Aufbau“ in
  `${CLAUDE_PLUGIN_ROOT}/agents/akte.md`: Form einer Quelle; Stand-Datum,
  aus der Quelle der Angabe; Form der Messwerte; eine überholte Angabe in
  eigener Zeile; eine doppelte Angabe; eine Angabe im falschen Abschnitt
  ihres Kapitels; Abgelehntes im Überblick.
- die Kapitel gegen die Beurteilung: Unter „Einschätzungen“ steht je
  Thema und Art der Eintrag, der gilt, mit seiner Quelle; einen anderen
  ersetzt du durch ihn.
- die Beurteilung gegen den Baum, mit neuen Einträgen, denn was committet
  ist, bleibt: Ein Eintrag, der gilt und dessen Grundlage der Baum nicht
  mehr trägt, und eine Frist, die laut Baum erledigt ist, bekommen einen
  Eintrag der Art „Aufgehoben“. Ein Eintrag, der Allergien, Medikation
  oder Diagnosen widerspricht, bekommt einen neuen Eintrag mit demselben
  Thema und derselben Art, auf das eingeschränkt, was nicht widerspricht,
  oder, wenn nichts von ihm bleibt, einen Eintrag „Aufgehoben“. Die
  neuen Einträge schreibst du wie unter „Neue Einträge der Beurteilung“
  in `${CLAUDE_PLUGIN_ROOT}/agents/akte.md`, Anlass „Prüfung der Akte.“,
  und ziehst die Kapitel danach nach.

Eine Berichtigung der Form ändert keine Angabe inhaltlich: keinen Wert,
keine Einheit, keinen Referenzbereich, keine Diagnosesicherheit und nicht,
worauf eine Quelle zeigt. Ginge es nicht ohne, meldest du den Fund nur.

## Rückmeldung

- **Commits** mit Hash und Titel; was ohne Commit geblieben ist und warum.
- **Baum:** was sich im Überblick und in den Kapiteln geändert hat,
  inhaltlich zusammengefasst.
- **Beurteilung:** die neuen Einträge in `unterlagen/beurteilung.md`, je
  mit Thema, dem Eintrag, den er ablöst, mit Datum, oder dass er neu ist,
  und dem Grund; getrennt die Einträge, die Schritt 3 committet hat, aus
  dem Gespräch oder aus einem abgebrochenen Bau.
- **Gegenprüfungen:** je Änderung alle Funde wie unter „Gegenprüfung“,
  „Keine Funde.“ oder dass sie nicht gelaufen ist.
- **Bau in Stapeln,** nach einem Neubau oder einer Kontrolle:
  die Zahl der Stapel; nach einem Neubau je Stapel und für den Abschluss
  die Funde seiner Gegenprüfung wie oben; je Stapel aus dem Abgleich die
  Wiederherstellungen oder Berichtigungen und die verworfenen Funde mit
  Grund, oder dass er nicht gelaufen ist; die PDFs, deren Seitenzahl
  `akte-stand --stapel` nicht bestimmen konnte, und ob `historie.md` oder
  `beurteilung.md` keine Datumsüberschriften hat, wenn es das meldet.
  Wurde ein liegen gebliebener Bau zurückgesetzt, steht hier, dass seine
  Änderungen am Baum verworfen sind, mit dem Diff, den du unter „Neubau“
  in Schritt 2 gelesen hast, im Wortlaut; ändert er mehr als 20 Zeilen
  oder legt er Dateien an, stattdessen, dass ein Bau abgebrochen war und
  neu begonnen wurde. Ist der Neubau oder die Kontrolle nicht gelaufen,
  steht das hier mit der Meldung von `akte-stand`.
- **Nach jedem Bau** aus den Rückmeldungen des Subagenten `akte`: nach
  einem Neubau, was er nach `literatur/` berichtigt hat, je mit Kapitel,
  dem Wortlaut der Beurteilung und dem der Quelle; nach einem
  schrittweisen Bau, was er je Kapitel aus `literatur/` zu einer neuen
  Angabe aufgenommen hat, mit Stelle, und welche neuen Einträge der
  Beurteilung daraus folgen; welche Kapitel er geteilt hat und welche
  du, mit den Unterkapiteln; ob der Überblick über seiner Höchstlänge bleibt; welche
  Verweise ins Leere er nicht beheben konnte. Dazu, was `akte-stand`
  nach dem letzten Commit noch zu Längen, Verweisen und Fristen meldet,
  im Wortlaut.
- **Fragen:** die offenen Widersprüche und Unklarheiten, die der Subagent
  `akte` meldet, außer solchen, deren Antwort nach `regeln.md` nicht in
  die Unterlagen käme; nach einem Bau in Stapeln davon nur die nach dem
  letzten Stapel noch offenen. Dazu die Fragen der Prüfung und die
  geklärten Widersprüche kurz mit ihrer Quelle.
- **Nur gemeldet:** die Funde der Prüfung aus dieser Gruppe.
- **Für `unterlagen/`:** Angaben, die dorthin gehören und noch fehlen.
- **Folgen:** ob sich Diagnosen, Medikation, Allergien, Implantate oder
  eine Schwangerschaft geändert haben, auch durch Absetzen oder Ausheilen,
  ob der Baum neu angelegt wurde, ob sich das Kapitel Vorsorge geändert
  hat und ob sich bei den Fristen etwas Wichtiges verschoben hat.
