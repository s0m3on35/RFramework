#!/bin/bash

set -e
echo "[*] Step 4: Secrets Detection in URLs, JS, and responses"

WORKDIR="results/step4_$(date +%Y-%m-%d_%H%M%S)"
mkdir -p "$WORKDIR"

# Input validation
if [ ! -f "targets.txt" ]; then
    echo "[✗] targets.txt not found. Run Step 1 first." >&2
    exit 1
fi

# Secret detection using nuclei + custom AI prompts
echo "[*] Running nuclei AI prompts for secrets detection..."
NUCLEI_SECRET_PROMPTS="secrets_ai_prompts.txt"

if [ ! -f "$NUCLEI_SECRET_PROMPTS" ]; then
    echo "[✗] Missing file: secrets_ai_prompts.txt" >&2
    exit 1
fi

i=0
while read -r prompt; do
    ((i=i+1))
    safe_name=$(echo "$prompt" | tr ' /()' '_' | cut -c1-80)
    echo "[*] Prompt $i: $prompt"
    nuclei -list targets.txt -ai "$prompt" -json -o "$WORKDIR/secrets_$i.json" || true
done < "$NUCLEI_SECRET_PROMPTS"

# Trufflehog (optional, local file scan)
if command -v trufflehog &> /dev/null; then
    echo "[*] Optional: Scanning downloaded JS files (if available)..."
    mkdir -p "$WORKDIR/truffle"
    trufflehog filesystem . --json --exclude-paths .git,node_modules --directory ./ --output "$WORKDIR/truffle/trufflehog_secrets.json" || true
fi

echo "[✓] Step 4 completed. Output saved in $WORKDIR"
