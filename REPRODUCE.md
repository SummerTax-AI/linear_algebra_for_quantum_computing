# Reproduce & Review — start here

This document is written for a **third-party reviewer on a fresh workstation**,
including a skeptical one. It states plainly what this repository is building,
how to run it end to end, what is and isn't verified, and where the honest
limits are. If you only read one file, read this one.

---

## 1. What we are building

This started as an introductory course (Lectures 1–10) teaching the linear
algebra prerequisites for quantum computing. This fork extends it into a single
coherent thesis:

> **The same linear algebra — vectors, inner products, matrices, tensor
> products, eigen/SVD — underlies both quantum computing and modern AI. "Meaning
> is geometry," and you can build and measure real systems on that footing.**

The extension (Lectures 11–17 + `METHODOLOGY.md`) walks that claim from theory
to running code:

| Lecture | What it builds | Verified? |
|---|---|---|
| 11 | Train a **variational quantum classifier** (PennyLane) | ✅ executed |
| 12 | Real text → embeddings; **inner products = semantic search** (RAG core) | ✅ executed |
| 13 | **Evaluate model outputs in embedding space** (dedup/cluster/diversity/drift) | ✅ executed |
| 14 | **Self-consistency + verification + decomposition** on the Claude API | ⚠️ runs with a key (see §5) |
| 15 | **Capstone:** language → embedding → PCA → quantum classifier, end to end | ✅ executed |
| 16 | **Eigenvalues/eigenvectors/SVD** — measurement ↔ PCA (the math hinge) | ✅ executed |
| 17 | **Attention is inner products** — a transformer head from scratch in NumPy | ✅ executed |
| 18 | **Projection — the universal readout** (geometry, AI, quantum measurement as one operation) | ✅ executed |

`FRAMEWORK.md` is the unifying thesis (computation as high-dimensional vectors
observed through low-dimensional projections) with a claim→notebook map.
`METHODOLOGY.md` is the written method, deliberately tiered into *usable today*,
*research on open models*, and *speculative* (so claims aren't oversold).
`EXPLORATION.md` is the original repo survey.

---

## 2. Prerequisites

- **Python 3.11** (tested on 3.11.15).
- ~3 GB free disk (PyTorch + a sentence-embedding model).
- **Network access on first run:** Lectures 12, 13, 15, 17 download a ~90 MB
  embedding model (`all-MiniLM-L6-v2`) from Hugging Face once, then cache it.
- A POSIX shell to run `verify_notebooks.sh` (optional).

---

## 3. Reproduce from scratch (copy/paste)

```bash
git clone <this-repo-url>
cd linear_algebra_for_quantum_computing

python3 -m venv .venv
source .venv/bin/activate            # Windows: .venv\Scripts\activate

# Pinned, tested versions — reproduces the embedded outputs most closely:
pip install -r requirements-lock.txt

# One command to execute every self-contained notebook and report PASS/FAIL:
bash verify_notebooks.sh
```

`requirements.txt` is the loose, human-friendly list; **`requirements-lock.txt`
is the exact set the notebooks were executed against** — use it to review.

To read/run a single notebook interactively instead:

```bash
jupyter lab            # then open any lecture_*.ipynb and Run All
```

### Expected runtime
`verify_notebooks.sh` executes 7 notebooks; budget **~5–10 minutes** total on a
laptop (first run is slower due to the model download). Individual heavy
notebooks: Lecture 11 ~1 min, Lecture 15 ~2 min; the rest are seconds.

---

## 4. Expected results (so you can check the claims)

Numbers are approximate — they depend on library versions and PennyLane's
optimizer, so treat them as ranges, not exact targets. Pin via
`requirements-lock.txt` to match most closely.

- **L11** — variational quantum classifier on two-moons trains to roughly
  **0.80–0.90 test accuracy**; cost curve decreases; a decision-boundary plot.
- **L12** — `cos(cat, kitten) ≈ 0.6`, `cos(cat, quantum) ≈ 0`; semantic search
  for *"a small sleeping animal"* returns the cat sentences.
- **L13** — dedup collapses 7 outputs → **5**; the off-topic "cafeteria" line is
  flagged as the outlier; paraphrase diversity (~0.3) < mixed-topic (~0.98);
  analogy-vs-technical drift ≈ **0.25**.
- **L15** — quantum **and** classical baselines both reach ~**1.00** test
  accuracy on the easy 2-topic set (this is the point — see §6).
- **L16** — Pauli-Z eigenvalues print as **±1**; hand-rolled PCA-via-SVD matches
  scikit-learn's `explained_variance_` (`match? True`).
- **L17** — attention rows each sum to 1; one-call attention matches the
  step-by-step build; the causal mask is lower-triangular.
- **L18** — projector is idempotent ($P^2=P$); the "finance" projection ranks
  finance sentences highest and an unrelated sentence near 0; quantum Z/X
  measurement probabilities match the squared projections, and a 5000-shot
  simulation's empirical frequency ≈ theory.

A green `verify_notebooks.sh` (PASS on all 6) means every notebook executed
top-to-bottom with no errors on your machine.

---

## 5. Lecture 14 and the Claude API

Lecture 14 calls a live model (`claude-opus-4-8`). It is **excluded from
`verify_notebooks.sh`** because it needs credentials and makes paid network
calls. It is written so that **without** a key it runs cleanly and prints
"skipped" notices (no errors). To exercise it for real:

```bash
export ANTHROPIC_API_KEY=sk-ant-...
jupyter nbconvert --to notebook --execute --inplace lecture_14_self_consistency_reasoning.ipynb
```

Its model-call code follows the current Opus 4.8 API surface (adaptive thinking;
`temperature`/`top_p`/`top_k` are *not* used because they are rejected on that
model; structured outputs via `messages.parse`).

---

## 6. Honest limits (what a skeptical reviewer should know)

- **No quantum advantage is claimed.** In Lecture 15 the classical baseline ties
  the quantum model. The quantum notebooks are a faithful, runnable *bridge*
  between the two halves of the course — not a performance result. This is
  stated in the notebooks and in `METHODOLOGY.md` (Tier C).
- **The original Lectures 5 & 10 are not part of the reproducible system.** They
  were authored against Qiskit ~0.18 / Python 3.7 and will not run on current
  Qiskit. `qiskit` is therefore intentionally absent from
  `requirements-lock.txt`. If you want to try them, expect API-drift errors.
- **Results are approximate, not bit-exact.** Embeddings are deterministic, but
  the PennyLane training loop can vary slightly across library versions even
  with a fixed seed. The *claims* (separability, convergence, the identities in
  L16/L17) are robust; the third decimal place is not.
- **Lecture 14 is unverified here** (no key in the build environment). Its
  structure executes cleanly; its live model outputs are not embedded.
- **License:** the upstream repository ships no `LICENSE` file, so reuse terms
  are unspecified. This fork adds documentation and notebooks but does not
  change that — treat upstream content accordingly.

---

## 7. Repository layout

```
FRAMEWORK.md          unifying thesis + claim->notebook map + honesty tiers
EXPLORATION.md        original-repo survey (what this fork started from)
METHODOLOGY.md        the method: linear algebra -> AI, tiered by what's real
REPRODUCE.md          this file
requirements.txt      loose dependency list
requirements-lock.txt pinned, tested versions (use this to review)
verify_notebooks.sh   one-command execute-all + PASS/FAIL report
Intro.ipynb,
lecture_2..10_*.ipynb original course (Lectures 5 & 10 use legacy Qiskit)
lecture_11..18_*.ipynb the extended "linear algebra -> AI" system
```
