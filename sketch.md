# Sketch: Expansions of Outline Items

This document expands the outline into tight mathematical notes with concise one‑line sketches. Each section corresponds to items in `outline.md`, including cleaned lines that were split.

## Flow Roadmap

- Algebraic foundations → probabilistic structure → stationarity/spectral → finite‑n/DoF → permanents toolbox → system design (pilots/glimpses/snapshots) → inference mapping (factor graphs/attention) → SLT caveat → tests/diagnostics → integration plan (with appendices A–G in `paper.md`).

## Validity Assumptions and Conventions (Sketch)

- Logs base‑2 for rates (convert via Appendix O). Matrices over R/C; PSD/SPD as usual.
- Domains: `pf` on even‑order skew‑symmetric; `haf` on even‑order symmetric; `per` on square.
- Block‑hafnian identity: `per(C)=haf([[0,C],[C^T,0]])` for square `C` only.
- Stationarity: exact for circulant/BCCB; Toeplitz ≈ circulant asymptotically/with embeddings.
- Unitary DFT (1/√n) preserves energy (Parseval): `||x||_2^2 = ||X||_2^2`.
 - FFT libs: NumPy/SciPy default to engineering normalization; use `norm="ortho"` for a unitary DFT.
- Boundary conditions matter (periodic/reflective/zero padding) for embeddings and spectral leakage.
- Boundary–window match: align boundary handling with chosen taper/window to avoid bias.
- Normal approximation conditions: information‑density CLT and matched units/models.
- “Attention ≈ BP” is heuristic; BP exact on trees.
 - Heavy tails: cumulants may be undefined; use robust/quantile alternatives.

## Submodularity Diagnostics (Quick)

- Curvature `c`: `c = 1 − min_i (f(V)−f(V\setminus\{i\}))/(f(\{i\})−f(∅))` (monotone `f`).
- Submodularity ratio `γ`: `Σ_{i∈B} Δ(i|A) ≥ γ·Δ(B|A)` for disjoint `A,B`; `γ=1` if submodular.
- Greedy guarantees use `c, γ` to interpolate between modular and fully submodular regimes.

## Waterfilling Snapshot

- Parallel Gaussian modes with eigenvalues `λ_i ≥ 0`, power `p_i ≥ 0`, `Σ p_i ≤ P`.
- KKT gives `p_i = max(0, μ^{−1} − 1/λ_i)` with `μ` s.t. `Σ p_i = P`.
- Aligns with `log det` Schur‑concavity and majorization (Appendix P).
- Log‑det is concave on the SPD cone (cross‑link Appendix I for KKT derivation details).

## Quick Inequality (Chung–Erdős)

- `P(⋃_i A_i) ≥ (Σ_i P(A_i))^2 / Σ_{i,j} P(A_i ∩ A_j)` when denominator is finite/nonzero; tighten union bound with overlap info. Note: bound can be vacuous if pairwise intersections dominate the denominator.

## DoF Note

- Real passband: `≈ 2BT` real DoF over duration `T` and bandwidth `B`.
- Complex baseband: `≈ BT` complex DoF (equivalently `2BT` real).
- Eb/N0 comparability requires stated spectral efficiency or bandwidth/signaling assumptions.

## Immanants, Determinant, Permanent, Pfaffian, Hafnian, Matchings

- Sketch: Immanants generalize determinant and permanent via symmetric‑group characters; pfaffian/hafnian enumerate perfect matchings (signed vs unsigned).
- Immanant: For `A ∈ C^{n×n}` and a class function `χ: S_n → C`,
  `Imm_χ(A) = Σ_{σ∈S_n} χ(σ) ∏_{i=1}^n a_{i,σ(i)}`.
  - Determinant: `χ(σ) = sgn(σ)` ⇒ `det(A)`.
  - Permanent: `χ(σ) ≡ 1` ⇒ `per(A)`.
- Pfaffian: For skew‑symmetric `A ∈ C^{2m×2m}` (transpose, not conjugate), `pf(A)` satisfies `pf(A)^2 = det(A)` and expands over perfect matchings with signs from crossing parity.
- Hafnian: For symmetric `A ∈ C^{2m×2m}`, `haf(A) = Σ_{M∈PM(2m)} ∏_{(i,j)∈M} A_{ij}` (unsigned sum over perfect matchings).
- Permutations: `per` invariant to simultaneous row/column permutations; `pf` flips sign under odd permutations (|pf| invariant).
- Graph viewpoint: `per` counts perfect matchings in bipartite graphs (biadjacency matrix), `haf` in general graphs (symmetric adjacency).
- Note: “Cumulant” is not an immanant; it’s a statistic derived from log‑MGF.
- Identity: `per(C) = haf([[0, C], [C^T, 0]])` (permanent as a block‑hafnian).
- Ryser/Glynn: Gray‑order with O(n) row‑sum updates per toggle; see Appendix T.
 - Numerical tips: use compensated summation for the outer accumulator; JSV FPRAS applies only to nonnegative matrices.
