# 7-permanent: Distilled Additions to sketch.md (Round 1)

**Proposed additions to sketch.md**
- Permanent toolbox (placement: Matrix identities or Immanants)
  - Add bullet list: detect block/reducible form; try treewidth DP; for dense nonnegative, use Bethe/JSV approximations; cache subproblems with Gray‑order bitsets.
- Complexity signal (placement: Immanants)
  - Add note: “Computing permanents is #P‑complete (even 0–1); exact feasible only for small k (Ryser/Glynn O(k·2^k)).”

**Already integrated in sketch.md**
- Permanent toolbox added; complexity context present across sections.

**Rationale**
- Gives a pragmatic decision tree for permanent‑related computations and sets expectations on exact vs approximate regimes.

---

## Round 2 Refinements
- Under the toolbox, mention JSV FPRAS applies to nonnegative matrices; Bethe/loopy BP are heuristics otherwise.
- If space permits, add a one-line note on Ryser vs Glynn variants and Gray‑order iteration for cache locality.

## Round 3 Finalization
- Final text to insert (Matrix Identities or Immanants): “Permanent toolbox: detect block/reducible structure; try treewidth DP; dense nonnegative → JSV FPRAS or Bethe/loopy BP; implement Ryser/Glynn with Gray‑order bitsets.”
