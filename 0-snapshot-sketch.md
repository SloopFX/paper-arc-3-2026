# 0-snapshot ↔ sketch.md

**Direct Mappings**
- Stationary Measures → snapshot’s BCCB/Toeplitz assumptions for fast updates (`sketch.md`: Stationary Measures).
- Log‑Det Updates → snapshot’s rank‑k change accounting (`sketch.md`: Log‑Det Updates).
- Submodularity/Curvature → selecting glimpses/dyadic windows (`sketch.md`: Submodular, Synergy).
- Pilots/Glimpses → snapshot lanes for synchronization and checks (`sketch.md`: One‑Line Sketch; Dyadic Windows; Glimpse).

**2×2 Comparison**
- Unique to 0-snapshot.txt
  - Operational snapshot format, hashing, delta pipelines; explicit latency/token economics.
- Unique to sketch.md
  - Formal immanant/pfaff/haf structure; Wick pairings; majorization.
- Common
  - Multiresolution views; diagonalization for stability; union‑bound/submodular selection.
- Refinements to sketch.md
  - Add a short “Snapshot Protocols” subsection under “One‑Line Sketch; Dyadic Windows; Glimpse” describing prefix‑free IDs, hashing, and delta caching.
  - Note log‑det/Woodbury as the numerical backbone for state updates.