- Structure checklist: check for block direct sums; planar cases (Kasteleyn orientation where |pf| counts matchings); and low treewidth (DP) to choose exact vs approximate methods.

## When One Becomes Another; Cumulants and Gaussianity; Bethe Permanent; Factor Graphs

- Sketch: `Imm_χ` specializes by choice of `χ`; Gaussianity kills higher cumulants; Bethe permanent approximates `per` via belief propagation on factor graphs.
- Specializations:
  - `Imm_χ` → `det` when `χ = sgn`; `Imm_χ` → `per` when `χ ≡ 1`.
  - For skew‑symmetric `A`, `pf(A)^2 = det(A)`.
- Cumulants: With cumulant generating function `K(t)=log E[e^{t^T X}]`, the order‑r cumulant tensor is `∇^r K(0)`. For Gaussian vectors, all cumulants of order ≥ 3 vanish (Wick closure).
- Bethe permanent: `per_Bethe(A)` is obtained by minimizing Bethe free energy over doubly‑stochastic approximate marginals of the bipartite matching factor graph and evaluating at BP fixed points.
- Factor graphs: Variable nodes for assignments `(i→j)`, factor nodes enforce one‑to‑one constraints; exact on trees; loopy belief propagation yields Bethe approximations.
- Decoding intuition: Masked attention with graph‑aligned masks approximates parallel BP; depth‑T ≈ T rounds.

## Submodular, Synergy, Diagonalize, Block‑Decompose

- Sketch: Submodularity = diminishing returns; direct sums block‑diagonalize and multiplicatively separate immanants.
- Submodular set functions: `f: 2^V→R` is submodular if `f(A)+f(B) ≥ f(A∩B)+f(A∪B)`; equivalently `Δ(x|A) ≥ Δ(x|B)` for `A⊆B`.
- Synergy/interaction: Deviation from additivity; captured by interaction information or higher‑order cumulants.
- Block multiplicativity for compatible classes:
  - `det(A1 ⊕ A2) = det(A1) det(A2)`.
  - For skew‑symmetric blocks: `pf(A1 ⊕ A2) = pf(A1) pf(A2)`.
  - For symmetric even‑size blocks: `haf(A1 ⊕ A2) = haf(A1) haf(A2)`.
  - `per(A1 ⊕ A2) = per(A1) per(A2)`.

## Moment Orders 0,1,2,3,… and Cumulants

- Sketch: Moments are MGF derivatives; cumulants are log‑MGF derivatives. Gaussian: only orders 1–2 survive (if centered, only 2).
- Moments: `m_k = E[X^k]` (mixed moments for vectors). The “0th moment” integrates to 1 for densities.
- Cumulant generating function: `K(t) = log E[e^{t^T X}]`; order‑r cumulant tensor `κ^{(r)} = ∇^r K(0)`.

## Union Bound; Submodularity Ratio; Diminishing Returns; Synergy

- Sketch: `P(∪ E_i) ≤ Σ P(E_i)`; submodular structure enables greedy `(1−1/e)` with curvature/ratio refinements; synergy shows up as interaction terms.
- Union bound: `P(∪_i E_i) ≤ Σ_i P(E_i)`; tighten via inclusion–exclusion or correlation inequalities when applicable.
- Submodularity ratio `γ`: Measures near‑submodularity; bounds greedy approximation when true submodularity fails.
- Curvature (see below) quantifies departure from modularity and refines guarantees.
- Two‑term refinement (Chung–Erdős): `P(⋃_i A_i) ≥ (Σ_i P(A_i))^2 / Σ_{i,j} P(A_i ∩ A_j)`.
- Cumulant view: refinements correspond to truncating the cumulant expansion (Möbius inversion on partitions); Bonferroni = order‑k truncation.

## Matrix Determinant Lemma; Flat Spectrum; Waterfilling; Majorization; Jacobi; Schur

