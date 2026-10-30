# Ubiquitous Language

Die Fachsprache ist Deutsch. Auch der Code des Plugins benennt die Dinge auf Deutsch; in Klammern steht der Name, den er dafür verwendet, wo es einen gibt.

## Terminology

- **Abgelehnt** - eine Empfehlung, die der Patient abgelehnt hat; seine Angabe steht mit Grund in **Historie** und im **Kapitel** ihres Themas, damit sie nicht erneut vorgeschlagen wird.
- **Abgeschlossen** - der Status eines **Problems**, das ausgeheilt oder erledigt ist und das keine **Unterlage** als fortbestehend nennt.
- **Abgleich mit der vorigen Fassung** - der Vergleich eines neu gebauten **Baums** je **Stapel** mit dem committeten, der Angaben findet, die beim **Neubau** verloren gingen.
- **Abschluss** - der letzte Schritt eines **Neubaus**, der die **Einschätzungen** gegen die neuen **Kapitel** prüft und neue Einträge an die **Beurteilung** hängt.
- **Akte** - das private Git-Repo eines Patienten mit **Überblick**, **Kapiteln**, **Unterlagen** und **Literatur**; das Plugin selbst enthält keine.
- **Aktiv** - der Status eines **Problems**, das gerade behandelt, abgeklärt oder mit offener Frist verfolgt wird.
- **Anamnese** (`anamnese.md`) - die Erstbefragung einer neuen **Akte**, vom Benutzer bestätigt und danach unverändert.
- **Art** - die Sorte eines Eintrags der **Beurteilung**: Einschätzung, Warnzeichen, Frist, **Beobachten** oder **Aufgehoben**.
- **Aufgehoben** - die **Art** eines Eintrags der **Beurteilung**, der einen früheren Eintrag mit dessen Art und Datum für nicht mehr gültig erklärt.
- **Baum** - der **Überblick** zusammen mit allen **Kapiteln** und **Unterkapiteln**; er fasst **Unterlagen**, **Literatur** und **Beurteilung** zusammen und lässt sich jederzeit daraus neu bauen.
- **Beobachten** - ein Thema, das mit einer Messreihe als CSV in `unterlagen/` verfolgt wird, festgehalten als Eintrag dieser **Art** in der **Beurteilung**.
- **Beurteilung** (`beurteilung`, `unterlagen/beurteilung.md`) - die **Unterlage** mit den Einschätzungen eines Modells, Warnzeichen mit Stufe, Fristen und was beobachtet wird; sie wird nur angehängt, nie umgeschrieben.
- **Bisheriger Aufbau** (`bisheriger_aufbau`) - eine **Akte** aus der Zeit vor dem **Baum**, mit allen Fakten in einer alten `AKTE.md` und allen Einschätzungen in `BEURTEILUNG.md`.
- **Einarbeiten** - neue und geänderte **Unterlagen** und Entwürfe committen und den **Baum** nachziehen, ausgelöst mit `/einarbeiten`.
- **Entwurf** - eine neue Angabe oder ein neuer Eintrag der **Beurteilung** ohne Commit, geschrieben im Gespräch und committet beim **Einarbeiten**.
- **Gegenprüfung** - die Prüfung einer Änderung vor dem Commit durch einen Subagenten in frischem Kontext, gegen ihre Quellen.
- **Grundlage** (`grundlage`, `kapitel/grundlage.md`) - die Prüfsummen der eingearbeiteten **Unterlagen**; sie ist kein **Kapitel**.
- **Historie** (`historie`, `historie.md`) - die **Unterlage** mit Aussagen des Patienten, Ereignissen, Arztgesprächen und Korrekturen, je unter dem Datum der Mitteilung.
- **Höchstlänge** (`woerter_ueberblick`, `woerter_kapitel`) - die größte Zahl an Wörtern, die der **Überblick** und jedes **Kapitel** haben darf.
- **Kapitel** - eine Datei in `kapitel/` zu einem **Problem** oder einem **übergreifenden Thema**, mit Fakten, Literatur, Einschätzungen und **Abgelehntem**.
- **Kontrolle** - ein zweiter Bau des **Baums** in einen **Zwischenstand**, der mit dem committeten verglichen wird, um Fehler einer der beiden Fassungen zu finden.
- **Literatur** (`literatur/`) - Leitlinien, Studien und Fachinformationen als PDF und Textfassung, auf die **Kapitel** mit Stelle verweisen.
- **Neubau** - der Bau des ganzen **Baums** aus allen **Unterlagen** in **Stapeln**, der den alten erst am Ende ersetzt.
- **Nicht abgeschlossener Bau** - Änderungen am **Baum** ohne Commit, die ein abgebrochener Bau hinterlassen hat.
- **Problem** - alles, was behandelt oder abgeklärt wird, auch ohne Diagnose; es ist **aktiv**, **ruhend** oder **abgeschlossen**.
- **Prüfung** - die Prüfung der ganzen **Akte** auf Lücken, Widersprüche und Form, ohne Befunde und **Literatur** zu lesen, nur auf Wunsch.
- **Ruhend** - der Status eines **Problems**, das fortbesteht, aber gerade weder Beschwerden macht noch behandelt wird.
- **Schrittweiser Bau** - das **Einarbeiten** neuer **Unterlagen** nur in die **Kapitel**, die sie berühren, und in den **Überblick**.
- **Stand der Akte** - was beim Start einer Sitzung eingespielt wird: was `akte-stand` an Ausstehendem und zu Behebendem meldet, und vergangene Termine, dazu, was daraus folgt.
- **Stapel** - eine Gruppe von **Unterlagen** in der Reihenfolge ihres Datums, die ein **Neubau** oder eine **Kontrolle** in einem Schritt einarbeitet.
- **Übergreifendes Thema** - ein **Kapitel**, das zu keinem einzelnen **Problem** gehört, genau eines von `person`, `behandelnde`, `medikation`, `psyche`, `gynaekologie`, `impfungen`, `vorsorge` und `messwerte`.
- **Überblick** (`akte`, `AKTE.md`) - was in jeder Beratung gelten muss, dazu je **Problem** und **übergreifendem Thema** eine Zeile mit Verweis auf sein **Kapitel**; er ist ab dem Start jeder Sitzung im Kontext.
- **Umstellung** - der Übergang einer **Akte** im **bisherigen Aufbau** zum **Baum**, mit dem ersten Eintrag der **Beurteilung** aus `BEURTEILUNG.md` und Entwürfen für die **Historie**.
- **Unterkapitel** - ein **Kapitel** unter einem anderen, entstanden durch Teilen, wenn ein Kapitel über seine **Höchstlänge** wuchs.
- **Unterlagen** (`unterlagen/`) - die Grundlage der **Akte**: Befunde, **Anamnese**, **Historie**, **Beurteilung** und Messreihen.
- **Verweis ins Leere** - ein Link im **Baum** auf eine Datei, die es nicht gibt.
- **Zwischenstand** - ein unfertiger **Baum** unter `.git/akte-bau/`, den ein **Neubau** oder eine **Kontrolle** je **Stapel** schreibt; er wird nie committet und nach dem Bau gelöscht.

## Aliases to avoid

- "Akte" für die Datei `AKTE.md` - nimm **Überblick**. „Akte“ ist das ganze Repo.
- "BEURTEILUNG.md" für die **Beurteilung** - die Datei gibt es nur im **bisherigen Aufbau**; die Beurteilung ist `unterlagen/beurteilung.md`.
- "Diagnose" für einen Eintrag des **Überblicks** - nimm **Problem**; ein Problem braucht keine Diagnose.
