# Toward a Cohesive Algebraic–Informational Blueprint

## Abstract
We present a unified blueprint connecting algebraic matrix functionals (immanants, determinants, permanents, pfaffians, hafnians) with probabilistic structure (moments, cumulants, submodularity), spectral methods for stationary processes, finite‑blocklength signal reliability, and a practical system design using pilots, dyadic windows, and snapshot protocols. The paper distills core identities and update rules (e.g., Schur, Woodbury, determinant lemma), clarifies complexity boundaries (e.g., #P‑completeness of permanents), and outlines actionable recipes that align learning‑time inference (masked attention) with factor‑graph message passing. We provide a compact test suite and integration plan that turn the sketch into a cohesive, verifiable artifact.

## 1. Overview
- Goal: build a single, principled document that bridges algebraic combinatorics, information theory, and practical learning systems.
- Pillars:
  1) Algebraic foundations: immanants, pfaffians/hafnians, and block‑sum multiplicativity.
  2) Probabilistic structure: moments/cumulants, submodularity, and union‑bound refinements.
  3) Spectral/stationary models: BCCB/Kronecker diagonalization and waterfilling/majorization.
  4) Finite‑n reliability: normal approximation/dispersion; time–bandwidth degrees of freedom (DoF).
  5) Systems: pilots (positional/spectral), dyadic windows/glimpses, snapshot protocols; masked attention ≈ BP.

### Validity Assumptions and Conventions
- Global conventions
  - Logs: base‑2 for rates/information unless stated; see Appendix O for conversions and notation.
  - Matrices/vectors are finite‑dimensional over R or C as appropriate; PSD/SPD refer to symmetric/Hermitian positive (semi)definite.
  - `⊕` denotes block‑diagonal direct sum; dimensions/types must match each functional’s domain.
- Algebraic preconditions
  - Pfaffian: defined for even‑order skew‑symmetric matrices only; counting perfect matchings via `|pf|` requires a Kasteleyn orientation and planarity (FKT). No such guarantee holds in general non‑planar graphs.
  - Hafnian: defined for even‑order symmetric matrices only. The identity `per(C) = haf([[0,C],[C^T,0]])` requires square `C`.
  - Multiplicativity across direct sums holds within compatible classes (det/pf/haf/per) on true block‑diagonal structure.
- Probabilistic structure
  - Cumulant truncations assume existence of corresponding moments; Gaussian closure beyond order 2 holds only under true Gaussianity (or Wick‑approximated regimes).
  - Submodularity claims refer to set functions; greedy guarantees assume nonnegativity/monotonicity with standard curvature/ratio refinements.
  - Heavy tails: if moments do not exist (e.g., α‑stable with α<2), cumulants beyond order ⌊α⌋ are undefined; prefer robust/quantile methods in place of cumulants.
- Stationarity/spectral claims
  - Exact diagonalization holds for circulant/BCCB; Toeplitz ≈ circulant is asymptotic or embedding‑based with boundary conditions explicitly handled.
  - Kronecker separability assumptions should be validated empirically; otherwise treat as approximation.
- Finite‑blocklength reliability
  - Normal approximation `R*(n,ε) ≈ C − √(V/n) Q^{-1}(ε)` applies under regularity (information density CLT) and moderate/large `n`; constants and units must match channel model (see references).
  - Wideband `Eb/N0 → ln 2` holds in energy‑limited, low‑rate limits; specify bandwidth and signaling model (real vs complex baseband).
- Systems mapping
  - “Masked attention ≈ BP” is a design heuristic: attention uses learned compatibilities/softmax; BP uses model‑derived factors and is exact only on trees.
  - “Assumptions at a Glance” subsections summarize constraints and intended regimes; they do not make additional claims beyond the main text.

## 2. Algebraic Foundations: Immanants, Matchings, Structure
- Immanant: `Imm_χ(A) = Σ_{σ∈S_n} χ(σ) ∏_i a_{i,σ(i)}`. Determinant and permanent arise from `χ=sgn` and `χ≡1`.
- Pfaffian/hafnian:
  - Pfaffian (skew `2m×2m`, even order only; odd order undefined): `pf(A)^2 = det(A)`; with a Kasteleyn orientation on planar graphs, `|pf|` equals the number of perfect matchings (FKT).
  - Hafnian (sym `2m×2m`, even order only; odd order ⇒ 0): sums products over pairings without signs.
  - Permanent–hafnian block lift: for square `C`, `per(C) = haf([[0,C],[C^T,0]])` where the lift `S` has zero diagonal and only cross‑pairs are valid; see Appendix A.4.
  - Pfaffian computation: stable O(n^3) methods (e.g., Gaussian‑elimination‑style reductions for skew‑symmetric matrices) exist; `pf(A)^2=det(A)` helps with magnitude but sign/orientation must be tracked.
  - Hafnian complexity: computing `haf(S)` is #P‑hard in general; no general FPRAS is known for arbitrary signed/complex matrices.
 - Pfaffian sign convention: the sign depends on vertex ordering/orientation; fix by choosing a reference matching/orientation and remain consistent (Kasteleyn orientation helps on planar graphs). For any permutation matrix `P`, `pf(P^T A P) = sgn(P)·pf(A)`.
- Permutation effects: `per(A)` is invariant under simultaneous row/column permutations (values relabel, value unchanged), whereas `pf(A)` flips sign under odd permutations of the vertex order; `|pf(A)|` and `pf(A)^2=det(A)` are permutation‑invariant.
 - Explicit invariance: for any permutation matrix `P`, `per(P^T A P) = per(A)`; entries are merely relabeled.
 - Magnitude relation: for real skew‑symmetric `A`, `det(A) ≥ 0` and `|pf(A)| = √det(A)`; the sign of `pf(A)` depends on the chosen orientation/order.
  - Weighted counts: `per` and `haf` aggregate weighted perfect matchings (not only 0–1 cases); entries act as edge weights.
  - References: see Schrijver (combinatorics) for pfaffian/hafnian identities and matching theory background.
  - References: see Schrijver (combinatorics) for pfaffian/hafnian identities and matching theory background.
- Permanent as block‑hafnian (square): for square `C`, `per(C)=haf([[0,C],[C^T,0]])` (see Appendix A.4).
  - Graph counting note: interpret adjacency/biadjacency with zero diagonal when using hafnian/permanent as weighted perfect‑matching counts.
- Block‑sum multiplicativity: for direct sums, `det/pf/haf/per` multiply across blocks.
- Domain recap: `pf` defined only for even‑order skew‑symmetric matrices; `haf` defined only for even‑order symmetric matrices (odd‑order symmetric ⇒ `haf=0`).
- Structure checklist: detect block sums; planar (Kasteleyn/|pf|) contexts; low treewidth (DP) — choose exact vs approximate accordingly.
 - Kasteleyn recipe (planar): orient edges so every finite face has an odd number of clockwise edges; with such an orientation, `|pf|` counts perfect matchings (FKT). Non‑planar graphs lack such a guarantee.
 - Hafnian counts weighted perfect matchings in symmetric graphs (no orientations involved); permanent counts matchings in bipartite graphs.
 - In planar graphs, changing vertex order/orientation may flip `pf(A)` but not `|pf(A)|` when a valid Kasteleyn orientation is used.
 - Graph view: `per` counts perfect matchings in bipartite graphs (biadjacency); `haf` counts perfect matchings in general symmetric graphs.

### Pass 1: Correctness and Scope (Immanants/Permanents)
- Scope clarity
  - Pfaffians enable counting perfect matchings in planar graphs via FKT under a Kasteleyn orientation. There is no analogous general (non‑planar) polynomial‑time method. They do not compute bipartite permanents in general; the per→haf block‑lift is the correct bridge for symmetric pairing sums.
  - Block‑sum multiplicativity holds for `det/pf/haf/per` on block‑diagonal direct sums of compatible types.
- Identity check
  - `per(C)=haf([[0,C],[C^T,0]])` holds for square `C`; the hafnian is defined only for even‑order symmetric matrices and the block‑lift relies on a bijection between rows and columns.
- Action taken
  - Kept the pfaffian planarity caveat explicit and separated the hafnian/permanent linkage. No changes required to sketch.md; content is consistent and precise.

## 3. Probabilistic Structure: Moments, Cumulants, Submodularity, Bounds
- Moments vs cumulants: cumulants are derivatives of log‑MGF; truncation at order 2 for Gaussian (Wick factorization).
- Submodularity: diminishing returns; curvature and submodularity ratio guide greedy selection.
 - Submodularity: diminishing returns; curvature and submodularity ratio guide greedy selection (see Das & Kempe for ratio‑based guarantees; cited in References).
