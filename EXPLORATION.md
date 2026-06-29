# Repository Exploration

_A quick map of what this repository is and what it offers, written while exploring the fork._

## What this repo is

**Linear Algebra for Quantum Computing** is an open educational course — a set of
10 self-contained Jupyter notebooks that build up the math and Python needed to
start working with quantum computing, starting from scratch. It is published by
"The Singularity Research" and follows the linear-algebra-first approach of the
standard textbook, Nielsen & Chuang's *Quantum Computation and Quantum
Information*.

It is **course material, not a software library** — there is no installable
package, no `setup.py`, and no test suite. The deliverable is the notebooks
themselves, meant to be read top-to-bottom and run interactively.

## How it's delivered

- **Jupyter notebooks** intended to be run cell-by-cell. Each lecture mixes
  markdown explanation with runnable Python.
- **Binder** integration — every lecture in the README has a "launch binder"
  badge so it can be opened as a live, zero-install notebook in the browser.
- **GitHub Pages** — `_config.yml` sets the Jekyll Cayman theme, so the repo can
  render as a simple project site.
- Dependencies (`requirements.txt`): `numpy` and `qiskit`. (See the note below —
  this is incomplete.)

## The lectures

| # | Notebook | Topic | Key tools |
|---|----------|-------|-----------|
| 1 | `Intro.ipynb` | What is quantum computing; Jupyter/QISKit/PennyLane setup | jupyter, pip |
| 2 | `lecture_2_complex_numbers.ipynb` | Complex numbers in Python | numpy |
| 3 | `lecture_3_vectors.ipynb` | Vectors | numpy |
| 4 | `lecture_4_inner_products.ipynb` | Inner products & unit vectors | numpy |
| 5 | `lecture_5_bloch_sphere.ipynb` | Bloch sphere; representing qubits | qiskit, numpy |
| 6 | `lecture_6_tensor_products.ipynb` | Tensor products of vectors | numpy |
| 7 | `lecture_7_preparing_basis_states.ipynb` | Preparing basis states | pennylane |
| 8 | `lecture_8_matrices.ipynb` | Matrices | numpy |
| 9 | `lecture_9_tensor_product_matrices.ipynb` | Tensor products of matrices | numpy |
| 10 | `lecture_10_quantum_gates.ipynb` | Quantum logic gates as matrices | qiskit, numpy |

The arc is deliberate: classical math foundations (complex numbers → vectors →
inner products → matrices → tensor products) build toward the quantum payoff
(Bloch sphere, basis-state preparation, quantum gates).

## What it can do for us

- **Onboarding / upskilling.** A structured, beginner-friendly path into quantum
  computing fundamentals for anyone on the team with no prior physics background.
- **Reference material.** Worked Python examples of core linear-algebra
  operations (NumPy) and intro quantum programming (Qiskit, PennyLane).
- **A base to extend.** Because it's notebooks rather than a locked-down library,
  it's easy to fork, add lectures/exercises, fix the environment, or adapt the
  examples to our own use cases.

## Observations & potential improvements

These stood out while exploring — candidates if we decide to invest in the fork:

1. **`requirements.txt` is incomplete.** It lists only `numpy` and `qiskit`, but
   Lecture 7 imports `pennylane` (and the Intro `pip install`s it). Binder builds
   that try to run Lecture 7 would fail. Adding `pennylane` (and `matplotlib`,
   used implicitly by the Bloch-sphere plots) would make the environment
   reproducible.
2. **No version pinning.** The notebooks were authored against Qiskit ~0.18 /
   Python 3.7. Qiskit's API has changed substantially since (e.g. the
   `from qiskit import *` style and `qiskit.visualization` imports). Notebooks may
   need updating to run on current releases.
3. **No license file.** The repo has funding/sponsorship info but no `LICENSE`,
   which leaves reuse terms ambiguous.
4. **No automated checks.** A CI job that executes the notebooks (e.g. via
   `nbconvert`/`papermill`) would catch the environment drift above automatically.

## How to run locally

```bash
pip install -r requirements.txt   # plus: pip install pennylane matplotlib
jupyter lab                       # then open any lecture_*.ipynb
```

Or click any "launch binder" badge in the README to run in-browser with no setup.
