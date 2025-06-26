#!/bin/bash
echo "🧪 Login Interface Fingerprinter"

mkdir -p login_fingerprint_results

input_file="urls_collected.txt"
if [[ ! -f "$input_file" ]]; then
  echo "Missing '$input_file'. Please provide URLs to scan."
  exit 1
fi

echo "[*] Searching for login forms and input fields..."

while read -r url; do
  echo "Testing: $url" >> login_fingerprint_results/raw_output.txt
  curl -s "$url" | grep -iE "login|username|password|email|auth|csrf" >> login_fingerprint_results/raw_output.txt
  echo "---" >> login_fingerprint_results/raw_output.txt
done < "$input_file"

echo "[+] Results written to login_fingerprint_results/raw_output.txt"
