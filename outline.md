# Outline (High‑Level Table of Contents)

## 0. Validity Assumptions and Conventions
- Logs base‑2 for rates; see notation appendix for conversions.
- Operators: `⊕` (block sum) and `⊗` (Kronecker) listed in Appendix O (symbols/glossary).
- Domains: pfaffian (even‑order skew‑sym), hafnian (even‑order sym), permanent defined for square matrices.
- Identity `per(C)=haf([[0,C],[C^T,0]])` requires square `C`.
- Stationarity: Toeplitz ≈ circulant is asymptotic/embedded; BCCB is exact.
- Finite‑blocklength: normal approximation under regularity (information‑density CLT); specify model/units.
- Systems: “masked attention ≈ BP” is heuristic, exact BP holds on trees.

## 1. Algebraic Foundations
- Immanants: `Imm_χ` unifies `det` and `per`; pfaffian/hafnian for skew/symmetric pairings (even‑order domains; pf uses transpose, not conjugate).
- Relations: `pf(A)^2 = det(A)` (skew); `per(C)=haf([[0,C],[C^T,0]])` for square `C`; block‑sum multiplicativity.
- Permutation effects: `per` invariant under simultaneous row/column permutations; `pf` flips sign under odd permutations (|pf| invariant).

## 2. Probabilistic Structure
- Moments and cumulants; Gaussian truncation (Wick); synergy via higher‑order cumulants.
- Submodularity: diminishing returns, curvature, submodularity ratio.
- Diagnostics: define curvature `c` and submodularity ratio `γ`; note greedy assumptions (monotone, nonnegative).
- Two‑term refinement: explicit Chung–Erdős bound formula and caveats.
- Probability bounds: union bound; inclusion–exclusion; Bonferroni truncations.
- Heavy tails: cumulants may not exist; prefer robust/quantile methods.

## 3. Stationarity and Spectral Methods
- Toeplitz/BCCB covariance; FFT diagonalization; Kronecker separability.
- Fourier: unitary DFT used; Parseval holds (energy preserved).
 - Parseval check: tiny numeric example (n=4) included.
 - FFT libs: NumPy/SciPy default to engineering normalization; set `norm="ortho"` for unitary consistency.
- Majorization and waterfilling for spectral allocation.
- Log‑det concavity over SPD cone (see Appendix I for KKT derivation).
- Validity: Toeplitz diagonalization is approximate; circulant/BCCB exact; check separability.
- Waterfilling KKT: `p_i = (μ − 1/λ_i)_+`, choose `μ` to meet power.
- Windowing tradeoff: leakage vs resolution affects Toeplitz≈circulant accuracy.
 - Boundary conditions: periodic vs reflective/zero padding change eigenstructure.
  - Boundary–window match: align boundary handling with chosen taper/window to avoid bias.

## 4. Finite‑Blocklength and Degrees of Freedom
- Normal approximation with dispersion; `R*(n,ε) ≈ C − √(V/n) Q^{-1}(ε)`.
- Time–bandwidth `≈ 2Bt` real DoF; wideband `Eb/N0 → ln 2`.
- Units and conditions: bits vs nats clarity; CLT regularity; moderate `ε`.
- Eb/N0 comparability requires stated spectral efficiency (bits/s/Hz) or bandwidth assumptions.
- Complex baseband: interpret `2Bt` real DoF as `Bt` complex DoF.

## 5. Permanents Toolbox
- #P‑completeness; Ryser/Glynn `O(k 2^k)`; `O(n 3^n)` for many subpermanents.
- Structure: block/reducible; treewidth DP; JSV FPRAS (nonnegative only); Bethe/loopy BP heuristics.
- Gray‑order with O(n) row‑sum updates per step; see Appendix T (formulas/pseudocode).
 - Cautions: JSV applies only to nonnegative matrices; avoid integer overflow—use floating‑point with scaling/log techniques.

## 6. System Design
- Pilots: positional/spectral; lane kit; mixed‑radix disjoint alphabets; interleaving (de‑Bruijn/PRN).
- Dyadic windows/glimpses; snapshot protocols (IDs, hashes, deltas; rank‑k det lemma/Woodbury).
- Validity: examples not specs; SPD checks for downdates; budgeted submodular selection assumptions.

## 7. Inference Mapping
- Factor graphs; masked attention ≈ parallel BP (decoding intuition).

## 8. Singular Learning Theory
- Degenerate Fisher; RLCT; remedies (reparam/quotient, priors, constraints, profile, whitening).
 - RLCT is typically rational (see Watanabe 2009).

## 9. Tests and Diagnostics
- 2×2 det vs per; 4×4 pfaff vs haf; odd‑order hafnian zero; rank‑1 log‑det; XOR synergy.
 - Waterfilling micro (2 modes) with units; pfaffian test ties to Appendix M.2.

## 10. Integration and Appendices
- Integration plan across layers; see Appendices H (section map), O (symbols/glossary), and T (permanent formulas) in `paper.md`.
