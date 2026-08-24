# 0-snapshot: Distillation and Organization

**Summary**
- Captures a design pattern for fast, reliable conversational work: use prefix-free “snapshots” of state to avoid expensive recaps, combine multiresolution summaries (dyadic windows/glimpses), and use algebraic structure (block decomposition, matchings) for efficient updates.
- Goal: minimize token and latency overhead while preserving information needed for correct reasoning and reproducibility.

**Core Ideas**
- Prefix-free canonicalization: structure every state artifact (prompt, plan, context) with stable headers/IDs to enable lossless reuse, chunking, and hashing.
- Multiresolution context: keep coarse summaries at large scale, finer slices for active regions (“dyadic windows”), and tiny “glimpses” on demand.
- Stable incremental updates: prefer rank‑k/det‑lemma forms for log‑det/Fisher/KL tweaks; track block separations so products (det/pf/haf/per) factor over direct sums.
- Snapshots vs model recaps: precompute “state deltas” externally (cheap tokens) instead of burning model tokens to regenerate them; cache and reuse across tasks.

**Mathematical Lens**
- Information budget: treat snapshot cost as rate R and require it to preserve MI with the next step’s targets; bound loss via Fano/normal approximation.
- Stationarity and diagonalization: when state evolves slowly, assume approximate stationarity and keep BCCB/Kronecker summaries for fast spectral updates.
- Cumulant truncation: exploit that high‑order cumulants are small/zero (Gaussian-ish cores), so low‑order structure plus local corrections suffice.

**Operational Recipes**
- State object = {plan, diffs, focus windows, invariants}. Store deltas with hashes; ensure prefix‑free format for streaming assembly.
- Use dyadic partitioning of files/buffers to address and splice; compute summaries bottom‑up; update only affected nodes.
- For numerical summaries, keep Cholesky/LDLᵀ factors and apply det lemma/Woodbury for rank‑k deltas.

**Links to sketch.md**
- Stationarity/BCCB; log‑det updates; submodularity/curvature for view selection; immanant multiplicativity for block structure; pilots/glimpses.
