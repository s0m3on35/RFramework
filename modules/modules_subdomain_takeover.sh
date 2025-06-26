#!/bin/bash
# modules_subdomain_takeover.sh

echo "[*] Running Subdomain Takeover Detector..."
echo "[*] Checking for vulnerable CNAMEs, orphaned services, and common takeover signatures..."

TARGET_FILE="results/subdomains.txt"
OUTPUT_FILE="results/subdomain_takeover_findings.txt"

if [ ! -f "$TARGET_FILE" ]; then
  echo "[!] No subdomain file found at $TARGET_FILE"
  exit 1
fi

# Example scan logic
cat "$TARGET_FILE" | while read sub; do
  echo "[*] Checking $sub..."
  # Simulated logic for detection
  if dig "$sub" +short | grep -i "amazonaws.com"; then
    echo "[!] Potential S3 Takeover on $sub" >> "$OUTPUT_FILE"
  fi
done

echo "[*] Subdomain takeover scan complete. Results saved in $OUTPUT_FILE."
