# 2-signals: Distillation and Organization

**Summary**
- Maps asymptotic and finite‑blocklength laws for reliability under stationary noise. Connects bandwidth/time degrees of freedom, capacity/waterfilling, randomization (scrambling/interleaving), replication (redundancy/coding), and error exponents/normal approximations.

**Core Laws**
- Time–bandwidth degrees of freedom (DoF): ≈ 2Bt real DoF over duration t and bandwidth B.
- Gaussian capacity: AWGN `C = B log2(1+SNR)`; colored noise via waterfilling over PSD N(f): `SX(f)=(ν−N(f))_+`.
- Wideband limit: minimal Eb/N0 = ln 2 (≈ −1.59 dB).
- Finite‑blocklength (normal approx): `R*(n,ε) ≈ C − √(V/n) Q^{-1}(ε)`; dispersion V depends on channel.

**Design Levers**
- Scrambling/interleaving: distribute symbols across time/frequency to whiten effective noise/erasures and realize waterfilling gains.
- Replication/coding: trade rate for error; choose codes with good distance and iterative decoders (LDPC/Polar/Reed–Solomon for bursts).
- Pilot placement: use positional (sync strings/hierarchical coordinates) and spectral pilots (checksums) for estimation and alignment.

**Stationarity and Diagonalization**
- Toeplitz/BCCB structure for stationary processes; diagonalize approximately by DFT (or exactly for block‑circulant) to decouple modes.
- Use Kronecker factorizations for separable 2D/3D fields to reduce complexity and shape spectra.

**Error Bounds and Exponents**
- Union bound and refinements (Chung–Erdős) to aggregate component error events; Gallager/RCU bounds for coding.
- Large deviations and Chernoff information for detection; submodular selection of pilot/measurement sets for robust inference.

**Links to sketch.md**
- Capacity/waterfilling; stationary measures (Toeplitz/BCCB); union‑bound/submodularity; pilots and nested lattices; dyadic windows/glimpses.
