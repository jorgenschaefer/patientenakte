---
effort: L
utility: S
---

# Kein Medikationsplan zum Mitnehmen

Wird der Benutzer unerwartet gefragt, was er nimmt, hat er keine
vollständige Liste bei sich und muss sich auf sein Gedächtnis verlassen.
Zuletzt im Krankenhaus: Der Name eines Präparats fiel ihm nicht ein. In
`AKTE.md` stehen alle Mittel unter „Medikation → Aktuell“
(`agents/akte.md:80`), aber nur in der Akte, die er unterwegs nicht dabeihat.
Richtig wäre eine aktuelle, vollständige Liste aller Mittel (verordnet,
Bedarfsmedikation, Nahrungsergänzung) mit Präparat, Wirkstoff und Dosis, die
er bei sich tragen und vorzeigen kann und die bei jeder Änderung der
Medikation nachgezogen wird.

Schon umgesetzt: Der Skill `notfallpass` gibt alle Mittel mit den übrigen
Angaben für den Notfall als Text zum Kopieren in den Notfallpass des Handys
aus, nach jeder Änderung von selbst (`skills/neue-information/SKILL.md`,
Schritt 10). Was fehlt, ist ein Plan zum Ausdrucken und Vorlegen.

Idee des Benutzers: ein Script, das aus der Akte einen Plan im offiziellen
Format als PDF erzeugt. Das Format legt die KBV fest (Anlage 3 zur
Vereinbarung nach § 31a SGB V), mit Data-Matrix-Barcode und PZN je Präparat.
Dafür bräuchte „Medikation → Aktuell“ ein festes, maschinenlesbares Format,
das bisher das Modell frei schreibt. Die PZN steht nirgends in der Akte,
dazu kämen eine PDF- und eine Barcode-Bibliothek.

Einwand: Ein selbst erzeugter Plan im offiziellen Layout, erst recht mit
Barcode, sieht im Krankenhaus aus wie von Praxis oder Apotheke ausgestellt.
Er würde womöglich ungeprüft in die eigene Medikation des Krankenhauses
übernommen. Ein Plan nach dem Muster, ohne Barcode und mit dem Vermerk „vom
Patienten erstellt“, wäre ehrlicher und kleiner.
