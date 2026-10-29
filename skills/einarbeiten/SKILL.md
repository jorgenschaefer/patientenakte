---
name: einarbeiten
description: Arbeitet alles Ausstehende in den Baum der Akte aus Überblick AKTE.md und Kapiteln ein – Entwürfe in unterlagen/ ohne Commit, neue oder geänderte Unterlagen, Einträge der Beurteilung und literatur/ ohne Commit, einen nicht abgeschlossenen Bau, vorbeigegangene Fristen, zu lange Dateien und Verweise ins Leere –, mit gesammelter Bestätigung; Bau, Gegenprüfung und Commits macht der Subagent akte-nachziehen. Benutzen zu Beginn einer Sitzung, wenn regeln.md es verlangt, auf /einarbeiten, wenn der Benutzer das Angebot am Ende des Gesprächs annimmt, und wenn er die Akte an die Vorlagen angleichen, den Baum neu bauen oder kontrollieren oder die Akte prüfen lassen will.
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
   auf. Es steht etwas aus, wenn `unterlagen/` oder `literatur/`
   Änderungen ohne Commit haben oder `akte-stand` etwas anderes meldet als
   „AKTE.md und kapitel/ sind auf dem Stand von unterlagen/.“, auch nur
   vorbeigegangene Fristen, eine Datei über ihrer Höchstlänge oder einen
   Verweis ins Leere. Steht nichts aus, ist nichts anzugleichen und will
   der Benutzer keinen Neubau, keine Kontrolle und keine Prüfung, sagst du
   das in einem Satz, und der Skill endet.
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

   Baut er den Baum in Stapeln, sagst du vorher in einem Satz, dass der
   Baum neu oder zur Kontrolle gebaut wird und in wie vielen Stapeln, nach
   der Zahl der Zeilen `Stapel N` aus `akte-stand --stapel`. In Stapeln
   baut er bei Neubau oder Kontrolle, beim Angleichen, wenn der Überblick
   oder ein Kapitel von der Vorlage abweicht, wenn `AKTE.md` fehlt und
   bei einem nicht abgeschlossenen Bau, dessen
   `git diff HEAD -- kapitel/grundlage.md` keine neue oder geänderte
   Prüfsumme zeigt, außer es gibt `.git/akte-bau/schrittweise`. Bricht
   `akte-stand --stapel` ab, entfällt der Satz; das meldet der Subagent,
   und du sagst es in Schritt 5.
5. **Änderungen nennen,** auf Deutsch und ohne Namen von Scripts oder
   Subagenten, aus seiner Rückmeldung: was sich im Überblick und in den
   Kapiteln geändert hat, die neuen Einträge der Beurteilung, alle Funde der
   Gegenprüfungen, was nur gemeldet ist, die geklärten Widersprüche kurz mit
   ihrer Quelle. Ist eine Gegenprüfung nicht gelaufen, sagst du das. Dazu
   nach jedem Bau: was er aus `literatur/` zu einer neuen Angabe aufgenommen
   hat und welche neuen Einschätzungen daraus folgen; jedes Kapitel, das er
   geteilt hat; ob der Überblick über seiner Höchstlänge bleibt; und was
   `akte-stand` danach noch meldet, je in einem Satz: jede Datei über ihrer
   Höchstlänge, jeden Verweis ins Leere, der sich nicht beheben ließ, und
   vorbeigegangene Fristen. Nach einem Bau in Stapeln dazu, was die
   Rückmeldung darüber sagt: die Zahl der Stapel; aus dem Abgleich die
   Wiederherstellungen oder Berichtigungen, die verworfenen Funde mit Grund
   und die Stapel, für die er nicht gelaufen ist; ob der vollständige Bau
   oder die Kontrolle nicht gelaufen ist, mit der Meldung von `akte-stand`;
   welche PDFs keine bestimmbare Seitenzahl haben und ob `historie.md` oder
   `beurteilung.md` keine Datumsüberschriften hat. Gibt sie verworfene
   Änderungen am Baum als Diff wieder, zeigst du ihn und fragst, ob etwas
   davon eine Angabe ist, die in die Unterlagen gehört. Die Fragen stellst
   du, wie in `regeln.md` beschrieben.
   - Antworten, auch auf die Fragen der Prüfung, und die Angaben, die
     laut Rückmeldung nach `unterlagen/` gehören, nimmst du mit dem Skill
     `neue-information` auf.
   - Erkennt der Benutzer etwas als falsch übernommen, ist es eine
     Berichtigung mit der Unterlage, aus der es stammt.

   Gibt es danach neue Entwürfe oder Berichtigungen, geht es ab Schritt 3
   weiter.
6. **Antworten:** kurz, was sich dadurch an der Einschätzung ändert. Dazu
   nach den Folgen aus der Rückmeldung je in einem Satz ein Angebot, ohne
   es auszuführen, wo es zutrifft:
   - die **nächsten Schritte** zu zeigen, wenn sich bei den Fristen etwas
     Wichtiges verschoben hat;
   - die **Vorsorge** zu zeigen, wenn sich das Kapitel Vorsorge geändert
     hat;
   - den **Notfallpass** zu zeigen, wenn sich Diagnosen, Medikation,
     Allergien, Implantate oder eine Schwangerschaft geändert haben, auch
     durch Absetzen oder Ausheilen, oder wenn der Baum neu angelegt wurde.