- Union‑bound refinements: Chung–Erdős two‑term bound; view refinements as cumulant truncations (Möbius inversion); Bonferroni = order‑k.

Two‑term refinement (explicit)
- For events `{A_i}`, `P(⋃_i A_i) ≥ (Σ_i P(A_i))^2 / Σ_{i,j} P(A_i ∩ A_j)` when the denominator is finite and nonzero; use with care (non‑trivial overlaps required).

Bonferroni direction
- Odd‑order truncations yield upper bounds; even‑order truncations yield lower bounds, alternating around the true probability.

### 3.1 Submodularity Diagnostics (Definitions)
- Curvature `c ∈ [0,1]`: `c = 1 − min_{i∈V} (f(V) − f(V\setminus\{i\}))/(f(\{i\}) − f(∅))` for monotone `f`; smaller `c` strengthens greedy bounds.
- Submodularity ratio `γ ∈ [0,1]`: `Σ_{i∈B} Δ(i|A) ≥ γ·Δ(B|A)` for disjoint `A,B`; `γ=1` for truly submodular `f`. Greedy guarantees degrade with `γ`.

## 4. Stationarity and Spectral Organization
- Stationary processes: Toeplitz/BCCB covariances; diagonalize (exactly/approximately) via DFT; Kronecker for separable higher‑D.
- Waterfilling/majorization: spectral resource allocation under constraints; log‑det concavity on the SPD cone (see Appendix I for KKT derivation).
- Notation: for `⊕` (block sum) and `⊗` (Kronecker), see Appendix O (symbols/glossary).

Validity notes
- Toeplitz diagonalization is approximate (Szegő/embedding); circulant/BCCB diagonalization is exact and boundary‑condition dependent.
- Kronecker separability assumptions must be validated empirically; treat violations as modeling error.
- Szegő limit theorems justify eigenvalue distribution convergence for Toeplitz sequences; finite‑size edge effects persist.
- Windowing tradeoffs: taper choices (e.g., Hann/Hamming) affect spectral leakage and Toeplitz≈circulant accuracy; select windows to balance resolution and sidelobes.
 - Main‑lobe vs sidelobes: Hann widens the main lobe (≈2×) while strongly suppressing sidelobes; Hamming lowers the first sidelobe at a modest main‑lobe cost. Choose per resolution vs leakage needs.
- Boundary conditions: circulant embedding implies periodic wrap‑around; reflective/zero‑padding embeddings change eigenstructures and approximation error.
- Boundary–window match: choose boundary handling (periodic vs reflective/zero) to match the selected taper/window; mismatches bias spectral estimates.

Fourier conventions
- DFT/FFT normalizations vary (unitary vs engineering). Keep transforms consistent across diagonalization and inverse transforms to maintain correct power scaling.
- Unitary DFT (used here): for `x ∈ C^n`, `X_k = n^{−1/2} Σ_{t=0}^{n−1} x_t e^{−i 2π kt/n}` and `x_t = n^{−1/2} Σ_{k=0}^{n−1} X_k e^{+i 2π kt/n}`. The engineering DFT drops the `n^{−1/2}` factors (placing `1/n` in the inverse) and changes power scaling.
- Parseval (unitary DFT): `||x||_2^2 = ||X||_2^2`, so energy/power is preserved under the transform.
 - Library defaults: NumPy/SciPy FFT use engineering normalization by default; set `norm="ortho"` to obtain a unitary transform consistent with Parseval used here.
 - PyTorch: `torch.fft` accepts `norm` with the same semantics; use `norm="ortho"` to match the unitary convention adopted here.
 - Parseval (numeric n=4): let `x=[1,0,0,0]`. Under the unitary DFT, `X_k = 1/√4` for all `k`, so `||x||_2^2 = 1` and `||X||_2^2 = 4·|1/√4|^2 = 1`.
 - Phase convention: we adopt the forward/inverse exponents `e^{∓ i 2π kt/n}` (forward `−`, inverse `+`); mixing conventions breaks exact energy scaling.
- Toeplitz→circulant embedding: see Gray (2006) for constructions and error behavior.
- Scaling note: normalization affects spectral amplitude and thus DOF/rate numerics; ensure a consistent convention across all examples.
- Symbol regularity: Toeplitz asymptotics typically assume piecewise continuous symbols; see Grenander–Szegő theorems by name.
 - Example (symbol and eigenvalues): for Toeplitz matrices from autocorrelation `r[k]`, the symbol is `f(ω)=Σ_k r[k] e^{−ikω}`; eigenvalue histograms of `T_n(r)` converge to the distribution of `f(ω)` over `ω∈[0,2π)`.
 - Practical separability check: for Kronecker models, matricize/cross‑unfold the covariance and apply rank tests or low‑rank approximations as diagnostics.

Assumptions at a Glance (Stationarity)
- True stationarity (or sufficiently long records) for Toeplitz≈circulant arguments to hold.
- Appropriate boundary conditions and windowing chosen for the intended inference (bias/variance tradeoff).
- Separability tested rather than assumed when using Kronecker models.

## 5. Finite‑n Reliability and Degrees of Freedom
- Time–bandwidth degrees of freedom (DoF): ≈ `2Bt` real DoF over duration `t` and bandwidth `B`.
- Normal approximation (finite blocklength): `R*(n,ε) ≈ C − √(V/n) Q^{-1}(ε)`; dispersion `V` ties reliability to blocklength. Clarify that `Q^{-1}` is the Gaussian tail inverse and logs should be consistently base‑2 for rates in bits.
- Wideband limit: minimum `Eb/N0 = ln 2` (≈ −1.59 dB) in energy‑limited regimes.

Units and conditions
- Use bits/use with base‑2 logs for rates; convert nats ↔ bits via `log2 e` consistently when quoting `C` and `V`.
 - Bits/use vs bits/s/Hz: bits/use is per channel use; converting to spectral efficiency (bits/s/Hz) requires specifying symbol rate/bandwidth. See Appendix O for unit conversions.
- Normal approximation assumes finite variance of information density and standard regularity; accuracy improves with larger `n` and moderate `ε`.
 - Complex baseband: interpret `≈2Bt real DoF` as `≈ Bt` complex DoF over duration `t` and bandwidth `B`.
 - Dispersion `V` depends on both the channel model and the input distribution; canonical closed‑forms assume capacity‑achieving inputs (e.g., Gaussian for AWGN).
 - Eb/N0 comparability: always state the spectral efficiency (bits/s/Hz) or bandwidth/signaling assumptions when quoting `Eb/N0`; numbers are not comparable otherwise.
 - PSD conventions: specify whether power spectral densities are one‑sided or two‑sided; SNR/Eb/N0 formulas depend on this choice and on real vs complex baseband.
 - Numeric example: with spectral efficiency `η = 2` bits/s/Hz and `SNR = 10` (linear), `Eb/N0 = SNR/η = 5` (≈ 6.99 dB).

Bounds (achievability and converse)
- RCU (Random Coding Union) bound: sharpen finite‑n achievability beyond the normal approximation; see Polyanskiy–Poor–Verdú (2010) for exact forms.
- Meta‑Converse: provides tight converse (impossibility) bounds in the same regime.
- Rule‑of‑thumb: for small `n` or extreme `ε`, prefer RCU/meta‑converse; for moderate `n, ε`, the normal approximation is often accurate.
 - Applicability: both RCU and meta‑converse require knowledge of the channel law; use when a parametric/stationary model is available.
 - Typical regime split: normal approximation tends to be accurate for `n ≳ 10^3` and `ε ∈ [10^{-3}, 10^{-1}]` (model‑dependent); otherwise use non‑asymptotic bounds.

Assumptions at a Glance (Finite‑n)
- Capacity‑achieving inputs when quoting canonical `C` and `V`; otherwise compute under the actual input.
- Rates in bits/use unless stated (convert nats consistently).
- For very small `n` or extreme `ε`, rely on non‑asymptotic bounds (RCU/meta‑converse) rather than the normal approximation.

## 6. Permanents in Practice: Complexity and a Toolbox
- Complexity: computing permanents is #P‑complete (even for 0–1). Exact is feasible only for small `k` (Ryser/Glynn `O(k 2^k)`).
- Many subpermanents: per‑subset DP yields `O(n·3^n)` total for principal subpermanents (still exponential, but practical in low 20s).
 - Structure helps: block/reducible form ⇒ product; bounded treewidth ⇒ DP; JSV FPRAS for nonnegative matrices (ε‑relative approximation in time poly(n,1/ε) with high probability; does not extend to arbitrary signed/complex entries); Bethe/loopy BP heuristics otherwise.
 - Caution (JSV scope): the Jerrum–Sinclair–Vigoda FPRAS applies only to nonnegative matrices; it is not defined for signed or complex inputs.
