# 6-union-bound: Distillation and Organization

**Summary**
- Relates union bounds (first‑order truncations) and submodularity (structured diminishing returns). Connects cumulant expansions, determinant/permanent/pfaffian/hafnian roles, whitening/sphering, and design across information theory, linear algebra, graph theory, and lattices.

**Union Bound and Refinements**
- Boole: `P(⋃ A_i) ≤ Σ P(A_i)`; ignores interactions.
- Inclusion–exclusion/Bonty: add higher‑order intersections; Chung–Erdős tightens using pairwise overlaps.
- Cumulants: Möbius inversion isolates connected interactions; truncation = principled order selection.

**Submodularity**
- Many information measures are submodular (entropy, mutual information in fixed families). Greedy selection yields `(1−1/e)`; submodularity ratio/curvature adjust guarantees when approximate.

**Linear‑Algebraic Anchors**
- Determinant/log‑det concavity; Schur complements; majorization and waterfilling (spectral resource allocation).
- Pfaffian/hafnian and matchings structure event interactions for planar/general graphs.

**Whitening/Sphering**
- Remove nuisance correlations; diagonalize covariance to separate modes and enable independent event bounding and allocation.

**Graphical/Bethe**
- Factor graphs encode constraints; Bethe free energy yields tractable approximations (e.g., Bethe permanent) with loopy BP.

**Lattices and Precision**
- Nested lattices (Construction A) for shaping/coding; CRT/Singer sets for pilot/sync design; precision and quantization tradeoffs.

**Links to sketch.md**
- Union bound ↔ submodularity/cumulants; waterfilling/majorization; pilots/nested lattices; tests for det/per/pf/haf differences.

