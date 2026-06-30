# The Unifying Framework — and how this repo grounds it

This document states the conceptual thesis the project is built around, and then
does the thing prose alone can't: it **maps each claim to the runnable notebook
that demonstrates it**, and marks honestly which parts are *not* demonstrable.
It is the bridge between the high-level idea and the executable lectures.

---

## The thesis in one sentence

> Computation has progressed from manipulating discrete **symbols** to
> transforming **points in high-dimensional vector spaces**. Linear algebra
> stops being a tool you *use* and becomes the **medium**: in AI it is the
> representational medium (embeddings), in quantum computing the physical medium
> (state vectors). In both, the full object is high-dimensional and is only ever
> observed through a **lower-dimensional readout** — a projection, a measurement,
> a similarity score, a decoded token.

The single operation under that whole sentence is **projection** — reading a
high-dimensional state out into something lower-dimensional we can interpret.
That is the same linear-algebra move whether the state is a geometric shape, a
text embedding, or a quantum wavefunction. (Lecture 18 demonstrates exactly this
in all three domains at once.)

---

## Claim → demonstration map

Every row is a claim from the conceptual arc, paired with where in this repo it
is made **concrete and executable** (not just asserted).

| Claim from the framework | Where it is demonstrated (runnable) |
|---|---|
| A qubit is a 2-D complex vector; gates are unitary matrices | Lectures 5, 10, 16 |
| Multi-qubit systems combine by tensor product | Lectures 6, 9 |
| **Measurement = projection of a state onto a basis** | Lecture 16 (eigenvectors) + **Lecture 18** |
| An embedding represents meaning as a vector | Lecture 12 |
| **Similarity = inner product = projection onto a direction** | Lectures 12, 18 |
| Observation = projecting a high-dim object to a low-dim readout | Lectures 13 (PCA), 16 (SVD), **18** |
| Attention is a matrix of inner products | Lecture 17 |
| Computation as a designed transformation of a state vector | Lectures 11, 15 |
| Eigenvalues/eigenvectors are the "special directions" of a map | Lecture 16 |
| Intrinsic vs. extrinsic dimension; latent spaces as manifolds | *proposed Lecture 19 — not yet built* |
| Limits of encoding classical vectors into quantum states | *proposed Lecture 20 — not yet built* |
| Universe-as-brane / cosmological extension | **Not demonstrable — speculation, see below** |

If a claim isn't in the left column with a runnable home, it isn't part of the
*verified* system — it's commentary. That distinction is the whole point of the
project's honesty discipline (see `METHODOLOGY.md`).

---

## Three tiers of confidence (don't oversell)

Mirroring `METHODOLOGY.md`, the framework's claims fall into three honestly
different buckets:

1. **Grounded in running code (this repo).** Embeddings as geometry, similarity
   as inner product, measurement as projection, PCA/SVD as projection, attention
   as inner products, quantum/AI both as vector transformation. These execute and
   are checked by `verify_notebooks.sh`.

2. **Established but not (yet) in this repo.** Category-theoretic unification of
   the three domains; latent-space manifold structure; amplitude encoding and its
   readout limits. These are real, buildable, and are the proposed next lectures
   (19, 20) — but they're not demonstrated here *yet*, so they're labeled as such.

3. **Speculative metaphor — clearly flagged.** The cosmological / brane extension
   ("our 3-D universe as a hypersurface in a higher-dimensional bulk") is a
   *geometric analogy*, not physics this project can demonstrate or defend. It is
   useful as intuition for intrinsic/extrinsic dimension and **nothing more**. We
   keep it explicitly in Tier 3 so a skeptical reader is never misled into
   thinking the repo claims a cosmological result. It does not.

---

## The continuation questions, sorted by "can we build it?"

The handoff ends with seven open questions. Sorting them by whether they're
*buildable here* vs *philosophy* keeps the project honest and productive:

**Buildable next (concrete notebooks):**
- *Are AI latent spaces learned manifolds, not just vector databases?* →
  **Lecture 19**: embed a smoothly-varying concept family (e.g. "one"…"ten",
  or "tiny"…"enormous") and show the points trace a low-dimensional curve inside
  384-D — intrinsic dimension ≪ extrinsic dimension.
- *What are the limits of encoding classical embeddings as quantum states?* →
  **Lecture 20**: amplitude-encode a classical vector into ⌈log₂n⌉ qubits, then
  show the catch — measurement returns *one* outcome, so the exponential
  compression is effectively "write-only." A precise, runnable answer.
- *Is measurement best understood as projection, slice, or constraint?* →
  **Lecture 18** (built now) makes the projection reading concrete; the
  slice/constraint readings become exercises on top of it.

**Genuinely open / philosophical (not a coding task):**
- A single category-theoretic formalism over embeddings + Hilbert spaces +
  branes. (Interesting; not something a notebook settles.)
- How far intrinsic/extrinsic generalizes before it's "just metaphor."
- Whether universe-as-brane is more than analogy. (Tier 3 — out of scope.)

---

## Why this matters for the repo

The framework is the *why*; the lectures are the *show me*. Keeping them in one
place — with an explicit map and explicit honesty tiers — is what lets a
third-party reviewer trace any grand-sounding claim down to a cell they can run,
and lets us keep expanding the idea **without drifting from what we can actually
demonstrate**. New conceptual claims earn a place in Tier 1 only when they arrive
with a notebook attached.
