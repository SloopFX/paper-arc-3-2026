# 2-signals: Distilled Additions to sketch.md (Round 1)

**Proposed additions to sketch.md**
- Finite‑blocklength reliability (placement: Log‑Det Updates / MI section)
  - Add note: “Finite‑blocklength: `R*(n, ε) ≈ C − √(V/n) Q^{-1}(ε)`; dispersion V ties snapshot size to reliability.”
- Degrees of freedom (placement: Stationary Measures or Quantization/Spacetime)
  - Add bullet: “Time–bandwidth DoF ≈ 2Bt (real) over duration t, bandwidth B.”
- Practical interleaving (placement: Pilots section)
  - Add sentence: “Use scrambling/interleaving (e.g., de‑Bruijn/PRN) to realize waterfilling and decorrelate constraints.”

**Already integrated in sketch.md**
- Finite‑blocklength note partially added; waterfilling/majorization present; pilots mention added.

**Rationale**
- Connects communication‑theoretic limits to snapshot design (size, mixing) and pilot practices.

---

## Round 2 Refinements
- Specify placement for 2Bt DoF under “Precision, Quantization, Spacetime Coordinates, Riemannian Geometry” with a cross-link to Stationary Measures.
- Add a one-liner under Pilots: “Interleave via de‑Bruijn/PRN schedules to flatten burst errors.”
- If adding formulas, include the wideband Eb/N0 → ln 2 mention in Signals context (kept concise).

## Round 3 Finalization
- Final text to insert (Precision/Spacetime): “Degrees of freedom (DoF): ≈2Bt real DoF over duration t, bandwidth B.”
- Final text to insert (Pilots): “Use scrambling/interleaving (de‑Bruijn/PRN) to decorrelate constraints and realize waterfilling.”
