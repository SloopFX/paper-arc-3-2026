# Sketch Update Proposal: Detailed Integration Plan

**Summary**
- Purpose: capture a deep, actionable plan for enriching `sketch.md` based on the ranked themes and items (0–7). This plan documents insertions, rationale, cross-links, verification, examples, and a phased approach.
- Inclusion order (aggregate across 7 themes): 2-signals, 7-permanent, 1-immanant, 6-union-bound, 3-arc, 4-submodular, 0-snapshot, 5-degenerate-fisher.
- Editing principles: preserve current style (tight bullets, concise one‑liners), insert under existing section headers, avoid redundancy by cross-linking rather than repeating.

**Global Editing Principles**
- Brevity with precision: prefer one‑line identities and placement notes over new subsections unless necessary.
- Cross-link, don’t duplicate: reference related sections (e.g., cumulants from union bound to moments/cumulants).
- Numerical stability: prioritize rank‑k updates (det lemma/Woodbury) and factor storage (Cholesky/LDLᵀ) in operational bullets.
- Structure-first: check block sums, planarity, and treewidth early to choose exact vs approximate methods.

**Section-by-Section Changes (Final Insertions + Rationale + Checks)**

1) Immanants, Determinant, Permanent, Pfaffian, Hafnian, Matchings
- Insertions (final text)
  - “Identity: per(C)=haf([[0,C],[C^T,0]]).”
  - “Structure checklist: block sums; planar (Kasteleyn/|pf| matchings); low treewidth (DP).”
- Rationale: clarifies reduction pathways and flags exploitable structure.
- Cross-links: Wick Pairings (Gaussian → hafnian), Matrix Identities (Schur/Jacobi), Tests (2×2 det/per).
- Verification: confirm hafnian identity for rectangular C via block symmetric lift; ensure Kasteleyn note is qualified as planar‑specific.

2) When One Becomes Another; Cumulants and Gaussianity; Bethe Permanent; Factor Graphs
- Insertions (final text)
  - “Masked attention with graph‑aligned masks approximates parallel BP; depth‑T ≈ T rounds.”
- Rationale: decoding intuition linking transformers to factor‑graph inference.
- Cross-links: 3‑arc (lane kit), 6‑union‑bound (Bethe/cumulant lens).
- Verification: keep as “intuition” to avoid overclaiming equivalence; cite BP fixed‑point analogy in surrounding prose if needed later.

3) Union Bound; Submodularity Ratio; Diminishing Returns; Synergy
- Insertions (final text)
  - “Two‑term refinement (Chung–Erdős): P(⋃_i A_i) ≥ (Σ_i P(A_i))^2 / Σ_{i,j} P(A_i ∩ A_j).”
  - “Cumulant view: refinements correspond to truncating the cumulant expansion (Möbius inversion); Bonferroni = order‑k truncation.”
- Rationale: principled improvement path beyond Boole’s inequality.
- Cross-links: Moments/Cumulants, MI/Higher‑Order.
- Verification: check inequality form; maintain notation consistency (set unions/intersections).

4) Matrix Determinant Lemma; Flat Spectrum; Waterfilling; Majorization; Jacobi; Schur
- Insertions (final text)
  - “Permanent toolbox: detect block/reducible structure; try treewidth‑based DP on sparse graphs; for dense nonnegative matrices use JSV FPRAS or Bethe/loopy BP heuristics; implement Ryser/Glynn with Gray‑order bitsets for cache locality.”
- Rationale: pragmatic decision tree for otherwise intractable permanents.
- Cross-links: Immanants, Tests, 7‑permanent.
- Verification: qualify JSV as nonnegative‑only; remind that Pfaffians don’t compute permanents on bipartite graphs.

5) Stationary Measures (no direct insertion this round)
- Note: keep as reference for BCCB/Toeplitz diagonalization; cross‑link from Signals and Snapshots.
- Future optional: small note about Kronecker separability in higher‑D stationary fields.

