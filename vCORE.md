# Context Coordinate Frames for Operator-Specific Fidelity

## Hypertokens: Dressing the Naked Context Window

## Abstract

Nominal context length states how much text a language model can accept, not which operations it can execute reliably over that text. Finding one occurrence, preserving a complete set, binding repeated names to the right versions, composing distant relations, and carrying state into a later operation can fail at different scales.

We define a *hypertoken* as a sparse, typed control record injected when a prompt is assembled. It can index a block, declare scope, expose a relation, carry a check, or retain task state without rewriting every source token. A hypertoken may itself occupy several ordinary tokens. Exact compiler properties do not imply that a model uses the resulting structure.

The current contribution is a protocol and measurement framework. It defines operation-specific fidelity, a reliable-workload frontier, typed context frames, matched-cost controls, and a causal relation-break criterion. The planned evaluation asks whether valid coordinates outperform ordinary identifiers at equal total cost and whether a local break selectively removes any gain. The repository establishes finite external constructions and offline evaluation infrastructure, but no positive comparative language-model result. A retained pilot was ceiling-confounded.

## 1. The naked context problem

Language-model interfaces expose a token sequence and a nominal context limit. They do not expose a contract for which occurrence is referenced, which role a span plays, where scope begins and ends, which relation must be preserved, or what state must survive into a later operation. The context is *naked*: payload and incidental formatting are visible, but the computational interface is largely implicit.

“Facts in, facts out” hides distinct failures. A model may retrieve one matching sentence while omitting another; find the right entity but bind it to the wrong version; preserve local plausibility while losing an ordering constraint; or collapse a candidate set before the evidence permits closure. We therefore separate selection, binding, completeness, ordering, composition, continuation, and abstention.

Even a short string exposes the problem: “the third S in MISSISSIPPI” is not operational until an occurrence order and indexing convention are fixed. “The rain in Spain stays mainly in the plains” adds repeated function words and similar-sounding content words, so an instruction may also need syntactic role and span boundaries. Longer prompts add scope, version, and cross-record relations to the same basic ambiguity.

Hypertokens test whether a user-space compiler can make required relations explicit and whether a frozen model uses them. They do not require privileged model access. Their guarantee is auditability, not efficacy.

The original HDRAM paper described hypertokens through spread-spectrum, holographic, Krylov, error-correcting, and quantum-inspired mechanisms [1]. Its reported recall and in-context sorting improvements are not reproduced by the present repository and are not retained as evidence here. The current paper supersedes those empirical claims with a narrower, falsifiable protocol claim.

## 2. Tasks, risk, and usable context

### 2.1 Operations and whole-output risk

For source instance \(x\), let \(o\) be a declared operation and \(y_o(x)\) its required output. Operations include:

- **find:** return a named occurrence or span;
- **bind:** associate an occurrence, role, or version with the correct value;
- **join:** combine records through declared relations;
- **count or bin:** return complete counts or partitions;
- **substitute:** change selected records without changing protected records;
- **sort or compose:** preserve a declared order or apply an ordered relation;
- **continue:** use compact prior state in a later dependent operation; and
- **abstain:** refuse when supplied state does not identify a valid answer.

Each operation has its own failure event. Whole-output risk counts omissions, false inclusions, wrong bindings, incorrect order, malformed output, and non-completion. Returning one correct member of an incomplete set is failure on a complete-set task. The confirmatory protocol permits one attempt per cell, so a retry is a failure there; exploratory retries remain observable cost rather than being silently discarded.

### 2.2 Fidelity on chains and grids

Fix a deployment profile \(d\): model and revision, target tokenizer, decoding policy, compiler, serialization, allowed tools, preregistered difficulty grid, and resource limits. Let \(R_o(g;d)\) be whole-output risk at grid cell \(g\), and let \(U_o(g;d)\) be its simultaneous upper uncertainty bound.

For a declared monotone chain \(g_1\preceq\cdots\preceq g_K\), define the fidelity horizon

\[
H_o(d,\epsilon_o)=\max\left\{k:\max_{j\le k}U_o(g_j;d)\le\epsilon_o\right\}.
\]

Prefix closure prevents an isolated late success from hiding an earlier failure; if the first cell fails, define \(H_o=0\). A multi-axis grid generally has no unique maximum. Its primary object is instead the reliable downset

