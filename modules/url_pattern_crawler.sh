#!/bin/bash
echo " URL Pattern Crawler"

mkdir -p pattern_results

if [[ ! -f urls_collected.txt ]]; then
  echo "Missing 'urls_collected.txt'. Please provide a list of URLs to analyze."
  exit 1
fi

grep -Eo 'https?://[^ ]+' urls_collected.txt | sort -u > pattern_results/clean_urls.txt

echo "[*] Extracting patterns..."

cat pattern_results/clean_urls.txt | grep -E '\?.*=.*' > pattern_results/parameterized_urls.txt
cat pattern_results/clean_urls.txt | grep -E '/[0-9]{2,}/' > pattern_results/numeric_paths.txt
cat pattern_results/clean_urls.txt | grep -E '[a-f0-9]{32,}' > pattern_results/hash_like.txt

echo "[+] Parameterized URLs:   $(wc -l < pattern_results/parameterized_urls.txt)"
echo "[+] Numeric path URLs:    $(wc -l < pattern_results/numeric_paths.txt)"
echo "[+] Hash-like patterns:   $(wc -l < pattern_results/hash_like.txt)"

echo "Done. Results saved in pattern_results/"
