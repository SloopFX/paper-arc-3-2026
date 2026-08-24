# 7-permanent: Distillation and Organization

**Summary**
- Addresses computing permanents of principal submatrices (sub‑matchings), their complexity, and when structure helps. Contrasts with determinants of principal minors (friendly via Jacobi/Schur). Covers exact/approximate methods and structural shortcuts.

**Permanents: Complexity and Algorithms**
- #P‑complete in general (even 0–1 matrices). Standard exact methods: Ryser/Glynn inclusion–exclusion `O(k 2^k)` for k×k submatrices; practical up to k≈25–30.
- Many subpermanents: naive is 2^n; with per‑subset DP across restricted columns total cost ≈ O(n 3^n) (still exponential but far better than n!).
- Approximation: Jerrum–Sinclair–Vigoda FPRAS for nonnegative entries; belief‑propagation/Bethe permanent heuristics for broader cases.

**When Structure Helps (Exact)**
- Block‑upper‑triangular/reducible form ⇒ product of block permanents.
- Bounded treewidth graphs ⇒ dynamic programming over tree decompositions.
- Planar bipartite graphs are not generally Pfaffian for permanents (Pfaffians help for perfect matchings on general graphs, not bipartite‑permanent directly).

**Determinantal Minors: Friendly Side**
- Jacobi complementary minors: `det A[I,I] · det A^{-1}[I^c, I^c] = det A`.
- Schur complements + LU/LDLᵀ/Cholesky let you batch‑compute many principal minors efficiently.

**Engineering Guidance**
- Detect block/reducible structure and small k subblocks; exploit sparsity/treewidth; switch to approximations (Bethe/JSV) when needed.
- Cache subproblems with Gray‑order bitset iteration; use vectorized kernels for subset sums in Ryser/Glynn.

**Links to sketch.md**
- Immanants/matchings; log‑det updates; tests distinguishing det vs per; factor‑graph/Bethe approximations.