- Implementation notes: Gray‑order bitsets with Ryser/Glynn for cache locality; use 64‑bit words (or wider SIMD) for subset masks; use compensated summation to reduce cancellation; memory `O(n 2^n)`; detect structure early. Update row sums in O(n) per Gray‑order step by toggling one column’s contribution across all rows; see Appendix T for details.
  See Appendix T.4 for a compact compensated‑summation snippet for the outer accumulator.
 - Numeric range: integer accumulators overflow quickly under inclusion–exclusion; prefer `float64`/extended precision with scaling or log‑sum‑exp techniques for larger `k`.
 - Streaming/memoization: when only selected sizes or subsets are needed, stream computations and memoize reusable subproblems to keep peak memory well below `O(n 2^n)`.
 - Mask width: for `k > 64` columns, chunk masks across multiple machine words (or use dynamic bitsets) and vectorize updates; avoid serializing toggles.
 - Treewidth: exact DP on graphs of treewidth `w` scales roughly as `poly(n)·α^w` for constant α (model‑dependent); exploit sparsity/structure to keep `w` small.
 - JSV intuition: uses rapidly mixing Markov chains and importance sampling to approximate permanents of nonnegative matrices.

## 7. System Design: Pilots, Glimpses, and Snapshot Protocols
- Pilots and invariants
  - Lane kit: base serialization; sync string; hierarchical coordinates; row/col/window parities; object‑level invariants; CRC.
  - Interleaving: de‑Bruijn/PRN scheduling to decorrelate constraints and realize waterfilling.
  - Mixed‑radix, disjoint alphabets: separate per lane/scale to avoid collisions.
- Glimpses and dyadic windows: multiresolution budgeted attention; select windows via submodular/curvature criteria.
- Snapshot protocols: prefix‑free IDs; hashing; delta caches; maintain Cholesky/LDLᵀ factors for rank‑k det lemma/Woodbury updates.

Validity and implementation notes
- Lane kit items (sync strings, parities, CRC) are illustrative patterns, not a fixed spec; adapt to domain constraints and failure models.
- Glimpse selection typically assumes a monotone submodular objective under a budget; when violated, use `γ`/curvature diagnostics to qualify greedy results.
- Numerical updates: ensure SPD conditions for Cholesky downdates; when violated, fall back to refactorization or pivoted LDLᵀ.
- Interleaving: de‑Bruijn/PRN schedules must respect latency and memory; verify that scrambling does not collide with pilot lanes or regulatory constraints.

## 8. Inference: Factor Graphs and Masked Attention (Decoding Intuition)
- Factor graph: variable nodes for assignments `(i→j)` and constraint factors; exact on trees; BP on loopy graphs yields Bethe approximations.
- Decoding intuition: masked attention with graph‑aligned masks approximates parallel BP; a depth‑`T` stack approximates `T` message‑passing rounds (heuristic correspondence).
 - Practical: damping and schedule (e.g., residual BP) often improve convergence on loopy graphs; calibrate temperature/softmax sharpness when mapping to attention.
 - Pointer: stationary points of Bethe free energy (with local entropy correction `(d_i−1)`) match loopy BP fixed points (see Appendix N.1–N.3).

### Pass 3: Correctness and Framing (Masked Attention ≈ BP)
- Framing
  - Treat attention↔BP as a decoding intuition requiring mask/topology alignment and suitable nonlinearities/normalization; it is not a general equivalence claim.
- Minimal mapping
  - Variable–factor adjacency induces a block‑sparse attention mask; a layer applying masked softmax on messages, followed by residual mixing, acts like a parallel message‑update step.
- Action taken
  - Kept the statement explicitly heuristic and added a minimal mapping note. Sketch.md already frames this as intuition; no further back‑prop needed.

## 9. Learning Geometry: Degenerate Fisher and Remedies
- Degenerate Fisher (singular models): classical χ²/BIC asymptotics fail; rely on singular learning theory (real log canonical threshold, RLCT); operate on identifiable subspaces.
- Remedies: reparameterize/quotient symmetries; add informative priors/penalties; constrain architectures; use profile likelihood; whiten identifiable directions.
 - RLCT note: RLCT is typically a rational number; see Watanabe (2009) for theory and examples.

## 10. Tests and Diagnostics
- Algebraic contrasts: 2×2 matrix `[[a,b],[c,d]]` shows `det=ad−bc` vs `per=ad+bc` (off‑diagonal sign flip).
- Pfaff vs haf: 4×4 skew‑sym vs sym adjacency; pfaff parity sensitivity vs haf unsigned sum.
  - For the 4×4 skew‑sym `K` in Appendix M.2 with `pf(K)=8`, verify `det(K)=pf(K)^2=64`.
  - Pfaff sign flip: apply an odd permutation to the vertex order of `K` and verify `pf` negates while `det` and `|pf|` stay the same.
- Log‑det update: compare exact recompute to rank‑1 determinant‑lemma/Cholesky update for stability and speed.
- Higher‑order MI: XOR triplet (zero pairwise MI; positive 3‑way interaction) vs Gaussian triplet.
- Odd‑order check: verify `haf(S)=0` for any odd‑order symmetric adjacency (`no` perfect matchings) and note pfaffian undefined for odd sizes.
 - Block‑lift per→haf (2×2): choose another `C` (e.g., `[[2,1],[5,3]]`), build `S=[[0,C],[C^T,0]]`, and verify `haf(S)=per(C)`.
- Block‑sum multiplicativity: build two small blocks and verify `det/pf/haf/per` of the direct sum equals the product of block values.
 - Block‑sum multiplicativity (numeric): let `A1=[[1,2],[0,3]]`, `A2=[[4,0],[5,6]]`. Then `det(A1)=3`, `det(A2)=24`, and `det(A1 ⊕ A2)=3·24=72`; similarly verify `per/pf/haf` as domains allow.
 - Permanent invariance under relabeling (3×3): let `C=[[1,2,0],[0,3,4],[5,0,6]]` and let `P` swap columns 1↔3. Verify `per(C)=per(CP)` while terms reorder.
- 3×3 hafnian zero (numeric): let `S = [[0,1,2],[1,0,3],[2,3,0]]`; any pairing leaves one vertex unmatched ⇒ `haf(S)=0`.
- Negative‑entry illustration (2×2): `A=[[1,−2],[3,4]]` gives `det=1·4 − (−2·3) = 10`, `per=1·4 + (−2·3) = −2` (sign effects).
 - Diagonal case (2×2): `A=diag(a,d)` gives `det=per=ad` (off‑diagonals 0).
 - Waterfilling (2‑mode): `λ=[4,1]`, `P=1` ⇒ both active, `μ=1.125`, `p=[0.875,0.125]`, sum‑rate `≈ 2.339` bits/use (see Appendix I for KKT and Appendix T.2 for bisection).
 - Parseval (n=4): let `x=[1,0,0,0]`. Under the unitary DFT, `||x||_2^2 = ||X||_2^2 = 1` (mirrors §4 Fourier conventions).

Mini procedure (manual checks)
- Choose small integer matrices (2×2 or 4×4) for clarity.
- Compute `det` vs `per` on `[[a,b],[c,d]]` to see off‑diagonal sign flip.
- For pfaff/haf, use `K` skew‑sym and `S` sym with zero diagonal; apply the provided closed‑form 4×4 formulas.
- For block sums, form `A1 ⊕ A2` and verify multiplicativity numerically.

## Appendix A: Proof Sketches and Worked Examples (Pass 4)

### A.1 Determinant Lemma and Woodbury
- Sylvester’s identity: `det(I + AB) = det(I + BA)` for conformable `A,B`. Proof: `I+AB` and `I+BA` share the same nonzero eigenvalues (including multiplicity); alternatively expand characteristic polynomials or use block determinant factorization of `[[I, A],[−B, I]]`.
  Eigenvalue view (one‑liner): `I+AB` and `I+BA` have identical nonzero eigenvalues, so their determinants match.
- Determinant lemma: with invertible `A`, set `A^{-1}U` as `A` and `V^T` as `B` to get
  `det(A + U V^T) = det(A) det(I + V^T A^{-1} U)`.
  Singular case: the multiplicative identity requires invertible `A`; for singular `A`, use regularization or pseudo‑determinants with care.
