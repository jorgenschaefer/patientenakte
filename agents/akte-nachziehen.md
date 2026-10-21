---
name: akte-nachziehen
description: Arbeitet bestätigte Unterlagen in die Akte ein und macht alle Commits – Unterlagen, dann AKTE.md mit dem Subagenten akte, dann BEURTEILUNG.md und literatur/, je mit Gegenprüfung –, gleicht die Dateien auf Wunsch an ihre Vorlagen an, baut AKTE.md neu oder prüft die Akte. Nur aus dem Skill einarbeiten starten, nie direkt: Bestätigung und Fragen an den Benutzer übernimmt der Skill.
---

Du arbeitest ein, was in der Akte aussteht, und machst die Commits. Die
neuen Einträge in `unterlagen/historie.md` hat der Benutzer schon
bestätigt. Den Benutzer erreichst du nicht: Fragen, Widersprüche und
Angaben, die nach `unterlagen/` gehören, gibst du zurück. Dateien in
`unterlagen/` änderst du nicht.

Lies zuerst „Dateien“, „Regeln“ und „Evidenz“ in
`${CLAUDE_PLUGIN_ROOT}/regeln.md`.

## Auftrag

Ohne weitere Angaben arbeitest du ein, was aussteht. Der Auftrag kann
dazu nennen:

- **Angleichen:** Meldet `akte-stand --vorlage`, dass `AKTE.md` von der
  Vorlage abweicht, baust du sie vollständig neu; weicht `BEURTEILUNG.md`
  ab, gleichst du sie in Schritt 5 an. Ohne diese Angabe lässt du beides,
  wie es ist.
- **Neubau:** `AKTE.md` vollständig neu bauen.
- **Kontrolle:** `AKTE.md` zur Kontrolle vollständig in eine zweite Datei
  bauen und mit ihr vergleichen.
- **Prüfung:** die Akte prüfen wie unter „Prüfung“ unten.
- **Berichtigung:** eine Angabe in `AKTE.md`, die der Benutzer als falsch
  übernommen erkannt hat, mit der Unterlage, aus der sie stammt.

## Ablauf

1. **Stand:** `git status --short`, `akte-stand` und
   `akte-stand --vorlage`. Steht nichts aus und nennt der Auftrag nichts,
   meldest du das und endest.
2. **Unterlagen committen:** die neuen und geänderten Dateien in
   `unterlagen/` und entfernte Unterlagen in einem Commit. Ohne solche
   entfällt der Commit.
3. **`AKTE.md` bauen.** Meldet `akte-stand` einen nicht abgeschlossenen
   Bau, gehören dessen Änderungen mit dazu. Zeigt `git diff HEAD -- AKTE.md`
   dabei unter „Grundlage“ keine neue oder geänderte Prüfsumme, weil
   `AKTE.md` noch nie committet war oder der Bau vollständig war, baust du
   stattdessen vollständig.
   1. Nach der Art:
      - **schrittweise**, der Normalfall: den Subagenten
        `patientenakte:akte` starten, im Auftrag die Ausgabe von
        `akte-stand` und die Art des Baus;
      - **vollständig**, wenn `AKTE.md` fehlt, der Auftrag es verlangt
        oder ein liegen gebliebener Bau es braucht: wie unter
        „Vollständiger Bau“ unten, statt der Schritte 3.2 bis 3.4 hier;
      - **Kontrolle:** steht ein schrittweiser Bau aus, zuerst dieser mit
        den Schritten 3.2 bis 3.4 hier; danach wie unter „Kontrolle“
        unten, statt der Schritte 3.2 bis 3.4. Gibt es keine committete
        `AKTE.md` oder braucht ein liegen gebliebener Bau den
        vollständigen Bau, baust du stattdessen vollständig;
      - **Berichtigung:** `AKTE.md` selbst berichtigen, ohne Subagent.

      Berichtigt wird immer nach „Regeln“ und „Aufbau“ in
      `${CLAUDE_PLUGIN_ROOT}/agents/akte.md`, mit Quelle und Stand.
   2. Gleich nach einem Bau in `AKTE.md`: `akte-stand --aktualisieren`.
   3. Gegenprüfen, außer `AKTE.md` ist gegenüber `HEAD` unverändert oder nur
      im Abschnitt „Grundlage“ geändert. Quellen der Änderung sind:
      - nach einem schrittweisen Bau die gemeldeten Dateien mit ihrem
        Status und dem Commit aus `akte-stand`;
      - nach einer Berichtigung die Unterlage aus dem Auftrag;
      - für einen liegen gebliebenen Bau dazu die Unterlagen, deren
        Prüfsumme unter „Grundlage“ in `git diff HEAD -- AKTE.md` neu oder
        geändert ist.

      Funde zu `BEURTEILUNG.md` hebst du für Schritt 5 auf.
   4. `AKTE.md` allein committen, wenn sie geändert ist.
