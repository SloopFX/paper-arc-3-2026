# Hypertokens — technical reference

This is a compact “good to know” reference distilled from the old sketches. It is not evidence for `vCORE.md`, not a citation substitute, and not a list of claims the paper currently makes. Verify primary sources before promoting an item into the paper.

## 1. Probability and information

### Event bounds

- Union bound: \(P(\bigcup_i A_i)\le\sum_iP(A_i)\).
- Inclusion–exclusion supplies alternating corrections when intersections are available.
- Chung–Erdős lower bound:
  \[
  P\!\left(\bigcup_iA_i\right)\ge
  \frac{\left(\sum_iP(A_i)\right)^2}
       {\sum_{i,j}P(A_i\cap A_j)}.
  \]

### Fano and finite blocklength

- For \(M\) equiprobable classes and error probability \(P_e\), one common Fano form is
  \[
  P_e\ge 1-\frac{I(W;Y)+\log 2}{\log M},
  \]
  with consistent log units.
- A normal approximation for many regular memoryless channels is
  \[
  R^*(n,\epsilon)\approx C-\sqrt{V/n}\,Q^{-1}(\epsilon),
  \]
  where \(V\) is channel dispersion. It is not model-free.
- A real signal limited to duration \(T\) and bandwidth \(B\) has roughly \(2BT\) real degrees of freedom under standard time–bandwidth conventions; complex baseband bookkeeping uses roughly \(BT\) complex degrees of freedom.
- Rate–distortion theory minimizes \(I(X;\hat X)\) subject to an expected distortion constraint. A shorter serialization alone is not a rate–distortion result.

## 2. Moments cumulants and dependence

- Moments come from derivatives of a moment-generating function when it exists; cumulants come from derivatives of its logarithm.
- All cumulants above order two vanish for a Gaussian distribution. Heavy-tailed distributions may not possess the needed moments or cumulants.
- Wick’s theorem writes even centered-Gaussian moments as sums over pairings.
- Pairwise mutual information can miss higher-order dependence. XOR-style examples are useful diagnostics, although the sign of “interaction information” depends on convention.
- Claims that long-range effects cancel require an explicit mixing or decay assumption; locality does not follow from a cumulant vocabulary alone.

## 3. Submodularity and experiment selection

- A set function \(f\) is submodular when marginal gain decreases with a larger conditioning set:
  \[
  \Delta(x\mid A)\ge\Delta(x\mid B)\quad\text{for }A\subseteq B.
  \]
- Monotone submodular maximization under a cardinality constraint admits the standard greedy \(1-1/e\) guarantee.
- Curvature and the submodularity ratio quantify departures from modularity or exact submodularity and can refine guarantees, but their definitions and assumptions must be frozen with the objective.
- Covering arrays provide interaction coverage without a full factorial. They are design tools, not proof that untested higher-order interactions are absent.

## 4. Matrix and spectral tools

### Low-rank updates

- Matrix determinant lemma:
  \[
  \det(A+UV^T)=\det(A)\det(I+V^TA^{-1}U)
  \]
  for invertible \(A\).
- Woodbury identity:
  \[
  (A+UCV^T)^{-1}=A^{-1}-A^{-1}U(C^{-1}+V^TA^{-1}U)^{-1}V^TA^{-1}.
  \]
- Schur complement:
  \[
  \det\!\begin{pmatrix}A&B\\C&D\end{pmatrix}
  =\det(A)\det(D-CA^{-1}B)
  \]
  when \(A\) is invertible.
- Stable implementations normally update Cholesky QR or LDLᵀ factors rather than explicitly forming inverses.

### Spectra and stationarity

- Waterfilling allocates power over parallel Gaussian modes as \(p_i=(\mu-1/\lambda_i)_+\), with the convention for \(\lambda_i\) stated explicitly.
- Majorization orders vectors by partial sums; Schur-convex and Schur-concave functions respond oppositely to that order.
- Circulant and block-circulant-with-circulant-block matrices diagonalize by one- and two-dimensional discrete Fourier transforms. Toeplitz-to-circulant replacement is generally approximate and boundary-dependent.
- A unitary DFT preserves energy. Library normalization conventions differ.
- Whitening standardizes covariance on identifiable directions; it does not manufacture independence or semantic orthogonality.

