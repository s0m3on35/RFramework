#!/bin/bash
echo " CORS Misconfiguration Tester"

mkdir -p cors_results

if [[ ! -f cors_targets.txt ]]; then
  echo "Missing cors_targets.txt. Provide targets (http/https URLs)."
  exit 1
fi

ORIGIN="https://evil.com"

for url in $(cat cors_targets.txt); do
  echo "[*] Testing: $url"
  response=$(curl -s -D - -o /dev/null -H "Origin: $ORIGIN" "$url")
  allowed_origin=$(echo "$response" | grep -i "access-control-allow-origin")

  if [[ "$allowed_origin" == *"$ORIGIN"* || "$allowed_origin" == *"*"* ]]; then
    echo "[!] Possible CORS misconfiguration on $url" >> cors_results/vulnerable.txt
    echo "$response" >> cors_results/$(echo $url | md5sum | cut -d' ' -f1).txt
  fi
done

echo "CORS tests completed. Check 'cors_results/' for potential issues."
