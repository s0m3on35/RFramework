#!/bin/bash
echo "🧭 Open Redirect Mapper"

mkdir -p open_redirect_results

if [[ ! -f redirect_targets.txt ]]; then
  echo "Missing redirect_targets.txt. Add URLs with parameters (e.g., ?url=) to test."
  exit 1
fi

payload="https://evil.com"

for url in $(cat redirect_targets.txt); do
  test_url="${url}${payload}"
  echo "[*] Testing: $test_url"
  location=$(curl -s -L -o /dev/null -w "%{redirect_url}" "$test_url")

  if [[ "$location" == *"evil.com"* ]]; then
    echo "[!] Vulnerable: $url" | tee -a open_redirect_results/vulnerable.txt
  fi
done

echo "Open redirect mapping completed. Check 'open_redirect_results/'."
