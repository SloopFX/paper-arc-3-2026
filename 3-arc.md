# 3-arc: Distillation and Organization

**Summary**
- Proposes encoding ARC-AGI tasks with extra lanes carrying positional and spectral pilots, making off‑diagonal (phase) structure explicit. Casts decoding as message passing on a factor graph, with transformers approximating BP. Suggests disjoint alphabets (mixed‑radix) and optional nested‑lattice wrapping.

**Lane Taxonomy**
- Base lane: prefix‑free serialization of grid (dims, palette, RLE per row/col).
- Positional pilots: synchronization strings + hierarchical coordinates (coarse→fine tiles), each level with a disjoint alphabet.
- Spectral pilots: row/col parities over colors (small primes), sliding‑window checksums, object‑level invariants (component IDs, histograms, perimeter/area parity), global CRC.

**Graphical Model and Decoding**
- Factor graph: variables = grid cells/objects; factors = parity/window/object constraints; edges reflect checks per cell.
- Masked attention ≈ parallel sum–product updates when masks mirror factor adjacency; depth‑T transformer ≈ T BP rounds.
- Interleaving/scrambling (de‑Bruijn or PRN) decorrelates constraints—akin to Turbo/LDPC practice.

**Algebraic Wrapping (Optional)**
- Map lanes to rings Z_{p^ℓ}; use Construction A to embed in lattices; use coarse lattice for shaping, fine lattice for checks. Keep dimensions modest.

**Theoretical Anchors**
- Synchronization strings for positional pilots (handle ins/del).
- Slepian–Wolf/Gelfand–Pinsker for “erasing nuisances” with side information U: maximize I(U;Y)−I(U;S).

**Experiments**
- Ablate each lane to measure its marginal value (mutual information proxy via accuracy drop).
- Train auxiliary losses to enforce checks (base reconstruction, parities, windows, object invariants, sync recovery).

**Links to sketch.md**
- Pilots (positional/spectral); nested lattices; factor graphs/Bethe; submodular selection of glimpses/windows; dyadic windows.