- Sketch: Low‑rank updates are fast (det lemma/Woodbury); eigenvalue order by majorization; block factorization via Schur; waterfilling allocates power.
- Matrix determinant lemma: `det(A+U V^T) = det(I+V^T A^{-1} U) det(A)` for invertible `A`.
- Woodbury: `(A+U C V^T)^{-1} = A^{-1} − A^{-1} U (C^{-1}+V^T A^{-1} U)^{-1} V^T A^{-1}`.
- Waterfilling: For eigenvalues `λ_i` and power `P`, solve `max_{p_i≥0, Σ p_i=P} Σ log(1+λ_i p_i)` by `p_i = (μ − 1/λ_i)_+`.
- Majorization: `x ≺ y` iff `Σ_{i=1}^k x_{(i)} ≤ Σ_{i=1}^k y_{(i)}` for `k=1..n` and totals equal; Schur‑convex/concave functions preserve/flip order. `log det` is concave on the PSD cone and Schur‑concave in eigenvalues.
- Jacobi: `d/dt log det(A+tB) = tr((A+tB)^{-1} B)`; complementary minor identity links minors of `A` and `A^{-1}`.
- Schur complement: For `A = [A11 A12; A21 A22]` with `A11` invertible, `det(A) = det(A11) det(A22 − A21 A11^{-1} A12)`.
- Permanent toolbox: detect block/reducible structure; try treewidth‑based DP on sparse graphs; for dense nonnegative matrices use JSV FPRAS or Bethe/loopy BP heuristics; implement Ryser/Glynn with Gray‑order bitsets for cache locality.

## Stationary Measures

- Sketch: Stationarity = invariance to shifts; diagonalize by characters (Fourier) on groups.
- Stationary process: Finite‑dimensional distributions invariant under time/space shifts. Gaussian stationary ⇒ Toeplitz (1D) or BCCB (periodic) covariance.
- Stationary distribution: For Markov chain with transition `P`, `π^T P = π^T`.
- Ergodicity: Time averages converge to expectations under the stationary measure.

## Diagonalize Fisher Information, KL, VC Dimension, Kendall’s Tau

- Sketch: Many functionals decompose along independent/eigen modes; Fisher is a Riemannian metric; KL diagonalizes when covariances commute; Kendall’s τ is rank‑based.
- Fisher information: `I(θ) = E[∇ log p_θ ∇ log p_θ^T]`. Under reparam `φ=g(θ)`, transforms as a metric; orthogonal bases can diagonalize locally.
- KL divergence: `D(P||Q)=E_P[log(dP/dQ)]`. For `N(μ,Σ)` vs `N(ν,Λ)`: `0.5( tr(Λ^{-1}Σ) + (ν−μ)^T Λ^{-1} (ν−μ) − d + log det Λ − log det Σ )`. Diagonalizes in common eigenbasis if `Σ` and `Λ` commute.
- VC dimension: Capacity of hypothesis class (e.g., `d+1` for thresholds on `R^d` with bias). Not an operator ⇒ no literal diagonalization; depends on feature space dimension after whitening.
- Kendall’s τ: `τ = P(concordant) − P(discordant)`. For elliptical families, monotone in correlation; invariant under strictly increasing transforms.
- Singular models note: when Fisher is rank‑deficient (degenerate), classical χ²/BIC asymptotics fail; use singular learning theory (RLCT‑based) and operate on identifiable subspaces.
- Remedies: reparameterize/quotient symmetries; add informative priors/penalties; constrain architectures; use profile likelihood; whiten identifiable directions.

## Log‑Det Updates; Curvature; Pairwise and Higher‑Order MI; Long‑Range Cancellation

- Sketch: Use det lemma for stable `log det` updates; submodular curvature refines greedy; cumulant decay explains cancellation of distant dependencies.
- Stable update: `log det(A+U V^T) = log det(A) + log det(I+V^T A^{-1} U)`; compute via Cholesky/QR of smaller matrix.
- Submodular curvature: `c = 1 − min_{e∈V} (f(V) − f(V\{e}))/(f({e}) − f(∅))` (in `[0,1]`). Lower curvature ⇒ better greedy bounds.
- Pairwise MI: `I(X;Y)=D(P_{XY}||P_X P_Y)`; Multi‑information: `I(X_1;…;X_n)=Σ H(X_i) − H(X_1,…,X_n)`.
- Interaction information: Signs indicate synergy/redundancy. XOR has zero pairwise MI but positive 3‑way interaction.
- Long‑range cancellation: In mixing/weakly‑dependent fields, high‑order cumulants decay; cumulant expansions effectively truncate, making objectives near‑local.
- Finite‑blocklength note: for limited snapshot windows, achievable rate `R*(n, ε) ≈ C − √(V/n) Q^{-1}(ε)` links reliability to dispersion V; motivates multiresolution snapshots.

