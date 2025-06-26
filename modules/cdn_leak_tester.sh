#!/bin/bash
echo "🌐 CDN Leak Tester"

mkdir -p cdn_results

input_file="urls_collected.txt"
if [[ ! -f "$input_file" ]]; then
  echo "Missing '$input_file'. Please provide URLs to scan."
  exit 1
fi

echo "[*] Checking CDN headers and caching indicators..."

while read -r url; do
  echo "Testing: $url" >> cdn_results/headers.txt
  curl -s -I "$url" | grep -iE "via:|x-cache:|cf-cache-status:|cache-control:|pragma:" >> cdn_results/headers.txt
  echo "---" >> cdn_results/headers.txt
done < "$input_file"

echo "[+] Results written to cdn_results/headers.txt"
