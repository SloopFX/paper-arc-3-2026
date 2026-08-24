# 1-immanant: Distillation and Organization

**Summary**
- Clarifies the immanant family and its special cases (det, per), and the pfaffian/hafnian for skew/symmetric pairings. Relates to moments/cumulants, Gaussianity (Wick), and block‑decomposition. Provides guidance on when one reduces to another and how factor‑graph/Bethe views approximate permanents.

**Formal Definitions**
- Immanant (with class function χ on S_n): `Imm_χ(A) = Σ_{σ∈S_n} χ(σ) ∏_i a_{i,σ(i)}`.
- Determinant: χ = sign; Permanent: χ ≡ 1.
- Pfaffian (2m×2m skew A): pf(A)^2 = det(A); sums signed perfect matchings.
- Hafnian (2m×2m sym S): haf(S) = sum over perfect matchings without signs.

**Key Relations**
- Block direct sum: `det/pf/haf/per` multiply across blocks: `F(A1 ⊕ A2) = F(A1)F(A2)`.
- Gaussian closure: Cumulants of order ≥3 vanish; moments factor by Wick; many objectives become functions of second‑order structure (covariances/eigenmodes).
- Bethe permanent: approximate per(A) via BP on bipartite matching factor graph; exact on trees, heuristic on loopy graphs.

**Graph Viewpoints**
- per(A) counts perfect matchings of a bipartite graph (biadjacency A≥0); haf(S) counts perfect matchings of undirected graphs (adjacency S≥0).
- Pfaffian and planar matchings: with Kasteleyn orientations, |pf| equals matching count for planar graphs (FKT).

**Where One Becomes Another**
- Skew case: pf(A)^2 = det(A); Symmetric case: haf captures matchings while det captures volume/orientation.
- per as block‑hafnian: `per(C)=haf([[0,C],[C^T,0]])`.

**Practical Guidance**
- Detect and exploit block structure early; check planarity/low treewidth to enable pfaffian/dynamic‑programming accelerations.
- For general dense nonnegative matrices, use Bethe/permanent approximations or JSV FPRAS when applicable.

**Links to sketch.md**
- Immanants and matchings; block multiplicativity; Wick pairings; tests distinguishing det vs per vs haf/pf.