\[
\mathcal D_o(d,\epsilon_o)=\left\{g:\max_{g'\preceq g}U_o(g';d)\le\epsilon_o\right\},
\]

reported through its maximal elements, or Pareto frontier. Here \(g'\preceq g\) means that \(g'\) is no harder on every preregistered difficulty axis. Because simultaneous bounds can depend on the number of cells, the grid and multiplicity rule are part of \(d\) and must be frozen before model calls.

Fidelity is operation-relative. It is neither Shannon capacity, a model-intrinsic constant, nor another name for advertised context length. “Usable capacity” below always means reliable work for a named operation under a fixed deployment profile.

### 2.3 Ambiguity surface

The first generator varies name count, versions per name, parts per version, and records per indexed block. Randomized record placement is recorded but is not yet a controlled distance axis. These variables define an ambiguity surface rather than a universal context score. Physical distance, payload similarity, nesting, pointer depth, corruption, and checkpoint spacing remain future axes until a generator and scorer implement them.

A cyclic coordinate is descriptive, not explanatory. “Phase” would earn explanatory force only if a declared cyclic origin predicted held-out behavior beyond spacing, token count, salience, ordinary identifiers, and matched redundancy.

### 2.4 Total cost

Framing cost is not prompt length alone. We record

\[
C=(T_{in},T_{out},N_{call},L,M_{KV},W_{ext},F,R),
\]

covering input and generated tokens, model calls, latency, memory or KV use when observable, external work, failures, and retries. Computing labels, coordinates, checks, corruption plans, or padding is charged to \(W_{ext}\). Results include both equal-payload and equal-total-budget comparisons; when components are unavailable or cannot be collapsed defensibly, the result is a partially observed Pareto frontier.

Confirmatory token parity must use the target provider tokenizer and raw prompt-only usage. The retained agent-CLI plumbing run reported 14,358 input tokens for a roughly 250-token proxy prompt and 15,033 for a roughly 955-token prompt. Wrapper context therefore dominates those usage records, making them unsuitable for matched-cost inference.

## 3. A typed context grammar

### 3.1 Context frames

A logical control frame is

\[
F_i=(A_i,P_i,C_i,X_i,M_i),
\]

where \(A_i\) identifies a span or block, \(P_i\) contains a compact index or semantic role, \(C_i\) contains declared checks or redundant relations, \(X_i\) specifies scope, version, reset, and boundary behavior, and \(M_i\) is optional carried state.

These fields are logical objects before tokenization. A deployment fixes alphabets, delimiters, escaping, placement, malformed-input policy, and tokenizer realization. The compiler records every injected span and its source range. Injection density is part of the cost: the default experiment adds one block index per several ordinary records, not one frame per record or source token.

### 3.2 Running example

The phrase *the quick brown fox jumps over the lazy dog* can be exposed as a typed hierarchy:

```text
1,the quick brown fox,subject
2,jumps over,verb
3,the lazy dog,object
4,1/2/3,sentence
5,ref=4,property=pangram
```

IDs 1–5 are ordinary sequential identifiers. Record 4 composes three spans; record 5 assigns a derived property to record 4. A misspelling, substitution, repeated phrase, or broken reference can then be scored as a declared payload, binding, completeness, or composition error.

### 3.3 Grammar ladder

The protocol ranges from an unmodified prompt, through ordinary identifiers, to sparse block indexes, optional boundaries, and optional checks. An experiment uses the least expressive and least dense rung that supports its operation. Additional syntax must earn its cost.

Sequential IDs are the primary comparator. The repository also implements restricted-range residue codes for a separate corruption-repair study, but the first sparse-index experiment neither uses nor needs them. Their exact finite properties do not imply latent orthogonality, neural error correction, or superiority to ordinary IDs.

### 3.4 Sparse anchors and checks

A prompt-time compiler may inject one index before a block of ordinary records. The index describes the names and versions present in that block, without containing bodies or query-specific target membership. Moving indexes among blocks while preserving their full multiset breaks only the index-to-block relation.

A lane is a *check* only when a declared code and decoder use it to detect or repair a specified corruption. Repeating a label may alter salience without adding a relation. A check can instead constrain compatibility among candidates, but model use must be measured rather than inferred from the compiler.

The current experiment needs only sparse indexing and lookup. Boundaries, checks, broader instruction catalogs, and multirate schedules are deferred until a task executes them.

