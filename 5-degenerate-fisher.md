# 5-degenerate-fisher: Distillation and Organization

**Summary**
- Explains degenerate Fisher Information Matrices (FIM) in singular learning theory (SLT). When the FIM has zero eigenvalues, classical asymptotics fail; models are treated as algebraic varieties. Covers causes (non‑identifiability, symmetries), consequences (non‑Gaussian posteriors, non‑χ² LRT), and remedies.

**What “Degenerate FIM” Means**
- For model p_θ(x) with score s_θ(x) = ∇_θ log p_θ(x), Fisher `I(θ) = E[s_θ s_θ^T] = −E[∇_θ^2 log p_θ]`.
- Degeneracy: I(θ) is PSD but not PD (rank deficient) ⇒ non‑invertible metric; some directions leave p_θ unchanged to first order.

**Equivalent Perspectives**
- Local non‑identifiability: ∃ v ≠ 0 with p_{θ+tv} = p_θ + o(t) (to first order).
- Parameter symmetries: permutations/scalings yield same distribution (mixture components, ReLU networks with dead paths).
- Overparameterization/flat minima: many configurations map to the same function near optimum.

**Consequences**
- Bayesian posterior is not asymptotically normal; MAP/MLE rates depend on real log canonical threshold (RLCT), not parameter count.
- Likelihood‑ratio tests are not χ²; BIC with (d/2) log n penalty is invalid; singular BIC uses RLCT instead.

**Remedies and Practices**
- Reparameterize to identifiable coordinates; quotient by symmetry groups.
- Add informative priors or penalties; constrain architectures (weight tying, orthogonality) to lift degeneracies.
- Use profile likelihood along identifiable subspaces; compute local Hessian spectra; whiten identifiable directions.

**Links to sketch.md**
- Fisher as Riemannian metric; diagonalization/whitening; curvature and submodularity (select informative directions); stationary approximations for stable updates.

