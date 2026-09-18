# Goal: distill a source family into the live paper corpus

Given a named source file or glob, reduce it into the smallest coherent live corpus without losing distinct useful machinery.

## Required process

1. Inventory and read every matched source before editing. Compare the sources with one another first: identify the strongest version, exact duplicates, paraphrase-only duplicates, contradictions, and genuinely distinct mechanisms or examples.
2. Treat the current live documents as authoritative context, not as untouchable prose. Route each surviving idea by function:
   - `vCORE.md`: only material that directly strengthens the current paper's argument, method, evidence, or necessary exposition. Remove authorial scratch notes and hide any indispensable editorial question in `<!-- ... -->` until resolved.
   - `vNOTES.md`: decisions likely to affect the next revision or experiment; current-paper material not ready for `vCORE.md`; uncertain placement; and next-paper or future-work programs. Put newly extracted future work at the end and state what evidence or decision would promote it.
   - `vWIKI.md`: stable background, known identities, standard machinery, and useful technical reminders that are not part of the current argument. It is not a citation substitute; verify niche claims against primary sources before promoting them into the paper.
   - `vOUTLINE.csv`: update only when the paper's one-screen conceptual structure changes. Preserve exactly seven columns, use commas only as separators, put no commas inside fields, and keep at most eleven rows including the header.
   - `README.md`: update only when the live corpus or verification command changes; keep it terse.
3. Discard only pure duplication, including the same idea restated with rearranged wording. Preserve separately phrased material when it introduces different machinery, a different falsifiable claim, a useful example, or a materially different caveat. Remove unsupported result claims, empty analogy chains, obsolete editorial chatter, and ornamental jargon rather than laundering them into `vNOTES.md`.
4. Consolidate surviving prose so core concepts appear where needed without becoming a repeated naming ritual. Hypertokens are sparse prompt-time protocol injections, not labels that must recur in every paragraph.
5. Make a thinning pass and then an expansion pass:
   - thinning: deduplicate across all live files and move misplaced content;
   - expansion: restore any missing definitions, operational details, caveats, examples, or promotion criteria needed for the remaining text to stand alone.
6. Run the repository's maintained verification and any relevant experiment checks.
7. Ask Claude Opus for a read-only second red-team of the matched sources and resulting live files. Require exact actionable findings on lost unique ideas, bad routing, duplicated claims, technical errors, unsupported assertions, and inconsistencies. Independently check its findings and apply only valid corrections.
8. Delete the matched source files only after distillation, the second pass, and corrections are complete. Never delete an irreducible raw transcript; move raw transcripts to the repository's transcript location instead. Do not delete unrelated files.
9. Rerun verification. Report what was preserved, merged, discarded, or left uncertain, and print this goal inline in the handoff so it can be reused for the next source family.

## Completion condition

The source family has been compared internally, all distinct useful content has one justified home, pure duplicates and fluff are gone, Opus findings have been dispositioned, matched reducible sources have been deleted, and all checks pass.