## 5. Matching functions

- The immanant
  \[
  \operatorname{Imm}_\chi(A)=\sum_{\sigma\in S_n}\chi(\sigma)\prod_i a_{i,\sigma(i)}
  \]
  specializes to the determinant for the sign character and to the permanent for the trivial character.
- For even skew-symmetric \(A\), \(\operatorname{pf}(A)^2=\det(A)\).
- The hafnian is the unsigned perfect-matching sum for an even symmetric matrix.
- For square \(C\),
  \[
  \operatorname{per}(C)=
  \operatorname{haf}\!\begin{pmatrix}0&C\\C^T&0\end{pmatrix}.
  \]
- Determinant permanent pfaffian and hafnian factor over compatible direct sums.
- Permanents count perfect matchings in bipartite graphs; hafnians do so for general undirected graphs. Pfaffian methods count planar perfect matchings after an appropriate Kasteleyn orientation; this structural condition matters.
- Exact permanent computation is generally expensive. Useful structure includes block decomposition low treewidth and planarity. Ryser or Glynn formulas suit small dense instances; the Jerrum–Sinclair–Vigoda approximation applies to nonnegative matrices; Bethe or loopy-belief-propagation methods are heuristics on loopy graphs.

## 6. Statistical geometry

- Fisher information transforms as a local metric under regular reparameterization.
- Gaussian KL divergence decomposes in a shared eigenbasis when the covariance matrices commute.
- Rank-deficient Fisher information signals non-identifiability or singularity. Classical chi-square and BIC asymptotics may fail; remedies include quotienting symmetries constraining the model profiling and working on identifiable subspaces.
- Singular learning theory uses quantities such as the real log canonical threshold; it should not be invoked without a specified singular statistical model.
- VC dimension is a hypothesis-class property, not an operator to diagonalize. Linear separators with bias in \(\mathbb R^d\) have VC dimension \(d+1\) under the usual setup.

## 7. Coding sampling and synchronization motifs

- The Chinese remainder theorem gives a bijection between an integer modulo a product of pairwise-coprime moduli and its residue tuple. Error correction requires a restricted codebook corruption model and decoder beyond CRT uniqueness.
- Singer difference sets are finite-group constructions with controlled difference multiplicities; using them as synchronization or pilot patterns requires a concrete channel model.
- In nested-lattice notation the coarse lattice is normally a sublattice of the fine lattice: \(\Lambda_c\subseteq\Lambda_f\). Naming conventions should be declared.
- Interleaving can decorrelate burst errors under an appropriate stochastic model; it does not create independence for free.
- Separate alphabets for lanes or scales can prevent serialization collisions, but tokenizer collisions and model confusion must still be measured.
- A practical integrity stack may contain base serialization synchronization coordinates local parity object invariants and an end-to-end check. Each layer needs a distinct failure model and cost.

## 8. Sketches snapshots and multiresolution access

- Linear sketches such as AMS or CountSketch preserve declared aggregate properties with probabilistic guarantees; they do not preserve arbitrary downstream operations.
- Dyadic windows provide multiresolution intervals or blocks and support fast localized aggregation.
- Prefix-free IDs hashes and delta caches can support reusable snapshots. Correctness additionally requires invalidation provenance privacy and revocation rules.
- Hashing and compression lengths can be useful empirical proxies, but compression-derived mutual-information estimates are estimator-dependent.
- Adaptive “glimpses” can be framed as bandit or submodular selection only after defining the observation action reward and cost.

## 9. Analogy guardrails

- Belief propagation is exact on trees under its usual factorization assumptions. “Masked attention resembles parallel BP” is a mechanism hypothesis, not an equivalence.
- A factor-graph account must specify variables factors messages schedule and readout.
- Planarity stationarity Gaussianity and independence are assumptions, not metaphors.
- Information capacity belongs to a named channel and resource constraint. An embedding dimension prompt length or token inventory is not by itself a capacity.
- Numerical identities about an external compiler do not imply that a language model represents or executes those identities.
