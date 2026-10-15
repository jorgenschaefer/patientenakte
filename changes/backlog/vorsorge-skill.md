---
effort: M
utility: L
---

# Skill `vorsorge`: vollständiger Vorsorge- und Kontrollplan

Übergabe für den Agenten, der den Skill schreibt. Alles Nötige steht hier;
Rückfragen an den Benutzer nur, wo unten „offen“ steht.

## Anlass

In einer Akte fragte der Benutzer: „Welche Vorsorgeuntersuchungen werden für
mich empfohlen, und wann sind diese fällig?“ Die erste Antwort enthielt nur
die gesetzliche Früherkennung nach Alter und Geschlecht (Check-up, Haut,
Darm, Prostata). Auf Nachfragen kamen nacheinander dazu:

- Zahnarzt und Bonusheft (letzter Termin stand nicht in der Akte und wurde
  nicht erfragt);
- ob ein Befund (Prostata im CT vergrößert) den Abstand verkürzt;
- Kontrollen aus den Leitlinien der Diagnosen (z. B. Blutzucker bei
  erhöhtem Diabetesrisiko);
- Kontrollen aus der Fachinformation eines Dauermedikaments (Haut unter
  TNF-α-Antikörper);
- arbeitsmedizinische Vorsorge im Nebenberuf (Rettungsdienst);
- spätere Altersgrenzen (Bauchaorta ab 65) und Kassenleistungen außerhalb der
  Früherkennung (Präventionskurse, Bonusprogramm der Kasse);
- ob eine Augenkontrolle auch bei erhöhtem Diabetesrisiko gilt (nein, nur bei
  Diabetes; das war geprüft, aber nicht gesagt).

Die Frage war klar. Das Modell hat „Vorsorge“ selbst auf die G-BA-
Früherkennung eingeengt, obwohl vieles schon in `BEURTEILUNG.md` und
`literatur/` lag. Der Skill soll festlegen, welche Quellen jedes Mal
abgearbeitet werden, und sagen, was geprüft wurde und nichts ergab.

Gesundheitsdaten aus der Akte gehören nicht in dieses öffentliche Repo
(siehe `changes/backlog/testakte-evals.md`). Die Beispiele hier sind deshalb
allgemein gehalten.

## Was es schon gibt

- `skills/naechste-schritte/SKILL.md:15-20`, Schritt 4, beschreibt die
  Ermittlung der Vorsorge bereits in einem Satz: G-BA-Richtlinien nach Alter
  und Geschlecht, STIKO, Kontrollen aus den Leitlinien der Diagnosen und aus
  Abschnitt 4.4 der Fachinformation, Abgleich mit „Vorsorge“ und „Impfungen“
  in `AKTE.md`. Die Frage nach Vorsorge löst diesen Skill aber nicht aus
  (Beschreibung: „was steht an“, „was ist am wichtigsten“), und ein Satz
  reicht nicht für eine vollständige Prüfung.
- `skills/leitlinie/SKILL.md:18-19` nennt die G-BA-Richtlinien zu
  Früherkennung und Check-up als Quelle mit dem Rang einer Leitlinie. Der
  Skill prüft je Aufruf eine Frage; für einen Plan braucht es viele Aufrufe.
- `skills/anamnese/SKILL.md:45` erfragt „Bisherige Vorsorge:
  Früherkennungsuntersuchungen und Check-up mit Datum und Ergebnis“, nicht
  Zahnarzt, Augenarzt, Betriebsarzt.
- `agents/akte.md:68`: Abschnitt `## Vorsorge` in `AKTE.md`, „Früherkennung
  und Check-up mit Datum und Ergebnis“.