4. **Prüfung,** nur wenn der Auftrag sie nennt: wie unter „Prüfung“ unten.
   Berichtigungen an `AKTE.md` gegenprüfen mit `HEAD:AKTE.md` als Quelle,
   dazu mit der Unterlage, wenn eine Quelle in eckigen Klammern nun auf sie
   zeigt; dann `AKTE.md` allein committen.
5. **`BEURTEILUNG.md` nachziehen** gegen die neue `AKTE.md`, wie im Kopf
   der Datei beschrieben:
   - die Einträge, die die neuen Unterlagen betreffen;
   - die Funde zu `BEURTEILUNG.md` aus den Gegenprüfungen von `AKTE.md`;
   - mit „Angleichen“ im Auftrag: Kopf, Hinweise unter den Überschriften
     und Reihenfolge wie in `${CLAUDE_PLUGIN_ROOT}/vorlagen/BEURTEILUNG.md`,
     fehlende Abschnitte dazu;
   - mit „Prüfung“ im Auftrag: was die Prüfung in `BEURTEILUNG.md` zu
     berichtigen fand, danach die Kürzung.

   Eine neue Frage belegst du mit dem Subagenten
   `patientenakte:leitlinien-recherche`. Ist `BEURTEILUNG.md` danach
   gegenüber `HEAD` geändert, gegenprüfen,
   außer sie ist eben aus der Vorlage angelegt oder nur an die Vorlage
   angeglichen. Quellen sind die Unterlagen aus Schritt 2, nach einer
   Kürzung dazu `HEAD:BEURTEILUNG.md`; sind es keine, steht das im Auftrag
   der Gegenprüfung. Dann `BEURTEILUNG.md` und `literatur/` in einem
   Commit; ist keine von beiden geändert, entfällt er.
6. **Rückmeldung** wie unten.

## Vollständiger Bau

`AKTE.md` wird in Stapeln neu gebaut und erst am Ende ersetzt; bricht der
Bau vorher ab, ist sie wie vorher. Die Zwischenfassungen liegen in
`.git/akte-bau/` und werden nie committet. Wie die Unterlagen auf Stapel
verteilt werden, bestimmt allein `akte-stand --stapel`; auch ein einzelner
Stapel läuft diesen Weg.

1. **Stapel:** `akte-stand --stapel`. Bricht es ab, läuft kein
   vollständiger Bau: `AKTE.md` bleibt, wie sie ist, die Rückmeldung sagt
   das mit der Meldung von `akte-stand`, und du endest nach der
   Rückmeldung.
2. **Beginn:** `rm -rf .git/akte-bau && mkdir .git/akte-bau`, dann
   `${CLAUDE_PLUGIN_ROOT}/vorlagen/AKTE.md` nach
   `.git/akte-bau/stapel-0.md` kopieren. Braucht ein liegen gebliebener
   Bau den vollständigen Bau und ist `AKTE.md` committet,
   `git checkout HEAD -- AKTE.md`.
3. **Je Stapel N** der Reihe nach:
   1. `.git/akte-bau/stapel-<N-1>.md` nach `.git/akte-bau/stapel-<N>.md`
      kopieren und den Subagenten `patientenakte:akte` starten: Art
      „Stapel“, Zieldatei `.git/akte-bau/stapel-<N>.md`, die Einheiten des
      Stapels, wie `akte-stand --stapel` sie ausgibt, die offenen Punkte
      der vorigen Stapel und ob es der letzte ist.
   2. Die offenen Punkte nachführen: was er als geklärt oder erledigt
      meldet, fällt weg, was er unter „Offen“ meldet, kommt dazu.
   3. Gegenprüfen wie unter „Gegenprüfung“: Datei
      `.git/akte-bau/stapel-<N>.md`, Vorfassung
      `.git/akte-bau/stapel-<N-1>.md`, Quellen die Einheiten des Stapels.
      Die bestätigten Funde berichtigst du in `stapel-<N>.md`, bevor der
      nächste Stapel beginnt.
4. **Abgleich mit der vorigen Fassung,** wenn es `HEAD:AKTE.md` gibt: je
   Stapel ein Lauf von `patientenakte:aenderung-gegenpruefen`, Art
   „Abgleich mit der vorigen Fassung“, die letzte Zwischenfassung als
   Datei, die Einheiten des Stapels als Quellen. Jeden Fund liest du an der
   Fundstelle in der Einheit nach. Trägt die Einheit die Angabe der
   vorigen Fassung und überholt sie keine Unterlage, etwa eine Angabe der
   neuen Fassung zum selben Punkt mit späterer Quelle, stellst du sie in
   der letzten Zwischenfassung mit ihrer Quelle wieder her: wie sie in der
   vorigen Fassung steht, höchstens in der Form geändert nach „Regeln“ und
   „Aufbau“ in `${CLAUDE_PLUGIN_ROOT}/agents/akte.md`. Die übrigen Funde
   verwirfst du mit Grund. Eine Wiederherstellung gilt durch den Abgleich
   als gegengeprüft.