## Whiten, Sphere, Covering Arrays (CAs), Sequential CAs (SCAs)

- Sketch: Whiten to identity covariance, normalize scales; use t‑wise covering designs to probe interactions efficiently.
- Whitening: Transform `x ↦ Σ^{-1/2}(x−μ)` to get identity covariance.
- Sphering: Normalize to unit norm or unit variance per component.
- Covering arrays `CA(N; t, k, v)`: `N×k` over `v` symbols where every set of `t` columns contains all `v^t` tuples at least once.
- Sequential CAs: Greedy extensions maintaining `t`‑wise coverage while adding tests/columns.

## Precision, Quantization, Spacetime Coordinates, Riemannian Geometry

- Sketch: Quantization introduces geometry via distortion; information geometry equips parameter spaces with Fisher‑Riemannian metrics.
- Quantization: Map `X` to codebook `\hat X` minimizing `E[d(X,\hat X)]` at rate `R`; rate–distortion `R(D)=inf I(X;\hat X)`.
- Spacetime coordinates: Respect geometry with multiscale bases (e.g., wavelets) and grid‑aligned structures.
- Riemannian information geometry: Manifold `(M,g)` with `g=I(θ)`; geodesics, curvature, and Jeffreys prior `π_J(θ) ∝ \sqrt{\det I(θ)}`.
- Degrees of freedom (DoF): ≈ `2Bt` real DoF over duration `t` and bandwidth `B`.

## Tests to Separate “Eyeball Width” of Immanants, Moments, etc.

- Sketch: Use small structured matrices/distributions to expose sign sensitivity and higher‑order effects.
- 2×2 matrix `[[a,b],[c,d]]`: `det=ad−bc`, `per=ad+bc` (off‑diagonal sign flip distinguishes structure).
- Pfaff vs haf: On 4×4 skew‑sym vs sym adjacencies, pfaff uses crossing parity signs; haf is unsigned.
- Gaussianity: Sample skewness/kurtosis (3rd/4th cumulants) to detect non‑Gaussianity.
- Submodularity: Verify diminishing returns on toy set functions.
- Log‑det updates: Compare exact vs rank‑1 updated `log det` numerics.
- Higher‑order MI: XOR variable triplets show synergy undetected by pairwise MI.

## Fano Certificate; Fano Inequality; Capacity; Degrees of Freedom; Normal Approximation

- Sketch: Fano lower bounds error via mutual information; capacity is the best achievable rate; DoF is high‑SNR slope; normal approximation refines finite‑blocklength performance.
- Fano inequality (multi‑class): For `M` equiprobable classes `W`, error `P_e`,
  `P_e ≥ 1 − (I(W;Y) + log 2)/log M`.
- Capacity: `C = sup_{P_X} I(X;Y)` per use. MIMO Gaussian: `C = log det(I + SNR·H Σ_X H^T)` under power constraints.
- Degrees of freedom: `DoF = lim_{SNR→∞} C(SNR)/log SNR`; equals `rank(H)` in many MIMO models.
- Normal approximation: `R^*(n,ε) ≈ C − √(V/n) Q^{-1}(ε) + o(1)` where dispersion `V` depends on channel.

## CRT, Singer Difference Sets, Pilots (Positional/Spectral, Absolute/Relative), Nested Lattices, Planar Matchings

- Sketch: Use algebraic designs for pilot placement and synchronization; nested lattices for coding/shaping; non‑crossing (planar) matchings mitigate interference.
- Chinese Remainder Theorem (CRT): Solve `x ≡ a_i (mod n_i)` with pairwise coprime `n_i`; fold multi‑dim indices to cyclic structures for sampling/design.
- Singer difference sets: In `Z_{q^2+q+1}`, construct `(v,k,λ)` sets with optimal correlation; useful for pilot and sync sequences.
- Pilots: Positional (time/space) vs spectral (frequency) placement; absolute phase vs relative references.
- Nested lattices: `Λ_f ⊂ Λ_c` for coding/shaping; dithering gives near‑Gaussian effective noise.
- Planar matchings: Allocate pilots as non‑crossing edges in time–frequency to reduce collisions.
- Minimal lane kit (practical): base serialization, global sync string, hierarchical coordinates, row/col/window parities, object‑level invariants, end‑to‑end CRC.
- Interleaving: Use scrambling/interleaving (de‑Bruijn/PRN schedules) to decorrelate constraints and realize waterfilling across resources.
- Mixed‑radix/disjoint alphabets: use separate alphabets per lane/scale to avoid collisions/interference.