- `vorlagen/BEURTEILUNG.md` hat keinen Abschnitt für Vorsorge. In der Akte,
  aus der dieser Auftrag stammt, entstand dabei ad hoc „Offen → ### Vorsorge“;
  daneben stehen verwandte Einträge unter „Offen“ (Impfungen, Blutfette,
  Knochendichte, Vitamine) und im Abschnitt „Warum diese Blutwerte
  beobachten“ (PSA-Intervall, Hepatitis-Screening).

## Anforderungen

### Auslöser

Fragen wie „welche Vorsorge steht an“, „welche Vorsorgeuntersuchungen
brauche ich“, „was zahlt die Kasse an Früherkennung“, „wann ist der nächste
Check-up“, „welche regelmäßigen Kontrollen sollte ich machen“. Zusätzlich
wird er aus `naechste-schritte` Schritt 4 aufgerufen, statt dass dort die
Prüfung in einem Satz steht.

### Quellen, die jedes Mal vollständig durchgegangen werden

Je Quelle prüfen, ob sie zutrifft; die Prüfung selbst über den Skill
`leitlinie` (Gültigkeit, Ablage in `literatur/`, Eintrag unter „Quellen“).

1. **Alter und Geschlecht, gesetzliche Leistungen:**
   - G-BA Gesundheitsuntersuchungs-Richtlinie (GU-RL, Check-up), darin auch
     das einmalige Screening auf Hepatitis B und C ab 35;
   - G-BA Krebsfrüherkennungs-Richtlinie (KFE-RL): Haut, Prostata und äußeres
     Genitale beim Mann, Gebärmutterhals und Brust bei der Frau
     (Mammographie-Screening);
   - G-BA Richtlinie für organisierte Krebsfrüherkennungsprogramme
     (oKFE-RL): Darmkrebs, Zervixkarzinom;
   - G-BA Ultraschallscreening auf Bauchaortenaneurysmen (US-BAA-RL);
   - Zahnärztliche Untersuchung und Bonusheft (§ 55 SGB V), Zahnsteinentfernung;
   - Gesundheitsuntersuchungen für Kinder und Jugendliche und
     Schwangerschaftsvorsorge, wo zutreffend;
   - Altersgrenzen der nächsten Jahre nennen, auch wenn sie noch nicht
     erreicht sind.
2. **Je Diagnose in `AKTE.md`** (auch Nebenbefunde): die Leitlinie der
   Diagnose, gezielt in den Kapiteln zu Verlaufskontrolle, Komplikationen,
   Krebsrisiko und Überwachung, Begleiterkrankungen und Manifestationen
   außerhalb des betroffenen Organs, Mangelzuständen, Knochen. Auch
   Zustände wie „erhöhtes Diabetesrisiko“ zählen.
3. **Je Mittel unter „Medikation → Aktuell“, und früheren Mitteln mit
   Spätrisiko:** Fachinformation Abschnitt 4.4 (Kontrollen vor und während
   der Behandlung), dazu 4.2 und 4.8, wo dort Kontrollen stehen.
4. **Lebensumstände:** Familienanamnese mit Verwandtschaftsgrad (viele
   Richtlinien zählen nur erstgradige Verwandte), Beruf und Nebenberuf mit
   arbeitsmedizinischer Vorsorge (ArbMedVV, Anhang), Rauchen, Alkohol,
   Gewicht.
5. **Impfungen:** Standard- und Indikationsimpfungen nach STIKO, bei
   Immunsuppression die STIKO-Anwendungshinweise; abgleichen mit dem
   Impfstatus in `AKTE.md`. Ausführlich nur, was nicht schon unter „Offen“
   steht.
6. **Über die Pflichtleistungen hinaus:** Selbstzahlerleistungen nur, wenn
   eine Leitlinie einen Nutzen nennt; Präventionskurse nach § 20 SGB V;
   Bonusprogramm und Satzungsleistungen der Kasse aus `AKTE.md` (nicht
   prüfbar ohne Kasse: als Frage an den Benutzer).
