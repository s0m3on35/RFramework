#!/bin/bash

set -e
echo "[*] Step 2: Directory and Endpoint Fuzzing"

WORKDIR="results/step2_$(date +%Y-%m-%d_%H%M%S)"
mkdir -p "$WORKDIR"

# Define wordlists
WORDLIST="/usr/share/seclists/Discovery/Web-Content/common.txt"
CUSTOM_WORDLIST="./custom_wordlist.txt"

# Check for targets file
if [ ! -f "targets.txt" ]; then
    echo "[✗] targets.txt not found. Run Step 1 first." >&2
    exit 1
fi

# Run ffuf for each target in targets.txt
echo "[*] Running ffuf..."
while read -r URL; do
    HOSTNAME=$(echo "$URL" | awk -F/ '{print $3}')
    ffuf -u "$URL/FUZZ" -w "$WORDLIST" -mc all -t 50 -o "$WORKDIR/${HOSTNAME}_ffuf.json" -of json || true
done < targets.txt

# Optional: Custom wordlist scan
if [ -f "$CUSTOM_WORDLIST" ]; then
    echo "[*] Running optional fuzz with custom wordlist..."
    while read -r URL; do
        HOSTNAME=$(echo "$URL" | awk -F/ '{print $3}')
        ffuf -u "$URL/FUZZ" -w "$CUSTOM_WORDLIST" -mc all -t 50 -o "$WORKDIR/${HOSTNAME}_custom_ffuf.json" -of json || true
    done < targets.txt
fi

echo "[✓] Step 2 completed. Output saved in $WORKDIR"
