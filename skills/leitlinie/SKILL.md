---
name: leitlinie
description: Sucht eine Leitlinie, Studie oder Fachinformation zu einer Frage aus Medizin, Psychologie und Psychotherapie, Physiotherapie, Ernährung oder Sport, prüft ihre Gültigkeit und legt sie in literatur/ ab. Benutzen vor jeder Empfehlung oder Einschätzung zu Diagnostik, Therapie, Medikation, Training oder Vorsorge, die nicht schon mit aktueller Quelle in BEURTEILUNG.md steht, und wenn der Benutzer fragt, was die Leitlinie zu einem Thema sagt.
---

# Leitlinie

Rangfolge der Quellen: Leitlinien, dann systematische Übersichtsarbeiten
(z. B. Cochrane), dann einzelne Studien, zuletzt Lehrbuchwissen und
Expertenmeinung. Unter den Leitlinien gehen AWMF S3 und Nationale
VersorgungsLeitlinien vor S2e/S2k. Deutsche Leitlinien haben Vorrang; eine
internationale kommt hinzu, wenn es keine deutsche zur Frage gibt oder die
internationale deutlich neuer ist.

Den Rang einer Leitlinie haben je nach Fachgebiet auch:

- **Impfungen:** die Empfehlungen der STIKO;
- **Vorsorge:** die Richtlinien des G-BA zu Früherkennung und
  Gesundheitsuntersuchung (Check-up);
- **Medikation:** die Fachinformation, für Dosierung, Gegenanzeigen,
  Wechselwirkungen und Kontrolluntersuchungen;
- **Psychotherapie:** die S3-Leitlinien der AWMF und die Nationalen
  VersorgungsLeitlinien, etwa zur unipolaren Depression, für Verfahren und
  Kassenleistungen die Psychotherapie-Richtlinie des G-BA;
- **Ernährung:** die Referenzwerte und Leitlinien der DGE;
- **Bewegung und Sport:** die Bewegungsempfehlungen der WHO, die
  Positionspapiere des ACSM und der DGSP;
- **Physiotherapie:** der physiotherapeutische Teil der AWMF-Leitlinien,
  sonst die Leitlinien der KNGF und die Clinical Practice Guidelines des
  JOSPT.

1. In `literatur/README.md` nachsehen, ob die Quelle schon vorliegt.
2. Online prüfen, ob es eine neuere Fassung gibt und bis wann die vorliegende
   gilt (im AWMF-Register: Gültigkeitsdatum, Status „in Überarbeitung“), wenn
   die letzte Prüfung älter als drei Monate ist, „gültig bis“ vorbei ist oder
   die Quelle neu ist. Gibt es eine neuere, die Dateien ersetzen und
   `literatur/README.md` anpassen. Eine abgelaufene Leitlinie ohne neue
   Fassung weiter nutzen und als abgelaufen kennzeichnen. Lässt sich die
   Gültigkeit nicht prüfen, etwa weil das Register den Abruf sperrt, die
   vorliegende Fassung weiter nutzen, das Prüfdatum nicht anpassen (bei
   einer neuen Quelle keins eintragen), in ihrer Zeile in
   `literatur/README.md` „nicht prüfbar am TT.MM.JJJJ“ mit Grund vermerken,
   ebenso in Schritt 5, und dem Benutzer sagen, dass die Gültigkeit
   ungeprüft ist. Ein früherer Vermerk wird dabei ersetzt.
3. Wird die Quelle voraussichtlich wieder gebraucht, speichern:
   - das PDF als `literatur/<herausgeber>-<nummer>-<thema>-<stand>.pdf`
     und daneben die Textfassung mit `pdftotext -layout` als `.txt`;
   - eine Zeile in `literatur/README.md`: Datei, Quelle, Version oder Stand,
     gültig bis, Abrufdatum, Herkunft;
   - lässt sie sich nicht herunterladen (Paywall, Download gesperrt), den
     Benutzer fragen, ob er das PDF beschaffen kann, mit Fundort; kommt er
     nicht heran, unter „Nicht gespeichert“ mit Grund und Fundort eintragen
     und die Aussage als aus Sekundärquellen gekennzeichnet verwenden.
4. Die Aussage zur Frage in der Textfassung nachlesen, im ganzen Abschnitt,
   nicht nur an der Fundstelle. Für den Eintrag in `BEURTEILUNG.md`
   Empfehlungsnummer, Empfehlungsgrad, Evidenzniveau und Konsensstärke
   festhalten; ohne Empfehlungsnummer, etwa bei Fachinformationen und
   Studien, den Abschnitt oder die Seite.
5. Eine neue oder erneut geprüfte Quelle mit dem Skill `beurteilung-aendern`
   unter „Quellen“ eintragen. Nach einer erneuten Prüfung auch in
   `literatur/README.md` das Prüfdatum anpassen und einen Vermerk „nicht
   prüfbar“ streichen.
