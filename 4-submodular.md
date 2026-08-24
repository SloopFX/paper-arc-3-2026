# 4-submodular: Distillation and Organization

**Summary**
- Frames multi‑layer MDL coding of “source” (amplitude) and “phase” as a cascade that harvests mutual information at each layer. Uses submodularity to reason about diminishing returns and stopping criteria; relates to cumulant vs permanent/determinant viewpoints of dependency structure.

**Cascade Model**
- At layer t with unexplained entropy H_t, explain a fraction ρ_t (normalized MI between current source and phase); pay model cost κ_t.
- Dynamics: H_{t+1} ≈ (1−ρ_t) H_t and L_t ≈ κ_t + ρ_t H_t. Stop when marginal gain ≤ marginal cost or curvature becomes high.

**Submodularity and Curvature**
- Treat added lanes/tests as ground elements; objective f is submodular (e.g., entropy reduction). Greedy gives (1−1/e) with curvature/refinements via submodularity ratio.
- Curvature c in [0,1] bounds how far from modular; high c suggests few informative additions remain.

**Cumulants vs Matchings**
- Gaussian core: higher cumulants vanish; pairwise structure suffices (Wick). Beyond‑Gaussian structure can be probed with hafnian/permanent‑like counts or tests.
- Block decomposition/diagonalization helps isolate independent interactions where subproblems factor.

**Prefix‑Free MDL and Recursion Depth**
- Given a context window w (budget), depth is limited by Σ_t (κ_t + overhead_t) ≤ w and by diminishing ρ_t. Practical depth is small (2–3) when phases carry most dependence.

**Links to sketch.md**
- Submodularity/curvature; moments/cumulants; immanants/matchings; one‑line sketch & dyadic windows as selection primitives.