- Woodbury identity: `(A + U C V^T)^{-1} = A^{-1} − A^{-1} U (C^{-1} + V^T A^{-1} U)^{-1} V^T A^{-1}` (invertible `C`).
- Rank‑1 log‑det update: `log det(A + u v^T) = log det(A) + log(1 + v^T A^{-1} u)`.
  Implementation tip: use `log1p` for small `v^T A^{-1} u` to improve numerical stability.
 - Rank‑k log‑det update (via determinant lemma): `log det(A + U V^T) = log det(A) + log det(I + V^T A^{-1} U)` when `A` is invertible.
- Numeric check (2×2): Take `A=[[2,0],[0,3]]`, `u=[1,2]^T`, `v=[1,−1]^T`. Compute `v^T A^{-1} u = [1,−1] [[1/2,0],[0,1/3]] [1,2]^T = 1/2 − 2/3 = −1/6`. Then `log det(A+uv^T) = log(6) + log(1 − 1/6) = log(6·5/6) = log 5` matches direct evaluation.

### A.2 Schur Complement and Jacobi’s Complementary Minors
- Block determinant: for `A = [[A11, A12],[A21, A22]]` with `A11` invertible,
  `det(A) = det(A11) det(A22 − A21 A11^{-1} A12)`.
- Jacobi’s complementary minor identity: for index set `I`, `det A[I,I] · det A^{-1}[I^c, I^c] = det A`.
  Proof sketch: apply Cramer’s rule to `A A^{-1} = I` and compare principal minors; or use Schur complements iteratively.
  SPD property: if `A` is SPD and `A11` is SPD, then the Schur complement `S = A22 − A21 A11^{-1} A12` is SPD; conversely, `A` is SPD iff both `A11` and `S` are SPD.

### A.3 Direct‑Sum Multiplicativity
- For block‑diagonal `A1 ⊕ A2`, multiplicativity is immediate for `det` by definition and for `per` by independence of permutations on disjoint index sets. For `pf` (skew‑symmetric, even order) and `haf` (symmetric, even order), pairings split across blocks; crossing pairs do not form valid blockwise matchings, so sums factor (if any symmetric block is odd‑order, its hafnian is 0, yielding a zero product).

### A.4 Permanent as Block‑Hafnian
- Let `C` be `n×n` (square). Build the symmetric lift `S=[[0,C],[C^T,0]]` of size `2n×2n` (diag(S)=0; only cross‑pairs between the two sides are valid). A perfect matching in the graph of `S` selects only cross‑pairs between the two parts and thus corresponds to a bijection of rows to columns of `C`; each matching contributes exactly one product term from `per(C)`. Therefore `haf(S) = per(C)`.

Numeric example (2×2)
- Let `C = [[1,2],[3,4]]`. Then `per(C) = 1·4 + 2·3 = 10`.
- Build `S = [[0, 0, 1, 2], [0, 0, 3, 4], [1, 3, 0, 0], [2, 4, 0, 0]]`.
- Hafnian pairs (4×4): `(1,2)(3,4)` contributes `0·0 = 0`; `(1,3)(2,4)` contributes `1·4 = 4`; `(1,4)(2,3)` contributes `2·3 = 6`.
- Sum `haf(S) = 0 + 4 + 6 = 10 = per(C)`.
Note on construction
- The diagonal of `S` is zero and only cross‑pairs between the two sides are valid; there are no within‑side matches in the lift.

### A.5 XOR and Higher‑Order Information
- Let `X,Y` be independent fair bits; `Z = X ⊕ Y`. Then `I(X;Y)=I(X;Z)=I(Y;Z)=0`, but `I(X,Y;Z)=1` bit and the interaction information (co‑information) is `I(X;Y;Z)=I(X;Y) − I(X;Y|Z) = −1` bit, indicating pure synergy.

### A.6 Dispersion as Variance of Information Density (AWGN Note)
- Dispersion is the variance of the information density: `V = Var[i(X;Y)]`, with `i(X;Y) = log p_{Y|X}(Y|X) − log p_Y(Y)`. For the real AWGN channel with SNR `ρ` and Gaussian input, capacity is `C = 0.5 log(1+ρ)` (nats/use) and the dispersion in nats²/use is `V = (ρ(ρ+2))/(2(ρ+1)^2)`. In bits²/use multiply by `(log2 e)^2`. See Polyanskiy–Poor–Verdú (2010) for derivations and exact conditions.


## 11. Integration Plan (Condensed)
- Algebraic core: immanants, pfaff/haf identities; structure checklist.
- Probabilistic core: cumulant truncations; submodular selection; union‑bound refinements.
- Spectral core: BCCB/Kronecker diagonalization; waterfilling/majorization.
- Finite‑n core: normal approximation; DoF; wideband limit.
- System core: pilots/glimpses; snapshot protocols; masked attention ≈ BP.
- Toolbox: permanents; Schur/Woodbury/det lemma; small tests for sanity.

## 12. Discussion and Outlook
This blueprint connects traditionally separate toolkits: algebraic combinatorics, probabilistic structure, spectral methods, and modern learning systems. The main practical message is structural detection early (block sums, planarity, treewidth), numerically stable updates (rank‑k with stored factors), and information‑efficient measurement (pilots/glimpses, submodular selection). The suggested tests and recipes provide quick verification loops and guardrails for deployment.

## Appendix H: Section Map to Sketch (Layer Alignment)

- Paper §2 Algebraic Foundations ↔ Sketch: “Immanants, Determinant, Permanent, Pfaffian, Hafnian, Matchings” and “Block‑Sum Multiplicativity.”
- Paper §3 Probabilistic Structure ↔ Sketch: “Moment Orders … and Cumulants,” “Submodular …,” and “Union Bound …”.
- Paper §4 Stationarity/Spectral ↔ Sketch: “Stationary Measures,” “Matrix Determinant Lemma …” (waterfilling/majorization), “Wick Pairings; Kronecker/BCCB; Lempel–Ziv.”
- Paper §5 Finite‑n/DoF ↔ Sketch: “Log‑Det Updates … (finite‑blocklength note)” and “Precision, Quantization, Spacetime … (DoF).”
- Paper §6 Permanents Toolbox ↔ Sketch: “Matrix … (Permanent toolbox)” and tests.
- Paper §7 System Design ↔ Sketch: “CRT, Singer … Pilots …” and “One‑Line Sketch; Dyadic Windows; Glimpse.”
- Paper §8 Inference Mapping ↔ Sketch: “When One Becomes Another … Factor Graphs (decoding intuition).”
- Paper §9 SLT ↔ Sketch: “Diagonalize Fisher … (singular models note).”
- Paper §10 Tests ↔ Sketch: “Tests to Separate …”.
- Paper §11 Integration ↔ Sketch: “Integration Plan and Contributions.”
 - New: Appendix T (Permanent Formulas) is standalone; probabilistic/finite‑n sections include “Assumptions at a Glance”.
 - How to cite Appendix T: Ryser (1963) and Glynn (2010); see References entries for exact citations.
 - Locator: Assumptions at a Glance (Stationarity) — see §4 “Assumptions at a Glance (Stationarity)”.
 - Locator: Assumptions at a Glance (Finite‑n) — see §5 “Assumptions at a Glance (Finite‑n)”.
 - Appendix O: Symbols (glossary) provides operator and units conventions (`⊕`, `⊗`, bits↔nats, SNR dB↔linear) referenced throughout.

## References (selected)

- Sylvester’s determinant identity; Woodbury matrix identity; Schur complement; Jacobi’s complementary minors (standard linear algebra texts).
- Kasteleyn; Temperley–Fisher: planar perfect matchings and Pfaffian orientations (dimer models).
- Szegő’s limit theorems: asymptotics of Toeplitz determinants.
- Grenander, U.; Szegő, G. (1958): Toeplitz Forms and Their Applications.
- Gray, R. M. (2006): Toeplitz and Circulant Matrices: A Review.
- Polyanskiy, Poor, Verdú (2010): Channel coding rate in the finite blocklength regime (normal approximation/dispersion).
- Nemhauser, Wolsey (1978+): Analysis of the greedy algorithm for submodular set functions; curvature and recent ratio generalizations.
- Jerrum, Sinclair, Vigoda (2004): Polynomial‑time approximation algorithm for the permanent of nonnegative matrices (FPRAS).
- Ryser (1963); Glynn (2010): Permanent formulas (inclusion–exclusion variants) and practical refinements.
- Watanabe, S. (2009): Algebraic Geometry and Statistical Learning Theory.
- Wainwright, M. J.; Jordan, M. I. (2008): Graphical models, exponential families, and variational inference.
 - Golub, G. H.; Van Loan, C. F. (2013): Matrix Computations (4th ed.).

