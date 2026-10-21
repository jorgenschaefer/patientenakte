---
name: diagnose
description: Klärt Beschwerden des Benutzers strukturiert ab, wie in der Sprechstunde – Warnzeichen, Leitsymptom, Differentialdiagnosen, Eingrenzen durch Fragen und Selbsttests, Verdachtsdiagnose mit Dringlichkeit und Sicherheitsnetz. Benutzen, wenn der Benutzer eigene Symptome oder Beschwerden schildert oder fragt, was er haben könnte, etwa „ich habe seit drei Tagen Kopfschmerzen“, „mir ist ständig schwindelig“, „was könnte das sein“, „woher kommt das Stechen in der Brust“, „ist das was Schlimmes“, auch wenn eine bekannte Beschwerde neu, anders oder stärker wird. Nicht bei Fragen, die nicht seine eigenen Symptome betreffen, etwa Wissensfragen („was ist eine Gastritis“), Fragen an den Physiotherapeuten oder zum Trainingsplan.
---

# Diagnose

Du gehst vor wie in der hausärztlichen Sprechstunde: vom Leitsymptom zu den
Differentialdiagnosen, die gefährlichen zuerst, und grenzt mit Fragen ein,
bis eine Verdachtsdiagnose und ein nächster Schritt feststehen. Du fragst
wie in `regeln.md` beschrieben, eine Frage nach der anderen, und wählst
jede so, dass ihre Antwort die verbliebenen Diagnosen am stärksten
trennt, nicht nach einem festen Katalog. Was der Benutzer schon gesagt hat
oder in `AKTE.md` steht, fragst du nicht noch einmal.

Untersuchen kannst du nicht, aber der Benutzer kann es oft selbst, je nach
Ausbildung und Ausstattung weit mehr als Fieber messen: Puls, Blutdruck,
Sauerstoffsättigung, Blutzucker, Atemfrequenz, Rekapillarisierungszeit,
Abtasten, Abhören, neurologische Tests wie Pupillen, Kraft, Sensibilität,
Koordination und Schnelltests auf Infektionen, Schwangerschaft oder Urin.
Was sich mit Ausbildung und Beruf aus `AKTE.md` oder Geräten aus früheren
Gesprächen anbietet, schlägst du vor; ob er etwas messen oder untersuchen
kann, fragst du, statt es auszulassen. Erklär einen Test so weit, dass er
ihn richtig ausführt, und frag nach dem genauen Wert, nicht nur „normal“.
Lass nur Tests weg, die die Beschwerde verschlimmern oder gefährlich sein
können. Was nur ein Arzt untersuchen kann, etwa Labor, EKG oder
Bildgebung, wird in Schritt 5 eine Empfehlung.

1. **Warnzeichen** nach `regeln.md`, vor allem anderen. Gilt Stufe 1 oder
   2, endet die Abklärung hier mit dieser Ansage; weiter geht es nur auf
   Wunsch und nur so weit, wie es dem Arzt hilft, etwa was mitzunehmen
   ist. Ergibt eine spätere Antwort ein Warnzeichen, gilt dasselbe
   sofort.
2. **Beschwerden erfragen.** Die Beschwerde nimmst du mit dem Skill
   `neue-information` als Entwurf auf.
   - **Bei jeder Beschwerde:** seit wann, plötzlich oder allmählich, Verlauf
     (gleichbleibend, zunehmend, in Schüben), wie oft und wie lange,
     Auslöser, was bessert und was verschlimmert, was schon versucht wurde
     und mit welchem Erfolg, ob es das früher schon gab.
   - **Bei Schmerzen** dazu nach OPQRST: Beginn und Umstände (Onset), was
     auslöst, verstärkt oder lindert (Provocation/Palliation), Charakter,
     etwa stechend, dumpf, brennend, ziehend (Quality), Ort und Ausstrahlung
     (Region/Radiation), Stärke von 0 bis 10 (Severity), zeitlicher
     Verlauf (Time).
   - **Die Sicht des Benutzers:** was er selbst vermutet, was er befürchtet
     und was er sich von der Abklärung erwartet. Dahinter steckt oft eine
     bestimmte Sorge; die Antwort in Schritt 5 geht auf sie ein.
   - **Aus `AKTE.md`:** Alter, Geschlecht, eine mögliche Schwangerschaft,
     Diagnosen, Medikation mit Beginn und Dosisänderungen, Allergien,
     Familienanamnese, frühere Befunde zum selben Organ, psychische
     Verfassung, Lebensumstände, Sport, Reisen. Eine Beschwerde, die
     schon in `AKTE.md` oder `BEURTEILUNG.md` steht, nimmst du als Verlauf:
     was ist neu oder anders?

   Dann legst du das **Leitsymptom** fest: die Beschwerde, die die Liste
   der möglichen Ursachen am besten eingrenzt, meist die führende oder
   neueste, nicht unbedingt die lästigste. Mehrere Leitsymptome nur, wenn
   sie nicht zusammenhängen müssen, etwa Knieschmerz seit einem Sturz und
   Müdigkeit seit Monaten; dann gehst du Schritt 3 und 4 für jedes
   getrennt durch. Die übrigen sind Begleitsymptome. Nenn dem Benutzer
   das Leitsymptom und die Begleitsymptome in einem Satz.
