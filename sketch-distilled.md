# Distilled Modifications to sketch.md

This document aggregates per-file distilled proposals into a cohesive plan to enrich `sketch.md`. Changes are grouped by target section. Round 1 captures the initial pass; later rounds refine ordering and wording.

## Round 1 (Initial Pass)

**Immanants, Determinant, Permanent, Pfaffian, Hafnian**
- Add identity: `per(C) = haf([[0, C], [C^T, 0]])` (if not already present) with brief note “permanent as block‑hafnian.”
- Add “Structure checklist”: block direct sums; planarity/Kasteleyn (Pfaffian); low treewidth (DP).
- Note: “Computing permanents is #P‑complete; exact feasible only for small k (Ryser/Glynn).”

**Union Bound and Refinements**
- Add explicit Chung–Erdős formula: `P(⋃ A_i) ≥ (Σ P(A_i))^2 / Σ_{i,j} P(A_i ∩ A_j)`.
- Add cumulant truncation note: refinements correspond to truncating cumulant expansion (Möbius inversion); Bonferroni = order‑k.

**Matrix Identities / Determinant Tools**
- Add “Permanent toolbox” bullet list (block/reducible, treewidth DP, Bethe/JSV, Gray‑order caches).

**Fisher / Riemannian**
- Add SLT caveat: in degenerate Fisher, use RLCT/singular-BIC; operate on identifiable subspaces.
- Add remedies list: reparameterize/quotient; informative priors/penalties; constrained architectures; profile likelihood; whiten identifiable directions.

**Signals / Stationarity / Capacity**
- Add time–bandwidth DoF ≈ 2Bt (real) over duration t and bandwidth B.
- Add finite‑blocklength note linking dispersion to snapshot reliability (place near Log‑Det/MI).
- Add interleaving/scrambling mention under Pilots to realize waterfilling and decorrelate constraints.

**Pilots / ARC Lane Kit**
- Add minimal lane kit: base serialization, sync string, hierarchical coords, window parities, object invariants, CRC.
- Add “Masked attention ≈ BP” line under Factor Graphs/Bethe (graph‑aligned masks; depth‑T ≈ T rounds).
- Add mixed‑radix/disjoint alphabet note for lanes.

**Snapshots / Glimpses**
- Add snapshot protocols bullet: prefix‑free IDs, hashing, delta caches; keep numerical factors for rank‑k updates.
- Tie multiresolution scheduling to submodularity/curvature.

---

Next: Round 2 will de‑duplicate and tighten phrasing; Round 3 will finalize precise insertions.

## Round 2 (Refined Plan)

Consolidates placements, removes redundancy, and tightens phrasing.

**Precise Placements**
- Immanants…: keep per=haf block identity; append “Structure checklist” and planar Kasteleyn/|pf| matchings note.
- Union Bound…: include explicit Chung–Erdős; add “cumulant truncation (Möbius inversion)” note; cross‑link to Moments/Cumulants.
- Matrix Determinant Lemma…: include “Permanent toolbox” bullet; mention JSV (nonnegative) and Bethe/loopy BP as heuristics.
- Diagonalize Fisher…: include SLT note with RLCT spelled out; add remedies bullet list inline.
- Precision, Quantization, Spacetime…: add time–bandwidth DoF ≈ 2Bt (real) and cross‑link to Stationary Measures.
- Log‑Det Updates…: keep finite‑blocklength note; tie dispersion to snapshot windowing.
- CRT, Singer… Pilots…: add lane kit; add interleaving/scrambling sentence; add mixed‑radix/disjoint alphabets note.
- When One Becomes Another… Factor Graphs: add “Masked attention ≈ BP” line.
- One‑Line Sketch; Dyadic Windows; Glimpse: keep snapshot protocols bullet; tie window selection to submodular/curvature.

**Redundancy Removals**
- Avoid repeating waterfilling/majorization across sections; keep only under Matrix Identities and Signals references.
- Keep cumulants discussion centralized (Moments/Cumulants) with a short pointer from Union Bound.

**Optional Anchors**
- Add internal anchors to section headers (editor convenience; not required for content).

## Round 3 (Final Cohesive Plan)

This final plan provides concise insertion text per section, deduplicated and ready to apply.

**Immanants, Determinant, Permanent, Pfaffian, Hafnian, Matchings**
- Insert: “Identity: per(C)=haf([[0,C],[C^T,0]]). Structure checklist: block sums; planar (Kasteleyn/|pf| matchings); low treewidth (DP).”

**Union Bound; Submodularity Ratio; Diminishing Returns; Synergy**
- Insert: “Two‑term refinement (Chung–Erdős): P(⋃ A_i) ≥ (Σ P(A_i))^2 / Σ_{i,j} P(A_i∩A_j). View refinements as cumulant truncations (Möbius inversion); Bonferroni = order‑k.”

**Matrix Determinant Lemma; Flat Spectrum; Waterfilling; Majorization; Jacobi; Schur**
- Insert: “Permanent toolbox: detect block/reducible; try treewidth DP; dense nonnegative → JSV FPRAS or Bethe/loopy BP; implement Ryser/Glynn with Gray‑order bitsets.”

**Diagonalize Fisher Information, KL, VC Dimension, Kendall’s Tau**
- Insert: “Singular models (degenerate Fisher): replace χ²/BIC with singular learning theory (real log canonical threshold, RLCT); operate on identifiable subspaces. Remedies: reparameterize/quotient symmetries; informative priors/penalties; constrain architectures; profile likelihood; whiten identifiable directions.”

**Precision, Quantization, Spacetime Coordinates, Riemannian Geometry**
- Insert: “Degrees of freedom (DoF): ≈2Bt real DoF over duration t, bandwidth B.”

**Log‑Det Updates; Curvature; Pairwise and Higher‑Order MI; Long‑Range Cancellation**
- Insert: “Finite‑blocklength: R*(n,ε)≈C−√(V/n)Q^{-1}(ε); dispersion V ties snapshot size to reliability.”

**CRT, Singer Difference Sets, Pilots (Positional/Spectral, Absolute/Relative), Nested Lattices, Planar Matchings**
- Insert: “Minimal lane kit: base serialization, sync string, hierarchical coords, window parities, object invariants, CRC. Use scrambling/interleaving (de‑Bruijn/PRN) to decorrelate constraints and realize waterfilling. Use mixed‑radix disjoint alphabets to avoid collisions.”

**When One Becomes Another; Cumulants and Gaussianity; Bethe Permanent; Factor Graphs**
- Insert: “Masked attention with graph‑aligned masks approximates parallel BP; depth‑T ≈ T rounds.”

**One‑Line Sketch; Dyadic Windows; Glimpse**
- Insert: “Snapshot protocols: prefix‑free IDs, hashing, delta caches; retain Cholesky/LDLᵀ factors to enable rank‑k det lemma/Woodbury updates.”
