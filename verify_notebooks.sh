#!/usr/bin/env bash
# verify_notebooks.sh — one-command reproducibility check.
#
# Executes every self-contained notebook in the "linear algebra -> AI" system
# headless, from a clean checkout, and reports PASS/FAIL per notebook.
# A reviewer can run this on a new workstation to confirm the repo's claims.
#
#   bash verify_notebooks.sh
#
# Requirements: pip install -r requirements-lock.txt   (Python 3.11)
# First run downloads a ~90 MB sentence-embedding model from Hugging Face,
# so network access is needed once.
#
# Lecture 14 (Claude API) is intentionally NOT executed here: it needs an
# ANTHROPIC_API_KEY and makes paid network calls. It is written to run cleanly
# without a key (it prints notices), so it is safe to open, just not part of
# the automated check.

set -u
cd "$(dirname "$0")"

# Self-contained, deterministic-ish notebooks with embedded outputs.
NOTEBOOKS=(
  "lecture_11_quantum_ml_training.ipynb"
  "lecture_12_inner_products_to_embeddings.ipynb"
  "lecture_13_evaluating_outputs_embedding_space.ipynb"
  "lecture_15_quantum_text_classification.ipynb"
  "lecture_16_eigenvalues_and_svd.ipynb"
  "lecture_17_attention_is_inner_products.ipynb"
  "lecture_18_projection_universal_readout.ipynb"
)

OUT=".verify_out"
mkdir -p "$OUT"
pass=0; fail=0; failed=()

echo "Executing ${#NOTEBOOKS[@]} notebooks (this can take several minutes)..."
echo

for nb in "${NOTEBOOKS[@]}"; do
  if [ ! -f "$nb" ]; then
    echo "MISSING  $nb"; fail=$((fail+1)); failed+=("$nb"); continue
  fi
  printf 'RUN   %-52s ' "$nb"
  if jupyter nbconvert --to notebook --execute \
        --ExecutePreprocessor.timeout=600 \
        --output-dir "$OUT" --output "$nb" "$nb" >"$OUT/${nb}.log" 2>&1; then
    echo "PASS"; pass=$((pass+1))
  else
    echo "FAIL  (see $OUT/${nb}.log)"; fail=$((fail+1)); failed+=("$nb")
  fi
done

echo
echo "-----------------------------------------"
echo "PASS: $pass    FAIL: $fail"
if [ "$fail" -ne 0 ]; then
  printf 'Failed: %s\n' "${failed[*]}"
  exit 1
fi
echo "All notebooks executed cleanly."