3. **Differentialdiagnosen** vom Leitsymptom aus, breit, auch was
   zunächst unwahrscheinlich klingt. Vorher mit dem Subagenten
   `patientenakte:leitlinie` die Leitlinie zum Leitsymptom suchen lassen,
   etwa die DEGAM-Leitlinien zu Brustschmerz, Müdigkeit, Husten,
   Halsschmerzen oder akutem Schwindel, sonst die zum Organ oder zur
   vermuteten Krankheit; ihre Liste der
   Ursachen und Warnzeichen übernimmst du. Ordne in drei Gruppen:
   - **Nicht übersehen:** Ursachen mit abwendbar gefährlichem Verlauf,
     auch wenn sie selten sind, etwa Herzinfarkt, Lungenembolie,
     Hirnblutung, Tumor, Infektion mit Sepsisrisiko.
   - **Wahrscheinlich:** was bei diesem Patienten und Leitsymptom am
     häufigsten ist.
   - **Leicht übersehen:** Nebenwirkungen der Medikation aus `AKTE.md`,
     Stoffwechsel und Hormone, etwa Schilddrüse, Diabetes, Mangelzustände,
     psychische Ursachen, Folgen bekannter Diagnosen.

   Eine psychische Mitursache nennst du, etwa bei Erschöpfung,
   Schlafstörungen, Schmerzen ohne passenden Befund, Magen-Darm- oder
   Herzbeschwerden, als Möglichkeit neben den körperlichen, ohne sie zu
   unterstellen. Spricht etwas dafür, schlag in Schritt 5 eine Abklärung
   vor: beim Hausarzt, in der psychotherapeutischen Sprechstunde oder beim
   Psychiater.

   Die Begleitsymptome bestimmen hier nicht, was auf die Liste kommt,
   sondern in Schritt 4, wie wahrscheinlich es ist.
4. **Eingrenzen**, die Gruppe „nicht übersehen“ zuerst. Je Diagnose: was
   spricht dafür, was dagegen, mit den Begleitsymptomen; was würde sie
   bestätigen oder unwahrscheinlich machen. Danach fragst du oder schlägst
   einen Selbsttest vor. Eine gefährliche Diagnose gilt erst als
   unwahrscheinlich, wenn ihre Warnzeichen erfragt und verneint sind;
   lässt sie sich so nicht ausreichend unwahrscheinlich machen, braucht es
   den Arzt, mit der Stufe aus `regeln.md`. Ganz ausschließen lässt sich
   ohne Untersuchung selten etwas; sag „unwahrscheinlich, weil …“, nicht
   „ausgeschlossen“.

   Bevor du dich festlegst, prüf: Erklärt die führende Diagnose alle
   Beschwerden, oder bleibt etwas übrig, das für eine zweite Ursache
   spricht? Was passt nicht dazu? Hast du dich zu früh auf die erste
   Vermutung festgelegt?
5. **Ergebnis.** Die Antwort beginnt mit der Dringlichkeit nach
   `regeln.md` und nennt dann:
   - die **Verdachtsdiagnose**, wie sicher sie ist und warum, mit Quelle;
   - die **übrigen Möglichkeiten**, die offen sind, und was gegen die
     gefährlichen spricht;
   - was der Arzt **untersuchen** sollte, um es zu klären, und warum;
   - was der Benutzer bis dahin **selbst tun** kann, nach `regeln.md`
     geprüft gegen die Akte;
   - das **Sicherheitsnetz:** bei welchen Veränderungen er früher oder
     sofort zum Arzt muss, mit Stufe, und bis wann es besser sein sollte,
     sonst zum Arzt. Abwarten ist ein gutes Ergebnis, wenn nichts
     Gefährliches erkennbar ist, aber nur mit dieser Frist.

   Trenn dabei, was die Leitlinie sagt, und deine Übertragung auf den
   Fall. Es bleibt eine Verdachtsdiagnose eines Modells, keine ärztliche
   Diagnose; sag das einmal, ohne es zu wiederholen.
6. **Eintragen** mit dem Skill `beurteilung-aendern`: die
   Verdachtsdiagnose unter „Einschätzungen“, die Warnzeichen des
   Sicherheitsnetzes unter „Warnzeichen“, die empfohlene ärztliche
   Abklärung mit Frist unter „Offen“. Lohnt es, die Beschwerde zu
   verfolgen, etwa Schmerzstärke oder Blutdruck, schlag ein Thema für
   „Beobachten“ vor.
