#!/bin/bash

set -e
echo "[*] Step 3: AI-assisted Vulnerability Scanning with Nuclei"

WORKDIR="results/step3_$(date +%Y-%m-%d_%H%M%S)"
mkdir -p "$WORKDIR"

# Validate targets
if [ ! -f "targets.txt" ]; then
    echo "[✗] targets.txt not found. Run Step 1 first." >&2
    exit 1
fi

# AI prompts list
PROMPTS_FILE="nuclei_ai_prompts.txt"
if [ ! -f "$PROMPTS_FILE" ]; then
    echo "[✗] Missing file: nuclei_ai_prompts.txt" >&2
    exit 1
fi

# Execute each AI prompt
i=0
while read -r prompt; do
    ((i=i+1))
    safe_name=$(echo "$prompt" | tr ' /()' '_' | cut -c1-80)
    echo "[*] Running prompt #$i: $prompt"
    nuclei -list targets.txt -ai "$prompt" -json -o "$WORKDIR/nuclei_ai_$i.json" || true
    echo "[✓] Saved: $WORKDIR/nuclei_ai_$i.json"
done < "$PROMPTS_FILE"

echo "[✓] Step 3 completed. All results in $WORKDIR"
