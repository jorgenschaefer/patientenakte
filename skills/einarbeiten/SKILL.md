---
name: einarbeiten
description: Arbeitet alles Ausstehende in die Akte ein – Entwürfe in unterlagen/ ohne Commit, neue oder geänderte Unterlagen, Änderungen an BEURTEILUNG.md und literatur/ ohne Commit, einen nicht abgeschlossenen Bau von AKTE.md –, mit gesammelter Bestätigung; Bau, Gegenprüfung und Commits macht der Subagent akte-nachziehen. Benutzen zu Beginn einer Sitzung, wenn etwas aussteht, auf /einarbeiten, wenn der Benutzer das Angebot am Ende des Gesprächs annimmt, und wenn er die Akte an die Vorlagen angleichen, AKTE.md neu bauen oder kontrollieren oder die Akte prüfen lassen will.
---

# Einarbeiten

Hier bleibt, was den Benutzer oder das Gespräch braucht. Einarbeiten,
gegenprüfen und committen tut der Subagent
`patientenakte:akte-nachziehen`.

Der Aufruf kann Entwürfe nennen, die der Benutzer schon bestätigt hat,
etwa `unterlagen/anamnese.md` aus dem Skill `anamnese`.

1. **Sammeln:** `git status --short`, `akte-stand` und
   `akte-stand --vorlage`. Am Ende eines Gesprächs dazu das Gespräch selbst:
   Was nach der Regel in `regeln.md` in die Unterlagen gehört und noch
   nicht als Entwurf dasteht, nimmst du mit dem Skill `neue-information`
   auf. Steht nichts aus, ist nichts anzugleichen und will der Benutzer
   keinen Neubau, keine Kontrolle und keine Prüfung, sagst du das in einem
   Satz, und der Skill endet.
2. **Unbesprochene Dateien:** Eine neue Datei in `unterlagen/`, die weder
   committet ist noch in diesem Gespräch abgelegt wurde, etwa ein PDF mit
   einem Namen außerhalb des Schemas, nimmst du mit dem Skill
   `neue-information` auf. Gehört sie danach nicht hinein, fragst du, ob du
   sie aus `unterlagen/` entfernen sollst; will der Benutzer sie behalten,
   bleibt sie.
3. **Wortlaut bestätigen lassen:** die neuen Einträge in `historie.md` auf
   einmal zeigen, so wie sie im Diff zu `HEAD` stehen. Was nach der Regel
   in `regeln.md` nicht hineingehört, schlägst du zum Streichen vor.
   Änderungen des Benutzers am Wortlaut übernimmst du in den Entwurf;
   gestrichene Einträge entfernst du. Zeilen in CSV-Dateien, abgelegte
   Befunde und was der Aufruf als bestätigt nennt, zeigst du nicht; ohne
   neue Einträge in `historie.md` entfällt der Schritt.
4. **Subagent starten.** Der Auftrag nennt nur, was zutrifft:
   - **Angleichen,** wenn der Benutzer `/einarbeiten` selbst aufgerufen hat
     und `akte-stand --vorlage` eine Abweichung meldet; nicht beim Beginn
     einer Sitzung und nicht aus einem anderen Skill;
   - **Neubau, Kontrolle oder Prüfung,** wenn der Benutzer es will; eine
     Prüfung nie von dir aus;
   - **Berichtigung** mit der Angabe und ihrer Unterlage, aus Schritt 5.

   Keine Zusammenfassung des Gesprächs: Was der Subagent wissen muss, steht
   in den Dateien.

   Baut er `AKTE.md` vollständig, sagst du vorher in einem Satz, dass
   `AKTE.md` vollständig gebaut wird und in wie vielen Stapeln, nach der
   Zahl der Zeilen `Stapel N` aus `akte-stand --stapel`. Vollständig baut
   er bei Neubau oder Kontrolle, beim Angleichen, wenn `AKTE.md` von der
   Vorlage abweicht, wenn `AKTE.md` fehlt und bei einem nicht
   abgeschlossenen Bau, dessen `git diff HEAD -- AKTE.md` unter
   „Grundlage“ keine neue oder geänderte Prüfsumme zeigt. Bricht
   `akte-stand --stapel` ab, entfällt der Satz; das meldet der Subagent,
   und du sagst es in Schritt 5.
5. **Änderungen nennen,** aus seiner Rückmeldung: was sich an `AKTE.md` und
   `BEURTEILUNG.md` geändert hat, alle Funde der Gegenprüfungen, was nur
   gemeldet ist, die geklärten Widersprüche kurz mit ihrer Quelle. Ist eine
   Gegenprüfung nicht gelaufen, sagst du das. Nach einem Bau in Stapeln
   dazu, was die Rückmeldung darüber sagt: die Zahl der Stapel; aus dem
   Abgleich die Wiederherstellungen oder Berichtigungen, die verworfenen
   Funde mit Grund und die Stapel, für die er nicht gelaufen ist; ob der
   vollständige Bau oder die Kontrolle nicht gelaufen ist, mit der Meldung
   von `akte-stand`; welche PDFs keine bestimmbare Seitenzahl haben und ob
   `historie.md` keine Datumsüberschriften hat. Die Fragen stellst du, wie in `regeln.md`
   beschrieben.
   - Antworten, auch auf die Fragen der Prüfung, und die Angaben, die
     laut Rückmeldung nach `unterlagen/` gehören, nimmst du mit dem Skill
     `neue-information` auf. Eine Quelle, die nicht gespeichert werden
     konnte, behandelst du wie unter „Evidenz“ in `regeln.md`.
   - Erkennt der Benutzer etwas als falsch übernommen, ist es eine
     Berichtigung mit der Unterlage, aus der es stammt.

   Gibt es danach neue Entwürfe oder Berichtigungen, geht es ab Schritt 3
   weiter.
6. **Antworten:** kurz, was sich dadurch an der Einschätzung ändert. Dazu
   nach den Folgen aus der Rückmeldung je in einem Satz ein Angebot, ohne
   es auszuführen, wo es zutrifft:
   - die **nächsten Schritte** zu zeigen, wenn sich unter „Offen“ etwas
     Wichtiges verschoben hat;
   - die **Vorsorge** zu zeigen, wenn sich Einträge unter „Vorsorge“ in
     `BEURTEILUNG.md` geändert haben;
   - den **Notfallpass** zu zeigen, wenn sich Diagnosen, Medikation,
     Allergien, Implantate oder eine Schwangerschaft geändert haben, auch
     durch Absetzen oder Ausheilen, oder wenn `AKTE.md` neu angelegt wurde.