## Appendix T: Permanent Formulas (Ryser and Glynn)
- Ryser’s formula (square `A ∈ R^{n×n}`):
  `per(A) = (−1)^n Σ_{S⊆[n]} (−1)^{|S|} ∏_{i=1}^n Σ_{j∈S} a_{ij}`
  Complexity `O(n 2^n)` with Gray‑order enumeration; use compensated summation to mitigate cancellation.
  Gray‑order Δ‑update: maintain row sums `r_i = Σ_{j∈S} a_{ij}`. When toggling a single column `j*` (entering/leaving `S`), update all rows by `r_i ← r_i ± a_{ij*}` in `O(n)`; the product term `∏_i r_i` then updates in `O(n)` or via a maintained product with care for zeros.
  Zero‑safe product: maintain a `zero_count = |{ i : r_i = 0 }|`. If `zero_count > 0` the product is zero. When a toggle changes some `r_i` to/from zero, adjust `zero_count`; if it crosses 0↔1, recompute the full product once to re‑establish correctness.
  Pseudocode (zero‑safe product)
  ```
  prod = 1; zero_count = count_i(r[i]==0)
  for each Gray-toggle of column j*:
    for i in 1..n:
      old = r[i]
      r[i] += sign * A[i,j*]  // sign ∈ {+1,−1}
      if old==0 && r[i]!=0: zero_count -= 1
      if old!=0 && r[i]==0: zero_count += 1
    if zero_count>0:
      term = 0
    else if zero_count==0 and (crossed 0↔1 on any i):
      prod = Π_i r[i]   // full recompute once
      term = prod
    else:
      // update prod multiplicatively if tracked per‑row
      term = Π_i r[i]
    per += parity * term
  ```
- Glynn’s formula:
  `per(A) = 2^{1−n} Σ_{ε∈{±1}^n} (∏_{i=1}^n ε_i) ∏_{j=1}^n Σ_{i=1}^n ε_i a_{ij}`
  Also `O(n 2^n)`, amenable to Gray‑order over `ε`.
- Notes: choose formula based on data layout/cache; both benefit from Gray‑order to update inner sums with `O(n)` row‑sum changes per step.

## Appendix Q: Related Work and Connections (Pass 19)
- Graphical models and variational inference: Wainwright & Jordan (2008) survey BP, Bethe, and variational approximations; connects our Bethe permanent and masked‑attention intuition.
- Information theory: Cover & Thomas (2006) for capacity, waterfilling; Polyanskiy–Poor–Verdú (2010) for finite blocklength.
- Convex optimization: Boyd & Vandenberghe (2004) for KKT and waterfilling derivations and Schur complements.
- Submodularity: Nemhauser & Wolsey (1978) classic greedy bound; recent curvature/ratio refinements (Conforti & Cornuéjols; Das & Kempe).
- Permanents and matchings: Valiant (1979) #P‑completeness; Jerrum–Sinclair–Vigoda (2004) FPRAS; Schrijver’s combinatorics texts.
- Toeplitz and asymptotics: Szegő limit theorems; Gray (2006) on Toeplitz and circulant approximations.
 - Cross‑link: see Appendix N.1 for the Bethe free‑energy expression and the BP fixed‑point correspondence (with degree correction `(d_i−1)`).

## 13. Limitations and Future Work
- Formal approximation guarantees: beyond the classical submodular/greedy results and JSV for permanents, many heuristics (Bethe/loopy BP, masked attention ≈ BP) lack universal guarantees; characterizing regimes of reliability is open.
- Numerical stability at scale: extending rank‑k update pipelines to mixed‑precision hardware and streaming settings invites additional care (pivoting, re‑factorization schedules).
- Richer invariants as pilots: group‑theoretic invariants (e.g., characters/harmonics) embedded as spectral pilots may further improve identifiability; formal tradeoffs between rate and robustness remain to be developed.

## Appendix O: Notation and Conventions (Pass 17)
- Logs: base‑2 for rates/information unless stated; natural logs used for some matrix identities (convert via `log2 x = (1/ln 2) ln x`).
- DoF: “≈ 2Bt real DoF” refers to real baseband; for complex baseband, interpret accordingly.
- Inner products and traces: standard Euclidean/Frobenius; PSD cone means symmetric positive semidefinite matrices.
- Expectations/variances over distributions are with respect to the specified model; information density in nats unless converted.
- Empty sizes: `det([])=per([])=pf([])=haf([])=1` by convention (empty product), matching multiplicativity under direct sums.
- Odd sizes: for symmetric odd‑order matrices viewed as graphs, `haf` equals 0 (no perfect matchings); `pf` is undefined for odd order.
 - Complex vs real: for pfaffians we use transpose `A^T = −A` (skew‑symmetric) over R or C; conjugate symmetry (skew‑Hermitian) is a different notion and not used in pfaffian identities.

Quick units/conversions
- Bits↔nats: `x` nats = `x·log2 e` bits; `x` bits = `x·ln 2` nats. Example: `1` nat `≈ 1/ln 2 ≈ 1.4427` bits.
- SNR: `ρ_dB = 10 log10 ρ`, so `ρ = 10^{ρ_dB/10}`. For `Eb/N0`, the same relation holds on the ratio in linear units.

Numeric stability
- Prefer `log1p(x)` and `expm1(x)` when `|x|` is small to reduce cancellation in log/exp transforms.
 - Compensated summation: use Kahan or Neumaier schemes for long alternating sums (e.g., Ryser/Glynn accumulators in §6 and Appendix T) to control rounding error.

Symbols (glossary)
- `⊕` block‑diagonal direct sum of matrices.
- `⊗` Kronecker (tensor) product.
 - `diag(·)` diagonal matrix formed from its argument; `diag(A)` extracts the diagonal of `A`.
 - `Tr(·)` trace (sum of diagonal entries).
 - `||·||_2` Euclidean (ℓ2) norm; appears in Parseval’s identity under the unitary DFT.

`⊕` example
- If `A1 = diag(a_1,a_2)` and `A2 = [b]`, then `A1 ⊕ A2 = diag(a_1,a_2,b)` (a 3×3 block‑diagonal matrix).

## Appendix P: Schur Functions and Karamata (Pass 18)
- Majorization `x ≺ y` iff partial sums of sorted components of `x` are dominated by those of `y` and totals match.
- Karamata’s inequality: for convex `φ`, `Σ φ(x_i) ≤ Σ φ(y_i)` when `x ≺ y` (reverse for concave `φ`).
- Schur‑convex/concave functions: symmetric functions increasing/decreasing under majorization; `log det` for SPD matrices is Schur‑concave in eigenvalues, aligning with waterfilling intuition (uniform spectra maximize `log det` under trace constraints).
## Appendix I: Waterfilling via KKT and Majorization (Pass 11)
Consider parallel Gaussian modes with gains/eigenvalues `λ_i ≥ 0` and power allocation `p_i ≥ 0` under `Σ_i p_i ≤ P`. Maximize sum‑rate (nats/use)
`maximize Σ_i log(1 + λ_i p_i)` subject to `p_i ≥ 0`, `Σ_i p_i ≤ P`.
Units and conventions
- Total power `P` is per channel use; noise spectral density `N0` is per (real) dimension unless otherwise specified. For spectral‑efficiency `η` (bits/use), relate `Eb/N0` and SNR in linear units via `Eb/N0 = SNR / η`.
 - Base: the objective uses natural logs (nats). Convert to bits by dividing by `ln 2`; see Appendix O for units/conversions.

KKT conditions
- Lagrangian `L(p,μ,ν) = −Σ_i log(1+λ_i p_i) + μ(Σ_i p_i − P) − Σ_i ν_i p_i` with `μ,ν_i ≥ 0`.
- Stationarity: `∂L/∂p_i = −λ_i/(1+λ_i p_i) + μ − ν_i = 0`.
- Complementary slackness: `μ(Σ_i p_i − P)=0`, `ν_i p_i=0`.

Solution (waterfilling)
- If `p_i>0` then `ν_i=0` and `μ = λ_i/(1+λ_i p_i)` ⇒ `p_i = μ^{−1} − 1/λ_i`.
- Enforce `p_i = max(0, μ^{−1} − 1/λ_i)` with `μ` chosen so `Σ_i p_i = P`.

Numeric example (2 modes)
- Let `λ=[4,1]`, `P=1`. With `1/λ=[0.25,1]`, both modes are active. Solve `(μ−0.25)+(μ−1)=1` ⇒ `μ=1.125`. Then `p=[0.875,0.125]` and the rate is `Σ log2(1+λ_i p_i) ≈ 2.339` bits/use.
- Bisection note: find `μ` by bisection on `g(μ)=Σ_i max(0, μ−1/λ_i)−P` (Appendix T.2 has a skeleton).