6) Diagonalize Fisher Information, KL, VC Dimension, Kendall’s Tau
- Insertions (final text)
  - “Singular models (degenerate Fisher): replace χ²/BIC with singular learning theory (real log canonical threshold, RLCT); operate on identifiable subspaces.”
  - “Remedies: reparameterize/quotient symmetries; add informative priors/penalties; constrain architectures; use profile likelihood; whiten identifiable directions.”
- Rationale: equips Fisher section for non‑regular cases.
- Cross-links: Precision/Riemannian (geometry), Submodular (direction selection relevance).
- Verification: ensure SLT phrasing is concise and non‑controversial; no claims of general χ² recovery.

7) Log‑Det Updates; Curvature; Pairwise and Higher‑Order MI; Long‑Range Cancellation
- Insertions (final text)
  - “Finite‑blocklength note: for limited snapshot windows, achievable rate R*(n, ε) ≈ C − √(V/n) Q^{-1}(ε) links reliability to dispersion V; motivates multiresolution snapshots.”
- Rationale: connects information‑theoretic reliability to snapshot design.
- Cross-links: Signals, Snapshots/Glimpses.
- Verification: clarify Q^{-1} is Gaussian tail inverse if later detailed.

8) Whiten, Sphere, Covering Arrays (CAs), Sequential CAs (SCAs)
- No new text; ensure cross‑refs from Submodular and Snapshots remain.

9) Precision, Quantization, Spacetime Coordinates, Riemannian Geometry
- Insertions (final text)
  - “Degrees of freedom (DoF): ≈ 2Bt real DoF over duration t and bandwidth B.”
- Rationale: capacity‑level link to window sizing and design.
- Cross-links: Signals, Stationary Measures.
- Verification: maintain units (real DoF vs complex uses).

10) Tests to Separate “Eyeball Width” of Immanants, Moments, etc.
- Optional future additions (examples): 2×2 det/per, 4×4 pfaff/haf, log‑det rank‑1 update stability check, XOR triplet MI.
- Rationale: concrete diagnostics aligning with inserted identities.

11) Fano Certificate; Fano Inequality; Capacity; Degrees of Freedom; Normal Approximation
- Already robust; ensure consistency with finite‑blocklength note in Log‑Det section.

12) CRT, Singer Difference Sets, Pilots (Positional/Spectral, Absolute/Relative), Nested Lattices, Planar Matchings
- Insertions (final text)
  - “Minimal lane kit (practical): base serialization, global sync string, hierarchical coordinates, row/col/window parities, object‑level invariants, end‑to‑end CRC.”
  - “Interleaving: Use scrambling/interleaving (de‑Bruijn/PRN schedules) to decorrelate constraints and realize waterfilling across resources.”
  - “Mixed‑radix/disjoint alphabets: use separate alphabets per lane/scale to avoid collisions/interference.”
- Rationale: portable systemization of pilot design.
- Cross-links: Factor Graphs (decoding), Signals (waterfilling), Snapshots (glimpses).
- Verification: keep terms implementation‑agnostic; no dependency on specific codes.

13) Wick Pairings; Kronecker/BCCB; Lempel–Ziv
- No changes; ensure link to Immanants and Stationary Measures is intact.

14) One‑Line Sketch; Dyadic Windows; Glimpse
- Insertions (final text)
  - “Snapshot protocols: prefix‑free IDs, hashing, and delta caches for low‑latency state reuse; retain Cholesky/LDLᵀ factors to enable rank‑k det lemma/Woodbury updates.”
- Rationale: operationalizes snapshots with numerically stable updates.
- Cross-links: Log‑Det Updates, Submodular (selection), Stationary Measures (diagonalization assumptions).
- Verification: keep wording concise; consistent terminology (rank‑k, det lemma/Woodbury).

**Cross-Cutting Link Map**
- Signals ↔ Precision/Spacetime ↔ Stationary Measures: 2Bt DoF, waterfilling, BCCB diagonalization.
- Immanants ↔ Matrix Identities ↔ Tests: block‑hafnian identity, structure checklist, permanent toolbox.
- Union Bound ↔ Moments/Cumulants ↔ MI/Higher‑Order: CE inequality, cumulant truncations, XOR example.
- Pilots ↔ Factor Graphs ↔ Snapshots: lane kit and decoding intuition, multiresolution glimpses, interleaving schedules.
- Fisher ↔ Riemannian/Whitening ↔ Submodular: RLCT caveat, identifiable directions, selection strategies.

