# 1-immanant: Distilled Additions to sketch.md (Round 1)

**Proposed additions to sketch.md**
- Block‑hafnian identity (placement: Immanants… section)
  - Ensure explicit: `per(C) = haf([[0, C], [C^T, 0]])` with a short parenthetical “permanent as block‑hafnian.”
- Structure checklist (placement: Immanants… section)
  - Add bullet: “Structure checklist: block direct sums, planarity (Kasteleyn/Pfaffian), low treewidth (DP) to choose exact vs approximate.”
- Planar matching note (placement: Wick Pairings; Kronecker/BCCB; Lempel–Ziv or Immanants)
  - Add sentence: “For planar graphs with Kasteleyn orientation, |pf| counts perfect matchings (FKT).”

**Already integrated in sketch.md**
- per=haf block identity; structure checklist bullets.

**Rationale**
- Makes reduction pathways explicit and flags structure‑exploitation pathways (planar/treewidth) alongside multiplicativity.

---

## Round 2 Refinements
- Add exact pointer for planar matchings: “with a Kasteleyn orientation (FKT), |pf(K)| counts perfect matchings.”
- Note placement explicitly: under “Immanants, Determinant, Permanent, Pfaffian, Hafnian, Matchings”.
- If examples are added later, include a 2×2 det/per mini-example reference (already in Tests section).

## Round 3 Finalization
- Final text to insert (Immanants…): “Identity: per(C)=haf([[0,C],[C^T,0]]). Structure checklist: block sums; planar (Kasteleyn/|pf| matchings); low treewidth (DP).”
