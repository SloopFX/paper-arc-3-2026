# 3-arc: Distilled Additions to sketch.md (Round 1)

**Proposed additions to sketch.md**
- Lane kit (placement: Pilots section)
  - Keep concise list: base serialization, sync string, hierarchical coords, window parities, object invariants, CRC.
- Masked‑attention ≈ BP (placement: Factor Graphs/Bethe)
  - Add line: “Masked attention with graph‑aligned masks approximates parallel BP updates; depth‑T ≈ T rounds.”
- Mixed‑radix/disjoint alphabets (placement: Pilots)
  - Add note: “Use disjoint alphabets per lane/scale (mixed‑radix) to avoid interference.”

**Already integrated in sketch.md**
- Lane kit added; factor‑graph content present.

**Rationale**
- Grounds pilots in a minimal, actionable kit and connects transformer inference to factor‑graph message passing.

---

## Round 2 Refinements
- Place “Masked attention ≈ BP” under “When One Becomes Another; … Factor Graphs” as a decoding intuition note.
- Keep lane kit in Pilots; add brief note on disjoint alphabets (mixed‑radix) to avoid collisions/interference.
- Optionally add a short example listing lane tokens (left for a later examples appendix).

## Round 3 Finalization
- Final text to insert (Factor Graphs): “Masked attention with graph‑aligned masks approximates parallel BP; depth‑T ≈ T rounds.”
- Final text to insert (Pilots): add mixed‑radix/disjoint alphabet note directly after “Minimal lane kit…”.
