#!/bin/bash
echo "🔐 Session Token Exposure Scanner"

mkdir -p token_results

input_file="urls_collected.txt"
if [[ ! -f "$input_file" ]]; then
  echo "Missing '$input_file'. Please provide URLs to scan."
  exit 1
fi

echo "[*] Scanning for session tokens and JWTs..."

grep -Eo '([a-zA-Z0-9\-_]{20,}\.[a-zA-Z0-9\-_]{20,}\.[a-zA-Z0-9\-_]{20,})' "$input_file" > token_results/jwt_candidates.txt
grep -Eo '(access_token|sessionid|auth_token)=[^& ]+' "$input_file" > token_results/url_tokens.txt

echo "[+] Possible JWTs found:      $(wc -l < token_results/jwt_candidates.txt)"
echo "[+] URL-based tokens found:   $(wc -l < token_results/url_tokens.txt)"

cat token_results/jwt_candidates.txt token_results/url_tokens.txt > token_results/all_token_matches.txt

echo "Done. Results saved in token_results/"
