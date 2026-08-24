# 4-submodular: Distilled Additions to sketch.md (Round 1)

**Proposed additions to sketch.md**
- MDL cascade (placement: Submodular, Synergy)
  - Add sidebar: “H_{t+1} ≈ (1−ρ_t)H_t; L_t ≈ κ_t + ρ_t H_t; stop when marginal gain ≤ marginal cost or curvature high.”
- Curvature/ratio usage (placement: Submodular, Synergy)
  - Add line: “Use curvature and submodularity ratio to adapt greedy guarantees under approximate submodularity.”

**Already integrated in sketch.md**
- MDL cascade note added; curvature and submodularity ratio present.

**Rationale**
- Provides a concrete stopping/selection heuristic linking coding budget to diminishing returns.

---

## Round 2 Refinements
- Ensure curvature definition `c` remains near the Submodular section; reference submodularity ratio `γ` for approximate cases.
- Add explicit stop condition text: “Stop when Δf/Δcost ≤ 1 or curvature c is high.”

## Round 3 Finalization
- Final text to insert (Submodular): “MDL cascade: H_{t+1}≈(1−ρ_t)H_t, L_t≈κ_t+ρ_t H_t; stop when Δgain/Δcost≤1 or curvature c high; use ratio γ when only approximately submodular.”
