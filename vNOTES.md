# Hypertokens — unresolved decisions and future work

`vCORE.md` is the current methods paper. This file holds only choices that can change the next revision or experiment, plus future programs with explicit promotion gates.

## 1. Decisions required before model calls

1. **Deployment:** choose a reliable raw API that exposes a stable model identifier, target tokenizer, prompt-only usage, decoding controls, and failure metadata. The claim is deployment-specific, so model prestige is secondary to auditability.
2. **Calibration:** use the offline versioned-selection generator, then retain difficulty cells where the sequential-ID arm has 20–60% whole-output risk. Freeze the private roster afterward.
3. **Budget:** define both equal-payload and equal-total-token estimands. Equal-payload conditions stay paired. Equal-total comparisons trace a workload frontier under the same generator and target prevalence; they do not handicap one arm with extra distractors.
4. **Inference:** use exact paired tests on discordant outcomes for directional contrasts, plus a frozen minimum effect and compatible confidence bound. Because every required claim must pass, test each intersection–union component at the declared alpha rather than Bonferroni-splitting alpha.
5. **Size:** choose document count by simulation over plausible discordant-pair rates and the minimum effect. The old \(n=64\) Hoeffding plan is too coarse for a 15-point target.
6. **Failures:** one confirmatory attempt per cell; non-completion is failure. Exploratory retries may diagnose infrastructure, but every retry remains in the cost and provenance record.

## 2. Versioned selection and task-conditioned ambiguity

The first task varies name count, versions per name, parts per version, and records per indexed block. Before execution, audit that:

- answers contain bodies, versions, and parts, never coordinate labels;
- no marker leaks target membership or output order;
- ordinary IDs and sparse indexes see identical target records in the equal-payload comparison;
- one query-independent hypertoken index is injected per block, never per source token;
- local index moves preserve payload, record layout, and the complete index multiset;
- RID assignment is independent of name, version, target membership, and output order; and
- equal-budget workloads come from the same generator and target prevalence.

A later paper may estimate a task-conditioned confusion graph. Vertices are candidate bindings; an edge connects alternatives that can change the required answer and are empirically confused under a frozen deployment. Possible programs:

- **A — empirical graph:** code only observed consequential confusions;
- **B — robust graph:** include uncertainty neighborhoods for sampling error and deployment drift; or
- **C — learned graph:** infer neighborhoods from open-model representations, then test held-out predictive value.

Promotion gate: a graph-derived code must beat ordinary IDs and a fixed-rate code at equal total cost, on held-out domains and codebooks.

## 3. Checks and corruption repair

Sequential IDs are primary. Restricted-range residue addresses belong only in a declared corruption-repair study.

The current v2 decoder fixture manufactures corruptions, supplies lookup tables, and explains the repair rule. It is useful for calibration—whether a model can execute the declared decoder—but not for the natural coordinate claim. Before any causal interpretation, add:

- an instruction-only arm with no corruption;
- a corruption-only arm without decoder instructions;
- a valid-check arm and a no-check arm; and
- a joint rule requiring valid checks to improve on no-check while broken checks worsen performance relative to valid checks.

External compiler work, including check construction and corruption planning, must be charged.

## 4. Closing state and the former momentum language

The first paper uses *closing state*. The general rubric-conditioned update \(E_r\) is not implemented by `src/momentum.py`; that module computes a modular weighted sum, now called a *modular moment*.

A future semantic-momentum claim needs a declared transformation \(T\), observable \(\psi\), and composition law, for example a tested covariance relation \(\psi(Tx)=\lambda\psi(x)\). Candidate programs are controlled translation-like actions, rubric transitions, or learned Koopman-style observables.

Promotion gate: held-out multi-step prediction plus a targeted intervention. Endpoint residues, evocative terminology, or decodability alone are insufficient.

## 5. Schedules and compiler surface

Odometer, accumulator, and polyphase schedules were removed from the paper because no current task uses them. Likewise, `bookmark`, `join`, `scan`, `score`, `restore`, and `route` remain design vocabulary, not current instructions.

A schedule can return only after it defines:

1. a sampled or filtered observable;
2. a state update and readout;
3. a baseline with the same spacing, repetition, and token cost; and
4. a held-out prediction that ordinary indexing does not make.

Serialization of a transform-related pattern is not execution of that transform.

## 6. Compression and native realizations

Keep three claims separate:

1. **reference compression:** a short address replaces a repeated value while a dictionary remains available;
2. **compressed computation:** useful operations occur on addresses without repeated expansion; and
3. **task-sufficient state:** payload-bearing state is discarded while every required downstream operation remains recoverable.

Only the first is available from syntax alone. The second needs reusable-computation baselines; the third needs an operation-specific sufficiency result.

If a black-box relation effect exists, later interventions may use reserved embeddings, adapters, a typed state sidecar, native registers, reinjection loops, or distillation with visible fields removed. Each rung needs shuffled-relation controls, held-out codebooks, matched training resources, and transfer across lengths and payload domains.

## 7. Mechanism, adaptation, and scaling

