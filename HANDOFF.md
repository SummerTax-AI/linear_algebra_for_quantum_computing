# Condensed Handoff — Linear Algebra → AI (and Quantum)

## Purpose
A single, continuation-ready digest of this project. Read this to understand the
whole system in a few minutes and pick up the work without the full history. The
deeper docs (`FRAMEWORK.md`, `METHODOLOGY.md`, `REPRODUCE.md`, `EXPLORATION.md`)
expand each part; this file condenses them.

## Core thesis
This fork began as an intro course on the **linear algebra prerequisites for
quantum computing** (Lectures 1–10) and was extended into a working system
carrying one claim from theory to running code:

> The same linear algebra — vectors, inner products, matrices, tensor products,
> eigen/SVD — underlies **both** quantum computing and modern AI. Computation is
> the transformation of high-dimensional vectors; **observation is a
> lower-dimensional projection** of them (a measurement, a similarity score, a
> decoded output). "Meaning is geometry," and you can build and *measure* real
> systems on that footing.

The one operation under that whole sentence is **projection** — the inner product
`⟨b|x⟩` — and Lecture 18 shows it doing geometry's shadow, AI's similarity, and
quantum measurement, all at once.

## The arc in one screen
- **Origin (1–10):** complex numbers → vectors → inner products → Bloch sphere →
  tensor products → matrices → quantum gates. (Lectures 5 & 10 use *legacy*
  Qiskit and are not part of the reproducible system.)
- **Extension (11–18):** train a quantum model; show embeddings *are* inner
  products; evaluate and reason about model outputs in vector space; derive the
  eigen/SVD and attention machinery; and unify it all under projection.
- **Docs:** a written method and framework, with strict honesty tiers so no
  claim outruns what a notebook can demonstrate.

## Lecture catalog (extension)
| # | One line | Verified |
|---|---|---|
| 11 | Variational quantum classifier trained in PennyLane | ✅ executed |
| 12 | Text → embeddings; inner products = semantic search (RAG core) | ✅ executed |
| 13 | Evaluate model outputs in embedding space (dedup/cluster/diversity/drift) | ✅ executed |
| 14 | Self-consistency + verification + decomposition on the Claude API | ⚠️ needs `ANTHROPIC_API_KEY` |
| 15 | Capstone: language → embedding → PCA → quantum classifier | ✅ executed |
| 16 | Eigenvalues/eigenvectors/SVD — measurement ↔ PCA | ✅ executed |
| 17 | Attention is inner products — a transformer head in NumPy | ✅ executed |
| 18 | Projection — the universal readout (geometry, AI, quantum as one op) | ✅ executed |

`verify_notebooks.sh` executes the 7 self-contained notebooks (all but 14) and
reports PASS/FAIL; last clean run: **7 PASS, 0 FAIL**.

## What's verified vs. not (the honesty tiers)
1. **Grounded in running code (this repo):** embeddings as geometry, similarity
   as inner product, measurement as projection, PCA/SVD, attention, quantum & AI
   as vector transformation. Checked by `verify_notebooks.sh`.
2. **Established but not yet here:** category-theoretic unification; latent-space
   manifold structure; amplitude encoding + its readout limits. These are the
   proposed next builds (Lectures 19, 20).
3. **Speculative metaphor (flagged, not claimed):** the cosmology / universe-as-
   brane extension. Useful intuition for intrinsic/extrinsic dimension; **the
   repo makes no cosmological claim.**

A separate, honest performance note: **no quantum advantage is claimed** — in
Lecture 15 the classical baseline ties the quantum model. The quantum notebooks
are a faithful *bridge*, not a speed result.

## How to run (full detail in `REPRODUCE.md`)
```bash
python3 -m venv .venv && source .venv/bin/activate     # Python 3.11
pip install -r requirements-lock.txt                   # exact tested versions
bash verify_notebooks.sh                               # execute all, PASS/FAIL
```
First run downloads a ~90 MB embedding model once (needs network). Lecture 14 is
run separately with a key.

## Document map
| Doc | Use it for |
|---|---|
| `HANDOFF.md` | this digest — start here |
| `REPRODUCE.md` | setup, expected results, verification, honest limits |
| `FRAMEWORK.md` | the unifying thesis + claim→notebook map + tiers |
| `METHODOLOGY.md` | the method (linear algebra → practical AI), tiered |
| `EXPLORATION.md` | the original-repo survey this fork began from |

## Open continuations
**Buildable next (each grounds an open question in a runnable notebook):**
- **L19 — Manifolds / intrinsic vs. extrinsic dimension:** embed a smoothly
  varying concept family and show the points trace a low-dimensional curve inside
  384-D (intrinsic ≪ extrinsic).
- **L20 — Classical→quantum encoding & its limit:** amplitude-encode a vector
  into ⌈log₂n⌉ qubits, then show measurement returns one outcome — the
  exponential compression is effectively "write-only."

**Philosophy, not a coding task:** a single category-theoretic formalism across
embeddings/Hilbert spaces/branes; how far intrinsic/extrinsic goes before it's
metaphor; whether universe-as-brane is more than analogy (Tier 3).

**Discipline:** a new conceptual claim earns Tier 1 only when it arrives with a
notebook attached.

## Key terms (condensed)
- **Vector / embedding** — a point/state in a space of degrees of freedom; for
  text, a learned 384-D direction whose geometry encodes meaning.
- **Inner product / projection** — `⟨b|x⟩`; the universal readout (similarity,
  measurement amplitude, shadow component).
- **Matrix / unitary / attention** — linear maps; a quantum gate, or `QKᵀ`.
- **Eigenvalue / eigenvector** — a map's special directions; quantum measurement
  outcomes & basis states; PCA's axes.
- **Tensor product** — how multi-qubit systems and multi-head structure combine.
- **Intrinsic vs. extrinsic dimension** — degrees of freedom an object *needs*
  vs. the ambient space it's *embedded in*.

## One-sentence handoff
This project shows — in runnable, verified notebooks — that quantum computing and
modern AI are the same linear algebra: high-dimensional vector states transformed
by matrices and observed only through lower-dimensional projections, with a strict
honesty discipline separating what the code demonstrates from what remains
speculation.