## Block‑Sum Multiplicativity (Cleaned Broken Lines)

- Sketch: Direct sums multiply: `haf(A1 ⊕ A2)=haf(A1) haf(A2)`; similarly for `det`, `pf`, `per`. Algebraic mirror of “block‑decompose and diagonalize.”

## Wick Pairings; Kronecker/BCCB; Lempel–Ziv

- Sketch: Gaussian moments sum over pairings (hafnian of subcovariances); BCCB matrices diagonalize with 2D DFT (`F ⊗ F`); compression links to entropy.
- Wick’s theorem: For zero‑mean Gaussian `X`,
  `E[X_{i1} … X_{i_{2m}}] = Σ_{pairings} ∏ Cov(X_{ia}, X_{ib})`.
- BCCB/Kronecker: Periodic 2D convolution matrices are block‑circulant with circulant blocks and diagonalize by `F ⊗ F`.
- Lempel–Ziv: Universal compression; empirical entropy/MI estimators from compression lengths (e.g., `L(x)+L(y)−L(x,y)`).

## One‑Line Sketch; Dyadic Windows; Glimpse

- Sketch: Small linear sketches summarize; dyadic windows yield multiscale locality; glimpses are adaptive subwindow probes.
- One‑line sketch: A linear projection or small set thereof, `s = h^T x`, preserving coarse properties (e.g., AMS/CountSketch in streaming).
- Dyadic windows: Intervals/squares at scales `2^j`; multiresolution partitions enable fast summations and localized analysis (integral images, FWT).
- Glimpse: Small attention slice (time/space/frequency) chosen adaptively via submodular selection or bandits to maximize information gain.
- Snapshot protocols: prefix‑free IDs, hashing, and delta caches for low‑latency state reuse; retain Cholesky/LDLᵀ factors to enable rank‑k det lemma/Woodbury updates.

## Integration Plan and Contributions

- Purpose: capture a concise, actionable plan for how this sketch integrates the ranked items (0–7) and what each contributes.
- Inclusion order (aggregate across 7 themes): 2‑signals, 7‑permanent, 1‑immanant, 6‑union‑bound, 3‑arc, 4‑submodular, 0‑snapshot, 5‑degenerate‑fisher.
- Editing principles: keep bullets tight; cross‑link rather than duplicate; prefer rank‑k updates and factor storage for numerical stability; detect structure (block sums, planarity, treewidth) early.

### Per‑Document Contributions (What Each Adds)

- 0‑snapshot
  - Unique adds: snapshot protocols (prefix‑free IDs, hashes, delta caches); numerical update backbone (det lemma/Woodbury with Cholesky/LDLᵀ); multiresolution “glimpse” scheduling.
  - Common threads: diagonalization under stationarity (BCCB/Kronecker); submodular selection for bandwidth budgeting.
  - Rigor tweaks: keep implementation‑agnostic; emphasize standard routines and bounded update ranks; check SPD on downdates and pivot if needed.

- 1‑immanant
  - Unique adds: per‑as‑block‑hafnian identity; structured “where one becomes another” lens; structure checklist (block sums, planar/Kasteleyn, low treewidth DP).
  - Common threads: Wick/Gaussian reduction to 2nd order; block sums multiply.
  - Rigor tweaks: small matrices in Tests to illustrate sign effects; qualify Kasteleyn as planar; reference hafnian block‑lift.

- 2‑signals (expanded)
  - Unique adds: finite‑blocklength normal approximation (dispersion V); explicit DoF ≈ 2Bt; interleaving recipes (de‑Bruijn/PRN); wideband Eb/N0 → ln 2 benchmark.
  - Common threads: waterfilling/majorization; BCCB/stationarity; pilots interplay.
  - Rigor tweaks: point to dispersion definitions and AWGN/BMS examples; clarify Q^{-1} and log bases.

- 3‑arc
  - Unique adds: lane kit; mixed‑radix disjoint alphabets; masked‑attention ≈ BP decoding intuition; auxiliary losses.
  - Common threads: pilots as structural side‑info; factor‑graph view; submodular glimpse scheduling.
  - Rigor tweaks: keep BP correspondence as intuition; keep lanes generic.

