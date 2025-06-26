#!/bin/bash
echo "📋 HTML Form Extractor & Mapper"
mkdir -p form_mapper
input="urls_collected.txt"
if [[ ! -f "$input" ]]; then echo "Missing $input"; exit 1; fi

> form_mapper/form_results.txt
while read -r url; do
  echo "🔎 Scanning: $url" >> form_mapper/form_results.txt
  curl -s "$url" | pup 'form json{}' >> form_mapper/form_results.txt
  echo "---" >> form_mapper/form_results.txt
done < "$input"

echo "[+] Form mapping complete. Output: form_mapper/form_results.txt"