7. **`BEURTEILUNG.md` und `AKTE.md`:** was dort schon zu Vorsorge oder
   regelmäßigen Kontrollen steht, wird übernommen und verwiesen, nicht neu
   gesucht.

### Fehlende letzte Termine

Fehlt in `AKTE.md` für eine zutreffende Untersuchung der letzte Termin, fragt
der Skill danach, gesammelt in einem Satz nach den Regeln in `regeln.md`, und
nimmt die Antworten über `neue-information` auf. Zu erfragen sind vor allem
Zahnarzt, Hautarzt, Augenarzt, Betriebsarzt und Check-up.

### Ausgabe

- Eine Tabelle: Untersuchung, Anlass (Alter, Diagnose, Mittel, Beruf),
  zuletzt laut Akte, wieder fällig, Quelle (Kurzname, Empfehlungsnummer,
  Grad), Kostenträger (Kasse, Arbeitgeber, Selbstzahler).
- Überfälliges zuerst.
- Darunter je Zeile mit Abweichung oder Begründung: was die Quelle sagt und,
  getrennt, die Übertragung auf den Fall (wie überall im Plugin).
- Eine kurze Liste „geprüft, ohne Ergebnis“, mit Grund, etwa
  „Augenkontrolle wegen erhöhtem Diabetesrisiko: nur bei Diabetes
  vorgesehen“.
- Hinweis auf Termine, die vorab gebucht werden müssen.

### Wohin das Ergebnis geht

- Empfehlungen nach `BEURTEILUNG.md`, als eine zentrale Liste. **Offen:** ein
  eigener Abschnitt in `vorlagen/BEURTEILUNG.md` (etwa `## Vorsorge`
  zwischen „Beobachten“ und „Offen“) oder ein Unterabschnitt von „Offen“. Der
  Abschnitt verweist auf Einträge an anderer Stelle (Impfungen, Blutwerte),
  statt sie zu doppeln.
- Fakten (stattgefundene Untersuchungen mit Datum und Ergebnis) über
  `neue-information` nach `unterlagen/` und von dort in `AKTE.md`.
- Ein Commit wie in `regeln.md` beschrieben.

## Fallstricke aus der Sitzung

- **Kalenderjahr-Regeln.** Die Richtlinien rechnen oft in Kalenderjahren,
  nicht ab Datum: GU-RL § 2 (nach einem Check-up keiner in den zwei folgenden
  Kalenderjahren), KFE-RL § 29 Abs. 2 (Haut erst nach Ablauf des folgenden
  Kalenderjahres), KFE-RL § 2 (Anspruch ab Beginn des Kalenderjahres),
  oKFE-RL Darmkrebs § 3 (nach einer Koloskopie neun Kalenderjahre keine
  Früherkennung). „Wieder fällig“ deshalb aus dem Wortlaut berechnen.
- **Krankheitsbezogene Kontrollen ersetzen oder verkürzen die allgemeine
  Früherkennung.** Beispiele: Überwachungskoloskopien bei CED statt
  Darmkrebs-Früherkennung ab 50; Hautkrebsscreening unter Thiopurinen oder
  TNF-α-Antikörpern „regelmäßig“ statt alle zwei Jahre. Die Kasse zahlt
  dann oft als Krankenbehandlung, nicht als Früherkennung.
- **Leitlinie und G-BA widersprechen sich manchmal.** Beispiel: Die KFE-RL
  zahlt ab 45 jährlich eine Tastuntersuchung der Prostata, die S3-Leitlinie
  Prostatakarzinom (Empfehlung 4.1, Grad A) rät davon ab. Beides nennen.
- **Intervalle hängen am Befund, nicht nur am Alter.** Beispiel: PSA-Intervall
  nach Basis-PSA (S3 Prostata, 4.4). Bildbefunde wie eine vergrößerte
  Prostata ändern das Intervall nicht; das ausdrücklich sagen, wenn ein
  solcher Befund in der Akte steht.
