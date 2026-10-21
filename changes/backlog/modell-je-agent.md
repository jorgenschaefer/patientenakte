---
effort: M
utility: M
---

# Modell je Agent festlegen

Kein Agent in `agents/` nennt im Kopf ein `model:`; alle laufen mit dem
Modell der Sitzung, in der Regel Opus. Frage des Benutzers: Könnte
`leitlinien-recherche` auch mit Sonnet arbeiten, oder braucht er das
Reasoning von Opus? Und welches Modell passt bei den anderen Agenten?

Einschätzung aus dem Lesen der Agenten, nicht gemessen:

- **`leitlinien-recherche`:** erster Kandidat für Sonnet. Er läuft am
  häufigsten, vor fast jeder Empfehlung (`regeln.md`, „Evidenz“) und
  mehrfach aus `vorsorge-recherche`. Seine Arbeit ist vor allem Suchen,
  Gültigkeit prüfen, Herunterladen und Ablesen; die Übertragung auf den
  Fall macht der Aufrufer (`agents/leitlinien-recherche.md`, Kopf). Das
  Risiko: falsche oder veraltete Leitlinie, falsch abgelesene
  Empfehlungsnummer oder falscher Grad – Fehler, die danach niemand
  bemerkt.
- **`akte`:** zweiter Kandidat, erst nach dem Bau in Stapeln, wenn ein
  Lauf höchstens 20 Seiten liest. Hier entstehen die Fehler, die jede
  Beratung erbt; beim vollständigen Bau am 21.10.2026 fand die
  Gegenprüfung mit Opus mehrere.
- **`akte-nachziehen`, `aenderung-gegenpruefen`, `vorsorge-recherche`:**
  Opus. Steuerung und Bewertung der Funde, das Sicherheitsnetz vor jedem
  Commit, und ein Plan mit Fälligkeiten und Kostenträgern aus vielen
  Quellen; `vorsorge-recherche` läuft zudem selten.
- **Haiku** für keinen: Jeder Agent schreibt oder prüft Gesundheitsdaten.

Messen ließe sich das in der Testakte des Skills `run`: dieselben Fragen
mit beiden Modellen, verglichen nach gewählter Quelle, Urteil über die
Gültigkeit, Empfehlungsnummer, Grad und Wortlaut. Siehe auch
`testakte-evals.md`.