## 4. Position and a deferred closing-state extension

### 4.1 Position

Position is the declared information needed to identify an occurrence: address, role, scope, version, local coordinate, and relations to other occurrences. It is not merely absolute token index. The same payload may occupy different logical positions because its role, version, or scope differs.

### 4.2 Closing state

A later operation may require a task-specific closing record: candidates and exclusions for completeness, a partial composition for an ordered join, or unresolved bindings for citation. Earlier drafts called this semantic momentum; the first study does not use that mechanics vocabulary or test closing state.

Any later test must respect causal placement. Model-emitted opening state cannot depend on payload that follows it, whereas compiler-supplied metadata may depend on an offline scan only when that side information and its cost are recorded. A valid closing state must improve a later operation beyond position-only framing, generic summaries, and equal-cost scratch state. No such model effect has yet been observed.

## 5. Confirmatory evaluation

### 5.1 Primary task

The primary task is complete-set versioned selection. Each ordinary record already binds a name, version, part, and body. A query requests every qualifying body, in a declared order, for one name and a minimum-version rule; index syntax never appears in the answer. Difficulty crosses name count, versions per name, parts per version, and records per indexed block. Calibration retains cells where the sequential-ID comparator has 20–60% whole-output risk, avoiding ceiling and floor. This first task tests sparse indexing and complete selection, not cross-record binding.

The repository now includes an offline generator, scorer, sparse-index checks, and exact paired-analysis fixture for this task. These establish design semantics only. They are not model results, and confirmatory rendering remains blocked until a reliable raw API and its target tokenizer are pinned.

### 5.2 Conditions and budgets

The confirmatory family separates two estimands:

1. **Equal payload:** natural records, sequential IDs, valid sparse block indexes, and a local index-to-block break contain the same records. This paired comparison isolates syntax and relation use.
2. **Equal total budget:** each representation receives the same target-token budget and draws workloads from the same generator at fixed target prevalence. The result is a workload frontier—how many records each representation can carry below the risk target—not a paired comparison with extra distractors added to only one arm. Neutral padding may close a final token gap but cannot replace useful payload.

All arms use identical task instructions except one condition-specific syntax sentence. The target tokenizer, serialized prompts, padding rule, compiler time, and all external work are frozen before calls. In the default 48-record development fixture, six indexes cost about 17% more proxy tokens than sequential IDs; proxy counts are diagnostics, not deployment parity.

The corruption-repair v2 fixture remains a calibration instrument. It tests whether a model can follow an explicit modular decoder under manufactured corruption; it cannot establish that sparse indexing extends fidelity on the natural selection task. Instruction-only and corruption-only arms are required before interpreting that fixture causally.

### 5.3 Endpoint and inference

The endpoint is whole-output failure, with one primary attempt per document-condition pair and non-completion counted as failure. The equal-payload comparisons use exact paired tests on discordant outcomes. Because support requires every directional claim to pass, this is an intersection–union rule: each required component is tested at \(\alpha=0.05\), without Bonferroni splitting. Minimum effects, calibration band, exclusions, and sample size are frozen before execution. The earlier \(n=64\) Bonferroni–Hoeffding plan had a 0.358 contrast half-width and is retained only as a conservative diagnostic.

Support requires all of the following:

- valid sparse indexes beat sequential IDs by the preregistered minimum effect at equal total cost;
- a local index-to-block break is worse than the valid index;
- no arm is at ceiling or floor.

This joint rule prevents “invalid structure hurts” from masquerading as “valid structure helps.” Because valid and moved-index prompts contain the same index strings, repetition and gross salience survive the break while the index-to-block relation does not. The claim is falsified if the valid sparse index fails to beat IDs, if the local break does not separate, or if the indexed representation has no reliable-workload advantage at equal total budget.

## 6. Present evidence

The evidence boundary is deliberately explicit:

- **Exact external facts:** finite CRT reconstruction, the restricted-range distance bound, and modular-moment identities.
- **Implemented fixtures:** compiler round trips, bounded repair and detection cases, relation controls, scorers, prompt hashes, and proxy-token audits.
- **Observed model records:** one easy plain/paired plumbing pair, an eight-call ceiling-confounded pilot with zero contrasts, two 90-second provider timeouts, and one ten-retry provider timeout.
- **Not observed:** a positive sparse-index effect, a matched-total-cost advantage, a versioned-selection result, a closing-state benefit, or a model-internal mechanism.