**Examples/Appendices (Optional Additions)**
- Determinant vs Permanent (2×2): numeric example in Tests.
- Pfaff/Haf (4×4): planar vs non‑planar sensitivity snapshot.
- Rank‑1 log‑det update: stable computation via Cholesky; compare exact vs update.
- Finite‑blocklength: R*(n,ε) numeric for sample V and ε.
- Pilot lane kit mini example: token sketches for lanes and sync string.

**Verification Checklist**
- Algebraic identities: per=haf block lift correctness; Schur/Jacobi formulas intact.
- Inequalities: CE inequality form; Fano consistency; dispersion notation.
- Graph/planarity caveats: Pfaffians for matchings, not permanents; Kasteleyn orientation noted.
- Notation consistency: bold vs italics, use of Σ/∑/Π/∏, set unions/intersections.
- Cross-links: no broken references; avoid duplicate statements across sections.

**Risks and Mitigations**
- 3‑arc novelty: frame masked attention ≈ BP as intuition; keep lane kit generic; ensure no overclaims.
- 0‑snapshot operationality: keep vendor‑neutral; emphasize standard numerical tools.
- 5‑degenerate‑fisher niche: concise and targeted; no heavy detour from main flow.

**Phased Plan**
- Phase 1 (done): Core insertions across sections above; deduplicated language.
- Phase 2 (optional): Add concise examples in Tests; small cross‑link notes in Stationary Measures.
- Phase 3 (optional): Appendices for recipes (Ryser/Glynn Gray‑order sketch; interleaver design notes; Cholesky update snippet).

**Delta Summary (Applied vs Planned)**
- Applied: all insertions listed in sections 1–4, 6–7, 9, 12, 14.
- Planned (optional): examples, small Stationary Measures cross‑note, appendices.

---

## Per‑Document Contributions (What Each Doc Adds)

This section summarizes each of the 8 docs (0–7) with Unique Adds, Common Threads, Rigor Tweaks, and Integration Hooks. Items 2‑signals and 7‑permanent are expanded with extra detail.

### 0‑snapshot
- Unique adds
  - Snapshot protocols: prefix‑free IDs, hashing, delta caches; numerical update backbone via det lemma/Woodbury with Cholesky/LDLᵀ.
  - Multiresolution snapshots: dyadic windows and “glimpse” scheduling.
- Common threads
  - Diagonalization for stability (stationarity/BCCB); submodular selection for bandwidth budgeting.
- Rigor tweaks
  - Keep vendor‑neutral and implementation‑agnostic; stress standard numerical routines and bounded update ranks.
- Integration hooks
  - One‑Line Sketch; Dyadic Windows; Glimpse; Log‑Det Updates; Submodular.
 - Status: already maintained.

### 1‑immanant
- Unique adds
  - Identity per(C)=haf([[0,C],[C^T,0]]); structured “where one becomes another” lens.
  - Structure checklist (block sums, planar/Kasteleyn, low treewidth DP).
- Common threads
  - Wick/Gaussian reduction to 2nd order; block sums multiply.
- Rigor tweaks
  - Small matrices in Tests to demonstrate sign differences (already linked). Keep Kasteleyn remark qualified (planar graphs); reference hafnian block‑lift construction.
- Integration hooks
  - Immanants section; Tests; Matrix Identities.
 - Status: already maintained.

### 2‑signals (expanded)
- Unique adds
  - Finite‑blocklength normal approximation: R*(n,ε) ≈ C − √(V/n) Q^{-1}(ε), framing reliability‑vs‑window tradeoffs.
  - Explicit degrees of freedom: ≈ 2Bt (real) over duration t and bandwidth B; aligns window sizing with capacity intuition.
  - Interleaving recipes: de‑Bruijn/PRN schedules to decorrelate constraints and realize waterfilling; coding choices for bursts vs random noise.
  - Wideband/low‑SNR benchmark (Eb/N0 → ln 2) for energy‑limited regimes.
