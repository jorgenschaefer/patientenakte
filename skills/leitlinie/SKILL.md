---
name: leitlinie
description: Sucht eine Leitlinie, Studie oder Fachinformation zu einer medizinischen Frage, prüft ihre Gültigkeit und legt sie in literatur/ ab. Benutzen vor jeder Empfehlung oder Einschätzung zu Diagnostik, Therapie, Medikation oder Training, die nicht schon mit aktueller Quelle in BEURTEILUNG.md steht, und wenn der Benutzer fragt, was die Leitlinie zu einem Thema sagt.
---

# Leitlinie

Rangfolge der Quellen: Leitlinien (AWMF S3, Nationale VersorgungsLeitlinien,
dann S2e/S2k), dann systematische Übersichtsarbeiten (z. B. Cochrane), dann
einzelne Studien, zuletzt Lehrbuchwissen und Expertenmeinung. Deutsche
Leitlinien haben Vorrang; eine internationale kommt hinzu, wenn es keine
deutsche zur Frage gibt oder die internationale deutlich neuer ist.

1. In `literatur/README.md` nachsehen, ob die Quelle schon vorliegt.
2. Online prüfen, ob es eine neuere Fassung gibt und bis wann die vorliegende
   gilt (im AWMF-Register: Gültigkeitsdatum, Status „in Überarbeitung“), wenn
   die letzte Prüfung älter als drei Monate ist, „gültig bis“ vorbei ist oder
   die Quelle neu ist. Gibt es eine neuere, die Dateien ersetzen und
   `literatur/README.md` anpassen. Eine abgelaufene Leitlinie ohne neue
   Fassung weiter nutzen und als abgelaufen kennzeichnen.
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
   nicht nur an der Fundstelle. Empfehlungsnummer, Empfehlungsgrad,
   Evidenzniveau und Konsensstärke festhalten.
5. Eine neue Quelle im Abschnitt „Quellen“ von `BEURTEILUNG.md` eintragen:
   Kurzname, Registernummer, Version, Gültigkeit, Prüfdatum, lokale Datei.
   Was nur aus Sekundärquellen oder Auszügen stammt, als solches
   kennzeichnen. Nach einer erneuten Prüfung das Prüfdatum dort und in
   `literatur/README.md` anpassen.