- **Familienanamnese:** Verwandtschaftsgrad prüfen; eine Großmutter senkt das
  Anfangsalter für Darmkrebs-Früherkennung nicht.
- **Quellenzugriff:** Das AWMF-Register blockiert automatisierte Abrufe
  zeitweise (Bot-Schutz); Pfade unter `guideline_bkp` liefern teils 404.
  Ausweichen auf Spiegel der Fachgesellschaft, sonst nach `leitlinie` den
  Benutzer um das PDF bitten. G-BA-Richtlinien lassen sich über
  `https://www.g-ba.de/richtlinien/<nr>/` finden (KFE-RL: 17, oKFE-RL: 104);
  dort steht die gültige Fassung und ob eine beschlossene Änderung erst
  später in Kraft tritt.
- **Gesetze und Kassenregeln** (§ 55 SGB V, ArbMedVV, BEMA) lagen nur aus
  Sekundärquellen vor; als solche kennzeichnen oder den Normtext lesen
  (gesetze-im-internet.de).
- **Nicht jede Leitlinie zur Diagnose passt zur Frage.** Beispiel: Die
  S3-Leitlinie zu periimplantären Infektionen (AWMF 083-023) behandelt
  Entzündungen, nicht die Nachsorge gesunder Implantate. Dann „keine
  Leitlinie gefunden“ sagen.

## Umsetzung

- Neuer Skill `skills/vorsorge/SKILL.md` im Stil der vorhandenen: Frontmatter
  mit `name` und `description` (die Beschreibung trägt die Auslöser),
  nummerierte Schritte, knapp, Deutsch.
- Schritt 1 wie in den anderen Skills: `akte-stand`, bei Änderungen zuerst
  `akte-aktualisieren`.
- `skills/naechste-schritte/SKILL.md` Schritt 4 auf den neuen Skill
  verweisen lassen.
- Prüfen, ob `skills/anamnese/SKILL.md:45` Zahnarzt, Augenarzt und
  arbeitsmedizinische Vorsorge mit erfragen soll.
- `vorlagen/BEURTEILUNG.md` um den Abschnitt ergänzen, wenn die Entscheidung
  unter „Wohin das Ergebnis geht“ so fällt; `agents/akte.md:68` ggf. um
  Zahnarzt und Augenarzt erweitern.
- `README.md` unter „Folgegespräche“ um das Anliegen ergänzen.
- Nach dem Schreiben den Skill `improve-skill` darauf anwenden; der Skill soll
  Verhalten festlegen, keine Leitlinieninhalte enthalten (Intervalle und
  Paragraphen oben sind Hinweise für den Autor, nicht Text für den Skill;
  sie ändern sich und werden über `leitlinie` geprüft).
- `tests/check.sh` ausführen.
- Commits nach den Regeln des Benutzers: nur die betroffenen Dateien
  stagen, getrennte Änderungen getrennt committen, nicht pushen.
- Deutsch nach den Regeln des Benutzers: keine erfundenen Komposita als
  Namen für Vorgänge; übliche englische Fachbegriffe bleiben.

## Fertig, wenn

- Die Frage „Welche Vorsorgeuntersuchungen werden für mich empfohlen?“ den
  Skill auslöst und eine Antwort ergibt, die alle sieben Quellenarten oben
  abdeckt, ohne dass der Benutzer nachfragen muss.
- Die Antwort fehlende letzte Termine erfragt und eine Liste „geprüft, ohne
  Ergebnis“ enthält.
- `naechste-schritte` den Skill nutzt, statt die Prüfung selbst zu
  beschreiben.
- Es in `BEURTEILUNG.md` eine zentrale Stelle für Vorsorge gibt, ohne
  doppelte Einträge.

Ausprobieren lässt sich das mangels Testakte nur an einer echten Akte des
Benutzers, lokal und ohne Daten ins Repo zu übernehmen; den Pfad nennt der
Benutzer.