- Common threads
  - Waterfilling/majorization; BCCB/stationarity diagonalization; pilots interplay (positional + spectral checks) for estimation and sync.
- Rigor tweaks
  - Point to dispersion V definitions and canonical closed‑form examples (e.g., AWGN and binary‑memoryless symmetric channels) as per Polyanskiy–Poor–Verdú; avoid numeric claims unless parameters are specified.
  - Clarify Q^{-1} is the Gaussian tail inverse; note units (bits vs nats) when using log bases.
- Integration hooks
  - Precision/Spacetime (2Bt DoF); Log‑Det (finite‑n note); Pilots (interleaving); Stationary Measures (BCCB/Kronecker links).
 - Status: already maintained.

### 3‑arc
- Unique adds
  - Minimal lane kit; mixed‑radix disjoint alphabets; masked‑attention ≈ BP decoding intuition; auxiliary loss design.
- Common threads
  - Pilots as structural side‑info; factor‑graph view; submodular glimpse scheduling.
- Rigor tweaks
  - Frame BP equivalence as intuition; keep lanes generic, not tied to specific code families.
- Integration hooks
  - Pilots; Factor Graphs; Submodular; Snapshots.
 - Status: already maintained.

### 4‑submodular
- Unique adds
  - MDL cascade equations with stop rule (Δgain/Δcost ≤ 1; curvature c, ratio γ guidance).
- Common threads
  - Greedy selection guarantees; diminishing returns when approaching saturation.
- Rigor tweaks
  - Specify Δgain/Δcost stop rule text (added). Keep curvature/ratio definitions compact; avoid overpromising guarantees beyond standard results.
- Integration hooks
  - Submodular; Snapshots/Glimpses; Tests (toy diminishing‑returns checks).
 - Status: already maintained.

### 5‑degenerate‑fisher
- Unique adds
  - SLT caveat (real log canonical threshold, RLCT); remedies (reparam/quotient, priors/penalties, constraints, profile, whiten).
- Common threads
  - Fisher as Riemannian metric; operate on identifiable subspaces; diagonalization/whitening.
- Rigor tweaks
  - Acronym spelled out; concise, non‑controversial placement. Keep concise; no χ² assertions; emphasize identifiable‑subspace operations.
- Integration hooks
  - Fisher; Riemannian; Submodular (direction selection).
 - Status: already maintained.

### 6‑union‑bound
- Unique adds
  - Chung–Erdős two‑term refinement; cumulant‑truncation (Möbius inversion) viewpoint; Bonferroni as order‑k truncation.
- Common threads
  - Bridges events/probability to information measures and cumulants; connects to factor‑graph/Bethe and to MI/higher‑order sections.
- Rigor tweaks
  - Optional cite or formula for Bonferroni order‑k truncations (not necessary to include now). Maintain exact inequality form; align notation for unions/intersections.
- Integration hooks
  - Union Bound; Moments/Cumulants; MI/Higher‑Order; Matrix Identities (majorization/waterfilling context).
 - Status: already maintained.

### 7‑permanent (expanded)
- Unique adds
  - Toolbox: detect block/reducible structure; treewidth‑based DP for sparse graphs; JSV FPRAS for nonnegative matrices; Bethe/loopy BP heuristics otherwise; implement Ryser/Glynn with Gray‑order bitsets for cache locality.
  - Workload strategy: per‑subset dynamic programming O(n·3^n) for many principal subpermanents; caching/Gray‑order to reduce overhead.
- Common threads
  - Factor‑graph/Bethe tie‑in for approximations; multiplicativity over direct sums.
- Rigor tweaks
  - Clarify planarity caveat: Pfaffians enable counting perfect matchings on general graphs with orientations (FKT), but do not yield bipartite permanents; avoid implying Pfaffians compute permanents.
  - Scope JSV: nonnegative entries only; complexity is polynomial in n and 1/ε.
- Integration hooks
  - Matrix Identities (Permanent toolbox bullet); Immanants; Tests (2×2 det/per; small k Ryser/Glynn experiments).
 - Status: already maintained.
