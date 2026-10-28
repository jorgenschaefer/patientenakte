---
effort: L
utility: M
---

# BEURTEILUNG.md verteilt ein Problem auf fünf Abschnitte

`vorlagen/BEURTEILUNG.md` gliedert nach der Art der Aussage: Warnzeichen,
Einschätzungen, Beobachten, Vorsorge, Offen, Abgelehnt (Zeilen 15-35).
Was zu einem Problem gehört, steht so an bis zu fünf Stellen. In einer
echten Akte verweisen die Einträge deshalb aufeinander („siehe ‚Offen‘,
…“, „siehe ‚Einschätzungen‘, …“). Wer nur mit `grep` liest (siehe
`ueberblick-beim-start.md`), findet einen Teil und übersieht den Rest.

Das Modell hat „Offen“ in der echten Akte schon von sich aus nach
Problemen gegliedert, mit fetten Zwischenzeilen je Problem.

Idee aus der Überprüfung: je Problem ein Abschnitt `## <Problem>` mit
Einschätzung, Warnzeichen, Offenem, Beobachtetem und Abgelehntem.
Übergreifend bleibt nur, was zu keinem Problem gehört, etwa die Vorsorge.
Eine Frage zu einem Problem hieße dann: einen zusammenhängenden Abschnitt
lesen, etwa mit einem `akte-stand --thema`.

Betrifft jeden Skill und Agenten, der Abschnitte von `BEURTEILUNG.md` beim
Namen nennt (`regeln.md`, `skills/diagnose`, `skills/naechste-schritte`,
`skills/vorsorge`, `agents/akte-nachziehen.md`,
`agents/aenderung-gegenpruefen.md`), und bestehende Akten müssen
umgestellt werden, etwa beim Angleichen an die Vorlage mit `/einarbeiten`.
