#!/bin/bash
echo "🧬 JS Analyzer for Hardcoded Keys"
mkdir -p js_secrets

input_dir="js_links"
if [[ ! -d "$input_dir" ]]; then
  echo "Missing 'js_links/' directory with JavaScript files"
  exit 1
fi

> js_secrets/results.txt
for jsfile in "$input_dir"/*.js; do
  echo "Scanning: $jsfile" >> js_secrets/results.txt
  grep -Eo '(api[_-]?key|token|secret|client[_-]?id|access[_-]?key)["'"]?[:=]["'"]?[A-Za-z0-9_\-]{10,}' "$jsfile" >> js_secrets/results.txt
  echo "---" >> js_secrets/results.txt
done

echo "[+] Analysis complete. Output in js_secrets/"