Behavioral effects precede mechanism stories. For an open model:

1. predict a representation or path change induced by a valid relation;
2. verify it on held-out inputs;
3. intervene on the candidate path; and
4. measure the predicted output consequence.

Possible tools include activation patching, local system identification, observability matrices, and nuisance-aware covariance or Fisher summaries. Decodability is not causal use.

Adaptive framing may allocate fields or checks only near a measured fidelity boundary. Compare offline calibration, online control, and joint learned compilation in that order. Each requires equal total cost and protection against policy-induced distribution shift.

Scaling questions—cross-model transfer, smaller-model substitution, repeated-context savings, and KV reduction—belong to reliable-workload frontiers, not a single universal context-capacity number.

## 8. Classical questions before harmonic or quantum claims

The original spread-spectrum, holographic, Krylov, and quantum language remains historical motivation. Before reintroducing it, answer nearer classical questions:

- Does a cyclic coordinate predict a held-out phase-sensitive effect beyond spacing and salience?
- Does a serialized schedule perform more than indexing?
- Does a fitted local dynamical model predict multi-step behavior and survive intervention?
- Does redundancy produce a measured recovery curve under a declared corruption model?

A stronger correspondence must define state space, operators, dynamics, channel, measurement, recovery map, and resources, then make a prediction unavailable from classical coding, estimation, or group representation.

## 9. Token realization and carrier hypotheses

Private Use Area code points, reserved strings, or compact symbol tuples are candidate serializations, not intrinsically privileged hypertokens. Never assume that a symbol is atomic, absent from training, still randomly initialized, Gaussian, or near-orthogonal. For a frozen deployment:

1. audit the exact tokenizer realization and prompt cost;
2. for open models, measure embedding norms and pairwise geometry with a declared normalization or whitening rule;
3. compare PUA symbols with ordinary random labels, matched ASCII strings, and repeated-label controls;
4. require a non-ceiling behavioral effect and a relation break, not geometry alone; and
5. retest across model revisions rather than assuming carrier stability.

The proposed `<X Z X | U>` and residue-derived key grammars are serialization candidates only. Prime congruence classes do not create neural information lanes by themselves. A payload-derived key is offline side information: charge its scan and encoding work, audit target leakage, and do not substitute a proxy tokenizer for the deployment tokenizer.

Do not infer an LLM retrieval-error bound from random-vector concentration or the Johnson–Lindenstrauss lemma without a model connecting tokenizer outputs, contextual hidden states, attention keys and queries, softmax margins, and the task decoder. Likewise, model width alone does not imply better retrieval. Claims about optimal sparse recovery, AC⁰/TC⁰ realization, Shannon proximity, or the Holevo bound require their own named channel, circuit, resources, and proof.

## 10. Sketch-derived future programs

These programs survive the old sketches because they could change a later experiment. The surrounding mathematical reference material now lives in `vWIKI.md`.

### Sparse protocol kit

A later compiler may combine base serialization, a global synchronization record, hierarchical block coordinates, local parity, object-level invariants, and an end-to-end check. Add one component at a time. Every component needs a corruption model, matched syntax or repetition controls, a cost entry, and a selective break. Mixed-radix or disjoint alphabets are candidates only after an observed collision problem justifies them.

### Adaptive index allocation

The current index rate is fixed. A later policy could choose which blocks receive indexes, at what resolution, and with how much redundancy. Dyadic windows, covering arrays, or greedy/submodular selection are candidate allocation tools, not explanations. Compare against fixed-rate indexing and stop adding structure when held-out risk reduction no longer earns its total cost.

### Snapshots and reusable state

Prefix-free identifiers, hashes, delta caches, and multiresolution snapshots may reduce replay in a stateful workspace. The endpoint is task-equivalent continuation, not reconstruction for its own sake. Compare with full replay, charge cache construction and invalidation, and test privacy, revocation, and stale-state failures.

### Factor-graph mechanism hypothesis

Graph-aligned attention masks may resemble rounds of message passing, but “attention is belief propagation” is only a hypothesis. Define variables, factors, messages, update schedule, and readout; predict a held-out error pattern; then intervene on the proposed path in an open model. Exactness on trees does not transfer automatically to loopy attention graphs.

### Interaction-efficient evaluation

Covering arrays can vary several compiler choices without an exhaustive factorial, while small structured examples can expose pairwise versus higher-order failures. Use these as experiment-design tools only after defining the estimand and interaction order. Information-theoretic certificates such as Fano or finite-blocklength bounds enter only when the experiment specifies a channel, decoder, units, and assumptions.

## 11. Source queue

The current paper now cites the archived v1 paper, Lost-in-the-Middle, RULER, Landmark Attention, Recurrent Memory Transformer, Gist Tokens, ICAE, and Activation Beacon. Future passes should verify primary work on robust residue codes, task-conditioned zero-error coding, dynamic token merging, and black-box causal probing only when those topics enter the paper.

`refs/links.md` is browser-history input, not a bibliography. Chat links and search pages are not sources.