The eight-call pilot exposed answer-bearing identifiers and did not require the proposed relation. Exact outputs in every arm therefore diagnose task saturation, not benefit, equivalence, or lack of benefit. Agent-wrapper usage is plumbing evidence only, because most billed input was not the rendered prompt. Provider alias and tokenizer metadata were also insufficient to pin a deployment profile.

## 7. Relation to prior work

Long-context acceptance is not long-context use. Lost-in-the-Middle demonstrates position-sensitive degradation in retrieval and multi-document question answering [2], while RULER broadens long-context evaluation beyond single-needle retrieval to multi-needle, tracing, and aggregation tasks [3]. The present framework adds an operation-specific whole-output risk target and a causal syntax intervention; it is not a replacement for those benchmarks.

Several systems introduce learned landmarks, memories, or compressed states. Landmark Attention trains special tokens to select blocks [4]. Recurrent Memory Transformer trains memory tokens across segments [5]. Gist Tokens [6], ICAE [7], and Activation Beacon [8] learn compressed prompt or activation representations. Hypertokens in the current paper are instead visible, externally compiled fields around a frozen model. Any comparison must therefore separate black-box prompt structure from learned or architectural memory.

The nearest coding analogy is task-conditioned side information: only distinctions that can change the requested output need be preserved. That analogy motivates future confusion-graph designs, but the first study uses ordinary IDs and explicit relation controls rather than claiming an optimal code.

## 8. Scope and limitations

*Grounding* here means preserving and correctly using declared source occurrence, role, scope, version, and relation information for a named operation. It does not establish factual grounding in the world, alignment, safety, or universal applicability.

The work does not establish generic reasoning improvement, model-intrinsic context extension, benefit across model families, latent orthogonality, neural error correction, harmonic transport, a transformer-internal Krylov or symplectic mechanism, quantum simulation, smaller-model equivalence, or optimality of any address family.

Learned embeddings, adapters, fine-tuning, native state, regenerative operators, adaptive coding, confusion graphs, and harmonic or quantum correspondences remain future work. The nearer classical questions in `vNOTES.md` must be answered before those explanations are promoted.

## 9. Conclusion

Hypertokens treat context as a compiled interface rather than an undifferentiated token buffer. The present contribution is an auditable typed protocol, exact external constructions, an operation-relative measurement object, and a causal experiment that can fail.

The target empirical claim is intentionally narrow: for a named operation and fixed deployment profile, a sparse prompt-time index extends the reliable-workload frontier under matched total cost, and a local index-to-block break selectively removes the gain. Until that comparison is executed, hypertokens remain a protocol and testable hypothesis, not a demonstrated improvement to language models.

## References

**[1]** Christopher James Augeri. “Hypertokens: Holographic Associative Memory in Tokenized LLMs.” arXiv:2507.00002, 2025. https://arxiv.org/abs/2507.00002

**[2]** Nelson F. Liu et al. “Lost in the Middle: How Language Models Use Long Contexts.” TACL, 2024. https://arxiv.org/abs/2307.03172

**[3]** Cheng-Ping Hsieh et al. “RULER: What’s the Real Context Size of Your Long-Context Language Models?” COLM, 2024. https://arxiv.org/abs/2404.06654

**[4]** Amirkeivan Mohtashami and Martin Jaggi. “Landmark Attention: Random-Access Infinite Context Length for Transformers.” NeurIPS Workshop, 2023. https://arxiv.org/abs/2305.16300

**[5]** Aydar Bulatov, Yuri Kuratov, and Mikhail S. Burtsev. “Recurrent Memory Transformer.” NeurIPS, 2022. https://arxiv.org/abs/2207.06881

**[6]** Jesse Mu, Xiang Lisa Li, and Noah Goodman. “Learning to Compress Prompts with Gist Tokens.” NeurIPS, 2023. https://arxiv.org/abs/2304.08467

**[7]** Tao Ge et al. “In-context Autoencoder for Context Compression in a Large Language Model.” ICLR, 2024. https://arxiv.org/abs/2307.06945

**[8]** Peitian Zhang et al. “Long Context Compression with Activation Beacon.” ICLR, 2024. https://arxiv.org/abs/2401.03462