- 4‑submodular
  - Unique adds: MDL cascade (H_{t+1}≈(1−ρ_t)H_t; L_t≈κ_t+ρ_tH_t) with stop rule (Δgain/Δcost≤1; curvature c, ratio γ guidance).
  - Common threads: greedy guarantees; diminishing returns on saturation.
  - Rigor tweaks: keep curvature/ratio compact; don’t overclaim beyond standard results.

- 5‑degenerate‑fisher
  - Unique adds: SLT caveat (real log canonical threshold, RLCT); remedies (reparam/quotient; priors/penalties; constraints; profile; whiten).
  - Common threads: Fisher as a metric; identifiable‑subspace operations; whitening/diagonalization.
  - Rigor tweaks: concise, non‑controversial placement; no χ² claims in singular regimes.

- 6‑union‑bound
  - Unique adds: Chung–Erdős refinement; cumulant‑truncation (Möbius inversion) viewpoint; Bonferroni as order‑k truncation.
  - Common threads: bridges events to information (entropy/MI/cumulants); connects to Bethe/factor graphs and higher‑order MI.
  - Rigor tweaks: maintain inequality form and notation consistency.

- 7‑permanent (expanded)
  - Unique adds: toolbox (block/reducible, treewidth DP, JSV FPRAS for nonnegative, Bethe/loopy BP; Ryser/Glynn with Gray‑order bitsets); workload strategy O(n·3^n) for many subpermanents.
  - Common threads: factor‑graph/Bethe tie‑in; multiplicativity over direct sums.
  - Rigor tweaks: planarity caveat (Pfaffians for matchings, not permanents); scope JSV to nonnegative inputs.

### Cross‑Cutting Links

- Signals ↔ Precision/Spacetime ↔ Stationary Measures: 2Bt DoF, waterfilling, BCCB diagonalization.
- Immanants ↔ Matrix Identities ↔ Tests: block‑hafnian identity, structure checklist, permanent toolbox.
- Union Bound ↔ Moments/Cumulants ↔ MI/Higher‑Order: CE inequality, cumulant truncations, XOR example.
- Pilots ↔ Factor Graphs ↔ Snapshots: lane kit and decoding intuition, multiresolution glimpses, interleaving schedules.
- Fisher ↔ Riemannian/Whitening ↔ Submodular: RLCT caveat, identifiable directions, selection strategies.

### Verification Checklist

- Algebraic identities: per=haf block lift; Schur/Jacobi intact; multiplicativity on block sums.
- Inequalities: Chung–Erdős form; Fano consistency; dispersion notation for finite‑n.
- Graph/planarity caveats: Kasteleyn orientation note; Pfaffians for matchings, not permanents.
- Notation: unions/intersections consistent; DoF units clarified; log bases noted where relevant.
- Cross‑links: no duplicate statements; related sections point to each other rather than repeat.

### Optional Examples/Appendices

- Determinant vs permanent (2×2) and pfaff/haf (4×4) small matrices in Tests.
- Rank‑1 log‑det update via Cholesky; compare to exact recomputation.
- Finite‑blocklength numerics: R*(n,ε) for sample V and ε.
- Pilot lane kit mini example: tokens for base/sync/coords/parities/objects/CRC.

### Phased Plan and Delta Summary

- Phase 1 applied: core insertions across Immanants, Factor Graphs, Union Bound, Matrix Identities, Fisher, Precision/Spacetime, Log‑Det, Pilots, Snapshots.
- Phase 2 (optional): add examples in Tests; small Stationary Measures note on Kronecker separability.
- Phase 3 (optional): appendices for Ryser/Glynn Gray‑order sketch; interleaver design notes; Cholesky update snippet.
- Delta: this integration plan mirrors what’s already in this sketch; remaining items are optional examples and appendices.
 - For detailed proofs/recipes, see Appendices A–Y in `paper.md` (det lemma/Schur/Jacobi; Toeplitz/BCCB; cumulants/Bonferroni; submodular guarantees; permanents; ARC pilots→graphs→attention; SLT/RLCT; waterfilling KKT/majorization; rank correlations; Construction A; VC/sample‑complexity; numeric examples; Bethe free energy; notation; section map; references; LDPC/Turbo links; RCU/error exponents; Cholesky updates; exponential families; spectral coherence; covering arrays).
