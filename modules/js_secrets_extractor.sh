#!/bin/bash
echo "📑 JavaScript Secrets Extractor"

mkdir -p js_secrets_results

if [[ ! -f js_links.txt ]]; then
  echo "Missing js_links.txt. Provide direct links to .js files (one per line)."
  exit 1
fi

regexes=(
  "AKIA[0-9A-Z]{16}"                          # AWS Access Key ID
  "AIza[0-9A-Za-z\-_]{35}"                   # Google API Key
  "sk_live_[0-9a-zA-Z]{24}"                   # Stripe Live Secret Key
  "eyJ[A-Za-z0-9-_]{10,}\.[A-Za-z0-9-_]{10,}" # JWT
  "[a-zA-Z0-9_]{32,45}"                       # Generic API Key
  "secret(.{0,20})['\"][0-9a-zA-Z]{16,}"     # Secret = "...."
)

while read -r url; do
  echo "[*] Downloading: $url"
  filename=$(echo "$url" | md5sum | cut -d' ' -f1).js
  curl -s "$url" -o "js_secrets_results/$filename"

  for regex in "${regexes[@]}"; do
    grep -Eo "$regex" "js_secrets_results/$filename" >> js_secrets_results/found_secrets.txt
  done
done < js_links.txt

echo "Done. Check js_secrets_results/found_secrets.txt"
