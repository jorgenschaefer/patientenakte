# Review: AKTE.md vollständig in Stapeln bauen

## For you

Needs your decision first:

- **An unfinished Berichtigung is thrown away without a word** (review
  round 1, should-fix; not fixed). Suppose a Berichtigung or a Prüfung edits
  AKTE.md and the session dies before the commit. The Grundlage section
  then shows no new checksum. Under AC-21, the next run resets AKTE.md to
  `HEAD` and rebuilds it in batches, so the user's correction is lost
  silently. The rebuild may also make the same mistake again. Before this
  change, such a leftover was kept and checked against all Unterlagen.
  AC-16 ("Berichtigung wie heute") and AC-21 pull in opposite directions
  here. The two cases cannot be told apart by `.git/akte-bau/`, because a
  batch build never touches AKTE.md before step 5. Decide whether AC-21
  should exclude this case, or whether the Rückmeldung should at least say
  that uncommitted changes were discarded.
- **Old historie.md entries without headings move to the newest date**
  (review round 1, should-fix; not fixed). An existing record has entries
  without `## TT.MM.JJJJ`. Once `neue-information` writes its first
  heading, AC-3 rules that everything before it is "Text vor der ersten
  Überschrift". So all those old entries, possibly years of them, become
  one unit dated today, sorted after every Befund. The notice
  „historie.md ohne Datumsüberschriften.“ also stops appearing. This is
  what AC-3 says, but it recreates the order that "Ruled out" rejects, and
  nobody is told. The criteria do not settle a historie.md that mixes
  entries with and without headings. Your real record will hit this with
  its next entry.
- **Departure from a technical decision:** I removed the one-run
  „Vollständig“ order type from `agents/akte.md` (review round 1
  should-fix, also the round 1 finding in ticket 02 that its build kept).
  The decision says "bisherige Aufträge bleiben gültig". But nothing
  issues this order any more. It read all Unterlagen in one context, in
  an order that contradicts AC-3: exactly the run this change replaces.
  Round 2 confirmed that nothing in the plugin still refers to it.

The rest, most important first:

- **The batch-build flow has never run end to end with this review's
  fixes in place** (ticket 02; this review). Everything outside
  `bin/akte-stand` is agent prose, and no test drives a session (backlog
  `testakte-evals`). These were never run live:
  - the abort without `pdfinfo` on the agent side (AC-19);
  - a stalled build (AC-21);
  - a PDF without a page count, or a historie.md without headings (AC-13);
  - every prose fix since ticket 02's last live run.

  Before acceptance, run `/run` with `neue-testakte --klein` for a Neubau
  and a Kontrolle.
- **Expired deadlines (AC-12) depend on the model saying "letzter
  Stapel"** (ticket 02). In one live run the order for the last batch
  left this out.
- **A removed document's entries drop out of a rebuild unmentioned**
  (ticket 02). A source in the previous version that points to no current
  batch is not compared by any batch's Abgleich.
- **Kontrolle corrections count as cross-checked by the Abgleich that
  found them** (ticket 02). AC-9 does not say so.
- **`--stapel` needs bash ≥ 4 and the `C.UTF-8` locale**, so it does not
  run on stock macOS (ticket 01).
- **AC-14 (headings in historie.md) is only a rule in
  `skills/neue-information/SKILL.md`**, checked by reading (ticket 01).

## Fixes after the last review

No reviewer saw these. They answer round 2's findings:

- `skills/einarbeiten/SKILL.md` step 5 now also tells the user which
  batches the Abgleich did not run for (round 2 should-fix). The list is
  now split by semicolons.
- `agents/akte-nachziehen.md`, „Fragen“: "after a batch build, only the
  points still open after the last batch" now applies only to what the
  akte subagent reported. The Prüfung's questions stay in their own
  sentence (round 2 nit).
- `tests/akte-stand.sh`, "Die Grenzen stehen nicht in den Texten des
  Plugins":
  - It now reads each file as a whole with `grep -z`, so a number split
    across a line break is caught.
  - A missing path now fails the test.
  - I checked both cases by hand, by appending "20\nSeiten" to the README
    and by renaming a path in the test (round 2 nit).
- README line wrap (round 2 nit).

## Fixed in round 1 and seen by round 2

- `agents/akte.md`: removed the one-run full build (see above).
- `agents/akte-nachziehen.md`, „Fragen“: after a batch build, takes the
  points still open after the last batch *instead of* what each batch
  reported (AC-12).
- `agents/aenderung-gegenpruefen.md`: with a Vorfassung path or in the
  Abgleich, an empty diff of historie.md no longer makes the whole file a
  source; only the batch's days are (AC-6).
- `skills/einarbeiten/SKILL.md` step 5: passes on the number of batches,
  plus the Abgleich's restorations and discarded findings (AC-11, AC-18).
- README:
  - It no longer gives the 20-page limit as a number (AC-15). A new test
    looks for the limits in the README, `regeln.md`, the agents and the
    skills; it failed first.
  - The agent list describes the new tasks of `akte` and
    `aenderung-gegenpruefen`.

## Builds' fixes after their last review

I checked each one against the finding it answers. All are correct and
complete:

- Ticket 01:
  - the anamnese header test;
  - removing `brew` from the README and the error message.
- Ticket 02:
  - einarbeiten step 5 relaying the batch notices (now extended, see
    above);
  - the README paragraph separating Neubau from Kontrolle;
  - the Kontrolle bullet in step 3.1.

## Checks

`tests/check.sh` passes after the last commit. I did not run the plugin
in Claude Code. The round 1 reviewer ran only `neue-testakte --klein`
with `akte-stand --stapel`, which gave 3 batches.
