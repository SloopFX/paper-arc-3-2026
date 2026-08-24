% 0-snapshot: Distilled Additions to sketch.md (Round 1)

**Proposed additions to sketch.md**
- Snapshot protocols (placement: One‑Line Sketch; Dyadic Windows; Glimpse)
  - Add bullet: “Snapshot protocols: prefix‑free IDs, hashing, and delta caches for low‑latency state reuse; keep numerical summaries (e.g., Cholesky factors) for rank‑k updates.”
- Numerical backbone (placement: Log‑Det Updates)
  - Add sentence: “Operationally, maintain Cholesky/LDLᵀ factors and apply det lemma/Woodbury for rank‑k snapshot updates.”
- Multiresolution scheduling (placement: Submodular, Synergy)
  - Add note: “Select dyadic windows/glimpses greedily using submodularity/curvature to budget snapshot bandwidth.”

**Already integrated in sketch.md**
- Snapshot protocols bullet under One‑Line Sketch/Dyadic Windows/Glimpse.
- Log‑det updates via det lemma; Cholesky/QR reference.

**Rationale**
- Codifies the operational layer (IDs, hashes, deltas) and ties it to numerical stability and submodular selection.

---

## Round 2 Refinements
- Add internal anchors in sketch.md for easy reference to sections (optional).
- Clarify numerical note to mention both Cholesky and LDLᵀ explicitly; store factor timestamps to avoid recomputation.
- Consider a tiny “snapshot delta schema” example under One‑Line Sketch or Tests if examples are later consolidated.

## Round 3 Finalization
- Final text to insert (One‑Line Sketch…): “Snapshot protocols: prefix‑free IDs, hashing, delta caches; retain Cholesky/LDLᵀ factors to enable rank‑k det lemma/Woodbury updates.”
