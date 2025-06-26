#!/bin/bash
# modules_csti_scanner.sh - Detect Client-Side Template Injection (CSTI)
echo "[*] Running CSTI Scanner..."
INPUT=${1:-targets.txt}
PAYLOADS=('{{7*7}}' '${{7*7}}' '<%= 7*7 %>' '{{=7*7}}')

for url in $(cat "$INPUT"); do
  for payload in "${PAYLOADS[@]}"; do
    response=$(curl -sk --max-time 10 "$url?input=$payload")
    if echo "$response" | grep -q '49'; then
      echo "[+] CSTI Detected: $url -> Payload: $payload"
      echo "$url,$payload" >> csti_results.csv
    fi
  done
done
echo "[*] CSTI scan complete. Results saved to csti_results.csv"