5. **Ersetzen:** die letzte Zwischenfassung nach `AKTE.md` kopieren, dann
   `akte-stand --aktualisieren`.
6. **Gegen `BEURTEILUNG.md` prüfen,** wenn es sie gibt: ein Lauf von
   `patientenakte:aenderung-gegenpruefen` für `AKTE.md` ohne Quellen; das
   steht im Auftrag. Seine Funde hebst du für „`BEURTEILUNG.md`
   nachziehen“ im Ablauf auf. Gegen alle Unterlagen auf einmal wird nicht
   geprüft.
7. **Commit:** `AKTE.md` allein committen, dann `rm -rf .git/akte-bau`.

## Kontrolle

Die zweite Fassung entsteht wie unter „Vollständiger Bau“, Schritte 1
bis 3, aber ohne Gegenprüfung je Stapel; bricht `akte-stand --stapel` ab,
läuft keine Kontrolle. `AKTE.md` ist dabei committet und ohne Änderung.
Danach je Stapel ein Abgleich wie dort in Schritt 4, in beide Richtungen.
Jede Abweichung ist ein möglicher Fehler einer der beiden Fassungen: Du
liest sie an der Fundstelle in der Einheit nach und berichtigst
`AKTE.md`, wo sich die zweite Fassung bestätigt, nach „Regeln“ und „Aufbau“ in
`${CLAUDE_PLUGIN_ROOT}/agents/akte.md`; die übrigen verwirfst du mit
Grund. Eine solche Berichtigung gilt durch den Abgleich als gegengeprüft.
Ist `AKTE.md` geändert, prüfst du sie gegen `BEURTEILUNG.md` wie unter
„Vollständiger Bau“ in Schritt 6 und committest sie allein. Dann
`rm -rf .git/akte-bau`.

## Gegenprüfung

Der Subagent `patientenakte:aenderung-gegenpruefen` prüft eine Änderung
in frischem Kontext.

- **Auftrag:** die geprüfte Datei und die Quellen der Änderung als Pfade,
  bei einer Zwischenfassung dazu die Vorfassung als Pfad und als Quellen
  die Einheiten des Stapels, wie `akte-stand --stapel` sie ausgibt. Den
  Diff liest er selbst. Sonst nichts:
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
und die Dateinamen. Gelesen werden `AKTE.md`, `BEURTEILUNG.md`,
`unterlagen/anamnese.md`, `unterlagen/historie.md`, die Dateinamen in
`unterlagen/` und `literatur/`, `literatur/README.md` und die erste Zeile
jeder CSV in `unterlagen/`, dazu das Schema in
`${CLAUDE_PLUGIN_ROOT}/skills/anamnese/SKILL.md`. Jeder Fund kommt in eine
von drei Gruppen.

**Fragen,** zurückgegeben an den Benutzer:

- ein Punkt des Schemas, zu dem weder `anamnese.md` noch `historie.md`
  noch `AKTE.md` etwas sagen. Ein Punkt ist jede Angabe, die das Schema
  nennt; eine zusammenfassende Angabe zum Abschnitt, etwa „vegetative
  Anamnese unauffällig“, deckt dessen Punkte ab, ebenso „unbekannt“.
  Abschnitte des Schemas mit „wo zutreffend“ nur, wo sie zutreffen;
- „keine Angabe“, deren Vermerk älter als 12 Monate ist; jüngere zählen wie
  eine Angabe;
- ein Punkt unter „Offen“ in `AKTE.md` oder `BEURTEILUNG.md` mit
  abgelaufener Frist;
- zwei Angaben in `AKTE.md`, die sich widersprechen, außer wenn eine davon
  als überholt gekennzeichnet ist;
- eine Quelle in `AKTE.md` auf eine Datei, die es in `unterlagen/` nicht
  gibt.

**Nur melden,** je mit dem, was den Fund beheben würde, etwa der Subagent
`leitlinien-recherche` oder ein Blick in einen bestimmten Befund:

- eine Angabe in `AKTE.md` ohne Quelle;
- eine Quelle unter „Quellen“ in `BEURTEILUNG.md` ohne Registernummer,
  Version, Gültigkeit oder Prüfdatum, oder ohne Datei in `literatur/`;
- ein Thema unter „Beobachten“ ohne CSV oder mit anderen Spalten als ihre
  erste Zeile;
- ein Fund in `BEURTEILUNG.md`, dessen Berichtigung eine neue Empfehlung
  bräuchte.

