# Outline

## Shorthands
- Immanants/objects: `imm`, `det`, `per`, `pf` (pfaffian), `haf` (hafnian); cumulants `cum`.
- Moments: `mom_k` for k-th order (e.g., `mom_0, mom_1, …`).

## Immanants and Related Objects
- Determinant, permanent, pfaffian, hafnian; matching interpretations.
- Immanant `Imm_χ` unifies `det` and `per` via symmetric‑group characters.

## Relations and Specializations
- `Imm_χ` → `det` when `χ = sgn`; `Imm_χ` → `per` when `χ ≡ 1`.
- Pfaffian vs determinant: for skew‑symmetric `A`, `pf(A)^2 = det(A)`.
- Block‑direct‑sum multiplicativity: `det(A1⊕A2)`, `pf(A1⊕A2)`, `haf(A1⊕A2)`, `per(A1⊕A2)` all factor as products over blocks.
- Bethe permanent; factor‑graph view of bipartite matchings.

## Moments and Cumulants
- Orders `0,1,2,3,…`; mixed moments; cumulant tensors.
- Gaussian case: orders ≥ 3 vanish; 2nd‑order closure (Wick).
- Hilbert‑space viewpoint for moments/cumulants when useful.

## Submodularity, Synergy, Diagonalization, Block Decomposition
- Submodular functions; diminishing returns; submodularity ratio; curvature.
- Synergy/interaction beyond additivity.
- Diagonalize when possible; block‑decompose to simplify objectives.

## Probability Bounds
- Union bound; inclusion–exclusion as needed.

## Matrix Identities and Spectral Principles
- Matrix determinant lemma; Schur complement factoring; Jacobi’s theorem.
- Majorization; flat spectra; waterfilling allocations.

## Stationary Measures
- Stationary processes and distributions; ergodicity; Toeplitz/BCCB structure under stationarity.

## Diagonalize Common Functionals
- Fisher information; KL divergence; VC dimension; Kendall’s tau.

## Log‑Det and Information Measures
- Fast/stable `log det` updates via det lemma.
- Curvature; pairwise MI; higher‑order MI; why long‑range effects cancel (cumulant decay).

## Normalization and Design
- Whiten; sphere; covering arrays (CAs); sequential CAs (SCAs).

## Quantization and Geometry
- Precision; quantization; spacetime coordinates; Riemannian viewpoints.

## Diagnostics/Tests
- Simple matrices/distributions to visually separate immanants, moment/cumulant behaviors, submodularity.

## Information‑Theoretic Certificates
- Fano certificate/how to compute; Fano inequality.
- Capacity; degrees of freedom (DoF); normal approximation (finite blocklength).

## Algebraic/Combinatorial Constructions for Pilots
- CRT; Singer difference sets; positional vs spectral pilots; absolute vs relative phase.
- Nested lattices; pilots as planar (non‑crossing) matchings.

## Wick Pairings; Kronecker/BCCB; Lempel–Ziv
- Wick pairings for Gaussian moments; Kronecker/BCCB diagonalization; Lempel–Ziv and compression‑based estimates.

## One‑Line Sketch; Dyadic Windows; Glimpse
- One‑line linear sketches; multiscale dyadic windows; adaptive “glimpses” for information‑efficient probing.

