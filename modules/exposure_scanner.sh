#!/bin/bash
echo "🗂️ Static Asset Exposure Scanner"

mkdir -p asset_results

if [[ ! -f exposure_targets.txt ]]; then
  echo "Missing exposure_targets.txt. Add base URLs (e.g. https://example.com/)."
  exit 1
fi

# Default sensitive paths
wordlist=(".env" ".git/config" ".gitignore" "backup.zip" "db.sql" "credentials.json" "wp-config.php" ".htaccess" "config.js" "debug.log")

for url in $(cat exposure_targets.txt); do
  echo "[*] Scanning: $url"
  for path in "${wordlist[@]}"; do
    full_url="${url}${path}"
    status=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")
    if [[ "$status" == "200" ]]; then
      echo "[+] Exposed: $full_url" | tee -a asset_results/vulnerable.txt
    fi
  done
done

echo "Scan complete. Check 'asset_results/'"