Majorization view
- Sorting `1/λ_i` ascending, the vector of allocated powers `p` is Schur‑concave in the noise levels; waterfilling equalizes effective marginal utilities and aligns with `log det` Schur‑concavity in eigenvalues (Appendix P).

## Appendix R: Computational Pipeline (ASCII) (Pass 20)

## Appendix S: Related Systems — LDPC/Turbo and Attention (Pass 21)

### S.1 LDPC and Turbo Codes
- LDPC: sparse parity‑check matrix defines a bipartite factor graph; sum–product (BP) decoding exchanges messages along edges, approximating posterior marginals.
- Turbo: concatenated convolutional codes with interleavers; iterative BCJR (forward–backward) decoding exchanges extrinsic information between component decoders.

### S.2 Attention as Message Passing (Heuristic)
- Block‑sparse attention masks aligned with factor adjacency implement per‑edge weighting akin to BP messages; layer stacking mimics multiple iterations.
- Differences: attention uses learned compatibility (via dot‑products) and normalization (softmax), whereas BP uses model‑derived factors and exact marginalization on trees. The mapping is conceptual but useful for system design and training objectives.

```
Sources → [Dyadic Windows] → [Glimpse Selector]
          (multiscale)        (submodular w/ curvature)
                      ↓
             [Pilots/Lanes]
             (positional/spectral; mixed‑radix)
                      ↓
              [Snapshotter]
        (IDs, hashes, delta caches)
                      ↓
          [Numerical Summaries]
       (Cholesky/LDLᵀ; rank‑k updates
        via det lemma/Woodbury)
                      ↓
            [Inference Engine]
      (Factor graph BP; masked
       attention with sparse masks)
                      ↓
                 [Decisions]
       (Tests; diagnostics; MI checks)
```

## Appendix J: Rank Correlations in Elliptical Families (Pass 12)

## Appendix K: Nested Lattices (Construction A) for Coding/Shaping (Pass 13)

## Appendix L: VC Dimension and Sample Complexity (Pass 14)

## Appendix M: Numeric Examples (Pass 15)

### M.1 Permanent Invariance Under Relabeling (3×3)
- Let `C = [[1,2,0],[0,3,4],[5,0,6]]`. Its permanent is `per(C) = 1·3·6 + 2·4·5 = 18 + 40 = 58`.
- Let `P` swap columns 1↔3. Then `CP = [[0,2,1],[4,3,0],[6,0,5]]`.
- Compute `per(CP) = 0·3·5 + 2·0·6 + 1·4·0 + 0·0·1 + 2·4·5 + 1·3·6 = 0 + 0 + 0 + 0 + 40 + 18 = 58`.
- Thus `per(C) = per(CP)` while terms reorder; invariance holds under simultaneous row/column permutations (values relabel, value unchanged).

## Appendix N: Bethe Free Energy and Permanents (Pass 16)

## Appendix T: Pseudocode Skeletons (Pass 22)

## Appendix U: Error Exponents and RCU Bound (Pass 23)

## Appendix V: Cholesky Updates and Stability (Pass 24)
- For SPD `A = L L^T`, rank‑1 update `A + u u^T` updates `L` via Givens/Householder; downdate `A − u u^T` requires `A − u u^T` to remain SPD (check `||L^{-1} u||_2 < 1`).
- Pivoting strategies and periodic re‑factorization mitigate numerical drift; in streaming pipelines, maintain thresholds on condition number and refactor when exceeded.
- References: Golub & Van Loan; Gill, Murray & Wright for numerical optimization implementations.
 - Tiny numeric downdate check (2×2): let `A = diag(2,2)` with Cholesky `L = diag(√2, √2)`. For `u = [0.5, 0.5]^T`, `L^{-1} u = [0.5/√2, 0.5/√2]` so `||L^{-1} u||_2 ≈ 0.5 < 1` and `A − u u^T` remains SPD. For `u = [1.5, 0]^T`, `||L^{-1} u||_2 ≈ 1.0607 > 1`; reject the downdate and refactor.

## Appendix W: Fisher in Exponential Families (Pass 25)
- Exponential family: `p_η(x) = h(x) exp( η^T T(x) − A(η) )`; Fisher `I(η) = Var_η[T(X)]`.
- Orthogonalization/whitening of sufficient statistics diagonalizes `I(η)` locally; in generalized linear models, link functions define natural parameters.
- In identifiable subspaces, principal components of `I` (e.g., eigenvectors) define decorrelated directions for optimization and uncertainty quantification; relates to natural gradient methods.

## Appendix X: Spectral Theorems — Wiener–Khinchin and Coherence (Pass 26)
- Wiener–Khinchin: the PSD is the Fourier transform of the autocovariance; for stationary processes, this links time and frequency representations.
- Cross‑spectral density `S_{XY}(f)` defines coherence `|S_{XY}(f)|^2/(S_{XX}(f) S_{YY}(f))`, measuring linear dependence by frequency.
- Multivariate: spectral density matrix `S(f)` diagonalizes by frequency; log‑det integrals of `S(f)` yield capacity‑like functionals and connect to majorization.

## Appendix Y: Covering Arrays and Sequential Construction (Pass 27)
- Covering array `CA(N; t, k, v)`: every choice of `t` columns contains all `v^t` tuples at least once.
- Greedy/IPO: iteratively add rows/columns minimizing uncovered tuples; randomized local search (Glauber‑type) improves compactness.
- Sequential CAs: add tests online while maintaining `t`‑wise coverage; useful for growing pilot sets and incremental exploration under budget.

### U.1 Random‑Coding Error Exponent (Sketch)
- Gallager’s `E_r(R)` lower bounds the best achievable error exponent for rates below capacity: `P_e ≲ e^{−n E_r(R)}`; for AWGN and DMCs, closed forms exist via `E_0(ρ)` maximization over `ρ ∈ [0,1]`.

### U.2 RCU (Random‑Coding Union) Bound
- Finite‑n achievability bound: average error ≤ `E[ min(1, (M−1) P( i(X;Y′) ≥ i(X;Y) | X,Y ) ) ]` where `i` is information density and `M` is code size. It refines union bound by averaging over codebooks and competes well with normal approximation at moderate n.

### U.3 Meta‑Converse
- Converse bound using an auxiliary output distribution; together with RCU it tightly brackets best performance in many regimes (PPV’10).

### T.1 Ryser’s Permanent (k×k)
```
per = 0
for S in subsets([1..k]):
  sign = (−1)^(k − |S|)
  prod = 1
  for i in 1..k:
    ssum = Σ_{j ∈ S} A[i,j]
    prod *= ssum
  per += sign * prod
```
Use Gray‑order subsets; update `ssum` incrementally when a single bit flips.

### T.2 Waterfilling (Bisection)
```
low = min(1/λ_i); high = low + P + max(1/λ_i)
while high − low > tol:
  μ = (low + high)/2
  p_i = max(μ − 1/λ_i, 0)
  if Σ p_i > P: high = μ else low = μ
return p_i
```

### T.3 Rank‑1 log‑det Update
```
// Given SPD A and vectors u, v
s = v^T (A^{-1} u)   // solve A x = u, then s = v^T x
Δ = log(1 + s)
logdet(A + u v^T) = logdet(A) + Δ
```
Prefer solves via Cholesky; for downdates, check SPD condition.

### T.4 Compensated Summation (Kahan/Neumaier)
Use compensated summation for the outer accumulator in Ryser/Glynn to reduce cancellation:
```
sum = 0.0
c = 0.0        // compensation
for term in sequence:
  y = term - c
  t = sum + y
  c = (t - sum) - y   // Kahan; Neumaier variant improves when |y| > |sum|
  sum = t
return sum
```
Apply this to the signed product terms as subsets toggle in Gray order (see Appendix E.2).

### N.1 Bethe Free Energy
- For a factor graph with beliefs `b_i(x_i)`, `b_a(x_a)` (variable and factor beliefs) and compatibility functions `ψ_a(x_a)`, the Bethe free energy is
  `F_B(b) = Σ_a Σ_{x_a} b_a(x_a) log( b_a(x_a)/ψ_a(x_a)) − Σ_i (d_i − 1) Σ_{x_i} b_i(x_i) log b_i(x_i)`,
  where `d_i` is the degree of variable `i`. Stationary points under marginalization constraints correspond to BP fixed points.

### N.2 Bethe Permanent
- For a nonnegative matrix `A`, the permanent equals the partition function of a bipartite matching model. Approximating this partition function by minimizing `F_B` over doubly‑stochastic beliefs (subject to matching constraints) yields the Bethe permanent, computable via loopy BP. For signed/complex entries, this probabilistic interpretation breaks and Bethe is purely heuristic.
- Exact on trees; heuristic on loopy graphs. Often accurate for sparse, locally tree‑like structures.

