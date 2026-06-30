# From Linear Algebra to AI Reasoning — A Working Methodology

_How the linear algebra taught in this course maps directly onto how a model like
Claude represents meaning and reasons, and how to turn that correspondence into
practical leverage. Written to be **useful**, so claims are tiered by how
established and how accessible they are — not everything inspiring is true, and
this document tries to say which is which._

---

## 1. The core thesis

A large language model is, mechanically, a stack of **linear-algebra operations**
interleaved with simple nonlinearities. The same five ideas this course teaches
are the same five ideas that make the model work:

| This course teaches… | …which in an LLM is |
|----------------------|---------------------|
| **Vectors** (Lec. 3) | An *embedding*: a token/word/sentence is a point (direction) in a high-dimensional space $\mathbb{R}^d$ ($d$ ≈ thousands). |
| **Inner products & unit vectors** (Lec. 4) | *Semantic similarity*. Cosine similarity **is** the inner product of two unit vectors. This is why retrieval, search, and clustering work. |
| **Matrices** (Lec. 8) | Every layer is matrix multiplication. **Attention** computes a matrix of inner products $QK^\top$, softmaxes it, and uses it to take a weighted sum of value vectors. |
| **Tensor products** (Lec. 6, 9) | The structure of multi-token sequences, multi-head attention, and the KV cache lives in tensor-structured spaces — exactly the way multi-qubit state space is a tensor product. |
| **Superposition** (Intro) | The *linear representation hypothesis*: concepts are **directions**, and the model packs many features into one space as **linear combinations** of them. "Superposition" is the literal term used in interpretability research. |

The punchline: **meaning is geometry**. If you can reason about vectors, inner
products, and linear combinations, you can reason about — and engineer — model
behavior. This course is the on-ramp to that.

---

## 2. Methodology, tiered by what you can actually do

### Tier A — Usable today, with only the Claude API (no model internals)

These need nothing but API access and an embedding model. They are direct
applications of **Lecture 4 (inner products / unit vectors)**.

1. **Retrieval / RAG done with the geometry in mind.** Embed your documents and
   the query as vectors; rank by inner product. Concretely: *unit-normalize*
   before comparing (so you're measuring angle, not magnitude — the Lecture 4
   point), choose cosine vs dot deliberately, and add a lexical signal for a
   hybrid score. Most "bad RAG" is a normalization or metric mistake.

2. **Output-space analytics — use linear algebra to *measure* the model.** Embed
   a batch of Claude's outputs and:
   - **cluster** them to see what modes it falls into,
   - **deduplicate** near-identical answers by an inner-product threshold,
   - **score diversity** (how spread out the vectors are) when you want varied
     generations,
   - **detect drift** between prompts or model versions as movement in
     embedding space.
   This turns "the output feels different" into a number.

3. **Self-consistency as ensemble measurement.** Sample several independent
   reasoning paths, embed the final answers, and take the **majority cluster /
   centroid** rather than trusting one sample. This is the single most reliable
   reasoning boost you can add from the outside — and it's geometrically just
   "find the densest region of answer-space." (Loose analogy to taking
   measurement statistics over repeated quantum runs — useful intuition, not a
   claim of quantum behavior.)

4. **Decomposition as clean composition.** Structure a task so each step is one
   well-defined transformation feeding the next — the way composing matrices
   $C = BA$ is cleaner than one tangled operator. Models reason more reliably
   over short, typed steps than one long leap.

### Tier B — Research methodology (open-weight models; transferable understanding, *not* the Claude API)

Here you touch the model's internal vectors. You can't do this through the Claude
API, but doing it once on an open model permanently changes how you think about
all of them.

5. **Activation steering / control vectors.** Add a direction to the model's
   residual stream to push behavior (more formal, more cautious, a topic). This
   is **literally vector addition (Lecture 3)** performed on the activations. You
   find the direction by contrasting activations on positive vs negative
   examples — i.e. a difference of vectors.

6. **Probing & feature directions.** Train a simple linear probe to read a
   concept off the residual stream: if a linear map recovers it, the concept is
   stored as a direction. This is the empirical test of the "meaning is geometry"
   thesis.

7. **Sparse autoencoders / un-mixing superposition.** Because the model packs
   many features into one space as linear combinations (superposition), you can
   train a decomposition that pulls them back apart into interpretable
   directions. This is the course's "superposition" idea meeting its
   interpretability namesake head-on.

### Tier C — Speculative / honest caveats (do **not** build a strategy on these yet)

8. **Quantum computing for LLM reasoning.** Today this is mostly aspirational.
   The honest, real threads are: **tensor-network ("quantum-inspired")
   compression** of weight matrices, and **quantum kernels / variational models**
   for *small* ML tasks (what Lecture 11 demonstrates). There is **no
   demonstrated quantum advantage for transformer-scale reasoning**, and anyone
   claiming otherwise is selling something. The leverage is in the **classical
   linear algebra that is actually running** — that's where this methodology
   puts its weight.

---

## 3. A concrete program (turning the above into work)

A staged plan that builds directly on this repo and stays mostly in Tier A:

- **Phase 1 — Make the correspondence runnable.** A lecture/notebook that takes
  Lecture 4's inner products and shows them as *real* semantic similarity:
  embed sentences, rank by cosine, build a tiny retrieval demo. This is the
  "aha" that connects the whole course to modern AI.
- **Phase 2 — An embedding-space evaluation harness for Claude outputs**
  (clustering, dedup, diversity, drift) — Tier A #2.
- **Phase 3 — A reasoning toolkit**: self-consistency, decomposition, and a
  verifier pass, each documented in linear-algebra terms — Tier A #3–4.
- **Phase 4 (optional, research)** — Reproduce a steering-vector experiment on an
  open model to internalize the geometry first-hand — Tier B #5.

Each phase is a standalone, useful artifact; each later phase is optional.

---

## 4. The one-sentence version

**Meaning is geometry; reasoning is moving through that geometry; and the
geometry is exactly the vectors, inner products, and linear combinations this
course already teaches — so the fastest way to advance how we *use* AI is to get
fluent in the linear algebra underneath it and engineer in vector space
deliberately.**