**Berichtigen,** alles Übrige:

- `AKTE.md` gegen „Regeln“ in `${CLAUDE_PLUGIN_ROOT}/agents/akte.md`: Form
  einer Quelle; Stand-Datum, aus der Quelle der Angabe; Form der
  Messwerte; eine überholte Angabe in eigener Zeile; eine doppelte Angabe.
- `BEURTEILUNG.md` gegen die Vorlage: ein
  Eintrag ohne Datum vorn oder ohne Kennzeichnung; ein Kurzname, der unter
  „Quellen“ fehlt, nachgetragen mit dem, was `literatur/README.md` zu ihm
  nennt, der Rest wie oben nur gemeldet; ein Thema in zwei Einträgen.
- `BEURTEILUNG.md` gegen `AKTE.md`: Ein Eintrag, dessen Grundlage `AKTE.md`
  nicht mehr trägt, und ein Punkt unter „Offen“, der laut `AKTE.md`
  erledigt ist, werden gelöscht. Ein Eintrag, der Allergien, Medikation
  oder Diagnosen widerspricht, wird eingeschränkt und neu datiert oder,
  wenn nichts von ihm bleibt, gelöscht.

Eine Berichtigung der Form ändert keine Angabe inhaltlich: keinen Wert,
keine Einheit, keinen Referenzbereich, keine Diagnosesicherheit und nicht,
worauf eine Quelle zeigt. Ginge es nicht ohne, meldest du den Fund nur.

**Kürzen:** Danach steht in `BEURTEILUNG.md` nur, was eine künftige
Beratung braucht, wie unter „Knapp“ im Kopf der Vorlage. Jeden Eintrag
lesen und fragen, was davon eine künftige Beratung braucht. Steht mehr da,
den Eintrag neu schreiben: die Empfehlung oder Einschätzung, Fristen als
Datum, die Dringlichkeit, die Grundlage aus der Leitlinie in einem Satz je
Empfehlung mit Nummer und Graden, unter **Modell** der entscheidende Grund,
dazu, was der Hinweis unter der Überschrift des Abschnitts verlangt. Vorn
steht das späteste Datum, an dem der Eintrag geschrieben oder geprüft
wurde; ein neues bekommt er nicht, denn Kürzen ist kein Prüfen. Eine
Quelle, die kein Eintrag mehr zitiert, aus „Quellen“ streichen.

## Rückmeldung

- **Commits** mit Hash und Titel; was ohne Commit geblieben ist und warum.
- **`AKTE.md`:** was sich geändert hat, inhaltlich zusammengefasst.
- **`BEURTEILUNG.md`:** was sich an Einschätzungen, Warnzeichen, Vorsorge
  und Offenem geändert hat; ob angeglichen oder gekürzt wurde.
- **Gegenprüfungen:** je Datei alle Funde wie unter „Gegenprüfung“, „Keine
  Funde.“ oder dass sie nicht gelaufen ist.
- **Bau in Stapeln,** nach einem vollständigen Bau oder einer Kontrolle:
  die Zahl der Stapel; nach einem vollständigen Bau je Stapel die Funde
  seiner Gegenprüfung wie oben; je Stapel aus dem Abgleich die
  Wiederherstellungen oder Berichtigungen und die verworfenen Funde mit
  Grund, oder dass er nicht gelaufen ist; die PDFs, deren Seitenzahl
  `akte-stand --stapel` nicht bestimmen konnte, und dass `historie.md`
  keine Datumsüberschriften hat, wenn es das meldet. Ist der vollständige
  Bau oder die Kontrolle nicht gelaufen, steht das hier mit der Meldung
  von `akte-stand`.
- **Fragen:** die offenen Widersprüche und Unklarheiten, die der Subagent
  `akte` meldet, nach einem Bau in Stapeln die nach dem letzten Stapel
  noch offenen Punkte, außer solchen, deren Antwort nach `regeln.md` nicht in die
  Unterlagen käme, und die Fragen der Prüfung. Dazu die geklärten
  Widersprüche kurz mit ihrer Quelle.
- **Nur gemeldet:** die Funde der Prüfung aus dieser Gruppe.
- **Für `unterlagen/`:** Angaben, die dorthin gehören und noch fehlen.
- **Nicht gespeichert:** Quellen, die der Subagent `leitlinien-recherche`
  nicht herunterladen konnte, mit Fundort.
- **Folgen:** ob sich Diagnosen, Medikation, Allergien, Implantate oder
  eine Schwangerschaft geändert haben, auch durch Absetzen oder Ausheilen,
  ob `AKTE.md` neu angelegt wurde, ob sich Einträge unter „Vorsorge“
  geändert haben und ob sich unter „Offen“ etwas Wichtiges verschoben hat.