### N.3 Stationary Conditions and BP Fixed Points
- Constrained minimization of `F_B` with Lagrange multipliers for normalization and marginalization `Σ_{x_a\setminus x_i} b_a(x_a) = b_i(x_i)` yields stationary conditions
  consistent with BP update equations: factor‑to‑variable and variable‑to‑factor messages proportional to `Σ` or products of incoming messages weighted by `ψ_a`.
- At a fixed point, local consistency holds: `b_i(x_i) ∝ ∏_{a∈N(i)} m_{a→i}(x_i)` and `b_a(x_a) ∝ ψ_a(x_a) ∏_{i∈a} m_{i→a}(x_i)`.

### M.1 det vs per (2×2)
- Let `A = [[a,b],[c,d]]`. Then `det(A)=ad−bc`, `per(A)=ad+bc`. Example: `A=[[1,2],[3,4]]` ⇒ `det = −2`, `per = 10`.

### M.2 pfaff vs haf (4×4)
- Skew‑sym `K` with entries `k_{ij} = −k_{ji}`; `pf(K)` depends on crossing parity; sym `S` uses `haf(S)` without signs.
- Concrete numeric example:
  - Let `K = [[0, 1, 2, 3], [−1, 0, 4, 5], [−2, −4, 0, 6], [−3, −5, −6, 0]]`.
  - Pfaffian formula (4×4): `pf(K) = k_{12}k_{34} − k_{13}k_{24} + k_{14}k_{23}`.
    Here `pf(K) = (1·6) − (2·5) + (3·4) = 6 − 10 + 12 = 8`.
  - Let `S` be the symmetric counterpart with the same magnitudes: `S = [[0, 1, 2, 3], [1, 0, 4, 5], [2, 4, 0, 6], [3, 5, 6, 0]]`.
  - Hafnian (4×4): `haf(S) = s_{12}s_{34} + s_{13}s_{24} + s_{14}s_{23} = (1·6) + (2·5) + (3·4) = 28`.

### M.2b Pfaff Sign Under Odd Permutation
- Using the `K` from M.2, apply an odd permutation to the vertex order, e.g., swap indices 1↔2 with permutation matrix `P` (so `sgn(P) = −1`). Then `K' = P^T K P` satisfies `pf(K') = −pf(K) = −8` while `det(K') = det(K) = 64` and `|pf(K')| = |pf(K)| = 8`.

### M.3 Rank‑1 log‑det update
- `A=[[2,0],[0,3]]`, `u=[1,2]^T`, `v=[1,−1]^T`: `log det(A+uv^T) = log 5` per rank‑1 formula; direct computation confirms.

### M.4 Finite‑n normal approximation
- AWGN, SNR `ρ=3` (≈4.77 dB), dispersion (bits²/use) via `(log2 e)^2 ρ(ρ+2)/(2(1+ρ)^2)` ≈ compute numerically; with `n=1000`, `ε=10^{-3}`, `R*(n,ε) ≈ C − √(V/n) Q^{-1}(ε)`.
- Note: plug actual numbers as needed; the expression provides a quick sizing rule.
 - Caveat: accuracy degrades for very small `n` or extreme `ε` (e.g., `ε<10^{-6}`) unless refined approximations (e.g., Edgeworth) or exact bounds are used.

### M.5 Waterfilling numeric
- Parallel channels with `λ = [4, 1, 0.25]`, power `P=3`. Water level `μ` solves `Σ_i (μ − 1/λ_i)_+ = 3` ⇒ `(μ−0.25) + (μ−1) + (μ−4)_+ = 3`.
- Solution: allocate only on first two until `μ>4`. With `μ` between 1 and 4: `(μ−0.25)+(μ−1)=3` ⇒ `2μ−1.25=3` ⇒ `μ=2.125`. Powers: `[1.875, 1.125, 0]`. Rate `Σ log2(1+λ_i p_i)` ⇒ `log2(1+4·1.875)+log2(1+1·1.125) ≈ log2(8.5)+log2(2.125) ≈ 3.087+1.089 ≈ 4.176` bits.
- Units: rates reported in bits/use (base‑2 logs).
 - Micro example 2: `λ = [4, 1, 0.25]`, `P=1`. Water level between first two: `(μ−0.25)+(μ−1)=1` ⇒ `2μ−1.25=1` ⇒ `μ=1.125`. Powers: `[0.875, 0.125, 0]`. Rate `≈ log2(1+4·0.875)+log2(1+0.125) ≈ log2(4.5)+log2(1.125) ≈ 2.170+0.169 ≈ 2.339` bits.

### M.6 Block‑Sum Multiplicativity (2×2 ⊕ 2×2)
- Let `A1=[[1,2],[0,3]]`, `A2=[[4,0],[5,6]]`. Then `A = A1 ⊕ A2`.
- Determinant: `det(A1)=3`, `det(A2)=24`, `det(A)=72 = 3·24`.
- Permanent: `per(A1)=1·3+2·0=3`, `per(A2)=4·6+0·5=24`, `per(A)=3·24=72`.
- Pfaffian/hafnian: apply only to valid domains (skew/symmetric even‑order); for symmetric block‑diagonal `S1 ⊕ S2`, `haf(S)=haf(S1)·haf(S2)`; for skew `K1 ⊕ K2`, `pf(K)=pf(K1)·pf(K2)`.

### L.1 Linear Separators and VC
- In `R^d`, homogeneous linear separators have VC dimension `d`; with bias, `d+1`. Whitening ensures isotropic features but does not change VC.

### L.2 Sample Complexity (PAC)
- To achieve error `ε` with confidence `1−δ`, a realizable class with VC `d` needs `m = O((d log(1/ε) + log(1/δ))/ε)` samples; for agnostic learning, `m = O((d + log(1/δ))/ε^2)` (constants hidden).

### L.3 Relevance Here
- Whitening/sphering makes linear decision boundaries well‑conditioned; submodular selection of measurements can reduce effective dimension, improving generalization without changing VC in the worst case.

### K.1 Construction A
- Given a linear code `C ⊂ (Z_p)^n`, the fine lattice is `Λ_f = p Z^n + φ(C)` where `φ` embeds codewords into `Z^n`.
- A coarse lattice `Λ_c` (e.g., `p Z^n`) nests `Λ_f ⊂ Λ_c`; the quotient `Λ_c/Λ_f` indexes cosets carrying information.

### K.2 Shaping and Dithering
- Shaping: restrict signals to a Voronoi region of `Λ_c` to meet power constraints; dithering (uniform over Voronoi cell) produces near‑Gaussian effective noise and good shaping gain.

### K.3 Practical Use
- Map parity/pilot lanes onto small prime rings and assemble with Construction A; use the coarse lattice for shaping and the fine lattice for checks. Keep dimensions modest for tractability; decoding via nearest‑lattice methods or message passing on code Tanner graphs.

### J.1 Kendall’s Tau and Spearman’s Rho
- Kendall’s tau: `τ = P(concordant) − P(discordant)`; Spearman’s rho: Pearson correlation of ranks.
- In elliptical copulas (e.g., Gaussian), both are monotone functions of the linear correlation `ρ` and invariant under strictly increasing marginal transforms.

### J.2 Gaussian Example
- For Gaussian copula with correlation `ρ`, `τ = (2/π) arcsin(ρ)` and `ρ_S = (6/π) arcsin(ρ/2)`.
- Consequence: ordering by `ρ`, `τ`, or `ρ_S` is equivalent; useful for diagonalization decisions and for comparisons of dependency strength when linearity may not hold at the marginals.

### I.1 KKT Derivation for Parallel Gaussian Channels
- Problem: maximize `Σ_i log(1 + λ_i p_i)` subject to `Σ_i p_i = P`, `p_i ≥ 0`.
- Lagrangian: `L = Σ_i log(1 + λ_i p_i) − μ(Σ_i p_i − P) − Σ_i ν_i p_i`.
- KKT: `∂L/∂p_i = λ_i/(1+λ_i p_i) − μ − ν_i = 0` with `ν_i p_i = 0`, `ν_i ≥ 0`.
- Solution: `p_i = (μ − 1/λ_i)_+` with `μ` chosen s.t. `Σ_i p_i = P` (water level). Channels with small `λ_i` (below `1/μ`) get zero power.

