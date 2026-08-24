# 4-submodular ↔ sketch.md

**Direct Mappings**
- Submodularity/curvature and greedy guarantees (`sketch.md`: Submodular, Synergy; Curvature).
- Cumulants vs higher‑order MI (`sketch.md`: Pairwise/Higher‑Order MI; Wick Pairings).
- Block‑decompose/diagonalize (`sketch.md`: Block‑Sum Multiplicativity; Schur complement).

**2×2 Comparison**
- Unique to 4-submodular.txt
  - Explicit MDL cascade with costs κ_t and gains ρ_t; stopping rules tied to context window budget.
- Unique to sketch.md
  - Broad matrix identities and immanant content not tied to MDL cascade.
- Common
  - Use submodularity as the backbone for selection; Gaussian truncation logic.
- Refinements to sketch.md
  - Add a small “MDL cascade” sidebar with H_{t+1} ≈ (1−ρ_t)H_t and a note on practical depths (2–3 layers) before diminishing returns.

