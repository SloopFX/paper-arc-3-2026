# 6-union-bound: Distilled Additions to sketch.md (Round 1)

**Proposed additions to sketch.md**
- Chung–Erdős (placement: Union Bound)
  - Add explicit formula: `P(⋃ A_i) ≥ (Σ P(A_i))^2 / Σ_{i,j} P(A_i ∩ A_j)`.
- Cumulant truncation (placement: Union Bound or Moments/Cumulants)
  - Add note: “View refinements as cumulant truncations (Möbius inversion on partitions); Bonferroni corresponds to order‑k truncations.”
- Cross‑disciplinary anchors (placement: Matrix identities / Pilots)
  - Add note: “Use majorization/waterfilling for spectral allocation; leverage expanders/treewidth for structure; nested lattices/CRT for pilot design.”

**Already integrated in sketch.md**
- Chung–Erdős mentioned; waterfilling/majorization, lattices, pilots present.

**Rationale**
- Places union‑bound refinements on firm algebraic footing (cumulants) and ties to structural tools.

---

## Round 2 Refinements
- Add explicit placement: put cumulant truncation note either under Union Bound (primary) or cross‑reference Moments/Cumulants.
- Keep the Chung–Erdős formula inline for quick recall.

## Round 3 Finalization
- Final text to insert (Union Bound): “Two‑term refinement (Chung–Erdős): P(⋃ A_i) ≥ (Σ P(A_i))^2 / Σ_{i,j} P(A_i∩A_j). View refinements as cumulant truncations (Möbius inversion); Bonferroni = order‑k truncation.”