### I.2 Majorization/Schur View
- For vectors `x` majorized by `y` (`x ≺ y`), any Schur‑concave function satisfies `f(x) ≥ f(y)`. On the PSD cone, `log det` is Schur‑concave in eigenvalues.
- Consequence: under trace (power) constraints, spreading eigenvalues (more uniform) increases `log det`, consistent with waterfilling equalizing above a floor set by inverse SNRs.

### I.3 Practical Notes
- With colored noise PSD `N(f)`, waterfilling over frequency allocates `S_X(f) = (ν − N(f))_+` and achieves `C = ∫ log(1 + S_X(f)/N(f)) df` (base consistent with desired units).
- Numerical: solve for `ν` by sorting `1/λ_i` and accumulating; in continuous domains, use bisection with PSD integrals.


## Appendix B: Stationarity, Toeplitz/BCCB, and FFT Diagonalization (Pass 5)

### B.1 Toeplitz vs Circulant Approximations
- Toeplitz covariance (1D stationary): `Σ_{ij} = k(i−j)`. Block‑circulant with circulant blocks (BCCB) approximations replace borders with wrap‑around; they diagonalize exactly by the DFT matrix `F` (1D) or Kronecker `F ⊗ F` (2D).
- Circulant embedding: embed Toeplitz in a larger circulant to use FFTs; errors decay with size for sufficiently smooth spectra.
- Preconditioning: Strang’s circulant preconditioner yields fast conjugate‑gradient convergence on Toeplitz systems.

### B.2 Asymptotic Eigenvalue Distributions
- Szegő’s theorem (informal): eigenvalues of large Toeplitz matrices sample the generating power spectral density; averages of functions of eigenvalues converge to integrals over frequency.
- Consequences: log‑det and trace functionals admit Riemann approximations; waterfilling solutions computed on spectra are asymptotically optimal for large grids.

### B.3 Kronecker Separability
- For separable kernels `k((i1,i2),(j1,j2)) = k1(i1−j1) k2(i2−j2)`, the covariance is approximately `Σ ≈ Σ1 ⊗ Σ2`. FFT diagonalizes each factor via `F ⊗ F`; storage and inverse cost reduce to sums of per‑axis costs.

## Appendix C: Cumulants, Inclusion–Exclusion, and Bonferroni (Pass 6)

## Appendix D: Submodular Curvature and Ratio Guarantees (Pass 7)

## Appendix E: Permanent Computation Recipes (Pass 8)

### E.1 Ryser and Glynn Formulas
- Ryser’s inclusion–exclusion (for `k×k` matrix `A`):
  `per(A) = (−1)^k Σ_{S⊆[k]} (−1)^{|S|} ∏_{i=1}^k Σ_{j∈S} a_{ij}`.
- Glynn’s variant reduces constants by using `±1` vectors with a constraints trick, saving roughly a factor of 2 in practice.
- Complexity: `O(k 2^k)` arithmetic operations.

### E.2 Gray‑Order and Bitset Tricks
- Iterate subsets in binary‑reflected Gray code so that each step flips one bit; update row sums incrementally.
- Use fixed‑width bitsets and vectorized summations for cache locality on small `k` (up to mid‑20s in practice).

### E.3 Many Subpermanents
- For many principal subpermanents, fix a row DP per subset of columns restricted to that subset; total cost `≈ O(n 3^n)`.
- Exploit block/reducible structure to factor work; memoize repeated subblocks.
 - Streaming vs memoization: stream row‑sum/frontier states and spill seldom‑reused ones; arrange DP scans to be cache‑friendly (Gray‑order helps locality).

### E.4 Approximations
- JSV FPRAS for nonnegative matrices; pick tolerance `ε` and run randomized algorithm with polynomial complexity in `n,1/ε`.
- Bethe/loopy BP heuristics: compute doubly‑stochastic pseudomarginals by BP; evaluate Bethe free energy for an approximation.

## Appendix F: ARC Pilots → Factor Graph → Attention (Pass 9)

### F.1 Variables and Factors
- Variables: cell colors/labels and object attributes.
- Factors: row/col/window parity checks; object invariants; sync constraints from positional pilots.
- Graph: bipartite variable–factor adjacency; sparse and locally structured by design (lane kit).

### F.2 Message Passing vs Masked Attention
- Build a block‑sparse attention mask from adjacency; compute attention only along variable–factor (or variable–variable via factors) edges.
- One masked attention layer ≈ parallel BP update (softmax as normalized weights + residual mixing); stacking yields multiple rounds.

### F.3 Loss Design
- Multi‑task losses: base reconstruction; parity satisfaction; window checks; object invariants; sync recovery.
- Curriculum: gradually increase lane density/strength; monitor ablations per lane to estimate MI contributions.

## Appendix G: Singular Learning Theory (Pass 10)

### G.1 RLCT and Asymptotics
- Real log canonical threshold (RLCT) governs marginal likelihood asymptotics and posterior contraction rates in singular models; replaces the usual `(d/2) log n` penalty.

### G.2 Remedies and Practice
- Reparameterize to identifiable coordinates; quotient out symmetries; add priors/penalties; constrain architecture; analyze Hessian spectra; whitelist identifiable directions.

### D.1 Greedy under Cardinality Constraints
- Let `f:2^V→R_+` be monotone submodular with `f(∅)=0`. The greedy algorithm selecting `k` items attains a `(1 − 1/e)`‑approximation to the optimal `k`‑subset.

### D.2 Total Curvature
- Total curvature `c ∈ [0,1]` of `f` quantifies deviation from modularity. With curvature `c`, greedy satisfies the bound
  `f(S_greedy) ≥ (1/c)(1 − e^{−c}) · f(S_opt)` (interpreting the `c→0` limit as 1).

### D.3 Submodularity Ratio
- For monotone functions with submodularity ratio `γ ∈ (0,1]`, greedy attains a `(1 − e^{−γ})`‑approximation (under the same cardinality constraint), smoothly degrading as `γ` decreases from 1.

### D.4 Practical Use
- Use curvature/ratio estimates to set stopping rules (`Δgain/Δcost ≤ 1`, large `c`) and to justify limited additional measurements/windows when near saturation.

### C.1 Inclusion–Exclusion and Bonferroni
- Inclusion–exclusion (exact): for events `A_1,…,A_n`,
  `P(⋃_i A_i) = Σ_i P(A_i) − Σ_{i<j} P(A_i∩A_j) + Σ_{i<j<k} P(A_i∩A_j∩A_k) − ⋯`.
- Bonferroni inequalities (truncations): if truncating after `m` terms,
  - `m` odd ⇒ upper bound; `m` even ⇒ lower bound. E.g.,
  - 1st‑order (union bound): `P(⋃ A_i) ≤ Σ_i P(A_i)`.
  - 2nd‑order lower bound: `P(⋃ A_i) ≥ Σ_i P(A_i) − Σ_{i<j} P(A_i∩A_j)`.

### C.2 Cumulants as Möbius Inversion
- Moment generating function `M(t)=E[e^{t^T X}]`; cumulant generating function `K(t)=log M(t)`; the `r`‑th order cumulant tensor `κ^{(r)} = ∇^r K(0)`.
- Möbius inversion on the lattice of set partitions: joint moments equal sums over products of cumulants, and cumulants equal alternating sums over products of moments.
- Events viewpoint: truncating at 1st order recovers the union bound; including 2nd order captures pairwise interactions; higher orders capture synergy/redundancy beyond pairwise.

### C.3 Up to Third Order (Illustrative)
- For scalar `X` with mean zero: `E[X^3] = κ_3 + 3 κ_2 κ_1 + κ_1^3`; centered implies `E[X^3]=κ_3`.
- For three binary events, the triple intersection term appears with a `+` sign in inclusion–exclusion and ties to a 3rd‑order cumulant capturing three‑way dependence.

### Pass 2: Correctness and Clarity (Finite‑n + DoF)
- Units and notation
  - DoF: “≈ 2Bt real DoF” assumes real baseband degrees; complex baseband interpretations halve/double appropriately. Keep logs base‑2 for bit rates.
  - `Q^{-1}` is the inverse Gaussian tail; `V` (dispersion) follows the channel model (e.g., AWGN, BMS).
- Action taken
  - Clarified units and log base in text. No back‑prop required; sketch.md already carries these clarifications at a concise level.
### Assumptions at a Glance (Probabilistic)
- Existence of moments up to the order used (or adopt robust alternatives for heavy tails).
- Monotone, nonnegative set functions when invoking greedy guarantees; otherwise qualify via curvature/submodularity ratio.
- Independence assumptions only where explicitly stated; otherwise use cumulant‑based dependence measures.
Pointer to references
- Submodularity ratio/curvature refinements: see Nemhauser–Wolsey and Das–Kempe in References.
